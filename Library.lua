--!nocheck
--[[
    Vitality — 1:1 Roblox port of the apremake Dear ImGui menu.

    Every metric, colour and widget geometry below is transcribed from:
        src/ui/theme.cpp, theme.h      palette, derived colours, style
        src/ui/draw.cpp,  draw.h       draw-list primitives
        src/ui/menu.cpp                window chrome / tabs / panels
        src/ui/widgets.cpp             checkbox, slider, combo, keybind, swatch
        src/ui/picker.cpp              colour picker
        src/ui/notify.cpp              notifications
        src/ui/overlay.cpp             top bar, watermark, keybinds, target hud
        src/ui/tools.cpp               playerlist, waypoints, colors, dex, config, perf
        src/ui/anim.cpp                exponential approach

    One ImGui pixel == one Roblox pixel. Offsets only, never scale.
--]]

do
    if getgenv and getgenv().Library and getgenv().Library.Exit then
        pcall(function()
            getgenv().Library:Exit()
        end)
    end

    cloneref = cloneref or function(Object)
        return Object
    end

    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local TextService = game:GetService("TextService")
    local HttpService = game:GetService("HttpService")
    local GuiService = game:GetService("GuiService")
    local CoreGui = cloneref(game:GetService("CoreGui"))

    gethui = gethui or function()
        return CoreGui
    end

    local LocalPlayer = Players.LocalPlayer

    while not LocalPlayer do
        task.wait()
        LocalPlayer = Players.LocalPlayer
    end

    local GuiInset = GuiService:GetGuiInset().Y or 36
    local Camera = workspace.CurrentCamera

    -- =====================================================================
    -- library skeleton
    -- =====================================================================

    local Library = {
        Flags = {},
        SetFlags = {},
        Connections = {},
        Threads = {},
        Updates = {},
        Layers = {},
        Windows = {},

        MenuKeybind = "Insert",
        Directory = "Vitality",
        Folders = {
            Assets = "/Assets",
            Configs = "/Configs",
            Themes = "/Themes",
        },

        FontSize = 10,
        -- Direct TTF sources (writefile -> getcustomasset -> Font.new).
        -- Verdana Bold 700 ships in Alpine/fonts/Verdana-Bold.ttf. Primary host
        -- is i77lhm/storage (same repo as the other faces); the public corefonts
        -- mirror is only a fallback until the file is uploaded there.
        -- Each entry may be a string or a list of URLs tried in order.
        FontSources = {
            Regular = "https://raw.githubusercontent.com/i77lhm/storage/main/fonts/Verdana-Font.ttf",
            Bold = {
                "https://raw.githubusercontent.com/i77lhm/storage/main/fonts/Verdana-Bold.ttf",
                "https://raw.githubusercontent.com/wolfsonliu/web_typography/master/fonts/verdanab.ttf",
            },
            Bar = "https://raw.githubusercontent.com/i77lhm/storage/main/fonts/Tahoma-Modern.ttf",
        },
        Font = nil,
        FontLoaded = {},
        BoldFont = nil,
        BarFont = nil,

        NotificationsEnabled = true,
        NotificationDuration = 5,
        AnimationRate = 60,
        FadeLimit = 90,

        DragClaimed = false,
        ThemeDirty = false,
        ThemeTimer = 0,
        Scrollbars = {},
        TooltipWatchers = {},
        AccentShines = {},
        Tooltips = {},
        OpenFrames = {},
        StartTime = os.clock(),
    }

    Library.__index = Library

    getgenv().Library = Library

    local function Create(Class, Properties)
        local Object = Instance.new(Class)

        for Key, Value in Properties or {} do
            if Key == "Parent" then
                Object.Parent = Value
            elseif Key == "FontFace" then
                Object.FontFace = Library.Font
            elseif Key == "TextSize" then
                Object.TextSize = Library.FontSize
            else
                Object[Key] = Value
            end
        end

        return setmetatable({
            Class = Class,
            Instance = Object,
            Properties = Properties or {},
        }, Library)
    end

    Library.Create = Create

    local function Connect(Signal, Callback)
        local Connection = Signal:Connect(Callback)
        table.insert(Library.Connections, Connection)
        return Connection
    end

    Library.Connect = Connect

    function Library:AddUpdate(Function)
        table.insert(Library.Updates, Function)
        return Function
    end

    function Library:RemoveUpdate(Function)
        local Index = table.find(Library.Updates, Function)

        if Index then
            table.remove(Library.Updates, Index)
        end
    end

    function Library:MousePoint()
        return UserInputService:GetMouseLocation()
    end

    Library.HolderPoint = function(_, Point)
        return Point
    end

    function Library:IsMouseOverFrame(Object)
        local Target = Object.Instance or Object
        local Point = self:MousePoint()

        return Point.X >= Target.AbsolutePosition.X
            and Point.X <= Target.AbsolutePosition.X + Target.AbsoluteSize.X
            and Point.Y >= Target.AbsolutePosition.Y
            and Point.Y <= Target.AbsolutePosition.Y + Target.AbsoluteSize.Y
    end

    function Library:Round(Number, Float)
        if not Float or Float <= 0 then
            return math.floor(Number + 0.5)
        end

        local Multiplier = 1 / Float
        return math.floor(Number * Multiplier + 0.5) / Multiplier
    end

    -- =====================================================================
    -- palette (theme.cpp)
    -- =====================================================================

    local PALETTE_KEYS = {
        "Accent", "Shine", "Outline", "Text Outline", "Border", "Background",
        "Bg Top", "Bg Bot", "Child Fill", "Child Top", "Child Bot", "Grab",
        "Text", "Text Dim", "Grad Top", "Grad Bot",
    }

    local function RGB(r, g, b)
        return Color3.fromRGB(r, g, b)
    end

    local function Pack(Value)
        return RGB(bit32.extract(Value, 16, 8), bit32.extract(Value, 8, 8), bit32.extract(Value, 0, 8))
    end

    local function Channels(Color)
        return math.floor(Color.R * 255 + 0.5), math.floor(Color.G * 255 + 0.5), math.floor(Color.B * 255 + 0.5)
    end

    local function Scale(Color, Factor)
        local r, g, b = Channels(Color)
        return RGB(
            math.clamp(math.floor(r * Factor + 0.5), 0, 255),
            math.clamp(math.floor(g * Factor + 0.5), 0, 255),
            math.clamp(math.floor(b * Factor + 0.5), 0, 255)
        )
    end

    local function Mix(From, To, T)
        local ar, ag, ab = Channels(From)
        local br, bg, bb = Channels(To)

        return RGB(
            math.clamp(math.floor(ar + (br - ar) * T + 0.5), 0, 255),
            math.clamp(math.floor(ag + (bg - ag) * T + 0.5), 0, 255),
            math.clamp(math.floor(ab + (bb - ab) * T + 0.5), 0, 255)
        )
    end

    local function LerpColor(From, To, T)
        return Mix(From, To, T)
    end

    -- default_colors + tinted() from theme.cpp, packed as 0xRRGGBB
    local DEFAULT_COLORS = {
        0x3B353D, 0xD6D3DA, 0x000000, 0x000000,
        0x1F2120, 0x101010, 0x1A1B1D, 0x101211,
        0x0D100F, 0x1B1E1D, 0x131515, 0x423348,
        0xF6F8F8, 0x868887, 0x423348, 0x322A34,
    }

    local PRESET_NAMES = {
        "Default", "Sakura", "Midnight", "Emerald", "Amber", "Violet", "Crimson",
        "Cyan", "Rose Gold", "Monochrome", "Ocean", "Sunset", "Neon Green",
        "Magenta", "Teal", "Blood", "Ice", "Toxic", "Gold", "Lavender", "Obsidian",
    }

    -- { accent, shine, grad_top, grad_bottom } — all other slots are default_colors
    local PRESET_TINTS = {
        { 0x965670, 0xFFDCE8, 0xE88CB0, 0xB06082 },
        { 0x343A6E, 0xD2D8FA, 0x505AAA, 0x343C78 },
        { 0x28825A, 0xD2F5E4, 0x2EA06E, 0x1E6E4C },
        { 0xB0701E, 0xFFE8BE, 0xE69628, 0xAA6818 },
        { 0x6E3CA0, 0xE8D6FA, 0x8C50D2, 0x603496 },
        { 0x961E32, 0xFACED6, 0xBE2840, 0x821A2C },
        { 0x288CA0, 0xD2F6FC, 0x32B4CD, 0x207C90 },
        { 0xAA6E64, 0xFCE4DC, 0xD29282, 0xA0685C },
        { 0x6E6E6E, 0xF0F0F0, 0x969696, 0x646464 },
        { 0x1E5A8C, 0xCCE4FA, 0x2878BE, 0x1A5488 },
        { 0xB45032, 0xFFDCC4, 0xEC6E3C, 0xB04628 },
        { 0x3CB428, 0xDCFFD2, 0x50F032, 0x32AA1E },
        { 0xAA288C, 0xFAD2F0, 0xDC32B4, 0x961E7C },
        { 0x1E8278, 0xCCF4EE, 0x28A698, 0x1A726A },
        { 0x781014, 0xF0BEBE, 0x96141A, 0x600C10 },
        { 0x82AAC8, 0xF0FAFF, 0xAAD6F0, 0x78A4C4 },
        { 0x82AA1E, 0xECFAC8, 0xAADC28, 0x769C18 },
        { 0xAA8C3A, 0xFAECC4, 0xD6AC30, 0x96741E },
        { 0x8C78BE, 0xF0E8FC, 0xB096E6, 0x7E6AB0 },
        { 0x282430, 0x968CA0, 0x363040, 0x221E28 },
    }

    local Presets = {}

    local function BuildPalette(Data)
        local Palette = {}

        for Index, Name in PALETTE_KEYS do
            Palette[Name] = Pack(Data[Index])
        end

        Palette["Menu Glow"] = 0.5
        Palette["Bg Dim"] = 0.0

        return Palette
    end

    Presets.Default = BuildPalette(DEFAULT_COLORS)

    for Index, Name in PRESET_NAMES do
        if Index > 1 then
            local Tint = PRESET_TINTS[Index - 1]
            local Data = table.clone(DEFAULT_COLORS)

            Data[1] = Tint[1]
            Data[2] = Tint[2]
            Data[12] = Tint[3]
            Data[15] = Tint[3]
            Data[16] = Tint[4]

            Presets[Name] = BuildPalette(Data)
        end
    end

    Library.Presets = Presets
    Library.PresetOrder = table.clone(PRESET_NAMES)
    Library.CurrentTheme = "Default"
    Library.Theme = table.clone(Presets.Default)

    -- theme::palette — current values
    local P = Library.Theme

    -- theme::color — derived values, recomputed by ThemeApply()
    local C = {}

    local function ThemeApply()
        local accent = P["Accent"]
        local shine = P["Shine"]
        local border = P["Border"]
        local background = P["Background"]
        local bgTop = P["Bg Top"]
        local bgBottom = P["Bg Bot"]
        local childTop = P["Child Top"]
        local childBottom = P["Child Bot"]
        local text = P["Text"]
        local textDim = P["Text Dim"]
        local gradTop = P["Grad Top"]
        local gradBottom = P["Grad Bot"]

        C.black = P["Outline"]
        C.text_outline = P["Text Outline"]

        C.accent_top = accent
        C.accent_bottom = Scale(accent, 0.82)
        C.accent_top_glow = shine
        C.accent_bottom_glow = Scale(shine, 0.96)

        C.window_edge = Scale(accent, 1.19)
        C.edge_glow = Scale(accent, 2.17)
        C.glow = Scale(accent, 0.7)
        C.text_active = Scale(accent, 2.0)

        C.header_border_top = Scale(accent, 0.66)
        C.header_border_glow = Mix(C.header_border_top, shine, 0.09)
        C.header_fill_top = Scale(accent, 0.48)
        C.header_fill_glow = Scale(accent, 0.73)
        C.header_grad_top = bgTop
        C.header_grad_bottom = bgBottom

        C.tab_accent_top = Scale(accent, 0.95)
        C.tab_accent_bottom = Scale(accent, 0.87)
        C.tab_accent_glow_top = shine
        C.tab_accent_glow_bottom = Scale(shine, 0.95)
        C.tab_fill_top = Scale(bgBottom, 1.05)
        C.tab_fill_bottom = Scale(bgBottom, 0.94)

        C.top_bar_top = Mix(bgBottom, bgTop, 0.5)
        C.top_bar_bottom = Scale(bgBottom, 0.94)

        C.content_fill = background
        C.backdrop_fill = Scale(background, 0.94)
        C.window_band = Mix(background, accent, 0.14)
        C.overlay_band = Mix(Scale(background, 0.85), accent, 0.12)

        C.frame_light = border
        C.panel_light = Scale(border, 1.03)

        C.panel_fill = P["Child Fill"]
        C.panel_fill_glow = Scale(accent, 0.66)
        C.panel_border_top = Scale(accent, 0.72)
        C.panel_border_glow = Mix(C.panel_border_top, shine, 0.06)

        C.input_top = childTop
        C.input_bottom = childBottom
        C.input_hover_top = Scale(childTop, 1.22)
        C.input_hover_bottom = Scale(childBottom, 1.2)
        C.track_top = childTop
        C.track_bottom = Scale(childBottom, 0.85)
        C.checkbox_top = Scale(childTop, 0.88)
        C.checkbox_bottom = Scale(childBottom, 0.8)
        C.checked_top = RGB(56, 57, 61)
        C.checked_bottom = RGB(43, 44, 48)
        C.frame_fill = childBottom

        C.fill_top = gradTop
        C.fill_bottom = gradBottom
        C.grab = P["Grab"]

        C.health_top = Scale(gradTop, 1.1)
        C.health_bottom = Scale(gradBottom, 1.05)
        C.health_accent = Scale(gradTop, 1.09)
        C.health_accent_glow = shine
        C.health_shade = Scale(gradTop, 0.94)
        C.health_shade_glow = Mix(C.health_shade, shine, 0.3)
        C.health_light = Scale(gradBottom, 0.72)

        C.text = text
        C.arrow = text
        C.text_title = Scale(text, 0.835)
        C.text_target = RGB(104, 116, 142)
        C.text_message = Scale(text, 0.81)
        C.text_dim = textDim
        C.text_separator = Scale(textDim, 0.45)
        C.text_tab_selected = Mix(Scale(textDim, 0.5), accent, 0.3)

        C.checker_light = RGB(170, 170, 170)
        C.checker_dark = RGB(136, 136, 136)
        C.picker_check_light = RGB(140, 140, 140)
        C.picker_check_dark = RGB(92, 92, 92)
        C.marker = RGB(255, 255, 255)
        C.health_light = C.health_light
    end

    ThemeApply()

    Library.Colors = C
    Library.ApplyTheme = ThemeApply

    -- =====================================================================
    -- fonts
    -- =====================================================================

    local function SafeGlobal(Name)
        local Ok, Value = pcall(function()
            if _G then
                return _G[Name]
            end
        end)

        if Ok and Value ~= nil then
            return Value
        end

        Ok, Value = pcall(function()
            if getgenv then
                return getgenv()[Name]
            end
        end)

        if Ok then
            return Value
        end
    end

    local function ValidFontBody(Body)
        if type(Body) ~= "string" or #Body < 2048 then
            return false
        end

        local B0, B1, B2, B3 = string.byte(Body, 1, 4)

        -- TrueType 1.0, OpenType CFF ("OTTO"), Apple ("true"), collection ("ttcf")
        return (B0 == 0 and B1 == 1 and B2 == 0 and B3 == 0)
            or (B0 == 79 and B1 == 84 and B2 == 84 and B3 == 79)
            or (B0 == 116 and B1 == 114 and B2 == 117 and B3 == 101)
            or (B0 == 116 and B1 == 116 and B2 == 99 and B3 == 102)
    end

    local function LoadFace(Name, Weight, Style, Url)
        if not Url or Url == "" then
            return nil
        end

        local Urls = type(Url) == "table" and Url or { Url }
        local Directory = Library.Directory .. Library.Folders.Assets

        for _, Link in Urls do
            local Ok, Result = pcall(function()
                local Write = SafeGlobal("writefile")
                local IsFile = SafeGlobal("isfile")
                local Asset = SafeGlobal("getcustomasset")

                if not Write or not IsFile or not Asset then
                    return nil
                end

                local MakeFolder = SafeGlobal("makefolder")
                local IsFolder = SafeGlobal("isfolder")

                if MakeFolder and IsFolder then
                    if not IsFolder(Library.Directory) then
                        MakeFolder(Library.Directory)
                    end

                    if not IsFolder(Directory) then
                        MakeFolder(Directory)
                    end
                end

                if not IsFile(Name) then
                    local Body = game:HttpGet(Link)

                    if not ValidFontBody(Body) then
                        return nil
                    end

                    Write(Name, Body)
                end

                local Data = {
                    name = Name,
                    faces = {
                        {
                            name = Name,
                            weight = Weight,
                            style = Style,
                            assetId = Asset(Name),
                        },
                    },
                }

                local Path = Directory .. "/" .. Name .. ".font"
                Write(Path, HttpService:JSONEncode(Data))

                local Face = Font.new(Asset(Path))
                Library.FontLoaded[Name] = true

                return Face
            end)

            if Ok and Result then
                return Result
            end
        end
    end

    Library.Font = LoadFace("Verdana-Regular", 400, "Normal", Library.FontSources.Regular)
        or Font.fromEnum(Enum.Font.Arial)

    Library.BoldFont = LoadFace("Verdana-Bold-700", 700, "Normal", Library.FontSources.Bold)
        or Font.fromEnum(Enum.Font.ArialBold)

    Library.BarFont = LoadFace("Tahoma-Regular", 400, "Normal", Library.FontSources.Bar)
        or Font.fromEnum(Enum.Font.Arial)

    -- font::ascent — tmAscent of Verdana@10 / Tahoma@11
    local FONTS = {
        reg = { face = Library.Font, size = 10, cell = 10, ascent = 9 },
        bold = { face = Library.BoldFont, size = 10, cell = 10, ascent = 9 },
        bar = { face = Library.BarFont, size = 11, cell = 11, ascent = 10 },
    }

    -- =====================================================================
    -- holder
    -- =====================================================================

    local Holder = Instance.new("ScreenGui")
    Holder.Name = "\0"
    Holder.IgnoreGuiInset = true
    Holder.ResetOnSpawn = false
    Holder.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Holder.DisplayOrder = 999999
    Holder.Parent = gethui()

    Library.Holder = { Instance = Holder }
    Library.GuiInset = GuiInset

    local function Layer(Name, Order)
        -- one ScreenGui per layer: a whole layer always draws (and receives
        -- input) above the previous one regardless of nested ZIndex values
        local Gui = Instance.new("ScreenGui")
        Gui.Name = "\0"
        Gui.IgnoreGuiInset = true
        Gui.ResetOnSpawn = false
        Gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
        Gui.DisplayOrder = 2147482000 + Order
        Gui.Parent = gethui()

        local Entry = { Instance = Gui, ZIndex = Order }
        Library.Layers[Name] = Entry

        return Entry
    end

    Layer("Menu", 10)
    Layer("Tools", 30)
    Layer("Overlay", 50)
    Layer("Popups", 100)
    Layer("Tooltip", 120)

    local Display = Holder.AbsoluteSize

    local function RefreshDisplay()
        Display = Holder.AbsoluteSize
    end

    local function DisplaySize()
        RefreshDisplay()

        return Display
    end

    -- =====================================================================
    -- text measurement
    -- =====================================================================

    local MeasureLabel
    local MeasureCache = {}

    local function Measure(Text, Kind)
        Kind = Kind or "reg"

        if Text == "" then
            return 0
        end

        local Key = Kind .. "\0" .. Text
        local Cached = MeasureCache[Key]

        if Cached then
            return Cached
        end

        if not MeasureLabel or not MeasureLabel.Parent then
            MeasureLabel = Instance.new("TextLabel")
            MeasureLabel.Name = "\0"
            MeasureLabel.BackgroundTransparency = 1
            MeasureLabel.BorderSizePixel = 0
            MeasureLabel.Visible = false
            MeasureLabel.TextWrapped = false
            MeasureLabel.RichText = false
            MeasureLabel.Size = UDim2.fromOffset(1, 1)
            MeasureLabel.Parent = Holder
        end

        local Font = FONTS[Kind]
        MeasureLabel.FontFace = Font.face
        MeasureLabel.TextSize = Font.size
        MeasureLabel.Text = Text

        local Width = MeasureLabel.TextBounds.X

        if Width <= 0 then
            Width = math.ceil(#Text * Font.size * 0.58)
        end

        MeasureCache[Key] = Width

        return Width
    end

    Library.Measure = Measure

    -- =====================================================================
    -- draw (draw.cpp)
    -- =====================================================================

    local Draw = {
        Shines = {},
    }

    local function NewFrame(Parent, X, Y, Width, Height, Color, Alpha, ZIndex)
        local Frame = Instance.new("Frame")
        Frame.Name = "\0"
        Frame.BorderSizePixel = 0
        Frame.BackgroundColor3 = Color or Color3.new(1, 1, 1)
        Frame.BackgroundTransparency = 1 - (Alpha or 1)
        Frame.Position = UDim2.fromOffset(math.floor(X + 0.5), math.floor(Y + 0.5))
        Frame.Size = UDim2.fromOffset(math.max(0, math.floor(Width + 0.5)), math.max(0, math.floor(Height + 0.5)))
        Frame.ZIndex = ZIndex or 1
        Frame.Parent = Parent

        return Frame
    end

    local function Fill(Parent, X1, Y1, X2, Y2, Color, Alpha, ZIndex)
        if X2 < X1 or Y2 < Y1 then
            return nil
        end

        return NewFrame(Parent, X1, Y1, X2 - X1 + 1, Y2 - Y1 + 1, Color, Alpha, ZIndex)
    end

    local function Gradient(Parent, X1, Y1, X2, Y2, Top, Bottom, Alpha, ZIndex)
        if X2 < X1 or Y2 < Y1 then
            return nil
        end

        local Frame = NewFrame(Parent, X1, Y1, X2 - X1 + 1, Y2 - Y1 + 1, Color3.new(1, 1, 1), Alpha, ZIndex)
        local Grand = Instance.new("UIGradient")
        Grand.Name = "\0"
        Grand.Rotation = 90
        Grand.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Top),
            ColorSequenceKeypoint.new(1, Bottom),
        })
        Grand.Parent = Frame

        return Frame
    end

    local function GradientH(Parent, X1, Y1, X2, Y2, Left, Right, Alpha, ZIndex)
        if X2 < X1 or Y2 < Y1 then
            return nil
        end

        local Frame = NewFrame(Parent, X1, Y1, X2 - X1 + 1, Y2 - Y1 + 1, Color3.new(1, 1, 1), Alpha, ZIndex)
        local Grand = Instance.new("UIGradient")
        Grand.Name = "\0"
        Grand.Rotation = 0
        Grand.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Left),
            ColorSequenceKeypoint.new(1, Right),
        })
        Grand.Parent = Frame

        return Frame
    end

    -- horizontal gradient fading from AlphaLeft to AlphaRight of one colour
    -- vertical gradient with an alpha ramp (draw::gradient with transparent ends)
    local function GradientAlpha(Parent, X1, Y1, X2, Y2, Color, TopAlpha, BottomAlpha, ZIndex)
        if X2 < X1 or Y2 < Y1 then
            return nil
        end

        local Frame = NewFrame(Parent, X1, Y1, X2 - X1 + 1, Y2 - Y1 + 1, Color, 1, ZIndex)
        local Grand = Instance.new("UIGradient")
        Grand.Name = "\0"
        Grand.Rotation = 90
        Grand.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1 - TopAlpha),
            NumberSequenceKeypoint.new(1, 1 - BottomAlpha),
        })
        Grand.Parent = Frame

        return Frame
    end

    local function GradientFade(Parent, X1, Y1, X2, Y2, Color, AlphaLeft, AlphaRight, ZIndex)
        if X2 < X1 or Y2 < Y1 then
            return nil
        end

        local Frame = NewFrame(Parent, X1, Y1, X2 - X1 + 1, Y2 - Y1 + 1, Color, 1, ZIndex)
        local Grand = Instance.new("UIGradient")
        Grand.Name = "\0"
        Grand.Rotation = 0
        Grand.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1 - AlphaLeft),
            NumberSequenceKeypoint.new(1, 1 - AlphaRight),
        })
        Grand.Parent = Frame

        return Frame
    end

    local function Border(Parent, X1, Y1, X2, Y2, Color, Alpha, ZIndex)
        Fill(Parent, X1, Y1, X2, Y1, Color, Alpha, ZIndex)
        Fill(Parent, X1, Y2, X2, Y2, Color, Alpha, ZIndex)
        Fill(Parent, X1, Y1 + 1, X1, Y2 - 1, Color, Alpha, ZIndex)
        Fill(Parent, X2, Y1 + 1, X2, Y2 - 1, Color, Alpha, ZIndex)
    end

    local function Checker(Parent, X1, Y1, X2, Y2, CellW, CellH, Light, Dark, ZIndex)
        local Row = 0

        for Y = Y1, Y2, CellH do
            local Column = 0

            for X = X1, X2, CellW do
                local Color = ((Row + Column) % 2 == 1) and Dark or Light

                Fill(
                    Parent,
                    math.max(X, X1),
                    math.max(Y, Y1),
                    math.min(X + CellW - 1, X2),
                    math.min(Y + CellH - 1, Y2),
                    Color,
                    1,
                    ZIndex
                )

                Column = Column + 1
            end

            Row = Row + 1
        end
    end

    function Draw.Mask(Parent, X, Y, Rows, Color, Alpha, ZIndex)
        for Pass = 0, 1 do
            for RowIndex, Row in Rows do
                if Pass == 0 then
                    for Column = 1, #Row do
                        if Row:sub(Column, Column) == "#" then
                            local PX = X + Column - 1
                            local PY = Y + RowIndex - 1

                            Fill(Parent, PX - 1, PY - 1, PX + 1, PY + 1, C.text_outline, Alpha, ZIndex)
                        end
                    end
                else
                    local Column = 1

                    while Column <= #Row do
                        if Row:sub(Column, Column) == "#" then
                            local Start = Column

                            while Column <= #Row and Row:sub(Column, Column) == "#" do
                                Column = Column + 1
                            end

                            Fill(Parent, X + Start - 1, Y + RowIndex - 1, X + Column - 2, Y + RowIndex - 1, Color, Alpha, ZIndex)
                        else
                            Column = Column + 1
                        end
                    end
                end
            end
        end
    end

    -- draw::accent with the per-pixel shine built once and moved per frame
    function Draw.Accent(Parent, X1, X2, Y, Style, BoxLeft, BoxWidth, Radius, ZIndex)
        local Spread = Radius and Radius > 0 and Radius or math.floor(BoxWidth * 0.12)

        Fill(Parent, X1, Y, X2, Y, Style.base, 1, ZIndex)

        if Spread <= 0 then
            return
        end

        local Clip = NewFrame(Parent, X1, Y, X2 - X1 + 1, 1, nil, 0, ZIndex)
        Clip.BackgroundTransparency = 1
        Clip.ClipsDescendants = true

        local Width = Spread * 2 + 1
        local Shine = NewFrame(Clip, 0, 0, Width, 1, Color3.new(1, 1, 1), 1, 1)

        local Grand = Instance.new("UIGradient")
        Grand.Name = "\0"
        Grand.Rotation = 0

        local Keypoints = {}
        local Steps = 8

        for Step = 0, Steps do
            local T = Step / Steps
            local V = 1 - math.abs(T * 2 - 1)
            local Smooth = V * V * (3 - 2 * V)

            table.insert(Keypoints, ColorSequenceKeypoint.new(T, LerpColor(Style.base, Style.peak, Smooth)))
        end

        Grand.Color = ColorSequence.new(Keypoints)
        Grand.Parent = Shine

        table.insert(Draw.Shines, {
            Kind = "line",
            Clip = Clip,
            Mover = Shine,
            X1 = X1,
            Y = Y,
            Spread = Spread,
            BoxLeft = BoxLeft,
            BoxWidth = BoxWidth,
            Radius = Radius,
        })
    end

    -- draw::accent_glow — rows above/below with linear horizontal falloff
    function Draw.AccentGlow(Parent, X1, X2, Y, BoxLeft, BoxWidth, Radius, Above, Below, ZIndex)
        Above = Above or 2
        Below = Below or 7

        local Strength = P["Menu Glow"] or 0

        if Strength <= 0 then
            return
        end

        local Spread = Radius and Radius > 0 and Radius or math.floor(BoxWidth * 0.12)
        local Reach = math.max(Above, Below) + 1
        local MaxWidth = math.floor(Spread * 1.6)

        local Clip = NewFrame(Parent, X1, Y - Above, X2 - X1 + 1, Above + Below + 1, nil, 0, ZIndex)
        Clip.BackgroundTransparency = 1
        Clip.ClipsDescendants = true

        local Mover = NewFrame(Clip, 0, 0, MaxWidth * 2 + 2, Above + Below + 1, nil, 0, 1)
        Mover.BackgroundTransparency = 1

        for Row = -Above, Below do
            if Row ~= 0 then
                local RowReach = (Row < 0 and Above or Below) + 1
                local T = 1 - math.abs(Row) / RowReach
                local W = math.floor(Spread * 1.6 * (0.5 + 0.5 * T))
                local Alpha = 0.26 * T * T * Strength

                if W > 0 then
                    local Line = Row + Above

                    GradientFade(Mover, MaxWidth - W, Line, MaxWidth, Line, C.accent_top_glow, 0, Alpha, 1)
                    GradientFade(Mover, MaxWidth + 1, Line, MaxWidth + W, Line, C.accent_top_glow, Alpha, 0, 1)
                end
            end
        end

        table.insert(Draw.Shines, {
            Kind = "glow",
            Clip = Clip,
            Mover = Mover,
            X1 = X1,
            Y = Y,
            Spread = Spread,
            MaxWidth = MaxWidth,
            BoxLeft = BoxLeft,
            BoxWidth = BoxWidth,
            Radius = Radius,
        })
    end

    function Draw.EdgeGlow(Parent, X1, Y1, X2, Y2, ZIndex)
        local Strength = P["Menu Glow"] or 0

        if Strength <= 0 then
            return
        end

        local Alphas = { 70, 40, 22, 11, 5 }

        for Ring, Value in Alphas do
            local Spread = Ring

            Border(
                Parent,
                X1 - Spread,
                Y1 - Spread,
                X2 + Spread,
                Y2 + Spread,
                C.edge_glow,
                (Value / 255) * Strength,
                ZIndex
            )
        end
    end

    function Draw.Panel(Parent, X1, Y1, X2, Y2, ZIndex)
        local Width = X2 - X1 + 1

        Border(Parent, X1, Y1, X2, Y2, C.black, 1, ZIndex)

        Draw.Accent(Parent, X1 + 1, X2 - 1, Y1 + 1, { base = C.panel_border_top, peak = C.panel_border_glow }, X1, Width, nil, ZIndex)
        Draw.Accent(Parent, X1 + 1, X2 - 1, Y1 + 2, { base = C.accent_top, peak = C.accent_top_glow }, X1, Width, nil, ZIndex)
        Draw.Accent(Parent, X1 + 1, X2 - 1, Y1 + 3, { base = C.accent_bottom, peak = C.accent_bottom_glow }, X1, Width, nil, ZIndex)

        Fill(Parent, X1 + 1, Y1 + 4, X1 + 1, Y2 - 1, C.panel_light, 1, ZIndex)
        Fill(Parent, X2 - 1, Y1 + 4, X2 - 1, Y2 - 1, C.panel_light, 1, ZIndex)
        Fill(Parent, X1 + 2, Y2 - 1, X2 - 2, Y2 - 1, C.panel_light, 1, ZIndex)

        Draw.Accent(Parent, X1 + 2, X2 - 2, Y1 + 4, { base = C.panel_fill, peak = C.panel_fill_glow }, X1, Width, nil, ZIndex)
        Fill(Parent, X1 + 2, Y1 + 5, X2 - 2, Y2 - 2, C.panel_fill, 1, ZIndex)

        Draw.AccentGlow(Parent, X1 + 2, X2 - 2, Y1 + 2, X1, Width, nil, 1, 8, ZIndex)
    end

    function Draw.Window(Parent, X1, Y1, X2, Y2, ZIndex)
        local Width = X2 - X1 + 1

        Draw.EdgeGlow(Parent, X1, Y1, X2, Y2, ZIndex)

        Border(Parent, X1, Y1, X2, Y2, C.black, 1, ZIndex)
        Border(Parent, X1 + 1, Y1 + 1, X2 - 1, Y2 - 1, C.window_edge, 1, ZIndex)
        Border(Parent, X1 + 2, Y1 + 2, X2 - 2, Y2 - 2, C.black, 1, ZIndex)
        Fill(Parent, X1 + 3, Y1 + 3, X2 - 3, Y2 - 3, C.overlay_band, 1, ZIndex)

        Draw.Accent(Parent, X1 + 6, X2 - 6, Y1 + 5, { base = C.accent_top, peak = C.accent_top_glow }, X1, Width, nil, ZIndex)
        Draw.Accent(Parent, X1 + 6, X2 - 6, Y1 + 6, { base = C.accent_bottom, peak = C.accent_bottom_glow }, X1, Width, nil, ZIndex)
    end

    function Draw.WindowGlow(Parent, X1, Y1, X2, ZIndex)
        Draw.AccentGlow(Parent, X1 + 6, X2 - 6, Y1 + 5, X1, X2 - X1 + 1, nil, 2, 9, ZIndex)
    end

    function Draw.Avatar(Parent, X1, Y1, X2, Y2, ZIndex)
        Border(Parent, X1, Y1, X2, Y2, C.black, 1, ZIndex)
        Gradient(Parent, X1 + 1, Y1 + 1, X2 - 1, Y2 - 1, C.input_top, C.input_bottom, 1, ZIndex)

        local Width = X2 - X1 + 1
        local Height = Y2 - Y1 + 1
        local CenterX = X1 + math.floor(Width * 0.5)
        local Head = math.floor(math.min(Width, Height) * 0.17)
        local HeadY = Y1 + math.floor(Height * 0.34)
        local Body = math.floor(Width * 0.34)
        local BodyTop = HeadY + Head + 3
        local Color = LerpColor(C.input_top, C.text_dim, 0.75)

        local Clip = NewFrame(Parent, X1 + 1, Y1 + 1, X2 - X1, Y2 - Y1, nil, 0, ZIndex)
        Clip.BackgroundTransparency = 1
        Clip.ClipsDescendants = true

        local Circle = NewFrame(Clip, CenterX - Head - (X1 + 1), HeadY - (Y1 + 1), Head * 2, Head * 2, Color, 1, ZIndex)
        local Corner = Instance.new("UICorner")
        Corner.Name = "\0"
        Corner.CornerRadius = UDim.new(0.5, 0)
        Corner.Parent = Circle

        local BodyFrame = NewFrame(
            Clip,
            CenterX - Body - (X1 + 1),
            BodyTop - (Y1 + 1),
            Body * 2 + 1,
            (Y2 - math.floor(Height * 0.1)) - BodyTop + 1,
            Color,
            1,
            ZIndex
        )

        local BodyCorner = Instance.new("UICorner")
        BodyCorner.Name = "\0"
        BodyCorner.CornerRadius = UDim.new(0, Head)
        BodyCorner.Parent = BodyFrame
    end

    function Draw.FrameBox(Parent, X1, Y1, X2, Y2, FillColor, ZIndex)
        Border(Parent, X1, Y1, X2, Y2, C.black, 1, ZIndex)
        Border(Parent, X1 + 1, Y1 + 1, X2 - 1, Y2 - 1, C.frame_light, 1, ZIndex)
        Fill(Parent, X1 + 2, Y1 + 2, X2 - 2, Y2 - 2, FillColor, 1, ZIndex)
    end

    -- =====================================================================
    -- text
    -- =====================================================================

    local function TextTop(CenterY, Kind)
        return math.floor(CenterY) + 4 - FONTS[Kind].ascent
    end

    function Draw.Text(Parent, X, CenterY, Color, String, Kind, Alpha, ZIndex)
        Kind = Kind or "reg"

        local Font = FONTS[Kind]
        local Width = Measure(String, Kind)

        if Width <= 0 then
            return nil
        end

        local Label = Instance.new("TextLabel")
        Label.Name = "\0"
        Label.BackgroundTransparency = 1
        Label.BorderSizePixel = 0
        Label.FontFace = Font.face
        Label.TextSize = Font.size
        Label.TextColor3 = Color
        Label.TextTransparency = 1 - (Alpha or 1)
        Label.Text = String
        Label.TextWrapped = false
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.TextYAlignment = Enum.TextYAlignment.Center
        Label.Position = UDim2.fromOffset(math.floor(X), TextTop(CenterY, Kind) - 2)
        Label.Size = UDim2.fromOffset(Width + 2, Font.cell + 4)
        Label.ZIndex = ZIndex or 1
        Label.Parent = Parent

        Label.TextStrokeColor3 = C.text_outline
        Label.TextStrokeTransparency = 1 - (Alpha or 1)

        return Label
    end

    function Draw.TextWidth(String, Kind)
        return Measure(String, Kind)
    end

    function Draw.TextCentered(Parent, X1, X2, CenterY, Color, String, Kind, Alpha, ZIndex)
        local Width = Measure(String, Kind)

        return Draw.Text(
            Parent,
            X1 + math.floor((X2 - X1 + 1 - Width) * 0.5),
            CenterY,
            Color,
            String,
            Kind,
            Alpha,
            ZIndex
        )
    end

    function Draw.TextRight(Parent, Right, CenterY, Color, String, Kind, Alpha, ZIndex)
        local Width = Measure(String, Kind)

        return Draw.Text(Parent, Right - Width + 1, CenterY, Color, String, Kind, Alpha, ZIndex)
    end

    -- draw::text_wave — per glyph lerp toward the moving head
    function Draw.TextWave(Parent, X, CenterY, Base, Peak, String, Kind, Alpha, ZIndex)
        Kind = Kind or "reg"

        local Letters = #String

        if Letters == 0 then
            return
        end

        local Cursor = X
        local Labels = {}

        for Index = 1, Letters do
            local Char = String:sub(Index, Index)

            local Label = Draw.Text(Parent, Cursor, CenterY, Base, Char, Kind, Alpha, ZIndex)

            Cursor = Cursor + Measure(Char, Kind)

            table.insert(Labels, Label)
        end

        -- the source animates this every frame; bake a moving highlight
        local function Animate()
            if not Labels[1] or not Labels[1].Parent then
                Library:RemoveUpdate(Animate)
                return
            end

            local Head = (os.clock() - Library.StartTime) * 5 % (Letters + 8) - 1.6

            for Index = 1, Letters do
                local T = math.clamp(1 - math.abs((Index - 1) - Head) / 1.6, 0, 1)
                local Smooth = T * T * (3 - 2 * T)

                Labels[Index].TextColor3 = LerpColor(Base, Peak, Smooth)
            end
        end

        Library:AddUpdate(Animate)

        return Labels
    end

    Draw.Fill = Fill
    Draw.Gradient = Gradient
    Draw.GradientH = GradientH
    Draw.GradientFade = GradientFade
    Draw.GradientAlpha = GradientAlpha
    Draw.Border = Border
    Draw.Checker = Checker
    Draw.TextTop = TextTop

    Library.Draw = Draw

    -- shine animation, called once per frame from the render loop
    function Draw.UpdateShines()
        local Time = os.clock() - Library.StartTime
        local Sweep = (Time % 4.5) / 4.5

        for Index = #Draw.Shines, 1, -1 do
            local Entry = Draw.Shines[Index]

            if not Entry.Clip.Parent then
                table.remove(Draw.Shines, Index)
                continue
            end

            local Spread = Entry.Radius and Entry.Radius > 0 and Entry.Radius
                or math.floor(Entry.BoxWidth * 0.12)

            local Peak = math.floor(Entry.BoxLeft - Spread + (Entry.BoxWidth + Spread * 2) * Sweep)

            if Entry.Kind == "line" then
                Entry.Mover.Position = UDim2.fromOffset(Peak - Spread - Entry.X1, 0)
            else
                Entry.Mover.Position = UDim2.fromOffset(Peak - Entry.MaxWidth - Entry.X1, 0)
            end
        end
    end
    -- =====================================================================
    -- anim.cpp
    -- =====================================================================

    local Anim = {
        Values = {},
    }

    function Anim.Approach(Key, Target, Speed, Delta)
        local Value = Anim.Values[Key]

        if Value == nil then
            Anim.Values[Key] = Target
            return Target
        end

        local Blend = 1 - math.exp(-(Speed or 14) * (Delta or 0))
        Value = Value + (Target - Value) * Blend

        if math.abs(Target - Value) < 0.001 then
            Value = Target
        end

        Anim.Values[Key] = Value

        return Value
    end

    function Anim.Reset(Key)
        if Key then
            Anim.Values[Key] = nil
        else
            Anim.Values = {}
        end
    end

    function Anim.EaseOutCubic(T)
        local Inverse = 1 - T

        return 1 - Inverse * Inverse * Inverse
    end

    Library.Anim = Anim

    -- =====================================================================
    -- notify.cpp
    -- =====================================================================

    local Notify = {
        Toasts = {},
        NextId = 1,
    }

    local function ToastWidth(Title, Message, Timer)
        local Header = Measure(Title) + Measure(Timer) + 22
        local Body = Measure(Message) + 14

        return math.ceil(math.max(150, math.max(Header, Body)))
    end

    function Library:Notification(Params)
        Params = Params or {}

        if self ~= Library then
            Params = self
        end

        if Library.NotificationsEnabled == false then
            return
        end

        local Toast = {
            Id = Notify.NextId,
            Title = tostring(Params.Name or Params.Title or ""),
            Message = tostring(Params.Text or Params.Message or ""),
            Duration = tonumber(Params.Time or Params.Duration) or Library.NotificationDuration,
            Elapsed = 0,
            Presence = 0,
        }

        Notify.NextId = Notify.NextId + 1

        local LayerFrame = Library.Layers.Overlay.Instance
        local Width = ToastWidth(Toast.Title, Toast.Message, string.format("%.1fs", Toast.Duration))

        local Canvas = Instance.new("CanvasGroup")
        Canvas.Name = "\0"
        Canvas.BackgroundTransparency = 1
        Canvas.BorderSizePixel = 0
        Canvas.Size = UDim2.fromOffset(Width, 35)
        Canvas.Position = UDim2.fromOffset(10 - 16, 36)
        Canvas.GroupTransparency = 1
        Canvas.ZIndex = 4
        Canvas.Parent = LayerFrame

        local DrawParent = Canvas

        Draw.Panel(DrawParent, 0, 0, Width - 1, 34)
        Draw.Text(DrawParent, 6, 11, C.text, Toast.Title)
        local Timer = Draw.TextRight(DrawParent, Width - 7, 11, C.text, string.format("%.1fs", Toast.Duration))
        Draw.Text(DrawParent, 5, 25, C.text_message, Toast.Message)

        Toast.Instance = Canvas
        Toast.Timer = Timer
        Toast.Width = Width

        table.insert(Notify.Toasts, Toast)

        return Toast
    end

    Library.Notify = Library.Notification

    local function UpdateNotifications(Delta)
        local Toasts = Notify.Toasts
        local Cursor = 36

        for Index = #Toasts, 1, -1 do
            local Toast = Toasts[Index]

            Toast.Elapsed = Toast.Elapsed + Delta

            if Toast.Elapsed >= Toast.Duration or not Toast.Instance.Parent then
                Toast.Instance:Destroy()
                table.remove(Toasts, Index)
            end
        end

        for _, Toast in Toasts do
            local Enter = math.clamp(Toast.Elapsed / 0.25, 0, 1)
            local Leave = math.clamp((Toast.Duration - Toast.Elapsed) / 0.25, 0, 1)
            local Presence = Anim.EaseOutCubic(math.min(Enter, Leave))

            Toast.Presence = Presence

            local Left = math.floor(10 - (1 - Presence) * 16 + 0.5)
            local Top = math.floor(Anim.Approach("toast_" .. Toast.Id, Cursor, 14, Delta) + 0.5)

            Toast.Instance.Position = UDim2.fromOffset(Left, Top)
            Toast.Instance.GroupTransparency = 1 - Presence

            if Toast.Timer then
                Toast.Timer.Text = string.format("%.1fs", math.max(0, Toast.Duration - Toast.Elapsed))
            end

            Cursor = Cursor + 39 * math.min(1, Leave * 2)
        end
    end

    -- =====================================================================
    -- tooltip (extrapolated: notification panel geometry)
    -- =====================================================================

    local function Tooltip(Object, Text, Title)
        if not Object or not Text or Text == "" then
            return
        end

        local Target = Object

        if type(Object) == "table" then
            if Object.Instance then
                Target = Object.Instance
            elseif Object.Items then
                local Button = Object.Items.Button
                local Hitbox = Object.Items.Hitbox

                if Button and Button.Instance then
                    Target = Button.Instance
                elseif Hitbox and Hitbox.Instance then
                    Target = Hitbox.Instance
                elseif Object.Items.Container then
                    Target = Object.Items.Container
                end
            end
        end
        local LayerFrame = Library.Layers.Tooltip.Instance

        local Width = 190
        local TitleHeight = (Title and Title ~= "") and 13 or 0
        local TextHeight = math.ceil(Measure(Text) / (Width - 12)) * 13
        local Height = 6 + TitleHeight + TextHeight + 4

        local Key = tostring(Object) .. "|" .. Text

        local Frame = Instance.new("CanvasGroup")
        Frame.Name = "\0"
        Frame.BackgroundTransparency = 1
        Frame.BorderSizePixel = 0
        Frame.Size = UDim2.fromOffset(Width, Height)
        Frame.GroupTransparency = 1
        Frame.Visible = false
        Frame.ZIndex = 1
        Frame.Parent = LayerFrame

        Draw.Panel(Frame, 0, 0, Width - 1, Height - 1)
        Draw.Text(Frame, 6, 9, C.text, Title or "", "bold")

        local Body = Draw.Text(Frame, 6, TitleHeight + 9, (Title and Title ~= "") and C.text_dim or C.text, Text)
        Body.TextWrapped = true
        Body.Size = UDim2.fromOffset(Width - 12, TextHeight)

        local Alpha = 0
        local Target_Alpha = 0

        local function Position()
            local Point = Target.AbsolutePosition
            local Extent = Target.AbsoluteSize
            local Screen = DisplaySize()
            local X = Point.X + Extent.X + 8
            local Y = Point.Y + Extent.Y / 2

            if X + Width > Screen.X - 4 then
                X = math.max(Point.X - Width - 8, 4)
            end

            Frame.Position = UDim2.fromOffset(math.floor(X), math.floor(Y - Height / 2))
        end

        Target.MouseEnter:Connect(function()
            Position()
            Frame.Visible = true
            Target_Alpha = 1
        end)

        Target.MouseLeave:Connect(function()
            Target_Alpha = 0
        end)

        Library:AddUpdate(function(Delta)
            if Alpha == Target_Alpha then
                return
            end

            local Move = math.clamp(Delta / 0.12, 0, 1)

            if Target_Alpha > Alpha then
                Alpha = math.min(Alpha + Move, 1)
            else
                Alpha = math.max(Alpha - Move, 0)
            end

            Frame.GroupTransparency = 1 - Alpha
            Frame.Visible = Alpha > 0.002
        end)

        table.insert(Library.Tooltips, Frame)

        return Frame
    end

    Library.Tooltip = Tooltip

    -- =====================================================================
    -- screen helpers
    -- =====================================================================

    -- =====================================================================
    -- overlay.cpp — top bar
    -- =====================================================================

    local TopBarItems = {
        { Name = "Watermark", Key = "watermark", Get = function() return Library.SourceUI.watermark end, Set = function(Value) Library:SetSourceUI("watermark", Value) end },
        { Name = "Players", Key = "players", Get = function() return Library.SourceUI.players end, Set = function(Value) Library:SetSourceUI("players", Value) end },
        { Name = "Waypoints", Key = "waypoints", Get = function() return Library.SourceUI.waypoints end, Set = function(Value) Library:SetSourceUI("waypoints", Value) end },
        { Name = "Themes", Key = "themes", Get = function() return Library.SourceUI.themes end, Set = function(Value) Library:SetSourceUI("themes", Value) end },
        { Name = "Keybinds", Key = "keybinds", Get = function() return Library.SourceUI.keybinds end, Set = function(Value) Library:SetSourceUI("keybinds", Value) end },
        { Name = "Target HUD", Key = "target_hud", Get = function() return Library.SourceUI.target_hud end, Set = function(Value) Library:SetSourceUI("target_hud", Value) end },
        { Name = "Dex", Key = "dex", Get = function() return Library.SourceUI.dex end, Set = function(Value) Library:SetSourceUI("dex", Value) end },
        { Name = "Config", Key = "configs", Get = function() return Library.SourceUI.configs end, Set = function(Value) Library:SetSourceUI("configs", Value) end },
        { Name = "Perf", Key = "perf", Get = function() return Library.SourceUI.perf end, Set = function(Value) Library:SetSourceUI("perf", Value) end },
    }

    Library.SourceUI = {
        watermark = true,
        keybinds = true,
        target_hud = true,
        players = false,
        waypoints = false,
        themes = false,
        dex = false,
        configs = false,
        perf = false,
    }

    local TopBarFrame
    local TopBarElements = {}

    local function BuildTopBar()
        if not Library.Layers or not Library.Layers.Overlay then
            return
        end

        if TopBarFrame then
            TopBarFrame:Destroy()
        end

        local DisplaySizeNow = DisplaySize()
        local Width = DisplaySizeNow.X
        local Height = 26

        local Root = Instance.new("Frame")
        Root.Name = "\0"
        Root.BackgroundTransparency = 1
        Root.BorderSizePixel = 0
        Root.Position = UDim2.fromOffset(0, 0)
        Root.Size = UDim2.fromOffset(Width, Height)
        Root.ZIndex = 2
        Root.Parent = Library.Layers.Overlay.Instance

        TopBarFrame = Root
        TopBarElements = {}

        local Right = Width - 1
        local Bottom = Height - 1

        Draw.Accent(Root, 0, Right, 0, { base = C.accent_top, peak = C.accent_top_glow }, 0, Width, 64)
        Draw.Accent(Root, 0, Right, 1, { base = C.accent_bottom, peak = C.accent_bottom_glow }, 0, Width, 64)
        Draw.Gradient(Root, 0, 2, Right, Bottom - 1, C.top_bar_top, C.top_bar_bottom)
        Draw.Fill(Root, 0, Bottom, Right, Bottom, C.black)
        Draw.AccentGlow(Root, 0, Right, 0, 0, Width, 64, 0, 8)

        local SeparatorGap = 7
        local Padding = 10
        local TextRow = 13

        local X = Padding
        local Brand = Draw.TextWave(Root, X, TextRow, C.text, C.text_active, "dbxlll", "bold")
        X = X + Measure("dbxlll", "bold") + SeparatorGap

        Draw.Text(Root, X, TextRow, C.text_separator, "|", "bar")
        X = X + Measure("|", "bar") + SeparatorGap

        for Index, Item in TopBarItems do
            if Index > 1 then
                Draw.Text(Root, X, TextRow, C.text_separator, "/", "bar")
                X = X + Measure("/", "bar") + SeparatorGap
            end

            local Active = Item.Get()
            local Kind = Active and "bold" or "bar"
            local WidthOf = Measure(Item.Name, Kind)
            local Label = Draw.Text(Root, X, TextRow, Active and C.text or C.text_title, Item.Name, Kind)

            local Hitbox = Instance.new("TextButton")
            Hitbox.Name = "\0"
            Hitbox.Text = ""
            Hitbox.AutoButtonColor = false
            Hitbox.BackgroundTransparency = 1
            Hitbox.BorderSizePixel = 0
            Hitbox.Position = UDim2.fromOffset(X - 3, 0)
            Hitbox.Size = UDim2.fromOffset(WidthOf + 6, Height)
            Hitbox.ZIndex = 4
            Hitbox.Parent = Root

            local Rest = Active and C.text or C.text_title

            Hitbox.MouseEnter:Connect(function()
                Label.TextColor3 = LerpColor(Rest, C.text, 0.4)
            end)

            Hitbox.MouseLeave:Connect(function()
                Label.TextColor3 = Rest
            end)

            Hitbox.MouseButton1Click:Connect(function()
                local Value = not Item.Get()

                Item.Set(Value)

                Library:Notification({
                    Name = "dbxlll",
                    Text = string.lower(Item.Name) .. (Value and " enabled" or " disabled"),
                })

                -- active items use the bold face, which changes every following
                -- slot; rebuild once instead of leaving a stale layout
                task.defer(BuildTopBar)
            end)

            table.insert(TopBarElements, Label)

            X = X + WidthOf + SeparatorGap
        end

        local Clock = Draw.TextRight(Root, Right - Padding, TextRow, C.text, os.date("%I:%M %p %m/%d/%Y"), "bar")

        Library.TopBarClock = Clock

        local function Tick()
            if not Clock.Parent then
                Library:RemoveUpdate(Tick)
                return
            end

            local Text = os.date("%I:%M %p %m/%d/%Y")

            if Clock.Text ~= Text then
                Clock.Text = Text
            end
        end

        Library:AddUpdate(Tick)
    end

    Library.BuildTopBar = BuildTopBar

    -- =====================================================================
    -- overlay.cpp — watermark
    -- =====================================================================

    local WatermarkObject

    function Library:Watermark(Params)
        Params = Params or {}

        if self ~= Library then
            Params = self
        end

        local Watermark = {
            Name = tostring(Params.Name or Params.name or "dbxlll"),
            SubName = tostring(Params.SubName or Params.subname or "build: footjob"),
            Status = tostring(Params.Status or Params.SubName or Params.subname or ""),
            Auto = Params.Auto ~= false and Params.auto ~= false,
            Visible = true,
            Items = {},
        }

        local Width = 240
        local Height = 32
        local DisplaySizeNow = DisplaySize()

        local Root = Instance.new("CanvasGroup")
        Root.Name = "\0"
        Root.BackgroundTransparency = 1
        Root.BorderSizePixel = 0
        Root.Position = UDim2.fromOffset(DisplaySizeNow.X - 26 - Width, 46)
        Root.Size = UDim2.fromOffset(Width, Height)
        Root.GroupTransparency = 1
        Root.ZIndex = 2
        Root.Parent = Library.Layers.Overlay.Instance

        local Placed = false

        local function Build()
            local Content = math.ceil(
                Measure(Watermark.Name, "bold") + 55 + Measure(Watermark.SubName, "bold")
                    + Measure("/", "bold") * 2 + 7 * 4
            )

            Width = Content + 12 + 10 + 12

            Root.Size = UDim2.fromOffset(Width, Height)

            if not Placed then
                Root.Position = UDim2.fromOffset(DisplaySizeNow.X - 26 - Width, 46)
                Placed = true
            end

            Root:ClearAllChildren()

            Draw.Window(Root, 0, 0, Width - 1, Height - 1)
            Draw.FrameBox(Root, 6, 8, Width - 7, Height - 7, C.frame_fill)
            Draw.WindowGlow(Root, 0, 0, Width - 1)

            local Row = 17
            local X = 6 + 12

            Draw.TextWave(Root, X, Row, C.text, C.text_active, Watermark.Name, "bold")
            X = X + Measure(Watermark.Name, "bold") + 7

            Draw.Text(Root, X, Row, C.text_separator, "/", "bold")
            X = X + Measure("/", "bold") + 7

            Draw.TextCentered(Root, X, X + 55 - 1, Row, C.text, string.format("fps: %d", Library.FpsValue or 60), "bold")
            X = X + 55 + 7

            Draw.Text(Root, X, Row, C.text_separator, "/", "bold")
            X = X + Measure("/", "bold") + 7

            Draw.Text(Root, X, Row, C.text, Watermark.SubName, "bold")
        end

        Watermark.Items.Watermark = { Instance = Root }
        Watermark.Items.Row = { Instance = Root }

        Build()

        -- dragging
        do
            local Dragging = false
            local DragStart
            local StartPosition

            Root.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1
                    or Input.UserInputType == Enum.UserInputType.Touch
                then
                    Dragging = true
                    DragStart = Input.Position
                    StartPosition = Root.Position
                end
            end)

            Connect(UserInputService.InputEnded, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1
                    or Input.UserInputType == Enum.UserInputType.Touch
                then
                    Dragging = false
                end
            end)

            Connect(UserInputService.InputChanged, function(Input)
                if not Dragging then
                    return
                end

                if Input.UserInputType == Enum.UserInputType.MouseMovement
                    or Input.UserInputType == Enum.UserInputType.Touch
                then
                    local Delta = Input.Position - DragStart
                    local Size = Root.AbsoluteSize
                    local Screen = DisplaySize()

                    local NewX = math.clamp(StartPosition.X.Offset + Delta.X, 0, Screen.X - Size.X)
                    local NewY = math.clamp(StartPosition.Y.Offset + Delta.Y, 0, Screen.Y - Size.Y)

                    Root.Position = UDim2.fromOffset(math.floor(NewX), math.floor(NewY))
                end
            end)
        end

        function Watermark:Center()
            local Size = Root.AbsoluteSize
            local Screen = DisplaySize()

            Root.Position = UDim2.fromOffset(math.floor((Screen.X - Size.X) / 2), Root.Position.Y.Offset)
        end

        function Watermark:SetText(Text)
            Watermark.Name = tostring(Text)
            Build()
        end

        function Watermark:SetSubText(Text)
            Watermark.SubName = tostring(Text)
            Build()
        end

        function Watermark:SetStatus(Text)
            Watermark.Status = tostring(Text)
        end

        function Watermark:SetVisibility(Value)
            Watermark.Visible = Value and true or false
            Root.Visible = Watermark.Visible
        end

        function Watermark:Toggle()
            Watermark:SetVisibility(not Watermark.Visible)
        end

        function Watermark:Destroy()
            Root:Destroy()
        end

        WatermarkObject = Watermark
        Library.WatermarkObject = Watermark

        Library:AddUpdate(function(Delta)
            if not Root.Parent then
                return
            end

            local Target = Watermark.Visible and 1 or 0
            local Visible = Anim.Approach("watermark_fade", Target, 12, Delta)

            Root.Visible = Visible > 0.002
            Root.GroupTransparency = 1 - Visible
        end)

        return Watermark
    end

    -- =====================================================================
    -- overlay.cpp — keybind list
    -- =====================================================================

    local KeybindListObject

    function Library:KeybindList(Params)
        Params = Params or {}

        if self ~= Library then
            Params = self
        end

        local KeybindList = {
            Name = tostring(Params.Name or Params.name or "Keybind"),
            Visible = true,
            Entries = {},
            Items = {},
        }

        local DisplaySizeNow = DisplaySize()

        local Root = Instance.new("Frame")
        Root.Name = "\0"
        Root.BackgroundTransparency = 1
        Root.BorderSizePixel = 0
        Root.Position = UDim2.fromOffset(10, math.floor(DisplaySizeNow.Y * 0.4))
        Root.Size = UDim2.fromOffset(152, 40)
        Root.ZIndex = 2
        Root.Parent = Library.Layers.Overlay.Instance

        KeybindList.Items.KeybindList = { Instance = Root }

        local function ModeText(Entry)
            if Entry.Mode == "Always" or not Entry.Key or Entry.Key == Enum.KeyCode.Unknown then
                return "(Always)"
            end

            return "(" .. Library.FormatKey(Entry.Key) .. ", " .. string.lower(Entry.Mode or "Hold") .. ")"
        end

        local function Build()
            local Rows = {}

            for _, Entry in KeybindList.Entries do
                if Entry.Enabled ~= false then
                    table.insert(Rows, Entry)
                end
            end

            local Width = 152

            for _, Entry in Rows do
                local Needed = 12 + 9 + Measure(Entry.Name, "bold") + 20 + Measure(ModeText(Entry), "bold") + 8

                Width = math.max(Width, math.ceil(Needed))
            end

            local ShownRows = #Rows
            local BodyHeight = ShownRows > 0 and math.floor(4 + ShownRows * 14 + 0.5) or 0
            local Height = 26 + (BodyHeight > 0 and BodyHeight + 3 or 0) + 6

            Root.Size = UDim2.fromOffset(Width, Height)
            Root:ClearAllChildren()

            local Left = 0
            local Top = 0
            local Right = Width - 1
            local Bottom = Height - 1

            Draw.Window(Root, Left, Top, Right, Bottom)

            local TitleFrame = { left = 6, top = 8, right = Width - 7, bottom = 25 }

            Draw.FrameBox(Root, TitleFrame.left, TitleFrame.top, TitleFrame.right, TitleFrame.bottom, C.frame_fill)
            Draw.WindowGlow(Root, 0, 0, Width - 1)
            Draw.Text(Root, TitleFrame.left + 5, TitleFrame.top + 9, C.text, "Keybinds", "bold")

            if BodyHeight > 0 then
                local Body = { left = TitleFrame.left, top = TitleFrame.bottom + 4, right = TitleFrame.right, bottom = TitleFrame.bottom + 3 + BodyHeight }

                Draw.FrameBox(Root, Body.left, Body.top, Body.right, Body.bottom, C.frame_fill)

                local Clip = Instance.new("Frame")
                Clip.Name = "\0"
                Clip.BackgroundTransparency = 1
                Clip.BorderSizePixel = 0
                Clip.ClipsDescendants = true
                Clip.Position = UDim2.fromOffset(Body.left + 2, Body.top + 2)
                Clip.Size = UDim2.fromOffset(Body.right - Body.left - 2, Body.bottom - Body.top - 2)
                Clip.ZIndex = 3
                Clip.Parent = Root

                for Index, Entry in Rows do
                    local Row = Body.top + 9 + (Index - 1) * 14 - (Body.top + 2)

                    Draw.Text(Clip, 9 - 2, Row, C.text, Entry.Name, "bold")
                    Draw.TextRight(Clip, Body.right - 8 - (Body.left + 2), Row, C.text_dim, ModeText(Entry), "bold")
                end
            end
        end

        function KeybindList:Refresh()
            Build()
        end

        function KeybindList:Add(Name, Mode, Key, Enabled)
            table.insert(KeybindList.Entries, {
                Name = tostring(Name),
                Mode = Mode or "Always",
                Key = Key,
                Enabled = Enabled ~= false,
            })

            Build()

            return KeybindList.Entries[#KeybindList.Entries]
        end

        function KeybindList:Remove(Name)
            for Index = #KeybindList.Entries, 1, -1 do
                if KeybindList.Entries[Index].Name == Name then
                    table.remove(KeybindList.Entries, Index)
                end
            end

            Build()
        end

        function KeybindList:SetVisibility(Value)
            KeybindList.Visible = Value and true or false
            Root.Visible = KeybindList.Visible
        end

        function KeybindList:Toggle()
            KeybindList:SetVisibility(not KeybindList.Visible)
        end

        function KeybindList:Center()
            local Screen = DisplaySize()

            Root.Position = UDim2.fromOffset(
                math.floor((Screen.X - Root.AbsoluteSize.X) / 2),
                math.floor((Screen.Y - Root.AbsoluteSize.Y) / 2)
            )
        end

        function KeybindList:SetText(Text)
            KeybindList.Name = tostring(Text)
        end

        function KeybindList:Destroy()
            Root:Destroy()
        end

        Build()

        KeybindListObject = KeybindList
        Library.KeyList = KeybindList

        do
            local Dragging = false
            local DragStart
            local StartPosition

            Root.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1
                    or Input.UserInputType == Enum.UserInputType.Touch
                then
                    Dragging = true
                    DragStart = Input.Position
                    StartPosition = Root.Position
                end
            end)

            Connect(UserInputService.InputEnded, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1
                    or Input.UserInputType == Enum.UserInputType.Touch
                then
                    Dragging = false
                end
            end)

            Connect(UserInputService.InputChanged, function(Input)
                if not Dragging then
                    return
                end

                if Input.UserInputType == Enum.UserInputType.MouseMovement
                    or Input.UserInputType == Enum.UserInputType.Touch
                then
                    local Delta = Input.Position - DragStart
                    local Size = Root.AbsoluteSize
                    local Screen = DisplaySize()

                    Root.Position = UDim2.fromOffset(
                        math.floor(math.clamp(StartPosition.X.Offset + Delta.X, 0, Screen.X - Size.X)),
                        math.floor(math.clamp(StartPosition.Y.Offset + Delta.Y, 0, Screen.Y - Size.Y))
                    )
                end
            end)
        end

        return KeybindList
    end

    -- =====================================================================
    -- overlay.cpp — target hud
    -- =====================================================================

    local TargetHUDObject

    function Library:TargetHUD(Params)
        Params = Params or {}

        if self ~= Library then
            Params = self
        end

        local HUD = {
            Name = tostring(Params.Name or Params.name or "ext"),
            Health = tonumber(Params.Health) or 100,
            MaxHealth = tonumber(Params.MaxHealth) or 100,
            Visible = true,
            Items = {},
        }

        local Width = 192
        local Height = 84
        local DisplaySizeNow = DisplaySize()

        local Root = Instance.new("Frame")
        Root.Name = "\0"
        Root.BackgroundTransparency = 1
        Root.BorderSizePixel = 0
        Root.Position = UDim2.fromOffset(DisplaySizeNow.X - 26 - Width, 84)
        Root.Size = UDim2.fromOffset(Width, Height)
        Root.ZIndex = 2
        Root.Parent = Library.Layers.Overlay.Instance

        HUD.Items.TargetHUD = { Instance = Root }

        local HealthValue = HUD.Health
        local HealthLabel
        local NameLabel

        local function HealthBar(Left, Top, Right, Bottom, Fraction)
            local Inner = { left = Left + 1, top = Top + 1, right = Right - 1, bottom = Bottom - 1 }
            local BarWidth = Right - Left + 1

            Draw.Border(Root, Left, Top, Right, Bottom, C.black)
            Draw.Fill(Root, Inner.left, Inner.top, Inner.right, Inner.bottom, C.input_bottom)

            local Filled = math.floor((Inner.right - Inner.left + 1) * math.clamp(Fraction, 0, 1) + 0.5)

            if Filled <= 0 then
                return
            end

            local FillRight = Inner.left + Filled - 1

            Draw.Border(Root, Inner.left, Inner.top, FillRight, Inner.bottom, C.health_light)
            Draw.Accent(Root, Inner.left + 1, FillRight - 1, Inner.top + 1, { base = C.health_accent, peak = C.health_accent_glow }, Left, BarWidth, nil)
            Draw.Accent(Root, Inner.left + 1, FillRight - 1, Inner.top + 2, { base = C.health_shade, peak = C.health_shade_glow }, Left, BarWidth, nil)
            Draw.Gradient(Root, Inner.left + 1, Inner.top + 3, FillRight - 1, Inner.bottom - 1, C.health_top, C.health_bottom)
        end

        local function Build()
            Root:ClearAllChildren()

            local Left = 0
            local Top = 0
            local Right = Width - 1
            local Bottom = Height - 1

            local Title = { left = 6, top = 8, right = Width - 7, bottom = 25 }
            local Body = { left = 6, top = 30, right = Width - 7, bottom = Height - 7 }
            local Pfp = { left = Body.left + 2, top = Body.top + 2, right = Body.left + 45, bottom = Body.bottom - 2 }
            local Bar = { left = Pfp.right + 3, top = Body.top + 14, right = Body.right - 4, bottom = Body.bottom - 4 }

            Draw.Window(Root, Left, Top, Right, Bottom)
            Draw.FrameBox(Root, Title.left, Title.top, Title.right, Title.bottom, C.frame_fill)
            Draw.WindowGlow(Root, Left, Top, Right)

            Draw.TextCentered(Root, Title.left, Title.right, Title.top + 9, C.text, "Target", "bold")

            Draw.FrameBox(Root, Body.left, Body.top, Body.right, Body.bottom, C.frame_fill)
            Draw.Border(Root, Pfp.left, Pfp.top, Pfp.right, Pfp.bottom, C.black)
            Draw.Gradient(Root, Pfp.left + 1, Pfp.top + 1, Pfp.right - 1, Pfp.bottom - 1, C.input_top, C.input_bottom)

            NameLabel = Draw.Text(Root, Bar.left + 1, Bar.top - 6, C.text_target, HUD.Name)

            HealthBar(Bar.left, Bar.top, Bar.right, Bar.bottom, HealthValue / HUD.MaxHealth)

            HealthLabel = Draw.TextCentered(
                Root,
                Bar.left,
                Bar.right,
                Bar.top + 15,
                C.text,
                string.format("%d / %d", math.floor(HealthValue + 0.5), HUD.MaxHealth)
            )
        end

        function HUD:SetVisible(Value)
            HUD.Visible = Value and true or false
            Root.Visible = HUD.Visible
        end

        HUD.SetVisibility = HUD.SetVisible

        function HUD:SetName(Name)
            HUD.Name = tostring(Name)

            if NameLabel then
                NameLabel.Text = HUD.Name
            end
        end

        function HUD:SetHealth(Value, Max)
            HUD.Health = tonumber(Value) or HUD.Health

            if Max then
                HUD.MaxHealth = tonumber(Max) or HUD.MaxHealth
            end

            Anim.Values["target_health"] = HUD.Health

            Build()
        end

        function HUD:Center()
            local Screen = DisplaySize()

            Root.Position = UDim2.fromOffset(
                math.floor((Screen.X - Width) / 2),
                math.floor((Screen.Y - Height) / 2)
            )
        end

        function HUD:Destroy()
            Root:Destroy()
        end

        Build()

        do
            local Dragging = false
            local DragStart
            local StartPosition

            Root.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1
                    or Input.UserInputType == Enum.UserInputType.Touch
                then
                    Dragging = true
                    DragStart = Input.Position
                    StartPosition = Root.Position
                end
            end)

            Connect(UserInputService.InputEnded, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1
                    or Input.UserInputType == Enum.UserInputType.Touch
                then
                    Dragging = false
                end
            end)

            Connect(UserInputService.InputChanged, function(Input)
                if not Dragging then
                    return
                end

                if Input.UserInputType == Enum.UserInputType.MouseMovement
                    or Input.UserInputType == Enum.UserInputType.Touch
                then
                    local Delta = Input.Position - DragStart
                    local Screen = DisplaySize()

                    Root.Position = UDim2.fromOffset(
                        math.floor(math.clamp(StartPosition.X.Offset + Delta.X, 0, Screen.X - Width)),
                        math.floor(math.clamp(StartPosition.Y.Offset + Delta.Y, 0, Screen.Y - Height))
                    )
                end
            end)
        end

        TargetHUDObject = HUD
        Library.TargetHUDObject = HUD

        Library:AddUpdate(function(Delta)
            if not Root.Parent then
                return
            end

            local Target = HUD.Visible and 1 or 0
            local Visible = Anim.Approach("target_hud_fade", Target, 12, Delta)

            Root.Visible = Visible > 0.002

            if not Root.Visible or not HealthLabel then
                return
            end

            local Shown = Anim.Approach("target_health", HUD.Health, 10, Delta)
            local Value = string.format("%d / %d", math.floor(Shown + 0.5), HUD.MaxHealth)

            if HealthLabel.Text ~= Value then
                HealthLabel.Text = Value
            end
        end)

        return HUD
    end
    -- =====================================================================
    -- menu.cpp — window metrics
    -- =====================================================================

    local MENU = {
        width = 644,
        height = 668,
        min_width = 480,
        min_height = 300,
        drag_height = 33,
    }

    local METRIC = {
        title_offset = 11,
        first_row_offset = 25,
        content_inset = 6,
        checkbox_row = 14,
        checkbox_size = 10,
        checkbox_label = 14,
        label_indent = 2,
        widget_offset = 8,
        slider_height = 10,
        slider_advance = 27,
        combo_height = 16,
        combo_advance = 33,
        combo_text_indent = 4,
        dropdown_item = 15,
        keybind_width = 32,
        keybind_height = 12,
        key_mode_width = 60,
        swatch_width = 22,
        swatch_height = 10,
        expand_size = 11,
        inline_gap = 4,
        swatch_gap = 6,
        popup_title_offset = 9,
        popup_first_row = 23,
        popup_right_inset = 8,
        area_first_row = 11,
        button_height = 16,
        button_advance = 20,
        default_settings_height = 120,
    }

    -- tool_window table from tools.cpp
    local TOOL_DEFS = {
        {
            id = "players",
            title = "Playerlist",
            size = { 440, 340 },
            min = { 300, 220 },
            opening = "unfold",
            ui = "players",
        },
        {
            id = "waypoints",
            title = "Waypoints",
            size = { 355, 388 },
            min = { 240, 200 },
            opening = "fade",
            ui = "waypoints",
        },
        {
            id = "colors",
            title = "Colors",
            size = { 230, 373 },
            min = { 230, 373 },
            opening = "fade",
            ui = "themes",
        },
        {
            id = "dex",
            title = "Dex Explorer",
            size = { 490, 680 },
            min = { 300, 300 },
            opening = "fade",
            ui = "dex",
        },
        {
            id = "configs",
            title = "Config",
            size = { 296, 338 },
            min = { 240, 200 },
            opening = "fade",
            ui = "configs",
        },
        {
            id = "perf",
            title = "Thread Performance",
            size = { 540, 710 },
            min = { 380, 360 },
            opening = "fade",
            ui = "perf",
        },
    }

    -- =====================================================================
    -- widget helpers (widgets.cpp)
    -- =====================================================================

    local Widgets = {}

    local function ContextValues(Left, Right, Cursor, LastRow)
        return {
            Left = Left,
            Right = Right,
            Cursor = Cursor,
            LastRow = LastRow,
            InlineRight = Right,
            InlineGap = 0,
        }
    end

    local function TakeRow(Context, Advance)
        local Row = Context.Cursor

        Context.LastRow = Row
        Context.Cursor = Context.Cursor + Advance
        Context.InlineRight = Context.Right
        Context.InlineGap = 0

        return Row
    end

    local function PlaceInline(Context, Width, Gap)
        local Right = Context.InlineRight - Context.InlineGap
        local Left = Right - Width + 1

        Context.InlineRight = Left - 1
        Context.InlineGap = Gap or 0

        return Left, Right
    end

    local function RenderInput(Parent, Left, Top, Right, Bottom, Hover, ZIndex)
        local TopColor = LerpColor(C.input_top, C.input_hover_top, Hover)
        local BottomColor = LerpColor(C.input_bottom, C.input_hover_bottom, Hover)

        Draw.Border(Parent, Left, Top, Right, Bottom, C.black, 1, ZIndex)
        Draw.Gradient(Parent, Left + 1, Top + 1, Right - 1, Bottom - 1, TopColor, BottomColor, 1, ZIndex)
    end

    local function RenderArrow(Parent, Right, Top, Open, ZIndex)
        local Inset = { 0, 1, 2 }
        local Flip = math.cos(Open * math.pi)
        local Rows = math.max(1, math.floor(math.abs(Flip) * 3 + 0.5))
        local Down = Flip >= 0
        local First = Top + 7 - math.floor(Rows / 2)

        for Index = 1, Rows do
            local InsetValue = Inset[(Down and Index or (Rows - Index + 1))] + (3 - Rows)
            local Y = First + Index - 1

            Draw.Fill(Parent, Right - 8 + InsetValue, Y, Right - 3 - InsetValue, Y, C.arrow, 1, ZIndex)
        end
    end

    local function HoverChannel(Button)
        local State = { Value = 0, Target = 0 }

        Button.MouseEnter:Connect(function()
            State.Target = 1
        end)

        Button.MouseLeave:Connect(function()
            State.Target = 0
        end)

        return State
    end

    -- animation driver shared by every hover/checked channel
    local function ChannelUpdater(Key, TargetFunction, Speed)
        local Current = nil

        return function(Delta)
            local Target = TargetFunction()

            if Current == nil then
                Current = Target
                Anim.Values[Key] = Target
                return Target, true
            end

            local Next = Anim.Approach(Key, Target, Speed, Delta)
            local Changed = Next ~= Current
            Current = Next

            return Next, Changed
        end
    end

    Library.Widgets = Widgets
    Library.Metric = METRIC

    -- =====================================================================
    -- flags
    -- =====================================================================

    local function GetFlag(Flag, Default)
        if Flag == nil then
            return Default
        end

        local Value = Library.Flags[Flag]

        if Value == nil then
            return Default
        end

        return Value
    end

    local function SetFlag(Flag, Value)
        if Flag ~= nil then
            Library.Flags[Flag] = Value
        end
    end

    Library.GetFlag = GetFlag
    Library.SetFlag = SetFlag

    -- =====================================================================
    -- container: Section
    -- =====================================================================

    local Section = {}
    Section.__index = Section

    local function SectionBuildChrome(Self)
        local Parent = Self.Panel
        local Width = Self.Width
        local Height = Self.Height

        Parent:ClearAllChildren()

        Draw.Panel(Parent, 0, 0, Width - 1, Height - 1)
        Draw.Text(Parent, METRIC.content_inset, METRIC.title_offset, C.text_title, Self.Name, "reg", 1, 3)
    end

    function Section:Row(Advance)
        return TakeRow(self.Context, Advance)
    end

    function Section:Place(Width, Gap)
        return PlaceInline(self.Context, Width, Gap)
    end

    function Section:Finish()
        local Bottom

        if self.FixedHeight then
            Bottom = self.Height
        else
            Bottom = self.Context.Cursor + 6
            self.Height = math.ceil(Bottom)
            self.Frame.Size = UDim2.fromOffset(self.Width, self.Height)
            self.WidgetFrame.Size = UDim2.fromOffset(self.Width, self.Height)
            SectionBuildChrome(self)
        end

        self.Bottom = Bottom

        return self
    end

    function Section:Label(Params)
        Params = Params or {}

        local Row = TakeRow(self.Context, METRIC.checkbox_row)

        Draw.Text(self.WidgetFrame, self.Context.Left + METRIC.label_indent, Row, C.text, tostring(Params.Name or ""))

        local LabelObject = {
            Name = tostring(Params.Name or ""),
            Section = self,
            Row = Row,
            Items = {},
        }

        setmetatable(LabelObject, Library)

        function LabelObject:Colorpicker(Options)
            Options = Options or {}
            Options.Name = Options.Name or LabelObject.Name
            Options.Parent = self.Section
            Options.Row = LabelObject.Row

            return Widgets.Swatch(self.Context, Options, self.Section)
        end

        function LabelObject:Keybind(Options)
            Options = Options or {}
            Options.Name = Options.Name or LabelObject.Name
            Options.Row = LabelObject.Row

            return Widgets.Keybind(self.Context, Options, self.Section)
        end

        return LabelObject
    end

    function Section:Toggle(Params)
        return Widgets.Toggle(self.Context, Params or {}, self)
    end

    function Section:Slider(Params)
        return Widgets.Slider(self.Context, Params or {}, self)
    end

    function Section:Dropdown(Params)
        return Widgets.Dropdown(self.Context, Params or {}, self)
    end

    function Section:Textbox(Params)
        return Widgets.Textbox(self.Context, Params or {}, self)
    end

    function Section:Button(Params)
        return Widgets.Button(self.Context, Params or {}, self)
    end

    function Section:Colorpicker(Params)
        return Widgets.Swatch(self.Context, Params or {}, self)
    end

    function Section:Checkbox(Params)
        return Widgets.Toggle(self.Context, Params or {}, self)
    end

    function Section:MultiDropdown(Params)
        Params = Params or {}
        Params.Multi = true

        return Widgets.Dropdown(self.Context, Params, self)
    end

    function Section:Combo(Params)
        return Widgets.Dropdown(self.Context, Params or {}, self)
    end

    function Section:Input(Params)
        return Widgets.Textbox(self.Context, Params or {}, self)
    end

    function Section:Settings(Params)
        Params = Params or {}

        return Widgets.Settings(self.Context, Params, self, Params.Row or self.Context.LastRow)
    end

    function Section:Keybind(Params)
        return Widgets.Keybind(self.Context, Params or {}, self)
    end

    function Section:Space(Amount)
        self.Context.Cursor = self.Context.Cursor + (Amount or 4)
    end

    -- =====================================================================
    -- toggle (widgets::checkbox)
    -- =====================================================================

    function Widgets.Toggle(Context, Params, SectionRef)
        local Flag = Params.Flag
        local Value = GetFlag(Flag, Params.Default)
        Value = Value and true or false

        local Row = TakeRow(Context, METRIC.checkbox_row)
        local Name = tostring(Params.Name or "")
        local Width = Measure(Name)

        local Left = Context.Left
        local BoxLeft = Left
        local BoxTop = Row - 5
        local BoxRight = Left + METRIC.checkbox_size - 1
        local BoxBottom = Row + 4

        local Hitbox = Instance.new("TextButton")
        Hitbox.Name = "\0"
        Hitbox.Text = ""
        Hitbox.AutoButtonColor = false
        Hitbox.BackgroundTransparency = 1
        Hitbox.BorderSizePixel = 0
        Hitbox.Position = UDim2.fromOffset(Left, Row - 6)
        Hitbox.Size = UDim2.fromOffset(METRIC.checkbox_label + Width + 1, 14)
        Hitbox.ZIndex = 40
        Hitbox.Parent = Context.Parent

        local Gradient = Draw.Gradient(
            Context.Parent,
            BoxLeft + 1,
            BoxTop + 1,
            BoxRight - 1,
            BoxBottom - 1,
            C.checkbox_top,
            C.checkbox_bottom,
            1,
            3
        )

        Draw.Border(Context.Parent, BoxLeft, BoxTop, BoxRight, BoxBottom, C.black, 1, 3)

        local Label = Draw.Text(Context.Parent, Left + METRIC.checkbox_label, Row, C.text_dim, Name, "reg", 1, 3)
        local GradientColor = Gradient:FindFirstChildOfClass("UIGradient")

        local Hover = HoverChannel(Hitbox)
        local Checked = Value and 1 or 0

        local Toggle = {
            Name = Name,
            Flag = Flag,
            Value = Value,
            Section = SectionRef,
            Row = Row,
            Items = {
                Button = { Instance = Hitbox },
                Label = { Instance = Label },
            },
        }

        local function Apply()
            local IdleTop = LerpColor(C.checkbox_top, C.input_hover_top, Hover.Value)
            local Top = LerpColor(IdleTop, C.checked_top, Checked)
            local Bottom = LerpColor(C.checkbox_bottom, C.checked_bottom, Checked)

            GradientColor.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Top),
                ColorSequenceKeypoint.new(1, Bottom),
            })

            if Label then
                local IdleText = LerpColor(C.text_dim, C.text, Hover.Value)

                Label.TextColor3 = LerpColor(IdleText, C.text, Checked)
            end
        end

        local function SetValue(NewValue, Silent)
            Value = NewValue and true or false
            Toggle.Value = Value

            SetFlag(Flag, Value)

            if not Silent and Params.Callback then
                task.spawn(Params.Callback, Value)
            end
        end

        table.insert(Library.Updates, function(Delta)
            if not Hitbox.Parent then
                return
            end

            local NewHover = Anim.Approach("toggle_hover_" .. tostring(Toggle), Hover.Target, 16, Delta)
            local NewChecked = Anim.Approach("toggle_check_" .. tostring(Toggle), Value and 1 or 0, 16, Delta)

            if math.abs(NewHover - Hover.Value) > 0.0001 or math.abs(NewChecked - Checked) > 0.0001 then
                Hover.Value = NewHover
                Checked = NewChecked
                Apply()
            end
        end)

        Hitbox.MouseButton1Click:Connect(function()
            SetValue(not Value)
        end)

        function Toggle:Set(NewValue)
            NewValue = NewValue and true or false
            SetValue(NewValue, true)

            Checked = NewValue and 1 or 0
            Hover.Value = Hover.Value
            Apply()
        end

        Toggle.SetValue = Toggle.Set

        function Toggle:Get()
            return Value
        end

        function Toggle:Colorpicker(Options)
            Options = Options or {}
            Options.Name = Options.Name or Name
            Options.Row = Row

            if SectionRef and SectionRef.Spec then
                return SectionRef.Spec("Swatch", Options)
            end

            return Widgets.Swatch(Context, Options, SectionRef)
        end

        function Toggle:Keybind(Options)
            Options = Options or {}
            Options.Name = Options.Name or Name
            Options.Row = Row

            if SectionRef and SectionRef.Spec then
                return SectionRef.Spec("Keybind", Options)
            end

            return Widgets.Keybind(Context, Options, SectionRef)
        end

        function Toggle:Settings(Options)
            Options = Options or {}

            return Widgets.Settings(Context, Options, SectionRef, Row)
        end

        function Toggle:Popup(Options)
            Options = Options or {}

            return Widgets.Popup(Options, SectionRef, Row)
        end

        function Toggle:Tooltip(Text, Title)
            Tooltip(Toggle.Items.Button.Instance, Text, Title)
        end

        if Params.Tooltip then
            Tooltip(Toggle.Items.Button.Instance, Params.Tooltip, Params.TooltipTitle)
        end

        if Flag ~= nil then
            Library.SetFlags[Flag] = function(NewValue)
                Toggle:Set(NewValue)
            end
        end

        Apply()

        return Toggle
    end

    -- =====================================================================
    -- slider (widgets::slider_scalar)
    -- =====================================================================

    function Widgets.Slider(Context, Params, SectionRef)
        local Flag = Params.Flag
        local Range = type(Params.Range) == "table" and Params.Range or nil
        local Min = tonumber(Params.Min) or (Range and tonumber(Range[1])) or 0
        local Max = tonumber(Params.Max) or (Range and tonumber(Range[2])) or 100
        local Decimals = tonumber(Params.Decimals) or 0
        local Suffix = Params.Suffix or ""
        local Value = math.clamp(tonumber(GetFlag(Flag, Params.Default)) or Min, Min, Max)
        local Name = tostring(Params.Name or "")

        local LabelRow = TakeRow(Context, METRIC.slider_advance)
        local Top = LabelRow + METRIC.widget_offset
        local Left = Context.Left
        local Right = Context.Right
        local Bottom = Top + METRIC.slider_height - 1
        local InnerLeft = Left + 1
        local InnerWidth = Right - Left - 1

        Draw.Text(Context.Parent, Left + METRIC.label_indent, LabelRow, C.text, Name)

        local Frame = Draw.Gradient(Context.Parent, InnerLeft, Top + 1, Right - 1, Bottom - 1, C.track_top, C.track_bottom, 1, 3)
        Draw.Border(Context.Parent, Left, Top, Right, Bottom, C.black, 1, 3)

        local TrackGradient = Frame:FindFirstChildOfClass("UIGradient")
        local Fill = Draw.Gradient(Context.Parent, InnerLeft, Top + 1, InnerLeft, Bottom - 1, C.fill_top, C.fill_bottom, 1, 3)
        Fill.Visible = false

        local ValueLabel = Draw.TextCentered(Context.Parent, Left, Right, Top + 5, C.text, "0", "reg", 0, 4)

        ValueLabel.Visible = false

        local Hitbox = Instance.new("TextButton")
        Hitbox.Name = "\0"
        Hitbox.Text = ""
        Hitbox.AutoButtonColor = false
        Hitbox.BackgroundTransparency = 1
        Hitbox.BorderSizePixel = 0
        Hitbox.Position = UDim2.fromOffset(Left, Top - 2)
        Hitbox.Size = UDim2.fromOffset(Right - Left + 1, METRIC.slider_height + 4)
        Hitbox.ZIndex = 40
        Hitbox.Parent = Context.Parent

        local Hover = HoverChannel(Hitbox)
        local Shown = math.clamp((Value - Min) / (Max - Min), 0, 1)
        local Filled = math.floor(InnerWidth * Shown + 0.5)
        local HoverValue = 0
        local Held = false

        local function Format(Number)
            if Decimals > 0 then
                return string.format("%." .. Decimals .. "f", Number) .. Suffix
            end

            return string.format("%d", math.floor(Number + 0.5)) .. Suffix
        end

        local function Apply()
            local TrackTop = LerpColor(C.track_top, C.input_hover_top, Hover.Value * 0.6)

            TrackGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, TrackTop),
                ColorSequenceKeypoint.new(1, C.track_bottom),
            })

            Filled = math.floor(InnerWidth * Shown + 0.5)

            if Filled > 0 then
                local FillRight = InnerLeft + Filled - 1
                local FillTop = LerpColor(C.fill_top, C.checked_top, Hover.Value * 0.4)

                Fill.Visible = true
                Fill.Position = UDim2.fromOffset(InnerLeft, Top + 1)
                Fill.Size = UDim2.fromOffset(math.max(1, FillRight - InnerLeft + 1), METRIC.slider_height - 2)

                local FillGradient = Fill:FindFirstChildOfClass("UIGradient")

                FillGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, FillTop),
                    ColorSequenceKeypoint.new(1, C.fill_bottom),
                })
            else
                Fill.Visible = false
            end

            ValueLabel.Text = Format(Value)
            ValueLabel.TextTransparency = 1 - Hover.Value
            ValueLabel.Visible = Hover.Value > 0.002
        end

        local function SetFromMouse()
            if Max <= Min then
                return
            end

            local Mouse = Library:MousePoint()
            local Frac = math.clamp((Mouse.X - (Hitbox.AbsolutePosition.X + 1)) / InnerWidth, 0, 1)
            local Scaled = Min + (Max - Min) * Frac
            local Next

            if Decimals > 0 then
                local Mult = 10 ^ Decimals
                Next = math.floor(Scaled * Mult + 0.5) / Mult
            else
                Next = math.floor(Scaled + 0.5)
            end

            if Next ~= Value then
                Value = Next

                SetFlag(Flag, Value)

                if Params.Callback then
                    task.spawn(Params.Callback, Value)
                end
            end
        end

        Hitbox.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1
                or Input.UserInputType == Enum.UserInputType.Touch
            then
                Held = true
                SetFromMouse()
            end
        end)

        Connect(UserInputService.InputEnded, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1
                or Input.UserInputType == Enum.UserInputType.Touch
            then
                Held = false
            end
        end)

        Connect(UserInputService.InputChanged, function(Input)
            if not Held then
                return
            end

            -- a release outside the window can swallow InputEnded; never let a
            -- slider follow the cursor after the button is already up
            local Ok, Down = pcall(function()
                return UserInputService:IsMouseButtonPressed(Enum.UserInputButton.MouseButton1)
            end)

            if Ok and not Down then
                Held = false
                return
            end

            if Input.UserInputType == Enum.UserInputType.MouseMovement
                or Input.UserInputType == Enum.UserInputType.Touch
            then
                SetFromMouse()
            end
        end)

        table.insert(Library.Updates, function(Delta)
            if not Hitbox.Parent then
                return
            end

            local Target = math.clamp((Value - Min) / (Max - Min), 0, 1)
            local NewShown = Anim.Approach("slider_value_" .. tostring(Hitbox), Target, Held and 30 or 14, Delta)
            local NewHover = Anim.Approach("slider_hover_" .. tostring(Hitbox), Hover.Target, 16, Delta)

            if math.abs(NewShown - Shown) > 0.0001 or math.abs(NewHover - Hover.Value) > 0.0001 then
                Shown = NewShown
                Hover.Value = NewHover
                Apply()
            end
        end)

        local Slider = {
            Name = Name,
            Flag = Flag,
            Section = SectionRef,
            Items = {
                Hitbox = { Instance = Hitbox },
                Fill = { Instance = Fill },
            },
        }

        function Slider:Set(NewValue)
            Value = math.clamp(tonumber(NewValue) or Value, Min, Max)
            SetFlag(Flag, Value)
            Apply()
        end

        function Slider:Get()
            return Value
        end

        Apply()

        if Flag ~= nil then
            Library.SetFlags[Flag] = function(NewValue)
                Slider:Set(NewValue)
            end

            SetFlag(Flag, Value)
        end

        return Slider
    end
    -- =====================================================================
    -- key names (widgets::format_key)
    -- =====================================================================

    local KEY_NAMES = {
        Backspace = "back",
        Escape = "escape",
        Return = "return",
        Space = "space",
        LeftShift = "leftshift",
        RightShift = "rightshift",
        LeftControl = "leftcontrol",
        RightControl = "rightcontrol",
        LeftAlt = "leftalt",
        RightAlt = "rightalt",
        Tab = "tab",
        Delete = "delete",
        Insert = "insert",
    }

    function Library.FormatKey(Key)
        if Key == nil or Key == Enum.KeyCode.Unknown then
            return "-"
        end

        if type(Key) == "string" then
            return string.lower(Key)
        end

        if Key == Enum.UserInputType.MouseButton1 or Key == Enum.KeyCode.MouseButton1 then
            return "m1"
        elseif Key == Enum.UserInputType.MouseButton2 or Key == Enum.KeyCode.MouseButton2 then
            return "m2"
        elseif Key == Enum.UserInputType.MouseButton3 or Key == Enum.KeyCode.MouseButton3 then
            return "m3"
        end

        local Name = typeof(Key) == "EnumItem" and Key.Name or tostring(Key)

        -- executors expose extra mouse buttons under several names
        if Name == "MouseButton4" or Name == "MouseX1" then
            return "m4"
        elseif Name == "MouseButton5" or Name == "MouseX2" then
            return "m5"
        end

        return string.lower(KEY_NAMES[Name] or Name)
    end

    local function NormalizeKey(Key)
        if typeof(Key) == "EnumItem" then
            return Key
        end

        if type(Key) == "string" then
            local Lower = string.lower(Key)

            -- neither Roblox nor every executor has m4/m5 enums; keep the name
            if Lower == "m4" or Lower == "m5" then
                return Lower
            end

            local Name = Key:match("^Enum%.UserInputType%.(.+)$")

            if Name then
                local OkType, InputType = pcall(function()
                    return Enum.UserInputType[Name]
                end)

                if OkType then
                    return InputType
                end
            end

            local CodeName = Key:match("^Enum%.KeyCode%.(.+)$")
            local Ok, EnumItem = pcall(function()
                return Enum.KeyCode[CodeName or Key]
            end)

            if Ok and EnumItem ~= Enum.KeyCode.Unknown then
                return EnumItem
            end

            local OkInput, InputType = pcall(function()
                return Enum.UserInputType[Key]
            end)

            if OkInput then
                return InputType
            end
        end

        return Enum.KeyCode.Unknown
    end

    -- =====================================================================
    -- dropdown (widgets::combo / multi_combo)
    -- =====================================================================

    local function SelectionFromFlag(Value, Items, Multi)
        if Multi then
            local Set = {}

            if type(Value) == "table" then
                if Value[1] ~= nil then
                    for _, Item in Value do
                        Set[tostring(Item)] = true
                    end
                else
                    for Item, Enabled in Value do
                        if Enabled == true then
                            Set[tostring(Item)] = true
                        end
                    end
                end
            end

            return Set
        end

        if type(Value) == "string" then
            return Value
        end

        if type(Value) == "number" then
            return Items[Value]
        end

        return nil
    end

    function Widgets.Dropdown(Context, Params, SectionRef)
        local Items = Params.Options or Params.Items or {}
        local Multi = Params.Multi and true or false
        local Flag = Params.Flag
        local Name = tostring(Params.Name or "")

        local Selected = SelectionFromFlag(GetFlag(Flag, Params.Default), Items, Multi)

        if not Multi and Selected == nil and Items[1] then
            Selected = Items[1]
        end

        local LabelRow = TakeRow(Context, METRIC.combo_advance)
        local Top = LabelRow + METRIC.widget_offset
        local Left = Context.Left
        local Right = Context.Right
        local Bottom = Top + METRIC.combo_height - 1

        Draw.Text(Context.Parent, Left + METRIC.label_indent, LabelRow, C.text, Name)

        local Frame = Draw.Gradient(Context.Parent, Left + 1, Top + 1, Right - 1, Bottom - 1, C.input_top, C.input_bottom, 1, 3)
        local FrameGradient = Frame:FindFirstChildOfClass("UIGradient")

        Draw.Border(Context.Parent, Left, Top, Right, Bottom, C.black, 1, 3)

        local Clip = Instance.new("Frame")
        Clip.Name = "\0"
        Clip.BackgroundTransparency = 1
        Clip.BorderSizePixel = 0
        Clip.ClipsDescendants = true
        Clip.Position = UDim2.fromOffset(Left + 1, Top)
        Clip.Size = UDim2.fromOffset(math.max(0, Right - 11 - (Left + 1)), METRIC.combo_height)
        Clip.ZIndex = 4
        Clip.Parent = Context.Parent

        local PreviewLabel


        local ArrowHolder = Instance.new("Frame")
        ArrowHolder.Name = "\0"
        ArrowHolder.BackgroundTransparency = 1
        ArrowHolder.BorderSizePixel = 0
        ArrowHolder.Position = UDim2.fromOffset(Left, Top)
        ArrowHolder.Size = UDim2.fromOffset(Right - Left + 1, METRIC.combo_height)
        ArrowHolder.ZIndex = 4
        ArrowHolder.Parent = Context.Parent

        local Arrow = Instance.new("Frame")
        Arrow.Name = "\0"
        Arrow.BackgroundTransparency = 1
        Arrow.BorderSizePixel = 0
        Arrow.Size = UDim2.fromOffset(Right - Left + 1, METRIC.combo_height)
        Arrow.ZIndex = 4
        Arrow.Parent = ArrowHolder

        local Hitbox = Instance.new("TextButton")
        Hitbox.Name = "\0"
        Hitbox.Text = ""
        Hitbox.AutoButtonColor = false
        Hitbox.BackgroundTransparency = 1
        Hitbox.BorderSizePixel = 0
        Hitbox.Position = UDim2.fromOffset(Left, Top)
        Hitbox.Size = UDim2.fromOffset(Right - Left + 1, METRIC.combo_height)
        Hitbox.ZIndex = 40
        Hitbox.Parent = Context.Parent

        local Hover = HoverChannel(Hitbox)
        local OpenAmount = 0
        local PopupFrame = nil
        local PopupAbove = false
        local PopupHeight = #Items * METRIC.dropdown_item + 2
        local Open = false

        local Dropdown

        local function PreviewText()
            if Multi then
                local Parts = {}

                for _, Item in Items do
                    if Selected[Item] then
                        table.insert(Parts, Item)
                    end
                end

                if #Parts == 0 then
                    return "None", C.text_dim
                end

                return table.concat(Parts, ", "), C.text
            end

            if Selected == nil then
                return "None", C.text_dim
            end

            return tostring(Selected), C.text
        end

        local function RefreshPreview()
            local Text, Color = PreviewText()

            -- a raw TextLabel centers on the font line height, which sits low
            -- inside the 16px track; Draw.Text uses the source's row math
            if PreviewLabel then
                PreviewLabel:Destroy()
            end

            PreviewLabel = Draw.Text(
                Clip,
                METRIC.combo_text_indent - 1,
                math.floor(METRIC.combo_height / 2),
                Color,
                Text,
                "reg",
                1,
                4
            )
        end

        local function DrawArrow()
            Arrow:ClearAllChildren()
            RenderArrow(Arrow, Right - Left, 0, OpenAmount, 2)
        end

        local function ClosePopup()
            Open = false

            if PopupFrame then
                PopupFrame:Destroy()
                PopupFrame = nil
            end

            DrawArrow()
        end

        local function OpenPopup()
            if Open or #Items == 0 then
                return
            end

            Open = true

            local DisplaySizeNow = DisplaySize()
            local X = Hitbox.AbsolutePosition.X
            local Y = Hitbox.AbsolutePosition.Y + METRIC.combo_height - 1 + 2
            local Width = Right - Left + 1

            PopupAbove = false

            if Y + PopupHeight > DisplaySizeNow.Y then
                Y = Hitbox.AbsolutePosition.Y - PopupHeight - 1
                PopupAbove = true
            end

            local Frame2 = Instance.new("Frame")
            Frame2.Name = "\0"
            Frame2.BackgroundTransparency = 1
            Frame2.BorderSizePixel = 0
            Frame2.Position = UDim2.fromOffset(math.floor(X), math.floor(Y))
            Frame2.Size = UDim2.fromOffset(Width, PopupHeight)
            Frame2.ZIndex = 10
            Frame2.Parent = Library.Layers.Popups.Instance

            PopupFrame = Frame2

            Draw.Border(Frame2, 0, 0, Width - 1, PopupHeight - 1, C.black)
            Draw.Fill(Frame2, 1, 1, Width - 2, PopupHeight - 2, C.input_bottom)

            for Index, Item in Items do
                local ItemTop = 1 + (Index - 1) * METRIC.dropdown_item
                local ItemBox = { left = 1, top = ItemTop, right = Width - 2, bottom = ItemTop + METRIC.dropdown_item - 1 }

                local Button = Instance.new("TextButton")
                Button.Name = "\0"
                Button.Text = ""
                Button.AutoButtonColor = false
                Button.BackgroundTransparency = 1
                Button.BorderSizePixel = 0
                Button.Position = UDim2.fromOffset(ItemBox.left, ItemBox.top)
                Button.Size = UDim2.fromOffset(ItemBox.right - ItemBox.left + 1, ItemBox.bottom - ItemBox.top + 1)
                Button.ZIndex = 12
                Button.Parent = Frame2

                local Gradient = Draw.Gradient(
                    Frame2,
                    ItemBox.left,
                    ItemBox.top,
                    ItemBox.right,
                    ItemBox.bottom,
                    C.input_hover_top,
                    C.input_hover_bottom,
                    0,
                    11
                )

                local ItemSelected = Multi and Selected[Item] or (Selected == Item)
                local ItemLabel = Draw.Text(
                    Frame2,
                    ItemBox.left + METRIC.combo_text_indent - 1,
                    ItemBox.top + 7,
                    ItemSelected and C.text or C.text_dim,
                    tostring(Item),
                    "reg",
                    1,
                    12
                )

                local ItemHover = 0
                local Pick = ItemSelected and 1 or 0

                Button.MouseEnter:Connect(function()
                    ItemHover = 1
                end)

                Button.MouseLeave:Connect(function()
                    ItemHover = 0
                end)

                Button.MouseButton1Click:Connect(function()
                    if Multi then
                        Selected[Item] = not Selected[Item]
                        Pick = Selected[Item] and 1 or 0

                        local Out = {}

                        for _, Each in Items do
                            if Selected[Each] then
                                table.insert(Out, Each)
                            end
                        end

                        SetFlag(Flag, Selected)
                        RefreshPreview()

                        if Params.Callback then
                            task.spawn(Params.Callback, Out, Selected)
                        end
                    else
                        Selected = Item
                        SetFlag(Flag, Selected)
                        RefreshPreview()

                        if Params.Callback then
                            task.spawn(Params.Callback, Selected)
                        end

                        ClosePopup()
                    end
                end)

                table.insert(Library.Updates, function()
                    if not Button.Parent then
                        return
                    end

                    Gradient.BackgroundTransparency = 1 - ItemHover
                    ItemLabel.TextColor3 = LerpColor(C.text_dim, C.text, math.max(Pick, ItemHover))
                end)
            end

            DrawArrow()
        end

        Hitbox.MouseButton1Click:Connect(function()
            if Open then
                ClosePopup()
            else
                OpenPopup()
            end
        end)

        local ClosedByOutside = false

        Connect(UserInputService.InputBegan, function(Input)
            if not Open then
                return
            end

            if Input.UserInputType ~= Enum.UserInputType.MouseButton1
                and Input.UserInputType ~= Enum.UserInputType.Touch
            then
                return
            end

            local Point = Library:MousePoint()

            if PopupFrame then
                local Position = PopupFrame.AbsolutePosition
                local Size = PopupFrame.AbsoluteSize

                if Point.X >= Position.X and Point.X <= Position.X + Size.X
                    and Point.Y >= Position.Y and Point.Y <= Position.Y + Size.Y
                then
                    return
                end
            end

            if Library:IsMouseOverFrame(Hitbox) then
                return
            end

            ClosePopup()
        end)

        table.insert(Library.Updates, function(Delta)
            if not Hitbox.Parent then
                ClosePopup()
                return
            end

            local NewHover = Anim.Approach("combo_hover_" .. tostring(Hitbox), Hover.Target, 16, Delta)
            local NewOpen = Anim.Approach("combo_open_" .. tostring(Hitbox), Open and 1 or 0, 18, Delta)

            if math.abs(NewHover - Hover.Value) > 0.0001 then
                Hover.Value = NewHover

                local TopColor = LerpColor(C.input_top, C.input_hover_top, Hover.Value)
                local BottomColor = LerpColor(C.input_bottom, C.input_hover_bottom, Hover.Value)

                FrameGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, TopColor),
                    ColorSequenceKeypoint.new(1, BottomColor),
                })
            end

            if math.abs(NewOpen - OpenAmount) > 0.0001 then
                OpenAmount = NewOpen
                DrawArrow()
            end
        end)

        Dropdown = {
            Name = Name,
            Flag = Flag,
            Section = SectionRef,
            Items = {},
            Value = Selected,
        }

        function Dropdown:Set(Value)
            if Multi then
                Selected = SelectionFromFlag(Value, Items, true)
            else
                Selected = tostring(Value)
            end

            SetFlag(Flag, Selected)
            RefreshPreview()
        end

        function Dropdown:Get()
            return Selected
        end

        function Dropdown:Open()
            OpenPopup()
        end

        function Dropdown:Close()
            ClosePopup()
        end

        SetFlag(Flag, Selected)
        RefreshPreview()
        DrawArrow()

        if Flag ~= nil then
            Library.SetFlags[Flag] = function(Value)
                Dropdown:Set(Value)
            end
        end

        return Dropdown
    end

    -- =====================================================================
    -- textbox (tools.cpp text_field)
    -- =====================================================================

    function Widgets.Textbox(Context, Params, SectionRef)
        local Flag = Params.Flag
        local Value = GetFlag(Flag, Params.Default)

        if type(Value) ~= "string" then
            Value = ""
        end

        local Row = TakeRow(Context, METRIC.button_advance)
        local Left = Context.Left
        local Right = Context.Right
        local Top = Row - 7
        local Bottom = Top + METRIC.button_height - 1

        local Frame = Draw.Gradient(Context.Parent, Left + 1, Top + 1, Right - 1, Bottom - 1, C.input_top, C.input_bottom, 1, 3)
        local FrameGradient = Frame:FindFirstChildOfClass("UIGradient")

        Draw.Border(Context.Parent, Left, Top, Right, Bottom, C.black, 1, 3)

        local Box = Instance.new("TextBox")
        Box.Name = "\0"
        Box.BackgroundTransparency = 1
        Box.BorderSizePixel = 0
        Box.FontFace = FONTS.reg.face
        Box.TextSize = FONTS.reg.size
        Box.TextColor3 = C.text
        Box.PlaceholderColor3 = C.text_dim
        Box.PlaceholderText = tostring(Params.Placeholder or "")
        Box.Text = Value
        Box.TextXAlignment = Enum.TextXAlignment.Left
        Box.TextYAlignment = Enum.TextYAlignment.Center
        Box.ClearTextOnFocus = false
        Box.MultiLine = false
        Box.ClipsDescendants = true
        Box.Position = UDim2.fromOffset(Left + 5, Top + 1)
        Box.Size = UDim2.fromOffset(Right - Left - 9, METRIC.button_height - 2)
        Box.ZIndex = 5
        Box.Parent = Context.Parent

        local Hover = HoverChannel(Box)

        local Textbox = {
            Name = tostring(Params.Name or ""),
            Flag = Flag,
            Section = SectionRef,
            Items = { Box = { Instance = Box } },
        }

        local function Apply()
            local TopColor = LerpColor(C.input_top, C.input_hover_top, Hover.Value)
            local BottomColor = LerpColor(C.input_bottom, C.input_hover_bottom, Hover.Value)

            FrameGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, TopColor),
                ColorSequenceKeypoint.new(1, BottomColor),
            })
        end

        Box.Focused:Connect(function()
            Hover.Target = 1
        end)

        Box.FocusLost:Connect(function()
            Hover.Target = 0

            Value = Box.Text
            SetFlag(Flag, Value)

            if Params.Finished then
                task.spawn(Params.Finished, Value)
            end

            if Params.Callback then
                task.spawn(Params.Callback, Value)
            end
        end)

        Box:GetPropertyChangedSignal("Text"):Connect(function()
            Value = Box.Text
            SetFlag(Flag, Value)

            if Params.Callback then
                task.spawn(Params.Callback, Value)
            end
        end)

        table.insert(Library.Updates, function(Delta)
            if not Box.Parent then
                return
            end

            local NewHover = Anim.Approach("textbox_hover_" .. tostring(Box), Hover.Target, 16, Delta)

            if math.abs(NewHover - Hover.Value) > 0.0001 then
                Hover.Value = NewHover
                Apply()
            end
        end)

        function Textbox:Set(NewValue)
            Value = tostring(NewValue)
            Box.Text = Value
            SetFlag(Flag, Value)
        end

        function Textbox:Get()
            return Value
        end

        Apply()

        if Flag ~= nil then
            Library.SetFlags[Flag] = function(NewValue)
                Textbox:Set(NewValue)
            end

            SetFlag(Flag, Value)
        end

        return Textbox
    end

    -- =====================================================================
    -- button (widgets::button)
    -- =====================================================================

    function Widgets.Button(Context, Params, SectionRef)
        local Name = tostring(Params.Name or "")
        local Row = TakeRow(Context, METRIC.button_advance)
        local Left = Context.Left
        local Right = Context.Right
        local Top = Row - 7
        local Bottom = Top + METRIC.button_height - 1

        local Frame = Draw.Gradient(Context.Parent, Left + 1, Top + 1, Right - 1, Bottom - 1, C.input_top, C.input_bottom, 1, 3)
        local FrameGradient = Frame:FindFirstChildOfClass("UIGradient")

        Draw.Border(Context.Parent, Left, Top, Right, Bottom, C.black, 1, 3)
        Draw.TextCentered(Context.Parent, Left, Right, Top + 8, C.text, Name, "reg", 1, 4)

        local Hitbox = Instance.new("TextButton")
        Hitbox.Name = "\0"
        Hitbox.Text = ""
        Hitbox.AutoButtonColor = false
        Hitbox.BackgroundTransparency = 1
        Hitbox.BorderSizePixel = 0
        Hitbox.Position = UDim2.fromOffset(Left, Top)
        Hitbox.Size = UDim2.fromOffset(Right - Left + 1, METRIC.button_height)
        Hitbox.ZIndex = 40
        Hitbox.Parent = Context.Parent

        local Hover = HoverChannel(Hitbox)
        local Button = {
            Name = Name,
            Section = SectionRef,
            Items = { Button = { Instance = Hitbox } },
        }

        local function Apply()
            local TopColor = LerpColor(C.input_top, C.input_hover_top, Hover.Value)
            local BottomColor = LerpColor(C.input_bottom, C.input_hover_bottom, Hover.Value)

            FrameGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, TopColor),
                ColorSequenceKeypoint.new(1, BottomColor),
            })
        end

        table.insert(Library.Updates, function(Delta)
            if not Hitbox.Parent then
                return
            end

            local NewHover = Anim.Approach("button_hover_" .. tostring(Hitbox), Hover.Target, 16, Delta)

            if math.abs(NewHover - Hover.Value) > 0.0001 then
                Hover.Value = NewHover
                Apply()
            end
        end)

        Hitbox.MouseButton1Click:Connect(function()
            if Params.Confirm then
                local Confirm = Instance.new("TextButton")
                Confirm.Name = "\0"
                Confirm.Text = ""
                Confirm.AutoButtonColor = false
                Confirm.BackgroundTransparency = 1
                Confirm.BorderSizePixel = 0
                Confirm.Position = UDim2.fromOffset(Left, Top)
                Confirm.Size = UDim2.fromOffset(Right - Left + 1, METRIC.button_height)
                Confirm.ZIndex = 6
                Confirm.Parent = Context.Parent

                Draw.Border(Confirm, Left, Top, Right, Bottom, C.black, 1, 6)
                Draw.Fill(Confirm, Left + 1, Top + 1, Right - 1, Bottom - 1, C.input_bottom, 1, 6)
                Draw.TextCentered(Context.Parent, Left, Right, Top + 8, C.text, tostring(Params.ConfirmText or "Are you sure?"), "reg", 1, 7)

                local Timer = Params.ConfirmTime or 2

                Confirm.MouseButton1Click:Connect(function()
                    Confirm:Destroy()

                    if Params.Callback then
                        task.spawn(Params.Callback)
                    end
                end)

                task.delay(Timer, function()
                    if Confirm.Parent then
                        Confirm:Destroy()
                    end
                end)
            elseif Params.Callback then
                task.spawn(Params.Callback)
            end
        end)

        Apply()

        if Params.Tooltip then
            Tooltip(Button, Params.Tooltip, Params.TooltipTitle)
        end

        return Button
    end

    -- =====================================================================
    -- keybind (widgets::keybind)
    -- =====================================================================

    local ListeningKeybind = nil

    function Widgets.Keybind(Context, Params, SectionRef)
        local Flag = Params.Flag
        local Name = tostring(Params.Name or "")
        local Row = Params.Row or Context.LastRow
        local Left, Right = PlaceInline(Context, METRIC.keybind_width, METRIC.inline_gap)
        local Top = Row - 6
        local Bottom = Top + METRIC.keybind_height - 1

        local Stored = GetFlag(Flag, nil)
        local Key = NormalizeKey(type(Stored) == "table" and Stored.Key or Params.Default)
        local Mode = (type(Stored) == "table" and Stored.Mode) or Params.Mode or "Hold"

        local Frame = Draw.Gradient(Context.Parent, Left + 1, Top + 1, Right - 1, Bottom - 1, C.input_top, C.input_bottom, 1, 4)
        local FrameGradient = Frame:FindFirstChildOfClass("UIGradient")

        Draw.Border(Context.Parent, Left, Top, Right, Bottom, C.black, 1, 4)

        local Hitbox = Instance.new("TextButton")
        Hitbox.Name = "\0"
        Hitbox.Text = ""
        Hitbox.AutoButtonColor = false
        Hitbox.BackgroundTransparency = 1
        Hitbox.BorderSizePixel = 0
        Hitbox.Position = UDim2.fromOffset(Left, Top)
        Hitbox.Size = UDim2.fromOffset(Right - Left + 1, METRIC.keybind_height)
        Hitbox.ZIndex = 40
        Hitbox.Parent = Context.Parent

        local Label = Draw.TextCentered(Context.Parent, Left, Right, Row, C.text_dim, "-", "reg", 1, 5)
        local Hover = HoverChannel(Hitbox)
        local Listening = false
        local ModePopup = nil
        local ModeOpen = false
        local ModeReveal = 0

        local Keybind = {
            Name = tostring(Params.Name or ""),
            Flag = Flag,
            Section = SectionRef,
            Key = Key,
            Mode = Mode,
            Items = { Hitbox = { Instance = Hitbox } },
        }

        local function Store()
            local Value = { Key = Key, Mode = Mode }

            SetFlag(Flag, Value)

            Keybind.Key = Key
            Keybind.Mode = Mode

            if Params.Callback then
                task.spawn(Params.Callback, Value)
            end

            if Library.KeyList then
                Library.KeyList:Refresh()
            end
        end

        local function Paint()
            if Listening then
                local Pulse = 0.5 + 0.5 * math.sin((os.clock() - Library.StartTime) * 6)

                Label.Text = "..."
                Label.TextColor3 = LerpColor(C.text_dim, C.text, Pulse)
            else
                Label.Text = Library.FormatKey(Key)
                Label.TextColor3 = LerpColor(C.text_dim, C.text, Hover.Value)
            end

            local TopColor = LerpColor(C.input_top, C.input_hover_top, Hover.Value)
            local BottomColor = LerpColor(C.input_bottom, C.input_hover_bottom, Hover.Value)

            FrameGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, TopColor),
                ColorSequenceKeypoint.new(1, BottomColor),
            })
        end

        local function CloseMode()
            ModeOpen = false

            if ModePopup then
                ModePopup:Destroy()
                ModePopup = nil
            end
        end

        local function OpenMode()
            if ModeOpen then
                return
            end

            ModeOpen = true

            local DisplaySizeNow = DisplaySize()
            local Width = METRIC.key_mode_width
            local Height = 3 * METRIC.dropdown_item + 2
            local X = Hitbox.AbsolutePosition.X + (Right - Left + 1) - Width
            local Y = Hitbox.AbsolutePosition.Y + METRIC.keybind_height - 1 + 2

            if Y + Height > DisplaySizeNow.Y then
                Y = Hitbox.AbsolutePosition.Y - Height - 1
            end

            local Popup = Instance.new("Frame")
            Popup.Name = "\0"
            Popup.BackgroundTransparency = 1
            Popup.BorderSizePixel = 0
            Popup.Position = UDim2.fromOffset(math.floor(X), math.floor(Y))
            Popup.Size = UDim2.fromOffset(Width, Height)
            Popup.ZIndex = 10
            Popup.Parent = Library.Layers.Popups.Instance

            ModePopup = Popup

            Draw.Border(Popup, 0, 0, Width - 1, Height - 1, C.black)
            Draw.Fill(Popup, 1, 1, Width - 2, Height - 2, C.input_bottom)

            for Index, Name in { "Hold", "Toggle", "Always" } do
                local ItemTop = 1 + (Index - 1) * METRIC.dropdown_item

                local Button = Instance.new("TextButton")
                Button.Name = "\0"
                Button.Text = ""
                Button.AutoButtonColor = false
                Button.BackgroundTransparency = 1
                Button.BorderSizePixel = 0
                Button.Position = UDim2.fromOffset(1, ItemTop)
                Button.Size = UDim2.fromOffset(Width - 2, METRIC.dropdown_item)
                Button.ZIndex = 12
                Button.Parent = Popup

                local Gradient = Draw.Gradient(Popup, 1, ItemTop, Width - 2, ItemTop + METRIC.dropdown_item - 1, C.input_hover_top, C.input_hover_bottom, 0, 11)
                local ItemLabel = Draw.Text(Popup, 3, ItemTop + 7, Mode == Name and C.text or C.text_dim, Name, "reg", 1, 12)
                local ItemHover = 0
                local Pick = Mode == Name and 1 or 0

                Button.MouseEnter:Connect(function()
                    ItemHover = 1
                end)

                Button.MouseLeave:Connect(function()
                    ItemHover = 0
                end)

                Button.MouseButton1Click:Connect(function()
                    Mode = Name
                    CloseMode()
                    Store()
                    Paint()
                end)

                table.insert(Library.Updates, function()
                    if not Button.Parent then
                        return
                    end

                    Gradient.BackgroundTransparency = 1 - ItemHover
                    ItemLabel.TextColor3 = LerpColor(C.text_dim, C.text, math.max(Pick, ItemHover))
                end)
            end
        end

        Hitbox.MouseButton1Click:Connect(function()
            if Listening then
                Listening = false
                ListeningKeybind = nil
            else
                Listening = true
                ListeningKeybind = Keybind
            end

            Paint()
        end)

        Hitbox.MouseButton2Click:Connect(function()
            OpenMode()
        end)

        Connect(UserInputService.InputBegan, function(Input)
            if not Listening or ListeningKeybind ~= Keybind then
                return
            end

            if Input.UserInputType == Enum.UserInputType.Keyboard then
                if Input.KeyCode == Enum.KeyCode.Escape then
                    Key = Enum.KeyCode.Unknown
                else
                    Key = Input.KeyCode
                end

                Listening = false
                ListeningKeybind = nil

                Store()
                Paint()
            else
                -- bind mouse buttons too (m1..m5 depending on the executor)
                local Formatted = Library.FormatKey(Input.UserInputType)

                if Formatted == "m1" or Formatted == "m2" or Formatted == "m3"
                    or Formatted == "m4" or Formatted == "m5"
                then
                    Key = Input.UserInputType

                    Listening = false
                    ListeningKeybind = nil

                    Store()
                    Paint()
                end
            end
        end)

        Connect(UserInputService.InputBegan, function(Input)
            if not ModeOpen then
                return
            end

            if Input.UserInputType ~= Enum.UserInputType.MouseButton1
                and Input.UserInputType ~= Enum.UserInputType.Touch
            then
                return
            end

            local Point = Library:MousePoint()

            if ModePopup then
                local Position = ModePopup.AbsolutePosition
                local Size = ModePopup.AbsoluteSize

                if Point.X >= Position.X and Point.X <= Position.X + Size.X
                    and Point.Y >= Position.Y and Point.Y <= Position.Y + Size.Y
                then
                    return
                end
            end

            if Library:IsMouseOverFrame(Hitbox) then
                return
            end

            CloseMode()
        end)

        table.insert(Library.Updates, function(Delta)
            if not Hitbox.Parent then
                CloseMode()
                return
            end

            local NewHover = Anim.Approach("keybind_hover_" .. tostring(Hitbox), Hover.Target, 16, Delta)

            if math.abs(NewHover - Hover.Value) > 0.0001 or Listening then
                Hover.Value = NewHover
                Paint()
            end
        end)

        function Keybind:Set(Value)
            if type(Value) == "table" then
                Key = NormalizeKey(Value.Key)
                Mode = Value.Mode or Mode
            else
                Key = NormalizeKey(Value)
            end

            SetFlag(Flag, { Key = Key, Mode = Mode })
            Paint()
        end

        function Keybind:Get()
            return { Key = Key, Mode = Mode }
        end

        Library.KeybindWidgets = Library.KeybindWidgets or {}
        Library.KeybindWidgets[Flag or Name] = {
            Name = Params.Name or Name,
            Enabled = true,
            Get = function()
                return Key, Mode
            end,
        }

        if Library.SyncKeybinds then
            Library.SyncKeybinds()
        end

        SetFlag(Flag, { Key = Key, Mode = Mode })
        Paint()

        if Params.Tooltip then
            Tooltip(Keybind, Params.Tooltip, Params.TooltipTitle)
        end

        return Keybind
    end

    -- =====================================================================
    -- colour state
    -- =====================================================================

    local ColorMeta = {}
    ColorMeta.__index = ColorMeta

    function ColorMeta:ToHex()
        local r, g, b = Channels(self.Color)

        return string.format("%02X%02X%02X%02X", r, g, b, math.floor(math.clamp(self.Alpha, 0, 1) * 255 + 0.5))
    end

    function ColorMeta:Get()
        return self.Color, self.Alpha
    end

    local function NewColorObject(Color, Alpha)
        return setmetatable({
            Color = Color or Color3.fromRGB(255, 255, 255),
            Alpha = Alpha ~= nil and Alpha or 1,
        }, ColorMeta)
    end

    Library.NewColor = NewColorObject

    -- =====================================================================
    -- picker (picker.cpp)
    -- =====================================================================

    local function ParseHex(String)
        String = tostring(String or ""):gsub("^#", "")

        if #String ~= 6 and #String ~= 8 then
            return nil
        end

        local r = tonumber(String:sub(1, 2), 16)
        local g = tonumber(String:sub(3, 4), 16)
        local b = tonumber(String:sub(5, 6), 16)
        local a = #String == 8 and tonumber(String:sub(7, 8), 16) or 255

        if not r or not g or not b or not a then
            return nil
        end

        return Color3.fromRGB(r, g, b), a / 255
    end

    local RingMask = {
        " #### ",
        "#    #",
        "#    #",
        "#    #",
        "#    #",
        " #### ",
    }

    function Widgets.OpenPicker(Anchor, State, OnChange)
        local Width = 181
        local Height = 201
        local Screen = DisplaySize()

        local X = Anchor.AbsolutePosition.X + Anchor.AbsoluteSize.X - Width + 1
        local Y = Anchor.AbsolutePosition.Y + Anchor.AbsoluteSize.Y + 3

        if Y + Height > Screen.Y then
            Y = Anchor.AbsolutePosition.Y - Height - 2
        end

        X = math.clamp(X, 0, math.max(0, Screen.X - Width))
        Y = math.clamp(Y, 0, math.max(0, Screen.Y - Height))

        local Popup = Instance.new("Frame")
        Popup.Name = "\0"
        Popup.BackgroundTransparency = 1
        Popup.BorderSizePixel = 0
        Popup.Position = UDim2.fromOffset(math.floor(X), math.floor(Y))
        Popup.Size = UDim2.fromOffset(Width, Height)
        Popup.ZIndex = 20
        Popup.Parent = Library.Layers.Popups.Instance

        local Hue, Sat, Val = State.Color:ToHSV()

        if Sat <= 0 or Val <= 0 then
            Hue = 0
        end

        local SatArea = { left = 7, top = 7, right = 156, bottom = 156 }
        local HueArea = { left = 161, top = 7, right = 173, bottom = 156 }
        local AlphaArea = { left = 7, top = 161, right = 173, bottom = 173 }
        local Hex = { left = 7, top = 178, right = 153, bottom = 193 }
        local Paste = { left = 158, top = 178, right = 173, bottom = 193 }

        local SatInner = { left = SatArea.left + 2, top = SatArea.top + 2, right = SatArea.right - 2, bottom = SatArea.bottom - 2 }
        local HueInner = { left = HueArea.left + 2, top = HueArea.top + 2, right = HueArea.right - 2, bottom = HueArea.bottom - 2 }
        local AlphaInner = { left = AlphaArea.left + 2, top = AlphaArea.top + 2, right = AlphaArea.right - 2, bottom = AlphaArea.bottom - 2 }

        Draw.Panel(Popup, 0, 0, Width - 1, Height - 1)

        -- saturation / value
        Draw.FrameBox(Popup, SatArea.left, SatArea.top, SatArea.right, SatArea.bottom, C.black)

        local WhiteToHue = Draw.GradientH(
            Popup,
            SatInner.left,
            SatInner.top,
            SatInner.right,
            SatInner.bottom,
            Color3.fromRGB(255, 255, 255),
            Color3.fromHSV(Hue, 1, 1)
        )

        local WhiteToHueGradient = WhiteToHue:FindFirstChildOfClass("UIGradient")

        Draw.GradientAlpha(Popup, SatInner.left, SatInner.top, SatInner.right, SatInner.bottom, Color3.new(0, 0, 0), 0, 1)

        local SatMarker = Instance.new("Frame")
        SatMarker.Name = "\0"
        SatMarker.BackgroundTransparency = 1
        SatMarker.BorderSizePixel = 0
        SatMarker.Size = UDim2.fromOffset(6, 6)
        SatMarker.ZIndex = 22
        SatMarker.Parent = Popup

        -- hue
        Draw.FrameBox(Popup, HueArea.left, HueArea.top, HueArea.right, HueArea.bottom, C.black)

        local HueHeight = HueInner.bottom - HueInner.top + 1

        for Segment = 0, 5 do
            local Top = HueInner.top + math.floor(HueHeight * Segment / 6 + 0.5)
            local Bottom = HueInner.top + math.floor(HueHeight * (Segment + 1) / 6 + 0.5) - 1

            Draw.Gradient(
                Popup,
                HueInner.left,
                Top,
                HueInner.right,
                Bottom,
                Color3.fromHSV(Segment / 6, 1, 1),
                Color3.fromHSV((Segment + 1) / 6, 1, 1)
            )
        end

        local HueMarker = Draw.Fill(Popup, HueInner.left - 3, HueInner.top, HueInner.right + 3, HueInner.top + 1, C.marker, 1, 22)

        -- alpha
        Draw.FrameBox(Popup, AlphaArea.left, AlphaArea.top, AlphaArea.right, AlphaArea.bottom, C.black)

        Draw.Checker(Popup, AlphaInner.left, AlphaInner.top, AlphaInner.right, AlphaInner.bottom, 4, 4, C.picker_check_light, C.picker_check_dark)
        Draw.GradientFade(Popup, AlphaInner.left, AlphaInner.top, AlphaInner.right, AlphaInner.bottom, Color3.new(State.Color.R, State.Color.G, State.Color.B), 0, 1)

        local AlphaMarker = Draw.Fill(Popup, AlphaInner.left, AlphaArea.top - 1, AlphaInner.left + 1, AlphaArea.bottom + 1, C.marker, 1, 22)

        -- hex + paste
        Draw.FrameBox(Popup, Hex.left, Hex.top, Hex.right, Hex.bottom, C.input_bottom)
        local HexLabel = Draw.Text(Popup, Hex.left + 6, Hex.top + 8, C.text, "#" .. State:ToHex())

        Draw.FrameBox(Popup, Paste.left, Paste.top, Paste.right, Paste.bottom, C.input_bottom)

        local function Paint()
            WhiteToHueGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromHSV(Hue, 1, 1)),
            })

            local MarkerX = SatInner.left + math.floor(Sat * (SatInner.right - SatInner.left) + 0.5)
            local MarkerY = SatInner.top + math.floor((1 - Val) * (SatInner.bottom - SatInner.top) + 0.5)

            SatMarker.Position = UDim2.fromOffset(MarkerX - 2, MarkerY - 2)
            SatMarker:ClearAllChildren()
            Draw.Mask(SatMarker, 0, 0, RingMask, C.marker)

            local HueY = math.min(HueInner.top + math.floor(Hue * (HueInner.bottom - HueInner.top) + 0.5), HueInner.bottom - 1)

            HueMarker.Position = UDim2.fromOffset(HueInner.left - 3, HueY)
            HueMarker.Size = UDim2.fromOffset(HueInner.right - HueInner.left + 7, 2)

            AlphaMarker.Position = UDim2.fromOffset(
                AlphaInner.left + math.floor(State.Alpha * (AlphaInner.right - AlphaInner.left - 1) + 0.5),
                AlphaArea.top - 1
            )

            HexLabel.Text = "#" .. State:ToHex()
        end

        local function Commit()
            State.Color = Color3.fromHSV(Hue, Sat, Val)

            if OnChange then
                OnChange(State)
            end

            Paint()
        end

        local function Hotspot(Area, OnDrag)
            local Button = Instance.new("TextButton")
            Button.Name = "\0"
            Button.Text = ""
            Button.AutoButtonColor = false
            Button.BackgroundTransparency = 1
            Button.BorderSizePixel = 0
            Button.Position = UDim2.fromOffset(Area.left, Area.top)
            Button.Size = UDim2.fromOffset(Area.right - Area.left + 1, Area.bottom - Area.top + 1)
            Button.ZIndex = 30
            Button.Parent = Popup

            local Dragging = false

            local function Apply(Mouse)
                OnDrag(
                    math.clamp((Mouse.X - (Popup.AbsolutePosition.X + Area.left)) / (Area.right - Area.left), 0, 1),
                    math.clamp((Mouse.Y - (Popup.AbsolutePosition.Y + Area.top)) / (Area.bottom - Area.top), 0, 1)
                )
            end

            Button.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1
                    or Input.UserInputType == Enum.UserInputType.Touch
                then
                    Dragging = true
                    Apply(Library:MousePoint())
                end
            end)

            Connect(UserInputService.InputEnded, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1
                    or Input.UserInputType == Enum.UserInputType.Touch
                then
                    Dragging = false
                end
            end)

            Connect(UserInputService.InputChanged, function(Input)
                if not Dragging or not Popup.Parent then
                    return
                end

                if Input.UserInputType == Enum.UserInputType.MouseMovement
                    or Input.UserInputType == Enum.UserInputType.Touch
                then
                    Apply(Library:MousePoint())
                end
            end)
        end

        Hotspot(SatInner, function(FracX, FracY)
            Sat = FracX
            Val = 1 - FracY
            Commit()
        end)

        Hotspot(HueInner, function(_, FracY)
            Hue = math.min(FracY, 0.999)
            Commit()
        end)

        Hotspot(AlphaInner, function(FracX)
            State.Alpha = FracX

            if OnChange then
                OnChange(State)
            end

            Paint()
        end)

        local HexButton = Instance.new("TextButton")
        HexButton.Name = "\0"
        HexButton.Text = ""
        HexButton.AutoButtonColor = false
        HexButton.BackgroundTransparency = 1
        HexButton.BorderSizePixel = 0
        HexButton.Position = UDim2.fromOffset(Hex.left, Hex.top)
        HexButton.Size = UDim2.fromOffset(Hex.right - Hex.left + 1, Hex.bottom - Hex.top + 1)
        HexButton.ZIndex = 30
        HexButton.Parent = Popup

        HexButton.MouseButton1Click:Connect(function()
            local SetClipboard = SafeGlobal("setclipboard")

            if SetClipboard then
                pcall(SetClipboard, "#" .. State:ToHex())
            end
        end)

        local PasteButton = Instance.new("TextButton")
        PasteButton.Name = "\0"
        PasteButton.Text = ""
        PasteButton.AutoButtonColor = false
        PasteButton.BackgroundTransparency = 1
        PasteButton.BorderSizePixel = 0
        PasteButton.Position = UDim2.fromOffset(Paste.left, Paste.top)
        PasteButton.Size = UDim2.fromOffset(Paste.right - Paste.left + 1, Paste.bottom - Paste.top + 1)
        PasteButton.ZIndex = 30
        PasteButton.Parent = Popup

        PasteButton.MouseButton1Click:Connect(function()
            local GetClipboard = SafeGlobal("getclipboard")

            if not GetClipboard then
                return
            end

            local Ok, Value = pcall(GetClipboard)
            local Color, Alpha

            if Ok then
                Color, Alpha = ParseHex(Value)
            end

            if Color then
                local h, s, v = Color:ToHSV()

                Hue = (s <= 0 or v <= 0) and Hue or h
                Sat, Val = s, v
                State.Color = Color
                State.Alpha = Alpha

                Commit()
            end
        end)

        Connect(UserInputService.InputBegan, function(Input)
            if not Popup.Parent then
                return
            end

            if Input.UserInputType ~= Enum.UserInputType.MouseButton1
                and Input.UserInputType ~= Enum.UserInputType.Touch
            then
                return
            end

            local Point = Library:MousePoint()
            local Position = Popup.AbsolutePosition
            local Size = Popup.AbsoluteSize

            if Point.X >= Position.X and Point.X <= Position.X + Size.X
                and Point.Y >= Position.Y and Point.Y <= Position.Y + Size.Y
            then
                return
            end

            if Library:IsMouseOverFrame(Anchor) then
                return
            end

            Popup:Destroy()
        end)

        Paint()

        return Popup
    end

    -- =====================================================================
    -- colour swatch (widgets::color_swatch)
    -- =====================================================================

    function Widgets.Swatch(Context, Params, SectionRef)
        local Flag = Params.Flag
        local Row = Params.Row or Context.LastRow
        local Left, Right = PlaceInline(Context, METRIC.swatch_width, METRIC.swatch_gap)
        local Top = Row - 5
        local Bottom = Top + METRIC.swatch_height - 1

        local Stored = GetFlag(Flag, nil)
        local State

        if getmetatable(Stored) == ColorMeta then
            State = Stored
        elseif type(Stored) == "table" and Stored.Color then
            State = NewColorObject(Stored.Color, Stored.Alpha)
        else
            State = NewColorObject(Params.Default or Color3.fromRGB(255, 255, 255), Params.Alpha or 1)
        end

        local Frame = Instance.new("Frame")
        Frame.Name = "\0"
        Frame.BackgroundTransparency = 1
        Frame.BorderSizePixel = 0
        Frame.Position = UDim2.fromOffset(Left, Top)
        Frame.Size = UDim2.fromOffset(Right - Left + 1, METRIC.swatch_height)
        Frame.ZIndex = 4
        Frame.Parent = Context.Parent

        local function Paint()
            Frame:ClearAllChildren()

            local Inner = { left = 1, top = 1, right = Right - Left - 1, bottom = METRIC.swatch_height - 2 }

            if State.Alpha < 1 then
                Draw.Checker(Frame, Inner.left, Inner.top, Inner.right, Inner.bottom, 6, 4, C.checker_light, C.checker_dark)
                Draw.GradientAlpha(Frame, Inner.left, Inner.top, Inner.right, Inner.bottom, Color3.new(0, 0, 0), 0, 25 / 255)
            end

            local TopColor = Color3.new(State.Color.R, State.Color.G, State.Color.B)
            local BottomColor = Color3.new(State.Color.R * 0.8, State.Color.G * 0.8, State.Color.B * 0.8)

            Draw.Gradient(Frame, Inner.left, Inner.top, Inner.right, Inner.bottom, TopColor, BottomColor, State.Alpha)
            Draw.Border(Frame, 0, 0, Right - Left, METRIC.swatch_height - 1, C.black)
        end

        local Hitbox = Instance.new("TextButton")
        Hitbox.Name = "\0"
        Hitbox.Text = ""
        Hitbox.AutoButtonColor = false
        Hitbox.BackgroundTransparency = 1
        Hitbox.BorderSizePixel = 0
        Hitbox.Position = UDim2.fromOffset(0, 0)
        Hitbox.Size = UDim2.fromOffset(Right - Left + 1, METRIC.swatch_height)
        Hitbox.ZIndex = 40
        Hitbox.Parent = Frame

        Paint()

        Hitbox.MouseButton1Click:Connect(function()
            Widgets.OpenPicker(Frame, State, function()
                SetFlag(Flag, State)
                Paint()

                if Params.Callback then
                    task.spawn(Params.Callback, State.Color, State.Alpha)
                end
            end)
        end)

        local Swatch = {
            Name = tostring(Params.Name or ""),
            Flag = Flag,
            Section = SectionRef,
            Color = State.Color,
            Alpha = State.Alpha,
            Items = { Hitbox = { Instance = Hitbox } },
        }

        function Swatch:Set(Color, Alpha)
            State.Color = Color or State.Color

            if Alpha ~= nil then
                State.Alpha = Alpha
            end

            Swatch.Color = State.Color
            Swatch.Alpha = State.Alpha

            SetFlag(Flag, State)
            Paint()
        end

        function Swatch:Get()
            return State.Color, State.Alpha
        end

        SetFlag(Flag, State)

        if Flag ~= nil then
            Library.SetFlags[Flag] = function(Color, Alpha)
                if type(Color) == "table" then
                    Swatch:Set(Color.Color, Color.Alpha)
                else
                    Swatch:Set(Color, Alpha)
                end
            end
        end

        return Swatch
    end

    -- =====================================================================
    -- settings popup (widgets::begin_settings)
    -- =====================================================================

    function Widgets.Settings(Context, Params, SectionRef, Row)
        local Left, Right = PlaceInline(Context, METRIC.expand_size, METRIC.inline_gap)
        local Top = Row - 6
        local Bottom = Top + METRIC.expand_size - 1

        local Frame = Draw.Gradient(Context.Parent, Left + 1, Top + 1, Right - 1, Bottom - 1, C.input_top, C.input_bottom, 1, 4)
        local FrameGradient = Frame:FindFirstChildOfClass("UIGradient")

        Draw.Border(Context.Parent, Left, Top, Right, Bottom, C.black, 1, 4)

        local Plus = { "  #  ", "  #  ", "#####", "  #  ", "  #  " }
        local Minus = { "#####" }

        local Glyph = Instance.new("Frame")
        Glyph.Name = "\0"
        Glyph.BackgroundTransparency = 1
        Glyph.BorderSizePixel = 0
        Glyph.Position = UDim2.fromOffset(Left, Top)
        Glyph.Size = UDim2.fromOffset(METRIC.expand_size, METRIC.expand_size)
        Glyph.ZIndex = 5
        Glyph.Parent = Context.Parent

        local Hitbox = Instance.new("TextButton")
        Hitbox.Name = "\0"
        Hitbox.Text = ""
        Hitbox.AutoButtonColor = false
        Hitbox.BackgroundTransparency = 1
        Hitbox.BorderSizePixel = 0
        Hitbox.Position = UDim2.fromOffset(Left, Top)
        Hitbox.Size = UDim2.fromOffset(METRIC.expand_size, METRIC.expand_size)
        Hitbox.ZIndex = 40
        Hitbox.Parent = Context.Parent

        local Hover = HoverChannel(Hitbox)
        local Open = false
        local Width = Context.Right + 2 - Context.Left + 1
        local DefaultHeight = METRIC.default_settings_height

        local Popup = Instance.new("Frame")
        Popup.Name = "\0"
        Popup.BackgroundTransparency = 1
        Popup.BorderSizePixel = 0
        Popup.Position = UDim2.fromOffset(
            math.floor(Context.Parent.AbsolutePosition.X + Context.Left),
            math.floor(Context.Parent.AbsolutePosition.Y + Row + 9)
        )
        Popup.Size = UDim2.fromOffset(Width, DefaultHeight)
        Popup.Visible = false
        Popup.ZIndex = 20
        Popup.Parent = Library.Layers.Popups.Instance

        local Panel = Instance.new("Frame")
        Panel.Name = "\0"
        Panel.BackgroundTransparency = 1
        Panel.BorderSizePixel = 0
        Panel.Size = UDim2.fromOffset(Width, DefaultHeight)
        Panel.ZIndex = 1
        Panel.Parent = Popup

        local Content = Instance.new("Frame")
        Content.Name = "\0"
        Content.BackgroundTransparency = 1
        Content.BorderSizePixel = 0
        Content.Size = UDim2.fromOffset(Width, 600)
        Content.ZIndex = 2
        Content.Parent = Popup

        local ContainerContext = ContextValues(
            METRIC.content_inset,
            Width - 1 - METRIC.popup_right_inset,
            METRIC.popup_first_row,
            METRIC.popup_title_offset
        )
        ContainerContext.Parent = Content

        local Container = setmetatable({
            Name = Params.Name or "",
            Context = ContainerContext,
            Panel = Panel,
            WidgetFrame = Content,
            Width = Width,
            Height = DefaultHeight,
            FixedHeight = true,
            Items = {},
        }, Section)

        local function DrawGlyph()
            Glyph:ClearAllChildren()

            if Open then
                Draw.Mask(Glyph, 3, 5, Minus, C.arrow)
            else
                Draw.Mask(Glyph, 3, 3, Plus, C.arrow)
            end
        end

        local function Close()
            Open = false
            Popup.Visible = false
            DrawGlyph()
        end

        local function Show()
            Open = true

            local Height = math.ceil(Container.Context.Cursor + 2)

            Popup.Size = UDim2.fromOffset(Width, Height)
            Panel.Size = UDim2.fromOffset(Width, Height)
            Container.Height = Height

            Panel:ClearAllChildren()

            Draw.Panel(Panel, 0, 0, Width - 1, Height - 1)
            Draw.Text(Panel, METRIC.content_inset, METRIC.popup_title_offset, C.text, Params.Name or "", "reg", 1, 3)

            Popup.Visible = true

            DrawGlyph()
        end

        Hitbox.MouseButton1Click:Connect(function()
            if Open then
                Close()
            else
                Show()
            end
        end)

        Connect(UserInputService.InputBegan, function(Input)
            if not Open then
                return
            end

            if Input.UserInputType ~= Enum.UserInputType.MouseButton1
                and Input.UserInputType ~= Enum.UserInputType.Touch
            then
                return
            end

            local Point = Library:MousePoint()
            local Position = Popup.AbsolutePosition
            local Size = Popup.AbsoluteSize

            if Point.X >= Position.X and Point.X <= Position.X + Size.X
                and Point.Y >= Position.Y and Point.Y <= Position.Y + Size.Y
            then
                return
            end

            if Library:IsMouseOverFrame(Hitbox) then
                return
            end

            Close()
        end)

        table.insert(Library.Updates, function(Delta)
            if not Hitbox.Parent then
                return
            end

            local NewHover = Anim.Approach("settings_hover_" .. tostring(Hitbox), Hover.Target, 16, Delta)

            if math.abs(NewHover - Hover.Value) > 0.0001 then
                Hover.Value = NewHover

                local TopColor = LerpColor(C.input_top, C.input_hover_top, Hover.Value)
                local BottomColor = LerpColor(C.input_bottom, C.input_hover_bottom, Hover.Value)

                FrameGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, TopColor),
                    ColorSequenceKeypoint.new(1, BottomColor),
                })
            end
        end)

        Container.Popup = Popup
        Container.Hitbox = Hitbox

        DrawGlyph()

        return Container
    end

    -- =====================================================================
    -- floating popup window
    -- =====================================================================

    function Widgets.Popup(Params, SectionRef, Row)
        local Width, Height = 260, 160

        if type(Params.Size) == "table" then
            if Params.Size.X and Params.Size.X.Offset then
                Width = Params.Size.X.Offset
                Height = Params.Size.Y.Offset
            else
                Width = Params.Size.X or Width
                Height = Params.Size.Y or Height
            end
        end

        local Position = { X = 200, Y = 200 }

        if type(Params.Position) == "table" then
            if Params.Position.X and Params.Position.X.Offset then
                Position = { X = Params.Position.X.Offset, Y = Params.Position.Y.Offset }
            else
                Position = Params.Position
            end
        end

        local Root = Instance.new("Frame")
        Root.Name = "\0"
        Root.BackgroundTransparency = 1
        Root.BorderSizePixel = 0
        Root.Position = UDim2.fromOffset(Position.X, Position.Y)
        Root.Size = UDim2.fromOffset(Width, Height)
        Root.Visible = Params.Default ~= false
        Root.ZIndex = 6
        Root.Parent = Library.Layers.Tools.Instance

        Draw.Window(Root, 0, 0, Width - 1, Height - 1)
        Draw.FrameBox(Root, 6, 8, Width - 7, 25, C.frame_fill)
        Draw.WindowGlow(Root, 0, 0, Width - 1)
        Draw.TextCentered(Root, 6, Width - 7, 17, C.text, tostring(Params.Name or "Popup"), "bold")

        local Body = Instance.new("Frame")
        Body.Name = "\0"
        Body.BackgroundTransparency = 1
        Body.BorderSizePixel = 0
        Body.Position = UDim2.fromOffset(6, 30)
        Body.Size = UDim2.fromOffset(Width - 12, Height - 36)
        Body.ZIndex = 3
        Body.Parent = Root

        local Context = ContextValues(METRIC.content_inset, Width - 12 - METRIC.content_inset, METRIC.area_first_row, METRIC.title_offset)
        Context.Parent = Body

        local Popup = {
            Name = Params.Name or "Popup",
            Context = Context,
            WidgetFrame = Body,
            Frame = Root,
            Width = Width,
            Height = Height,
            Items = {},
            Visible = Root.Visible,
        }

        setmetatable(Popup, Section)

        function Popup:SetOpen(Value)
            Popup.Visible = Value and true or false
            Root.Visible = Popup.Visible
        end

        function Popup:ToggleOpen()
            Popup:SetOpen(not Popup.Visible)
        end

        function Popup:IsOpen()
            return Popup.Visible
        end

        function Popup:Center()
            local Screen = DisplaySize()

            Root.Position = UDim2.fromOffset(math.floor((Screen.X - Width) / 2), math.floor((Screen.Y - Height) / 2))
        end

        if Params.Content then
            task.spawn(Params.Content, Popup)
        end

        return Popup
    end
    -- =====================================================================
    -- section / page / window
    -- =====================================================================

    local SOURCE_LAYOUT = {
        [1] = {
            Aimbot = { Side = 1, Left = 23, Top = 78, Right = 323, Bottom = 490 },
            Orbit = { Side = 1, Left = 23, Top = 495, Right = 323, Bottom = 648 },
            ["Silent Aim"] = { Side = 2, Left = 328, Top = 78, Right = 628, Bottom = 436 },
            Triggerbot = { Side = 2, Left = 328, Top = 441, Right = 628, Bottom = 608 },
        },
        [2] = {
            Visuals = { Side = 1, Left = 23, Top = 78, Right = 323, Bottom = 256 },
            Settings = { Side = 2, Left = 328, Top = 78, Right = 628, Bottom = 218 },
        },
    }

    local Page = {}
    Page.__index = Page

    local Window = {}
    Window.__index = Window

    local function BuildSectionVisual(Self)
        Self.PanelFrame:ClearAllChildren()

        local Width = Self.Width
        local Height = Self.Height

        Draw.Panel(Self.PanelFrame, 0, 0, Width - 1, Height - 1)
        Draw.Text(Self.PanelFrame, METRIC.content_inset, METRIC.title_offset, C.text_title, Self.Name, "reg", 1, 3)
    end

    function Section:Rebuild()
        if not self.PanelFrame or not self.PanelFrame.Parent then
            return
        end

        local Width = self.Width

        if not self.FixedHeight then
            self.Height = math.ceil(self.Context.Cursor + 6)
        end

        self.Frame.Size = UDim2.fromOffset(Width, self.Height)
        self.WidgetFrame.Size = UDim2.fromOffset(Width, self.Height)
        self.WidgetFrame:ClearAllChildren()

        self.Context = ContextValues(
            METRIC.content_inset,
            Width - 1 - METRIC.content_inset,
            METRIC.first_row_offset,
            METRIC.title_offset
        )
        self.Context.Parent = self.WidgetFrame

        BuildSectionVisual(self)

        for _, Spec in self.Specs do
            if Spec.Type == "Label" then
                local Row = TakeRow(self.Context, METRIC.checkbox_row)

                Draw.Text(self.WidgetFrame, self.Context.Left + METRIC.label_indent, Row, C.text, tostring(Spec.Params.Name or ""))
                Spec.Object.Row = Row
            else
                local NewObject = Widgets[Spec.Type](self.Context, Spec.Params, self)

                if Spec.Object and NewObject then
                    for Key, Value in NewObject do
                        Spec.Object[Key] = Value
                    end

                    setmetatable(Spec.Object, getmetatable(NewObject))
                end
            end
        end
    end

    function Section:Resize(Left, Top, Right, Bottom, Fixed)
        self.Left = Left
        self.Top = Top
        self.Width = Right - Left + 1
        self.Height = Bottom - Top + 1
        self.FixedHeight = Fixed and true or false

        local Parent = self.Frame.Parent

        self.Frame.Position = UDim2.fromOffset(Left - 19, Top - 74)
        self.Frame.Size = UDim2.fromOffset(self.Width, self.Height)
        self.WidgetFrame.Position = UDim2.fromOffset(0, 0)
    end

    local function CreateSection(PageRef, Params)
        Params = Params or {}

        local Self = setmetatable({
            Name = tostring(Params.Name or "Section"),
            Page = PageRef,
            Side = Params.Side or 1,
            Specs = {},
            Items = {},
        }, Section)

        local PageIndex = PageRef.Index
        local Layout = SOURCE_LAYOUT[PageIndex] and SOURCE_LAYOUT[PageIndex][Self.Name]

        if Layout then
            Self.Side = Layout.Side
        end

        PageRef.Window:PlaceSection(Self, Layout)

        Self.Frame = Instance.new("Frame")
        Self.Frame.Name = "\0"
        Self.Frame.BackgroundTransparency = 1
        Self.Frame.BorderSizePixel = 0
        Self.Frame.Position = UDim2.fromOffset(Self.Left - 19, Self.Top - 74)
        Self.Frame.Size = UDim2.fromOffset(Self.Width, Self.Height)
        Self.Frame.ZIndex = 1
        Self.Frame.Parent = PageRef.Frame

        Self.PanelFrame = Instance.new("Frame")
        Self.PanelFrame.Name = "\0"
        Self.PanelFrame.BackgroundTransparency = 1
        Self.PanelFrame.BorderSizePixel = 0
        Self.PanelFrame.Size = UDim2.fromOffset(Self.Width, Self.Height)
        Self.PanelFrame.ZIndex = 1
        Self.PanelFrame.Parent = Self.Frame

        Self.WidgetFrame = Instance.new("Frame")
        Self.WidgetFrame.Name = "\0"
        Self.WidgetFrame.BackgroundTransparency = 1
        Self.WidgetFrame.BorderSizePixel = 0
        Self.WidgetFrame.Size = UDim2.fromOffset(Self.Width, Self.Height)
        Self.WidgetFrame.ClipsDescendants = true
        Self.WidgetFrame.ZIndex = 2
        Self.WidgetFrame.Parent = Self.Frame

        Self.Context = ContextValues(
            METRIC.content_inset,
            Self.Width - 1 - METRIC.content_inset,
            METRIC.first_row_offset,
            METRIC.title_offset
        )
        Self.Context.Parent = Self.WidgetFrame

        BuildSectionVisual(Self)

        -- record widget constructors so the section can be rebuilt on theme
        -- or width changes while the caller keeps its handles
        local function Spec(Type, Params2)
            local Object = Widgets[Type](Self.Context, Params2, Self)

            table.insert(Self.Specs, {
                Type = Type,
                Params = Params2,
                Object = Object,
            })

            return Object
        end

        Self.Spec = Spec

        function Self:Toggle(Params2)
            return Spec("Toggle", Params2 or {})
        end

        function Self:Slider(Params2)
            return Spec("Slider", Params2 or {})
        end

        function Self:Dropdown(Params2)
            return Spec("Dropdown", Params2 or {})
        end

        function Self:Textbox(Params2)
            return Spec("Textbox", Params2 or {})
        end

        function Self:Button(Params2)
            return Spec("Button", Params2 or {})
        end

        function Self:Label(Params2)
            Params2 = Params2 or {}

            local Row = TakeRow(Self.Context, METRIC.checkbox_row)

            Draw.Text(Self.WidgetFrame, Self.Context.Left + METRIC.label_indent, Row, C.text, tostring(Params2.Name or ""))

            local LabelObject = setmetatable({
                Name = tostring(Params2.Name or ""),
                Section = Self,
                Row = Row,
                Items = {},
            }, Library)

            function LabelObject:Colorpicker(Options)
                Options = Options or {}
                Options.Name = Options.Name or LabelObject.Name
                Options.Row = Row

                return Spec("Swatch", Options)
            end

            function LabelObject:Keybind(Options)
                Options = Options or {}
                Options.Name = Options.Name or LabelObject.Name
                Options.Row = Row

                return Spec("Keybind", Options)
            end

            table.insert(Self.Specs, {
                Type = "Label",
                Params = Params2,
                Object = LabelObject,
            })

            return LabelObject
        end

        function Self:Space(Amount)
            Self.Context.Cursor = Self.Context.Cursor + (Amount or 4)
        end

        function Self:Finish()
            if not Self.FixedHeight then
                Self.Height = math.ceil(Self.Context.Cursor + 6)
                Self.Frame.Size = UDim2.fromOffset(Self.Width, Self.Height)
                Self.WidgetFrame.Size = UDim2.fromOffset(Self.Width, Self.Height)
                BuildSectionVisual(Self)
            end

            Self.Bottom = Self.Top + Self.Height - 1
        end

        PageRef.Window.Sections[#PageRef.Window.Sections + 1] = Self
        PageRef.Sections[#PageRef.Sections + 1] = Self

        return Self
    end

    function Page:Section(Params)
        return CreateSection(self, Params)
    end

    function Page:Finish()
        for _, SectionRef in self.Sections do
            SectionRef:Finish()
        end
    end

    -- =====================================================================
    -- window
    -- =====================================================================

    local function LayoutRectFor(WindowRef, SectionRef, Layout)
        if Layout then
            return Layout.Left, Layout.Top, Layout.Right, Layout.Bottom
        end

        local Left = SectionRef.Side == 2 and 328 or 23
        local Right = SectionRef.Side == 2 and 628 or 323
        local Top = 78

        for _, Other in WindowRef.Sections do
            if Other ~= SectionRef and Other.Page == SectionRef.Page then
                if not Other.FixedHeight then
                    Other:Finish()
                end

                if Other.Side == SectionRef.Side and Other.Bottom and Other.Bottom + 6 > Top then
                    Top = Other.Bottom + 6
                end
            end
        end

        return Left, Top, Right, Top + 100
    end

    function Window:PlaceSection(SectionRef, Layout)
        local Left, Top, Right, Bottom = LayoutRectFor(self, SectionRef, Layout)

        SectionRef.Left = Left
        SectionRef.Top = Top
        SectionRef.Right = Right
        SectionRef.Bottom = Bottom
        SectionRef.Width = Right - Left + 1
        SectionRef.Height = Bottom - Top + 1
        SectionRef.FixedHeight = Layout ~= nil
    end

    local function Chrome(WindowRef)
        local Root = WindowRef.ChromeFrame
        local Width = WindowRef.Size.X
        local Height = WindowRef.Size.Y

        Root:ClearAllChildren()

        local function LX(Value)
            return Value - 4 + 10
        end

        local function LY(Value)
            return Value - 5 + 10
        end

        local WinLeft = 10
        local WinTop = 10
        local WinRight = 10 + Width - 1
        local WinBottom = 10 + Height - 1

        Draw.EdgeGlow(Root, WinLeft, WinTop, WinRight, WinBottom)
        Draw.Border(Root, WinLeft, WinTop, WinRight, WinBottom, C.black)
        Draw.Border(Root, WinLeft + 1, WinTop + 1, WinRight - 1, WinBottom - 1, C.window_edge)
        Draw.Border(Root, WinLeft + 2, WinTop + 2, WinRight - 2, WinBottom - 2, C.black)
        Draw.Fill(Root, WinLeft + 3, WinTop + 3, WinRight - 3, WinBottom - 3, C.window_band)

        local function Framed(Left, Top, Right, Bottom, FillColor)
            Draw.Border(Root, Left, Top, Right, Bottom, C.black)
            Draw.Border(Root, Left + 1, Top + 1, Right - 1, Bottom - 1, C.frame_light)
            Draw.Fill(Root, Left + 2, Top + 2, Right - 2, Bottom - 2, FillColor)
        end

        local ExtraX = Width - MENU.width
        local ExtraY = Height - MENU.height

        Framed(LX(11), LY(33), LX(640) + ExtraX, LY(665) + ExtraY, C.backdrop_fill)
        Framed(LX(17), LY(72), LX(634) + ExtraX, LY(659) + ExtraY, C.content_fill)

        -- header boxes
        local function HeaderBox(Left, Top, Right, Bottom)
            local BoxWidth = Right - Left + 1

            Draw.Border(Root, Left, Top, Right, Bottom, C.black)
            Draw.Fill(Root, Left + 1, Top + 1, Left + 1, Bottom - 1, C.frame_light)
            Draw.Fill(Root, Right - 1, Top + 1, Right - 1, Bottom - 1, C.frame_light)
            Draw.Fill(Root, Left + 2, Bottom - 1, Right - 2, Bottom - 1, C.frame_light)

            Draw.Accent(Root, Left + 2, Right - 2, Top + 1, { base = C.header_border_top, peak = C.header_border_glow }, Left, BoxWidth)
            Draw.Accent(Root, Left + 2, Right - 2, Top + 2, { base = C.accent_top, peak = C.accent_top_glow }, Left, BoxWidth)
            Draw.Accent(Root, Left + 2, Right - 2, Top + 3, { base = C.accent_bottom, peak = C.accent_bottom_glow }, Left, BoxWidth)
            Draw.Accent(Root, Left + 2, Right - 2, Top + 4, { base = C.header_fill_top, peak = C.header_fill_glow }, Left, BoxWidth)

            Draw.Gradient(Root, Left + 2, Top + 5, Right - 2, Bottom - 2, C.header_grad_top, C.header_grad_bottom)
            Draw.AccentGlow(Root, Left + 2, Right - 2, Top + 2, Left, BoxWidth, nil, 2, 8)
        end

        local Logo = { LX(11), LY(12), LX(150), LY(33) }
        local Build = { LX(499), LY(12), LX(640) + ExtraX, LY(33) }
        local Title = { LX(155), LY(12), LX(494), LY(33) }

        HeaderBox(Logo[1], Logo[2], Logo[3], Logo[4])
        HeaderBox(Title[1], Title[2], Title[3], Title[4])
        HeaderBox(Build[1], Build[2], Build[3], Build[4])

        Draw.Mask(Root, LX(56), LY(18), WindowRef.LogoMask, C.text)

        local HeaderRow = LY(24)

        local TitleString = WindowRef.UserName .. " | " .. WindowRef.BuildDate
        local TitleClip = Instance.new("Frame")
        TitleClip.Name = "\0"
        TitleClip.BackgroundTransparency = 1
        TitleClip.BorderSizePixel = 0
        TitleClip.ClipsDescendants = true
        TitleClip.Position = UDim2.fromOffset(Title[1] + 2, Title[2])
        TitleClip.Size = UDim2.fromOffset(Title[3] - Title[1] - 2, Title[4] - Title[2] + 1)
        TitleClip.ZIndex = 3
        TitleClip.Parent = Root

        Draw.TextCentered(TitleClip, 0, Title[3] - Title[1] - 3, HeaderRow - Title[2], C.text, TitleString)
        Draw.TextCentered(Root, Build[1], Build[3], HeaderRow, C.text, WindowRef.BuildType)

        -- tabs
        local TabBar = { LX(17), LY(44), LX(634) + ExtraX, LY(67) }
        local BarWidth = TabBar[3] - TabBar[1] + 1

        Draw.Border(Root, TabBar[1], TabBar[2], TabBar[3], TabBar[4], C.black)
        Draw.Accent(Root, TabBar[1] + 1, TabBar[3] - 1, TabBar[2] + 1, { base = C.tab_accent_top, peak = C.tab_accent_glow_top }, TabBar[1], BarWidth)
        Draw.Accent(Root, TabBar[1] + 1, TabBar[3] - 1, TabBar[2] + 2, { base = C.tab_accent_bottom, peak = C.tab_accent_glow_bottom }, TabBar[1], BarWidth)

        local Seps = WindowRef:TabSeparators()
        local TabTextRow = LY(57)

        for Index, PageRef in WindowRef.Pages do
            local Left = LX(Seps[Index]) + 1
            local Right = LX(Seps[Index + 1]) - 1

            local CellTop = TabBar[2] + 3
            local CellBottom = TabBar[4] - 1

            Draw.Gradient(Root, Left, CellTop, Right, CellBottom, C.tab_fill_top, C.tab_fill_bottom)

            if Index > 0 and Index > 1 then
                Draw.Fill(Root, Left - 1, CellTop, Left - 1, CellBottom, C.black)
            end

            local Hitbox = Instance.new("TextButton")
            Hitbox.Name = "\0"
            Hitbox.Text = ""
            Hitbox.AutoButtonColor = false
            Hitbox.BackgroundTransparency = 1
            Hitbox.BorderSizePixel = 0
            Hitbox.Position = UDim2.fromOffset(Left, TabBar[2])
            Hitbox.Size = UDim2.fromOffset(Right - Left + 1, TabBar[4] - TabBar[2] + 1)
            Hitbox.ZIndex = 40
            Hitbox.Parent = Root

            local Label = Draw.TextCentered(Root, Left, Right, TabTextRow, WindowRef.CurrentPage == PageRef and C.text_tab_selected or C.text_dim, PageRef.Name)

            local Hover = 0
            local TargetHover = 0
            local Selected = WindowRef.CurrentPage == PageRef
            local Active = Selected and 1 or 0

            Hitbox.MouseEnter:Connect(function()
                TargetHover = 1
            end)

            Hitbox.MouseLeave:Connect(function()
                TargetHover = 0
            end)

            Hitbox.MouseButton1Click:Connect(function()
                WindowRef:SetPage(PageRef)
            end)

            Library:AddUpdate(function(Delta)
                if not Hitbox.Parent then
                    return
                end

                local NewHover = Anim.Approach("tab_hover_" .. tostring(Hitbox), TargetHover, 16, Delta)
                local NewActive = Anim.Approach("tab_active_" .. tostring(Hitbox), WindowRef.CurrentPage == PageRef and 1 or 0, 12, Delta)

                if math.abs(NewHover - Hover) > 0.0001 or math.abs(NewActive - Active) > 0.0001 then
                    Hover = NewHover
                    Active = NewActive

                    local Idle = LerpColor(C.text_dim, C.text, NewHover * 0.35)

                    Label.TextColor3 = LerpColor(Idle, C.text_tab_selected, NewActive)
                end
            end)
        end

        Draw.AccentGlow(Root, TabBar[1] + 1, TabBar[3] - 1, TabBar[2] + 1, TabBar[1], BarWidth, nil, 1, 7)

        -- content clip (created once in Library:Window, repositioned here)
        local ContentLeft = LX(19)
        local ContentTop = LY(74)
        local ContentRight = LX(632) + ExtraX
        local ContentBottom = LY(657) + ExtraY

        local Clip = WindowRef.Clip
        local Scroll = WindowRef.ScrollFrame

        Clip.Position = UDim2.fromOffset(ContentLeft, ContentTop)
        Clip.Size = UDim2.fromOffset(ContentRight - ContentLeft + 1, ContentBottom - ContentTop + 1)

        Scroll.Size = UDim2.fromOffset(ContentRight - ContentLeft + 1, 4000)

        WindowRef.ContentLeft = ContentLeft
        WindowRef.ContentTop = ContentTop
        WindowRef.ContentRight = ContentRight
        WindowRef.ContentBottom = ContentBottom

        for _, PageRef in WindowRef.Pages do
            PageRef.Frame.Visible = PageRef == WindowRef.CurrentPage
        end

        -- drag area
        local DragArea = Instance.new("TextButton")
        DragArea.Name = "\0"
        DragArea.Text = ""
        DragArea.AutoButtonColor = false
        DragArea.BackgroundTransparency = 1
        DragArea.BorderSizePixel = 0
        DragArea.Position = UDim2.fromOffset(0, 0)
        DragArea.Size = UDim2.fromOffset(Width, MENU.drag_height)
        DragArea.ZIndex = 8
        DragArea.Parent = Root

        -- resize grip
        local Grip = Instance.new("TextButton")
        Grip.Name = "\0"
        Grip.Text = ""
        Grip.AutoButtonColor = false
        Grip.BackgroundTransparency = 1
        Grip.BorderSizePixel = 0
        Grip.Position = UDim2.fromOffset(Width - 12 + 10, Height - 12 + 10)
        Grip.Size = UDim2.fromOffset(12, 12)
        Grip.ZIndex = 8
        Grip.Parent = Root

        -- scrollbar
        WindowRef.Scrollbar = nil
    end

    function Window:TabSeparators()
        if #self.Pages == 5 then
            return { 17, 141, 264, 387, 510, 634 }
        end

        local Separators = { 17 }
        local Span = 634 - 17

        for Index = 1, #self.Pages do
            table.insert(Separators, 17 + math.floor(Span * Index / #self.Pages + 0.5))
        end

        Separators[#Separators] = 634

        return Separators
    end

    function Window:SetPage(PageRef)
        if self.CurrentPage == PageRef then
            return
        end

        self.CurrentPage = PageRef
        self.TabProgress = 0
        self.ScrollTarget = 0
        self.Scroll = 0

        for _, Each in self.Pages do
            Each.Frame.Visible = Each == PageRef
        end

        self:Build()
    end

    function Window:Layout()
        local Width = self.Size.X
        local Height = self.Size.Y

        self.Root.Position = UDim2.fromOffset(self.Position.X - 10, self.Position.Y - 10)
        self.Root.Size = UDim2.fromOffset(Width + 20, Height + 20)

        Chrome(self)
    end

    function Window:Build()
        self:Layout()
        self:FinishPages()

        for _, SectionRef in self.Sections do
            if SectionRef.Page == self.CurrentPage then
                SectionRef:Resize(SectionRef.Left, SectionRef.Top, SectionRef.Right, SectionRef.Bottom, SectionRef.FixedHeight)
            end
        end
    end

    function Window:FinishPages()
        local Lowest = 0

        for _, SectionRef in self.Sections do
            if SectionRef.Page == self.CurrentPage then
                SectionRef:Finish()
                Lowest = math.max(Lowest, SectionRef.Bottom)
            end
        end

        self.PanelBottom = Lowest
    end

    function Window:Center()
        local Screen = DisplaySize()

        self.Position = {
            X = math.floor((Screen.X - self.Size.X) / 2),
            Y = math.floor((Screen.Y - self.Size.Y) / 2),
        }

        self.Root.Position = UDim2.fromOffset(self.Position.X - 10, self.Position.Y - 10)
    end

    function Window:SetOpen(Value)
        self.IsOpen = Value and true or false
        self.OpenTarget = self.IsOpen and 1 or 0

        if not self.IsOpen then
            self.ScrollTarget = 0
        end
    end

    function Window:Toggle()
        self:SetOpen(not self.IsOpen)
    end

    function Window:Page(Params)
        Params = Params or {}

        local Self = setmetatable({
            Name = tostring(Params.Name or "Page"),
            Window = self,
            Index = #self.Pages + 1,
            Sections = {},
            Items = {},
        }, Page)

        local Frame = Instance.new("Frame")
        Frame.Name = "\0"
        Frame.BackgroundTransparency = 1
        Frame.BorderSizePixel = 0
        Frame.Position = UDim2.fromOffset(0, 0)
        Frame.Size = UDim2.fromOffset(620, 3000)
        Frame.ZIndex = 2
        Frame.Parent = self.ScrollFrame

        Self.Frame = Frame

        table.insert(self.Pages, Self)

        if #self.Pages == 1 then
            self.CurrentPage = Self
        else
            Frame.Visible = false
        end

        self:Build()

        return Self
    end

    function Library:Window(Params)
        Params = Params or {}

        if self ~= Library then
            Params = self
        end

        local Self = setmetatable({
            Name = tostring(Params.Name or Params.name or "Window"),
            UserName = Params.UserName or "dbxlll",
            BuildDate = Params.BuildDate or "hello",
            BuildType = Params.BuildType or "wow man",
            LogoMask = Params.LogoMask or {
                "                                          ####",
                "                                         #####",
                "     ###                 ##              ##   ",
                "    #####               ####             ##   ",
                "   ##    ##          ###   ##            ###  ",
                "   ##    ##          ###   ##             ##  ",
                "   ###  ##            ### ##              ##  ",
                "    ##### ##        ##  ####              ##  ",
                "     #######        #### ##             ####  ",
                "     ####              ####          ######   ",
                "     ###                ###          ####     ",
            },
            IsOpen = true,
            OpenTarget = 1,
            Pages = {},
            Sections = {},
            Items = {},
            TabProgress = 1,
            Scroll = 0,
            ScrollTarget = 0,
            PanelBottom = 0,
            Size = { X = MENU.width, Y = MENU.height },
            Position = { X = 0, Y = 0 },
        }, Window)

        local Screen = DisplaySize()

        Self.Position = {
            X = math.floor((Screen.X - MENU.width) / 2),
            Y = math.floor((Screen.Y - MENU.height) / 2),
        }

        local Root = Instance.new("Frame")
        Root.Name = "\0"
        Root.BackgroundTransparency = 1
        Root.BorderSizePixel = 0
        Root.Position = UDim2.fromOffset(Self.Position.X - 10, Self.Position.Y - 10)
        Root.Size = UDim2.fromOffset(MENU.width + 20, MENU.height + 20)
        Root.Active = true
        Root.ZIndex = 2
        Root.Parent = Library.Layers.Menu.Instance

        Self.Root = Root
        Self.Layer = Library.Layers.Menu.Instance

        local ChromeFrame = Instance.new("Frame")
        ChromeFrame.Name = "\0"
        ChromeFrame.BackgroundTransparency = 1
        ChromeFrame.BorderSizePixel = 0
        ChromeFrame.Position = UDim2.fromOffset(0, 0)
        ChromeFrame.Size = UDim2.fromOffset(MENU.width + 20, MENU.height + 20)
        ChromeFrame.ZIndex = 1
        ChromeFrame.Parent = Root

        local Clip = Instance.new("Frame")
        Clip.Name = "\0"
        Clip.BackgroundTransparency = 1
        Clip.BorderSizePixel = 0
        Clip.ClipsDescendants = true
        Clip.Position = UDim2.fromOffset(25, 79)
        Clip.Size = UDim2.fromOffset(MENU.width - 30, MENU.height - 84)
        Clip.ZIndex = 2
        Clip.Parent = Root

        local Scroll = Instance.new("Frame")
        Scroll.Name = "\0"
        Scroll.BackgroundTransparency = 1
        Scroll.BorderSizePixel = 0
        Scroll.Position = UDim2.fromOffset(0, 0)
        Scroll.Size = UDim2.fromOffset(MENU.width - 30, 4000)
        Scroll.ZIndex = 2
        Scroll.Parent = Clip

        Self.ChromeFrame = ChromeFrame
        Self.Clip = Clip
        Self.ScrollFrame = Scroll

        Chrome(Self)

        Library.Windows[#Library.Windows + 1] = Self

        table.insert(Library.Updates, function(Delta)
            if not Root.Parent then
                return
            end

            local Fade = Anim.Approach("menu_fade_" .. tostring(Root), Self.OpenTarget, 14, Delta)

            Root.Visible = Fade > 0.5

            -- tab slide
            if Self.TabProgress < 1 then
                Self.TabProgress = math.min(1, Self.TabProgress + Delta / 0.22)
            end

            local Eased = Anim.EaseOutCubic(Self.TabProgress)
            local Slide = math.floor((1 - Eased) * 8 + 0.5)

            Self.ScrollTarget = math.clamp(
                Self.ScrollTarget,
                0,
                math.max(0, Self.PanelBottom + 9 - 74 - (Self.ContentBottom - Self.ContentTop + 1))
            )
            Self.Scroll = math.floor(Anim.Approach("menu_scroll_" .. tostring(Root), Self.ScrollTarget, 16, Delta) + 0.5)

            if Self.ScrollFrame then
                Self.ScrollFrame.Position = UDim2.fromOffset(0, Slide - Self.Scroll)
            end

            -- scrollbar
            if Self.Clip then
                if not Self.Scrollbar then
                    Self.Scrollbar = Draw.Fill(Self.Clip, 0, 0, 0, 0, C.grab, 1, 6)
                end

                local Total = Self.PanelBottom + 9 - 74
                local View = Self.ContentBottom - Self.ContentTop + 1

                if Total > View and View > 0 then
                    local Track = View - 4
                    local Thumb = math.floor(math.max(12, Track * View / Total))
                    local Range = Total - View
                    local Top = 2 + math.floor((Track - Thumb) * math.clamp(Self.Scroll / Range, 0, 1) + 0.5)

                    local BarX = Self.ContentRight - Self.ContentLeft - 2

                    Self.Scrollbar.Visible = true
                    Self.Scrollbar.Position = UDim2.fromOffset(BarX, Top)
                    Self.Scrollbar.Size = UDim2.fromOffset(2, Thumb)
                else
                    Self.Scrollbar.Visible = false
                end
            end
        end)

        -- drag
        do
            local Dragging = false
            local DragStart
            local StartPosition

            Root.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1
                    or Input.UserInputType == Enum.UserInputType.Touch
                then
                    local Point = Input.Position
                    local LocalY = Point.Y - Root.AbsolutePosition.Y

                    if LocalY <= MENU.drag_height and Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Dragging = true
                        DragStart = Point
                        StartPosition = { X = Self.Position.X, Y = Self.Position.Y }
                    end
                end
            end)

            Connect(UserInputService.InputEnded, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1
                    or Input.UserInputType == Enum.UserInputType.Touch
                then
                    Dragging = false
                end
            end)

            Connect(UserInputService.InputChanged, function(Input)
                if not Dragging then
                    return
                end

                if Input.UserInputType ~= Enum.UserInputType.MouseMovement then
                    return
                end

                local Delta = Input.Position - DragStart
                local Screen = DisplaySize()

                local NewX = math.clamp(StartPosition.X + Delta.X, 0, Screen.X - Self.Size.X)
                local NewY = math.clamp(StartPosition.Y + Delta.Y, 0, Screen.Y - Self.Size.Y)

                Self.Position = { X = math.floor(NewX), Y = math.floor(NewY) }
                Root.Position = UDim2.fromOffset(Self.Position.X - 10, Self.Position.Y - 10)
            end)
        end

        -- resize (menu.cpp grip, min 480x300)
        do
            local Resizing = false
            local Grab = { X = 0, Y = 0 }

            Root.InputBegan:Connect(function(Input)
                if Input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    return
                end

                local Point = Input.Position
                local LocalX = Point.X - Root.AbsolutePosition.X
                local LocalY = Point.Y - Root.AbsolutePosition.Y

                if LocalX >= Self.Size.X + 10 - 12 and LocalY >= Self.Size.Y + 10 - 12 then
                    Resizing = true
                    Grab = { X = Point.X - (Root.AbsolutePosition.X + Self.Size.X + 10), Y = Point.Y - (Root.AbsolutePosition.Y + Self.Size.Y + 10) }
                end
            end)

            Connect(UserInputService.InputChanged, function(Input)
                if not Resizing then
                    return
                end

                if Input.UserInputType ~= Enum.UserInputType.MouseMovement then
                    return
                end

                local Point = Input.Position
                local Screen = DisplaySize()

                local NewWidth = math.floor(math.clamp(Point.X - Grab.X - Self.Position.X, MENU.min_width, Screen.X - Self.Position.X))
                local NewHeight = math.floor(math.clamp(Point.Y - Grab.Y - Self.Position.Y, MENU.min_height, Screen.Y - Self.Position.Y))

                if NewWidth ~= Self.Size.X or NewHeight ~= Self.Size.Y then
                    Self.Size = { X = NewWidth, Y = NewHeight }

                    Self.Root.Size = UDim2.fromOffset(NewWidth + 20, NewHeight + 20)

                    Chrome(Self)

                    for _, SectionRef in Self.Sections do
                        if SectionRef.Page == Self.CurrentPage then
                            SectionRef:Resize(SectionRef.Left, SectionRef.Top, SectionRef.Right, SectionRef.Bottom, SectionRef.FixedHeight)
                            SectionRef:Rebuild()
                        end
                    end
                end
            end)

            Connect(UserInputService.InputEnded, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Resizing = false
                end
            end)
        end

        -- wheel scrolling
        Connect(UserInputService.InputChanged, function(Input)
            if Input.UserInputType ~= Enum.UserInputType.MouseWheel then
                return
            end

            if not Root.Visible then
                return
            end

            local Point = Library:MousePoint()

            if not Self.Clip then
                return
            end

            local Position = Self.Clip.AbsolutePosition
            local Size = Self.Clip.AbsoluteSize

            if Point.X >= Position.X and Point.X <= Position.X + Size.X
                and Point.Y >= Position.Y and Point.Y <= Position.Y + Size.Y
            then
                Self.ScrollTarget = Self.ScrollTarget - Input.Position.Z * 40

                local Total = Self.PanelBottom + 9 - 74
                local View = Self.ContentBottom - Self.ContentTop + 1

                Self.ScrollTarget = math.clamp(Self.ScrollTarget, 0, math.max(0, Total - View))
            end
        end)

        return Self
    end
    -- =====================================================================
    -- tools.cpp — shared shell
    -- =====================================================================

    local Tools = {}

    local function ToolMetrics(Tool)
        return {
            bodyInset = 5,
            fieldHeight = 18,
            buttonHeight = 16,
            buttonGap = 4,
            clearWidth = 46,
            sectionGap = 5,
            listRow = 17,
            textIndent = 5,
            wheelStep = 34,
            dexHintHeight = 110,
            perfInfoHeight = 150,
            playerInfoHeight = 96,
        }
    end

    local function ToolInput(Parent, Rect, Hover)
        Draw.Border(Parent, Rect.left, Rect.top, Rect.right, Rect.bottom, C.black)
        Draw.Gradient(
            Parent,
            Rect.left + 1,
            Rect.top + 1,
            Rect.right - 1,
            Rect.bottom - 1,
            LerpColor(C.input_top, C.input_hover_top, Hover),
            LerpColor(C.input_bottom, C.input_hover_bottom, Hover)
        )
    end

    local function ToolTextField(Parent, Rect, Text, Placeholder, OnChanged)
        ToolInput(Parent, Rect, 0)

        local Box = Instance.new("TextBox")
        Box.Name = "\0"
        Box.BackgroundTransparency = 1
        Box.BorderSizePixel = 0
        Box.FontFace = FONTS.reg.face
        Box.TextSize = FONTS.reg.size
        Box.TextColor3 = C.text
        Box.PlaceholderColor3 = C.text_dim
        Box.PlaceholderText = Placeholder
        Box.Text = Text or ""
        Box.TextXAlignment = Enum.TextXAlignment.Left
        Box.TextYAlignment = Enum.TextYAlignment.Center
        Box.ClearTextOnFocus = false
        Box.Position = UDim2.fromOffset(Rect.left + 5, Rect.top + 1)
        Box.Size = UDim2.fromOffset(Rect.right - Rect.left - 9, Rect.bottom - Rect.top - 1)
        Box.ZIndex = 4
        Box.Parent = Parent

        Box:GetPropertyChangedSignal("Text"):Connect(function()
            if OnChanged then
                OnChanged(Box.Text)
            end
        end)

        return Box
    end

    local function ToolButton(Parent, Rect, Name, Callback)
        local Hover = 0
        local HoverTarget = 0

        local Frame = Draw.Gradient(Parent, Rect.left + 1, Rect.top + 1, Rect.right - 1, Rect.bottom - 1, C.input_top, C.input_bottom)
        local Gradient = Frame:FindFirstChildOfClass("UIGradient")

        Draw.Border(Parent, Rect.left, Rect.top, Rect.right, Rect.bottom, C.black)
        Draw.TextCentered(Parent, Rect.left, Rect.right, Rect.top + 8, C.text, Name)

        local Button = Instance.new("TextButton")
        Button.Name = "\0"
        Button.Text = ""
        Button.AutoButtonColor = false
        Button.BackgroundTransparency = 1
        Button.BorderSizePixel = 0
        Button.Position = UDim2.fromOffset(Rect.left, Rect.top)
        Button.Size = UDim2.fromOffset(Rect.right - Rect.left + 1, Rect.bottom - Rect.top + 1)
        Button.ZIndex = 5
        Button.Parent = Parent

        Button.MouseEnter:Connect(function()
            HoverTarget = 1
        end)

        Button.MouseLeave:Connect(function()
            HoverTarget = 0
        end)

        Button.MouseButton1Click:Connect(function()
            if Callback then
                task.spawn(Callback)
            end
        end)

        Library:AddUpdate(function(Delta)
            if not Button.Parent then
                return
            end

            local Value = Anim.Approach("tool_button_" .. tostring(Button), HoverTarget, 16, Delta)

            if math.abs(Value - Hover) > 0.0001 then
                Hover = Value
                Gradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, LerpColor(C.input_top, C.input_hover_top, Value)),
                    ColorSequenceKeypoint.new(1, LerpColor(C.input_bottom, C.input_hover_bottom, Value)),
                })
            end
        end)

        return Button
    end

    local function ToolListEntry(Parent, Rect, Selected, Callback)
        local Hover = 0
        local HoverTarget = 0

        local Frame = Draw.Gradient(Parent, Rect.left, Rect.top, Rect.right, Rect.bottom, C.fill_top, C.fill_bottom)
        Frame.BackgroundTransparency = Selected and 0 or 1

        local Button = Instance.new("TextButton")
        Button.Name = "\0"
        Button.Text = ""
        Button.AutoButtonColor = false
        Button.BackgroundTransparency = 1
        Button.BorderSizePixel = 0
        Button.Position = UDim2.fromOffset(Rect.left, Rect.top)
        Button.Size = UDim2.fromOffset(Rect.right - Rect.left + 1, Rect.bottom - Rect.top + 1)
        Button.ZIndex = 6
        Button.Parent = Parent

        Button.MouseEnter:Connect(function()
            HoverTarget = 1
        end)

        Button.MouseLeave:Connect(function()
            HoverTarget = 0
        end)

        Button.MouseButton1Click:Connect(function()
            if Callback then
                Callback()
            end
        end)

        Library:AddUpdate(function(Delta)
            if not Button.Parent then
                return
            end

            Hover = Anim.Approach("tool_row_" .. tostring(Button), HoverTarget, 16, Delta)
            Frame.BackgroundTransparency = Selected and (1 - math.max(0.0, 1 - Hover) * 1) or (1 - Hover * 0.6)
        end)

        return Button
    end

    local function CreateToolWindow(Definition, Index)
        local Tool = {
            Id = Definition.id,
            Title = Definition.title,
            Size = { X = Definition.size[1], Y = Definition.size[2] },
            Min = { X = Definition.min[1], Y = Definition.min[2] },
            Opening = Definition.opening,
            UI = Definition.ui,
            Open = false,
            Progress = 0,
            Visible = 0,
        }

        local Screen = DisplaySize()
        local Cascade = Index * 24

        Tool.Position = {
            X = math.clamp(math.floor((Screen.X - Tool.Size.X) / 2) + Cascade, 0, math.max(0, Screen.X - Tool.Size.X)),
            Y = math.clamp(math.floor((Screen.Y - Tool.Size.Y) / 2) + Cascade, 26, math.max(26, Screen.Y - Tool.Size.Y)),
        }

        local Root = Instance.new("Frame")
        Root.Name = "\0"
        Root.BackgroundTransparency = 1
        Root.BorderSizePixel = 0
        Root.Position = UDim2.fromOffset(Tool.Position.X, Tool.Position.Y)
        Root.Size = UDim2.fromOffset(Tool.Size.X, Tool.Size.Y)
        Root.Visible = false
        Root.Active = true
        Root.ZIndex = 3
        Root.Parent = Library.Layers.Tools.Instance

        Tool.Root = Root

        local Chrome = Instance.new("Frame")
        Chrome.Name = "\0"
        Chrome.BackgroundTransparency = 1
        Chrome.BorderSizePixel = 0
        Chrome.Size = UDim2.fromOffset(Tool.Size.X, Tool.Size.Y)
        Chrome.ZIndex = 2
        Chrome.Parent = Root

        local Body = Instance.new("Frame")
        Body.Name = "\0"
        Body.BackgroundTransparency = 1
        Body.BorderSizePixel = 0
        Body.ClipsDescendants = true
        Body.Position = UDim2.fromOffset(6, 30)
        Body.Size = UDim2.fromOffset(Tool.Size.X - 12, Tool.Size.Y - 36)
        Body.ZIndex = 4
        Body.Parent = Root

        Tool.Chrome = Chrome
        Tool.Body = Body

        local function Shell()
            Chrome:ClearAllChildren()

            local Width = Tool.Size.X
            local Height = Tool.Size.Y
            local Shown = Height

            if Tool.Opening == "unfold" then
                Shown = math.floor(40 + (Height - 40) * Tool.Progress + 0.5)
            end

            Draw.Window(Chrome, 0, 0, Width - 1, Shown - 1)
            Draw.FrameBox(Chrome, 6, 8, Width - 7, 25, C.frame_fill)
            Draw.WindowGlow(Chrome, 0, 0, Width - 1)
            Draw.TextCentered(Chrome, 6, Width - 7, 17, C.text, Tool.Title, "bold")
            Draw.FrameBox(Chrome, 6, 30, Width - 7, Shown - 7, C.frame_fill)
        end

        Shell()

        Tool.Shell = Shell

        function Tool:SetVisibility(Value)
            self.Open = Value and true or false

            if self.Open and self.Build then
                self.Build()
            end
        end

        Tool.SetOpen = Tool.SetVisibility

        function Tool:Toggle()
            self:SetVisibility(not self.Open)
        end

        function Tool:SetSize(Width, Height)
            self.Size = { X = Width, Y = Height }
            Root.Size = UDim2.fromOffset(Width, Height)
            Body.Size = UDim2.fromOffset(Width - 12, Height - 36)
            Shell()
        end

        function Tool:Build()
        end

        -- drag on the title bar
        do
            local Dragging = false
            local DragStart
            local StartPosition

            Root.InputBegan:Connect(function(Input)
                if Input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    return
                end

                local Local = Input.Position.Y - Root.AbsolutePosition.Y

                if Local <= 26 then
                    Dragging = true
                    DragStart = Input.Position
                    StartPosition = { X = Root.Position.X.Offset, Y = Root.Position.Y.Offset }
                end
            end)

            Connect(UserInputService.InputEnded, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Dragging = false
                end
            end)

            Connect(UserInputService.InputChanged, function(Input)
                if not Dragging or Input.UserInputType ~= Enum.UserInputType.MouseMovement then
                    return
                end

                local Delta = Input.Position - DragStart
                local ScreenNow = DisplaySize()

                Root.Position = UDim2.fromOffset(
                    math.floor(math.clamp(StartPosition.X + Delta.X, 0, ScreenNow.X - Tool.Size.X)),
                    math.floor(math.clamp(StartPosition.Y + Delta.Y, 26, ScreenNow.Y - Tool.Size.Y))
                )
            end)
        end

        -- resize grip
        do
            local Resizing = false

            Root.InputBegan:Connect(function(Input)
                if Input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    return
                end

                local LocalX = Input.Position.X - Root.AbsolutePosition.X
                local LocalY = Input.Position.Y - Root.AbsolutePosition.Y

                if LocalX >= Tool.Size.X - 12 and LocalY >= Tool.Size.Y - 12 then
                    Resizing = true
                end
            end)

            Connect(UserInputService.InputEnded, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Resizing = false
                end
            end)

            Connect(UserInputService.InputChanged, function(Input)
                if not Resizing or Input.UserInputType ~= Enum.UserInputType.MouseMovement then
                    return
                end

                local ScreenNow = DisplaySize()
                local Mouse = Input.Position

                local NewWidth = math.clamp(Mouse.X - Root.AbsolutePosition.X + 6, Tool.Min.X, math.max(Tool.Min.X, ScreenNow.X - Root.AbsolutePosition.X))
                local NewHeight = math.clamp(Mouse.Y - Root.AbsolutePosition.Y + 6, Tool.Min.Y, math.max(Tool.Min.Y, ScreenNow.Y - Root.AbsolutePosition.Y))

                Tool:SetSize(math.floor(NewWidth), math.floor(NewHeight))

                local BodyClip = Body.Size
                Body.Size = UDim2.fromOffset(Tool.Size.X - 12, math.max(0, Body.Size.Y.Offset))
                Body.Size = UDim2.fromOffset(Tool.Size.X - 12, Tool.Size.Y - 36)
            end)
        end

        Library:AddUpdate(function(Delta)
            if not Root.Parent then
                return
            end

            local Fade

            if Tool.Opening == "unfold" then
                local Step = Delta / 0.3

                Tool.Progress = math.clamp(Tool.Progress + (Tool.Open and Step or -Step), 0, 1)
                Fade = Anim.EaseOutCubic(Tool.Progress)
            else
                Fade = Anim.Approach("tool_fade_" .. Tool.Id, Tool.Open and 1 or 0, 12, Delta)
            end

            Tool.Visible = Fade
            Root.Visible = Fade > 0.5

            if Tool.Visible > 0.002 then
                local Shown = Tool.Size.Y

                if Tool.Opening == "unfold" then
                    Shown = math.floor(40 + (Tool.Size.Y - 40) * Tool.Progress + 0.5)
                end

                if Tool.LastShown ~= Shown or Tool.LastWidth ~= Tool.Size.X then
                    Tool.LastShown = Shown
                    Tool.LastWidth = Tool.Size.X
                    Shell()
                end

                local BodyHeight = math.max(0, Shown - 36)

                if Tool.LastBodyHeight ~= BodyHeight then
                    Tool.LastBodyHeight = BodyHeight
                    Body.Position = UDim2.fromOffset(6, 30)
                    Body.Size = UDim2.fromOffset(Tool.Size.X - 12, BodyHeight)
                end
            end
        end)

        return Tool
    end

    -- =====================================================================
    -- tools.cpp — bodies
    -- =====================================================================

    local PlayerNames = { "dbxlll", "hi again" }
    local PlayerSearch = ""
    local SelectedPlayer = -1
    local WaypointNames = {}
    local WaypointInput = ""

    local function BuildPlayersBody(Tool)
        local Body = Tool.Body
        local M = ToolMetrics(Tool)
        local Width = Tool.Size.X - 12
        local Height = Tool.Size.Y - 36
        local Inner = { left = M.bodyInset, top = M.bodyInset, right = Width - 1 - M.bodyInset, bottom = Height - 1 - M.bodyInset }

        Body:ClearAllChildren()

        local Field = { left = Inner.left, top = Inner.top, right = Inner.right, bottom = Inner.top + M.fieldHeight - 1 }
        local Info = { left = Inner.left, top = Inner.bottom - M.playerInfoHeight + 1, right = Inner.right, bottom = Inner.bottom }
        local List = { left = Inner.left, top = Field.bottom + M.sectionGap, right = Inner.right, bottom = Info.top - M.sectionGap - 1 }

        ToolTextField(Body, Field, PlayerSearch, "search players...", function(Value)
            PlayerSearch = Value
            BuildPlayersBody(Tool)
        end)

        Draw.FrameBox(Body, List.left, List.top, List.right, List.bottom, C.panel_fill)
        Draw.FrameBox(Body, Info.left, Info.top, Info.right, Info.bottom, C.panel_fill)

        local Shown = {}

        for Index, Name in PlayerNames do
            if PlayerSearch == "" or string.find(string.lower(Name), string.lower(PlayerSearch), 1, true) then
                table.insert(Shown, { Index = Index, Name = Name })
            end
        end

        local RowRight = List.right - 2

        for RowIndex, Entry in Shown do
            local Top = List.top + 2 + (RowIndex - 1) * M.listRow
            local Rect = { left = List.left + 2, top = Top, right = RowRight, bottom = Top + M.listRow - 1 }

            ToolListEntry(Body, Rect, SelectedPlayer == Entry.Index, function()
                SelectedPlayer = SelectedPlayer == Entry.Index and -1 or Entry.Index
                BuildPlayersBody(Tool)
            end)

            Draw.Text(Body, Rect.left + M.textIndent, Rect.top + 8, C.text, Entry.Name)
        end

        if #Shown == 0 then
            Draw.TextCentered(Body, List.left, List.right, List.top + math.floor((List.bottom - List.top + 1) / 2), C.text_dim, "no players found")
        end

        local PfpSize = Info.bottom - Info.top - 9
        local Pfp = { left = Info.left + 5, top = Info.top + 5, right = Info.left + 5 + PfpSize - 1, bottom = Info.bottom - 5 }

        Draw.Avatar(Body, Pfp.left, Pfp.top, Pfp.right, Pfp.bottom)

        local TextLeft = Pfp.right + 9

        if SelectedPlayer < 0 then
            Draw.Text(Body, TextLeft, Info.top + math.floor((Info.bottom - Info.top + 1) / 2), C.text_dim, "select a player")
            return
        end

        local TextTop = Pfp.top + 10
        local Name = PlayerNames[SelectedPlayer]

        Draw.Text(Body, TextLeft, TextTop, C.text, Name, "bold")
        Draw.Text(Body, TextLeft, TextTop + 16, C.text_dim, "health: 100 / 100")
        Draw.Text(Body, TextLeft, TextTop + 30, C.text_dim, "team: none")
        Draw.Text(Body, TextLeft, TextTop + 44, C.text_dim, "distance: 0 studs")
    end

    local function BuildWaypointsBody(Tool)
        local Body = Tool.Body
        local M = ToolMetrics(Tool)
        local Width = Tool.Size.X - 12
        local Height = Tool.Size.Y - 36
        local Inner = { left = M.bodyInset, top = M.bodyInset, right = Width - 1 - M.bodyInset, bottom = Height - 1 - M.bodyInset }

        Body:ClearAllChildren()

        local Field = { left = Inner.left, top = Inner.top, right = Inner.right, bottom = Inner.top + M.fieldHeight - 1 }
        local ButtonsTop = Inner.bottom - (M.buttonHeight * 2 + M.buttonGap) + 1
        local List = { left = Inner.left, top = Field.bottom + M.sectionGap, right = Inner.right, bottom = ButtonsTop - M.sectionGap - 1 }

        ToolTextField(Body, Field, WaypointInput, "waypoint name...", function(Value)
            WaypointInput = Value
        end)

        Draw.FrameBox(Body, List.left, List.top, List.right, List.bottom, C.panel_fill)

        local RowRight = List.right - 2

        for Index, Name in WaypointNames do
            local Top = List.top + 2 + (Index - 1) * M.listRow
            local Rect = { left = List.left + 2, top = Top, right = RowRight, bottom = Top + M.listRow - 1 }

            ToolListEntry(Body, Rect, false, function()
                WaypointInput = Name
                BuildWaypointsBody(Tool)
            end)

            Draw.Text(Body, Rect.left + M.textIndent, Rect.top + 8, C.text, Name)
        end

        local Half = math.floor((Inner.right - Inner.left + 1 - M.buttonGap) / 2)
        local SecondRow = ButtonsTop + M.buttonHeight + M.buttonGap

        local Save = { left = Inner.left, top = ButtonsTop, right = Inner.left + Half - 1, bottom = ButtonsTop + M.buttonHeight - 1 }
        local Overwrite = { left = Save.right + M.buttonGap + 1, top = ButtonsTop, right = Inner.right, bottom = Save.bottom }
        local Delete = { left = Inner.left, top = SecondRow, right = Save.right, bottom = SecondRow + M.buttonHeight - 1 }
        local Teleport = { left = Overwrite.left, top = SecondRow, right = Inner.right, bottom = Delete.bottom }

        ToolButton(Body, Save, "Save", function()
            if WaypointInput == "" then
                Library:Notification({ Name = "hello world", Text = "enter a waypoint name first" })
                return
            end

            table.insert(WaypointNames, WaypointInput)
            Library:Notification({ Name = "hello world", Text = "saved waypoint " .. WaypointInput })
            BuildWaypointsBody(Tool)
        end)

        ToolButton(Body, Overwrite, "Overwrite", function()
            Library:Notification({ Name = "hello world", Text = "overwrote waypoint " .. WaypointInput })
        end)

        ToolButton(Body, Delete, "Delete", function()
            if #WaypointNames > 0 then
                local Removed = table.remove(WaypointNames, 1)

                Library:Notification({ Name = "hello world", Text = "deleted waypoint " .. Removed })
                BuildWaypointsBody(Tool)
            end
        end)

        ToolButton(Body, Teleport, "Teleport", function()
            Library:Notification({ Name = "hello world", Text = "teleported to " .. WaypointInput })
        end)
    end

    local PaletteRows = {
        "Accent", "Shine", "Outline", "Text Outline", "Border", "Background",
        "Bg Top", "Bg Bot", "Child Fill", "Child Top", "Child Bot", "Grab",
        "Text", "Text Dim", "Grad Top", "Grad Bot",
    }

    local function BuildColorsBody(Tool)
        local Body = Tool.Body
        local Width = Tool.Size.X - 12
        local Height = Tool.Size.Y - 36

        Body:ClearAllChildren()

        local Context = ContextValues(METRIC.content_inset, Width - 1 - METRIC.content_inset, METRIC.area_first_row, METRIC.title_offset)
        Context.Parent = Body

        for _, Name in PaletteRows do
            local Row = TakeRow(Context, METRIC.checkbox_row)

            Draw.Text(Body, Context.Left + METRIC.label_indent, Row, C.text, Name)

            local Left, Right = PlaceInline(Context, METRIC.swatch_width, METRIC.swatch_gap)
            local Top = Row - 5

            local Frame = Instance.new("Frame")
            Frame.Name = "\0"
            Frame.BackgroundTransparency = 1
            Frame.BorderSizePixel = 0
            Frame.Position = UDim2.fromOffset(Left, Top)
            Frame.Size = UDim2.fromOffset(METRIC.swatch_width, METRIC.swatch_height)
            Frame.ZIndex = 4
            Frame.Parent = Body

            Draw.Gradient(Frame, 1, 1, METRIC.swatch_width - 2, METRIC.swatch_height - 2, Library.Theme[Name], Scale(Library.Theme[Name], 0.8))
            Draw.Border(Frame, 0, 0, METRIC.swatch_width - 1, METRIC.swatch_height - 1, C.black)

            local Hitbox = Instance.new("TextButton")
            Hitbox.Name = "\0"
            Hitbox.Text = ""
            Hitbox.AutoButtonColor = false
            Hitbox.BackgroundTransparency = 1
            Hitbox.BorderSizePixel = 0
            Hitbox.Size = UDim2.fromOffset(METRIC.swatch_width, METRIC.swatch_height)
            Hitbox.ZIndex = 6
            Hitbox.Parent = Frame

            Hitbox.MouseButton1Click:Connect(function()
                local State = NewColorObject(Library.Theme[Name], 1)

                Widgets.OpenPicker(Frame, State, function()
                    Library:SetThemeValue(Name, State.Color)
                end)
            end)
        end

        local GlowRow = TakeRow(Context, METRIC.slider_advance)
        local GlowTop = GlowRow + METRIC.widget_offset

        Draw.Text(Body, Context.Left + METRIC.label_indent, GlowRow, C.text, "Menu Glow")

        local GlowFrame = Draw.Gradient(Body, Context.Left + 1, GlowTop + 1, Context.Right - 1, GlowTop + METRIC.slider_height - 2, C.track_top, C.track_bottom)
        Draw.Border(Body, Context.Left, GlowTop, Context.Right, GlowTop + METRIC.slider_height - 1, C.black)

        local GlowFilled = Draw.Gradient(
            Body,
            Context.Left + 1,
            GlowTop + 1,
            Context.Left + 1 + math.floor((Context.Right - Context.Left - 1) * math.clamp(Library.Theme["Menu Glow"] / 2, 0, 1)) - 1,
            GlowTop + METRIC.slider_height - 2,
            C.fill_top,
            C.fill_bottom
        )

        local GlowHitbox = Instance.new("TextButton")
        GlowHitbox.Name = "\0"
        GlowHitbox.Text = ""
        GlowHitbox.AutoButtonColor = false
        GlowHitbox.BackgroundTransparency = 1
        GlowHitbox.BorderSizePixel = 0
        GlowHitbox.Position = UDim2.fromOffset(Context.Left, GlowTop - 2)
        GlowHitbox.Size = UDim2.fromOffset(Context.Right - Context.Left + 1, METRIC.slider_height + 4)
        GlowHitbox.ZIndex = 5
        GlowHitbox.Parent = Body

        local GlowDragging = false

        local function SetGlow(Mouse)
            local WidthInner = Context.Right - Context.Left - 1
            local Frac = math.clamp((Mouse.X - (GlowHitbox.AbsolutePosition.X + 1)) / WidthInner, 0, 1)

            Library.Theme["Menu Glow"] = Frac * 2
            Library:SetThemeValue("Menu Glow", Frac * 2)

            GlowFilled.Size = UDim2.fromOffset(
                math.max(1, math.floor(WidthInner * Frac)),
                METRIC.slider_height - 2
            )
        end

        GlowHitbox.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                GlowDragging = true
                SetGlow(Library:MousePoint())
            end
        end)

        Connect(UserInputService.InputEnded, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                GlowDragging = false
            end
        end)

        Connect(UserInputService.InputChanged, function(Input)
            if GlowDragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
                SetGlow(Library:MousePoint())
            end
        end)

        local BgRow = TakeRow(Context, METRIC.slider_advance)
        local BgTop = BgRow + METRIC.widget_offset

        Draw.Text(Body, Context.Left + METRIC.label_indent, BgRow, C.text, "Bg Blur")
        Draw.Gradient(Body, Context.Left + 1, BgTop + 1, Context.Right - 1, BgTop + METRIC.slider_height - 2, C.track_top, C.track_bottom)
        Draw.Border(Body, Context.Left, BgTop, Context.Right, BgTop + METRIC.slider_height - 1, C.black)

        local ComboRow = TakeRow(Context, METRIC.combo_advance)
        local ComboTop = ComboRow + METRIC.widget_offset

        Draw.Text(Body, Context.Left + METRIC.label_indent, ComboRow, C.text, "Preset")
        ToolInput(Body, { left = Context.Left, top = ComboTop, right = Context.Right, bottom = ComboTop + METRIC.combo_height - 1 }, 0)

        local PresetBox = Instance.new("TextButton")
        PresetBox.Name = "\0"
        PresetBox.Text = ""
        PresetBox.AutoButtonColor = false
        PresetBox.BackgroundTransparency = 1
        PresetBox.BorderSizePixel = 0
        PresetBox.Position = UDim2.fromOffset(Context.Left, ComboTop)
        PresetBox.Size = UDim2.fromOffset(Context.Right - Context.Left + 1, METRIC.combo_height)
        PresetBox.ZIndex = 5
        PresetBox.Parent = Body

        Draw.Text(Body, Context.Left + METRIC.combo_text_indent, ComboTop + 8, C.text, Library.CurrentTheme or "Default")
        RenderArrow(Body, Context.Right, ComboTop, 0)

        PresetBox.MouseButton1Click:Connect(function()
            local WidthPopup = Context.Right - Context.Left + 1
            local HeightPopup = #Library.PresetOrder * METRIC.dropdown_item + 2
            local X = PresetBox.AbsolutePosition.X
            local Y = PresetBox.AbsolutePosition.Y + METRIC.combo_height - 1 + 2

            local Popup = Instance.new("Frame")
            Popup.Name = "\0"
            Popup.BackgroundTransparency = 1
            Popup.BorderSizePixel = 0
            Popup.Position = UDim2.fromOffset(math.floor(X), math.floor(Y))
            Popup.Size = UDim2.fromOffset(WidthPopup, HeightPopup)
            Popup.ZIndex = 40
            Popup.Parent = Library.Layers.Popups.Instance

            Draw.Border(Popup, 0, 0, WidthPopup - 1, HeightPopup - 1, C.black)
            Draw.Fill(Popup, 1, 1, WidthPopup - 2, HeightPopup - 2, C.input_bottom)

            for Index, Name in Library.PresetOrder do
                local Top = 1 + (Index - 1) * METRIC.dropdown_item
                local Button = Instance.new("TextButton")
                Button.Name = "\0"
                Button.Text = ""
                Button.AutoButtonColor = false
                Button.BackgroundTransparency = 1
                Button.BorderSizePixel = 0
                Button.Position = UDim2.fromOffset(1, Top)
                Button.Size = UDim2.fromOffset(WidthPopup - 2, METRIC.dropdown_item)
                Button.ZIndex = 42
                Button.Parent = Popup

                Draw.Text(Popup, 3, Top + 7, Name == Library.CurrentTheme and C.text or C.text_dim, Name, "reg", 1, 42)

                Button.MouseButton1Click:Connect(function()
                    Library:SetTheme(Name)
                    Popup:Destroy()
                end)
            end

            Connect(UserInputService.InputBegan, function(Input)
                if not Popup.Parent then
                    return
                end

                if Input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    return
                end

                local Point = Library:MousePoint()
                local Position = Popup.AbsolutePosition
                local Size = Popup.AbsoluteSize

                if Point.X < Position.X or Point.X > Position.X + Size.X or Point.Y < Position.Y or Point.Y > Position.Y + Size.Y then
                    Popup:Destroy()
                end
            end)
        end)

        local ButtonRow = TakeRow(Context, METRIC.button_advance)
        local ButtonTop = ButtonRow - 7

        ToolButton(Body, { left = Context.Left, top = ButtonTop, right = Context.Right, bottom = ButtonTop + METRIC.button_height - 1 }, "Apply Theme", function()
            Library:SetTheme(Library.CurrentTheme or "Default")
        end)
    end

    local DexSearch = ""
    local PerfFilter = ""
    local ConfigInput = ""
    local ConfigSelected = false
    local ConfigName = "Hi dbxlll"

    local function BuildDexBody(Tool)
        local Body = Tool.Body
        local M = ToolMetrics(Tool)
        local Width = Tool.Size.X - 12
        local Height = Tool.Size.Y - 36
        local Inner = { left = M.bodyInset, top = M.bodyInset, right = Width - 1 - M.bodyInset, bottom = Height - 1 - M.bodyInset }

        Body:ClearAllChildren()

        local Field = { left = Inner.left, top = Inner.top, right = Inner.right - M.clearWidth - M.buttonGap, bottom = Inner.top + M.fieldHeight - 1 }
        local Clear = { left = Field.right + M.buttonGap + 1, top = Field.top, right = Inner.right, bottom = Field.bottom }

        ToolTextField(Body, Field, DexSearch, "Search name or class...", function(Value)
            DexSearch = Value
        end)

        ToolButton(Body, Clear, "Clear", function()
            DexSearch = ""
            BuildDexBody(Tool)
        end)

        local Hint = { left = Inner.left, top = Inner.bottom - M.dexHintHeight + 1, right = Inner.right, bottom = Inner.bottom }
        local Tree = { left = Inner.left, top = Field.bottom + M.sectionGap, right = Inner.right, bottom = Hint.top - M.sectionGap - 1 }

        Draw.FrameBox(Body, Tree.left, Tree.top, Tree.right, Tree.bottom, C.panel_fill)
        Draw.FrameBox(Body, Hint.left, Hint.top, Hint.right, Hint.bottom, C.panel_fill)
        Draw.TextCentered(Body, Hint.left, Hint.right, Hint.top + math.floor((Hint.bottom - Hint.top + 1) / 2), C.text_dim, "Right-click for options, left-click to select")
    end

    local ConfigButtons = { "Save", "Overwrite", "Load", "Delete", "Refresh", "Set Autoload" }
    local ConfigMessages = {
        "saved config hi dbxlll",
        "overwrote config hi dbxlll",
        "loaded config hi dbxlll",
        "hi dbxlll is the only config, it stays",
        "found 1 config",
        "hi dbxlll set to autoload",
    }

    local function BuildConfigBody(Tool)
        local Body = Tool.Body
        local M = ToolMetrics(Tool)
        local Width = Tool.Size.X - 12
        local Height = Tool.Size.Y - 36
        local Inner = { left = M.bodyInset, top = M.bodyInset, right = Width - 1 - M.bodyInset, bottom = Height - 1 - M.bodyInset }

        Body:ClearAllChildren()

        local Field = { left = Inner.left, top = Inner.top, right = Inner.right, bottom = Inner.top + M.fieldHeight - 1 }
        local ButtonsTop = Inner.bottom - (M.buttonHeight * 3 + M.buttonGap * 2) + 1
        local List = { left = Inner.left, top = Field.bottom + M.sectionGap, right = Inner.right, bottom = ButtonsTop - M.sectionGap - 1 }

        ToolTextField(Body, Field, ConfigInput, "config name...", function(Value)
            ConfigInput = Value
        end)

        Draw.FrameBox(Body, List.left, List.top, List.right, List.bottom, C.panel_fill)

        local Item = { left = List.left + 2, top = List.top + 2, right = List.right - 2, bottom = List.top + 1 + M.listRow }

        ToolListEntry(Body, Item, ConfigSelected, function()
            ConfigSelected = not ConfigSelected

            if ConfigSelected then
                ConfigInput = ConfigName
            end

            BuildConfigBody(Tool)
        end)

        Draw.Text(Body, Item.left + M.textIndent, Item.top + 8, C.text, ConfigName)
        Draw.Text(Body, Item.left + M.textIndent + Measure(ConfigName) + 4, Item.top + 8, C.text_dim, "(autoloading)")

        local Half = math.floor((Inner.right - Inner.left + 1 - M.buttonGap) / 2)

        for Index, Name in ConfigButtons do
            local Left = Inner.left + (Index % 2 == 1 and 0 or (Half + M.buttonGap))
            local Right = Index % 2 == 1 and (Left + Half - 1) or Inner.right
            local Top = ButtonsTop + math.floor((Index - 1) / 2) * (M.buttonHeight + M.buttonGap)

            ToolButton(Body, { left = Left, top = Top, right = Right, bottom = Top + M.buttonHeight - 1 }, Name, function()
                Library:Notification({ Name = "hello world", Text = ConfigMessages[Index] })
            end)
        end
    end

    local function BuildPerfBody(Tool)
        local Body = Tool.Body
        local M = ToolMetrics(Tool)
        local Width = Tool.Size.X - 12
        local Height = Tool.Size.Y - 36
        local Inner = { left = M.bodyInset, top = M.bodyInset, right = Width - 1 - M.bodyInset, bottom = Height - 1 - M.bodyInset }

        Body:ClearAllChildren()

        local Field = { left = Inner.left, top = Inner.top, right = Inner.right - M.clearWidth - M.buttonGap, bottom = Inner.top + M.fieldHeight - 1 }
        local Clear = { left = Field.right + M.buttonGap + 1, top = Field.top, right = Inner.right, bottom = Field.bottom }

        ToolTextField(Body, Field, PerfFilter, "Filter thread name...", function(Value)
            PerfFilter = Value
        end)

        ToolButton(Body, Clear, "Clear", function()
            PerfFilter = ""
            BuildPerfBody(Tool)
        end)

        local Info = { left = Inner.left, top = Inner.bottom - M.perfInfoHeight + 1, right = Inner.right, bottom = Inner.bottom }
        local Header = { left = Inner.left, top = Field.bottom + M.sectionGap, right = Inner.right, bottom = Field.bottom + M.sectionGap + M.listRow - 1 }
        local List = { left = Inner.left, top = Header.bottom + 3, right = Inner.right, bottom = Info.top - M.sectionGap - 1 }

        Draw.FrameBox(Body, Header.left, Header.top, Header.right, Header.bottom, C.panel_fill)

        local Span = Header.right - Header.left - M.textIndent * 2

        for _, Column in {
            { "Thread ^", 0.0 },
            { "Hz", 0.42 },
            { "avg ms", 0.54 },
            { "CPU%", 0.68 },
            { "Hz graph", 0.80 },
        } do
            Draw.Text(Body, Header.left + M.textIndent + math.floor(Span * Column[2] + 0.5), Header.top + 8, C.text_dim, Column[1])
        end

        Draw.FrameBox(Body, List.left, List.top, List.right, List.bottom, C.panel_fill)
        Draw.TextCentered(Body, List.left, List.right, List.top + math.floor((List.bottom - List.top + 1) / 2), C.text, "too lazy to do ts")

        Draw.FrameBox(Body, Info.left, Info.top, Info.right, Info.bottom, C.panel_fill)
        Draw.TextCentered(Body, Info.left, Info.right, Info.top + math.floor((Info.bottom - Info.top + 1) / 2), C.text_dim, "Click a thread to see its graphs")
    end

    -- =====================================================================
    -- console (extrapolated from the config window language)
    -- =====================================================================

    function Library:Console(Params)
        Params = Params or {}

        if self ~= Library then
            Params = self
        end

        local Tool = CreateToolWindow({
            id = "console",
            title = tostring(Params.Name or "Console"),
            size = { 400, 260 },
            min = { 240, 140 },
            opening = "fade",
        }, 6)

        local Body = Tool.Body
        local Lines = {}
        local Input = ""

        local function Build()
            local Width = Tool.Size.X - 12
            local Height = Tool.Size.Y - 36

            Body:ClearAllChildren()

            local Field = { left = 5, top = Height - 23, right = Width - 6, bottom = Height - 6 }

            Draw.FrameBox(Body, 5, 5, Width - 6, Field.top - 5, C.console_body or C.panel_fill)

            local Y = 9

            for Index = math.max(1, #Lines - 12), #Lines do
                Draw.Text(Body, 9, Y, C.text, Lines[Index])
                Y = Y + 13
            end

            ToolTextField(Body, Field, Input, "command...", function(Value)
                Input = Value
            end)
        end

        function Tool:Add(Text)
            table.insert(Lines, tostring(Text))
            Build()
        end

        Tool.Log = Tool.Add
        Tool.Print = Tool.Add

        function Tool:Clear()
            Lines = {}
            Build()
        end

        Tool.Build = Build
        Build()

        Library.ConsoleObject = Tool

        return Tool
    end

    -- =====================================================================
    -- fps graph (extrapolated from the thread performance panel)
    -- =====================================================================

    local Graph

    function Library:Graph(Params)
        Params = Params or {}

        if self ~= Library then
            Params = self
        end

        local Tool = CreateToolWindow({
            id = Params.Id or "graph",
            title = tostring(Params.Name or "Graph"),
            size = { 220, 120 },
            min = { 160, 90 },
            opening = "fade",
        }, 7)

        local Values = {}
        local Max = tonumber(Params.Max) or 240

        local function Build()
            local Width = Tool.Size.X - 12
            local Height = Tool.Size.Y - 36

            Tool.Body:ClearAllChildren()

            Draw.FrameBox(Tool.Body, 5, 5, Width - 6, Height - 6, C.panel_fill)

            local Left = 8
            local Top = 8
            local GraphWidth = Width - 16
            local GraphHeight = Height - 16

            for Index = 2, #Values do
                local X1 = Left + math.floor((Index - 2) / math.max(1, #Values - 1) * (GraphWidth - 1))
                local X2 = Left + math.floor((Index - 1) / math.max(1, #Values - 1) * (GraphWidth - 1))
                local Y1 = Top + GraphHeight - 1 - math.floor(math.clamp(Values[Index - 1] / Max, 0, 1) * (GraphHeight - 1))
                local Y2 = Top + GraphHeight - 1 - math.floor(math.clamp(Values[Index] / Max, 0, 1) * (GraphHeight - 1))

                local Steps = math.max(math.abs(X2 - X1), math.abs(Y2 - Y1))

                for Step = 0, Steps do
                    local T = Steps == 0 and 0 or Step / Steps
                    local X = math.floor(X1 + (X2 - X1) * T + 0.5)
                    local Y = math.floor(Y1 + (Y2 - Y1) * T + 0.5)

                    Draw.Fill(Tool.Body, X, Y, X, Y, C.accent_top, 1, 6)
                end
            end
        end

        function Tool.Push(A, B)
            local Value = B

            if Value == nil then
                Value = A
            end

            table.insert(Values, tonumber(Value) or 0)

            if #Values > 120 then
                table.remove(Values, 1)
            end

            Build()
        end

        Tool.Build = Build

        if Tool.Visible > 0.002 then
            Build()
        end

        return Tool
    end

    function Library:FpsGraph()
        if not Graph then
            Graph = Library:Graph({ Id = "fps", Name = "Fps", Max = 240 })
            Graph:SetVisibility(false)
        end

        return Graph
    end

    -- =====================================================================
    -- tool instances and source UI wiring
    -- =====================================================================

    Library.Tools = {}

    function Library:SetSourceUI(Key, Value)
        Library.SourceUI[Key] = Value and true or false

        local Tool = Library.Tools[Key]

        if Tool then
            Tool:SetVisibility(Value)
        end

        if Key == "watermark" and Library.WatermarkObject then
            Library.WatermarkObject:SetVisibility(Value)
        elseif Key == "keybinds" and Library.KeyList then
            Library.KeyList:SetVisibility(Value)
        elseif Key == "target_hud" and Library.TargetHUDObject then
            Library.TargetHUDObject:SetVisible(Value)
        end
    end

    function Library:CreateTools()
        for Index, Definition in TOOL_DEFS do
            local Tool = CreateToolWindow(Definition, Index - 1)
            local UI = Definition.ui

            Tool.Build = function()
                if UI == "players" then
                    BuildPlayersBody(Tool)
                elseif UI == "waypoints" then
                    BuildWaypointsBody(Tool)
                elseif UI == "themes" then
                    BuildColorsBody(Tool)
                elseif UI == "dex" then
                    BuildDexBody(Tool)
                elseif UI == "configs" then
                    BuildConfigBody(Tool)
                elseif UI == "perf" then
                    BuildPerfBody(Tool)
                end
            end

            Tool:Build()

            Library.Tools[UI] = Tool
        end
    end

    -- =====================================================================
    -- themes
    -- =====================================================================

    -- rebuild every window surface that painted with the old palette
    function Library:RefreshTheme(Skip)
        Skip = Skip or {}

        ThemeApply()

        for _, WindowRef in Library.Windows do
            WindowRef:Build()

            for _, SectionRef in WindowRef.Sections do
                SectionRef:Rebuild()
            end
        end

        for Key, Tool in Library.Tools do
            if not Skip[Key] then
                if Tool.Shell then
                    Tool.Shell()
                end

                if Tool.Build then
                    Tool.Build()
                end
            end
        end

        if Library.BuildTopBar then
            Library.BuildTopBar()
        end

        if Library.WatermarkObject then
            Library.WatermarkObject:SetSubText(Library.WatermarkObject.SubName)
        end

        if Library.KeyList then
            Library.KeyList:Refresh()
        end
    end

    function Library:SetThemeValue(Key, Color)
        if Library.Theme[Key] ~= nil then
            Library.Theme[Key] = Color
        end

        ThemeApply()

        -- live theme editing: coalesce the rebuild to one per frame at most
        Library.ThemeDirty = true
    end

    function Library:ChangeTheme(Key, Color)
        if Library.Theme[Key] == nil then
            return
        end

        Library.Theme[Key] = Color
        Library.ThemeDirty = false

        Library:RefreshTheme()
    end

    function Library:SetTheme(Name)
        local Preset = Library.Presets[Name]

        if not Preset then
            return false
        end

        for Key, Value in Library.Presets.Default do
            Library.Theme[Key] = Preset[Key] or Value
        end

        Library.CurrentTheme = Name
        Library.ThemeDirty = false

        Library:RefreshTheme()

        if Library.WatermarkObject then
            Library.WatermarkObject:SetSubText(Library.WatermarkObject.SubName)
        end

        return true
    end

    -- =====================================================================
    -- config files (executor filesystem, as in the contract)
    -- =====================================================================

    local ConfigFolder = Library.Directory .. Library.Folders.Configs .. "/"

    function Library:GetConfig()
        local Data = {}

        for Key, Value in Library.Flags do
            if type(Value) == "table" and Value.Color then
                Data[Key] = { Color = "#" .. Value:ToHex(), Alpha = Value.Alpha }
            elseif type(Value) == "table" and Value.Key then
                Data[Key] = { Key = tostring(Value.Key), Mode = Value.Mode }
            else
                Data[Key] = Value
            end
        end

        return HttpService:JSONEncode(Data)
    end

    function Library:LoadConfig(String)
        local Ok, Decoded = pcall(function()
            return HttpService:JSONDecode(String)
        end)

        if not Ok then
            return false, Decoded
        end

        for Key, Value in Decoded do
            local Setter = Library.SetFlags[Key]

            if Setter then
                if type(Value) == "table" and Value.Key then
                    Setter(Value)
                elseif type(Value) == "table" and Value.Color then
                    local Color, Alpha = ParseHex(Value.Color)
                    Setter(Color, Value.Alpha or Alpha)
                else
                    Setter(Value)
                end
            end
        end

        return true
    end

    -- =====================================================================
    -- settings page (contract: Window:InitSettings)
    -- =====================================================================

    function Window:InitSettings()
        local SettingsPage = self:Page({ Name = "Settings" })

        local Configuration = SettingsPage:Section({ Name = "Configuration", Side = 1 })

        Configuration:Dropdown({
            Name = "Configs",
            Flag = "configs_dropdown",
            Items = {},
            Multi = false,
        })

        Configuration:Textbox({
            Name = "Config Name:",
            Flag = "config_name",
            Placeholder = "",
        })

        Configuration:Button({ Name = "Save" })
        Configuration:Button({ Name = "Load" })
        Configuration:Button({ Name = "Delete" })
        Configuration:Button({ Name = "Refresh" })

        local ScriptSection = SettingsPage:Section({ Name = "Script", Side = 1 })

        ScriptSection:Button({
            Name = "Unload",
            Tooltip = "unload the script and close the menu",
            Callback = function()
                pcall(function()
                    Library:Exit()
                end)
            end,
        })

        local MenuSection = SettingsPage:Section({ Name = "Menu", Side = 1 })

        MenuSection:Label({ Name = "Menu Bind" }):Keybind({
            Flag = "menu_bind",
            Mode = "Toggle",
            Default = Enum.KeyCode.RightShift,
            Callback = function(Value)
                Library.MenuKeybind = Value.Key
            end,
        })

        MenuSection:Dropdown({
            Name = "Easing Style",
            Items = { "Linear", "Quad", "Quart", "Back", "Bounce", "Circular", "Cubic", "Elastic", "Exponential", "Sine", "Quint" },
            Default = "Exponential",
        })

        MenuSection:Dropdown({
            Name = "Easing Direction",
            Items = { "In", "Out", "InOut" },
            Default = "Out",
        })

        MenuSection:Slider({
            Name = "Tweening Speed",
            Min = 0,
            Max = 1,
            Default = 0.3,
            Decimals = 2,
        })

        MenuSection:Textbox({
            Name = "Menu Name",
            Flag = "menu_name",
            Placeholder = "",
        })

        local HudSection = SettingsPage:Section({ Name = "HUD", Side = 2 })

        HudSection:Toggle({
            Name = "Watermark",
            Flag = "hud_watermark",
            Default = true,
            Callback = function(Value)
                Library:SetSourceUI("watermark", Value)
            end,
        })

        HudSection:Dropdown({
            Name = "Options",
            Flag = "hud_options",
            Items = { "Game", "Status", "Fps", "Ping" },
            Default = { "Game", "Status", "Fps", "Ping" },
            Multi = true,
        })

        HudSection:Slider({
            Name = "Refresh Rate",
            Min = 0.05,
            Max = 2,
            Default = 0.1,
            Decimals = 2,
            Suffix = "s",
        })

        HudSection:Toggle({
            Name = "Console",
            Flag = "hud_console",
            Default = true,
            Callback = function(Value)
                if Library.ConsoleObject then
                    Library.ConsoleObject:SetVisibility(Value)
                end
            end,
        })

        HudSection:Toggle({
            Name = "Keybind List",
            Flag = "hud_keybindlist",
            Default = true,
            Callback = function(Value)
                if Library.KeyList then
                    Library.KeyList:SetVisibility(Value)
                end
            end,
        })

        local ThemingSection = SettingsPage:Section({ Name = "Theming", Side = 2 })

        for Index, Value in Library.Theme do
            if type(Value) == "Color3" then
                ThemingSection:Label({ Name = Index }):Colorpicker({
                    Name = Index,
                    Flag = "theme_" .. Index,
                    Default = Value,
                    Callback = function(Color, Alpha)
                        Library.Theme[Index] = Color
                        Library:ChangeTheme(Index, Color)
                    end,
                })
            end
        end

        ThemingSection:Dropdown({
            Name = "Preset",
            Flag = "theme_preset",
            Items = Library.PresetOrder,
            Default = Library.CurrentTheme or "Default",
            Callback = function(Value)
                Library:SetTheme(Value)
            end,
        })

        return SettingsPage
    end

    -- =====================================================================
    -- cleanup
    -- =====================================================================

    function Library:Exit()
        for _, Connection in Library.Connections do
            pcall(function()
                Connection:Disconnect()
            end)
        end

        table.clear(Library.Connections)
        table.clear(Library.Updates)
        table.clear(Library.AccentShines)

        pcall(function()
            Library.Holder.Instance:Destroy()
        end)

        for _, Entry in Library.Layers do
            pcall(function()
                Entry.Instance:Destroy()
            end)
        end

        Library.Holder = nil
        Library.Layers = {}
        Library.Windows = {}
        Library.Theme = nil

        getgenv().Library = nil

        return true
    end

    -- =====================================================================
    -- boot: top bar, overlay elements, animation loop
    -- =====================================================================

    BuildTopBar()
    Library:CreateTools()

    function Library:SyncKeybinds()
        if not Library.KeyList then
            return
        end

        local Entries = {}

        for _, Registration in Library.KeybindWidgets or {} do
            local Key, Mode = Registration.Get()

            table.insert(Entries, {
                Name = Registration.Name,
                Mode = Mode,
                Key = Key,
                Enabled = Registration.Enabled ~= false,
            })
        end

        Library.KeyList.Entries = Entries
        Library.KeyList:Refresh()
    end

    function Library:PlayerList(Params)
        Params = Params or {}

        if self ~= Library then
            Params = self
        end

        local Tool = Library.Tools.players
        local Object = {
            Name = Params.Name or "Playerlist",
            Flag = Params.Flag or "playerlist",
            IncludeLocal = Params.IncludeLocal and true or false,
            Rows = {},
            Values = {},
            Items = {},
            Visible = false,
        }

        function Object:SetVisibility(Value)
            self.Visible = Value and true or false
            Tool:SetVisibility(self.Visible)
            Library.SourceUI.players = self.Visible
        end

        Object.SetVisible = Object.SetVisibility

        function Object:Toggle()
            self:SetVisibility(not self.Visible)
        end

        function Object:Refresh()
            BuildPlayersBody(Tool)
        end

        function Object:Select(Player) self.Selected = Player end

        function Object:GetPriority(Player)
            return self.Values[tostring(Player)] or "None"
        end

        function Object:SetPriority(Player, Priority)
            self.Values[tostring(Player)] = Priority
            Library.Flags[self.Flag] = self.Values
            BuildPlayersBody(Tool)
        end

        function Object:Center()
            local Screen = DisplaySize()

            Tool.Root.Position = UDim2.fromOffset(
                math.floor((Screen.X - Tool.Size.X) / 2),
                math.floor((Screen.Y - Tool.Size.Y) / 2)
            )
        end

        Library.Flags[Object.Flag] = Object.Values
        Library.PlayerListObject = Object

        return Object
    end

    function Library.Toggle(A, B)
        if A == Library then
            A = B
            B = nil
        end

        if type(A) == "table" then
            if A.ToggleOpen then
                A:ToggleOpen()
                return A
            end

            if A.SetOpen then
                A:SetOpen(not (A.IsOpen or A.Visible))
                return A
            end

            if A.SetVisibility and A.Open ~= nil then
                A:SetVisibility(not A.Open)
                return A
            end

            if A.SetValue then
                A:SetValue(not A:Get())
                return A
            end
        end

        return Widgets.Popup(B or {}, nil)
    end

    -- =====================================================================
    -- diagnostics (fonts + FPS)
    -- =====================================================================

    function Library:GetFontStatus()
        if self ~= Library then
            return Library:GetFontStatus()
        end

        local Regular = Library.FontLoaded["Verdana-Regular"] == true
        local Bold = Library.FontLoaded["Verdana-Bold-700"] == true
        local Bar = Library.FontLoaded["Tahoma-Regular"] == true

        local Count = (Regular and 1 or 0) + (Bold and 1 or 0) + (Bar and 1 or 0)

        return {
            Fps = math.floor((Library.FpsValue or 0) + 0.5),
            Regular = Regular and "Verdana (custom)" or "Arial (fallback)",
            Bold = Bold and "Verdana Bold (custom)" or "ArialBold (fallback)",
            Bar = Bar and "Tahoma (custom)" or "Arial (fallback)",
            RegularLoaded = Regular,
            BoldLoaded = Bold,
            BarLoaded = Bar,
            Loaded = Count,
            Total = 3,
        }
    end

    function Library:Diagnostics()
        if self ~= Library then
            return Library:Diagnostics()
        end

        if Library.DiagnosticTool then
            Library.DiagnosticTool:Toggle()
            return Library.DiagnosticTool
        end

        local Tool = CreateToolWindow({
            id = "diagnostics",
            title = "Diagnostics",
            size = { 330, 140 },
            min = { 250, 120 },
            opening = "fade",
        }, 8)

        local Screen = DisplaySize()

        Tool.Position = {
            X = math.floor((Screen.X - Tool.Size.X) / 2),
            Y = 32,
        }

        Tool.Root.Position = UDim2.fromOffset(Tool.Position.X, Tool.Position.Y)

        local Labels = {}
        local Timer = 0

        local function Value(Index, Text, Color)
            local Label = Labels[Index]

            if Label and Label.Parent and Label.Text ~= Text then
                Label.Text = Text
                Label.TextColor3 = Color
            end
        end

        local function Build()
            local Width = Tool.Size.X - 12
            local Height = Tool.Size.Y - 36

            Tool.Body:ClearAllChildren()

            Labels = {}

            Draw.FrameBox(Tool.Body, 5, 5, Width - 6, Height - 6, C.panel_fill)

            local Rows = {
                { "fps", "0" },
                { "regular", "-" },
                { "bold", "-" },
                { "bar", "-" },
                { "faces", "-" },
            }

            for Index, Row in Rows do
                local Y = 12 + (Index - 1) * 16

                Draw.Text(Tool.Body, 10, Y, C.text_dim, Row[1])
                Labels[Index] = Draw.Text(Tool.Body, 92, Y, C.text, Row[2], "reg", 1, 3)
            end
        end

        Tool.Build = Build

        Build()

        Library:AddUpdate(function(Delta)
            if not Tool.Root.Parent or not Tool.Open then
                return
            end

            Timer = Timer + Delta

            if Timer < 0.25 then
                return
            end

            Timer = 0

            local Status = Library:GetFontStatus()

            Value(1, tostring(Status.Fps), C.text)
            Value(2, Status.Regular, Status.RegularLoaded and C.text or C.text_dim)
            Value(3, Status.Bold, Status.BoldLoaded and C.text or C.text_dim)
            Value(4, Status.Bar, Status.BarLoaded and C.text or C.text_dim)
            Value(5, string.format("%d/%d custom", Status.Loaded, Status.Total), C.text)
        end)

        Library.DiagnosticTool = Tool

        Tool:SetVisibility(true)

        return Tool
    end

    Library:Watermark({ Name = "dbxlll", SubName = "build: footjob" })
    Library:KeybindList({ Name = "Keybind" })
    Library:TargetHUD({ Name = "ext", Health = 100, MaxHealth = 100 })
    Library:Console({ Name = "Console" })

    Library.Fps = Library:Graph({ Id = "fps", Name = "Fps", Max = 240 })
    Library.Fps:SetVisibility(false)

    -- the source keybind list is populated from enabled binds; mirror them
    -- for every keybind widget that was registered with the menu
    Library:AddUpdate(function()
        if Library.KeyList and #Library.KeyList.Entries == 0 and Library.Windows[1] then
            local Entries = {}

            for _, WindowRef in Library.Windows do
                for _, SectionRef in WindowRef.Sections do
                    for _, Spec in SectionRef.Specs do
                        if Spec.Type == "Keybind" and Spec.Params.Flag then
                            local Stored = Library.Flags[Spec.Params.Flag]

                            table.insert(Entries, {
                                Name = Spec.Params.Name or "keybind",
                                Mode = type(Stored) == "table" and Stored.Mode or "Always",
                                Key = type(Stored) == "table" and Stored.Key or nil,
                                Enabled = true,
                            })
                        end
                    end
                end
            end
        end
    end)

    local FrameCounter = 0
    local FrameClock = os.clock()
    Library.FpsValue = 60

    local RenderConnection = RunService.RenderStepped:Connect(function(Delta)
        Draw.UpdateShines()

        for Index = #Library.Updates, 1, -1 do
            local Update = Library.Updates[Index]

            local Ok, Err = pcall(Update, Delta)

            if not Ok then
                warn("[Library] " .. tostring(Err))
                table.remove(Library.Updates, Index)
            end
        end

        if Library.ThemeDirty then
            Library.ThemeTimer = (Library.ThemeTimer or 0) + Delta

            if Library.ThemeTimer >= 0.2 then
                Library.ThemeTimer = 0
                Library.ThemeDirty = false

                -- live palette edits repaint every surface except the colors
                -- tool itself, so the control being dragged is never rebuilt
                Library:RefreshTheme({ themes = true })
            end
        end

        UpdateNotifications(Delta)

        FrameCounter = FrameCounter + 1

        if Library.TopBarClock and Library.TopBarClock.Parent then
            local Stamp = os.date("%I:%M %p %m/%d/%Y")

            if Library.TopBarClock.Text ~= Stamp then
                Library.TopBarClock.Text = Stamp
            end
        end

        local Now = os.clock()

        if Now - FrameClock >= 0.5 then
            Library.FpsValue = math.floor(FrameCounter / (Now - FrameClock) + 0.5)
            FrameCounter = 0
            FrameClock = Now
        end
    end)

    table.insert(Library.Connections, RenderConnection)

    -- menu keybind (source: Insert; contract: Library.MenuKeybind)
    Connect(UserInputService.InputBegan, function(Input, Processed)
        if Processed then
            return
        end

        if Input.UserInputType ~= Enum.UserInputType.Keyboard then
            return
        end

        local Bind = Library.MenuKeybind

        if type(Bind) == "string" then
            Bind = Enum.KeyCode[Bind] or Bind
        end

        if Input.KeyCode == Bind or (Bind == "Insert" and Input.KeyCode == Enum.KeyCode.Insert) then
            for _, WindowRef in Library.Windows do
                WindowRef:Toggle()
            end
        end
    end)

    return Library
end
