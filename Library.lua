do
	if getgenv().Library and getgenv().Library.Exit then
		getgenv().Library:Exit()
	end

	cloneref = cloneref or function(Object) return Object end

	local Players = game:GetService("Players")
	local UserInputService = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	local HttpService = game:GetService("HttpService")
	local TweenService = game:GetService("TweenService")
	local GuiService = game:GetService("GuiService")
	local CoreGui = cloneref(game:GetService("CoreGui"))

	gethui = gethui or function() return CoreGui end
		local LocalPlayer = Players.LocalPlayer

		while not LocalPlayer do
			task.wait()

			LocalPlayer = Players.LocalPlayer
		end

		local IsMobile = UserInputService.TouchEnabled or false
		local GuiInset = GuiService:GetGuiInset().Y
		local Mouse = cloneref(LocalPlayer:GetMouse())
		local Camera = workspace.CurrentCamera

	Library = {
		Flags = { },
		MenuKeybind = tostring(Enum.KeyCode.X),

		Directory = "Vitality",
		Folders = {
			Assets = "/Assets",
			Configs = "/Configs",
			Themes = "/Themes"
		},

		FontSize = 14,

		Animation = {
			Time = 0.3,
			Style = "Exponential",
			Direction = "Out"
		},

		ZIndexOrder = {
			["OptionHolder"] = 4,
			["KeybindWindow"] = 4,
			["ColorpickerWindow"] = 6
		},

		Theme = nil,

		Threads = { },
		Connections = { },
		SetFlags = { },

		ThemingStuff = { },
		ThemeMap = { },

		OpenFrames = { },

		Holder = nil,
		UnusedHolder = nil,

		Font = nil,
		BoldFont = nil,
	} do
		Library.__index = Library

		local Flags = Library.Flags
		local SetFlags = Library.SetFlags
		local ConfigsFolder = Library.Directory .. Library.Folders.Configs .. "/"
		local ConfigSelected
		local ConfigName
		local ThemeSelected
		local ThemeName

		local Keys = {
			["Unknown"]           = "Unknown",
			["Backspace"]         = "Back",
			["Tab"]               = "Tab",
			["Clear"]             = "Clear",
			["Return"]            = "Return",
			["Pause"]             = "Pause",
			["Escape"]            = "Escape",
			["Space"]             = "Space",
			["QuotedDouble"]      = '"',
			["Hash"]              = "#",
			["Dollar"]            = "$",
			["Percent"]           = "%",
			["Ampersand"]         = "&",
			["Quote"]             = "'",
			["LeftParenthesis"]   = "(",
			["RightParenthesis"]  = " )",
			["Asterisk"]          = "*",
			["Plus"]              = "+",
			["Comma"]             = ",",
			["Minus"]             = "-",
			["Period"]            = ".",
			["Slash"]             = "`",
			["Three"]             = "3",
			["Seven"]             = "7",
			["Eight"]             = "8",
			["Colon"]             = ":",
			["Semicolon"]         = ";",
			["LessThan"]          = "<",
			["GreaterThan"]       = ">",
			["Question"]          = "?",
			["Equals"]            = "=",
			["At"]                = "@",
			["LeftBracket"]       = "LeftBracket",
			["RightBracket"]      = "RightBracked",
			["BackSlash"]         = "BackSlash",
			["Caret"]             = "^",
			["Underscore"]        = "_",
			["Backquote"]         = "`",
			["LeftCurly"]         = "{",
			["Pipe"]              = "|",
			["RightCurly"]         = "}",
			["Tilde"]             = "~",
			["Delete"]            = "Delete",
			["End"]               = "End",
			["KeypadZero"]        = "Keypad0",
			["KeypadOne"]         = "Keypad1",
			["KeypadTwo"]         = "Keypad2",
			["KeypadThree"]       = "Keypad3",
			["KeypadFour"]        = "Keypad4",
			["KeypadFive"]        = "Keypad5",
			["KeypadSix"]         = "Keypad6",
			["KeypadSeven"]       = "Keypad7",
			["KeypadEight"]       = "Keypad8",
			["KeypadNine"]        = "Keypad9",
			["KeypadPeriod"]      = "KeypadP",
			["KeypadDivide"]      = "KeypadD",
			["KeypadMultiply"]    = "KeypadM",
			["KeypadMinus"]       = "KeypadM",
			["KeypadPlus"]        = "KeypadP",
			["KeypadEnter"]       = "KeypadE",
			["KeypadEquals"]      = "KeypadE",
			["Insert"]            = "Insert",
			["Home"]              = "Home",
			["PageUp"]            = "PageUp",
			["PageDown"]          = "PageDown",
			["RightShift"]        = "RightShift",
			["LeftShift"]         = "LeftShift",
			["RightControl"]      = "RightControl",
			["LeftControl"]       = "LeftControl",
			["LeftAlt"]           = "LeftAlt",
			["RightAlt"]          = "RightAlt"
		}

		if not isfolder(Library.Directory) then
			makefolder(Library.Directory)
		end

		for _, Folder in Library.Folders do
			if not isfolder(Library.Directory .. Folder) then
				makefolder(Library.Directory .. Folder)
			end
		end

		local Themes = {
			["Preset"] = {
				["Background"] = Color3.fromRGB(23, 23, 23),
				["Inline"] = Color3.fromRGB(22, 22, 22),
				["Content"] = Color3.fromRGB(21, 21, 21),
				["Text"] = Color3.fromRGB(200, 200, 200),
				["Outline 1"] = Color3.fromRGB(35, 35, 35),
				["Outline 2"] = Color3.fromRGB(30, 30, 30),
				["Outline 3"] = Color3.fromRGB(15, 15, 15),
				["Outline 4"] = Color3.fromRGB(10, 10, 10),
				["Inactive Text"] = Color3.fromRGB(135, 135, 135),
				["Accent"] = Color3.fromRGB(181, 32, 55),
				["Hovered Element"] = Color3.fromRGB(35, 35, 35),
				["Slider Track"] = Color3.fromRGB(24, 24, 24),
				["Section Box"] = Color3.fromRGB(18, 18, 18),
				["Console Body"] = Color3.fromRGB(17, 17, 17),
				["Console Tab"] = Color3.fromRGB(24, 24, 24),
				["Element"] = Color3.fromRGB(26, 26, 26),
			}
		}

		Library.Theme = Themes.Preset

		Library.AnimationRate = 30

		Library.NotificationsEnabled = true
		Library.CurrentTheme = "Vitality"

		Library.Presets = {
			["Vitality"] = table.clone(Themes.Preset),

			["Matrix"] = {
				["Background"] = Color3.fromRGB(10, 24, 14),
				["Inline"] = Color3.fromRGB(10, 23, 13),
				["Content"] = Color3.fromRGB(9, 22, 13),
				["Text"] = Color3.fromRGB(186, 240, 200),
				["Outline 1"] = Color3.fromRGB(16, 37, 21),
				["Outline 2"] = Color3.fromRGB(14, 32, 18),
				["Outline 3"] = Color3.fromRGB(7, 16, 9),
				["Outline 4"] = Color3.fromRGB(4, 10, 6),
				["Inactive Text"] = Color3.fromRGB(104, 152, 120),
				["Accent"] = Color3.fromRGB(0, 255, 102),
				["Hovered Element"] = Color3.fromRGB(16, 37, 21),
				["Slider Track"] = Color3.fromRGB(11, 25, 14),
				["Section Box"] = Color3.fromRGB(8, 19, 11),
				["Console Body"] = Color3.fromRGB(8, 18, 10),
				["Console Tab"] = Color3.fromRGB(11, 25, 14),
				["Element"] = Color3.fromRGB(12, 27, 16)
			},

			["Toxic"] = {
				["Background"] = Color3.fromRGB(18, 25, 10),
				["Inline"] = Color3.fromRGB(18, 24, 10),
				["Content"] = Color3.fromRGB(17, 23, 9),
				["Text"] = Color3.fromRGB(206, 219, 182),
				["Outline 1"] = Color3.fromRGB(28, 38, 16),
				["Outline 2"] = Color3.fromRGB(24, 33, 14),
				["Outline 3"] = Color3.fromRGB(12, 16, 7),
				["Outline 4"] = Color3.fromRGB(8, 11, 4),
				["Inactive Text"] = Color3.fromRGB(133, 148, 104),
				["Accent"] = Color3.fromRGB(166, 255, 20),
				["Hovered Element"] = Color3.fromRGB(28, 38, 16),
				["Slider Track"] = Color3.fromRGB(19, 26, 11),
				["Section Box"] = Color3.fromRGB(14, 20, 8),
				["Console Body"] = Color3.fromRGB(14, 19, 8),
				["Console Tab"] = Color3.fromRGB(19, 26, 11),
				["Element"] = Color3.fromRGB(21, 29, 12)
			},

			["Vaporwave"] = {
				["Background"] = Color3.fromRGB(30, 18, 34),
				["Inline"] = Color3.fromRGB(29, 17, 33),
				["Content"] = Color3.fromRGB(27, 16, 32),
				["Text"] = Color3.fromRGB(228, 201, 230),
				["Outline 1"] = Color3.fromRGB(46, 27, 52),
				["Outline 2"] = Color3.fromRGB(39, 23, 45),
				["Outline 3"] = Color3.fromRGB(20, 12, 22),
				["Outline 4"] = Color3.fromRGB(13, 8, 15),
				["Inactive Text"] = Color3.fromRGB(158, 124, 162),
				["Accent"] = Color3.fromRGB(255, 61, 168),
				["Hovered Element"] = Color3.fromRGB(46, 27, 52),
				["Slider Track"] = Color3.fromRGB(31, 19, 36),
				["Section Box"] = Color3.fromRGB(23, 14, 27),
				["Console Body"] = Color3.fromRGB(22, 13, 26),
				["Console Tab"] = Color3.fromRGB(31, 19, 36),
				["Element"] = Color3.fromRGB(34, 20, 39)
			},

			["Abyss"] = {
				["Background"] = Color3.fromRGB(13, 23, 30),
				["Inline"] = Color3.fromRGB(12, 22, 29),
				["Content"] = Color3.fromRGB(12, 21, 27),
				["Text"] = Color3.fromRGB(193, 221, 232),
				["Outline 1"] = Color3.fromRGB(19, 35, 46),
				["Outline 2"] = Color3.fromRGB(16, 30, 39),
				["Outline 3"] = Color3.fromRGB(8, 15, 20),
				["Outline 4"] = Color3.fromRGB(6, 10, 13),
				["Inactive Text"] = Color3.fromRGB(112, 146, 162),
				["Accent"] = Color3.fromRGB(0, 224, 255),
				["Hovered Element"] = Color3.fromRGB(19, 35, 46),
				["Slider Track"] = Color3.fromRGB(13, 24, 31),
				["Section Box"] = Color3.fromRGB(10, 18, 23),
				["Console Body"] = Color3.fromRGB(9, 17, 22),
				["Console Tab"] = Color3.fromRGB(13, 24, 31),
				["Element"] = Color3.fromRGB(14, 26, 34)
			},

			["Solar Flare"] = {
				["Background"] = Color3.fromRGB(32, 21, 12),
				["Inline"] = Color3.fromRGB(31, 20, 11),
				["Content"] = Color3.fromRGB(29, 19, 10),
				["Text"] = Color3.fromRGB(233, 211, 187),
				["Outline 1"] = Color3.fromRGB(49, 32, 18),
				["Outline 2"] = Color3.fromRGB(42, 28, 15),
				["Outline 3"] = Color3.fromRGB(21, 14, 8),
				["Outline 4"] = Color3.fromRGB(14, 9, 5),
				["Inactive Text"] = Color3.fromRGB(163, 134, 106),
				["Accent"] = Color3.fromRGB(255, 122, 26),
				["Hovered Element"] = Color3.fromRGB(49, 32, 18),
				["Slider Track"] = Color3.fromRGB(34, 22, 12),
				["Section Box"] = Color3.fromRGB(25, 17, 9),
				["Console Body"] = Color3.fromRGB(24, 16, 8),
				["Console Tab"] = Color3.fromRGB(34, 22, 12),
				["Element"] = Color3.fromRGB(36, 24, 13)
			},

			["Ultraviolet"] = {
				["Background"] = Color3.fromRGB(24, 15, 36),
				["Inline"] = Color3.fromRGB(23, 15, 34),
				["Content"] = Color3.fromRGB(22, 14, 33),
				["Text"] = Color3.fromRGB(216, 200, 238),
				["Outline 1"] = Color3.fromRGB(37, 23, 54),
				["Outline 2"] = Color3.fromRGB(32, 20, 46),
				["Outline 3"] = Color3.fromRGB(16, 10, 23),
				["Outline 4"] = Color3.fromRGB(10, 7, 16),
				["Inactive Text"] = Color3.fromRGB(140, 122, 172),
				["Accent"] = Color3.fromRGB(166, 77, 255),
				["Hovered Element"] = Color3.fromRGB(37, 23, 54),
				["Slider Track"] = Color3.fromRGB(25, 16, 37),
				["Section Box"] = Color3.fromRGB(19, 12, 28),
				["Console Body"] = Color3.fromRGB(18, 11, 26),
				["Console Tab"] = Color3.fromRGB(25, 16, 37),
				["Element"] = Color3.fromRGB(27, 17, 40)
			},

			["Frostbite"] = {
				["Background"] = Color3.fromRGB(19, 23, 29),
				["Inline"] = Color3.fromRGB(18, 22, 28),
				["Content"] = Color3.fromRGB(17, 21, 26),
				["Text"] = Color3.fromRGB(209, 226, 238),
				["Outline 1"] = Color3.fromRGB(29, 35, 44),
				["Outline 2"] = Color3.fromRGB(25, 30, 38),
				["Outline 3"] = Color3.fromRGB(12, 15, 19),
				["Outline 4"] = Color3.fromRGB(8, 10, 12),
				["Inactive Text"] = Color3.fromRGB(132, 151, 167),
				["Accent"] = Color3.fromRGB(125, 214, 255),
				["Hovered Element"] = Color3.fromRGB(29, 35, 44),
				["Slider Track"] = Color3.fromRGB(20, 24, 30),
				["Section Box"] = Color3.fromRGB(15, 18, 22),
				["Console Body"] = Color3.fromRGB(14, 17, 21),
				["Console Tab"] = Color3.fromRGB(20, 24, 30),
				["Element"] = Color3.fromRGB(21, 26, 32)
			},

			["Sakura"] = {
				["Background"] = Color3.fromRGB(30, 20, 24),
				["Inline"] = Color3.fromRGB(29, 19, 23),
				["Content"] = Color3.fromRGB(28, 18, 22),
				["Text"] = Color3.fromRGB(236, 210, 218),
				["Outline 1"] = Color3.fromRGB(46, 31, 37),
				["Outline 2"] = Color3.fromRGB(40, 26, 32),
				["Outline 3"] = Color3.fromRGB(20, 13, 16),
				["Outline 4"] = Color3.fromRGB(13, 9, 11),
				["Inactive Text"] = Color3.fromRGB(166, 134, 146),
				["Accent"] = Color3.fromRGB(255, 138, 190),
				["Hovered Element"] = Color3.fromRGB(46, 31, 37),
				["Slider Track"] = Color3.fromRGB(32, 21, 25),
				["Section Box"] = Color3.fromRGB(24, 16, 19),
				["Console Body"] = Color3.fromRGB(22, 15, 18),
				["Console Tab"] = Color3.fromRGB(32, 21, 25),
				["Element"] = Color3.fromRGB(34, 23, 28)
			}
		}
		Library.PresetOrder = { "Vitality", "Matrix", "Toxic", "Vaporwave", "Abyss", "Solar Flare", "Ultraviolet", "Frostbite", "Sakura" }

		Library.SetTheme = function(Self, Name)
			local Preset = Library.Presets[Name]

			if not Preset then
				return false
			end

			for Key, Fallback in Library.Presets["Vitality"] do
				local Color = Preset[Key] or Fallback

				Library.Theme[Key] = Color
				Library:ChangeTheme(Key, Color)

				local Setter = Library.SetFlags[Key]

				if Setter then
					pcall(Setter, Color)
				end
			end

			Library.CurrentTheme = Name
			return true
		end
			-- ================================================================
			-- Alpine pixel fonts
			--
			-- Strategy: custom pixel TTFs (option A).
			-- VerdanaPixel is the body/readout and bold header face; TahomaPixel
			-- is the bar face. These match the GDI bitmap faces used by the C++
			-- reference and the advance table in the widget layer.
			--
			-- Hosted on GitHub, downloaded once, cached in the executor folder.
			-- Cache names are versioned; bumping the version forces every client
			-- to drop an older TTF and descriptor instead of silently keeping it.
			-- No embedded base64 payload, no built-in font fallback ambiguity.
			-- ================================================================

			Library.FontCacheVersion = 7
			Library.FontStatus = { }
			Library.FontErrors = { }
			Library.FontSources = { }

			-- These are the exact pixel faces the Alpine metrics were measured
			-- against: VerdanaPixel for rows and headers, TahomaPixel for the bar.
			local FontBase = "https://raw.githubusercontent.com/i77lhm/storage/main/fonts/"
			local FontTag = "?v=7"

			local function ValidTTF(Body)
				if type(Body) ~= "string" or #Body < 2048 then
					return false
				end

				local B0, B1, B2, B3 = string.byte(Body, 1, 4)

				return (B0 == 0 and B1 == 1 and B2 == 0 and B3 == 0)
					or (B0 == 79 and B1 == 84 and B2 == 84 and B3 == 79)
					or (B0 == 116 and B1 == 114 and B2 == 117 and B3 == 101)
			end

			local function AssetDir()
				local Directory = Library.Directory .. Library.Folders.Assets

				if makefolder and isfolder then
					if not isfolder(Library.Directory) then
						makefolder(Library.Directory)
					end

					if not isfolder(Directory) then
						makefolder(Directory)
					end
				end

				return Directory
			end

			local function Describe(Path, Family, Face, Weight)
				-- Font family descriptor. The reference executor scripts use .font
				-- for this JSON document; keep that convention so executors that
				-- resolve the asset by extension see the same file type they use.
				local Descriptor = Path:gsub("%.ttf$", ".font")

				-- rewrite the descriptor on every load: a stale descriptor can
				-- otherwise keep pointing at an old asset id forever
				if isfile and isfile(Descriptor) and delfile then
					pcall(delfile, Descriptor)
				end

				writefile(Descriptor, HttpService:JSONEncode({
					name = Family,
					faces = {
						{
							name = Face,
							weight = Weight,
							style = "normal",
							assetId = getcustomasset(Path),
						},
					},
				}))

				return Descriptor
			end

			local function LoadFace(Key, Family, Face, Weight, Files)
				local Ok, Result = pcall(function()
					local Directory = AssetDir()
					local Path = Directory .. "/" .. Key .. ".ttf"
					local FallbackMarker = Path .. ".fallback"

					local Cached = false

					-- a cached fallback must not shadow the pixel font after it is
					-- uploaded; retry the primary URL on the next run instead.
					if isfile and isfile(FallbackMarker) then
						Cached = false
					end

					if not Cached and isfile and isfile(Path) then
						if readfile then
							local ReadOk, Body = pcall(readfile, Path)
							Cached = ReadOk and ValidTTF(Body) or false
						else
							Cached = true
						end
					end

					if not Cached then
						if isfile and isfile(Path) and delfile then
							pcall(delfile, Path)
						end

						local Body
						local Source

						for Index, File in ipairs(Files) do
							local HttpOk, Download = pcall(function()
								return game:HttpGet(FontBase .. File .. FontTag)
							end)

							if HttpOk and ValidTTF(Download) then
								Body = Download
								Source = Index == 1 and "github" or "fallback"
								break
							end
						end

						if not Body then
							error("download failed: " .. FontBase .. tostring(Files[1]) .. FontTag)
						end

						writefile(Path, Body)
						Library.FontSources[Key] = Source

						if Source == "fallback" then
							if writefile then
								pcall(writefile, FallbackMarker, "1")
							end
						elseif Source == "github" and delfile and isfile and isfile(FallbackMarker) then
							pcall(delfile, FallbackMarker)
						end
					else
						Library.FontSources[Key] = "cache"
					end

					local Descriptor = Describe(Path, Family, Face, Weight)

					local Font = Font.new(
						getcustomasset(Descriptor),
						Weight >= 700 and Enum.FontWeight.Bold or Enum.FontWeight.Regular,
						Enum.FontStyle.Normal
					)

					if Font == nil then
						error("Font.new returned nil")
					end

					return Font
				end)

				if Ok and Result ~= nil then
					Library.FontStatus[Key] = true
					Library.FontErrors[Key] = nil
					return Result
				end

				Library.FontStatus[Key] = false
				Library.FontErrors[Key] = tostring(Result)
				Library.FontSources[Key] = nil

				return nil
			end

			Library.Font = LoadFace("AlpineVerdanaPixel-v7-Regular", "AlpineVerdanaPixelV7", "Regular", 400, {
				"VerdanaPixel-Regular.ttf",
				"Verdana-Font.ttf",
			}) or Font.fromEnum(Enum.Font.Arial)
			Library.BoldFont = LoadFace("AlpineVerdanaPixel-v7-Bold", "AlpineVerdanaPixelV7Bold", "Bold", 700, {
				"VerdanaPixel-Bold.ttf",
				"Tahoma-Modern-Bold.ttf",
			}) or Font.fromEnum(Enum.Font.ArialBold)
			Library.BarFont = LoadFace("AlpineTahomaPixel-v7-Bar", "AlpineTahomaPixelV7Bar", "Regular", 400, {
				"TahomaPixel-Bar.ttf",
				"Tahoma-Modern.ttf",
			}) or Font.fromEnum(Enum.Font.Arial)

			Library.FontSize = 12
			Library.BarFontSize = 12
		Library.Exit = function(Self)
			for _, Layer in Library.Layers do
				pcall(function()
					Layer.Instance:Destroy()
				end)
			end

			table.clear(Library.Layers)
			table.clear(Library.WindowLayers)
			for _, Connection in Library.Connections do
				Connection:Disconnect()
			end

			for _, Thread in Library.Threads do
				coroutine.close(Thread)
			end

			if Self.Holder then
				Self.Holder.Instance:Destroy()
			end

			if Self.UnusedHolder then
				Self.UnusedHolder.Instance:Destroy()
			end

			Library = nil
			getgenv().Library = nil
		end

		Library.Create = function(Self, Class, Properties)
			local Data = {
				Class = Class,
				Properties = Properties,
				Instance = Instance.new(Class)
			}

			for Index, Property in Properties do
				if Property == "FontFace" then
					Data.Instance[Property] = Library.Font
				elseif Property == "TextSize" then
					Data.Instance[Property] = Library.FontSize
				elseif Property == "Name" then
					Data.Instance[Property] = "\0"
				elseif Class == "TextButton" and Property == "AutoButtonColor" then
					Data.Instance[Property] = false
				elseif Class == "TextButton" and Property == "Text" then
					Data.Instance[Property] = ""
				else
					Data.Instance[Index] = Property
				end
			end

			return setmetatable(Data, Library)
		end

		Library.Thread = function(Self, Function)
			local NewThread = coroutine.create(Function)

			coroutine.wrap(function()
				coroutine.resume(NewThread)
			end)()

			table.insert(Library.Threads, NewThread)
			return NewThread
		end

		Library.Connect = function(Self, Signal, Callback)
			local Connection

			if Self.Instance then
				if Self.Instance[Signal] then
					if IsMobile and Signal == "MouseButton1Down" then
						Connection = Self.Instance.InputBegan:Connect(function(Input)
							if Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseButton1 then
								Callback(Input)
							end
						end)

						return
					end

					Connection = Self.Instance[Signal]:Connect(Callback)
				else
					Connection = Signal:Connect(Callback)
				end
			else
				Connection = Signal:Connect(Callback)
			end

			table.insert(Library.Connections, Connection)
			return Connection
		end

		Library.Tween = function(Self, Properties, Info, IsRawItem)
			local Object = Self.Instance or IsRawItem
			Info = Info or TweenInfo.new(Library.Animation.Time, Enum.EasingStyle[Library.Animation.Style], Enum.EasingDirection[Library.Animation.Direction])

			if not Object then
				return
			end

			local NewTween = TweenService:Create(Object, Info, Properties)
			NewTween:Play()

			if Object:IsA("TextLabel") then
				local Stroke = Object:FindFirstChildOfClass("UIStroke")

				if Stroke and Properties.TextTransparency then
					TweenService:Create(Stroke, Info, {
						Transparency = Properties.TextTransparency
					}):Play()
				end
			end

			return NewTween
		end

		Library.GetTweenProperty = function(Self, IsRawItem)
			local Object = Self.Instance or IsRawItem

			if not Object then
				return { }
			end

			if Object:IsA("Frame") then
				return { "BackgroundTransparency" }
			elseif Object:IsA("TextLabel") or Object:IsA("TextButton") then
				return { "TextTransparency", "BackgroundTransparency" }
			elseif Object:IsA("ImageLabel") or Object:IsA("ImageButton") then
				return { "BackgroundTransparency", "ImageTransparency" }
			elseif Object:IsA("ScrollingFrame") then
				return { "BackgroundTransparency", "ScrollBarImageTransparency" }
			elseif Object:IsA("TextBox") then
				return { "TextTransparency", "BackgroundTransparency" }
			elseif Object:IsA("UIStroke") then
				return { "Transparency" }
			end
		end

		Library.Fade = function(Self, Property, Visibility, IsRawItem)
			local Object = Self.Instance or IsRawItem

			if not Object then
				return
			end

			local OldTransparency = Object[Property]
			Object[Property] = Visibility and 1 or OldTransparency

			local NewTween = Library:Tween({
				[Property] = Visibility and OldTransparency or 1
			}, nil, Object)

			NewTween.Completed:Once(function()
				if not Visibility then
					task.wait()
					Object[Property] = OldTransparency
				end
			end)

			return NewTween
		end

		Library.FadeLimit = 90

		Library.FadeDescendants = function(Self, Visibility, Callback)
			if Visibility then
				Self.Instance.Visible = true
			end

			local Children = Self.Instance:GetDescendants()
			table.insert(Children, Self.Instance)

			if #Children > (Library.FadeLimit or 90) then
				Self.Instance.Visible = Visibility

				if Callback and type(Callback) == "function" then
					Callback()
				end

				return
			end

			local NewTween

			for _, Child in Children do
				local TransparencyProperty = Library:GetTweenProperty(Child)

				if TransparencyProperty then
					if type(TransparencyProperty) == "table" then
						for _, Property in TransparencyProperty do
							NewTween = Library:Fade(Property, Visibility, Child)
						end
					else
						NewTween = Library:Fade(TransparencyProperty, Visibility, Child)
					end
				end
			end

			if not NewTween then
				Self.Instance.Visible = Visibility

				if Callback and type(Callback) == "function" then
					Callback()
				end

				return
			end

			NewTween.Completed:Once(function()
				if Callback and type(Callback) == "function" then
					Callback()
				end

				Self.Instance.Visible = Visibility
			end)
		end

		Library.DragClaimed = false

		Library.ClaimDrag = function(Self)
			Library.DragClaimed = true
		end

		Library:Connect(UserInputService.InputEnded, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				Library.DragClaimed = false
			end
		end)

		Library.MakeDraggable = function(Self)
			if not Self.Instance then
				return
			end

			local Gui = Self.Instance
			local Dragging = false
			local DragStart
			local StartPosition

			local Set = function(Input)
				local DragDelta = Input.Position - DragStart
				local NewX = StartPosition.X.Offset + DragDelta.X
				local NewY = StartPosition.Y.Offset + DragDelta.Y

				local ScreenSize = Gui.Parent.AbsoluteSize
				local GuiSize = Gui.AbsoluteSize

				NewX = math.clamp(NewX, 0, ScreenSize.X - GuiSize.X)
				NewY = math.clamp(NewY, 0, ScreenSize.Y - GuiSize.Y)

				Self:Tween({Position = UDim2.new(0, NewX, 0, NewY)}, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
			end

			local InputChanged

			Self:Connect("InputBegan", function(Input)
				if Library.DragClaimed then
					return
				end

				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Dragging = true
					DragStart = Input.Position
					StartPosition = Gui.Position

					if InputChanged then
						return
					end

					InputChanged = Input.Changed:Connect(function()
						if Input.UserInputState == Enum.UserInputState.End then
							Dragging = false
							InputChanged:Disconnect()
							InputChanged = nil
						end
					end)
				end
			end)

			Library:Connect(UserInputService.InputChanged, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
					if Dragging and not Library.DragClaimed then
						Set(Input)
					end
				end
			end)

			return Dragging
		end

		Library.MakeResizeable = function(Self, Minimum)
			if not Self.Instance then
				return
			end

			local Gui = Self.Instance

			local Resizing = false
			local CurrentSide = nil

			local StartMouse = nil
			local StartPosition = nil
			local StartSize = nil

			local LastX, LastY, LastW, LastH

			local EdgeThickness = 2

			local MakeEdge = function(Name, Position, Size)
				local Button = Library:Create("TextButton", {
					Name = "\0",
					Size = Size,
					Position = Position,
					BackgroundColor3 = Color3.fromRGB(166, 147, 243),
					BackgroundTransparency = 1,
					Text = "",
					BorderSizePixel = 0,
					AutoButtonColor = false,
					Parent = Gui,
					ZIndex = 99999,					})

					Button:AddToTheme({BackgroundColor3 = "Accent"})

				return Button
			end

			local Edges = {
				{Button = MakeEdge(
					"Left",
					UDim2.new(0, 0, 0, 0),
					UDim2.new(0, EdgeThickness, 1, 0)),
					Side = "L"
				},

				{Button = MakeEdge(
					"Right",
					UDim2.new(1, -EdgeThickness, 0, 0),
					UDim2.new(0, EdgeThickness, 1, 0)),
					Side = "R"
				},

				{Button = MakeEdge(
					"Top", UDim2.new(0, 0, 0, 0),
					UDim2.new(1, 0, 0, EdgeThickness)),
					Side = "T"
				},

				{Button = MakeEdge(
					"Bottom",
					UDim2.new(0, 0, 1, -EdgeThickness),
					UDim2.new(1, 0, 0, EdgeThickness)),
					Side = "B"
				},
			}

			local CornerThickness = 6

			for _, Corner in {
				{Side = "TL", Position = UDim2.new(0, 0, 0, 0)},
				{Side = "TR", Position = UDim2.new(1, -CornerThickness, 0, 0)},
				{Side = "BL", Position = UDim2.new(0, 0, 1, -CornerThickness)},
				{Side = "BR", Position = UDim2.new(1, -CornerThickness, 1, -CornerThickness)}
			} do
				table.insert(Edges, {
					Button = MakeEdge(Corner.Side, Corner.Position, UDim2.new(0, CornerThickness, 0, CornerThickness)),
					Side = Corner.Side
				})
			end

			local BeginResizing = function(Side)
				Resizing = true
				CurrentSide = Side

				StartMouse = UserInputService:GetMouseLocation()

				StartPosition = Vector2.new(Gui.Position.X.Offset, Gui.Position.Y.Offset)
				StartSize = Vector2.new(Gui.Size.X.Offset, Gui.Size.Y.Offset)

				for Index, Value in Edges do
					Value.Button.Instance.BackgroundTransparency = (Value.Side == Side) and 0 or 1
				end
			end

			local EndResizing = function()
				Resizing = false
				CurrentSide = nil

				for Index, Value in Edges do
					Value.Button.Instance.BackgroundTransparency = 1
				end
			end

			for Index, Value in Edges do
				Value.Button:Connect("InputBegan", function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
						Library:ClaimDrag()

						BeginResizing(Value.Side)
					end
				end)
			end

			Library:Connect(UserInputService.InputEnded, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if Resizing then
						EndResizing()
					end
				end
			end)

			Library:Connect(RunService.RenderStepped, function()
				if not Resizing or not CurrentSide then
					return
				end

				local MouseLocation = UserInputService:GetMouseLocation()
				local dx = MouseLocation.X - StartMouse.X
				local dy = MouseLocation.Y - StartMouse.Y

				local x, y = StartPosition.X, StartPosition.Y
				local w, h = StartSize.X, StartSize.Y

				if string.find(CurrentSide, "L") then
					x = StartPosition.X + dx
					w = StartSize.X - dx
				elseif string.find(CurrentSide, "R") then
					w = StartSize.X + dx
				end

				if string.find(CurrentSide, "T") then
					y = StartPosition.Y + dy
					h = StartSize.Y - dy
				elseif string.find(CurrentSide, "B") then
					h = StartSize.Y + dy
				end

				if w < Minimum.X then
					if string.find(CurrentSide, "L") then
						x = x - (Minimum.X - w)
					end
					w = Minimum.X
				end
				if h < Minimum.Y then
					if string.find(CurrentSide, "T") then
						y = y - (Minimum.Y - h)
					end
					h = Minimum.Y
				end

				if x ~= LastX or y ~= LastY then
					LastX, LastY = x, y

					Gui.Position = UDim2.fromOffset(x, y)
				end

				if w ~= LastW or h ~= LastH then
					LastW, LastH = w, h

					Gui.Size = UDim2.fromOffset(w, h)
				end
			end)
		end

		Library.Shade = function(Self, Item, Strength)
			local Object = typeof(Item) == "Instance" and Item or (type(Item) == "table" and Item.Instance)

			if not Object then
				return
			end

			for Index, Child in Object:GetChildren() do
				if Child:IsA("UIGradient") then
					Child:Destroy()
				end
			end

			Strength = Strength or 1

			local Middle = math.clamp(255 - 29 * Strength, 0, 255)
			local Bottom = math.clamp(255 - 71 * Strength, 0, 255)

			return Library:Create("UIGradient", {
				Name = "\0",
				Parent = Object,
				Rotation = 90,
				Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(Middle, Middle, Middle)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(Bottom, Bottom, Bottom))
				}
			})
		end

		Library.HolderOffset = function(Self)
			local Holder = Library.Holder and Library.Holder.Instance

			return Holder and Holder.AbsolutePosition.Y or -GuiInset
		end

		Library.MousePoint = function(Self)
			return Vector2.new(Mouse.X, Mouse.Y + GuiInset + Library:HolderOffset())
		end

		Library.HolderPoint = function(Self, Point)
			return Vector2.new(Point.X, Point.Y - Library:HolderOffset())
		end

		Library.IsMouseOverFrame = function(Self)
			if not Self.Instance then
				return
			end

			local Object = Self.Instance

			local MousePosition = Library:MousePoint()

			return MousePosition.X >= Object.AbsolutePosition.X and MousePosition.X <= Object.AbsolutePosition.X + Object.AbsoluteSize.X
			and MousePosition.Y >= Object.AbsolutePosition.Y and MousePosition.Y <= Object.AbsolutePosition.Y + Object.AbsoluteSize.Y
		end

		Library.ResolveParent = function(Self, Parent)
			if not Parent then
				return nil
			end

			if typeof(Parent) == "Instance" then
				return Parent
			end

			if Parent.Instance then
				return Parent.Instance
			end

			if Parent.Items then
				local Content = Parent.Items["Content"]

				if Content then
					return Content.Instance or Content
				end
			end

			return nil
		end

		Library.SafeCall = function(Self, Function, ...)
			local Arguements = { ... }
			local Success, Result = pcall(Function, table.unpack(Arguements))

			if not Success then
				warn(Result)
				return false
			end

			return Success, Result
		end

		Library.Round = function(Self, Number, Float)
			if not Float or Float <= 0 then
				return math.floor(Number + 0.5)
			end

			local Multiplier = 1 / Float
			return math.floor(Number * Multiplier + 0.5) / Multiplier
		end

		Library.GetConfig = function(Self)
			local Config = { }

			local Success, Result = Library:SafeCall(function()
				for Index, Value in Library.Flags do
					if type(Value) == "table" and Value.Key then
						Config[Index] = {Key = tostring(Value.Key), Mode = Value.Mode}
					elseif type(Value) == "table" and Value.Color then
						Config[Index] = {Color = "#" .. Value.HexValue, Alpha = Value.Alpha}
					else
						Config[Index] = Value
					end
				end
			end)

			if not Success then
				warn("Failed to get config:\n"..Result)
				return
			end

			return HttpService:JSONEncode(Config)
		end

		Library.LoadConfig = function(Self, Config)
			local Decoded = HttpService:JSONDecode(Config)

			local Success, Result = Library:SafeCall(function()
				for Index, Value in Decoded do
					local SetFunction = Library.SetFlags[Index]

					if SetFunction then
						if type(Value) == "table" and Value.Key then
							SetFunction(Value)
						elseif type(Value) == "table" and Value.Color then
							SetFunction(Value.Color, Value.Alpha)
						else
							SetFunction(Value)
						end
					end
				end
			end)

			return Success, Result
		end

		Library.GetConfigsList = function(Self, Element)
			local List = { }
			local ReturnList = { }

			List = listfiles(Library.Directory .. Library.Folders.Configs)

			for Index = 1, #List do
				local File = List[Index]

				if File:sub(-5) == ".json" then
					local Position = File:find(".json", 1, true)
					local StartPosition = Position

					local Character = File:sub(Position, Position)
					while Character ~= "/" and Character ~= "\\" and Character ~= "" do
						Position = Position - 1
						Character = File:sub(Position, Position)
					end

					if Character == "/" or Character == "\\" then
						table.insert(ReturnList, File:sub(Position + 1, StartPosition - 1))
					end
				end
			end

			Element:Refresh(ReturnList)
		end

		Library.GetThemesList = function(Self, Element)
			local List = { }
			local ReturnList = { }

			List = listfiles(Library.Directory .. Library.Folders.Themes)

			for Index = 1, #List do
				local File = List[Index]

				if File:sub(-5) == ".json" then
					local Position = File:find(".json", 1, true)
					local StartPosition = Position

					local Character = File:sub(Position, Position)
					while Character ~= "/" and Character ~= "\\" and Character ~= "" do
						Position = Position - 1
						Character = File:sub(Position, Position)
					end

					if Character == "/" or Character == "\\" then
						table.insert(ReturnList, File:sub(Position + 1, StartPosition - 1))
					end
				end
			end

			Element:Refresh(ReturnList)
		end

		Library.AddToTheme = function(Self, Properties)
			local Object = Self.Instance

			local ThemeData = {
				Item = Object,
				Properties = Properties,
			}

			for Property, Value in ThemeData.Properties do
				if type(Value) == "string" then
					if not Library.Theme[Value] then
						Object[Property] = Value
					end

					Object[Property] = Library.Theme[Value]
				else
					Object[Property] = Value()
				end
			end

			table.insert(Library.ThemingStuff, ThemeData)
			Library.ThemeMap[Object] = ThemeData

			Library.ThemeIndex = nil

			return Self
		end

		Library.ChangeItemTheme = function(Self, Properties)
			local Object = Self.Instance

			if not Library.ThemeMap[Object] then
				return
			end

			Library.ThemeMap[Object].Properties = Properties
			Library.ThemeMap[Object] = Library.ThemeMap[Object]

			Library.ThemeIndex = nil
		end

		Library.BuildThemeIndex = function()
			local Index = { }
			local Dynamic = { }

			for _, Item in Library.ThemingStuff do
				for Property, Value in Item.Properties do
					if type(Value) == "string" then
						local Bucket = Index[Value]

						if not Bucket then
							Bucket = { }
							Index[Value] = Bucket
						end

						table.insert(Bucket, {Item = Item.Item, Property = Property})
					elseif type(Value) == "function" then
						table.insert(Dynamic, {Item = Item.Item, Property = Property, Value = Value})
					end
				end
			end

			Library.ThemeIndex = Index
			Library.DynamicTheming = Dynamic

			return Index
		end

		Library.ChangeTheme = function(Self, Theme, Color)
			Library.Theme[Theme] = Color

			local Index = Library.ThemeIndex or Library.BuildThemeIndex()
			local Bucket = Index[Theme]

			if Bucket then
				for _, Entry in Bucket do
					Entry.Item[Entry.Property] = Color
				end
			end

			for _, Entry in Library.DynamicTheming do
				Entry.Item[Entry.Property] = Entry.Value()
			end
		end

		Library.OnHover = function(Self, OnHoverEnter, OnHoverLeave)
			local Object = Self.Instance

			if not Object then
				return
			end

			Library:Connect(Object.MouseEnter, OnHoverEnter)
			Library:Connect(Object.MouseLeave, OnHoverLeave)
		end

		Library.SearchThreshold = 10

		Library.IconAssets = { }

		Library.IconTint = true
		Library.IconTints = { }

		Library.IconThumbnailFallback = false

		Library.IconStatus = { }

		Library.SetIcon = function(Self, Key, Asset, Tint)
			Library.IconAssets[Key] = Asset

			if Tint ~= nil then
				Library.IconTints[Key] = Tint
			end
		end

		Library.IconRound = function(Self, Piece, Radius)
			if not Piece then
				return Piece
			end

			Library:Create("UICorner", {
				Name = "\0",
				Parent = Piece.Instance,
				CornerRadius = UDim.new(0, Radius or 2)
			})

			return Piece
		end

		Library.IconImage = function(Self, Button, Key, Registry)
			local Asset = Library.IconAssets[Key]

			if type(Asset) == "number" then
				Asset = tostring(Asset)
			end

			if type(Asset) ~= "string" or Asset == "" then
				return false
			end

			local Id = string.match(Asset, "^%s*(%d+)%s*$") or string.match(Asset, "rbxassetid://(%d+)")
			local Sources = { }

			if Id then
				table.insert(Sources, "rbxassetid://" .. Id)

				if Library.IconThumbnailFallback then
					table.insert(Sources, "rbxthumb://type=Asset&id=" .. Id .. "&w=150&h=150")
				end
			else
				table.insert(Sources, Asset)
			end

			local Glyphs = { }

			for _, Child in Button.Instance:GetChildren() do
				if Child:IsA("GuiObject") then
					table.insert(Glyphs, Child)
				end
			end

			local Tint = Library.IconTints[Key]

			if Tint == nil then
				Tint = Library.IconTint ~= false
			end

			local Image = Library:Create("ImageLabel", {
				Name = "\0",
				Parent = Button.Instance,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Size = UDim2.new(0, 16, 0, 16),
				ZIndex = 62,
				Visible = false,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ScaleType = Enum.ScaleType.Fit,
				Image = Sources[1],
				ImageColor3 = Tint and Library.Theme["Accent"] or Color3.fromRGB(255, 255, 255)
			})

			if Tint then
				Image:AddToTheme({ImageColor3 = 'Accent'})

				if Registry then
					table.insert(Registry, {Item = Image, Property = "ImageColor3"})
				end
			end

			Library:Thread(function()
				local Provider

				pcall(function()
					Provider = game:GetService("ContentProvider")
				end)

				for _, Source in ipairs(Sources) do
					Image.Instance.Image = Source

					if Provider then
						pcall(function()
							Provider:PreloadAsync({Image.Instance})
						end)
					end

					local Clock = os.clock()

					while not Image.Instance.IsLoaded and os.clock() - Clock < 3 do
						task.wait(0.05)
					end

					if Image.Instance.IsLoaded then
						Image.Instance.Visible = true

						for _, Glyph in Glyphs do
							Glyph.Visible = false
						end

						Library.IconStatus[Key] = "loaded"
						return
					end
				end

				Library.IconStatus[Key] = "failed"
			end)

			return true
		end

		Library.AccentGradientStart = Color3.fromRGB(255, 255, 255)
		Library.AccentGradientEnd = Color3.fromRGB(210, 210, 210)

		Library.AccentGradient = function(Self, Item, Rotation)
			local Target = Item and (Item.Instance or Item)

			if not Target then return end

			return Library:Create("UIGradient", {
				Name = "\0",
				Parent = Target,
				Rotation = Rotation or 0,
				Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Library.AccentGradientStart),
					ColorSequenceKeypoint.new(1, Library.AccentGradientEnd)
				}
			})
		end

		Library.Build = "r25-staff-fix"

		Library.Scrollbars = { }

		Library.ScrollbarGradient = function(Self, Item)
			return Library:Create("UIGradient", {
				Name = "\0",
				Parent = Item and (Item.Instance or Item),
				Rotation = 90,
				Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(0.4, Color3.fromRGB(252, 252, 252)),
					ColorSequenceKeypoint.new(0.45, Color3.fromRGB(243, 243, 243)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(222, 222, 222)),
					ColorSequenceKeypoint.new(0.55, Color3.fromRGB(200, 200, 200)),
					ColorSequenceKeypoint.new(0.6, Color3.fromRGB(186, 186, 186)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 180, 180))
				}
			})
		end

		Library.Scrollbar = function(Self, Scroll, Params)
			Params = Params or { }

			local Target = Scroll and (Scroll.Instance or Scroll)

			if not Target then
				return
			end

			local Holder = Params.Parent and (Params.Parent.Instance or Params.Parent) or Target.Parent

			if not (Holder and Holder:IsA("GuiObject")) then
				return
			end

			local Thickness = Params.Thickness or 2
			local Right = Params.Right or 4
			local Top = Params.Top or 30
			local Bottom = Params.Bottom or 0
			local Layer = Params.ZIndex or 3

			Target.ScrollBarThickness = 0

			local TrackFrame

			if Params.Track then
				TrackFrame = Library:Create("Frame", {
					Name = "\0",
					Parent = Holder,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 0,
					BorderSizePixel = 0,
					Visible = false,
					ZIndex = Layer,
					Size = UDim2.fromOffset(Thickness, 0)
				}).Instance
			end

			local Bar = Library:Create("Frame", {
				Name = "\0",
				Parent = Holder,
				BackgroundColor3 = Library.Theme["Accent"],
				BorderSizePixel = 0,
				Visible = false,
				ZIndex = Layer + 1,
				Size = UDim2.fromOffset(Thickness, 0)
			}):AddToTheme({BackgroundColor3 = 'Accent'})

			Library:ScrollbarGradient(Bar)

			local Entry = {
				Scroll = Target,
				Holder = Holder,
				Bar = Bar.Instance,
				Track = TrackFrame,
				Thickness = Thickness,
				Right = Right,
				Top = Top,
				Bottom = Bottom
			}

			table.insert(Library.Scrollbars, Entry)

			return Entry
		end

		local function ScrollbarVisible(Object)
			while Object and Object:IsA("GuiObject") do
				if not Object.Visible then
					return false
				end

				Object = Object.Parent
			end

			return true
		end

		Library.UpdateScrollbars = function(Self)
			for Index = #Library.Scrollbars, 1, -1 do
				local Entry = Library.Scrollbars[Index]
				local Scroll = Entry.Scroll

				if not (Scroll and Scroll.Parent and Entry.Holder and Entry.Holder.Parent) then
					pcall(function()
						Entry.Bar:Destroy()

						if Entry.Track then
							Entry.Track:Destroy()
						end
					end)

					table.remove(Library.Scrollbars, Index)
				else
					local View = Scroll.AbsoluteSize
					local Canvas = Scroll.AbsoluteCanvasSize

					local Range = Canvas.Y - View.Y

					local Shown = ScrollbarVisible(Scroll)
					local Signature = (Shown and 1 or 0) + View.Y * 4 + Canvas.Y * 8192 + Scroll.CanvasPosition.Y * 67108864

					if Entry.Signature == Signature then
						continue
					end

					Entry.Signature = Signature

					if not Shown or View.Y < 8 or Range < 6 then
						Entry.Bar.Visible = false
						Scroll.ScrollingEnabled = false

						if Entry.Track then
							Entry.Track.Visible = false
						end
					else
						Scroll.ScrollingEnabled = true

						local Track = math.max(View.Y - Entry.Bottom, 8)
						local MinBar = math.min(16, Track)
						local MaxBar = math.max(Track - 6, MinBar)
						local BarHeight = math.clamp(Track * (View.Y / Canvas.Y), MinBar, MaxBar)
						local Progress = math.clamp(Scroll.CanvasPosition.Y / Range, 0, 1)

						if Entry.Track then
							Entry.Track.Size = UDim2.fromOffset(Entry.Thickness, Track)
							Entry.Track.Position = UDim2.new(1, -(Entry.Right + Entry.Thickness), 0, Entry.Top)
							Entry.Track.Visible = true
						end

						Entry.Bar.Size = UDim2.fromOffset(Entry.Thickness, BarHeight)
						Entry.Bar.Position = UDim2.new(1, -(Entry.Right + Entry.Thickness), 0, Entry.Top + (Track - BarHeight) * Progress)
						Entry.Bar.Visible = true
					end
				end
			end
		end

		Library:Connect(RunService.RenderStepped, function()
			Library:UpdateScrollbars()
		end)
		Library.TooltipWatchers = { }

		local function TooltipRendered(Target)
			local Current = Target

			while Current and Current:IsA("GuiObject") do
				if not Current.Visible then
					return false
				end

				Current = Current.Parent
			end

			return Current ~= nil and Current:IsA("LayerCollector") and Current.Enabled
		end

		Library.WatchTooltip = function(Self, Object, Enter, Leave, Step)
			local Watcher = {Object = Object, Enter = Enter, Leave = Leave, Step = Step, State = false}

			table.insert(Library.TooltipWatchers, Watcher)

			if not Library.TooltipLoop then
				Library.TooltipLoop = true

				Library:Connect(RunService.Heartbeat, function(Delta)
					local Point = Library:MousePoint()

					for Index = #Library.TooltipWatchers, 1, -1 do
						local Entry = Library.TooltipWatchers[Index]
						local Target = Entry.Object and Entry.Object.Instance

						if not Target or not Target.Parent then
							table.remove(Library.TooltipWatchers, Index)

							if Entry.State then
								Entry.State = false

								Library:SafeCall(Entry.Leave)
							end

							continue
						end

						local Corner = Target.AbsolutePosition
						local Extent = Target.AbsoluteSize
						local Margin = Entry.State and 2 or 0

						local Over = TooltipRendered(Target)
							and Point.X >= Corner.X - Margin and Point.X <= Corner.X + Extent.X + Margin
							and Point.Y >= Corner.Y - Margin and Point.Y <= Corner.Y + Extent.Y + Margin

						if Over ~= Entry.State then
							Entry.State = Over

							Library:SafeCall(Over and Entry.Enter or Entry.Leave)
						end

						if Entry.Step then
							Library:SafeCall(Entry.Step, Delta, Entry.State)
						end
					end
				end)
			end

			return Watcher
		end

		Library.Tooltip = function(Self, Object, Text, Title)
			if not Object or not Text or Text == "" then
				return
			end

			local Items = { } do
				Items["Tooltip"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Library.Holder.Instance,
					Visible = false,
					ZIndex = 500,
					Size = UDim2.new(0, 190, 0, 26),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Inline"]
				}):AddToTheme({BackgroundColor3 = 'Inline'})

				Items["Outer"] = Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Tooltip"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Transparency = 1,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Items["Ring"] = Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Tooltip"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Transparency = 1,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				Items["Inner"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Tooltip"].Instance,
					BackgroundTransparency = 1,
					ZIndex = 501,
					Position = UDim2.new(0, 3, 0, 3),
					Size = UDim2.new(1, -6, 1, -6),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Content"]
				}):AddToTheme({BackgroundColor3 = 'Content'})

				Library:Create("UIPadding", {
					Name = "\0",
					Parent = Items["Inner"].Instance,
					PaddingTop = UDim.new(0, 4),
					PaddingBottom = UDim.new(0, 4),
					PaddingLeft = UDim.new(0, 6),
					PaddingRight = UDim.new(0, 6)
				})

				Items["Layout"] = Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["Inner"].Instance,
					Padding = UDim.new(0, 2),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				Items["Title"] = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.BoldFont,
					TextSize = Library.FontSize,
					Parent = Items["Inner"].Instance,
					Visible = Title ~= nil and Title ~= "",
					ZIndex = 502,
					LayoutOrder = 1,
					TextColor3 = Library.Theme["Text"],
					Text = tostring(Title or ""),
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 13),
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
					TextWrapped = true,
					AutomaticSize = Enum.AutomaticSize.Y,
					BorderSizePixel = 0
				}):AddToTheme({TextColor3 = 'Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Title"].Instance
				})

				local BodyKey = (Title ~= nil and Title ~= "") and "Inactive Text" or "Text"

				Items["Text"] = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["Inner"].Instance,
					RichText = true,
					ZIndex = 502,
					LayoutOrder = 2,
					TextColor3 = Library.Theme[BodyKey],
					Text = tostring(Text),
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 12),
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
					TextWrapped = true,
					AutomaticSize = Enum.AutomaticSize.Y,
					BorderSizePixel = 0
				}):AddToTheme({TextColor3 = BodyKey})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Text"].Instance
				})
			end

			local function Resize()
				Items["Tooltip"].Instance.Size = UDim2.new(0, 190, 0, Items["Layout"].Instance.AbsoluteContentSize.Y + 14)
			end

			Library:Connect(Items["Layout"].Instance:GetPropertyChangedSignal("AbsoluteContentSize"), Resize)
			Resize()

			local function Position()
				local Box = Object.Instance.AbsolutePosition
				local Extent = Object.Instance.AbsoluteSize

				local X = Box.X + Extent.X + 8
				local Y = Box.Y + Extent.Y / 2

				local Viewport = (Camera or workspace.CurrentCamera).ViewportSize
				local Size = Items["Tooltip"].Instance.AbsoluteSize

				if X + Size.X > Viewport.X - 4 then
					X = math.max(Box.X - Size.X - 8, 4)
				end

				local Anchor = Library:HolderPoint(Vector2.new(X, Y - Size.Y / 2))

				Items["Tooltip"].Instance.Position = UDim2.new(0, Anchor.X, 0, Anchor.Y)
			end

			local TitleStroke = Items["Title"].Instance:FindFirstChildOfClass("UIStroke")
			local TextStroke = Items["Text"].Instance:FindFirstChildOfClass("UIStroke")

			local Alpha = 0
			local Target = 0

			local function Paint()
				local Level = 1 - Alpha

				Items["Tooltip"].Instance.BackgroundTransparency = Level
				Items["Title"].Instance.TextTransparency = Level
				Items["Text"].Instance.TextTransparency = Level
				Items["Outer"].Instance.Transparency = Level
				Items["Ring"].Instance.Transparency = Level

				if TitleStroke then
					TitleStroke.Transparency = Level
				end

				if TextStroke then
					TextStroke.Transparency = Level
				end

				Items["Tooltip"].Instance.Visible = Alpha > 0.002
			end

			Paint()

			Library:WatchTooltip(Object, function()
				Resize()
				Position()

				Target = 1
			end, function()
				Target = 0
			end, function(Delta)
				if Target == 1 then
					Position()
				end

				if Alpha == Target then
					return
				end

				local Move = math.clamp((Delta or 0.016) / 0.12, 0, 1)

				if Target > Alpha then
					Alpha = math.min(Alpha + Move, 1)
				else
					Alpha = math.max(Alpha - Move, 0)
				end

				Paint()
			end)

			return Items["Tooltip"]
		end

		Library.TooltipMark = function(Self, Row, Anchor, Text, Title, BaseX)
			if not Row or not Anchor or not Text or Text == "" then
				return
			end

			local Mark = Library:Create("TextLabel", {
				Name = "\0",
				FontFace = Library.Font,
				TextSize = Library.FontSize,
				Parent = Row.Instance,
				Text = "(?)",
				TextColor3 = Color3.fromRGB(100, 100, 100),
				BackgroundTransparency = 1,
				Position = UDim2.new(0, BaseX or 0, 0, 0),
				Size = UDim2.new(0, 0, 0, 16),
				ZIndex = 4,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X
			})

			Library:Create("UIStroke", {
				Name = "\0",
				Parent = Mark.Instance
			})

			local function Place()
				Mark.Instance.Position = UDim2.new(0, (BaseX or 0) + Anchor.Instance.AbsoluteSize.X + 4, 0, 0)
			end

			Library:Connect(Anchor.Instance:GetPropertyChangedSignal("AbsoluteSize"), Place)
			Place()

			Library:WatchTooltip(Mark, function()
				Mark:Tween({TextColor3 = Color3.fromRGB(175, 175, 175)}, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
			end, function()
				Mark:Tween({TextColor3 = Color3.fromRGB(100, 100, 100)}, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
			end)

			Library:Tooltip(Mark, Text, Title)

			return Mark
		end

		Library.Holder = Library:Create("ScreenGui", {
			Parent = gethui(),
			IgnoreGuiInset = true,
			Name = "\0",
			ZIndexBehavior = Enum.ZIndexBehavior.Global,
			ResetOnSpawn = false
		})

		Library.UnusedHolder = Library:Create("ScreenGui", {
			Parent = gethui(),
			Name = "\0",
			Enabled = false,
			ZIndexBehavior = Enum.ZIndexBehavior.Global,
			ResetOnSpawn = false
		})

		Library.Holder.Instance.DisplayOrder = 1000000

		Library.Layers = { }
		Library.WindowLayers = { }
		Library.LayerOrder = 10

		Library.CreateLayer = function(Self)
			local Layer = Library:Create("ScreenGui", {
				Parent = gethui(),
				IgnoreGuiInset = true,
				Name = "\0",
				DisplayOrder = Library.LayerOrder,
				ZIndexBehavior = Enum.ZIndexBehavior.Global,
				ResetOnSpawn = false
			})

			Library.LayerOrder += 1
			table.insert(Library.Layers, Layer)

			return Layer
		end

		Library.BringToFront = function(Self, Layer)
			if not Layer or not Layer.Instance then
				return
			end

			Library.LayerOrder += 1
			Layer.Instance.DisplayOrder = Library.LayerOrder
		end

		Library.RegisterWindow = function(Self, Item)
			if not Item or not Item.Instance then
				return
			end

			local Layer = Library:CreateLayer()

			Item.Instance.Parent = Layer.Instance
			table.insert(Library.WindowLayers, {Layer = Layer, Frame = Item})

			return Layer
		end

		Library:Connect(UserInputService.InputBegan, function(Input)
			if Input.UserInputType ~= Enum.UserInputType.MouseButton1 and Input.UserInputType ~= Enum.UserInputType.Touch then
				return
			end

			local Target = nil
			local Order = -1

			for _, Entry in Library.WindowLayers do
				local Frame = Entry.Frame.Instance

				if Frame.Visible and Frame.Parent and Frame.Parent.Enabled and Entry.Frame:IsMouseOverFrame() then
					local Current = Entry.Layer.Instance.DisplayOrder

					if Current > Order then
						Target = Entry
						Order = Current
					end
				end
			end

			if Target then
				Library:BringToFront(Target.Layer)
			end
		end)

		Library.NotifHolder = Library:Create("Frame", {
			Name = "\0",
			Parent = Library.Holder.Instance,
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 0, 1, 0),
			BorderSizePixel = 0,
			AutomaticSize = Enum.AutomaticSize.X
		})

		Library:Create("UIListLayout", {
			Name = "\0",
			Parent = Library.NotifHolder.Instance,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 6)
		})

		Library:Create("UIPadding", {
			Name = "\0",
			Parent = Library.NotifHolder.Instance,
			PaddingTop = UDim.new(0, 30),
			PaddingBottom = UDim.new(0, 8),
			PaddingRight = UDim.new(0, 8),
			PaddingLeft = UDim.new(0, 8)
		})

		Library.ConsoleLimit = 150

		Library.Console = function(Self, Params)
			Params = Params or { }

			local ConsoleWindow = {
				Name = Params.Name or Params.name or "Console",
				Size = Params.Size or Params.size or UDim2.new(0, 420, 0, 385),
				Position = Params.Position or Params.position or UDim2.new(0, 380, 0, 150),
				Items = { },
				EntryCount = 0,
				Search = "",
				Filters = {
					["Output"] = true,
					["Info"] = true,
					["Warning"] = true
				}
			}

			local ConsoleFontSize = Library.FontSize

			local Items = { } do
				Items["Console"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Library.Holder.Instance,
					Position = ConsoleWindow.Position,
					Size = ConsoleWindow.Size,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Background"]
				}):AddToTheme({BackgroundColor3 = 'Background'})

				Items["Console"]:MakeDraggable()

				Items["Console"]:MakeResizeable(Vector2.new(300, 240))

				Library:RegisterWindow(Items["Console"])

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Console"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Console"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Console"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 2"],
					BorderOffset = UDim.new(0, 2)
				}):AddToTheme({Color = 'Outline 2'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Console"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 4"],
					BorderOffset = UDim.new(0, 3)
				}):AddToTheme({Color = 'Outline 4'})

				Items["AccentLine"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Console"].Instance,
					Size = UDim2.new(1, 0, 0, 1),
					Position = UDim2.new(0, 0, 0, 0),
					BorderSizePixel = 0,
					ZIndex = 3,
					BackgroundColor3 = Library.Theme["Accent"]
				}):AddToTheme({BackgroundColor3 = 'Accent'})

				Items["TitleBand"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Console"].Instance,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(1, 0, 0, 30),
					BorderSizePixel = 0,
					ZIndex = 2,
					BackgroundColor3 = Library.Theme["Console Tab"]
				}):AddToTheme({BackgroundColor3 = 'Console Tab'})

				Library:Create("UIGradient", {
					Name = "\0",
					Parent = Items["TitleBand"].Instance,
					Rotation = 90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(182, 182, 182))
					}
				})

				Items["TitleRule"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["TitleBand"].Instance,
					AnchorPoint = Vector2.new(0, 1),
					Position = UDim2.new(0, 0, 1, 0),
					Size = UDim2.new(1, 0, 0, 1),
					BorderSizePixel = 0,
					ZIndex = 3,
					BackgroundColor3 = Library.Theme["Outline 3"]
				}):AddToTheme({BackgroundColor3 = 'Outline 3'})

				Items["ActualTitle"] = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.BoldFont,
					TextSize = ConsoleFontSize,
					Parent = Items["Console"].Instance,
					RichText = true,
					TextColor3 = Library.Theme["Accent"],
					Text = ConsoleWindow.Name,
					ZIndex = 3,
					Size = UDim2.new(0, 0, 0, 18),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 8, 0, 9),
					AutomaticSize = Enum.AutomaticSize.X
				}):AddToTheme({TextColor3 = 'Accent'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["ActualTitle"].Instance
				})

				Items["Header"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Console"].Instance,
					Position = UDim2.new(0, 8, 0, 36),
					Size = UDim2.new(1, -16, 0, 26),
					BackgroundTransparency = 1,
					BorderSizePixel = 0
				})

				Items["SearchBackground"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Header"].Instance,
					ClipsDescendants = true,
					Size = UDim2.new(0.45, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Element"]
				}):AddToTheme({BackgroundColor3 = 'Element'})

				Library:Create("UIGradient", {
					Name = "\0",
					Parent = Items["SearchBackground"].Instance,
					Rotation = 90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(184, 184, 184))
					}
				})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["SearchBackground"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Items["Search"] = Library:Create("TextBox", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = ConsoleFontSize,
					Parent = Items["SearchBackground"].Instance,
					Active = false,
					Selectable = false,
					AnchorPoint = Vector2.new(0, 0.5),
					PlaceholderColor3 = Library.Theme["Inactive Text"],
					PlaceholderText = "Search...",
					TextXAlignment = Enum.TextXAlignment.Left,
					Size = UDim2.new(1, -20, 0, 20),
					TextColor3 = Library.Theme["Text"],
					Text = "",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 0.5, 0),
					CursorPosition = -1,
					ClearTextOnFocus = false,
					BorderSizePixel = 0
				}):AddToTheme({TextColor3 = 'Text', PlaceholderColor3 = 'Inactive Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Search"].Instance
				})

				Items["FilterButtons"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Header"].Instance,
					AnchorPoint = Vector2.new(1, 0),
					Position = UDim2.new(1, 0, 0, 0),
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 0, 1, 0),
					AutomaticSize = Enum.AutomaticSize.X,
					BorderSizePixel = 0
				})

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["FilterButtons"].Instance,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					Padding = UDim.new(0, 8),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				local function ApplyFilters()
					local Query = string.lower(ConsoleWindow.Search)

					for _, Entry in Items["Scroll"].Instance:GetChildren() do
						if Entry:IsA("TextLabel") then
							local Match = (ConsoleWindow.Filters[Entry:GetAttribute("LogType")] ~= false) and (Query == "" or string.find(string.lower(Entry:GetAttribute("LogText")), Query, 1, true))

							Entry.Visible = Match and true or false
						end
					end
				end

				ConsoleWindow.ApplyFilters = ApplyFilters

				local FilterOrder = {"Output", "Info", "Warning"}
				local FilterColors = {
					["Output"] = Color3.fromRGB(200, 200, 200),
					["Info"] = Color3.fromRGB(120, 170, 255),
					["Warning"] = Color3.fromRGB(255, 190, 70),
					["Error"] = Color3.fromRGB(255, 90, 90)
				}

				for Index, FilterName in FilterOrder do
					local Chip = Library:Create("TextButton", {
						Name = "\0",
						FontFace = Library.BoldFont,
						TextSize = ConsoleFontSize,
						Parent = Items["FilterButtons"].Instance,
						LayoutOrder = Index,
						TextColor3 = Library.Theme["Text"],
						Text = FilterName,
						AutoButtonColor = false,
						BackgroundTransparency = 1,
						Size = UDim2.new(0, 0, 1, 0),
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.X
					}):AddToTheme({TextColor3 = 'Text'})

					Library:Create("UIStroke", {
						Name = "\0",
						Parent = Chip.Instance
					})

					local Dot = Library:Create("Frame", {
						Name = "\0",
						Parent = Chip.Instance,
						AnchorPoint = Vector2.new(0, 0.5),
						Position = UDim2.new(0, -11, 0.5, 0),
						Size = UDim2.new(0, 7, 0, 7),
						BorderSizePixel = 0,
						BackgroundColor3 = Library.Theme["Accent"]
					}):AddToTheme({BackgroundColor3 = 'Accent'})

					Library:AccentGradient(Dot, 90)

					Library:Create("UIPadding", {
						Name = "\0",
						Parent = Chip.Instance,
						PaddingLeft = UDim.new(0, 14)
					})

					Chip:Connect("MouseButton1Click", function()
						ConsoleWindow.Filters[FilterName] = not ConsoleWindow.Filters[FilterName]

						Dot:Tween({BackgroundTransparency = ConsoleWindow.Filters[FilterName] and 0 or 0.7}, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
						Chip:Tween({TextTransparency = ConsoleWindow.Filters[FilterName] and 0 or 0.5}, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))

						ApplyFilters()
					end)
				end

				Library:Connect(Items["Search"].Instance:GetPropertyChangedSignal("Text"), function()
					ConsoleWindow.Search = Items["Search"].Instance.Text

					ApplyFilters()
				end)

				Items["Scroll"] = Library:Create("ScrollingFrame", {
					Name = "\0",
					Parent = Items["Console"].Instance,
					Position = UDim2.new(0, 8, 0, 68),
					Size = UDim2.new(1, -16, 1, -76),
					BackgroundColor3 = Library.Theme["Console Body"],
					BorderSizePixel = 0,
					ScrollBarThickness = 3,
					ScrollBarImageColor3 = Library.Theme["Accent"],
					CanvasSize = UDim2.new(0, 0, 0, 0),
					AutomaticCanvasSize = Enum.AutomaticSize.Y
				}):AddToTheme({ScrollBarImageColor3 = 'Accent', BackgroundColor3 = 'Console Body'})

				Library:Scrollbar(Items["Scroll"], {Top = 70, Right = 10, Bottom = 4})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Scroll"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["Scroll"].Instance,
					Padding = UDim.new(0, 3),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				Library:Create("UIPadding", {
					Name = "\0",
					Parent = Items["Scroll"].Instance,
					PaddingTop = UDim.new(0, 4),
					PaddingRight = UDim.new(0, 10),
					PaddingLeft = UDim.new(0, 10)
				})

				Library:AccentGradient(Items["AccentLine"], 0)
				Library:AccentGradient(Items["ActualTitle"], 0)

				ConsoleWindow.Items = Items
				Library.ConsoleObject = ConsoleWindow

				if Library.UpdateConsoleIcon then
					Library.UpdateConsoleIcon(Items["Console"].Instance.Visible)
				end
			end

			function ConsoleWindow:SetVisibility(Bool)
				Items["Console"].Instance.Visible = Bool

				if Library.UpdateConsoleIcon then
					Library.UpdateConsoleIcon(Bool)
				end
			end

			function ConsoleWindow:Clear()
				for _, Child in Items["Scroll"].Instance:GetChildren() do
					if Child:IsA("TextLabel") then
						Child:Destroy()
					end
				end
				ConsoleWindow.EntryCount = 0
				ConsoleWindow.LastKey = nil
				ConsoleWindow.LastEntry = nil
				ConsoleWindow.LastBody = nil
				ConsoleWindow.LastCount = nil
			end

			function ConsoleWindow:Log(Text, Type)
					local Type = Type or "Output"
					local Colors = {
						["Output"] = "rgb(235, 235, 235)",
						["Info"] = "rgb(120, 170, 255)",
						["Warning"] = "rgb(255, 190, 70)",
						["Error"] = "rgb(255, 90, 90)"
					}

					local Stamp = os.date("%H:%M:%S")

					local Key = string.upper(Type) .. "\0" .. tostring(Text)

					if ConsoleWindow.LastKey == Key and ConsoleWindow.LastEntry and ConsoleWindow.LastEntry.Instance.Parent then
						local Accent = Library.Theme["Accent"]

						ConsoleWindow.LastCount = (ConsoleWindow.LastCount or 1) + 1

						ConsoleWindow.LastEntry.Instance.Text = string.format(
							'%s <font color="rgb(%d, %d, %d)"><b>[x%d]</b></font>',
							ConsoleWindow.LastBody,
							math.floor(Accent.R * 255),
							math.floor(Accent.G * 255),
							math.floor(Accent.B * 255),
							ConsoleWindow.LastCount
						)

						Items["Scroll"].Instance.CanvasPosition = Vector2.new(0, Items["Scroll"].Instance.AbsoluteCanvasSize.Y)

						return
					end

					local Body = string.format(
						'<font color="%s"><b>[%s] [%s]</b></font> <font color="rgb(160, 160, 160)">%s</font>',
						Colors[Type] or Colors["Output"],
						Stamp,
						string.upper(Type),
						tostring(Text)
					)

					local Entry = Library:Create("TextLabel", {
						Name = "\0",
						FontFace = Library.Font,
						TextSize = ConsoleFontSize,
						Parent = Items["Scroll"].Instance,
						RichText = true,
						TextColor3 = Library.Theme["Text"],
						Text = Body,
						Size = UDim2.new(1, 0, 0, 18),
						BackgroundTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextWrapped = true,
						AutomaticSize = Enum.AutomaticSize.Y,
						BorderSizePixel = 0
					}):AddToTheme({TextColor3 = 'Text'})

					Entry.Instance:SetAttribute("LogType", Type)
					Entry.Instance:SetAttribute("LogText", tostring(Text))

					Library:Create("UIStroke", {
						Name = "\0",
						Parent = Entry.Instance
					})

					ConsoleWindow.EntryCount = ConsoleWindow.EntryCount + 1

					ConsoleWindow.LastKey = Key
					ConsoleWindow.LastBody = Body
					ConsoleWindow.LastCount = 1
					ConsoleWindow.LastEntry = Entry

					if ConsoleWindow.EntryCount > (Library.ConsoleLimit or 150) then
						for Index, Child in Items["Scroll"].Instance:GetChildren() do
							if Child:IsA("TextLabel") and Child ~= Entry.Instance then
								Child:Destroy()

								ConsoleWindow.EntryCount = ConsoleWindow.EntryCount - 1

								break
							end
						end
					end

					local Query = string.lower(ConsoleWindow.Search)
					Entry.Instance.Visible = (ConsoleWindow.Filters[Type] ~= false) and (Query == "" or string.find(string.lower(tostring(Text)), Query, 1, true)) and true or false

					Items["Scroll"].Instance.CanvasPosition = Vector2.new(0, Items["Scroll"].Instance.AbsoluteCanvasSize.Y)
				end

			return setmetatable(ConsoleWindow, Library)
		end

		Library.WatermarkOptions = Library.WatermarkOptions or { "Game", "Status", "Fps", "Ping" }
		Library.WatermarkRefreshRate = Library.WatermarkRefreshRate or 0.1
		Library.GameName = nil

		Library.HasWatermarkOption = function(Self, Name)
			local Options = Library.WatermarkOptions

			if type(Options) == "table" then
				for _, Option in ipairs(Options) do
					if tostring(Option) == Name then
						return true
					end
				end

				return false
			end

			return tostring(Options) == Name
		end

		Library.GetGameName = function(Self)
			if Library.GameName then
				return Library.GameName
			end

			local Ok, Info = pcall(function()
				return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
			end)

			local Name

			if Ok and type(Info) == "table" and Info.Name then
				Name = tostring(Info.Name)
			else
				Name = "place " .. tostring(game.PlaceId)
			end

			Name = Name:gsub("[\128-\255]", "")
			Name = Name:gsub("%s+", " ")
			Name = Name:gsub("^%s*(.-)%s*$", "%1")

			if Name == "" then
				Name = "place " .. tostring(game.PlaceId)
			end

			Library.GameName = Name

			return Library.GameName
		end
		Library.Watermark = function(Self, Params)
			Params = Params or { }

			local Watermark = {
				Name = Params.Name or Params.name or "Watermark",
				SubName = Params.SubName or Params.subname or "SubName",
				Items = { }
			}

			local Items = { } do
				Items["Watermark"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Library.Holder.Instance,
					AnchorPoint = Vector2.new(0.5, 0),
					Position = UDim2.new(0.5, 0, 0, 5 + GuiInset),
					Size = UDim2.new(0, 0, 0, 22),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundColor3 = Library.Theme["Background"]
				}):AddToTheme({BackgroundColor3 = 'Background'})

				Items["Watermark"]:MakeDraggable()

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Watermark"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Watermark"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Watermark"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 2"],
					BorderOffset = UDim.new(0, 2)
				}):AddToTheme({Color = 'Outline 2'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Watermark"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 4"],
					BorderOffset = UDim.new(0, 3)
				}):AddToTheme({Color = 'Outline 4'})

				Items["AccentLine"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Watermark"].Instance,
					Size = UDim2.new(1, 0, 0, 1),
					Position = UDim2.new(0, 0, 0, 0),
					BorderSizePixel = 0,
					ZIndex = 3,
					BackgroundColor3 = Library.Theme["Accent"]
				}):AddToTheme({BackgroundColor3 = 'Accent'})

				Library:AccentGradient(Items["AccentLine"], 0)

				Items["Row"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Watermark"].Instance,
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0.5, 0),
					Size = UDim2.new(0, 0, 0, 20),
					ZIndex = 2,
					AutomaticSize = Enum.AutomaticSize.X,
					BorderSizePixel = 0
				})

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["Row"].Instance,
					FillDirection = Enum.FillDirection.Horizontal,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					Padding = UDim.new(0, 6),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				Items["Icon"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Row"].Instance,
					BackgroundTransparency = 1,
					LayoutOrder = 1,
					Size = UDim2.new(0, 11, 0, 12),
					ZIndex = 3,
					BorderSizePixel = 0
				})

				for _, Bar in {
					{Position = UDim2.new(0, 0, 0, 7), Size = UDim2.new(0, 2, 0, 3)},
					{Position = UDim2.new(0, 3, 0, 3), Size = UDim2.new(0, 2, 0, 7)},
					{Position = UDim2.new(0, 6, 0, 0), Size = UDim2.new(0, 2, 0, 12)},
					{Position = UDim2.new(0, 9, 0, 5), Size = UDim2.new(0, 2, 0, 5)}
				} do
					local Piece = Library:Create("Frame", {
						Name = "\0",
						Parent = Items["Icon"].Instance,
						Position = Bar.Position,
						Size = Bar.Size,
						ZIndex = 4,
						BorderSizePixel = 0,
						BackgroundColor3 = Library.Theme["Accent"]
					}):AddToTheme({BackgroundColor3 = 'Accent'})

					Library:AccentGradient(Piece, 90)
				end

				Items["Title"] = Items["Row"]

				Items["Text"] = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.BoldFont,
					TextSize = Library.FontSize,
					Parent = Items["Row"].Instance,
					RichText = true,
					LayoutOrder = 2,
					TextColor3 = Library.Theme["Accent"],
					Text = Watermark.Name,
					ZIndex = 3,
					Size = UDim2.new(0, 0, 0, 18),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					AutomaticSize = Enum.AutomaticSize.X
				}):AddToTheme({TextColor3 = 'Accent'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Text"].Instance
				})

				Library:AccentGradient(Items["Text"], 0)

				Items["SubText"] = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["Row"].Instance,
					RichText = true,
					LayoutOrder = 3,
					TextColor3 = Library.Theme["Text"],
					Text = Watermark.SubName,
					ZIndex = 3,
					Size = UDim2.new(0, 0, 0, 18),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					AutomaticSize = Enum.AutomaticSize.X
				}):AddToTheme({TextColor3 = 'Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["SubText"].Instance
				})

				Library:Create("UIPadding", {
					Name = "\0",
					Parent = Items["Watermark"].Instance,
					PaddingRight = UDim.new(0, 9),
					PaddingLeft = UDim.new(0, 9)
				})

				Watermark.Items = Items
				Library.WatermarkObject = Watermark
			end

			function Watermark:Center()
				local AbsPos = Items["Watermark"].Instance.AbsolutePosition
				Items["Watermark"].Instance.AnchorPoint = Vector2.new(0, 0)
				task.wait()
				Items["Watermark"].Instance.Position = UDim2.new(0, AbsPos.X, 0, AbsPos.Y + GuiInset)
			end

			function Watermark:SetText(Text)
				Items["Text"].Instance.Text = tostring(Text)
			end

			function Watermark:SetSubText(Text)
				Items["SubText"].Instance.Text = tostring(Text)
			end

			function Watermark:SetVisibility(Bool)
				Items["Watermark"].Instance.Visible = Bool
			end

			Watermark.Status = Watermark.SubName
			Watermark.Auto = Params.Auto ~= false and Params.auto ~= false

			function Watermark:SetStatus(Text)
				Watermark.Status = tostring(Text)
			end

			Library:Thread(function()
				local Frames = 0
				local Last = os.clock()
				local Fps = 0
				local Ping = 0

				while Items["Watermark"].Instance.Parent do
					task.wait()
					Frames += 1

					local Now = os.clock()
					local Rate = math.max(tonumber(Library.WatermarkRefreshRate) or 0.1, 0.05)

					if Now - Last >= Rate then
						Fps = math.floor(Frames / (Now - Last) + 0.5)
						Frames = 0
						Last = Now

						pcall(function()
							Ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue() + 0.5)
						end)

						if Watermark.Auto then
							local Parts = { }

							if Library:HasWatermarkOption("Game") then
								table.insert(Parts, Library:GetGameName())
							end

							if Library:HasWatermarkOption("Status") and tostring(Watermark.Status) ~= "" then
								table.insert(Parts, tostring(Watermark.Status))
							end

							if Library:HasWatermarkOption("Fps") then
								table.insert(Parts, Fps .. " fps")
							end

							if Library:HasWatermarkOption("Ping") then
								table.insert(Parts, Ping .. " ms")
							end

							local Accent = Library.Theme["Accent"]
							local Separator = string.format(
								' <font color="rgb(%d, %d, %d)">.</font> ',
								math.floor(Accent.R * 255 + 0.5),
								math.floor(Accent.G * 255 + 0.5),
								math.floor(Accent.B * 255 + 0.5)
							)

							Watermark:SetSubText(table.concat(Parts, Separator))
						end
					end
				end
			end)
			Watermark:Center()
			return setmetatable(Watermark, Library)
		end

		Library.KeybindList = function(Self, Params)
			Params = Params or { }

			local KeybindList = {
				Name = Params.Name or Params.name or 'Keybind',
				Items = { },
			}

			Library.KeyList = KeybindList

			local Items = { } do
				Items["KeybindList"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Library.Holder.Instance,
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 20, 0.5, 0),
					Size = UDim2.new(0, 172, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Library.Theme["Background"]
				}):AddToTheme({BackgroundColor3 = 'Background'})

				Items["KeybindList"]:MakeDraggable()

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["KeybindList"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["KeybindList"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["KeybindList"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 2"],
					BorderOffset = UDim.new(0, 2)
				}):AddToTheme({Color = 'Outline 2'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["KeybindList"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 4"],
					BorderOffset = UDim.new(0, 3)
				}):AddToTheme({Color = 'Outline 4'})

				Items["AccentLine"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["KeybindList"].Instance,
					Size = UDim2.new(1, 0, 0, 1),
					Position = UDim2.new(0, 0, 0, 0),
					BorderSizePixel = 0,
					ZIndex = 3,
					BackgroundColor3 = Library.Theme["Accent"]
				}):AddToTheme({BackgroundColor3 = 'Accent'})

				Items["Text"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["KeybindList"].Instance,
					BackgroundTransparency = 1,
					ZIndex = 3,
					Size = UDim2.new(0, 0, 0, 18),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 0, 0),
					AutomaticSize = Enum.AutomaticSize.XY
				})

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["Text"].Instance,
					FillDirection = Enum.FillDirection.Horizontal,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					Padding = UDim.new(0, 0),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				local KbA = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.BoldFont,
					TextSize = Library.FontSize,
					Parent = Items["Text"].Instance,
					LayoutOrder = 1,
					RichText = false,
					TextColor3 = Library.Theme["Accent"],
					Text = KeybindList.Name,
					ZIndex = 3,
					Size = UDim2.new(0, 0, 0, 18),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					AutomaticSize = Enum.AutomaticSize.X
				}):AddToTheme({TextColor3 = 'Accent'})

				Library:Create("UIStroke", {Name = "\0", Parent = KbA.Instance})

				Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.BoldFont,
					TextSize = Library.FontSize,
					Parent = Items["Text"].Instance,
					LayoutOrder = 2,
					RichText = false,
					TextColor3 = Library.Theme["Text"],
					Text = " List",
					ZIndex = 3,
					Size = UDim2.new(0, 0, 0, 18),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					AutomaticSize = Enum.AutomaticSize.X
				}):AddToTheme({TextColor3 = 'Text'})

				Library:Create("UIPadding", {
					Name = "\0",
					Parent = Items["KeybindList"].Instance,
					PaddingTop = UDim.new(0, 7),
					PaddingBottom = UDim.new(0, 7),
					PaddingRight = UDim.new(0, 8),
					PaddingLeft = UDim.new(0, 8)
				})

				Items["Content"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["KeybindList"].Instance,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 24),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY
				})

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["Content"].Instance,
					Padding = UDim.new(0, 5),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				Library:AccentGradient(Items["AccentLine"], 0)

				KeybindList.Items = Items
			end

			function KeybindList:Center()
				local AbsPos = Items["KeybindList"].Instance.AbsolutePosition
				Items["KeybindList"].Instance.AnchorPoint = Vector2.new(0, 0)
				task.wait()
				Items["KeybindList"].Instance.Position = UDim2.new(0, AbsPos.X, 0, AbsPos.Y + GuiInset)
			end

			function KeybindList:SetText(Text)
				Items["Text"].Instance.Text = tostring(Text)
			end

			function KeybindList:SetVisibility(Bool)
				Items["KeybindList"].Instance.Visible = Bool

				if Library.UpdateKeybindsIcon then
					Library.UpdateKeybindsIcon(Bool)
				end
			end

			function KeybindList:Add(Name, Mode)
				local NewItems = { } do
					NewItems["NewKey"] = Library:Create("Frame", {
						Name = "\0",
						Parent = Items["Content"].Instance,
						BackgroundTransparency = 1,
						Size = UDim2.new(0, 180, 0, 18),
						BorderSizePixel = 0
					})

					NewItems["Holder"] = Library:Create("Frame", {
						Name = "\0",
						Parent = NewItems["NewKey"].Instance,
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 1, 0),
						BorderSizePixel = 0
					})

					NewItems["Text"] = Library:Create("TextLabel", {
						Name = "\0",
						FontFace = Library.Font,
						TextSize = Library.FontSize,
						Parent = NewItems["Holder"].Instance,
						RichText = true,
						TextColor3 = Library.Theme["Text"],
						Text = "",
						AnchorPoint = Vector2.new(0, 0.5),
						Size = UDim2.new(0, 0, 0, 18),
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 0, 0.5, 0),
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.X
					}):AddToTheme({TextColor3 = 'Text'})

					Library:Create("UIStroke", {
						Name = "\0",
						Parent = NewItems["Text"].Instance
					})

					NewItems["Mode"] = Library:Create("TextLabel", {
						Name = "\0",
						FontFace = Library.Font,
						TextSize = Library.FontSize,
						Parent = NewItems["Holder"].Instance,
						TextColor3 = Library.Theme["Accent"],
						Text = "always",
						AnchorPoint = Vector2.new(1, 0.5),
						Size = UDim2.new(0, 0, 0, 18),
						BackgroundTransparency = 1,
						Position = UDim2.new(1, 0, 0.5, 0),
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.X
					}):AddToTheme({TextColor3 = 'Accent'})

					Library:Create("UIStroke", {
						Name = "\0",
						Parent = NewItems["Mode"].Instance
					})
				end

				task.wait()

				local CanBeVisible = true

				function NewItems:SetVis(Bool)
					CanBeVisible = Bool
				end

				local StateId = 0

				function NewItems:SetStatus(Bool)
					StateId = StateId + 1
					local Current = StateId

					if not CanBeVisible then
						NewItems["NewKey"].Instance.Visible = false
						return
					end

					if Bool then
						NewItems["NewKey"].Instance.Visible = true

						NewItems["NewKey"]:Tween({Size = UDim2.new(0, 180, 0, 18), Position = UDim2.new(0, 0, 0, 0)})
						NewItems["Text"]:Tween({TextTransparency = 0})
						NewItems["Mode"]:Tween({TextTransparency = 0})
					else
						Library:Thread(function()
							NewItems["NewKey"]:Tween({Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(-1, 0, 0, 0)})
							local FadeText = NewItems["Text"]:Tween({TextTransparency = 1})
							NewItems["Mode"]:Tween({TextTransparency = 1})
							FadeText.Completed:Wait()

							if Current ~= StateId then return end

							NewItems["NewKey"].Instance.Visible = false
						end)
					end
				end

				local RowName = ""
				local RowMode = ""
				local RowKey = ""

				local function RenderRow()
					local Accent = Library.Theme["Accent"]
					local Hex = string.format(
						"#%02X%02X%02X",
						math.floor(Accent.R * 255 + 0.5),
						math.floor(Accent.G * 255 + 0.5),
						math.floor(Accent.B * 255 + 0.5)
					)

					local Key = (RowKey ~= "" and RowKey ~= "None") and RowKey or "..."

					NewItems["Text"].Instance.Text = string.format(
						'<font color="%s">[%s]</font> - %s%s',
						Hex,
						Key,
						RowName,
						RowMode ~= "" and (" (" .. RowMode .. ")") or ""
					)
				end

				function NewItems:Set(Name, Mode, Key)
					RowName = tostring(Name)

					if Mode ~= nil and Mode ~= "" then
						RowMode = tostring(Mode)
					end

					if Key ~= nil then
						RowKey = tostring(Key)
					end

					RenderRow()
				end

				function NewItems:SetMode(Mode)
					NewItems["Mode"].Instance.Text = ""
					RenderRow()
				end

				return NewItems
			end

			KeybindList:Center()

			return setmetatable(KeybindList, Library)
		end

		Library.Notification = function(Self, Params)
			if Library.NotificationsEnabled == false then
				return
			end

			local Items = { } do
				Items["Notification"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Library.NotifHolder.Instance,
					Size = UDim2.new(0, 0, 0, 22),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundColor3 = Library.Theme["Background"]
				}):AddToTheme({BackgroundColor3 = 'Background'})

				Items["Stroke1"] = Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Notification"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Items["Stroke2"] = Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Notification"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				Library:Create("UIPadding", {
					Name = "\0",
					Parent = Items["Notification"].Instance,
					PaddingRight = UDim.new(0, 8),
					PaddingLeft = UDim.new(0, 8)
				})

				Items["SideBar"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Notification"].Instance,
					Position = UDim2.new(0, -8, 0, 0),
					Size = UDim2.new(0, 2, 1, 0),
					ZIndex = 2,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Accent"]
				}):AddToTheme({BackgroundColor3 = 'Accent'})

				Library:AccentGradient(Items["SideBar"], 90)

				Items["Text"] = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["Notification"].Instance,
					RichText = true,
					TextColor3 = Library.Theme["Text"],
					Text = Params.Name,
					AnchorPoint = Vector2.new(0, 0.5),
					Size = UDim2.new(0, 0, 0, 16),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0.5, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X
				}):AddToTheme({TextColor3 = 'Text'})

				Items["TextStroke"] = Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Text"].Instance
				})
			end

			for Index, Value in Items do
				if Value.Instance:IsA("Frame") then
					Value.Instance.BackgroundTransparency = 1
				elseif Value.Instance:IsA("TextLabel") then
					Value.Instance.TextTransparency = 1
				elseif Value.Instance:IsA("UIStroke") then
					Value.Instance.Transparency = 1
				end
			end

			local GetSize = function()
				local AbsSize = Items["Notification"].Instance.AbsoluteSize
				Items["Notification"].Instance.AutomaticSize = Enum.AutomaticSize.None
				task.wait()
				Items["Notification"].Instance.Size = UDim2.new(0, AbsSize.X, 0, AbsSize.Y)
				return AbsSize
			end

			local Size = GetSize()
			task.wait()
			Items["Notification"].Instance.Size = UDim2.new(0, 0, 0, Size.Y)

			local Info = TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0)

			Library:Thread(function()
				for Index, Value in Items do
					if Value.Instance:IsA("Frame") then
						Value:Tween({BackgroundTransparency = 0}, Info)
					elseif Value.Instance:IsA("TextLabel") then
						Value:Tween({TextTransparency = 0}, Info)
					elseif Value.Instance:IsA("UIStroke") then
						Value:Tween({Transparency = 0}, Info)
					end
				end

				Items["Notification"]:Tween({Size = UDim2.new(0, Size.X, 0, Size.Y)}, Info)

				task.delay(Params.Time + 0.1, function()
					for Index, Value in Items do
						if Value.Instance:IsA("Frame") then
							Value:Tween({BackgroundTransparency = 1})
						elseif Value.Instance:IsA("TextLabel") then
							Value:Tween({TextTransparency = 1})
						elseif Value.Instance:IsA("UIStroke") then
							Value:Tween({Transparency = 1})
						end
					end

					Items["Notification"]:Tween({Size = UDim2.new(0, 0, 0, 0)}, Info)
					task.wait(0.5)
					Items["Notification"].Instance:Destroy()
				end)
			end)
		end

		Library.CreateColorpicker = function(Self, Data)
			local Colorpicker = {
				Hue = 0,
				Saturation = 0,
				Value = 0,

				Alpha = 0,

				Color = Color3.fromRGB(255, 255, 255),
				HexValue = "#FFFFFF",

				Flag = Data.Flag,
				IsOpen = false,

				Items = { }
			}

			local Items = { } do
				Colorpicker.Animate = false
				Colorpicker.AnimationMode = "Rainbow"

				Items["ColorpickerButton"] = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Data.Parent.Instance,
					TextColor3 = Color3.fromRGB(0, 0, 0),
					Text = "",
					AutoButtonColor = false,
					Size = UDim2.new(0, 26, 0, 11),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 143, 203)
				})

				Library:Create("UIGradient", {
					Name = "\0",
					Parent = Items["ColorpickerButton"].Instance,
					Rotation = 45,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145))
					}
				})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["ColorpickerButton"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["ColorpickerButton"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Items["ColorpickerWindow"] = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Library.UnusedHolder.Instance,
					Visible = false,
					TextColor3 = Color3.fromRGB(0, 0, 0),
					Text = "",
					AutoButtonColor = false,
					Position = UDim2.new(0, 1011, 0, 100),
					Size = UDim2.new(0, 228, 0, 256),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Background"]
				}):AddToTheme({BackgroundColor3 = 'Background'})

				for Index, Outline in {"Outline 1", "Outline 3", "Outline 4"} do
					Library:Create("UIStroke", {
						Name = "\0",
						Parent = Items["ColorpickerWindow"].Instance,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						LineJoinMode = Enum.LineJoinMode.Miter,
						Color = Library.Theme[Outline],
						BorderOffset = UDim.new(0, Index - 1)
					}):AddToTheme({Color = Outline})
				end

				Items["TabRow"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["ColorpickerWindow"].Instance,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 7, 0, 7),
					Size = UDim2.new(1, -14, 0, 22),
					BorderSizePixel = 0
				})

				Items["ColorTab"] = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.BoldFont,
					TextSize = Library.FontSize,
					Parent = Items["TabRow"].Instance,
					TextColor3 = Library.Theme["Accent"],
					Text = "Color",
					AutoButtonColor = false,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(0.5, -2, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Hovered Element"]
				}):AddToTheme({BackgroundColor3 = 'Hovered Element', TextColor3 = 'Accent'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["ColorTab"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIGradient", {
					Name = "\0",
					Parent = Items["ColorTab"].Instance,
					Rotation = 90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(236, 236, 236)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(208, 208, 208))
					}
				})

				Items["SettingsTab"] = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.BoldFont,
					TextSize = Library.FontSize,
					Parent = Items["TabRow"].Instance,
					TextColor3 = Library.Theme["Inactive Text"],
					Text = "Settings",
					AutoButtonColor = false,
					Position = UDim2.new(0.5, 2, 0, 0),
					Size = UDim2.new(0.5, -2, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Inline"]
				}):AddToTheme({BackgroundColor3 = 'Inline', TextColor3 = 'Inactive Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["SettingsTab"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIGradient", {
					Name = "\0",
					Parent = Items["SettingsTab"].Instance,
					Rotation = 90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(236, 236, 236)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(208, 208, 208))
					}
				})

				Items["ColorPage"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["ColorpickerWindow"].Instance,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 7, 0, 36),
					Size = UDim2.new(1, -14, 1, -44),
					BorderSizePixel = 0
				})

				Items["SettingsPage"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["ColorpickerWindow"].Instance,
					Visible = false,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 7, 0, 36),
					Size = UDim2.new(1, -14, 1, -44),
					BorderSizePixel = 0
				})

				Items["Palette"] = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["ColorPage"].Instance,
					TextColor3 = Color3.fromRGB(0, 0, 0),
					Text = "",
					AutoButtonColor = false,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(1, -40, 1, -48),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 143, 203)
				})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Palette"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"]
				}):AddToTheme({Color = 'Outline 3'})

				Items["Saturation"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Palette"].Instance,
					Size = UDim2.new(1, 0, 1, 0),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderSizePixel = 0
				})

				Library:Create("UIGradient", {
					Name = "\0",
					Parent = Items["Saturation"].Instance,
					Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 1),
						NumberSequenceKeypoint.new(1, 0)
					}
				})

				Items["Value"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Palette"].Instance,
					Size = UDim2.new(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				})

				Library:Create("UIGradient", {
					Name = "\0",
					Parent = Items["Value"].Instance,
					Rotation = 90,
					Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 1),
						NumberSequenceKeypoint.new(1, 0)
					}
				})

				Items["PaletteDragger"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Palette"].Instance,
					Size = UDim2.new(0, 1, 0, 1),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0
				})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["PaletteDragger"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Color3.fromRGB(0, 0, 0)
				})

				Items["Hue"] = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["ColorPage"].Instance,
					TextColor3 = Color3.fromRGB(0, 0, 0),
					Text = "",
					AutoButtonColor = false,
					Position = UDim2.new(1, -36, 0, 0),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Size = UDim2.new(0, 14, 1, -48),
					BorderSizePixel = 0
				})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Hue"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"]
				}):AddToTheme({Color = 'Outline 3'})

				Library:Create("UIGradient", {
					Name = "\0",
					Parent = Items["Hue"].Instance,
					Rotation = 90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
						ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
						ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
						ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
						ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
					}
				})

				Items["HueDragger"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Hue"].Instance,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Size = UDim2.new(1, 0, 0, 1),
					BorderSizePixel = 0
				})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["HueDragger"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Color3.fromRGB(6, 7, 7)
				})

				Items["Alpha"] = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["ColorPage"].Instance,
					TextColor3 = Color3.fromRGB(0, 0, 0),
					Text = "",
					AutoButtonColor = false,
					Position = UDim2.new(1, -16, 0, 0),
					Size = UDim2.new(0, 14, 1, -48),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 143, 203)
				})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Alpha"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"]
				}):AddToTheme({Color = 'Outline 3'})

				Items["CheckersAlpha"] = Library:Create("ImageLabel", {
					Name = "\0",
					Parent = Items["Alpha"].Instance,
					ScaleType = Enum.ScaleType.Tile,
					TileSize = UDim2.new(0, 6, 0, 6),
					Image = "http://www.roblox.com/asset/?id=18274452449",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 2,
					BorderSizePixel = 0
				})

				Library:Create("UIGradient", {
					Name = "\0",
					Parent = Items["CheckersAlpha"].Instance,
					Rotation = 90,
					Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 1),
						NumberSequenceKeypoint.new(1, 0)
					}
				})

				Items["AlphaDragger"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Alpha"].Instance,
					Size = UDim2.new(1, 0, 0, 1),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderSizePixel = 0
				})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["AlphaDragger"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Color3.fromRGB(6, 7, 7)
				})

				Items["RgbaBox"] = Library:Create("TextBox", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["ColorPage"].Instance,
					TextColor3 = Library.Theme["Text"],
					Text = "255, 255, 255, 1.00",
					PlaceholderText = "",
					ClearTextOnFocus = false,
					TextEditable = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.new(0, 0, 1, -44),
					Size = UDim2.new(1, -24, 0, 20),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Inline"]
				}):AddToTheme({BackgroundColor3 = 'Inline', TextColor3 = 'Text'})

				Library:Create("UIPadding", {
					Name = "\0",
					Parent = Items["RgbaBox"].Instance,
					PaddingRight = UDim.new(0, 6),
					PaddingLeft = UDim.new(0, 6)
				})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["RgbaBox"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Items["CurrentColor"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["ColorPage"].Instance,
					Position = UDim2.new(1, -20, 1, -44),
					Size = UDim2.new(0, 20, 0, 20),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 143, 203)
				})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["CurrentColor"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Items["Checkers"] = Library:Create("ImageLabel", {
					Name = "\0",
					Parent = Items["CurrentColor"].Instance,
					ScaleType = Enum.ScaleType.Tile,
					ImageTransparency = 0.6000000238418579,
					TileSize = UDim2.new(0, 6, 0, 6),
					Image = "http://www.roblox.com/asset/?id=18274452449",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 2,
					BorderSizePixel = 0
				})

				Items["HexBox"] = Library:Create("TextBox", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["ColorPage"].Instance,
					TextColor3 = Library.Theme["Text"],
					Text = "#FFFFFFFF",
					PlaceholderText = "",
					ClearTextOnFocus = false,
					TextEditable = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.new(0, 0, 1, -20),
					Size = UDim2.new(1, 0, 0, 20),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Inline"]
				}):AddToTheme({BackgroundColor3 = 'Inline', TextColor3 = 'Text'})

				Library:Create("UIPadding", {
					Name = "\0",
					Parent = Items["HexBox"].Instance,
					PaddingRight = UDim.new(0, 6),
					PaddingLeft = UDim.new(0, 6)
				})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["HexBox"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Items["AnimateLabel"] = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["SettingsPage"].Instance,
					TextColor3 = Library.Theme["Text"],
					Text = "Animate",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(1, -22, 0, 18),
					BorderSizePixel = 0,
					TextXAlignment = Enum.TextXAlignment.Left
				}):AddToTheme({TextColor3 = 'Text'})

				Items["AnimateShadow"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["SettingsPage"].Instance,
					Position = UDim2.new(1, -11, 0, 5),
					Size = UDim2.new(0, 13, 0, 13),
					BorderSizePixel = 0,
					ZIndex = 1,
					BackgroundTransparency = 0.6,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				})
				Items["AnimateButton"] = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["SettingsPage"].Instance,
					TextColor3 = Color3.fromRGB(0, 0, 0),
					Text = "",
					AutoButtonColor = false,
					Position = UDim2.new(1, -13, 0, 3),
					Size = UDim2.new(0, 13, 0, 13),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Inline"]
				}):AddToTheme({BackgroundColor3 = 'Inline'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["AnimateButton"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Items["AnimateFill"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["AnimateButton"].Instance,
					Size = UDim2.new(1, -4, 1, -4),
					Position = UDim2.new(0, 2, 0, 2),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Accent"]
				}):AddToTheme({BackgroundColor3 = 'Accent'})

				Items["AnimationLabel"] = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["SettingsPage"].Instance,
					TextColor3 = Library.Theme["Inactive Text"],
					Text = "Animation",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 26),
					Size = UDim2.new(1, 0, 0, 16),
					BorderSizePixel = 0,
					TextXAlignment = Enum.TextXAlignment.Left
				}):AddToTheme({TextColor3 = 'Inactive Text'})

				Items["AnimationListShadow"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["SettingsPage"].Instance,
					Position = UDim2.new(0, 2, 0, 48),
					Size = UDim2.new(1, 0, 0, 116),
					BorderSizePixel = 0,
					ZIndex = 1,
					BackgroundTransparency = 0.6,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				})
				Items["AnimationList"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["SettingsPage"].Instance,
					Position = UDim2.new(0, 0, 0, 46),
					Size = UDim2.new(1, 0, 0, 116),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Inline"]
				}):AddToTheme({BackgroundColor3 = 'Inline'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["AnimationList"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIPadding", {
					Name = "\0",
					Parent = Items["AnimationList"].Instance,
					PaddingTop = UDim.new(0, 4),
					PaddingBottom = UDim.new(0, 4),
					PaddingRight = UDim.new(0, 6),
					PaddingLeft = UDim.new(0, 6)
				})

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["AnimationList"].Instance,
					Padding = UDim.new(0, 1),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				local AnimationRows = { }

				local function RefreshAnimationRows()
					for Mode, Row in pairs(AnimationRows) do
						local Selected = Colorpicker.AnimationMode == Mode

						Row:ChangeItemTheme({TextColor3 = Selected and "Accent" or "Inactive Text"})
						Row:Tween({TextColor3 = Selected and Library.Theme["Accent"] or Library.Theme["Inactive Text"]})
					end
				end

				for Index, Mode in ipairs({ "Rainbow", "Fading", "Oscillating", "Sawtooth", "Strobe" }) do
					local Row = Library:Create("TextButton", {
						Name = "\0",
						FontFace = Library.Font,
						TextSize = Library.FontSize,
						Parent = Items["AnimationList"].Instance,
						TextColor3 = Library.Theme["Inactive Text"],
						Text = Mode,
						AutoButtonColor = false,
						LayoutOrder = Index,
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 20),
						BorderSizePixel = 0,
						TextXAlignment = Enum.TextXAlignment.Left
					}):AddToTheme({TextColor3 = 'Inactive Text'})

					AnimationRows[Mode] = Row

					local RowNudge = Library:Create("UIPadding", {
						Name = "\0",
						Parent = Row.Instance,
						PaddingLeft = UDim.new(0, 0)
					})

					Row:OnHover(function()
						RowNudge:Tween({PaddingLeft = UDim.new(0, 5)}, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))

						if Colorpicker.AnimationMode ~= Mode then
							Row:Tween({TextColor3 = Library.Theme["Text"]})
						end
					end, function()
						RowNudge:Tween({PaddingLeft = UDim.new(0, 0)}, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))

						if Colorpicker.AnimationMode ~= Mode then
							Row:Tween({TextColor3 = Library.Theme["Inactive Text"]})
						end
					end)

					Row:Connect("MouseButton1Down", function()
						Colorpicker.AnimationMode = Mode

						RefreshAnimationRows()
						Colorpicker:UpdateAnimation()
					end)
				end

				RefreshAnimationRows()

				Items["AnimateButton"]:Connect("MouseButton1Down", function()
					Colorpicker.Animate = not Colorpicker.Animate

					Items["AnimateFill"]:Tween({BackgroundTransparency = Colorpicker.Animate and 0 or 1})
					Colorpicker:UpdateAnimation()
				end)

				local function SetTab(Name)
					local IsColor = Name == "Color"

					Items["ColorPage"].Instance.Visible = IsColor
					Items["SettingsPage"].Instance.Visible = not IsColor

					Items["ColorTab"]:ChangeItemTheme({TextColor3 = IsColor and "Accent" or "Inactive Text", BackgroundColor3 = IsColor and "Hovered Element" or "Inline"})
					Items["ColorTab"]:Tween({TextColor3 = IsColor and Library.Theme["Accent"] or Library.Theme["Inactive Text"], BackgroundColor3 = IsColor and Library.Theme["Hovered Element"] or Library.Theme["Inline"]})

					Items["SettingsTab"]:ChangeItemTheme({TextColor3 = IsColor and "Inactive Text" or "Accent", BackgroundColor3 = IsColor and "Inline" or "Hovered Element"})
					Items["SettingsTab"]:Tween({TextColor3 = IsColor and Library.Theme["Inactive Text"] or Library.Theme["Accent"], BackgroundColor3 = IsColor and Library.Theme["Inline"] or Library.Theme["Hovered Element"]})
				end

				Items["ColorTab"]:Connect("MouseButton1Down", function()
					SetTab("Color")
				end)

				Items["SettingsTab"]:Connect("MouseButton1Down", function()
					SetTab("Settings")
				end)

				Items["RgbaBox"].Instance.Focused:Connect(function()
					Colorpicker.EditingRgba = true

					Items["RgbaBox"]:ChangeItemTheme({TextColor3 = "Accent"})
					Items["RgbaBox"]:Tween({TextColor3 = Library.Theme["Accent"]})
				end)

				Items["RgbaBox"].Instance.FocusLost:Connect(function()
					Colorpicker.EditingRgba = false

					Items["RgbaBox"]:ChangeItemTheme({TextColor3 = "Text"})
					Items["RgbaBox"]:Tween({TextColor3 = Library.Theme["Text"]})

					local Numbers = { }

					for Piece in string.gmatch(Items["RgbaBox"].Instance.Text, "[%d%.]+") do
						table.insert(Numbers, tonumber(Piece))
					end

					if Numbers[1] and Numbers[2] and Numbers[3] then
						local Opacity = math.clamp(Numbers[4] or 1, 0, 1)

						Colorpicker:Set(Color3.fromRGB(math.clamp(Numbers[1], 0, 255), math.clamp(Numbers[2], 0, 255), math.clamp(Numbers[3], 0, 255)), 1 - Opacity)
					else
						Colorpicker:UpdateReadouts()
					end
				end)

				Items["HexBox"].Instance.Focused:Connect(function()
					Colorpicker.EditingHex = true

					Items["HexBox"]:ChangeItemTheme({TextColor3 = "Accent"})
					Items["HexBox"]:Tween({TextColor3 = Library.Theme["Accent"]})
				end)

				Items["HexBox"].Instance.FocusLost:Connect(function()
					Colorpicker.EditingHex = false

					Items["HexBox"]:ChangeItemTheme({TextColor3 = "Text"})
					Items["HexBox"]:Tween({TextColor3 = Library.Theme["Text"]})

					local Hex = string.gsub(Items["HexBox"].Instance.Text, "[^%x]", "")

					if #Hex >= 6 then
						local AlphaPart = #Hex >= 8 and tonumber(string.sub(Hex, 7, 8), 16) or 255

						Colorpicker:Set("#" .. string.sub(Hex, 1, 6), 1 - (AlphaPart / 255))
					else
						Colorpicker:UpdateReadouts()
					end
				end)

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["ColorpickerWindow"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["ColorpickerWindow"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				Colorpicker.Items = Items
			end

			Colorpicker.Holder = Items["ColorpickerWindow"]

			function Colorpicker:SetVisibility(Bool)
				Items["ColorpickerButton"].Instance.Visible = Bool
			end

			Library:Shade(Items["ColorTab"])
			Library:Shade(Items["SettingsTab"])

			function Colorpicker:UpdateReadouts()
				local Color = Colorpicker.Color or Color3.fromHSV(Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value)

				local R = math.floor(Color.R * 255 + 0.5)
				local G = math.floor(Color.G * 255 + 0.5)
				local B = math.floor(Color.B * 255 + 0.5)
				local Opacity = math.clamp(1 - (Colorpicker.Alpha or 0), 0, 1)

				if Items["RgbaBox"] and not Colorpicker.EditingRgba then
					Items["RgbaBox"].Instance.Text = string.format("%d, %d, %d, %.2f", R, G, B, Opacity)
				end

				if Items["HexBox"] and not Colorpicker.EditingHex then
					Items["HexBox"].Instance.Text = string.format("#%02X%02X%02X%02X", R, G, B, math.floor(Opacity * 255 + 0.5))
				end
			end

			function Colorpicker:UpdateDraggers(SweepX)
				local PaletteX = math.clamp(SweepX or (1 - Colorpicker.Saturation), 0, 0.99)
				local PaletteY = math.clamp(1 - Colorpicker.Value, 0, 0.99)
				local HueY = math.clamp(Colorpicker.Hue, 0, 0.99)
				local AlphaY = math.clamp(Colorpicker.Alpha or 0, 0, 0.985)

				Items["PaletteDragger"].Instance.Position = UDim2.new(PaletteX, 0, PaletteY, 0)
				Items["HueDragger"].Instance.Position = UDim2.new(0, 0, HueY, 0)

				if Items["AlphaDragger"] then
					Items["AlphaDragger"].Instance.Position = UDim2.new(0, 0, AlphaY, 0)
				end
			end

			function Colorpicker:Update(IsFromAlpha)
				local Hue, Saturation, Value = Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value

				Colorpicker.Color = Color3.fromHSV(Hue, Saturation, Value)
				Colorpicker.HexValue = Colorpicker.Color:ToHex()

				Items["ColorpickerButton"]:Tween({BackgroundColor3 = Colorpicker.Color})
				Items["Palette"]:Tween({BackgroundColor3 = Color3.fromHSV(Hue, 1, 1)})

				Flags[Colorpicker.Flag] = {
					Alpha = Colorpicker.Alpha,
					Color = Colorpicker.Color,
					HexValue = Colorpicker.HexValue,
					Transparency = 1 - Colorpicker.Alpha
				}

				if not IsFromAlpha then
					Items["Alpha"]:Tween({BackgroundColor3 = Colorpicker.Color})
				end

				Items["CurrentColor"]:Tween({BackgroundColor3 = Colorpicker.Color})
				Items["Checkers"]:Tween({ImageTransparency = 1 - Colorpicker.Alpha})

				if not Colorpicker.AnimationThread then
					Colorpicker:UpdateDraggers()
				end

				Colorpicker:UpdateReadouts()

				if Data.Callback then
					Library:SafeCall(Data.Callback, Colorpicker.Color, Colorpicker.Alpha)
				end
			end

			local Debounce = false
			local ColorpickerWindow = Items["ColorpickerWindow"].Instance
			local ColorpickerButton = Items["ColorpickerButton"].Instance
			local IsSettings = Data.Section and Data.Section.IsSettings

			function Colorpicker:SetOpen(Bool)
				if Debounce then
					return
				end

				Colorpicker.IsOpen = Bool
				Debounce = true

				if Colorpicker.IsOpen then
					ColorpickerWindow.Position = UDim2.new(0, ColorpickerButton.AbsolutePosition.X, 0, ColorpickerButton.AbsolutePosition.Y + ColorpickerButton.AbsoluteSize.Y + GuiInset)
					ColorpickerWindow.Parent = Library.Holder.Instance
					ColorpickerWindow.Visible = true

					Items["ColorpickerWindow"]:Tween({Position = UDim2.new(0, ColorpickerButton.AbsolutePosition.X, 0, ColorpickerButton.AbsolutePosition.Y + ColorpickerButton.AbsoluteSize.Y + 10 + GuiInset)})
					Items["ColorpickerWindow"]:FadeDescendants(true, function()
						Debounce = false
					end)

					for Index, Value in Library.OpenFrames do
						if Value ~= IsSettings then
							Value:SetOpen(false)
						end
					end

					Library.OpenFrames[Colorpicker] = Colorpicker
				else
					Items["ColorpickerWindow"]:Tween({Position = UDim2.new(0, ColorpickerButton.AbsolutePosition.X, 0, ColorpickerButton.AbsolutePosition.Y + ColorpickerButton.AbsoluteSize.Y - 10 + GuiInset)})
					Items["ColorpickerWindow"]:FadeDescendants(false, function()
						ColorpickerWindow.Parent = Library.UnusedHolder.Instance
						Debounce = false
					end)

					if Library.OpenFrames[Colorpicker] then
						Library.OpenFrames[Colorpicker] = nil
					end
				end

				local Descendants = ColorpickerWindow:GetDescendants()
				table.insert(Descendants, ColorpickerWindow)

				for Index, Value in Descendants do
					if not Value.ClassName:find("UI") then
						if IsSettings then
							Value.ZIndex = Colorpicker.IsOpen and Library.ZIndexOrder.ColorpickerWindow + 4 or 1
						else
							Value.ZIndex = Colorpicker.IsOpen and Library.ZIndexOrder.ColorpickerWindow or 1
						end
					end
				end
			end

			local SlidingPalette = false
			local PaletteChanged

			function Colorpicker:SlidePalette(Input)
				if not SlidingPalette then
					return
				end

				local Palette = Items["Palette"].Instance
				local Point = Library:MousePoint()

				local AlphaX = math.clamp((Point.X - Palette.AbsolutePosition.X) / math.max(Palette.AbsoluteSize.X, 1), 0, 1)
				local AlphaY = math.clamp((Point.Y - Palette.AbsolutePosition.Y) / math.max(Palette.AbsoluteSize.Y, 1), 0, 1)

				Colorpicker.Saturation = 1 - AlphaX
				Colorpicker.Value = 1 - AlphaY

				Colorpicker:Update()
			end

			local SlidingHue = false
			local HueChanged

			function Colorpicker:SlideHue(Input)
				if not SlidingHue then
					return
				end

				local Hue = Items["Hue"].Instance
				local Point = Library:MousePoint()

				Colorpicker.Hue = math.clamp((Point.Y - Hue.AbsolutePosition.Y) / math.max(Hue.AbsoluteSize.Y, 1), 0, 1)

				Colorpicker:Update()
			end

			local SlidingAlpha = false
			local AlphaChanged

			function Colorpicker:SlideAlpha(Input)
				if not SlidingAlpha then
					return
				end

				local Alpha = Items["Alpha"].Instance
				local Point = Library:MousePoint()

				Colorpicker.Alpha = math.clamp((Point.Y - Alpha.AbsolutePosition.Y) / math.max(Alpha.AbsoluteSize.Y, 1), 0, 1)

				Colorpicker:Update(true)
			end

			function Colorpicker:Set(Color, Alpha)
				if type(Color) == "table" then
					Color = Color3.fromRGB(Color[1], Color[2], Color[3])
				elseif type(Color) == "string" then
					Color = Color3.fromHex(Color)
				else
					Color = Color
				end

				Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value = Color:ToHSV()
				Colorpicker.Alpha = Alpha or 0

				Colorpicker:Update()
			end

			function Colorpicker:UpdateAnimation()
				if Colorpicker.AnimationThread then
					pcall(task.cancel, Colorpicker.AnimationThread)
					Colorpicker.AnimationThread = nil
				end

				if not Colorpicker.Animate then
					return
				end

				local BaseHue, BaseSaturation, BaseValue = Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value

				Colorpicker.AnimationThread = task.spawn(function()
					local Clock = 0

					while Colorpicker.Animate do
						Clock = Clock + task.wait(1 / math.clamp(Library.AnimationRate or 30, 1, 240))

						local Mode = Colorpicker.AnimationMode
						local Hue, Saturation, Value = BaseHue, BaseSaturation, BaseValue

						if Mode == "Rainbow" then
							Hue = Clock % 1
						elseif Mode == "Fading" then
							Value = BaseValue * (0.25 + 0.75 * ((math.sin(Clock * math.pi * 2) + 1) / 2))
						elseif Mode == "Oscillating" then
							Hue = (BaseHue + 0.12 * math.sin(Clock * math.pi * 2)) % 1
						elseif Mode == "Sawtooth" then
							Value = BaseValue * (0.2 + 0.8 * (Clock % 1))
						elseif Mode == "Strobe" then
							Value = (math.floor(Clock * 8) % 2 == 0) and BaseValue or BaseValue * 0.1
						end

						Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value = Hue, Saturation, Value
						Colorpicker.Color = Color3.fromHSV(Hue, Saturation, Value)

						Items["ColorpickerButton"].Instance.BackgroundColor3 = Colorpicker.Color

						if Colorpicker.IsOpen then
							Colorpicker.HexValue = Colorpicker.Color:ToHex()

							Items["CurrentColor"].Instance.BackgroundColor3 = Colorpicker.Color
							Items["Palette"].Instance.BackgroundColor3 = Color3.fromHSV(Hue, 1, 1)
							Items["Alpha"].Instance.BackgroundColor3 = Colorpicker.Color

							local Sweep = nil

							if Mode == "Rainbow" or Mode == "Oscillating" then
								Sweep = Hue
							end

							Colorpicker:UpdateDraggers(Sweep)
							Colorpicker:UpdateReadouts()
						end

						local FlagTable = Flags[Colorpicker.Flag]

						if type(FlagTable) ~= "table" then
							FlagTable = { }
							Flags[Colorpicker.Flag] = FlagTable
						end

						FlagTable.Alpha = Colorpicker.Alpha
						FlagTable.Color = Colorpicker.Color
						FlagTable.HexValue = Colorpicker.HexValue
						FlagTable.Transparency = 1 - Colorpicker.Alpha

						if Data.Callback then
							Library:SafeCall(Data.Callback, Colorpicker.Color, Colorpicker.Alpha)
						end
					end

					Colorpicker.AnimationThread = nil
				end)
			end

			Items["ColorpickerButton"]:Connect("MouseButton1Down", function()
				Colorpicker:SetOpen(not Colorpicker.IsOpen)
			end)

			Items["Palette"]:Connect("InputBegan", function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					SlidingPalette = true
					Colorpicker:SlidePalette(Input)

					if PaletteChanged then
						return
					end

					PaletteChanged = Input.Changed:Connect(function()
						if Input.UserInputState == Enum.UserInputState.End then
							SlidingPalette = false
							PaletteChanged:Disconnect()
							PaletteChanged = nil
						end
					end)
				end
			end)

			Items["Hue"]:Connect("InputBegan", function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					SlidingHue = true
					Colorpicker:SlideHue(Input)

					if HueChanged then
						return
					end

					HueChanged = Input.Changed:Connect(function()
						if Input.UserInputState == Enum.UserInputState.End then
							SlidingHue = false
							HueChanged:Disconnect()
							HueChanged = nil
						end
					end)
				end
			end)

			Items["Alpha"]:Connect("InputBegan", function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					SlidingAlpha = true
					Colorpicker:SlideAlpha(Input)

					if AlphaChanged then
						return
					end

					AlphaChanged = Input.Changed:Connect(function()
						if Input.UserInputState == Enum.UserInputState.End then
							SlidingAlpha = false
							AlphaChanged:Disconnect()
							AlphaChanged = nil
						end
					end)
				end
			end)

			Library:Connect(UserInputService.InputChanged, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
					if SlidingPalette then
						Colorpicker:SlidePalette(Input)
					end
					if SlidingHue then
						Colorpicker:SlideHue(Input)
					end
					if SlidingAlpha then
						Colorpicker:SlideAlpha(Input)
					end
				end
			end)

			Library:Connect(UserInputService.InputBegan, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if Colorpicker.IsOpen then
						if Items["ColorpickerWindow"]:IsMouseOverFrame() then
							return
						end

						Colorpicker:SetOpen(false)
					end
				end
			end)

			if Data.Default then
				Colorpicker:Set(Data.Default, Data.Alpha)
			end

			SetFlags[Colorpicker.Flag] = function(Value, Alpha)
				Colorpicker:Set(Value, Alpha)
			end

			return Colorpicker, Items
		end

		Library.CreateKeybind = function(Self, Data)
			local Keybind = {
				Flag = Data.Flag,
				IsOpen = false,
				Key = "",
				Mode = "",
				Value = "",
				Toggled = false,
				Picking = false,
				Items = { },
			}

			local Items = { } do
				Items["KeyButton"] = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Data.Parent.Instance,
					TextColor3 = Library.Theme["Inactive Text"],
					Text = "[...]",
					AutoButtonColor = false,
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 0, 0, 16),
					TextXAlignment = Enum.TextXAlignment.Right,
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X
				}):AddToTheme({TextColor3 = 'Inactive Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["KeyButton"].Instance
				})

				Library:Create("UIPadding", {
					Parent = Items["KeyButton"].Instance,
					PaddingRight = UDim.new(0, -1)
				})

				Items["KeybindWindow"] = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Library.UnusedHolder.Instance,
					Visible = false,
					TextColor3 = Color3.fromRGB(0, 0, 0),
					Text = "",
					AutoButtonColor = false,
					Size = UDim2.new(0, 200, 0, 50),
					Position = UDim2.new(0, 1030, 0, 197),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Library.Theme["Background"]
				}):AddToTheme({BackgroundColor3 = 'Background'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["KeybindWindow"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["KeybindWindow"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIPadding", {
					Name = "\0",
					Parent = Items["KeybindWindow"].Instance,
					PaddingTop = UDim.new(0, 6),
					PaddingBottom = UDim.new(0, 6),
					PaddingRight = UDim.new(0, 6),
					PaddingLeft = UDim.new(0, 6)
				})

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["KeybindWindow"].Instance,
					Padding = UDim.new(0, 4),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				Keybind.Items = Items
			end

			Keybind.Holder = Items["KeybindWindow"]

			local ApplyKeyDisplay = function()
				local Bound = Keybind.Value ~= nil and Keybind.Value ~= "" and Keybind.Value ~= "None"
				local Key = Keybind.Picking and "Accent" or (Bound and "Text" or "Inactive Text")

				Items["KeyButton"].Instance.TextSize = Library.FontSize - 2
				Items["KeyButton"].Instance.Text = "[" .. ((Bound and not Keybind.Picking) and Keybind.Value or "...") .. "]"

				Items["KeyButton"]:ChangeItemTheme({TextColor3 = Key})
				Items["KeyButton"]:Tween({TextColor3 = Library.Theme[Key]})
			end

			local Debounce = false
			local KeybindWindow = Items["KeybindWindow"].Instance
			local KeyButton = Items["KeyButton"].Instance
			local IsSettings = Data.Section and Data.Section.IsSettings

			function Keybind:SetOpen(Bool)
				if Debounce then
					return
				end

				Keybind.IsOpen = Bool
				Debounce = true

				if Keybind.IsOpen then
					KeybindWindow.Position = UDim2.new(0, KeyButton.AbsolutePosition.X, 0, KeyButton.AbsolutePosition.Y + KeyButton.AbsoluteSize.Y + GuiInset)
					KeybindWindow.Parent = Library.Holder.Instance

					Items["KeybindWindow"]:Tween({Position = UDim2.new(0, KeyButton.AbsolutePosition.X, 0, KeyButton.AbsolutePosition.Y + KeyButton.AbsoluteSize.Y + 10 + GuiInset)})
					Items["KeybindWindow"]:FadeDescendants(true, function()
						Debounce = false
					end)

					for Index, Value in Library.OpenFrames do
						if Value ~= IsSettings then
							Value:SetOpen(false)
						end
					end

					Library.OpenFrames[Keybind] = Keybind
				else
					Items["KeybindWindow"]:Tween({Position = UDim2.new(0, KeyButton.AbsolutePosition.X, 0, KeyButton.AbsolutePosition.Y + KeyButton.AbsoluteSize.Y - 10 + GuiInset)})
					Items["KeybindWindow"]:FadeDescendants(false, function()
						Items["KeybindWindow"].Instance.Parent = Library.UnusedHolder.Instance
						Debounce = false
					end)

					if Library.OpenFrames[Keybind] then
						Library.OpenFrames[Keybind] = nil
					end
				end

				local Descendants = KeybindWindow:GetDescendants()
				table.insert(Descendants, KeybindWindow)

				for Index, Value in Descendants do
					if not Value.ClassName:find("UI") then
						if IsSettings then
							Value.ZIndex = Keybind.IsOpen and Library.ZIndexOrder.KeybindWindow or 1
						else
							Value.ZIndex = Keybind.IsOpen and Library.ZIndexOrder.KeybindWindow + 1 or 1
						end
					end
				end
			end

			local KeybindObject
			if Library.KeyList then
				KeybindObject = Library.KeyList:Add("", "")
			end

			local Update = function()
				if KeybindObject then
					KeybindObject:Set(Data.Name, Keybind.Mode, Keybind.Value)
					KeybindObject:SetStatus(Keybind.Toggled)

					if Keybind.Mode == "Hold" then
						KeybindObject:SetMode(Keybind.Toggled and "holding" or "off")
					elseif Keybind.Mode == "Always" then
						KeybindObject:SetMode("always on")
					else
						KeybindObject:SetMode(Keybind.Toggled and "toggled" or "off")
					end
				end
			end

			function Keybind:SetMode()
				Flags[Keybind.Flag] = {
					Mode = Keybind.Mode,
					Key = Keybind.Key,
					Toggled = Keybind.Toggled
				}

				if Data.Callback then
					Library:SafeCall(Data.Callback, Keybind.Toggled)
				end

				Update()
			end

			local ModeDropdown = Library:Dropdown({
				Name = "mode",
				Flag = Keybind.Flag .. "ModeDropdown",
				Parent = Items["KeybindWindow"],
				Items = { "Toggle", "Hold", "Always" },
				Default = "Toggle",
				Callback = function(Value)
					Keybind.Mode = Value
					Keybind:SetMode()

					if Value == "Always" then
						Keybind:Press(true)
					end
				end
			})

			local ShowInKeybindsList = Library:Toggle({
				Name = "show in keybinds list",
				Flag = Data.Flag .. "ShowInKeybindsList",
				Parent = Items["KeybindWindow"],
				Default = true,
				Callback = function(Value)
					if KeybindObject then
						KeybindObject:SetVis(Value)
						Update()
					end
				end
			})

			if Data.Toggle then
				Library:Toggle({
					Name = "sync",
					Flag = Data.Flag .. "Sync",
					Parent = Items["KeybindWindow"],
					Default = true,
				})
			end

			function Keybind:Press(Bool)
				if Keybind.Mode == "Toggle" then
					Keybind.Toggled = not Keybind.Toggled
				elseif Keybind.Mode == "Hold" then
					Keybind.Toggled = Bool
				elseif Keybind.Mode == "Always" then
					Keybind.Toggled = true
				end

				Flags[Keybind.Flag] = {
					Mode = Keybind.Mode,
					Key = Keybind.Key,
					Toggled = Keybind.Toggled
				}

				if Data.Callback then
					Library:SafeCall(Data.Callback, Keybind.Toggled)
				end

				Update()
			end

			function Keybind:Set(Key)
				if string.find(tostring(Key), "Enum") then
					Keybind.Key = tostring(Key)
					Key = Key.Name == "Backspace" and "None" or Key.Name

					local KeyString = Keys[Keybind.Key] or string.gsub(Key, "Enum.", "") or "None"
					local TextToDisplay = string.gsub(string.gsub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"

					Keybind.Value = TextToDisplay
					Keybind.Picking = false
					ApplyKeyDisplay()

					Flags[Keybind.Flag] = {
						Mode = Keybind.Mode,
						Key = Keybind.Key,
						Toggled = Keybind.Toggled
					}

					if Data.Callback then
						Library:SafeCall(Data.Callback, Keybind.Toggled)
					end

					Update()
				elseif type(Key) == "table" then
					local RealKey = Key.Key == "Backspace" and "None" or Key.Key
					Keybind.Key = tostring(Key.Key)

					if Key.Mode then
						Keybind.Mode = Key.Mode
						Keybind:SetMode(Key.Mode)
					else
						Keybind.Mode = "Toggle"
						Keybind:SetMode("Toggle")
					end

					local KeyString = Keys[Keybind.Key] or string.gsub(tostring(RealKey), "Enum.", "") or RealKey
					local TextToDisplay = KeyString and string.gsub(string.gsub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"
					TextToDisplay = string.gsub(string.gsub(KeyString, "KeyCode.", ""), "UserInputType.", "")

					Keybind.Value = TextToDisplay
					Keybind.Picking = false
					ApplyKeyDisplay()

					if Data.Callback then
						Library:SafeCall(Data.Callback, Keybind.Toggled)
					end

					Update()
				elseif table.find({"Toggle", "Hold", "Always"}, Key) then
					Keybind.Mode = Key
					Keybind:SetMode(Key)

					if Data.Callback then
						Library:SafeCall(Data.Callback, Keybind.Toggled)
					end
				end

				Keybind.Picking = false
			end

			Items["KeyButton"]:Connect("MouseButton1Click", function()
				if Keybind.Picking then
					return
				end

				Keybind.Picking = true
				ApplyKeyDisplay()

				local InputBegan
				InputBegan = UserInputService.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.Keyboard then
						Keybind:Set(Input.KeyCode)
					else
						Keybind:Set(Input.UserInputType)
					end

					Keybind.Picking = false
					ApplyKeyDisplay()

					InputBegan:Disconnect()
					InputBegan = nil
				end)
			end)

			Library:Connect(UserInputService.InputBegan, function(Input, GPE)
				if Keybind.Value == "None" then
					return
				end

				if Keybind.IsOpen and not Items["KeybindWindow"]:IsMouseOverFrame() and not ModeDropdown.Items.OptionHolder:IsMouseOverFrame() then
					Keybind:SetOpen(false)
				end

				if Data.Toggle and Data.GateByToggle and not Data.Toggle.Value then
					return
				end

				if not GPE then
					if tostring(Input.KeyCode) == Keybind.Key then
						if Keybind.Mode == "Toggle" then
							Keybind:Press()
						elseif Keybind.Mode == "Hold" then
							Keybind:Press(true)
						elseif Keybind.Mode == "Always" then
							Keybind:Press(true)
						end
					elseif tostring(Input.UserInputType) == Keybind.Key then
						if Keybind.Mode == "Toggle" then
							Keybind:Press()
						elseif Keybind.Mode == "Hold" then
							Keybind:Press(true)
						elseif Keybind.Mode == "Always" then
							Keybind:Press(true)
						end
					end
				end
			end)

			Library:Connect(UserInputService.InputEnded, function(Input, GPE)
				if GPE then
					return
				end

				if Keybind.Value == "None" then
					return
				end

				if tostring(Input.KeyCode) == Keybind.Key then
					if Keybind.Mode == "Hold" then
						Keybind:Press(false)
					elseif Keybind.Mode == "Always" then
						Keybind:Press(true)
					end
				elseif tostring(Input.UserInputType) == Keybind.Key then
					if Keybind.Mode == "Hold" then
						Keybind:Press(false)
					elseif Keybind.Mode == "Always" then
						Keybind:Press(true)
					end
				end
			end)

			Items["KeyButton"]:Connect("MouseButton2Down", function()
				Keybind:SetOpen(not Keybind.IsOpen)
			end)

			if Data.Default then
				Keybind:Set({
					Mode = Data.Mode or "Toggle",
					Key = Data.Default,
				})
			end

			SetFlags[Keybind.Flag] = function(Value)
				Keybind:Set(Value)
			end

			return Keybind, Items
		end

		Library.Window = function(Self, Params)
			Params = Params or { }

			local Window = {
				Name = Params.Name or Params.name or "Window",

				IsOpen = true,
				Pages = { },
				Items = { }
			}

			local Items = { } do
				if IsMobile then
					Library:Create("UIScale", {
						Parent = Items["MainFrame"],
						Scale = 0.67
					})
				end

				Items["MainFrame"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Library.Holder.Instance,
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0, 485, 0, 520),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Background"]
				}):AddToTheme({BackgroundColor3 = 'Background'})

				Items["MainFrame"]:MakeDraggable()
				Items["MainFrame"]:MakeResizeable(Vector2.new(440, 440))

				Library:RegisterWindow(Items["MainFrame"])

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["MainFrame"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["MainFrame"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["MainFrame"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 2"],
					BorderOffset = UDim.new(0, 2)
				}):AddToTheme({Color = 'Outline 2'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["MainFrame"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 4"],
					BorderOffset = UDim.new(0, 3)
				}):AddToTheme({Color = 'Outline 4'})

				Items["AccentLine"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["MainFrame"].Instance,
					Size = UDim2.new(1, 0, 0, 1),
					Position = UDim2.new(0, 0, 0, 0),
					BorderSizePixel = 0,
					ZIndex = 3,
					BackgroundColor3 = Library.Theme["Accent"]
				}):AddToTheme({BackgroundColor3 = 'Accent'})

				Library:AccentGradient(Items["AccentLine"], 0)

				Items["Pages"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["MainFrame"].Instance,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 6, 0, 33),
					Size = UDim2.new(1, -12, 0, 22),
					BorderSizePixel = 0
				})

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["Pages"].Instance,
					FillDirection = Enum.FillDirection.Horizontal,
					Padding = UDim.new(0, 0),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				Items["Content"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["MainFrame"].Instance,
					Position = UDim2.new(0, 8, 0, 58),
					Size = UDim2.new(1, -16, 1, -66),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Content"]
				}):AddToTheme({BackgroundColor3 = 'Content'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Content"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Content"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Content"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 2"],
					BorderOffset = UDim.new(0, 2)
				}):AddToTheme({Color = 'Outline 2'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Content"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 4"],
					BorderOffset = UDim.new(0, 3)
				}):AddToTheme({Color = 'Outline 4'})

				Items["Title"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["MainFrame"].Instance,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 0, 1),
					Size = UDim2.new(1, 0, 0, 29),
					ZIndex = 2,
					BackgroundColor3 = Library.Theme["Inline"]
				}):AddToTheme({BackgroundColor3 = 'Inline'})

				Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Title"].Instance,
					AnchorPoint = Vector2.new(0, 1),
					Position = UDim2.new(0, 0, 1, 0),
					Size = UDim2.new(1, 0, 0, 1),
					ZIndex = 3,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Outline 1"]
				}):AddToTheme({BackgroundColor3 = 'Outline 1'})

				Library:Shade(Items["Title"])

				Items["Icon"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Title"].Instance,
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 9, 0.5, 0),
					Size = UDim2.new(0, 16, 0, 16),
					ZIndex = 3,
					BorderSizePixel = 0,
					BackgroundTransparency = 1
				})

				local IconBars = {
					{Position = UDim2.new(0, 0, 0.5, -1), Size = UDim2.new(0, 4, 0, 2), Rotation = 0, Center = false},
					{Position = UDim2.new(0, 6, 0.5, 0), Size = UDim2.new(0, 2, 0, 10), Rotation = 35, Center = true},
					{Position = UDim2.new(0, 10, 0.5, 0), Size = UDim2.new(0, 2, 0, 10), Rotation = -35, Center = true},
					{Position = UDim2.new(0, 12, 0.5, -1), Size = UDim2.new(0, 4, 0, 2), Rotation = 0, Center = false}
				}

				for _, Bar in IconBars do
					local Piece = Library:Create("Frame", {
						Name = "\0",
						Parent = Items["Icon"].Instance,
						AnchorPoint = Bar.Center and Vector2.new(0.5, 0.5) or Vector2.new(0, 0),
						Position = Bar.Position,
						Size = Bar.Size,
						Rotation = Bar.Rotation,
						ZIndex = 4,
						BorderSizePixel = 0,
						BackgroundColor3 = Library.Theme["Accent"]
					}):AddToTheme({BackgroundColor3 = 'Accent'})

					Library:AccentGradient(Piece, 90)
				end

				Items["ActualTitle"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Title"].Instance,
					BackgroundTransparency = 1,
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 30, 0.5, 0),
					Size = UDim2.new(0, 0, 0, 18),
					ZIndex = 3,
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X
				})

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["ActualTitle"].Instance,
					FillDirection = Enum.FillDirection.Horizontal,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					Padding = UDim.new(0, 0),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				do
					local TitleParts = string.split(Window.Name, "•")
					for PartIdx, Part in TitleParts do
						if PartIdx > 1 then
							local DL = Library:Create("TextLabel", {
								Name = "\0",
								FontFace = Library.BoldFont,
								TextSize = Library.FontSize,
								Parent = Items["ActualTitle"].Instance,
								LayoutOrder = (PartIdx - 1) * 2,
								RichText = false,
								TextColor3 = Library.Theme["Accent"],
								Text = "•",
								ZIndex = 3,
								Size = UDim2.new(0, 0, 0, 18),
								BorderSizePixel = 0,
								BackgroundTransparency = 1,
								AutomaticSize = Enum.AutomaticSize.X
							}):AddToTheme({TextColor3 = 'Accent'})
							Library:Create("UIStroke", {Name = "\0", Parent = DL.Instance})
						end
						if Part ~= "" then
							local PL = Library:Create("TextLabel", {
								Name = "\0",
								FontFace = Library.BoldFont,
								TextSize = Library.FontSize,
								Parent = Items["ActualTitle"].Instance,
								LayoutOrder = (PartIdx - 1) * 2 + 1,
								RichText = true,
								TextColor3 = Library.Theme["Text"],
								Text = Part,
								ZIndex = 3,
								Size = UDim2.new(0, 0, 0, 18),
								BorderSizePixel = 0,
								BackgroundTransparency = 1,
								AutomaticSize = Enum.AutomaticSize.X
							}):AddToTheme({TextColor3 = 'Text'})
							Library:Create("UIStroke", {Name = "\0", Parent = PL.Instance})
						end
					end
				end

				Items["IconBar"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Library.Holder.Instance,
					AnchorPoint = Vector2.new(0.5, 0),
					Position = UDim2.new(0.5, 0, 0, 8),
					Size = UDim2.new(0, 126, 0, 26),
					ZIndex = 60,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Background"]
				}):AddToTheme({BackgroundColor3 = 'Background'})

				Items["IconBar"]:MakeDraggable()

				for _, Layer in {
					{Key = "Outline 1", Offset = 0},
					{Key = "Outline 3", Offset = 1},
					{Key = "Outline 2", Offset = 2},
					{Key = "Outline 4", Offset = 3}
				} do
					Library:Create("UIStroke", {
						Name = "\0",
						Parent = Items["IconBar"].Instance,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						LineJoinMode = Enum.LineJoinMode.Miter,
						Color = Library.Theme[Layer.Key],
						BorderOffset = UDim.new(0, Layer.Offset)
					}):AddToTheme({Color = Layer.Key})
				end

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["IconBar"].Instance,
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					Padding = UDim.new(0, 4),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				local MakeIconButton = function(Order)
					local Button = Library:Create("TextButton", {
						Name = "\0",
						Parent = Items["IconBar"].Instance,
						Text = "",
						AutoButtonColor = false,
						LayoutOrder = Order,
						Size = UDim2.new(0, 22, 0, 20),
						ZIndex = 61,
						BorderSizePixel = 0,
						BackgroundTransparency = 1,
						BackgroundColor3 = Library.Theme["Element"]
					}):AddToTheme({BackgroundColor3 = 'Element'})

					Button:Connect("MouseEnter", function()
						Button:Tween({BackgroundTransparency = 0}, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
					end)

					Button:Connect("MouseLeave", function()
						Button:Tween({BackgroundTransparency = 1}, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
					end)

					return Button
				end

				Items["HomeGlyphs"] = { }
				Items["ConsoleGlyphs"] = { }
				Items["PlayersGlyphs"] = { }
				Items["KeybindsGlyphs"] = { }
				Items["NotifyGlyphs"] = { }

				Library.IconCut = function(Self, Parent, Position, Size, Radius, Rotation)
					local Cut = Library:Create("Frame", {
						Name = "\0",
						Parent = Parent.Instance,
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = Position,
						Size = Size,
						Rotation = Rotation or 0,
						ZIndex = 63,
						BorderSizePixel = 0,
						BackgroundColor3 = Library.Theme["Background"]
					}):AddToTheme({BackgroundColor3 = 'Background'})

					if Radius then
						Library:IconRound(Cut, Radius)
					end

					return Cut
				end

				Library.IconOutline = function(Self, Parent, Position, Size, Radius, Thickness, Registry)
					local Frame = Library:Create("Frame", {
						Name = "\0",
						Parent = Parent.Instance,
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = Position,
						Size = Size,
						ZIndex = 62,
						BorderSizePixel = 0,
						BackgroundTransparency = 1
					})

					Library:Create("UICorner", {
						Name = "\0",
						Parent = Frame.Instance,
						CornerRadius = UDim.new(0, Radius or 0)
					})

					local Stroke = Library:Create("UIStroke", {
						Name = "\0",
						Parent = Frame.Instance,
						Thickness = Thickness or 1.6,
						Color = Library.Theme["Accent"]
					}):AddToTheme({Color = 'Accent'})

					if Registry then
						table.insert(Registry, {Item = Stroke, Property = "Color"})
					end

					return Frame
				end

				local SetIconState = function(Registry, Active)
					local Key = Active and "Accent" or "Inactive Text"

					for _, Entry in Registry do
						Entry.Item:ChangeItemTheme({[Entry.Property] = Key})
						Entry.Item:Tween({[Entry.Property] = Library.Theme[Key]}, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
					end
				end

				local MakeIconPiece = function(Parent, Position, Size, Rotation, Registry)
					local Piece = Library:Create("Frame", {
						Name = "\0",
						Parent = Parent.Instance,
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = Position,
						Size = Size,
						Rotation = Rotation or 0,
						ZIndex = 62,
						BorderSizePixel = 0,
						BackgroundColor3 = Library.Theme["Accent"]
					}):AddToTheme({BackgroundColor3 = 'Accent'})

					Library:AccentGradient(Piece, 90)

					if Registry then
						table.insert(Registry, {Item = Piece, Property = "BackgroundColor3"})
					end

					return Piece
				end

				Items["HomeButton"] = MakeIconButton(1)

				for Index, Bar in {
					{Position = UDim2.new(0.5, -3.8, 0.5, -3.6), Size = UDim2.new(0, 11, 0, 4), Rotation = -41},
					{Position = UDim2.new(0.5, 3.8, 0.5, -3.6), Size = UDim2.new(0, 11, 0, 4), Rotation = 41},
					{Position = UDim2.new(0.5, 0, 0.5, 3.2), Size = UDim2.new(0, 11.4, 0, 8.2), Rotation = 0}
				} do
					Library:IconRound(MakeIconPiece(Items["HomeButton"], Bar.Position, Bar.Size, Bar.Rotation, Items["HomeGlyphs"]), 1.4)
				end

				MakeIconPiece(Items["HomeButton"], UDim2.new(0.5, 0, 0.5, -0.9), UDim2.new(0, 5.2, 0, 5.2), 45, Items["HomeGlyphs"])

				Library:IconCut(Items["HomeButton"], UDim2.new(0.5, 0, 0.5, 4.9), UDim2.new(0, 4.2, 0, 5.6), 2)

				Items["ConsoleButton"] = MakeIconButton(2)

				Library:IconRound(MakeIconPiece(Items["ConsoleButton"], UDim2.new(0.5, 0, 0.5, 0), UDim2.new(0, 16, 0, 13), 0, Items["ConsoleGlyphs"]), 2)

				Library:IconCut(Items["ConsoleButton"], UDim2.new(0.5, 0, 0.5, 1.1), UDim2.new(0, 13, 0, 7.8), 0.5)

				for Index, Dot in {-5.2, -2.6, 0} do
					Library:IconCut(Items["ConsoleButton"], UDim2.new(0.5, Dot, 0.5, -4.5), UDim2.new(0, 1.8, 0, 1.8), 99)
				end

				for Index, Bar in {
					{Position = UDim2.new(0.5, -3, 0.5, -0.4), Size = UDim2.new(0, 4.2, 0, 1.5), Rotation = 37},
					{Position = UDim2.new(0.5, -3, 0.5, 2), Size = UDim2.new(0, 4.2, 0, 1.5), Rotation = -37},
					{Position = UDim2.new(0.5, 2.7, 0.5, 3.2), Size = UDim2.new(0, 4.4, 0, 1.5), Rotation = 0}
				} do
					local Piece = MakeIconPiece(Items["ConsoleButton"], Bar.Position, Bar.Size, Bar.Rotation, Items["ConsoleGlyphs"])

					Piece.Instance.ZIndex = 64

					Library:IconRound(Piece, 1)
				end

				Window.UpdateIcons = function()
					SetIconState(Items["HomeGlyphs"], Window.IsOpen ~= false)
				end

				Library.UpdateConsoleIcon = function(Active)
					SetIconState(Items["ConsoleGlyphs"], Active and true or false)
				end

				Window.UpdateIcons()
				Library.UpdateConsoleIcon(false)

				Items["HomeButton"]:Connect("MouseButton1Click", function()
					Window:SetOpen(not Window.IsOpen)
				end)

				Items["ConsoleButton"]:Connect("MouseButton1Click", function()
					local Target = Library.ConsoleObject

					if Target and Target.Items and Target.Items["Console"] then
						Target:SetVisibility(not Target.Items["Console"].Instance.Visible)
					end
				end)

				Items["PlayersButton"] = MakeIconButton(3)

				Library:IconRound(MakeIconPiece(Items["PlayersButton"], UDim2.new(0.5, -6, 0.5, -2), UDim2.new(0, 4, 0, 4), 0, Items["PlayersGlyphs"]), 99)
				Library:IconRound(MakeIconPiece(Items["PlayersButton"], UDim2.new(0.5, -6, 0.5, 4), UDim2.new(0, 6, 0, 5), 0, Items["PlayersGlyphs"]), 2)

				Library:IconRound(MakeIconPiece(Items["PlayersButton"], UDim2.new(0.5, 6, 0.5, -2), UDim2.new(0, 4, 0, 4), 0, Items["PlayersGlyphs"]), 99)
				Library:IconRound(MakeIconPiece(Items["PlayersButton"], UDim2.new(0.5, 6, 0.5, 4), UDim2.new(0, 6, 0, 5), 0, Items["PlayersGlyphs"]), 2)

				Library:IconRound(MakeIconPiece(Items["PlayersButton"], UDim2.new(0.5, 0, 0.5, -3), UDim2.new(0, 6, 0, 6), 0, Items["PlayersGlyphs"]), 99)
				Library:IconRound(MakeIconPiece(Items["PlayersButton"], UDim2.new(0.5, 0, 0.5, 4), UDim2.new(0, 9, 0, 7), 0, Items["PlayersGlyphs"]), 3)

				Items["KeybindsButton"] = MakeIconButton(4)

				Items["KeybindsGlyph"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["KeybindsButton"].Instance,
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0, 16, 0, 12),
					ZIndex = 62,
					BorderSizePixel = 0,
					BackgroundTransparency = 1
				})

				Items["KeybindsOutline"] = Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["KeybindsGlyph"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Inactive Text"]
				}):AddToTheme({Color = 'Inactive Text'})

				table.insert(Items["KeybindsGlyphs"], {Item = Items["KeybindsOutline"], Property = "Color"})

				Library:Create("UICorner", {
					Name = "\0",
					Parent = Items["KeybindsGlyph"].Instance,
					CornerRadius = UDim.new(0, 2)
				})

				Library:IconRound(MakeIconPiece(Items["KeybindsGlyph"], UDim2.new(0.5, -5, 0.5, -2), UDim2.new(0, 2, 0, 2), 0, Items["KeybindsGlyphs"]), 1)
				Library:IconRound(MakeIconPiece(Items["KeybindsGlyph"], UDim2.new(0.5, -2, 0.5, -2), UDim2.new(0, 2, 0, 2), 0, Items["KeybindsGlyphs"]), 1)
				Library:IconRound(MakeIconPiece(Items["KeybindsGlyph"], UDim2.new(0.5, 2, 0.5, -2), UDim2.new(0, 2, 0, 2), 0, Items["KeybindsGlyphs"]), 1)
				Library:IconRound(MakeIconPiece(Items["KeybindsGlyph"], UDim2.new(0.5, 5, 0.5, -2), UDim2.new(0, 2, 0, 2), 0, Items["KeybindsGlyphs"]), 1)

				Library:IconRound(MakeIconPiece(Items["KeybindsGlyph"], UDim2.new(0.5, -6, 0.5, 2), UDim2.new(0, 2, 0, 2), 0, Items["KeybindsGlyphs"]), 99)
				Library:IconRound(MakeIconPiece(Items["KeybindsGlyph"], UDim2.new(0.5, 0, 0.5, 2), UDim2.new(0, 8, 0, 2), 0, Items["KeybindsGlyphs"]), 1)
				Library:IconRound(MakeIconPiece(Items["KeybindsGlyph"], UDim2.new(0.5, 6, 0.5, 2), UDim2.new(0, 2, 0, 2), 0, Items["KeybindsGlyphs"]), 99)

				Items["NotifyButton"] = MakeIconButton(5)

				Library:IconRound(MakeIconPiece(Items["NotifyButton"], UDim2.new(0.5, 0, 0.5, 0), UDim2.new(0, 14, 0, 14), 0, Items["NotifyGlyphs"]), 99)

				Library:IconCut(Items["NotifyButton"], UDim2.new(0.5, 0, 0.5, -3), UDim2.new(0, 2, 0, 2), 99)
				Library:IconCut(Items["NotifyButton"], UDim2.new(0.5, 0, 0.5, 2), UDim2.new(0, 2, 0, 5), 1)

				Library:IconImage(Items["HomeButton"], "Home", Items["HomeGlyphs"])
				Library:IconImage(Items["ConsoleButton"], "Console", Items["ConsoleGlyphs"])
				Library:IconImage(Items["PlayersButton"], "Players", Items["PlayersGlyphs"])
				Library:IconImage(Items["KeybindsButton"], "Keybinds", Items["KeybindsGlyphs"])
				Library:IconImage(Items["NotifyButton"], "Notifications", Items["NotifyGlyphs"])

				Library.UpdatePlayersIcon = function(Active)
					SetIconState(Items["PlayersGlyphs"], Active and true or false)
				end

				Library.UpdateKeybindsIcon = function(Active)
					SetIconState(Items["KeybindsGlyphs"], Active and true or false)
				end

				Library.UpdateNotifyIcon = function(Active)
					SetIconState(Items["NotifyGlyphs"], Active and true or false)
				end

				Library.IconVisible = function(Object, Key)
					local Visible = false

					pcall(function()
						Visible = Object.Items[Key].Instance.Visible
					end)

					return Visible
				end

				Library.UpdatePlayersIcon(Library.PlayerListObject and Library.IconVisible(Library.PlayerListObject, "PlayerList"))
				Library.UpdateKeybindsIcon(Library.KeyList and Library.IconVisible(Library.KeyList, "KeybindList"))
				Library.UpdateNotifyIcon(Library.NotificationsEnabled ~= false)

				Items["PlayersButton"]:Connect("MouseButton1Click", function()
					local Target = Library.PlayerListObject

					if not Target then
						return
					end

					Target:SetVisibility(not Library.IconVisible(Target, "PlayerList"))
				end)

				Items["KeybindsButton"]:Connect("MouseButton1Click", function()
					local Target = Library.KeyList

					if not Target then
						return
					end

					Target:SetVisibility(not Library.IconVisible(Target, "KeybindList"))
				end)

				Items["NotifyButton"]:Connect("MouseButton1Click", function()
					Library.NotificationsEnabled = Library.NotificationsEnabled == false
					Library.UpdateNotifyIcon(Library.NotificationsEnabled)

					if Library.NotificationsEnabled then
						Library:Notification({Name = "notifications on", Time = 2})
					end
				end)

				Window.Items = Items
			end

			local Debounce = false

			function Window:SetOpen(Bool)
				if Debounce then
					return
				end

				Debounce = true

				Window.IsOpen = Bool

				if Window.UpdateIcons then
					Window.UpdateIcons()
				end

				Items["MainFrame"]:FadeDescendants(Bool, function()
					Debounce = false
				end)

				for Index, Value in Library.OpenFrames do
					Value:SetOpen(false)
				end
			end

			function Window:Center()
				local AbsPos = Items["MainFrame"].Instance.AbsolutePosition
				Items["MainFrame"].Instance.AnchorPoint = Vector2.new(0, 0)
				task.wait()
				Items["MainFrame"].Instance.Position = UDim2.new(0, AbsPos.X, 0, AbsPos.Y + GuiInset)
			end

			Library:Connect(UserInputService.InputBegan, function(Input)
				if tostring(Input.KeyCode) == Library.MenuKeybind or tostring(Input.UserInputType) == Library.MenuKeybind then
					if UserInputService:GetFocusedTextBox() then
						return
					end

					Window:SetOpen(not Window.IsOpen)
				end
			end)

			Window:Center()
			return setmetatable(Window, Library)
		end

		Library.Page = function(Self, Params)
			Params = Params or { }

			local Page = {
				Name = Params.Name or Params.name or "Page",

				Window = Self,
				ColumnsData = { },
				Items = { },
				Active = false,
				Debounce = false
			}

			local Items = { } do
				Items["Inactive"] = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Page.Window.Items["Pages"].Instance,
					TextColor3 = Color3.fromRGB(0, 0, 0),
					Text = "",
					AutoButtonColor = false,
					AutomaticSize = Enum.AutomaticSize.None,
					Size = UDim2.new(0, 0, 1, 0),
					BorderSizePixel = 0,
					ZIndex = 2,
					BackgroundColor3 = Library.Theme["Inline"]
				}):AddToTheme({BackgroundColor3 = 'Inline'})

				Library:Create("UIPadding", {
					Name = "\0",
					Parent = Items["Inactive"].Instance,
					PaddingRight = UDim.new(0, 7),
					PaddingLeft = UDim.new(0, 7)
				})

				Items["Shade"] = Library:Create("UIGradient", {
					Name = "\0",
					Parent = Items["Inactive"].Instance,
					Rotation = 90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
					}
				})

				Items["Text"] = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.BoldFont,
					TextSize = Library.FontSize,
					Parent = Items["Inactive"].Instance,
					TextColor3 = Library.Theme["Inactive Text"],
					Text = Page.Name,
					AutomaticSize = Enum.AutomaticSize.X,
					AnchorPoint = Vector2.new(0.5, 0.5),
					Size = UDim2.new(0, 0, 0, 18),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					BorderSizePixel = 0,
					ZIndex = 2
				}):AddToTheme({TextColor3 = 'Inactive Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Text"].Instance
				})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Inactive"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Inactive"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				Items["Page"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Library.Holder.Instance,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					Visible = false,
					BorderSizePixel = 0
				})

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["Page"].Instance,
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					Padding = UDim.new(0, 2),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				Items["LeftColumn"] = Library:Create("ScrollingFrame", {
					Name = "\0",
					Parent = Items["Page"].Instance,
					ScrollBarImageColor3 = Library.Theme["Accent"],
					Active = true,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					ScrollBarThickness = 0,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					BorderSizePixel = 0,
					CanvasSize = UDim2.new(0, 0, 0, 0)
				}):AddToTheme({ScrollBarImageColor3 = 'Accent'})

				Library:Create("UIPadding", {
					Name = "\0",
					Parent = Items["LeftColumn"].Instance,
					PaddingTop = UDim.new(0, 6),
					PaddingBottom = UDim.new(0, 6),
					PaddingRight = UDim.new(0, 3),
					PaddingLeft = UDim.new(0, 3)
				})

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["LeftColumn"].Instance,
					Padding = UDim.new(0, 8),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				Items["RightColumn"] = Library:Create("ScrollingFrame", {
					Name = "\0",
					Parent = Items["Page"].Instance,
					ScrollBarImageColor3 = Library.Theme["Accent"],
					Active = true,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					ScrollBarThickness = 0,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					BorderSizePixel = 0,
					CanvasSize = UDim2.new(0, 0, 0, 0)
				}):AddToTheme({ScrollBarImageColor3 = 'Accent'})

				Library:Create("UIPadding", {
					Name = "\0",
					Parent = Items["RightColumn"].Instance,
					PaddingTop = UDim.new(0, 6),
					PaddingBottom = UDim.new(0, 6),
					PaddingRight = UDim.new(0, 3),
					PaddingLeft = UDim.new(0, 3)
				})

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["RightColumn"].Instance,
					Padding = UDim.new(0, 8),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				Page.ColumnsData[1] = Items["LeftColumn"]
				Page.ColumnsData[2] = Items["RightColumn"]

				Page.Items = Items
			end

			function Page:Turn()
				local Old = Page.Window.Current

				if Old == Page then
					return
				end

				if Page.Debounce then
					return
				end

				if Old and Old.Debounce then
					return
				end

				Page.Debounce = true

				if Old then
					Old.Items["Text"]:ChangeItemTheme({TextColor3 = "Inactive Text"})
					Old.Items["Text"]:Tween({TextColor3 = Library.Theme["Inactive Text"]})

					Old.Items["Inactive"]:Tween({BackgroundColor3 = Library.Theme["Inline"]})

					if Old.Items["Shade"] then
						Old.Items["Shade"].Instance.Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
						}
					end

					Old.Items["Inactive"].Instance.Size = UDim2.new(1 / math.max(#Page.Window.Pages, 1), 0, 1, 0)
					Old.Items["Text"].Instance.Position = UDim2.new(0.5, 0, 0.5, 0)

					Old.Items["Page"]:FadeDescendants(false, function()
						Old.Items["Page"].Instance.Parent = Library.UnusedHolder.Instance
					end)
				end

				Items["Page"].Instance.Parent = Page.Window.Items["Content"].Instance
				Items["Page"].Instance.Visible = true
				Items["Page"]:FadeDescendants(true, function()
					Page.Debounce = false
				end)

				Items["Text"]:ChangeItemTheme({TextColor3 = "Accent"})
				Items["Text"]:Tween({TextColor3 = Library.Theme.Accent})

				Items["Inactive"]:Tween({BackgroundColor3 = Library.Theme["Hovered Element"]})

				if Items["Shade"] then
					Items["Shade"].Instance.Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(226, 226, 226)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(184, 184, 184))
					}
				end

				Items["Inactive"].Instance.Size = UDim2.new(1 / math.max(#Page.Window.Pages, 1), 0, 1, 0)
				Items["Text"].Instance.Position = UDim2.new(0.5, 0, 0.5, 0)

				Page.Window.Current = Page
			end

			Items["Inactive"]:Connect("MouseButton1Down", function()
				Page:Turn()
			end)

			if #Page.Window.Pages == 0 then
				Page:Turn()
			end

			table.insert(Page.Window.Pages, Page)

			local PageCount = #Page.Window.Pages
			for _, ExistingPage in Page.Window.Pages do
				ExistingPage.Items["Inactive"].Instance.AutomaticSize = Enum.AutomaticSize.None
				ExistingPage.Items["Inactive"].Instance.Size = UDim2.new(1 / PageCount, 0, 1, 0)
			end

			return setmetatable(Page, Library)
		end

		Library.Section = function(Self, Params)
			Params = Params or { }

			local Section = {
				Name = Params.Name or Params.name or "Section",
				Side = Params.Side or Params.side or 1,

				Window = Self.Window,
				Page = Self,
				Items = { },
			}

			local Items = { } do
				local FullHeight = Params.FullHeight == true
				local MaxHeight = Params.MaxHeight or Params.maxheight or 240
				local ExtraHeight = Params.ExtraHeight or Params.extraheight or 0
				Items["Section"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Section.Page.ColumnsData[Section.Side].Instance,
					Size = FullHeight and UDim2.new(1, 0, 1, 0) or UDim2.new(1, 0, 0, 35),
					BorderSizePixel = 0,
					AutomaticSize = FullHeight and Enum.AutomaticSize.None or Enum.AutomaticSize.Y,
					ClipsDescendants = true,
					BackgroundColor3 = Library.Theme["Section Box"]
				}):AddToTheme({BackgroundColor3 = 'Section Box'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Section"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Section"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				Items["Header"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Section"].Instance,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(1, 0, 0, 25),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Element"]
				}):AddToTheme({BackgroundColor3 = 'Element'})

				Library:Create("UIGradient", {
					Name = "\0",
					Parent = Items["Header"].Instance,
					Rotation = 90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(218, 218, 218)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(167, 167, 167))
					}
				})

				Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Header"].Instance,
					AnchorPoint = Vector2.new(0, 1),
					Position = UDim2.new(0, 0, 1, 0),
					Size = UDim2.new(1, 0, 0, 1),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Outline 1"]
				}):AddToTheme({BackgroundColor3 = 'Outline 1'})

				Items["Text"] = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.BoldFont,
					TextSize = Library.FontSize,
					Parent = Items["Header"].Instance,
					TextColor3 = Library.Theme["Text"],
					Text = Section.Name,
					AnchorPoint = Vector2.new(0, 0.5),
					Size = UDim2.new(0, 0, 0, 16),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 7, 0.5, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X
				}):AddToTheme({TextColor3 = 'Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Text"].Instance
				})

				Items["Content"] = Library:Create("ScrollingFrame", {
					Name = "\0",
					Parent = Items["Section"].Instance,
					Active = true,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 4, 0, 30),
					Size = FullHeight and UDim2.new(1, -10, 1, -36) or UDim2.new(1, -10, 0, 0),
					BorderSizePixel = 0,
					CanvasSize = UDim2.new(0, 0, 0, 0),
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					ScrollingDirection = Enum.ScrollingDirection.Y,
					ElasticBehavior = Enum.ElasticBehavior.Never,
					ScrollBarThickness = 0
				})

				Items["ContentLayout"] = Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["Content"].Instance,
					Padding = UDim.new(0, 4),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				Items["ContentPadding"] = Library:Create("UIPadding", {
					Name = "\0",
					Parent = Items["Content"].Instance,
					PaddingBottom = UDim.new(0, 4)
				})

				if not FullHeight then
					local Layout = Items["ContentLayout"].Instance
					local Content = Items["Content"].Instance

					local function ResizeContent()
						Content.Size = UDim2.new(1, -10, 0, math.min(Layout.AbsoluteContentSize.Y + 4, MaxHeight) + ExtraHeight)
					end

					Library:Connect(Layout:GetPropertyChangedSignal("AbsoluteContentSize"), ResizeContent)
					ResizeContent()
				end

				Library:Scrollbar(Items["Content"], {Parent = Items["Section"], Top = 30, Right = 1, Bottom = 6, Track = true})

				if FullHeight then
					Library:Create("UIPadding", {
						Name = "\0",
						Parent = Items["Content"].Instance,
						PaddingRight = UDim.new(0, 0),
						PaddingBottom = UDim.new(0, 6)
					})
				end

				Library:Create("UIPadding", {
					Name = "\0",
					Parent = Items["Section"].Instance,
					PaddingBottom = UDim.new(0, 6)
				})

				Section.Items = Items
			end

			return setmetatable(Section, Library)
		end

		Library.MultiSection = function(Self, Params)
			Params = Params or { }

			local Resizable = Params.Resizable

			if Resizable == nil then
				Resizable = Params.resizable
			end

			if Resizable == nil then
				Resizable = true
			end

			local CanPopOut = Params.PopOut

			if CanPopOut == nil then
				CanPopOut = Params.popout
			end

			if CanPopOut == nil then
				CanPopOut = true
			end

			local MultiSection = {
				Side = Params.Side or Params.side or 1,
				Height = Params.Height or Params.height or 150,
				MinimumHeight = Params.MinimumHeight or Params.minimumheight or 80,
				MaximumHeight = Params.MaximumHeight or Params.maximumheight or 600,
				Resizable = Resizable,
				CanPopOut = CanPopOut,
				Popped = false,
				Window = Self.Window,
				Page = Self,
				Items = { },
				Current = nil,
				Sections = { }
			}

			local TabHeight = 20
			local TabPadding = 3

			local Items = { } do
				Items["MultiSection"] = Library:Create("Frame", {
					Name = "\0",
					Parent = MultiSection.Page.ColumnsData[MultiSection.Side].Instance,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, TabHeight + MultiSection.Height),
					BorderSizePixel = 0
				})

				Items["Sections"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["MultiSection"].Instance,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, TabHeight),
					BorderSizePixel = 0
				})

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["Sections"].Instance,
					FillDirection = Enum.FillDirection.Horizontal,
					Padding = UDim.new(0, TabPadding),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				Items["Body"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["MultiSection"].Instance,
					Position = UDim2.new(0, 0, 0, TabHeight),
					Size = UDim2.new(1, 0, 1, -TabHeight),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					BackgroundColor3 = Library.Theme["Section Box"]
				}):AddToTheme({BackgroundColor3 = 'Section Box'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Body"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Body"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				Items["Floating"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Library.Holder.Instance,
					Visible = false,
					Position = UDim2.fromOffset(200, 200),
					Size = UDim2.fromOffset(220, 200),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Background"]
				}):AddToTheme({BackgroundColor3 = 'Background'})

				for Index, Outline in {"Outline 1", "Outline 3", "Outline 2", "Outline 4"} do
					Library:Create("UIStroke", {
						Name = "\0",
						Parent = Items["Floating"].Instance,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						LineJoinMode = Enum.LineJoinMode.Miter,
						Color = Library.Theme[Outline],
						BorderOffset = UDim.new(0, Index - 1)
					}):AddToTheme({Color = Outline})
				end

				Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Floating"].Instance,
					Size = UDim2.new(1, 0, 0, 1),
					BorderSizePixel = 0,
					ZIndex = 3,
					BackgroundColor3 = Library.Theme["Accent"]
				}):AddToTheme({BackgroundColor3 = 'Accent'})

				Items["Floating"]:MakeResizeable(Vector2.new(170, 120))

				Library:RegisterWindow(Items["Floating"])

				Items["Grip"] = Library:Create("TextButton", {
					Name = "\0",
					Parent = Items["MultiSection"].Instance,
					Text = "",
					AutoButtonColor = false,
					BackgroundTransparency = 1,
					Visible = MultiSection.Resizable,
					AnchorPoint = Vector2.new(0, 1),
					Position = UDim2.new(0, 0, 1, 1),
					Size = UDim2.new(1, 0, 0, 2),
					ZIndex = 4,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Accent"]
				}):AddToTheme({BackgroundColor3 = 'Accent'})

				MultiSection.Items = Items
			end

			local function UpdateTabSizes()
				local Count = #MultiSection.Sections

				if Count == 0 then
					return
				end

				local Offset = -(TabPadding * (Count - 1)) / Count

				for _, SubSection in MultiSection.Sections do
					SubSection.Items["Inactive"].Instance.Size = UDim2.new(1 / Count, Offset, 0, SubSection.Active and TabHeight or TabHeight + 1)
				end
			end

			function MultiSection:SetHeight(Height)
				Height = math.clamp(Height, MultiSection.MinimumHeight, MultiSection.MaximumHeight)
				MultiSection.Height = Height

				if MultiSection.Popped then
					Items["Floating"].Instance.Size = UDim2.fromOffset(Items["Floating"].Instance.AbsoluteSize.X, Height + TabHeight + 12)
				else
					Items["MultiSection"].Instance.Size = UDim2.new(1, 0, 0, TabHeight + Height)
				end
			end

			local DropRing

			local function ShowDropRing(Bool)
				if Bool and not DropRing then
					DropRing = Library:Create("UIStroke", {
						Name = "\0",
						Parent = Items["MultiSection"].Instance,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						LineJoinMode = Enum.LineJoinMode.Miter,
						Thickness = 1,
						Color = Library.Theme["Accent"]
					}):AddToTheme({Color = 'Accent'})
				end

				if DropRing then
					DropRing.Instance.Enabled = Bool
				end
			end

			local function NearColumn()
				local Target = MultiSection.Page and MultiSection.Page.ColumnsData and MultiSection.Page.ColumnsData[MultiSection.Side]

				if not Target or not Target.Instance then
					return false
				end

				local Point = Library:MousePoint()
				local Origin = Target.Instance.AbsolutePosition
				local Size = Target.Instance.AbsoluteSize
				local Margin = 45

				return Point.X >= Origin.X - Margin and Point.X <= Origin.X + Size.X + Margin
					and Point.Y >= Origin.Y - Margin and Point.Y <= Origin.Y + Size.Y + Margin
			end

			function MultiSection:PopOut()
				if MultiSection.Popped or not Library.Holder then
					return
				end

				MultiSection.Popped = true

				local Frame = Items["MultiSection"].Instance
				local Position = Frame.AbsolutePosition
				local Width = math.max(Frame.AbsoluteSize.X, 170)

				Items["Floating"].Instance.Size = UDim2.fromOffset(Width + 8, MultiSection.Height + TabHeight + 12)
				local Anchor = Library:HolderPoint(Vector2.new(Position.X - 4, Position.Y - 4))

				Items["Floating"].Instance.Position = UDim2.fromOffset(Anchor.X, Anchor.Y)

				Items["Sections"].Instance.Parent = Items["Floating"].Instance
				Items["Sections"].Instance.Position = UDim2.new(0, 4, 0, 4)
				Items["Sections"].Instance.Size = UDim2.new(1, -8, 0, TabHeight)

				Items["Body"].Instance.Parent = Items["Floating"].Instance
				Items["Body"].Instance.Position = UDim2.new(0, 4, 0, 4 + TabHeight)
				Items["Body"].Instance.Size = UDim2.new(1, -8, 1, -(TabHeight + 8))

				Items["Floating"].Instance.Visible = true

				Items["MultiSection"].Instance.Visible = true
				Items["MultiSection"].Instance.Size = UDim2.new(1, 0, 0, TabHeight + MultiSection.Height)
				ShowDropRing(false)
			end

			function MultiSection:Dock()
				if not MultiSection.Popped then
					return
				end

				MultiSection.Popped = false

				MultiSection.Height = math.clamp(Items["Floating"].Instance.AbsoluteSize.Y - TabHeight - 12, MultiSection.MinimumHeight, MultiSection.MaximumHeight)

				Items["Sections"].Instance.Parent = Items["MultiSection"].Instance
				Items["Sections"].Instance.Position = UDim2.new(0, 0, 0, 0)
				Items["Sections"].Instance.Size = UDim2.new(1, 0, 0, TabHeight)

				Items["Body"].Instance.Parent = Items["MultiSection"].Instance
				Items["Body"].Instance.Position = UDim2.new(0, 0, 0, TabHeight)
				Items["Body"].Instance.Size = UDim2.new(1, 0, 1, -TabHeight)

				Items["Floating"].Instance.Visible = false
				Items["MultiSection"].Instance.Visible = true
				Items["MultiSection"].Instance.Size = UDim2.new(1, 0, 0, TabHeight + MultiSection.Height)
				ShowDropRing(false)
			end

			function MultiSection:SetPopped(Bool)
				if Bool then
					MultiSection:PopOut()
				else
					MultiSection:Dock()
				end
			end

			function MultiSection:SetVisibility(Bool)
				if MultiSection.Popped then
					Items["Floating"].Instance.Visible = Bool
				else
					Items["MultiSection"].Instance.Visible = Bool
				end
			end

			local ResizingHeight = false
			local ResizeStart = 0
			local ResizeStartHeight = 0

			Items["Grip"]:Connect("InputBegan", function(Input)
				if not MultiSection.Resizable or MultiSection.Popped then
					return
				end

				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Library:ClaimDrag()

					ResizingHeight = true
					Items["Grip"].Instance.BackgroundTransparency = 0
					ResizeStart = Input.Position.Y
					ResizeStartHeight = MultiSection.Height
				end
			end)

			local DragTracking = false
			local DraggingFloat = false
			local DragStart = Vector2.new(0, 0)
			local DragOffset = Vector2.new(0, 0)

			local function BeginTabDrag(Input)
				if not MultiSection.CanPopOut then
					return
				end

				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Library:ClaimDrag()

					DragTracking = true
					DragStart = Vector2.new(Input.Position.X, Input.Position.Y)
				end
			end

			Library:Connect(UserInputService.InputChanged, function(Input)
				if Input.UserInputType ~= Enum.UserInputType.MouseMovement and Input.UserInputType ~= Enum.UserInputType.Touch then
					return
				end

				if ResizingHeight then
					MultiSection:SetHeight(ResizeStartHeight + (Input.Position.Y - ResizeStart))
					return
				end

				local Position = Vector2.new(Input.Position.X, Input.Position.Y)

				if DragTracking and not DraggingFloat then
					if (Position - DragStart).Magnitude < 14 then
						return
					end

					if not MultiSection.Popped then
						MultiSection:PopOut()
					end

					DraggingFloat = true

					local FramePosition = Items["Floating"].Instance.AbsolutePosition

					DragOffset = Library:MousePoint() - Vector2.new(FramePosition.X, FramePosition.Y)
				end

				if DraggingFloat then
					local Target = Library:HolderPoint(Library:MousePoint() - DragOffset)

					Items["Floating"].Instance.Position = UDim2.fromOffset(Target.X, Target.Y)
					ShowDropRing(NearColumn())
				end
			end)

			Library:Connect(UserInputService.InputEnded, function(Input)
				if Input.UserInputType ~= Enum.UserInputType.MouseButton1 and Input.UserInputType ~= Enum.UserInputType.Touch then
					return
				end

				ResizingHeight = false
				Items["Grip"].Instance.BackgroundTransparency = 1

				if DraggingFloat then
					if NearColumn() then
						MultiSection:Dock()
					end

					ShowDropRing(false)
				end

				DragTracking = false
				DraggingFloat = false
			end)

			if MultiSection.Window and MultiSection.Window.Items and MultiSection.Window.Items["MainFrame"] then
				local MainFrame = MultiSection.Window.Items["MainFrame"].Instance

				Library:Connect(MainFrame:GetPropertyChangedSignal("Visible"), function()
					if MultiSection.Popped then
						Items["Floating"].Instance.Visible = MainFrame.Visible
					end
				end)
			end

			function MultiSection:Section(SectionParams)
				SectionParams = SectionParams or { }

				local SubSection = {
					Name = SectionParams.Name or SectionParams.name or "Section",
					Window = MultiSection.Window,
					Page = MultiSection.Page,
					MultiSection = MultiSection,
					Items = { },
					Active = false,
					Debounce = false
				}

				local SubItems = { } do
					SubItems["Inactive"] = Library:Create("TextButton", {
						Name = "\0",
						FontFace = Library.Font,
						TextSize = Library.FontSize,
						Parent = Items["Sections"].Instance,
						TextColor3 = Color3.fromRGB(0, 0, 0),
						Text = "",
						AutoButtonColor = false,
						Size = UDim2.new(1, 0, 0, TabHeight + 1),
						BorderSizePixel = 0,
						ZIndex = 2,
						BackgroundColor3 = Library.Theme["Element"]
					}):AddToTheme({BackgroundColor3 = 'Element'})

					SubItems["Shade"] = Library:Shade(SubItems["Inactive"])

					SubItems["Text"] = Library:Create("TextLabel", {
						Name = "\0",
						FontFace = Library.BoldFont,
						TextSize = Library.FontSize,
						Parent = SubItems["Inactive"].Instance,
						TextColor3 = Library.Theme["Inactive Text"],
						Text = SubSection.Name,
						AnchorPoint = Vector2.new(0.5, 0.5),
						Size = UDim2.new(1, -6, 0, 18),
						BackgroundTransparency = 1,
						Position = UDim2.new(0.5, 0, 0.5, 0),
						BorderSizePixel = 0,
						ZIndex = 2
					}):AddToTheme({TextColor3 = 'Inactive Text'})

					Library:Create("UIStroke", {
						Name = "\0",
						Parent = SubItems["Text"].Instance
					})

					Library:Create("UIStroke", {
						Name = "\0",
						Parent = SubItems["Inactive"].Instance,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						LineJoinMode = Enum.LineJoinMode.Miter,
						Color = Library.Theme["Outline 1"]
					}):AddToTheme({Color = 'Outline 1'})

					Library:Create("UIStroke", {
						Name = "\0",
						Parent = SubItems["Inactive"].Instance,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						LineJoinMode = Enum.LineJoinMode.Miter,
						Color = Library.Theme["Outline 3"],
						BorderOffset = UDim.new(0, 1)
					}):AddToTheme({Color = 'Outline 3'})

					SubItems["Hide"] = Library:Create("Frame", {
						Name = "\0",
						Parent = SubItems["Inactive"].Instance,
						Visible = false,
						AnchorPoint = Vector2.new(0, 1),
						Position = UDim2.new(0, 0, 1, 4),
						Size = UDim2.new(1, 0, 0, 4),
						ZIndex = 2,
						BorderSizePixel = 0,
						BackgroundColor3 = Library.Theme["Section Box"]
					}):AddToTheme({BackgroundColor3 = 'Section Box'})

					Library:Create("Frame", {
						Name = "\0",
						Parent = SubItems["Hide"].Instance,
						Size = UDim2.new(0, 1, 0, 3),
						Position = UDim2.new(1, 0, 0, 0),
						ZIndex = 2,
						BorderSizePixel = 0,
						BackgroundColor3 = Library.Theme["Outline 1"]
					}):AddToTheme({BackgroundColor3 = 'Outline 1'})

					Library:Create("Frame", {
						Name = "\0",
						Parent = SubItems["Hide"].Instance,
						AnchorPoint = Vector2.new(1, 0),
						Size = UDim2.new(0, 1, 0, 3),
						ZIndex = 2,
						BorderSizePixel = 0,
						BackgroundColor3 = Library.Theme["Outline 1"]
					}):AddToTheme({BackgroundColor3 = 'Outline 1'})

					SubItems["Hide2"] = Library:Create("Frame", {
						Name = "\0",
						Parent = SubItems["Inactive"].Instance,
						AnchorPoint = Vector2.new(0, 1),
						Position = UDim2.new(0, 0, 1, 1),
						Size = UDim2.new(1, 0, 0, 1),
						ZIndex = 2,
						BorderSizePixel = 0,
						BackgroundColor3 = Library.Theme["Element"]
					}):AddToTheme({BackgroundColor3 = 'Element'})

					SubItems["Content"] = Library:Create("ScrollingFrame", {
						Name = "\0",
						Parent = Items["Body"].Instance,
						Active = true,
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 4, 0, 4),
						Size = UDim2.new(1, -10, 1, -8),
						Visible = false,
						BorderSizePixel = 0,
						CanvasSize = UDim2.new(0, 0, 0, 0),
						AutomaticCanvasSize = Enum.AutomaticSize.Y,
						ScrollingDirection = Enum.ScrollingDirection.Y,
						ElasticBehavior = Enum.ElasticBehavior.Never,
						ScrollBarThickness = 0
					})

					Library:Create("UIListLayout", {
						Name = "\0",
						Parent = SubItems["Content"].Instance,
						Padding = UDim.new(0, 4),
						SortOrder = Enum.SortOrder.LayoutOrder
					})

					Library:Create("UIPadding", {
						Name = "\0",
						Parent = SubItems["Content"].Instance,
						PaddingBottom = UDim.new(0, 4)
					})

					Library:Scrollbar(SubItems["Content"], {Parent = Items["Body"], Top = 4, Right = 1, Bottom = 4, Track = true})

					SubSection.Items = SubItems
				end

				function SubSection:Turn()
					local Old = MultiSection.Current

					if Old == SubSection then
						return
					end

					if SubSection.Debounce then
						return
					end

					if Old and Old.Debounce then
						return
					end

					SubSection.Debounce = true

					if Old then
						Old.Active = false
						Old.Items["Text"]:ChangeItemTheme({TextColor3 = "Inactive Text"})
						Old.Items["Text"]:Tween({TextColor3 = Library.Theme["Inactive Text"]})
						Old.Items["Inactive"]:ChangeItemTheme({BackgroundColor3 = "Element"})
						Old.Items["Inactive"]:Tween({BackgroundColor3 = Library.Theme["Element"]})

						if Old.Items["Shade"] then
							Old.Items["Shade"].Instance.Color = ColorSequence.new{
								ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
								ColorSequenceKeypoint.new(0.5, Color3.fromRGB(226, 226, 226)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(184, 184, 184))
							}
						end
						Old.Items["Hide2"]:Tween({BackgroundTransparency = 0})
						Old.Items["Hide"].Instance.Visible = false
						Old.Items["Content"].Instance.Visible = false
					end

					SubSection.Active = true
					SubItems["Content"].Instance.Visible = true
					SubItems["Text"]:ChangeItemTheme({TextColor3 = "Accent"})
					SubItems["Text"]:Tween({TextColor3 = Library.Theme["Accent"]})
					SubItems["Inactive"]:ChangeItemTheme({BackgroundColor3 = "Section Box"})
					SubItems["Inactive"]:Tween({BackgroundColor3 = Library.Theme["Section Box"]})

					if SubItems["Shade"] then
						SubItems["Shade"].Instance.Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
						}
					end
					SubItems["Hide2"]:Tween({BackgroundTransparency = 1})
					SubItems["Hide"].Instance.Visible = true

					MultiSection.Current = SubSection
					UpdateTabSizes()

					SubSection.Debounce = false
				end

				SubItems["Inactive"]:Connect("MouseButton1Down", function()
					SubSection:Turn()
				end)

				SubItems["Inactive"]:Connect("InputBegan", function(Input)
					BeginTabDrag(Input)
				end)

				table.insert(MultiSection.Sections, SubSection)
				UpdateTabSizes()

				if not MultiSection.Current then
					SubSection:Turn()
				end

				return setmetatable(SubSection, Library)
			end

			return setmetatable(MultiSection, Library)
		end

		Library.Toggle = function(Self, Params)
			Params = Params or { }

			local Toggle = {
				Name = Params.Name or Params.name or "Toggle",
				Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
				Default = Params.Default or Params.default or false,
				Callback = Params.Callback or Params.callback or function() end,
				Tooltip = Params.Tooltip or Params.tooltip,

				Window = Self.Window,
				Page = Self.Page,
				Section = Self,

				Value = false,
				Items = { },
				SettingsItem = nil,
			}

			local Parent

			if Params.Parent then
				Parent = Params.Parent
			else
				Parent = Toggle.Section.Items["Content"]
			end

			local Items = { } do
				Items["Toggle"] = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Parent.Instance,
					TextColor3 = Color3.fromRGB(0, 0, 0),
					Text = "",
					AutoButtonColor = false,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 18),
					BorderSizePixel = 0
				})

				Items["Indicator"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Toggle"].Instance,
					Position = UDim2.new(0, 2, 0, 4),
					Size = UDim2.new(0, 10, 0, 10),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Content"]
				}):AddToTheme({BackgroundColor3 = 'Content'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Indicator"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Indicator"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				Items["Inline"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Indicator"].Instance,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Accent"]
				}):AddToTheme({BackgroundColor3 = 'Accent'})

				Library:Create("UIGradient", {
					Name = "\0",
					Parent = Items["Inline"].Instance,
					Rotation = 90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(215, 215, 215)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 180, 180))
					}
				})

				Items["Text"] = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["Toggle"].Instance,
					TextColor3 = Library.Theme["Inactive Text"],
					Text = Toggle.Name,
					Size = UDim2.new(0, 0, 0, 16),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 20, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X
				}):AddToTheme({TextColor3 = 'Inactive Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Text"].Instance
				})

				Items["SubElements"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Toggle"].Instance,
					AnchorPoint = Vector2.new(1, 0),
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -1, 0, 0),
					Size = UDim2.new(0, 0, 1, 0),
					BorderSizePixel = 0
				})

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["SubElements"].Instance,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					Padding = UDim.new(0, 6),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				Items["Toggle"]:OnHover(function()
					Items["Indicator"]:Tween({BackgroundColor3 = Library.Theme["Hovered Element"]})
				end, function()
					Items["Indicator"]:Tween({BackgroundColor3 = Library.Theme["Content"]})
				end)

				Toggle.Items = Items
			end

			if Toggle.Tooltip then
				Library:TooltipMark(Items["Toggle"], Items["Text"], Toggle.Tooltip, Toggle.Name, 20)
			end

			function Toggle:Set(Bool)
				Toggle.Value = Bool

				if Bool then
					Items["Inline"]:Tween({BackgroundTransparency = 0, Size = UDim2.new(1, 0, 1, 0)})
					Items["Text"]:ChangeItemTheme({TextColor3 = "Text"})
					Items["Text"]:Tween({TextColor3 = Library.Theme.Text})
				else
					Items["Inline"]:Tween({BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0)})
					Items["Text"]:ChangeItemTheme({TextColor3 = "Inactive Text"})
					Items["Text"]:Tween({TextColor3 = Library.Theme["Inactive Text"]})
				end

				if Toggle.SettingsItem then
					Toggle.SettingsItem:SetOpen(Bool)
				end

				if Toggle.PopupItem then
					Toggle.PopupItem:SetOpen(Bool)
				end

				Flags[Toggle.Flag] = Bool

				task.defer(function()
					Library:SafeCall(Toggle.Callback, Bool)
				end)
			end

			function Toggle:SetVisibility(Bool)
				Items["Toggle"].Instance.Visible = Bool
			end

			function Toggle:SetText(Text)
				Items["Text"].Instance.Text = tostring(Text)
			end

			function Toggle:Colorpicker(Data)
				Data = Data or { }

				local Colorpicker = {
					Flag = Data.Flag or Data.flag or (Data.Name or Data.name or Toggle.Name),
					Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
					Callback = Data.Callback or Data.callback or function() end,
					Alpha = Data.Alpha or Data.alpha or 0,

					Window = Toggle.Window,
					Page = Toggle.Page,
					Section = Toggle.Section,
				}

				local NewColorpicker, ColorpickerItems = Library:CreateColorpicker({
					Parent = Items["SubElements"],
					Page = Colorpicker.Page,
					Section = Colorpicker.Section,
					Flag = Colorpicker.Flag,
					Default = Colorpicker.Default,
					Callback = Colorpicker.Callback,
					Alpha = Colorpicker.Alpha
				})

				return NewColorpicker
			end

			function Toggle:Keybind(Data)
				Data = Data or { }

				local Keybind = {
					Name = Data.Name or Data.name or Toggle.Name,
					Flag = Data.Flag or Data.flag or (Data.Name or Data.name or Toggle.Name),
					Default = Data.Default or Data.default or Enum.KeyCode.E,
					Callback = Data.Callback or Data.callback or function() end,
					Mode = Data.Mode or Data.mode or "Toggle",

					Window = Toggle.Window,
					Page = Toggle.Page,
					Section = Toggle.Section,
				}

				local NewKeybind, KeybindItems = Library:CreateKeybind({
					Parent = Items["SubElements"],
					Name = Keybind.Name,
					Page = Keybind.Page,
					Section = Keybind.Section,
					Toggle = Toggle,
					GateByToggle = Data.GateByToggle or Data.gateByToggle or false,
					Flag = Keybind.Flag,
					Default = Keybind.Default,
					Mode = Keybind.Mode,
					Callback = Keybind.Callback
				})

				return NewKeybind
			end

			function Toggle:Popup(Data)
				Data = Data or { }

				local Popup = {
					Window = Toggle.Window,
					Page = Toggle.Page,
					Toggle = Toggle,
					IsOpen = false,
					Items = { }
				}

				local RowHeight = Items["Toggle"].Instance.AbsoluteSize.Y

				if RowHeight < 18 then
					RowHeight = 18
				end

				Items["Toggle"].Instance.AutomaticSize = Enum.AutomaticSize.None
				Items["Toggle"].Instance.Size = UDim2.new(1, 0, 0, RowHeight)

				local PopupItems = { } do
					PopupItems["Clip"] = Library:Create("Frame", {
						Name = "\0",
						Parent = Items["Toggle"].Instance,
						Position = UDim2.new(0, 0, 0, 19),
						Size = UDim2.new(1, 0, 0, 0),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						ClipsDescendants = true
					})

					PopupItems["Content"] = Library:Create("Frame", {
						Name = "\0",
						Parent = PopupItems["Clip"].Instance,
						Size = UDim2.new(1, 0, 0, 0),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y
					})

					Library:Create("UIListLayout", {
						Name = "\0",
						Parent = PopupItems["Content"].Instance,
						Padding = UDim.new(0, 4),
						SortOrder = Enum.SortOrder.LayoutOrder
					})

					Popup.Items = PopupItems
				end

				function Popup:SetOpen(Bool, Instant)
					Popup.IsOpen = Bool and true or false

					local Target = Popup.IsOpen and PopupItems["Content"].Instance.AbsoluteSize.Y or 0
					local Row = Target > 0 and (19 + Target) or RowHeight

					if Instant then
						PopupItems["Clip"].Instance.Size = UDim2.new(1, 0, 0, Target)
						Items["Toggle"].Instance.Size = UDim2.new(1, 0, 0, Row)

						return
					end

					local Info = TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

					PopupItems["Clip"]:Tween({Size = UDim2.new(1, 0, 0, Target)}, Info)
					Items["Toggle"]:Tween({Size = UDim2.new(1, 0, 0, Row)}, Info)
				end

				Library:Connect(PopupItems["Content"].Instance:GetPropertyChangedSignal("AbsoluteSize"), function()
					if Popup.IsOpen then
						Popup:SetOpen(true)
					end
				end)

				Toggle.PopupItem = Popup

				Popup:SetOpen(Toggle.Value, true)

				return setmetatable(Popup, Library)
			end

			function Toggle:Settings()
				local Settings = {
					IsOpen = false,
					Items = { }
				}

				Items["Toggle"].Instance.AutomaticSize = Enum.AutomaticSize.Y

				local SettingsItems = { } do
					SettingsItems["Content"] = Library:Create("Frame", {
						Name = "\0",
						Parent = Items["Toggle"].Instance,
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 19, 0, 19),
						Size = UDim2.new(1, -19, 0, 0),
						Visible = false,
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y
					})

					Library:Create("UIListLayout", {
						Name = "\0",
						Parent = SettingsItems["Content"].Instance,
						Padding = UDim.new(0, 4),
						SortOrder = Enum.SortOrder.LayoutOrder
					})

					Library:Create("UIPadding", {
						Name = "\0",
						Parent = SettingsItems["Content"].Instance,
						PaddingBottom = UDim.new(0, 6)
					})

					SettingsItems["Connect"] = Library:Create("Frame", {
						Name = "\0",
						Parent = Items["Toggle"].Instance,
						Position = UDim2.new(0, 5, 0, 12),
						Size = UDim2.new(0, 2, 0, 0),
						BorderSizePixel = 0,
						BackgroundColor3 = Library.Theme["Outline 2"]
					}):AddToTheme({BackgroundColor3 = 'Outline 2'})

					Settings.Items = SettingsItems
				end

				function Settings:SetOpen(Bool)
					if Bool then
						SettingsItems["Content"].Instance.Visible = true
						SettingsItems["Connect"]:Tween({Size = UDim2.new(0, 2, 0, SettingsItems["Content"].Instance.AbsoluteSize.Y + 1)})
					else
						SettingsItems["Content"].Instance.Visible = false
						SettingsItems["Connect"]:Tween({Size = UDim2.new(0, 2, 0, 0)})
					end
				end

				Toggle.SettingsItem = Settings
				return setmetatable(Settings, Library)
			end

			Items["Toggle"]:Connect("MouseButton1Down", function()
				Toggle:Set(not Toggle.Value)
			end)

			Toggle:Set(Toggle.Default)

			SetFlags[Toggle.Flag] = function(Value)
				Toggle:Set(Value)
			end

			return setmetatable(Toggle, Library)
		end

		Library.RowGap = 4
		Library.TrackedRows = { }

		Library.LayoutRow = function(Self, Row)
			local Frame = Row

			if typeof(Row) == "table" then
				Frame = Row.Instance
			end

			if typeof(Frame) ~= "Instance" then
				return
			end

			local Layout = Frame:FindFirstChildOfClass("UIListLayout")

			if not Layout or Layout.FillDirection ~= Enum.FillDirection.Horizontal then
				return
			end

			local Cells = { }

			for _, Child in Frame:GetChildren() do
				if Child:IsA("GuiObject") then
					table.insert(Cells, Child)
				end
			end

			local Count = #Cells

			if Count == 0 then
				return
			end

			local Flexed = true

			for _, Child in Cells do
				if not Child:FindFirstChildOfClass("UIFlexItem") then
					local Ok = pcall(function()
						Library:Create("UIFlexItem", {
							Name = "\0",
							Parent = Child,
							FlexMode = Enum.UIFlexMode.Fill
						})
					end)

					if not Ok then
						Flexed = false
					end
				end
			end

			if Flexed then
				for _, Child in Cells do
					Child.Size = UDim2.new(0, 0, 0, 20)
				end

				return
			end

			local Width = Frame.AbsoluteSize.X

			if Width <= 0 then
				return
			end

			local Cell = math.max(math.floor((Width - Library.RowGap * (Count - 1)) / Count), 1)

			for _, Child in Cells do
				Child.Size = UDim2.new(0, Cell, 0, 20)
			end
		end

		Library.TrackRow = function(Self, Row)
			local Frame = Row

			if typeof(Row) == "table" then
				Frame = Row.Instance
			end

			if typeof(Frame) ~= "Instance" then
				return
			end

			if not Library.TrackedRows[Frame] then
				Library.TrackedRows[Frame] = true

				Library:Connect(Frame:GetPropertyChangedSignal("AbsoluteSize"), function()
					Library:LayoutRow(Frame)
				end)
			end

			Library:LayoutRow(Frame)
		end

		local ButtonPerRow = {
			["Large"] = 1,
			["Medium"] = 2,
			["Small"] = 3
		}

		local ButtonRows = { }

		local function GetButtonRow(ParentInstance, SizeName, PerRow, ForceNew)
			local Existing = ButtonRows[ParentInstance]

			if Existing and not ForceNew and Existing.SizeName == SizeName and Existing.Count < PerRow and Existing.Frame.Instance.Parent == ParentInstance then
				Existing.Count += 1
				return Existing.Frame
			end

			local Row = Library:Create("Frame", {
				Name = "\0",
				Parent = ParentInstance,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 20)
			})

			Library:Create("UIListLayout", {
				Name = "\0",
				Parent = Row.Instance,
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				Padding = UDim.new(0, 4),
				SortOrder = Enum.SortOrder.LayoutOrder
			})

			ButtonRows[ParentInstance] = {
				Frame = Row,
				SizeName = SizeName,
				Count = 1
			}

			return Row
		end

		Library.Button = function(Self, Params)
			Params = Params or { }

			local SizeName = tostring(Params.Size or Params.size or "Large")
			SizeName = SizeName:sub(1, 1):upper() .. SizeName:sub(2):lower()

			if not ButtonPerRow[SizeName] then
				SizeName = "Large"
			end

			local Button = {
				Name = Params.Name or Params.name or "Button",
				Callback = Params.Callback or Params.callback or function() end,
				Tooltip = Params.Tooltip or Params.tooltip,
				Size = SizeName,
				Confirm = Params.Confirm or Params.confirm or false,
				ConfirmTime = Params.ConfirmTime or Params.confirmtime or 5,
				ConfirmText = Params.ConfirmText or Params.confirmtext or "Confirm?",
				Window = Self.Window,
				Page = Self.Page,
				Section = Self,
				Items = { }
			}

			local Parent

			if Params.Parent then
				Parent = Params.Parent
			else
				Parent = Button.Section.Items["Content"]
			end

			local ParentInstance = Library:ResolveParent(Parent)
			local PerRow = ButtonPerRow[SizeName]
			local Holder = ParentInstance
			local ButtonSize = Params.RowWidth or UDim2.new(1, 0, 0, 20)

			local TrackedRow = nil

			if PerRow > 1 and not Params.RowWidth then
				local Row = GetButtonRow(ParentInstance, SizeName, PerRow, Params.NewRow or Params.newrow)
				Holder = Row.Instance
				TrackedRow = Row.Instance
				ButtonSize = UDim2.new(0, 40, 0, 20)
			elseif Params.RowWidth then
				Holder = ParentInstance
				TrackedRow = ParentInstance
			end

			local Items = { } do
				Items["Button"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Holder,
					Size = ButtonSize,
					Active = true,
					Selectable = true,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Inline"]
				}):AddToTheme({BackgroundColor3 = 'Inline'})

				if TrackedRow then
					Library:TrackRow(TrackedRow)
				end

				Items["RealButton"] = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["Button"].Instance,
					TextColor3 = Color3.fromRGB(0, 0, 0),
					Text = "",
					AutoButtonColor = false,
					Position = UDim2.new(0, 2, 0, 0),
					Size = UDim2.new(1, -4, 0, 20),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Element"]
				}):AddToTheme({BackgroundColor3 = 'Element'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["RealButton"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["RealButton"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIGradient", {
					Name = "\0",
					Parent = Items["RealButton"].Instance,
					Rotation = 90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(236, 236, 236)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(208, 208, 208))
					}
				})

				Items["Text"] = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["RealButton"].Instance,
					TextColor3 = Library.Theme["Text"],
					Text = Button.Name,
					AnchorPoint = Vector2.new(0.5, 0.5),
					Size = UDim2.new(0, 0, 0, 16),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X
				}):AddToTheme({TextColor3 = 'Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Text"].Instance
				})

				Items["RealButton"]:OnHover(function()
					Items["RealButton"]:Tween({BackgroundColor3 = Library.Theme["Hovered Element"]})
				end, function()
					Items["RealButton"]:Tween({BackgroundColor3 = Library.Theme["Element"]})
				end)

				Button.Items = Items
			end

			local Confirming = false
			local ConfirmToken = 0
			local PressToken = 0

			local function EndConfirm()
				Confirming = false
				ConfirmToken += 1

				Items["Text"]:ChangeItemTheme({TextColor3 = "Text"})
				Items["Text"].Instance.Text = Button.Name
				Items["Text"]:Tween({TextColor3 = Library.Theme["Text"]})
			end

			function Button:StartConfirm()
				Confirming = true
				ConfirmToken += 1

				local Token = ConfirmToken
				local Duration = tonumber(Button.ConfirmTime) or 5

				Items["Text"]:ChangeItemTheme({TextColor3 = "Accent"})
				Items["Text"].Instance.TextColor3 = Library.Theme["Accent"]
				Items["Text"].Instance.Text = string.format("%s (%.1fs)", Button.ConfirmText, Duration)

				Library:Thread(function()
					local Finish = os.clock() + Duration

					while Token == ConfirmToken do
						local Remaining = Finish - os.clock()

						if Remaining <= 0 then
							break
						end

						Items["Text"].Instance.Text = string.format("%s (%.1fs)", Button.ConfirmText, Remaining)
						task.wait(0.1)
					end

					if Token == ConfirmToken then
						EndConfirm()
					end
				end)
			end

			function Button:CancelConfirm()
				if Confirming then
					EndConfirm()
				end
			end

			function Button:Press()
				if Button.Confirm and not Confirming then
					Button:StartConfirm()
					return
				end

				if Confirming then
					EndConfirm()
				end

				PressToken += 1

				local Token = PressToken

				Items["Text"]:ChangeItemTheme({TextColor3 = "Accent"})
				Items["Text"].Instance.TextColor3 = Library.Theme["Accent"]

				Library:Thread(function()
					task.wait(0.12)

					if Token ~= PressToken or Confirming then
						return
					end

					Items["Text"]:ChangeItemTheme({TextColor3 = "Text"})
					Items["Text"]:Tween({TextColor3 = Library.Theme["Text"]})
				end)

				Library:SafeCall(Button.Callback)
			end

			function Button:SetVisibility(Bool)
				Items["Button"].Instance.Visible = Bool
			end

			function Button:SetText(Text)
				Button.Name = tostring(Text)

				if not Confirming then
					Items["Text"].Instance.Text = Button.Name
				end
			end

			Items["RealButton"]:Connect("MouseButton1Down", function()
				Button:Press()
			end)

			return setmetatable(Button, Library)
		end

		Library.ButtonRow = function(Self, Params)
			Params = Params or { }

			local Definitions = Params.Buttons or Params.buttons or Params
			local Count = #Definitions

			if Count == 0 then
				return { }
			end

			local Parent = Params.Parent or Self.Items["Content"]
			local ParentInstance = Library:ResolveParent(Parent)

			local Row = Library:Create("Frame", {
				Name = "\0",
				Parent = ParentInstance,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 20)
			})

			Library:Create("UIListLayout", {
				Name = "\0",
				Parent = Row.Instance,
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				Padding = UDim.new(0, 4),
				SortOrder = Enum.SortOrder.LayoutOrder
			})

			local Width = UDim2.new(0, 40, 0, 20)
			local Created = { }

			for Index, Definition in Definitions do
				Definition = table.clone(Definition)
				Definition.Parent = Row
				Definition.RowWidth = Width

				Created[Index] = Library.Button(Self, Definition)
			end

			Library:TrackRow(Row.Instance)

			return Created
		end

		Library.Slider = function(Self, Params)
			Params = Params or { }

			local Slider = {
				Name = Params.Name or Params.name or "Slider",
				Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
				Default = Params.Default or Params.default or 0,
				Min = Params.Min or Params.min or 0,
				Max = Params.Max or Params.max or 100,
				Callback = Params.Callback or Params.callback or function() end,
				Decimals = Params.Decimals or Params.decimals or 0,
				Suffix = Params.Suffix or Params.suffix or "",
				Tooltip = Params.Tooltip or Params.tooltip,

				Strings = Params.String or Params.string or Params.Strings,
				IsRange = (Params.Range or Params.range) ~= nil,

				Window = Self.Window,
				Page = Self.Page,
				Section = Self,

				Value = 0,
				Sliding = false,
				Items = { }
			}

			if Slider.Strings then
				Slider.Min = 1
				Slider.Max = math.max(#Slider.Strings, 1)
				Slider.Decimals = 0
				Slider.Default = Params.Default or Params.default or 1
			end

			if Slider.IsRange then
				local Bounds = Params.Range or Params.range

				Slider.Low = Bounds[1] or Bounds.Low or Bounds.Min or Slider.Min
				Slider.High = Bounds[2] or Bounds.High or Bounds.Max or Slider.Max
			end

			local Parent

			if Params.Parent then
				Parent = Params.Parent
			else
				Parent = Slider.Section.Items["Content"]
			end

			local Items = { } do
				Items["Slider"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Parent.Instance,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 30),
					BorderSizePixel = 0
				})

				Items["SliderShadow"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Slider"].Instance,
					Position = UDim2.new(0, 1, 0, 21),
					Size = UDim2.new(1, 0, 0, 10),
					BorderSizePixel = 0,
					ZIndex = 0,
					BackgroundTransparency = 0.6,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				})

				Items["RealSlider"] = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["Slider"].Instance,
					TextColor3 = Color3.fromRGB(0, 0, 0),
					Text = "",
					AutoButtonColor = false,
					Position = UDim2.new(0, 0, 0, 20),
					Size = UDim2.new(1, 0, 0, 10),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					ZIndex = 1,
					BackgroundColor3 = Library.Theme["Slider Track"]
				}):AddToTheme({BackgroundColor3 = 'Slider Track'})

				Library:Create("UIGradient", {
					Name = "\0",
					Parent = Items["RealSlider"].Instance,
					Rotation = 90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(205, 205, 205))
					}
				})

				Items["Accent"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["RealSlider"].Instance,
					AnchorPoint = Vector2.new(0, 0),
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(0.5, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Accent"]
				}):AddToTheme({BackgroundColor3 = 'Accent'})

				Items["AccentGradient"] = Library:Create("UIGradient", {
					Name = "\0",
					Parent = Items["Accent"].Instance,
					Rotation = 0,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(0.4400, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(0.4600, Color3.fromRGB(250, 250, 250)),
						ColorSequenceKeypoint.new(0.4750, Color3.fromRGB(241, 241, 241)),
						ColorSequenceKeypoint.new(0.4875, Color3.fromRGB(230, 230, 230)),
						ColorSequenceKeypoint.new(0.5000, Color3.fromRGB(217, 217, 217)),
						ColorSequenceKeypoint.new(0.5125, Color3.fromRGB(204, 204, 204)),
						ColorSequenceKeypoint.new(0.5250, Color3.fromRGB(193, 193, 193)),
						ColorSequenceKeypoint.new(0.5400, Color3.fromRGB(184, 184, 184)),
						ColorSequenceKeypoint.new(0.5600, Color3.fromRGB(179, 179, 179)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(178, 178, 178))
					}
				})

				Items["Value"] = Library:Create("TextBox", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["Slider"].Instance,
					TextColor3 = Library.Theme["Text"],
					Text = "1871ft",
					PlaceholderText = "",
					ClearTextOnFocus = false,
					TextEditable = true,
					AnchorPoint = Vector2.new(1, 0),
					Size = UDim2.new(0, 0, 0, 16),
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -2, 0, 0),
					BorderSizePixel = 0,
					TextXAlignment = Enum.TextXAlignment.Right,
					AutomaticSize = Enum.AutomaticSize.X
				}):AddToTheme({TextColor3 = 'Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Value"].Instance
				})

				Items["Text"] = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["Slider"].Instance,
					TextColor3 = Library.Theme["Text"],
					Text = Slider.Name,
					Size = UDim2.new(0, 0, 0, 16),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 1, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X
				}):AddToTheme({TextColor3 = 'Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Text"].Instance
				})

				Items["RealSlider"]:OnHover(function()
					local HoverColor = Library.Theme["Slider Track"]:Lerp(Color3.fromRGB(255, 255, 255), 0.05)
					Items["RealSlider"]:Tween({BackgroundColor3 = HoverColor})
				end, function()
					Items["RealSlider"]:Tween({BackgroundColor3 = Library.Theme["Slider Track"]})
				end)

				Slider.Items = Items
			end

			local SeamWidth = 16

			local LastSeam = nil

			local UpdateSeam = function(Fraction)
				local Gradient = Items["AccentGradient"]

				if not Gradient then
					return
				end

				local BarWidth = Items["RealSlider"].Instance.AbsoluteSize.X
				local FillWidth = math.max(BarWidth * math.clamp(Fraction, 0, 1), 1)
				local Rounded = math.floor(FillWidth)

				if Rounded == LastSeam then
					return
				end

				LastSeam = Rounded

				local Half = math.clamp((SeamWidth * 0.5) / FillWidth, 0.02, 0.49)

				Gradient.Instance.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(math.max(0.5 - Half, 0.01), Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(0.5 - Half * 0.80, Color3.fromRGB(251, 251, 251)),
					ColorSequenceKeypoint.new(0.5 - Half * 0.60, Color3.fromRGB(245, 245, 245)),
					ColorSequenceKeypoint.new(0.5 - Half * 0.40, Color3.fromRGB(236, 236, 236)),
					ColorSequenceKeypoint.new(0.5 - Half * 0.20, Color3.fromRGB(227, 227, 227)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(217, 217, 217)),
					ColorSequenceKeypoint.new(0.5 + Half * 0.20, Color3.fromRGB(207, 207, 207)),
					ColorSequenceKeypoint.new(0.5 + Half * 0.40, Color3.fromRGB(198, 198, 198)),
					ColorSequenceKeypoint.new(0.5 + Half * 0.60, Color3.fromRGB(190, 190, 190)),
					ColorSequenceKeypoint.new(0.5 + Half * 0.80, Color3.fromRGB(183, 183, 183)),
					ColorSequenceKeypoint.new(math.min(0.5 + Half, 0.99), Color3.fromRGB(178, 178, 178)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(178, 178, 178))
				}
			end

			if Slider.IsRange then
				function Slider:SetRange(Low, High)
					Low = Library:Round(math.clamp(Low, Slider.Min, Slider.Max), Slider.Decimals)
					High = Library:Round(math.clamp(High, Slider.Min, Slider.Max), Slider.Decimals)

					if Low > High then
						Low, High = High, Low
					end

					Slider.Low = Low
					Slider.High = High
					Slider.Value = High

					local Span = Slider.Max - Slider.Min

					if Span == 0 then
						Span = 1
					end

					local LowFraction = (Low - Slider.Min) / Span
					local HighFraction = (High - Slider.Min) / Span
					local Info = TweenInfo.new(Library.Animation.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

					Items["Accent"]:Tween({
						Position = UDim2.new(LowFraction, 0, 0, 0),
						Size = UDim2.new(HighFraction - LowFraction, 0, 1, 0)
					}, Info)

					Items["Value"].Instance.Text = string.format("%s - %s", tostring(Low), tostring(High)) .. Slider.Suffix

					Flags[Slider.Flag] = {Low = Low, High = High}
					Library:SafeCall(Slider.Callback, Low, High)
				end
			end

			function Slider:Set(Value)
				if Slider.IsRange then
					local Target = math.clamp(Value, Slider.Min, Slider.Max)

					if math.abs(Target - Slider.Low) <= math.abs(Target - Slider.High) then
						Slider:SetRange(Target, Slider.High)
					else
						Slider:SetRange(Slider.Low, Target)
					end

					return
				end

				Slider.Value = Library:Round(math.clamp(Value, Slider.Min, Slider.Max), Slider.Decimals)

				local Fraction = (Slider.Value - Slider.Min) / (Slider.Max - Slider.Min)

				Items["Accent"]:Tween({Size = UDim2.new(Fraction, 0, 1, 0)}, TweenInfo.new(Library.Animation.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))

				UpdateSeam(Fraction)
				local ValueText = type(Slider.Value) == "number" and (math.floor(Slider.Value) == Slider.Value and tostring(math.floor(Slider.Value)) or tostring(Slider.Value)) or tostring(Slider.Value)

				if Slider.Strings then
					ValueText = tostring(Slider.Strings[math.clamp(math.floor(Slider.Value + 0.5), 1, #Slider.Strings)])
				end

				Items["Value"].Instance.Text = ValueText .. Slider.Suffix

				Flags[Slider.Flag] = Slider.Value
				Library:SafeCall(Slider.Callback, Slider.Value)
			end

			function Slider:SetVisibility(Bool)
				Items["Slider"].Instance.Visible = Bool
			end

			function Slider:GetSize(Input)
				local SizeX = math.clamp((Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X, 0, 1)
				local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min

				return Value
			end

			function Slider:SetText(Text)
				Items["Text"].Instance.Text = tostring(Text)
			end

			local InputChanged

			Items["RealSlider"]:Connect("InputBegan", function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Slider.Sliding = true

					local Value = Slider:GetSize(Input)

					Slider:Set(Value)

					if InputChanged then
						return
					end

					InputChanged = Input.Changed:Connect(function()
						if Input.UserInputState == Enum.UserInputState.End then
							Slider.Sliding = false

							InputChanged:Disconnect()
							InputChanged = nil
						end
					end)
				end
			end)

			Library:Connect(UserInputService.InputChanged, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
					if Slider.Sliding then
						local Value = Slider:GetSize(Input)

						Slider:Set(Value)
					end
				end
			end)

			if Slider.IsRange then
				Slider:SetRange(Slider.Low, Slider.High)
			else
				Slider:Set(Slider.Default)
			end

			do
				local ValueBox = Items["Value"].Instance

				ValueBox.Focused:Connect(function()
					ValueBox.Text = tostring(Slider.Value)

					Items["Value"]:ChangeItemTheme({TextColor3 = "Accent"})
					Items["Value"]:Tween({TextColor3 = Library.Theme["Accent"]})
				end)

				ValueBox.FocusLost:Connect(function()
					local Cleaned = string.gsub(tostring(ValueBox.Text), "[^%\-%d%.]", "")
					local Typed = tonumber(Cleaned)

					Items["Value"]:ChangeItemTheme({TextColor3 = "Text"})
					Items["Value"]:Tween({TextColor3 = Library.Theme["Text"]})

					Slider:Set(Typed or Slider.Value)
				end)
			end

			SetFlags[Slider.Flag] = function(Value)
				Slider:Set(Value)
			end

			return setmetatable(Slider, Library)
		end

		Library.Dropdown = function(Self, Params)
			Params = Params or { }

			local Dropdown = {
				Name = Params.Name or Params.name or "Dropdown",
				OptionItems = Params.Items or Params.items or { },
				Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
				Default = Params.Default or Params.default or "",
				Callback = Params.Callback or Params.callback or function() end,
				Multi = Params.Multi or Params.multi or false,
				Tooltip = Params.Tooltip or Params.tooltip,

				Window = Self.Window,
				Page = Self.Page,
				Section = Self,

				Value = { },
				Options = { },
				IsOpen = false,
				Items = { }
			}

			local Parent

			if Params.Parent then
				Parent = Params.Parent
			else
				Parent = Dropdown.Section.Items["Content"]
			end

			local Items = { } do
				Items["Dropdown"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Parent.Instance,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 42),
					BorderSizePixel = 0
				})

				Items["Text"] = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["Dropdown"].Instance,
					TextColor3 = Library.Theme["Text"],
					Text = Dropdown.Name,
					Size = UDim2.new(0, 0, 0, 18),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 1, 0, -1),
					BorderSizePixel = 0,
					TextYAlignment = Enum.TextYAlignment.Top,
					AutomaticSize = Enum.AutomaticSize.X
				}):AddToTheme({TextColor3 = 'Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Text"].Instance
				})

				Items["RealDropdown"] = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["Dropdown"].Instance,
					TextColor3 = Color3.fromRGB(0, 0, 0),
					Text = "",
					AutoButtonColor = false,
					AnchorPoint = Vector2.new(0, 1),
					Position = UDim2.new(0, 2, 1, -2),
					Size = UDim2.new(1, -4, 0, 20),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					BackgroundColor3 = Library.Theme["Element"]
				}):AddToTheme({BackgroundColor3 = 'Element'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["RealDropdown"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["RealDropdown"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				Library:Create("UIGradient", {
					Name = "\0",
					Parent = Items["RealDropdown"].Instance,
					Rotation = 90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(236, 236, 236)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(208, 208, 208))
					}
				})

				Items["Value"] = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["RealDropdown"].Instance,
					TextColor3 = Library.Theme["Inactive Text"],
					Text = ".....",
					AnchorPoint = Vector2.new(0, 0.5),
					Size = UDim2.new(1, -24, 0, 16),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 6, 0.5, 0),
					BorderSizePixel = 0,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextTruncate = Enum.TextTruncate.AtEnd,
					AutomaticSize = Enum.AutomaticSize.None
				}):AddToTheme({TextColor3 = 'Inactive Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Value"].Instance
				})

				Items["Arrow"] = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = 8,
					Parent = Items["RealDropdown"].Instance,
					RichText = true,
					TextColor3 = Library.Theme["Text"],
					Text = "▼",
					AnchorPoint = Vector2.new(1, 0.5),
					Size = UDim2.new(0, 0, 0, 14),
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -7, 0.5, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X
				}):AddToTheme({TextColor3 = 'Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Arrow"].Instance
				})

				Items["OptionHolder"] = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Library.UnusedHolder.Instance,
					Visible = false,
					TextColor3 = Color3.fromRGB(0, 0, 0),
					Text = "",
					AutoButtonColor = false,
					Size = UDim2.new(0, 246, 0, 0),
					Position = UDim2.new(0, 979, 0, 167),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Library.Theme["Background"]
				}):AddToTheme({BackgroundColor3 = 'Background'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["OptionHolder"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["OptionHolder"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["OptionHolder"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 4"],
					BorderOffset = UDim.new(0, 2)
				}):AddToTheme({Color = 'Outline 4'})

				Library:Create("UIGradient", {
					Name = "\0",
					Parent = Items["OptionHolder"].Instance,
					Rotation = 90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(238, 238, 238)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(206, 206, 206))
					}
				})

				Library:Create("UIPadding", {
					Name = "\0",
					Parent = Items["OptionHolder"].Instance,
					PaddingTop = UDim.new(0, 3),
					PaddingBottom = UDim.new(0, 6),
					PaddingRight = UDim.new(0, 6),
					PaddingLeft = UDim.new(0, 6)
				})

				Items["SearchBackground"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Library.Holder.Instance,
					Visible = false,
					ClipsDescendants = true,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(0, 120, 0, 20),
					ZIndex = Library.ZIndexOrder.OptionHolder + 3,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Element"]
				}):AddToTheme({BackgroundColor3 = 'Element'})

				Library:Create("UIGradient", {
					Name = "\0",
					Parent = Items["SearchBackground"].Instance,
					Rotation = 90,
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(184, 184, 184))
					})
				})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["SearchBackground"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["SearchBackground"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				Items["SearchBox"] = Library:Create("TextBox", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["SearchBackground"].Instance,
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 6, 0.5, 0),
					Size = UDim2.new(1, -12, 0, 16),
					ZIndex = Library.ZIndexOrder.OptionHolder + 5,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ClearTextOnFocus = false,
					Text = "",
					PlaceholderText = "Search",
					TextXAlignment = Enum.TextXAlignment.Left,
					PlaceholderColor3 = Library.Theme["Inactive Text"],
					TextColor3 = Library.Theme["Text"]
				}):AddToTheme({TextColor3 = 'Text', PlaceholderColor3 = 'Inactive Text'})

				Items["OptionScroll"] = Library:Create("ScrollingFrame", {
					Name = "\0",
					Parent = Items["OptionHolder"].Instance,
					Active = true,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(1, 6, 0, 16),
					CanvasSize = UDim2.new(0, 0, 0, 16),
					ScrollingDirection = Enum.ScrollingDirection.Y,
					ScrollBarThickness = 3,
					ScrollBarImageColor3 = Library.Theme["Accent"],
					ZIndex = 2
				}):AddToTheme({ScrollBarImageColor3 = 'Accent'})

				Library:Scrollbar(Items["OptionScroll"], {ZIndex = 9, Top = 0, Right = -3})

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["OptionScroll"].Instance,
					Padding = UDim.new(0, 5),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				Items["RealDropdown"]:OnHover(function()
					Items["RealDropdown"]:Tween({BackgroundColor3 = Library.Theme["Hovered Element"]})
				end, function()
					Items["RealDropdown"]:Tween({BackgroundColor3 = Library.Theme["Element"]})
				end)

				Dropdown.Items = Items
			end

			function Dropdown:Place(Offset, UseTween)
				local Box = Items["RealDropdown"].Instance
				local Search = Items["SearchBackground"]
				local Left = Box.AbsolutePosition.X
				local Width = Box.AbsoluteSize.X
				local Top = Box.AbsolutePosition.Y + Box.AbsoluteSize.Y + GuiInset + (Offset or 0)
				local SearchVisible = Search.Instance.Visible

				Search.Instance.Size = UDim2.new(0, Width, 0, 20)

				local SearchPosition = UDim2.new(0, Left, 0, Top + 4)

				if SearchVisible then
					Top = Top + 24
				end

				local HolderPosition = UDim2.new(0, Left, 0, Top + (SearchVisible and 4 or 2))

				if UseTween then
					Search:Tween({Position = SearchPosition})
					Items["OptionHolder"]:Tween({Position = HolderPosition})
				else
					Search.Instance.Position = SearchPosition
					Items["OptionHolder"].Instance.Position = HolderPosition
				end
			end

			local function ResizeOptions()
				local Count = 0
				local Total = 0

				for _, Child in Items["OptionScroll"].Instance:GetChildren() do
					if Child:IsA("GuiObject") then
						Total = Total + 1

						if Child.Visible then
							Count = Count + 1
						end
					end
				end

				local Height = math.max(Count * 16 + math.max(Count - 1, 0) * 5, 16)

				Dropdown.ShowSearch = Total > (Library.SearchThreshold or 10)
				Items["SearchBackground"].Instance.Visible = Dropdown.ShowSearch and Dropdown.IsOpen and true or false

				Items["OptionScroll"].Instance.CanvasSize = UDim2.new(0, 0, 0, Height)
				Items["OptionScroll"].Instance.Position = UDim2.new(0, 0, 0, 0)
				Items["OptionScroll"].Instance.Size = UDim2.new(1, 6, 0, math.min(Height, 156))

				if Dropdown.IsOpen then
					Dropdown:Place(0)
				end
			end

			function Dropdown:Filter(Query)
				Query = string.lower(tostring(Query or ""))

				for Name, OptionData in Dropdown.Options do
					if OptionData.Button then
						OptionData.Button.Instance.Visible = Query == "" or string.find(string.lower(tostring(Name)), Query, 1, true) ~= nil
					end
				end

				ResizeOptions()
			end

			function Dropdown:SetSearchOpen(Bool)
				Items["SearchBox"].Instance.Text = ""

				Dropdown:Filter("")

				if Bool and Items["SearchBackground"].Instance.Visible then
					task.defer(function()
						pcall(function()
							Items["SearchBox"].Instance:CaptureFocus()
						end)
					end)
				end
			end

			Items["SearchBox"]:Connect("Changed", function(Property)
				if Property ~= "Text" then
					return
				end

				Dropdown:Filter(Items["SearchBox"].Instance.Text)
			end)

			function Dropdown:Set(Value)
				if Dropdown.Multi then
					if type(Value) ~= "table" then
						return
					end

					Dropdown.Value = Value

					for Index, Value in Value do
						local OptionData = Dropdown.Options[Value]

						if OptionData then
							OptionData.IsSelected = true
							OptionData:ToggleState("Active")
						end
					end

					Flags[Dropdown.Flag] = Value
					Items["Value"].Instance.Text = table.concat(Value, ", ")
				else
					if not Dropdown.Options[Value] then
						return
					end

					local OptionData = Dropdown.Options[Value]

					Dropdown.Value = Value

					for Index, Value in Dropdown.Options do
						if Value ~= OptionData then
							Value.IsSelected = false
							Value:ToggleState("Inactive")
						else
							Value.IsSelected = true
							Value:ToggleState("Active")
						end
					end

					Flags[Dropdown.Flag] = Value
					Items["Value"].Instance.Text = Value
				end

				Library:SafeCall(Dropdown.Callback, Dropdown.Value)
			end

			function Dropdown:Add(Value)
				local OptionButton = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["OptionScroll"].Instance,
					TextColor3 = Library.Theme["Inactive Text"],
					Text = Value,
					AutoButtonColor = false,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 16),
					TextXAlignment = Enum.TextXAlignment.Left,
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.None
				}):AddToTheme({TextColor3 = 'Inactive Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = OptionButton.Instance
				})

				local OptionNudge = Library:Create("UIPadding", {
					Name = "\0",
					Parent = OptionButton.Instance,
					PaddingLeft = UDim.new(0, 0)
				})

				ResizeOptions()

				local OptionData = {
					Button = OptionButton,
					Text = OptionButton,
					Name = Value,
					IsSelected = false
				}

				OptionButton:OnHover(function()
					OptionNudge:Tween({PaddingLeft = UDim.new(0, 5)}, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))

					if OptionData.IsSelected then return end
					OptionButton:Tween({TextColor3 = Library.Theme.Text})
				end, function()
					OptionNudge:Tween({PaddingLeft = UDim.new(0, 0)}, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))

					if OptionData.IsSelected then return end
					OptionButton:Tween({TextColor3 = Library.Theme["Inactive Text"]})
				end)

				function OptionData:ToggleState(Value)
					if Value == "Active" then
						OptionData.Text:ChangeItemTheme({TextColor3 = "Accent"})
						OptionData.Text:Tween({TextColor3 = Library.Theme.Accent})

						OptionButton.Instance.BackgroundTransparency = 1
					else
						OptionData.Text:ChangeItemTheme({TextColor3 = "Inactive Text"})
						OptionData.Text:Tween({TextColor3 = Library.Theme["Inactive Text"]})

						OptionButton.Instance.BackgroundTransparency = 1
					end
				end

				function OptionData:Set()
					OptionData.IsSelected = not OptionData.IsSelected

					if Dropdown.Multi then
						local Index = table.find(Dropdown.Value, OptionData.Name)

						if Index then
							table.remove(Dropdown.Value, Index)
						else
							table.insert(Dropdown.Value, OptionData.Name)
						end

						OptionData:ToggleState(Index and "Inactive" or "Active")

						Flags[Dropdown.Flag] = Dropdown.Value

						local TextFormat = #Dropdown.Value > 0 and table.concat(Dropdown.Value, ", ") or "....."
						Items["Value"].Instance.Text = TextFormat
					else
						if OptionData.IsSelected then
							Dropdown.Value = OptionData.Name
							Flags[Dropdown.Flag] = OptionData.Name

							OptionData.IsSelected = true
							OptionData:ToggleState("Active")

							for Index, Value in Dropdown.Options do
								if Value ~= OptionData then
									Value.IsSelected = false
									Value:ToggleState("Inactive")
								end
							end

							Items["Value"].Instance.Text = OptionData.Name
						else
							Dropdown.Value = nil
							Flags[Dropdown.Flag] = nil

							OptionData.IsSelected = false
							OptionData:ToggleState("Inactive")

							Items["Value"].Instance.Text = "....."
						end
					end

					Library:SafeCall(Dropdown.Callback, Dropdown.Value)
				end

				OptionData.Button:Connect("MouseButton1Down", function()
					OptionData:Set()

					if not Dropdown.Multi then
						task.delay(0.1, function()
							Dropdown:SetOpen(false)
						end)
					end
				end)

				Dropdown.Options[OptionData.Name] = OptionData
				return OptionData
			end

			function Dropdown:Remove(Option)
				if Dropdown.Options[Option] then
					Dropdown.Options[Option].Button.Instance:Destroy()
					Dropdown.Options[Option] = nil
				end
			end

			function Dropdown:Refresh(List)
				for Index, Value in Dropdown.Options do
					Dropdown:Remove(Value.Name)
				end

				for Index, Value in List do
					Dropdown:Add(Value)
				end
			end

			function Dropdown:SetText(Text)
				Items["Text"].Instance.Text = tostring(Text)
			end

			function Dropdown:SetVisibility(Bool)
				Items["Dropdown"].Instance.Visible = Bool
			end

			local Debounce = false
			local OptionHolder = Items["OptionHolder"].Instance
			local RealDropdown = Items["RealDropdown"].Instance

			local IsSettings = Dropdown.Section and Dropdown.Section.IsSettings

			function Dropdown:SetOpen(Bool)
				if Debounce then
					return
				end

				Dropdown.IsOpen = Bool

				Debounce = true

				if Dropdown.IsOpen then
					OptionHolder.Size = UDim2.new(0, RealDropdown.AbsoluteSize.X, 0, 0)
					OptionHolder.Parent = Library.Holder.Instance

					Items["SearchBackground"].Instance.Visible = Dropdown.ShowSearch and true or false

					ResizeOptions()

					Dropdown:Place(-10)
					Dropdown:Place(0, true)

					Items["OptionHolder"]:FadeDescendants(true, function()
						Debounce = false
					end)

					Items["Arrow"]:Tween({Rotation = 180})

					for Index, Value in Library.OpenFrames do
						if Value ~= IsSettings and not Params.Parent then
							Value:SetOpen(false)
						end
					end

					Library.OpenFrames[Dropdown] = Dropdown
				else
					if Items["SearchBackground"] and Items["SearchBackground"].Instance.Visible then
						Dropdown:SetSearchOpen(false)
					end

					Items["SearchBackground"].Instance.Visible = false

					Dropdown:Place(-10, true)
					Items["OptionHolder"]:FadeDescendants(false, function()
						OptionHolder.Parent = Library.UnusedHolder.Instance
						Debounce = false
					end)

					Items["Arrow"]:Tween({Rotation = 0})

					if Library.OpenFrames[Dropdown] then
						Library.OpenFrames[Dropdown] = nil
					end
				end

				local Descendants = OptionHolder:GetDescendants()
				table.insert(Descendants, OptionHolder)

				for Index, Value in Descendants do
					if not Value.ClassName:find("UI") then
						if not Params.Parent then
							Value.ZIndex = Dropdown.IsOpen and Library.ZIndexOrder.OptionHolder or 1
						else
							Value.ZIndex = Dropdown.IsOpen and Library.ZIndexOrder.OptionHolder + 3 or 1
						end
					end
				end
			end

			Items["RealDropdown"]:Connect("MouseButton1Down", function()
				Dropdown:SetOpen(not Dropdown.IsOpen)
			end)

			Library:Connect(UserInputService.InputBegan, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 then
					if not Dropdown.IsOpen then
						return
					end

					if Items["OptionHolder"]:IsMouseOverFrame() then
						return
					end

					if Items["SearchBackground"].Instance.Visible and Items["SearchBackground"]:IsMouseOverFrame() then
						return
					end

					Dropdown:SetOpen(false)
				end
			end)

			for Index, Value in Dropdown.OptionItems do
				Dropdown:Add(Value)
			end

			Dropdown:Set(Dropdown.Default)

			SetFlags[Dropdown.Flag] = function(Value)
				Dropdown:Set(Value)
			end

			return setmetatable(Dropdown, Library)
		end

		Library.Label = function(Self, Params)
			Params = Params or { }

			local Label = {
				Name = Params.Name or Params.name or "Label",
				Tooltip = Params.Tooltip or Params.tooltip,

				Window = Self.Window,
				Page = Self.Page,
				Section = Self,

				Items = { }
			}

			local Parent

			if Params.Parent then
				Parent = Params.Parent
			else
				Parent = Label.Section.Items["Content"]
			end

			local Items = { } do
				Items["Label"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Parent.Instance,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					AutomaticSize = Enum.AutomaticSize.Y,
					BorderSizePixel = 0
				})

				Items["Text"] = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["Label"].Instance,
					TextColor3 = Library.Theme["Text"],
					Text = Label.Name,
					Size = UDim2.new(1, -2, 0, 0),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 1, 0, 0),
					BorderSizePixel = 0,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
					AutomaticSize = Enum.AutomaticSize.Y
				}):AddToTheme({TextColor3 = 'Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Text"].Instance
				})

				Items["SubElements"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Label"].Instance,
					AnchorPoint = Vector2.new(1, 0),
					BackgroundTransparency = 1,
					Position = UDim2.new(1, 0, 0, 0),
					Size = UDim2.new(0, 0, 1, 0),
					BorderSizePixel = 0
				})

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["SubElements"].Instance,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					Padding = UDim.new(0, 6),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				Label.Items = Items
			end

			function Label:SetVisibility(Bool)
				Items["Label"].Instance.Visible = Bool
			end

			function Label:SetText(Text)
				Items["Text"].Instance.Text = tostring(Text)
			end

			function Label:Colorpicker(Data)
				Data = Data or { }

				local Colorpicker = {
					Flag = Data.Flag or Data.flag or (Data.Name or Data.name or Label.Name),
					Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
					Callback = Data.Callback or Data.callback or function() end,
					Alpha = Data.Alpha or Data.alpha or 0,

					Window = Label.Window,
					Page = Label.Page,
					Section = Label.Section,
				}

				local NewColorpicker, ColorpickerItems = Library:CreateColorpicker({
					Parent = Items["SubElements"],
					Page = Colorpicker.Page,
					Section = Colorpicker.Section,
					Flag = Colorpicker.Flag,
					Default = Colorpicker.Default,
					Callback = Colorpicker.Callback,
					Alpha = Colorpicker.Alpha
				})

				return NewColorpicker
			end

			function Label:Keybind(Data)
				Data = Data or { }

				local Keybind = {
					Name = Data.Name or Data.name or Label.Name,
					Flag = Data.Flag or Data.flag or (Data.Name or Data.name or Label.Name),
					Default = Data.Default or Data.default or Enum.KeyCode.E,
					Callback = Data.Callback or Data.callback or function() end,
					Mode = Data.Mode or Data.mode or "Toggle",

					Window = Label.Window,
					Page = Label.Page,
					Section = Label.Section,
				}

				local NewKeybind, KeybindItems = Library:CreateKeybind({
					Parent = Items["SubElements"],
					Name = Keybind.Name,
					Page = Keybind.Page,
					Section = Keybind.Section,
					Flag = Keybind.Flag,
					Default = Keybind.Default,
					Mode = Keybind.Mode,
					Callback = Keybind.Callback
				})

				return NewKeybind
			end

			Label:SetText(Label.Name)

			return setmetatable(Label, Library)
		end

		Library.Textbox = function(Self, Params)
			Params = Params or { }

			local Textbox = {
				Name = Params.Name or Params.name or "Textbox",
				Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
				Default = Params.Default or Params.default or "",
				Callback = Params.Callback or Params.callback or function() end,
				Finished = Params.Finished or Params.finished or false,
				Placeholder = Params.Placeholder or Params.placeholder or "",
				Numeric = Params.Numeric or Params.numeric or false,
				Tooltip = Params.Tooltip or Params.tooltip,

				Window = Self.Window,
				Page = Self.Page,
				Section = Self,
				Value = "",

				Items = { },
			}

			local Parent

			if Params.Parent then
				Parent = Params.Parent
			else
				Parent = Textbox.Section.Items["Content"]
			end

			local Items = { } do
				Items["Textbox"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Parent.Instance,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 24),
					BorderSizePixel = 0
				})

				if Textbox.Name and Textbox.Name ~= "" then
					Items["Text"] = Library:Create("TextLabel", {
						Name = "\0",
						FontFace = Library.Font,
						TextSize = Library.FontSize,
						Parent = Items["Textbox"].Instance,
						TextColor3 = Library.Theme["Text"],
						Text = Textbox.Name,
						Size = UDim2.new(0, 0, 0, 16),
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 1, 0, -2),
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.X
					}):AddToTheme({TextColor3 = 'Text'})

					Library:Create("UIStroke", {
						Name = "\0",
						Parent = Items["Text"].Instance
					})

					Items["Textbox"].Instance.Size = UDim2.new(1, 0, 0, 38)
				end

				Items["Background"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Textbox"].Instance,
					ClipsDescendants = true,
					AnchorPoint = Vector2.new(0, 1),
					Size = UDim2.new(1, -4, 0, 22),
					Position = UDim2.new(0, 2, 1, 0),
					Selectable = true,
					Active = true,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Inline"]
				}):AddToTheme({BackgroundColor3 = 'Inline'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Background"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Background"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				Items["Input"] = Library:Create("TextBox", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["Background"].Instance,
					Active = false,
					Selectable = false,
					AnchorPoint = Vector2.new(0, 0.5),
					PlaceholderColor3 = Library.Theme["Inactive Text"],
					PlaceholderText = Textbox.Placeholder,
					Size = UDim2.new(1, -12, 0, 16),
					TextColor3 = Library.Theme["Text"],
					Text = "",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 6, 0.5, 0),
					CursorPosition = -1,
					ClearTextOnFocus = false,
					BorderSizePixel = 0
				}):AddToTheme({TextColor3 = 'Text', PlaceholderColor3 = 'Inactive Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Input"].Instance
				})

				Textbox.Items = Items
			end

			function Textbox:SetVisibility(Bool)
				Items["Textbox"].Instance.Visible = Bool
			end

			function Textbox:SetText(Text)
				if Items["Text"] then
					Items["Text"].Instance.Text = tostring(Text)
				end
			end

			function Textbox:Set(Value)
				if Textbox.Numeric then
					if (not tonumber(Value)) and string.len(tostring(Value)) > 0 then
						Value = Textbox.Value
					end
				end

				Textbox.Value = Value
				Items["Input"].Instance.Text = Value
				Flags[Textbox.Flag] = Value

				Library:SafeCall(Textbox.Callback, Value)
			end

			if Textbox.Finished then
				Items["Input"]:Connect("FocusLost", function(PressedEnterQuestionMark)
					if PressedEnterQuestionMark then
						Textbox:Set(Items["Input"].Instance.Text)
					end
				end)
			else
				Library:Connect(Items["Input"].Instance:GetPropertyChangedSignal("Text"), function()
					Textbox:Set(Items["Input"].Instance.Text)
				end)
			end

			Textbox:Set(Textbox.Default)

			SetFlags[Textbox.Flag] = function(Value)
				Textbox:Set(Value)
			end

			return setmetatable(Textbox, Library)
		end

		Library.Listbox = function(Self, Params)
			Params = Params or { }

			local UseSearch = Params.Search

			if UseSearch == nil then
				UseSearch = Params.search
			end

			if UseSearch == nil then
				UseSearch = true
			end

			local Listbox = {
				Name = Params.Name or Params.name,
				OptionItems = Params.Items or Params.items or { },
				Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
				Default = Params.Default or Params.default,
				Callback = Params.Callback or Params.callback or function() end,
				Multi = Params.Multi or Params.multi or false,
				Search = UseSearch,
				Height = Params.Height or Params.height or 100,
				Tooltip = Params.Tooltip or Params.tooltip,
				Window = Self.Window,
				Page = Self.Page,
				Section = Self,
				Options = { },
				Items = { }
			}

			Listbox.Value = Listbox.Multi and { } or ""

			local Parent = Params.Parent or Listbox.Section.Items["Content"]
			local ParentInstance = Library:ResolveParent(Parent)

			local TitleHeight = Listbox.Name and 16 or 0
			local SearchHeight = Listbox.Search and 24 or 0

			local Items = { } do
				Items["Listbox"] = Library:Create("Frame", {
					Name = "\0",
					Parent = ParentInstance,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 0, TitleHeight + SearchHeight + Listbox.Height)
				})

				if Listbox.Name then
					Items["Title"] = Library:Create("TextLabel", {
						Name = "\0",
						FontFace = Library.Font,
						TextSize = Library.FontSize,
						Parent = Items["Listbox"].Instance,
						TextColor3 = Library.Theme["Text"],
						Text = Listbox.Name,
						TextXAlignment = Enum.TextXAlignment.Left,
						Size = UDim2.new(1, 0, 0, 16),
						BackgroundTransparency = 1,
						BorderSizePixel = 0
					}):AddToTheme({TextColor3 = 'Text'})

					Library:Create("UIStroke", {
						Name = "\0",
						Parent = Items["Title"].Instance
					})
				end

				if Listbox.Search then
					Items["SearchBackground"] = Library:Create("Frame", {
						Name = "\0",
						Parent = Items["Listbox"].Instance,
						ClipsDescendants = true,
						Position = UDim2.new(0, 2, 0, TitleHeight),
						Size = UDim2.new(1, -4, 0, 20),
						BorderSizePixel = 0,
						BackgroundColor3 = Library.Theme["Element"]
					}):AddToTheme({BackgroundColor3 = 'Element'})

					Library:Create("UIGradient", {
						Name = "\0",
						Parent = Items["SearchBackground"].Instance,
						Rotation = 90,
						Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(184, 184, 184))
						}
					})

					Library:Create("UIStroke", {
						Name = "\0",
						Parent = Items["SearchBackground"].Instance,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						LineJoinMode = Enum.LineJoinMode.Miter,
						Color = Library.Theme["Outline 1"]
					}):AddToTheme({Color = 'Outline 1'})

					Library:Create("UIStroke", {
						Name = "\0",
						Parent = Items["SearchBackground"].Instance,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						LineJoinMode = Enum.LineJoinMode.Miter,
						Color = Library.Theme["Outline 3"],
						BorderOffset = UDim.new(0, 1)
					}):AddToTheme({Color = 'Outline 3'})

					Items["Search"] = Library:Create("TextBox", {
						Name = "\0",
						FontFace = Library.Font,
						TextSize = Library.FontSize,
						Parent = Items["SearchBackground"].Instance,
						AnchorPoint = Vector2.new(0, 0.5),
						Position = UDim2.new(0, 6, 0.5, 0),
						Size = UDim2.new(1, -12, 0, 16),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						ClearTextOnFocus = false,
						Text = "",
						PlaceholderText = Params.Placeholder or Params.placeholder or "Search",
						TextXAlignment = Enum.TextXAlignment.Left,
						PlaceholderColor3 = Library.Theme["Inactive Text"],
						TextColor3 = Library.Theme["Text"]
					}):AddToTheme({TextColor3 = 'Text', PlaceholderColor3 = 'Inactive Text'})
				end

				Items["ListFrame"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Listbox"].Instance,
					Position = UDim2.new(0, 2, 0, TitleHeight + SearchHeight),
					Size = UDim2.new(1, -4, 0, Listbox.Height),
					ClipsDescendants = true,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Content"]
				}):AddToTheme({BackgroundColor3 = 'Content'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["ListFrame"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["ListFrame"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				Items["List"] = Library:Create("ScrollingFrame", {
					Name = "\0",
					Parent = Items["ListFrame"].Instance,
					Active = true,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 2, 0, 3),
					Size = UDim2.new(1, -7, 1, -6),
					BorderSizePixel = 0,
					CanvasSize = UDim2.new(0, 0, 0, 0),
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					ScrollingDirection = Enum.ScrollingDirection.Y,
					ElasticBehavior = Enum.ElasticBehavior.Never,
					ScrollBarThickness = 0
				})

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["List"].Instance,
					Padding = UDim.new(0, 1),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				Library:Scrollbar(Items["List"], {Parent = Items["ListFrame"], Top = 3, Right = 1, Bottom = 3, Track = true})

				Listbox.Items = Items
			end

			local function IsSelected(Value)
				if Listbox.Multi then
					return table.find(Listbox.Value, Value) ~= nil
				end

				return Listbox.Value == Value
			end

			local function PaintOption(Option)
				local Selected = IsSelected(Option.Value)
				Option.Selected = Selected

				if Selected then
					Option.Items["Button"].Instance.BackgroundTransparency = 1
					Option.Items["Text"]:ChangeItemTheme({TextColor3 = "Accent"})
					Option.Items["Text"]:Tween({TextColor3 = Library.Theme["Accent"]})
				else
					Option.Items["Button"].Instance.BackgroundTransparency = 1
					Option.Items["Text"]:ChangeItemTheme({TextColor3 = "Inactive Text"})
					Option.Items["Text"]:Tween({TextColor3 = Library.Theme["Inactive Text"]})
				end

			end

			local function Finish()
				for _, Option in Listbox.Options do
					PaintOption(Option)
				end

				Flags[Listbox.Flag] = Listbox.Value
				Library:SafeCall(Listbox.Callback, Listbox.Value)
			end

			function Listbox:Set(Value)
				if Listbox.Multi then
					if type(Value) == "table" then
						Listbox.Value = table.clone(Value)
					elseif Value ~= nil then
						local Index = table.find(Listbox.Value, Value)

						if Index then
							table.remove(Listbox.Value, Index)
						else
							table.insert(Listbox.Value, Value)
						end
					end
				else
					Listbox.Value = Value or ""
				end

				Finish()
			end

			function Listbox:Add(Value)
				Value = tostring(Value)

				local Option = {
					Value = Value,
					Selected = false,
					Items = { }
				}

				Option.Items["Button"] = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["List"].Instance,
					Text = "",
					AutoButtonColor = false,
					Size = UDim2.new(1, 0, 0, 18),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					BackgroundColor3 = Library.Theme["Element"]
				}):AddToTheme({BackgroundColor3 = 'Element'})

				Option.Items["Text"] = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Option.Items["Button"].Instance,
					TextColor3 = Library.Theme["Inactive Text"],
					Text = Value,
					TextXAlignment = Enum.TextXAlignment.Left,
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 6, 0.5, 0),
					Size = UDim2.new(1, -10, 0, 16),
					BackgroundTransparency = 1,
					BorderSizePixel = 0
				}):AddToTheme({TextColor3 = 'Inactive Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Option.Items["Text"].Instance
				})

				Option.Items["Button"]:OnHover(function()
					if not Option.Selected then
						Option.Items["Text"]:Tween({TextColor3 = Library.Theme["Text"]})
					end
				end, function()
					if not Option.Selected then
						Option.Items["Text"]:Tween({TextColor3 = Library.Theme["Inactive Text"]})
					end
				end)

				Option.Items["Button"]:Connect("MouseButton1Down", function()
					Listbox:Set(Value)
				end)

				table.insert(Listbox.Options, Option)
				PaintOption(Option)

				return Option
			end

			function Listbox:Remove(Value)
				for Index = #Listbox.Options, 1, -1 do
					local Option = Listbox.Options[Index]

					if Option.Value == Value then
						Option.Items["Button"].Instance:Destroy()
						table.remove(Listbox.Options, Index)
					end
				end
			end

			function Listbox:Refresh(List)
				for _, Option in Listbox.Options do
					Option.Items["Button"].Instance:Destroy()
				end

				Listbox.Options = { }
				Listbox.OptionItems = List or { }

				for _, Value in Listbox.OptionItems do
					Listbox:Add(Value)
				end
			end

			function Listbox:SetVisibility(Bool)
				Items["Listbox"].Instance.Visible = Bool
			end

			function Listbox:GetValue()
				return Listbox.Value
			end

			for _, Value in Listbox.OptionItems do
				Listbox:Add(Value)
			end

			if Listbox.Search then
				local LastListClick = 0

				Library:Connect(UserInputService.InputBegan, function(Input)
					if Input.UserInputType ~= Enum.UserInputType.MouseButton1 and Input.UserInputType ~= Enum.UserInputType.Touch then
						return
					end

					if not Items["ListFrame"]:IsMouseOverFrame() then
						return
					end

					local Now = os.clock()

					if (Now - LastListClick) <= 0.35 then
						pcall(function()
							Items["Search"].Instance:CaptureFocus()
						end)
					end

					LastListClick = Now
				end)
			end

			if Listbox.Search then
				Items["Search"]:Connect("Changed", function(Property)
					if Property ~= "Text" then
						return
					end

					local Query = string.lower(Items["Search"].Instance.Text)

					for _, Option in Listbox.Options do
						Option.Items["Button"].Instance.Visible = Query == "" or string.find(string.lower(Option.Value), Query, 1, true) ~= nil
					end
				end)
			end

			if Listbox.Default ~= nil then
				Listbox:Set(Listbox.Default)
			else
				Flags[Listbox.Flag] = Listbox.Value
			end

			SetFlags[Listbox.Flag] = function(Value)
				Listbox:Set(Value)
			end

			return setmetatable(Listbox, Library)
		end

		local function CatmullRom(P0, P1, P2, P3, T)
			local T2 = T * T
			local T3 = T2 * T

			return 0.5 * ((2 * P1) + (-P0 + P2) * T + (2 * P0 - 5 * P1 + 4 * P2 - P3) * T2 + (-P0 + 3 * P1 - 3 * P2 + P3) * T3)
		end

		local function DrawPolyline(Parent, Pool, Points, Thickness, ThemeKey)
			local Used = 0

			for Index = 1, #Points - 1 do
				local Start = Points[Index]
				local Finish = Points[Index + 1]
				local Delta = Finish - Start
				local Length = Delta.Magnitude

				if Length > 0 then
					Used += 1

					local Part = Pool[Used]

					if not Part then
						Part = Library:Create("Frame", {
							Name = "\0",
							Parent = Parent,
							AnchorPoint = Vector2.new(0.5, 0.5),
							BorderSizePixel = 0,
							ZIndex = 2,
							Size = UDim2.fromOffset(0, Thickness or 1),
							BackgroundColor3 = Library.Theme[ThemeKey or "Text"]
						}):AddToTheme({BackgroundColor3 = ThemeKey or 'Text'})

						if (Thickness or 1) > 1 then
							Library:Create("UICorner", {
								Name = "\0",
								Parent = Part.Instance,
								CornerRadius = UDim.new(1, 0)
							})
						end

						Pool[Used] = Part
					end

					Part.Instance.Size = UDim2.fromOffset(math.ceil(Length) + (Thickness or 1), Thickness or 1)
					Part.Instance.Position = UDim2.fromOffset((Start.X + Finish.X) / 2, (Start.Y + Finish.Y) / 2)
					Part.Instance.Rotation = math.deg(math.atan2(Delta.Y, Delta.X))
					Part.Instance.Visible = true
				end
			end

			for Index = Used + 1, #Pool do
				Pool[Index].Instance.Visible = false
			end
		end

		local function GraphGrid(Parent, Columns, Rows)
			for Index = 1, Columns - 1 do
				Library:Create("Frame", {
					Name = "\0",
					Parent = Parent,
					BorderSizePixel = 0,
					Position = UDim2.new(Index / Columns, 0, 0, 0),
					Size = UDim2.new(0, 1, 1, 0),
					BackgroundTransparency = 0.5,
					BackgroundColor3 = Library.Theme["Outline 1"]
				}):AddToTheme({BackgroundColor3 = 'Outline 1'})
			end

			for Index = 1, Rows - 1 do
				Library:Create("Frame", {
					Name = "\0",
					Parent = Parent,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, Index / Rows, 0),
					Size = UDim2.new(1, 0, 0, 1),
					BackgroundTransparency = 0.5,
					BackgroundColor3 = Library.Theme["Outline 1"]
				}):AddToTheme({BackgroundColor3 = 'Outline 1'})
			end
		end

		local function GraphBoxShadow(Box)
			Library:Create("UIStroke", {
				Name = "\0",
				Parent = Box.Instance,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				LineJoinMode = Enum.LineJoinMode.Miter,
				Color = Library.Theme["Outline 4"],
				BorderOffset = UDim.new(0, 2)
			}):AddToTheme({Color = 'Outline 4'})

			return Library:Shade(Box, 0.5)
		end

		local function MakeGraphFloatable(Object, Items, RootKey, Options)
			local Root = Items[RootKey]
			local Column = Root.Instance.Parent
			local Apply = Options.Apply
			local Handle = Options.Handle
			local Minimum = Options.MinimumHeight or 40
			local Maximum = Options.MaximumHeight or 600
			local Padding = 4

			Object.Popped = false
			Object.Resizable = Options.Resizable ~= false
			Object.CanPopOut = Options.PopOut ~= false and Handle ~= nil

			Items["Floating"] = Library:Create("Frame", {
				Name = "\0",
				Parent = Library.Holder.Instance,
				Visible = false,
				Position = UDim2.fromOffset(260, 220),
				Size = UDim2.fromOffset(300, 220),
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme["Background"]
			}):AddToTheme({BackgroundColor3 = 'Background'})

			for Index, Outline in {"Outline 1", "Outline 3", "Outline 2", "Outline 4"} do
				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Floating"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme[Outline],
					BorderOffset = UDim.new(0, Index - 1)
				}):AddToTheme({Color = Outline})
			end

			Library:Create("Frame", {
				Name = "\0",
				Parent = Items["Floating"].Instance,
				Size = UDim2.new(1, 0, 0, 1),
				ZIndex = 3,
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme["Accent"]
			}):AddToTheme({BackgroundColor3 = 'Accent'})

			Items["Floating"]:MakeResizeable(Vector2.new(190, 110))

			local Layer = Library:RegisterWindow(Items["Floating"])

			Items["Grip"] = Library:Create("TextButton", {
				Name = "\0",
				Parent = Root.Instance,
				Text = "",
				AutoButtonColor = false,
				Visible = Object.Resizable,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 2),
				ZIndex = 8,
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme["Accent"]
			}):AddToTheme({BackgroundColor3 = 'Accent'})

			Items["DropZone"] = Library:Create("Frame", {
				Name = "\0",
				Parent = Column,
				Visible = false,
				BackgroundTransparency = 1,
				LayoutOrder = Root.Instance.LayoutOrder,
				Size = UDim2.new(1, 0, 0, 0),
				BorderSizePixel = 0
			})

			Items["DropStroke"] = Library:Create("UIStroke", {
				Name = "\0",
				Parent = Items["DropZone"].Instance,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				LineJoinMode = Enum.LineJoinMode.Miter,
				Thickness = 1,
				Enabled = false,
				Color = Library.Theme["Accent"]
			}):AddToTheme({Color = 'Accent'})

			local function ShowDropZone(Bool)
				Items["DropStroke"].Instance.Enabled = Bool
			end

			local function NearGraphColumn()
				if not Column then
					return false
				end

				local Point = Library:MousePoint()
				local Origin = Column.AbsolutePosition
				local Bounds = Column.AbsoluteSize
				local Margin = 45

				return Point.X >= Origin.X - Margin and Point.X <= Origin.X + Bounds.X + Margin
					and Point.Y >= Origin.Y - Margin and Point.Y <= Origin.Y + Bounds.Y + Margin
			end

			local GripResizing = false
			local GripStart = 0
			local GripHeight = 0
			local DragTracking = false
			local DragFloating = false
			local DragStart = Vector2.new(0, 0)
			local DragOffset = Vector2.new(0, 0)

			function Object:SetHeight(Height)
				Object.Height = math.clamp(Height, Minimum, Maximum)

				if not Object.Popped then
					Apply(Object.Height, false)
				end
			end

			function Object:PopOut()
				if Object.Popped then
					return
				end

				Object.Popped = true

				local Position = Root.Instance.AbsolutePosition
				local Size = Root.Instance.AbsoluteSize

				local Anchor = Library:HolderPoint(Vector2.new(Position.X - Padding, Position.Y - Padding))

				Items["Floating"].Instance.Size = UDim2.fromOffset(math.max(Size.X, 190) + Padding * 2, math.max(Size.Y, 110) + Padding * 2)
				Items["Floating"].Instance.Position = UDim2.fromOffset(Anchor.X, Anchor.Y)
				Items["Floating"].Instance.Visible = true

				Items["DropZone"].Instance.Size = UDim2.new(1, 0, 0, Size.Y)
				Items["DropZone"].Instance.Visible = true
				ShowDropZone(false)

				Root.Instance.Parent = Items["Floating"].Instance
				Root.Instance.Position = UDim2.fromOffset(Padding, Padding)
				Root.Instance.Size = UDim2.new(1, -Padding * 2, 1, -Padding * 2)

				Apply(Object.Height, true)
				Library:BringToFront(Layer)
			end

			function Object:Dock()
				if not Object.Popped then
					return
				end

				Object.Popped = false
				Object.Height = math.clamp(Root.Instance.AbsoluteSize.Y - (Options.Chrome or 0), Minimum, Maximum)

				Items["DropZone"].Instance.Visible = false
				ShowDropZone(false)

				Root.Instance.Parent = Column
				Root.Instance.Position = UDim2.new(0, 0, 0, 0)
				Items["Floating"].Instance.Visible = false

				Apply(Object.Height, false)
			end

			function Object:SetPopped(Bool)
				if Bool then
					Object:PopOut()
				else
					Object:Dock()
				end
			end

			if Handle then
				Handle.Instance.Active = true

				Handle:Connect("InputBegan", function(Input)
					if not Object.CanPopOut then
						return
					end

					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
						Library:ClaimDrag()

						DragTracking = true
						DragStart = Vector2.new(Input.Position.X, Input.Position.Y)
					end
				end)
			end

			Items["Grip"]:Connect("InputBegan", function(Input)
				if Object.Popped or not Object.Resizable then
					return
				end

				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Library:ClaimDrag()

					GripResizing = true
					GripStart = Input.Position.Y
					GripHeight = Object.Height
					Items["Grip"].Instance.BackgroundTransparency = 0
				end
			end)

			Items["Grip"]:OnHover(function()
				if not GripResizing then
					Items["Grip"].Instance.BackgroundTransparency = 0.55
				end
			end, function()
				if not GripResizing then
					Items["Grip"].Instance.BackgroundTransparency = 1
				end
			end)

			Library:Connect(UserInputService.InputChanged, function(Input)
				if Input.UserInputType ~= Enum.UserInputType.MouseMovement and Input.UserInputType ~= Enum.UserInputType.Touch then
					return
				end

				if GripResizing then
					Object:SetHeight(GripHeight + (Input.Position.Y - GripStart))
					return
				end

				if not DragTracking then
					return
				end

				local Position = Vector2.new(Input.Position.X, Input.Position.Y)

				if not DragFloating then
					if (Position - DragStart).Magnitude < 14 then
						return
					end

					Object:PopOut()

					DragFloating = true

					local Frame = Items["Floating"].Instance.AbsolutePosition

					DragOffset = Library:MousePoint() - Vector2.new(Frame.X, Frame.Y)
				end

				local Target = Library:HolderPoint(Library:MousePoint() - DragOffset)

				Items["Floating"].Instance.Position = UDim2.fromOffset(Target.X, Target.Y)
				ShowDropZone(NearGraphColumn())
			end)

			Library:Connect(UserInputService.InputEnded, function(Input)
				if Input.UserInputType ~= Enum.UserInputType.MouseButton1 and Input.UserInputType ~= Enum.UserInputType.Touch then
					return
				end

				if GripResizing then
					GripResizing = false
					Items["Grip"].Instance.BackgroundTransparency = 1
				end

				if DragFloating then
					if NearGraphColumn() then
						Object:Dock()
					end

					ShowDropZone(false)
				end

				DragTracking = false
				DragFloating = false
			end)

			if Object.Window and Object.Window.Items and Object.Window.Items["MainFrame"] then
				local MainFrame = Object.Window.Items["MainFrame"].Instance

				Library:Connect(MainFrame:GetPropertyChangedSignal("Visible"), function()
					if Object.Popped then
						Items["Floating"].Instance.Visible = MainFrame.Visible
					end
				end)
			end
		end

		Library.Graph = function(Self, Params)
			Params = Params or { }

			local Smooth = Params.Smooth

			if Smooth == nil then
				Smooth = Params.smooth
			end

			if Smooth == nil then
				Smooth = true
			end

			local Graph = {
				Name = Params.Name or Params.name,
				Height = Params.Height or Params.height or 40,
				Min = Params.Min or Params.min or 0,
				Max = Params.Max or Params.max or 100,
				MaxPoints = Params.MaxPoints or Params.maxpoints or 64,
				Smooth = Smooth,
				Data = Params.Data or Params.data or { },
				Tooltip = Params.Tooltip or Params.tooltip,
				Window = Self.Window,
				Page = Self.Page,
				Section = Self,
				Items = { }
			}

			local Parent = Params.Parent or Graph.Section.Items["Content"]
			local ParentInstance = Library:ResolveParent(Parent)
			local TitleHeight = Graph.Name and 18 or 0

			local Items = { } do
				Items["Graph"] = Library:Create("Frame", {
					Name = "\0",
					Parent = ParentInstance,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 0, TitleHeight + Graph.Height)
				})

				if Graph.Name then
					Items["Title"] = Library:Create("TextLabel", {
						Name = "\0",
						FontFace = Library.Font,
						TextSize = Library.FontSize,
						Parent = Items["Graph"].Instance,
						TextColor3 = Library.Theme["Text"],
						Text = Graph.Name,
						TextXAlignment = Enum.TextXAlignment.Left,
						Size = UDim2.new(1, 0, 0, 16),
						BackgroundTransparency = 1,
						BorderSizePixel = 0
					}):AddToTheme({TextColor3 = 'Text'})

					Library:Create("UIStroke", {
						Name = "\0",
						Parent = Items["Title"].Instance
					})
				end

				Items["Box"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Graph"].Instance,
					Position = UDim2.new(0, 0, 0, TitleHeight),
					Size = UDim2.new(1, 0, 0, Graph.Height),
					ClipsDescendants = true,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Content"]
				}):AddToTheme({BackgroundColor3 = 'Content'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Box"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Box"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				GraphGrid(Items["Box"].Instance, Params.Columns or 5, Params.Rows or 3)
				GraphBoxShadow(Items["Box"])

				Graph.Items = Items
			end

			local Pool = { }

			local function Redraw()
				local Box = Items["Box"].Instance
				local Width = Box.AbsoluteSize.X
				local Height = Box.AbsoluteSize.Y
				local Data = Graph.Data
				local Count = #Data

				if Count < 2 or Width <= 0 or Height <= 0 then
					DrawPolyline(Box, Pool, { }, 1)
					return
				end

				local Range = Graph.Max - Graph.Min

				if Range == 0 then
					Range = 1
				end

				local function Sample(Index)
					return Data[math.clamp(Index, 1, Count)]
				end

				local function ToY(Value)
					return Height - ((math.clamp(Value, Graph.Min, Graph.Max) - Graph.Min) / Range) * Height
				end

				local Steps = Graph.Smooth and 8 or 1
				local Points = { }

				for Index = 1, Count - 1 do
					for Step = 0, Steps - 1 do
						local Alpha = Step / Steps
						local Value

						if Graph.Smooth then
							Value = CatmullRom(Sample(Index - 1), Sample(Index), Sample(Index + 1), Sample(Index + 2), Alpha)
						else
							Value = Sample(Index) + (Sample(Index + 1) - Sample(Index)) * Alpha
						end

						table.insert(Points, Vector2.new(((Index - 1) + Alpha) / (Count - 1) * Width, ToY(Value)))
					end
				end

				table.insert(Points, Vector2.new(Width, ToY(Sample(Count))))
				DrawPolyline(Box, Pool, Points, 2)
			end

			function Graph:SetData(Data)
				Graph.Data = Data or { }
				Redraw()
			end

			function Graph:Push(Value)
				table.insert(Graph.Data, tonumber(Value) or 0)

				while #Graph.Data > Graph.MaxPoints do
					table.remove(Graph.Data, 1)
				end

				Redraw()
			end

			function Graph:Clear()
				Graph.Data = { }
				Redraw()
			end

			function Graph:SetRange(Min, Max)
				Graph.Min = Min or Graph.Min
				Graph.Max = Max or Graph.Max
				Redraw()
			end

			function Graph:SetVisibility(Bool)
				Items["Graph"].Instance.Visible = Bool
			end

			local function ApplyGraphLayout(Height, Popped)
				if Popped then
					Items["Box"].Instance.Position = UDim2.new(0, 0, 0, TitleHeight)
					Items["Box"].Instance.Size = UDim2.new(1, 0, 1, -TitleHeight)
					Items["Grip"].Instance.Visible = false
				else
					Graph.Height = Height

					Items["Graph"].Instance.Size = UDim2.new(1, 0, 0, TitleHeight + Height + 4)
					Items["Box"].Instance.Position = UDim2.new(0, 0, 0, TitleHeight)
					Items["Box"].Instance.Size = UDim2.new(1, 0, 0, Height)
					Items["Grip"].Instance.Position = UDim2.new(0, 0, 0, TitleHeight + Height)
					Items["Grip"].Instance.Visible = Graph.Resizable
				end
			end

			MakeGraphFloatable(Graph, Items, "Graph", {
				Handle = Items["Title"],
				Apply = ApplyGraphLayout,
				Chrome = TitleHeight + 4,
				MinimumHeight = 32,
				MaximumHeight = 600,
				PopOut = Params.PopOut ~= false,
				Resizable = Params.Resizable ~= false
			})

			ApplyGraphLayout(Graph.Height, false)

			Library:Connect(Items["Box"].Instance:GetPropertyChangedSignal("AbsoluteSize"), Redraw)
			Redraw()

			if Params.Editable or Params.editable then
				local EditorHeight = Params.EditorHeight or Params.editorheight or 120

				Items["EditorClip"] = Library:Create("Frame", {
					Name = "\0",
					Parent = ParentInstance,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Size = UDim2.new(1, 0, 0, 0)
				})

				Items["EditorHolder"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["EditorClip"].Instance,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					Size = UDim2.new(1, 0, 0, 0)
				})

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["EditorHolder"].Instance,
					Padding = UDim.new(0, 4),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				Library:Create("UIPadding", {
					Name = "\0",
					Parent = Items["EditorHolder"].Instance,
					PaddingTop = UDim.new(0, 2),
					PaddingBottom = UDim.new(0, 4)
				})

				Items["EditorButton"] = Library:Create("TextButton", {
					Name = "\0",
					Parent = Items["Box"].Instance,
					Text = "",
					AutoButtonColor = false,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 6,
					Size = UDim2.new(1, 0, 1, 0)
				})

				Graph.EditorOpen = false

				local function EditorTarget()
					return Graph.EditorOpen and Items["EditorHolder"].Instance.AbsoluteSize.Y or 0
				end

				function Graph:PullFromEditor()
					if not Graph.Editor then
						return
					end

					local Samples = math.clamp(Graph.MaxPoints, 8, 64)
					local Data = { }

					for Index = 1, Samples do
						Data[Index] = Graph.Editor:Evaluate((Index - 1) / (Samples - 1) * 100)
					end

					Graph:SetData(Data)
				end

				function Graph:BuildEditor()
					if Graph.Editor then
						return Graph.Editor
					end

					local Count = #Graph.Data
					local Seed = { }

					if Count >= 2 then
						local Steps = math.min(Count, 6)

						for Index = 1, Steps do
							local Alpha = (Index - 1) / (Steps - 1)

							Seed[Index] = {
								X = Alpha * 100,
								Y = Graph.Data[math.clamp(math.floor(Alpha * (Count - 1)) + 1, 1, Count)]
							}
						end
					end

					Graph.Editor = Library.GraphEditor(Graph, {
						Height = EditorHeight,
						Parent = Items["EditorHolder"],
						Flag = tostring(Graph.Name or "graph") .. "_editor",
						XMin = 0,
						XMax = 100,
						YMin = Graph.Min,
						YMax = Graph.Max,
						XLabel = Params.XLabel or Params.xlabel or "increment",
						YLabel = Params.YLabel or Params.ylabel or "value",
						PopOut = false,
						Points = Seed,
						Callback = function()
							Graph:PullFromEditor()
						end
					})

					Graph:PullFromEditor()

					return Graph.Editor
				end

				function Graph:SetEditorOpen(Bool, Instant)
					Graph.EditorOpen = Bool and true or false

					if Graph.EditorOpen then
						Graph:BuildEditor()
					end

					local Target = EditorTarget()

					if Instant then
						Items["EditorClip"].Instance.Size = UDim2.new(1, 0, 0, Target)

						return
					end

					Items["EditorClip"]:Tween({Size = UDim2.new(1, 0, 0, Target)}, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
				end

				Library:Connect(Items["EditorHolder"].Instance:GetPropertyChangedSignal("AbsoluteSize"), function()
					if Graph.EditorOpen then
						Items["EditorClip"]:Tween({Size = UDim2.new(1, 0, 0, EditorTarget())}, TweenInfo.new(0.12, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
					end
				end)

				Items["EditorButton"]:Connect("MouseButton1Click", function()
					Graph:SetEditorOpen(not Graph.EditorOpen)
				end)
			end

			return setmetatable(Graph, Library)
		end

		Library.GraphEditor = function(Self, Params)
			Params = Params or { }

			local GraphEditor = {
				Name = Params.Name or Params.name,
				Height = Params.Height or Params.height or 120,
				XMin = Params.XMin or Params.xmin or 0,
				XMax = Params.XMax or Params.xmax or 100,
				YMin = Params.YMin or Params.ymin or 0,
				YMax = Params.YMax or Params.ymax or 100,
				XLabel = Params.XLabel or Params.xlabel or "Increment",
				YLabel = Params.YLabel or Params.ylabel or "deg/s",
				Interpolation = Params.Interpolation or Params.interpolation or "Linear",
				Modes = Params.Modes or Params.modes or {"Linear", "Smooth", "Step"},
				Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
				Callback = Params.Callback or Params.callback or function() end,
				Tooltip = Params.Tooltip or Params.tooltip,
				Window = Self.Window,
				Page = Self.Page,
				Section = Self,
				Points = { },
				Items = { }
			}

			local Parent = Params.Parent or GraphEditor.Section.Items["Content"]
			local ParentInstance = Library:ResolveParent(Parent)
			local TitleHeight = GraphEditor.Name and 18 or 0
			local ControlsHeight = 24

			local function NormalizePoints(List)
				local Result = { }

				for _, Point in List or { } do
					if type(Point) == "table" then
						local X = Point.X or Point.x or Point[1]
						local Y = Point.Y or Point.y or Point[2]

						if X and Y then
							table.insert(Result, {X = X, Y = Y})
						end
					end
				end

				table.sort(Result, function(A, B)
					return A.X < B.X
				end)

				return Result
			end

			GraphEditor.Points = NormalizePoints(Params.Points or Params.points)

			if #GraphEditor.Points < 2 then
				GraphEditor.Points = {
					{X = GraphEditor.XMin, Y = GraphEditor.YMin},
					{X = GraphEditor.XMax, Y = GraphEditor.YMax}
				}
			end

			local Items = { } do
				Items["GraphEditor"] = Library:Create("Frame", {
					Name = "\0",
					Parent = ParentInstance,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 0, TitleHeight + GraphEditor.Height + 4 + ControlsHeight)
				})

				if GraphEditor.Name then
					Items["Title"] = Library:Create("TextLabel", {
						Name = "\0",
						FontFace = Library.Font,
						TextSize = Library.FontSize,
						Parent = Items["GraphEditor"].Instance,
						TextColor3 = Library.Theme["Text"],
						Text = GraphEditor.Name,
						TextXAlignment = Enum.TextXAlignment.Left,
						Size = UDim2.new(1, 0, 0, 16),
						BackgroundTransparency = 1,
						BorderSizePixel = 0
					}):AddToTheme({TextColor3 = 'Text'})

					Library:Create("UIStroke", {
						Name = "\0",
						Parent = Items["Title"].Instance
					})
				end

				Items["Box"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["GraphEditor"].Instance,
					Position = UDim2.new(0, 0, 0, TitleHeight),
					Size = UDim2.new(1, 0, 0, GraphEditor.Height),
					ClipsDescendants = true,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Content"]
				}):AddToTheme({BackgroundColor3 = 'Content'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Box"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Box"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				GraphGrid(Items["Box"].Instance, Params.Columns or 6, Params.Rows or 4)
				GraphBoxShadow(Items["Box"])

				Items["CrosshairX"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Box"].Instance,
					Visible = false,
					Size = UDim2.new(0, 1, 1, 0),
					ZIndex = 4,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Text"]
				}):AddToTheme({BackgroundColor3 = 'Text'})

				Items["CrosshairY"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Box"].Instance,
					Visible = false,
					Size = UDim2.new(1, 0, 0, 1),
					ZIndex = 4,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Text"]
				}):AddToTheme({BackgroundColor3 = 'Text'})

				local function Label(Text, Position, Anchor, Alignment)
					local Created = Library:Create("TextLabel", {
						Name = "\0",
						FontFace = Library.Font,
						TextSize = Library.FontSize,
						Parent = Items["Box"].Instance,
						TextColor3 = Library.Theme["Inactive Text"],
						Text = Text,
						TextXAlignment = Alignment or Enum.TextXAlignment.Left,
						AnchorPoint = Anchor,
						Position = Position,
						Size = UDim2.new(0, 0, 0, 14),
						AutomaticSize = Enum.AutomaticSize.X,
						BackgroundTransparency = 1,
						ZIndex = 5,
						BorderSizePixel = 0
					}):AddToTheme({TextColor3 = 'Inactive Text'})

					Library:Create("UIStroke", {
						Name = "\0",
						Parent = Created.Instance
					})

					return Created
				end

				Items["MaxLabel"] = Label(tostring(GraphEditor.YMax), UDim2.new(0, 3, 0, 2), Vector2.new(0, 0))
				Items["YZeroLabel"] = Label(tostring(GraphEditor.YMin), UDim2.new(0, 3, 1, -2), Vector2.new(0, 1))
				Items["XZeroLabel"] = Label(tostring(GraphEditor.XMin), UDim2.new(0, 14, 1, -2), Vector2.new(0, 1))
				Items["XMaxLabel"] = Label(tostring(GraphEditor.XMax), UDim2.new(1, -3, 1, -2), Vector2.new(1, 1), Enum.TextXAlignment.Right)
				Items["XLabel"] = Label(GraphEditor.XLabel, UDim2.new(0.5, 0, 1, -2), Vector2.new(0.5, 1), Enum.TextXAlignment.Center)
				Items["YLabel"] = Label(GraphEditor.YLabel, UDim2.new(0, 3, 0.5, 0), Vector2.new(0, 0.5))
				Items["Readout"] = Label("", UDim2.new(1, -3, 0, 2), Vector2.new(1, 0), Enum.TextXAlignment.Right)

				Items["Controls"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["GraphEditor"].Instance,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 0, TitleHeight + GraphEditor.Height + 4),
					Size = UDim2.new(1, 0, 0, 20)
				})

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["Controls"].Instance,
					FillDirection = Enum.FillDirection.Horizontal,
					Padding = UDim.new(0, 4),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				GraphEditor.Items = Items
			end

			local function Plate(Size, Order)
				local Plated = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["Controls"].Instance,
					Text = "",
					AutoButtonColor = false,
					LayoutOrder = Order,
					Size = Size,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Element"]
				}):AddToTheme({BackgroundColor3 = 'Element'})

				Library:Create("UIGradient", {
					Name = "\0",
					Parent = Plated.Instance,
					Rotation = 90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(184, 184, 184))
					}
				})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Plated.Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Plated.Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				return Plated
			end

			local function PlateText(PlateItem, Text, Alignment, Offset)
				local Created = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = PlateItem.Instance,
					TextColor3 = Library.Theme["Text"],
					Text = Text,
					TextXAlignment = Alignment,
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, Offset or 0, 0.5, 0),
					Size = UDim2.new(1, -(Offset or 0) * 2, 0, 16),
					BackgroundTransparency = 1,
					BorderSizePixel = 0
				}):AddToTheme({TextColor3 = 'Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Created.Instance
				})

				return Created
			end

			Items["Mode"] = Plate(UDim2.new(0.6, -6, 1, 0), 1)
			Items["ModeText"] = PlateText(Items["Mode"], GraphEditor.Interpolation, Enum.TextXAlignment.Left, 7)

			Items["Arrow"] = Library:Create("TextLabel", {
				Name = "\0",
				FontFace = Library.Font,
				TextSize = 8,
				Parent = Items["Mode"].Instance,
				RichText = true,
				TextColor3 = Library.Theme["Text"],
				Text = "▼",
				AnchorPoint = Vector2.new(1, 0.5),
				Size = UDim2.new(0, 0, 0, 14),
				AutomaticSize = Enum.AutomaticSize.X,
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -7, 0.5, 0),
				BorderSizePixel = 0
			}):AddToTheme({TextColor3 = 'Text'})

			Items["Add"] = Plate(UDim2.new(0.2, -1, 1, 0), 2)
			PlateText(Items["Add"], "Add", Enum.TextXAlignment.Center, 0)

			Items["Remove"] = Plate(UDim2.new(0.2, -1, 1, 0), 3)
			PlateText(Items["Remove"], "Remove", Enum.TextXAlignment.Center, 0)

			Items["ModeHolder"] = Library:Create("Frame", {
				Name = "\0",
				Parent = Library.UnusedHolder.Instance,
				Visible = false,
				Size = UDim2.fromOffset(100, 4 + #GraphEditor.Modes * 18),
				ZIndex = Library.ZIndexOrder.OptionHolder,
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme["Content"]
			}):AddToTheme({BackgroundColor3 = 'Content'})

			Library:Create("UIStroke", {
				Name = "\0",
				Parent = Items["ModeHolder"].Instance,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				LineJoinMode = Enum.LineJoinMode.Miter,
				Color = Library.Theme["Outline 1"]
			}):AddToTheme({Color = 'Outline 1'})

			Library:Create("UIListLayout", {
				Name = "\0",
				Parent = Items["ModeHolder"].Instance,
				Padding = UDim.new(0, 1),
				SortOrder = Enum.SortOrder.LayoutOrder
			})

			Library:Create("UIPadding", {
				Name = "\0",
				Parent = Items["ModeHolder"].Instance,
				PaddingTop = UDim.new(0, 2),
				PaddingLeft = UDim.new(0, 2),
				PaddingRight = UDim.new(0, 2)
			})

			local ModeOptions = { }
			local ModeOpen = false

			local CurvePool = { }
			local KeyPool = { }
			local DraggingPoint = nil
			local SelectedPoint = GraphEditor.Points[1]

			local function ToPixel(Point, Width, Height)
				local SpanX = GraphEditor.XMax - GraphEditor.XMin
				local SpanY = GraphEditor.YMax - GraphEditor.YMin

				if SpanX == 0 then
					SpanX = 1
				end

				if SpanY == 0 then
					SpanY = 1
				end

				return Vector2.new(
					((Point.X - GraphEditor.XMin) / SpanX) * Width,
					Height - ((Point.Y - GraphEditor.YMin) / SpanY) * Height
				)
			end

			function GraphEditor:Evaluate(X)
				local Points = GraphEditor.Points
				local Count = #Points

				if Count == 0 then
					return GraphEditor.YMin
				end

				if X <= Points[1].X then
					return Points[1].Y
				end

				if X >= Points[Count].X then
					return Points[Count].Y
				end

				for Index = 1, Count - 1 do
					local First = Points[Index]
					local Second = Points[Index + 1]

					if X >= First.X and X <= Second.X then
						local Span = Second.X - First.X
						local Alpha = Span > 0 and (X - First.X) / Span or 0

						if GraphEditor.Interpolation == "Step" then
							return First.Y
						end

						if GraphEditor.Interpolation == "Smooth" then
							local Before = Points[math.max(Index - 1, 1)]
							local After = Points[math.min(Index + 2, Count)]

							return math.clamp(CatmullRom(Before.Y, First.Y, Second.Y, After.Y, Alpha), GraphEditor.YMin, GraphEditor.YMax)
						end

						return First.Y + (Second.Y - First.Y) * Alpha
					end
				end

				return Points[Count].Y
			end

			local function GetKeyframe(Index)
				local Keyframe = KeyPool[Index]

				if not Keyframe then
					Keyframe = Library:Create("TextButton", {
						Name = "\0",
						Text = "",
						AutoButtonColor = false,
						Parent = Items["Box"].Instance,
						AnchorPoint = Vector2.new(0.5, 0.5),
						Size = UDim2.fromOffset(6, 6),
						ZIndex = 6,
						BorderSizePixel = 0,
						BackgroundColor3 = Library.Theme["Accent"]
					}):AddToTheme({BackgroundColor3 = 'Accent'})

					Library:Create("UIStroke", {
						Name = "\0",
						Parent = Keyframe.Instance,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						LineJoinMode = Enum.LineJoinMode.Miter,
						Color = Library.Theme["Outline 1"]
					}):AddToTheme({Color = 'Outline 1'})

					Keyframe:Connect("InputBegan", function(Input)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
							DraggingPoint = GraphEditor.Points[Index]
							SelectedPoint = DraggingPoint
						end
					end)

					KeyPool[Index] = Keyframe
				end

				return Keyframe
			end

			local function Redraw()
				local Box = Items["Box"].Instance
				local Width = Box.AbsoluteSize.X
				local Height = Box.AbsoluteSize.Y

				if Width <= 0 or Height <= 0 then
					return
				end

				local Samples = math.clamp(math.floor(Width / 2), 24, 220)
				local Line = { }

				for Index = 0, Samples do
					local Alpha = Index / Samples
					local X = GraphEditor.XMin + Alpha * (GraphEditor.XMax - GraphEditor.XMin)

					table.insert(Line, ToPixel({X = X, Y = GraphEditor:Evaluate(X)}, Width, Height))
				end

				DrawPolyline(Box, CurvePool, Line, 2, "Accent")

				for Index, Point in GraphEditor.Points do
					local Keyframe = GetKeyframe(Index)
					local Pixel = ToPixel(Point, Width, Height)

					Keyframe.Instance.Position = UDim2.fromOffset(Pixel.X, Pixel.Y)
					Keyframe.Instance.Visible = true
				end

				for Index = #GraphEditor.Points + 1, #KeyPool do
					KeyPool[Index].Instance.Visible = false
				end
			end

			local Dirty = false

			local function Finish()
				Redraw()

				Flags[GraphEditor.Flag] = {
					Points = GraphEditor.Points,
					Interpolation = GraphEditor.Interpolation
				}

				Library:SafeCall(GraphEditor.Callback, GraphEditor.Points, GraphEditor.Interpolation)
			end

			Library:Connect(RunService.RenderStepped, function()
				if not Dirty then
					return
				end

				Dirty = false

				Finish()
			end)

			function GraphEditor:GetPoints()
				return GraphEditor.Points
			end

			function GraphEditor:SetPoints(Value)
				if type(Value) == "table" and Value.Points then
					if Value.Interpolation then
						GraphEditor.Interpolation = Value.Interpolation
						Items["ModeText"].Instance.Text = Value.Interpolation
					end

					Value = Value.Points
				end

				local Normalized = NormalizePoints(Value)

				if #Normalized >= 2 then
					GraphEditor.Points = Normalized
					SelectedPoint = GraphEditor.Points[1]
				end

				Finish()
			end

			function GraphEditor:AddPoint(X, Y)
				if not X then
					local BestIndex, BestSpan = 1, -1

					for Index = 1, #GraphEditor.Points - 1 do
						local Span = GraphEditor.Points[Index + 1].X - GraphEditor.Points[Index].X

						if Span > BestSpan then
							BestSpan = Span
							BestIndex = Index
						end
					end

					X = (GraphEditor.Points[BestIndex].X + GraphEditor.Points[BestIndex + 1].X) / 2
				end

				Y = Y or GraphEditor:Evaluate(X)

				local Point = {
					X = math.clamp(X, GraphEditor.XMin, GraphEditor.XMax),
					Y = math.clamp(Y, GraphEditor.YMin, GraphEditor.YMax)
				}

				table.insert(GraphEditor.Points, Point)
				table.sort(GraphEditor.Points, function(A, B)
					return A.X < B.X
				end)

				SelectedPoint = Point
				Finish()

				return Point
			end

			function GraphEditor:RemovePoint(Point)
				if #GraphEditor.Points <= 2 then
					return
				end

				Point = Point or SelectedPoint or GraphEditor.Points[#GraphEditor.Points]

				local Index = table.find(GraphEditor.Points, Point)

				if not Index then
					Index = #GraphEditor.Points
				end

				table.remove(GraphEditor.Points, Index)
				SelectedPoint = GraphEditor.Points[math.clamp(Index, 1, #GraphEditor.Points)]
				Finish()
			end

			function GraphEditor:SetInterpolation(Mode)
				GraphEditor.Interpolation = Mode
				Items["ModeText"].Instance.Text = Mode

				for _, Option in ModeOptions do
					Option.Items["Text"]:ChangeItemTheme({TextColor3 = Option.Value == Mode and "Accent" or "Inactive Text"})
					Option.Items["Text"]:Tween({TextColor3 = Library.Theme[Option.Value == Mode and "Accent" or "Inactive Text"]})
				end

				Finish()
			end

			function GraphEditor:SetVisibility(Bool)
				Items["GraphEditor"].Instance.Visible = Bool

				if not Bool and ModeOpen then
					GraphEditor:SetModeOpen(false)
				end
			end

			local ModeDebounce = false

			function GraphEditor:SetModeOpen(Bool)
				if ModeDebounce then
					return
				end

				ModeOpen = Bool
				ModeDebounce = true

				local Plate = Items["Mode"].Instance
				local AnchorX = Plate.AbsolutePosition.X
				local AnchorY = Plate.AbsolutePosition.Y + Plate.AbsoluteSize.Y + GuiInset

				if Bool then
					Items["ModeHolder"].Instance.Parent = Library.Holder.Instance
					Items["ModeHolder"].Instance.Size = UDim2.fromOffset(Plate.AbsoluteSize.X, 4 + #GraphEditor.Modes * 18)
					Items["ModeHolder"].Instance.Position = UDim2.fromOffset(AnchorX, AnchorY)
					Items["ModeHolder"].Instance.Visible = true

					Items["ModeHolder"]:Tween({Position = UDim2.fromOffset(AnchorX, AnchorY + 10)})
					Items["ModeHolder"]:FadeDescendants(true, function()
						ModeDebounce = false
					end)

					Items["Arrow"]:Tween({Rotation = 180})
				else
					Items["ModeHolder"]:Tween({Position = UDim2.fromOffset(AnchorX, AnchorY - 10)})
					Items["ModeHolder"]:FadeDescendants(false, function()
						Items["ModeHolder"].Instance.Parent = Library.UnusedHolder.Instance
						ModeDebounce = false
					end)

					Items["Arrow"]:Tween({Rotation = 0})
				end
			end

			for Order, Mode in GraphEditor.Modes do
				local Option = {
					Value = Mode,
					Items = { }
				}

				Option.Items["Button"] = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["ModeHolder"].Instance,
					Text = "",
					AutoButtonColor = false,
					LayoutOrder = Order,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 17),
					ZIndex = Library.ZIndexOrder.OptionHolder + 1,
					BorderSizePixel = 0
				})

				Option.Items["Text"] = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Option.Items["Button"].Instance,
					TextColor3 = Library.Theme[Mode == GraphEditor.Interpolation and "Accent" or "Inactive Text"],
					Text = Mode,
					TextXAlignment = Enum.TextXAlignment.Left,
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 5, 0.5, 0),
					Size = UDim2.new(1, -8, 0, 16),
					ZIndex = Library.ZIndexOrder.OptionHolder + 1,
					BackgroundTransparency = 1,
					BorderSizePixel = 0
				}):AddToTheme({TextColor3 = Mode == GraphEditor.Interpolation and 'Accent' or 'Inactive Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Option.Items["Text"].Instance
				})

				Option.Items["Button"]:Connect("MouseButton1Down", function()
					GraphEditor:SetInterpolation(Mode)
					GraphEditor:SetModeOpen(false)
				end)

				table.insert(ModeOptions, Option)
			end

			Items["Mode"]:Connect("MouseButton1Down", function()
				GraphEditor:SetModeOpen(not ModeOpen)
			end)

			Items["Add"]:Connect("MouseButton1Down", function()
				GraphEditor:AddPoint()
			end)

			Items["Remove"]:Connect("MouseButton1Down", function()
				GraphEditor:RemovePoint()
			end)

			for _, Plated in {Items["Mode"], Items["Add"], Items["Remove"]} do
				Plated:OnHover(function()
					Plated:ChangeItemTheme({BackgroundColor3 = "Hovered Element"})
					Plated:Tween({BackgroundColor3 = Library.Theme["Hovered Element"]})
				end, function()
					Plated:ChangeItemTheme({BackgroundColor3 = "Element"})
					Plated:Tween({BackgroundColor3 = Library.Theme["Element"]})
				end)
			end

			Items["Box"]:Connect("MouseMoved", function()
				local Box = Items["Box"].Instance
				local Absolute = Box.AbsolutePosition
				local Size = Box.AbsoluteSize

				local Point = Library:MousePoint()
				local OffsetX = math.clamp(Point.X - Absolute.X, 0, Size.X)
				local OffsetY = math.clamp(Point.Y - Absolute.Y, 0, Size.Y)

				Items["CrosshairX"].Instance.Position = UDim2.fromOffset(OffsetX, 0)
				Items["CrosshairY"].Instance.Position = UDim2.fromOffset(0, OffsetY)
				Items["CrosshairX"].Instance.Visible = true
				Items["CrosshairY"].Instance.Visible = true

				local ValueX = GraphEditor.XMin + (OffsetX / math.max(Size.X, 1)) * (GraphEditor.XMax - GraphEditor.XMin)

				Items["Readout"].Instance.Text = string.format("%.2f %.1f", ValueX, GraphEditor:Evaluate(ValueX))
			end)

			Items["Box"]:Connect("MouseLeave", function()
				Items["CrosshairX"].Instance.Visible = false
				Items["CrosshairY"].Instance.Visible = false
				Items["Readout"].Instance.Text = ""
			end)

			Library:Connect(UserInputService.InputChanged, function(Input)
				if not DraggingPoint then
					return
				end

				if Input.UserInputType ~= Enum.UserInputType.MouseMovement and Input.UserInputType ~= Enum.UserInputType.Touch then
					return
				end

				local Box = Items["Box"].Instance
				local Absolute = Box.AbsolutePosition
				local Size = Box.AbsoluteSize
				local Point = Library:MousePoint()
				local AlphaX = math.clamp((Point.X - Absolute.X) / math.max(Size.X, 1), 0, 1)
				local AlphaY = math.clamp((Point.Y - Absolute.Y) / math.max(Size.Y, 1), 0, 1)

				local NewX = GraphEditor.XMin + AlphaX * (GraphEditor.XMax - GraphEditor.XMin)
				local NewY = GraphEditor.YMax - AlphaY * (GraphEditor.YMax - GraphEditor.YMin)

				if NewX == DraggingPoint.X and NewY == DraggingPoint.Y then
					return
				end

				DraggingPoint.X = NewX
				DraggingPoint.Y = NewY

				table.sort(GraphEditor.Points, function(A, B)
					return A.X < B.X
				end)

				Dirty = true
			end)

			Library:Connect(UserInputService.InputEnded, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					DraggingPoint = nil

					if ModeOpen and not Items["ModeHolder"]:IsMouseOverFrame() and not Items["Mode"]:IsMouseOverFrame() then
						GraphEditor:SetModeOpen(false)
					end
				end
			end)

			Library:Connect(Items["Box"].Instance:GetPropertyChangedSignal("AbsoluteSize"), Redraw)

			Flags[GraphEditor.Flag] = {
				Points = GraphEditor.Points,
				Interpolation = GraphEditor.Interpolation
			}

			SetFlags[GraphEditor.Flag] = function(Value)
				GraphEditor:SetPoints(Value)
			end

			local function ApplyEditorLayout(Height, Popped)
				if Popped then
					Items["Box"].Instance.Position = UDim2.new(0, 0, 0, TitleHeight)
					Items["Box"].Instance.Size = UDim2.new(1, 0, 1, -(TitleHeight + 4 + ControlsHeight))
					Items["Controls"].Instance.Position = UDim2.new(0, 0, 1, -20)
					Items["Grip"].Instance.Visible = false
				else
					GraphEditor.Height = Height

					Items["GraphEditor"].Instance.Size = UDim2.new(1, 0, 0, TitleHeight + Height + 4 + ControlsHeight)
					Items["Box"].Instance.Position = UDim2.new(0, 0, 0, TitleHeight)
					Items["Box"].Instance.Size = UDim2.new(1, 0, 0, Height)
					Items["Controls"].Instance.Position = UDim2.new(0, 0, 0, TitleHeight + Height + 4)
					Items["Grip"].Instance.Position = UDim2.new(0, 0, 0, TitleHeight + Height)
					Items["Grip"].Instance.Visible = GraphEditor.Resizable
				end
			end

			MakeGraphFloatable(GraphEditor, Items, "GraphEditor", {
				Handle = Items["Title"],
				Apply = ApplyEditorLayout,
				Chrome = TitleHeight + 4 + ControlsHeight,
				MinimumHeight = 60,
				MaximumHeight = 600,
				PopOut = Params.PopOut ~= false,
				Resizable = Params.Resizable ~= false
			})

			ApplyEditorLayout(GraphEditor.Height, false)

			Redraw()

			return setmetatable(GraphEditor, Library)
		end

		Library.PlayerList = function(Self, Params)
			Params = Params or { }

			local PlayerList = {
				Name = Params.Name or Params.name or "Players",
				Priorities = Params.Priorities or Params.priorities or {"Neutral", "Friendly", "Enemy", "Ignored"},
				DefaultPriority = Params.DefaultPriority or Params.defaultpriority or "Neutral",
				Flag = Params.Flag or Params.flag or "Player Priorities",
				Callback = Params.Callback or Params.callback or function() end,
				IncludeLocal = Params.IncludeLocal or Params.includelocal or false,
				Values = { },
				Rows = { },
				Selected = nil,
				Items = { }
			}

			local function PlatedFrame(ParentInstance, Properties)
				local Plated = Library:Create(Properties.Class or "TextButton", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = ParentInstance,
					Text = "",
					AutoButtonColor = false,
					Position = Properties.Position,
					Size = Properties.Size,
					ZIndex = Properties.ZIndex or 2,
					ClipsDescendants = true,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Element"]
				}):AddToTheme({BackgroundColor3 = 'Element'})

				Library:Create("UIGradient", {
					Name = "\0",
					Parent = Plated.Instance,
					Rotation = 90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(184, 184, 184))
					}
				})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Plated.Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Plated.Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				return Plated
			end

			local function TextIn(ParentInstance, Text, Position, Size, ThemeKey, Alignment, Bold)
				local Created = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Bold and Library.BoldFont or Library.Font,
					TextSize = Library.FontSize,
					Parent = ParentInstance,
					TextColor3 = Library.Theme[ThemeKey or "Text"],
					Text = Text,
					TextXAlignment = Alignment or Enum.TextXAlignment.Left,
					TextTruncate = Enum.TextTruncate.AtEnd,
					Position = Position,
					Size = Size,
					ZIndex = 3,
					BackgroundTransparency = 1,
					BorderSizePixel = 0
				}):AddToTheme({TextColor3 = ThemeKey or 'Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Created.Instance
				})

				return Created
			end

			local function Box(ParentInstance, Title, Position, Size)
				local Frame = Library:Create("Frame", {
					Name = "\0",
					Parent = ParentInstance,
					Position = Position,
					Size = Size,
					ClipsDescendants = true,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Section Box"]
				}):AddToTheme({BackgroundColor3 = 'Section Box'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Frame.Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Frame.Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 3"],
					BorderOffset = UDim.new(0, 1)
				}):AddToTheme({Color = 'Outline 3'})

				local Header = Library:Create("Frame", {
					Name = "\0",
					Parent = Frame.Instance,
					Size = UDim2.new(1, 0, 0, 25),
					BorderSizePixel = 0,
					ZIndex = 2,
					BackgroundColor3 = Library.Theme["Element"]
				}):AddToTheme({BackgroundColor3 = 'Element'})

				Library:Create("UIGradient", {
					Name = "\0",
					Parent = Header.Instance,
					Rotation = 90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(218, 218, 218)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(167, 167, 167))
					}
				})

				Library:Create("Frame", {
					Name = "\0",
					Parent = Header.Instance,
					AnchorPoint = Vector2.new(0, 1),
					Position = UDim2.new(0, 0, 1, 0),
					Size = UDim2.new(1, 0, 0, 1),
					ZIndex = 3,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Outline 1"]
				}):AddToTheme({BackgroundColor3 = 'Outline 1'})

				TextIn(Header.Instance, Title, UDim2.new(0, 7, 0.5, 0), UDim2.new(1, -14, 0, 16), "Text", Enum.TextXAlignment.Left, true).Instance.AnchorPoint = Vector2.new(0, 0.5)

				return Frame
			end

			local Items = { } do
				Items["PlayerList"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Library.Holder.Instance,
					Visible = Params.Visible or false,
					Position = UDim2.fromOffset(340, 150),
					Size = UDim2.fromOffset(340, 370),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Background"]
				}):AddToTheme({BackgroundColor3 = 'Background'})

				for Index, Outline in ipairs({"Outline 1", "Outline 3", "Outline 2", "Outline 4"}) do
					Library:Create("UIStroke", {
						Name = "\0",
						Parent = Items["PlayerList"].Instance,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						LineJoinMode = Enum.LineJoinMode.Miter,
						Color = Library.Theme[Outline],
						BorderOffset = UDim.new(0, Index - 1)
					}):AddToTheme({Color = Outline})
				end

				Items["AccentLine"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["PlayerList"].Instance,
					Size = UDim2.new(1, 0, 0, 1),
					ZIndex = 3,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Accent"]
				}):AddToTheme({BackgroundColor3 = 'Accent'})

				Items["TitleBand"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["PlayerList"].Instance,
					Size = UDim2.new(1, 0, 0, 30),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Console Tab"]
				}):AddToTheme({BackgroundColor3 = 'Console Tab'})

				Library:Create("UIGradient", {
					Name = "\0",
					Parent = Items["TitleBand"].Instance,
					Rotation = 90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(182, 182, 182))
					}
				})

				Library:Create("Frame", {
					Name = "\0",
					Parent = Items["TitleBand"].Instance,
					AnchorPoint = Vector2.new(0, 1),
					Position = UDim2.new(0, 0, 1, 0),
					Size = UDim2.new(1, 0, 0, 1),
					ZIndex = 2,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Outline 3"]
				}):AddToTheme({BackgroundColor3 = 'Outline 3'})

				Items["ActualTitle"] = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.BoldFont,
					TextSize = Library.FontSize,
					Parent = Items["PlayerList"].Instance,
					TextColor3 = Library.Theme["Accent"],
					Text = PlayerList.Name,
					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.new(0, 8, 0, 9),
					Size = UDim2.new(0, 0, 0, 14),
					AutomaticSize = Enum.AutomaticSize.X,
					ZIndex = 2,
					BackgroundTransparency = 1,
					BorderSizePixel = 0
				}):AddToTheme({TextColor3 = 'Accent'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["ActualTitle"].Instance
				})

				Items["PlayerList"]:MakeDraggable()
				Items["PlayerList"]:MakeResizeable(Vector2.new(300, 320))

				Library:RegisterWindow(Items["PlayerList"])

				Items["PlayerBox"] = Box(Items["PlayerList"].Instance, "Player", UDim2.new(0, 8, 0, 38), UDim2.new(1, -16, 1, -196))

				Items["SearchBackground"] = PlatedFrame(Items["PlayerBox"].Instance, {
					Position = UDim2.new(0, 6, 0, 31),
					Size = UDim2.new(1, -12, 0, 20)
				})

				Items["Search"] = Library:Create("TextBox", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["SearchBackground"].Instance,
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 6, 0.5, 0),
					Size = UDim2.new(1, -12, 0, 16),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 3,
					ClearTextOnFocus = false,
					Text = "",
					PlaceholderText = "Search...",
					TextXAlignment = Enum.TextXAlignment.Left,
					PlaceholderColor3 = Library.Theme["Inactive Text"],
					TextColor3 = Library.Theme["Text"]
				}):AddToTheme({TextColor3 = 'Text', PlaceholderColor3 = 'Inactive Text'})

				Items["Columns"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Items["PlayerBox"].Instance,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 6, 0, 55),
					Size = UDim2.new(1, -12, 0, 18)
				})

				TextIn(Items["Columns"].Instance, "Player", UDim2.new(0, 2, 0, 1), UDim2.new(0.45, -4, 0, 16), "Inactive Text")
				TextIn(Items["Columns"].Instance, "Team", UDim2.new(0.45, 0, 0, 1), UDim2.new(0.27, -4, 0, 16), "Inactive Text")
				TextIn(Items["Columns"].Instance, "Priority", UDim2.new(0.72, 0, 0, 1), UDim2.new(0.28, -4, 0, 16), "Inactive Text")

				Library:Create("Frame", {
					Name = "\0",
					Parent = Items["Columns"].Instance,
					AnchorPoint = Vector2.new(0, 1),
					Position = UDim2.new(0, 0, 1, 0),
					Size = UDim2.new(1, 0, 0, 1),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Outline 1"]
				}):AddToTheme({BackgroundColor3 = 'Outline 1'})

				Items["List"] = Library:Create("ScrollingFrame", {
					Name = "\0",
					Parent = Items["PlayerBox"].Instance,
					Active = true,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 6, 0, 75),
					Size = UDim2.new(1, -13, 1, -80),
					BorderSizePixel = 0,
					CanvasSize = UDim2.new(0, 0, 0, 0),
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					ScrollingDirection = Enum.ScrollingDirection.Y,
					ElasticBehavior = Enum.ElasticBehavior.Never,
					ScrollBarThickness = 0
				})

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["List"].Instance,
					Padding = UDim.new(0, 1),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				Library:Scrollbar(Items["List"], {Parent = Items["PlayerBox"], Top = 75, Right = 2, Bottom = 5, Track = true})

				Items["SettingsBox"] = Box(Items["PlayerList"].Instance, "Settings", UDim2.new(0, 8, 1, -150), UDim2.new(1, -16, 0, 142))

				Items["Avatar"] = Library:Create("ImageLabel", {
					Name = "\0",
					Parent = Items["SettingsBox"].Instance,
					Position = UDim2.new(0, 8, 0, 33),
					Size = UDim2.fromOffset(64, 64),
					BorderSizePixel = 0,
					ZIndex = 2,
					Image = "",
					BackgroundColor3 = Library.Theme["Element"]
				}):AddToTheme({BackgroundColor3 = 'Element'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["Avatar"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Items["NameLabel"] = TextIn(Items["SettingsBox"].Instance, "Name: --", UDim2.new(0, 80, 0, 33), UDim2.new(0.5, -80, 0, 16), "Text")
				Items["PriorityLabel"] = TextIn(Items["SettingsBox"].Instance, "Priority: --", UDim2.new(0, 80, 0, 51), UDim2.new(0.5, -80, 0, 16), "Text")
				Items["TeamLabel"] = TextIn(Items["SettingsBox"].Instance, "Team: --", UDim2.new(0, 80, 0, 69), UDim2.new(0.5, -80, 0, 16), "Text")
				Items["UserIdLabel"] = TextIn(Items["SettingsBox"].Instance, "UserId: --", UDim2.new(0, 80, 0, 87), UDim2.new(0.5, -80, 0, 16), "Text")

				TextIn(Items["SettingsBox"].Instance, "priority", UDim2.new(0.55, 0, 0, 33), UDim2.new(0.45, -10, 0, 16), "Inactive Text")

				Items["PriorityDropdown"] = PlatedFrame(Items["SettingsBox"].Instance, {
					Position = UDim2.new(0.55, 0, 0, 51),
					Size = UDim2.new(0.45, -10, 0, 20)
				})

				Items["PriorityText"] = TextIn(Items["PriorityDropdown"].Instance, PlayerList.DefaultPriority, UDim2.new(0, 7, 0.5, 0), UDim2.new(1, -22, 0, 16), "Text")
				Items["PriorityText"].Instance.AnchorPoint = Vector2.new(0, 0.5)

				Items["Arrow"] = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = 8,
					Parent = Items["PriorityDropdown"].Instance,
					RichText = true,
					TextColor3 = Library.Theme["Text"],
					Text = "▼",
					AnchorPoint = Vector2.new(1, 0.5),
					Size = UDim2.new(0, 0, 0, 14),
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundTransparency = 1,
					ZIndex = 3,
					Position = UDim2.new(1, -7, 0.5, 0),
					BorderSizePixel = 0
				}):AddToTheme({TextColor3 = 'Text'})

				Items["Teleport"] = PlatedFrame(Items["SettingsBox"].Instance, {
					Position = UDim2.new(0.55, 0, 0, 79),
					Size = UDim2.new(0.45, -10, 0, 20)
				})

				TextIn(Items["Teleport"].Instance, "Teleport", UDim2.new(0, 0, 0.5, 0), UDim2.new(1, 0, 0, 16), "Text", Enum.TextXAlignment.Center).Instance.AnchorPoint = Vector2.new(0, 0.5)

				Items["Print"] = PlatedFrame(Items["SettingsBox"].Instance, {
					Position = UDim2.new(0.55, 0, 0, 107),
					Size = UDim2.new(0.45, -10, 0, 20)
				})

				TextIn(Items["Print"].Instance, "Print Priorities", UDim2.new(0, 0, 0.5, 0), UDim2.new(1, 0, 0, 16), "Text", Enum.TextXAlignment.Center).Instance.AnchorPoint = Vector2.new(0, 0.5)

				Items["PriorityHolder"] = Library:Create("Frame", {
					Name = "\0",
					Parent = Library.UnusedHolder.Instance,
					Visible = false,
					Size = UDim2.fromOffset(120, 4 + #PlayerList.Priorities * 18),
					ZIndex = Library.ZIndexOrder.OptionHolder + 3,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Content"]
				}):AddToTheme({BackgroundColor3 = 'Content'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Items["PriorityHolder"].Instance,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Miter,
					Color = Library.Theme["Outline 1"]
				}):AddToTheme({Color = 'Outline 1'})

				Library:Create("UIListLayout", {
					Name = "\0",
					Parent = Items["PriorityHolder"].Instance,
					Padding = UDim.new(0, 1),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				Library:Create("UIPadding", {
					Name = "\0",
					Parent = Items["PriorityHolder"].Instance,
					PaddingTop = UDim.new(0, 2),
					PaddingLeft = UDim.new(0, 2),
					PaddingRight = UDim.new(0, 2)
				})

				PlayerList.Items = Items

				Library.PlayerListObject = PlayerList
			end

			local PriorityOpen = false

			local function TeamName(Player)
				local Team = Player.Team

				return Team and Team.Name or "None"
			end

			function PlayerList:GetPriority(Player)
				local Key = typeof(Player) == "Instance" and Player.Name or tostring(Player)

				return PlayerList.Values[Key] or PlayerList.DefaultPriority
			end

			local function UpdateSettings()
				local Player = PlayerList.Selected

				if not Player or not Player.Parent then
					Items["NameLabel"].Instance.Text = "Name: --"
					Items["PriorityLabel"].Instance.Text = "Priority: --"
					Items["TeamLabel"].Instance.Text = "Team: --"
					Items["UserIdLabel"].Instance.Text = "UserId: --"
					Items["PriorityText"].Instance.Text = PlayerList.DefaultPriority
					Items["Avatar"].Instance.Image = ""
					return
				end

				Items["NameLabel"].Instance.Text = "Name: " .. Player.Name
				Items["PriorityLabel"].Instance.Text = "Priority: " .. PlayerList:GetPriority(Player)
				Items["TeamLabel"].Instance.Text = "Team: " .. TeamName(Player)
				Items["UserIdLabel"].Instance.Text = "UserId: " .. tostring(Player.UserId)
				Items["PriorityText"].Instance.Text = PlayerList:GetPriority(Player)

				Library:Thread(function()
					local Success, Content = pcall(function()
						return Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
					end)

					if Success and PlayerList.Selected == Player then
						Items["Avatar"].Instance.Image = Content
					end
				end)
			end

			local function PaintRow(Row)
				local IsSelected = PlayerList.Selected == Row.Player

				Row.Items["Button"].Instance.BackgroundTransparency = IsSelected and 0 or 1
				Row.Items["Name"]:ChangeItemTheme({TextColor3 = IsSelected and "Accent" or "Text"})
				Row.Items["Name"]:Tween({TextColor3 = Library.Theme[IsSelected and "Accent" or "Text"]})
				Row.Items["Team"].Instance.Text = TeamName(Row.Player)
				Row.Items["Priority"].Instance.Text = PlayerList:GetPriority(Row.Player)
			end

			local function PaintRows()
				for _, Row in ipairs(PlayerList.Rows) do
					PaintRow(Row)
				end
			end

			function PlayerList:Select(Player)
				PlayerList.Selected = Player
				PaintRows()
				UpdateSettings()
			end

			function PlayerList:SetPriority(Player, Priority)
				if not Player then
					return
				end

				local Key = typeof(Player) == "Instance" and Player.Name or tostring(Player)
				PlayerList.Values[Key] = Priority

				Flags[PlayerList.Flag] = PlayerList.Values
				PaintRows()
				UpdateSettings()
				Library:SafeCall(PlayerList.Callback, Player, Priority)
			end

			local PriorityDebounce = false

			function PlayerList:SetPriorityOpen(Bool)
				if PriorityDebounce then
					return
				end

				PriorityOpen = Bool
				PriorityDebounce = true

				local Plate = Items["PriorityDropdown"].Instance
				local AnchorX = Plate.AbsolutePosition.X
				local AnchorY = Plate.AbsolutePosition.Y + Plate.AbsoluteSize.Y + GuiInset

				if Bool then
					Items["PriorityHolder"].Instance.Parent = Library.Holder.Instance
					Items["PriorityHolder"].Instance.Size = UDim2.fromOffset(Plate.AbsoluteSize.X, 4 + #PlayerList.Priorities * 18)
					Items["PriorityHolder"].Instance.Position = UDim2.fromOffset(AnchorX, AnchorY)
					Items["PriorityHolder"].Instance.Visible = true

					Items["PriorityHolder"]:Tween({Position = UDim2.fromOffset(AnchorX, AnchorY + 10)})
					Items["PriorityHolder"]:FadeDescendants(true, function()
						PriorityDebounce = false
					end)

					Items["Arrow"]:Tween({Rotation = 180})
				else
					Items["PriorityHolder"]:Tween({Position = UDim2.fromOffset(AnchorX, AnchorY - 10)})
					Items["PriorityHolder"]:FadeDescendants(false, function()
						Items["PriorityHolder"].Instance.Parent = Library.UnusedHolder.Instance
						PriorityDebounce = false
					end)

					Items["Arrow"]:Tween({Rotation = 0})
				end
			end

			function PlayerList:AddRow(Player)
				local Row = {
					Player = Player,
					Items = { }
				}

				Row.Items["Button"] = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["List"].Instance,
					Text = "",
					AutoButtonColor = false,
					Size = UDim2.new(1, 0, 0, 18),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme["Element"]
				}):AddToTheme({BackgroundColor3 = 'Element'})

				Row.Items["Name"] = TextIn(Row.Items["Button"].Instance, Player.Name, UDim2.new(0, 2, 0, 1), UDim2.new(0.45, -4, 0, 16), "Text")
				Row.Items["Team"] = TextIn(Row.Items["Button"].Instance, TeamName(Player), UDim2.new(0.45, 0, 0, 1), UDim2.new(0.27, -4, 0, 16), "Inactive Text")
				Row.Items["Priority"] = TextIn(Row.Items["Button"].Instance, PlayerList:GetPriority(Player), UDim2.new(0.72, 0, 0, 1), UDim2.new(0.28, -4, 0, 16), "Inactive Text")

				Row.Items["Button"]:Connect("MouseButton1Down", function()
					PlayerList:Select(Player)
				end)

				table.insert(PlayerList.Rows, Row)
				PaintRow(Row)

				return Row
			end

			function PlayerList:Refresh()
				for _, Row in ipairs(PlayerList.Rows) do
					Row.Items["Button"].Instance:Destroy()
				end

				PlayerList.Rows = { }

				for _, Player in ipairs(Players:GetPlayers()) do
					if PlayerList.IncludeLocal or Player ~= LocalPlayer then
						PlayerList:AddRow(Player)
					end
				end

				local Query = string.lower(Items["Search"].Instance.Text)

				if Query ~= "" then
					for _, Row in ipairs(PlayerList.Rows) do
						Row.Items["Button"].Instance.Visible = string.find(string.lower(Row.Player.Name), Query, 1, true) ~= nil
					end
				end

				UpdateSettings()
			end

			function PlayerList:SetVisibility(Bool)
				Items["PlayerList"].Instance.Visible = Bool

				if Library.UpdatePlayersIcon then
					Library.UpdatePlayersIcon(Bool)
				end

				if not Bool and PriorityOpen then
					PlayerList:SetPriorityOpen(false)
				end

				if Bool then
					PlayerList:Refresh()
				end
			end

			function PlayerList:Toggle()
				PlayerList:SetVisibility(not Items["PlayerList"].Instance.Visible)
			end

			for Order, Priority in ipairs(PlayerList.Priorities) do
				local Button = Library:Create("TextButton", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Items["PriorityHolder"].Instance,
					Text = "",
					AutoButtonColor = false,
					LayoutOrder = Order,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 17),
					ZIndex = Library.ZIndexOrder.OptionHolder + 4,
					BorderSizePixel = 0
				})

				local Text = Library:Create("TextLabel", {
					Name = "\0",
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					Parent = Button.Instance,
					TextColor3 = Library.Theme["Inactive Text"],
					Text = Priority,
					TextXAlignment = Enum.TextXAlignment.Left,
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 5, 0.5, 0),
					Size = UDim2.new(1, -8, 0, 16),
					ZIndex = Library.ZIndexOrder.OptionHolder + 4,
					BackgroundTransparency = 1,
					BorderSizePixel = 0
				}):AddToTheme({TextColor3 = 'Inactive Text'})

				Library:Create("UIStroke", {
					Name = "\0",
					Parent = Text.Instance
				})

				Button:OnHover(function()
					Text:Tween({TextColor3 = Library.Theme["Text"]})
				end, function()
					Text:Tween({TextColor3 = Library.Theme["Inactive Text"]})
				end)

				Button:Connect("MouseButton1Down", function()
					if PlayerList.Selected then
						PlayerList:SetPriority(PlayerList.Selected, Priority)
					end

					PlayerList:SetPriorityOpen(false)
				end)
			end

			Items["PriorityDropdown"]:Connect("MouseButton1Down", function()
				PlayerList:SetPriorityOpen(not PriorityOpen)
			end)

			Items["Teleport"]:Connect("MouseButton1Down", function()
				local Target = PlayerList.Selected

				if not Target then
					return
				end

				pcall(function()
					local Character = LocalPlayer.Character
					local TargetCharacter = Target.Character

					if Character and TargetCharacter then
						Character:PivotTo(TargetCharacter:GetPivot() * CFrame.new(0, 0, 4))
					end
				end)
			end)

			Items["Print"]:Connect("MouseButton1Down", function()
				for _, Row in ipairs(PlayerList.Rows) do
					print(Row.Player.Name .. ": " .. PlayerList:GetPriority(Row.Player))
				end
			end)

			for _, Plated in ipairs({Items["PriorityDropdown"], Items["Teleport"], Items["Print"]}) do
				Plated:OnHover(function()
					Plated:ChangeItemTheme({BackgroundColor3 = "Hovered Element"})
					Plated:Tween({BackgroundColor3 = Library.Theme["Hovered Element"]})
				end, function()
					Plated:ChangeItemTheme({BackgroundColor3 = "Element"})
					Plated:Tween({BackgroundColor3 = Library.Theme["Element"]})
				end)
			end

			Items["Search"]:Connect("Changed", function(Property)
				if Property ~= "Text" then
					return
				end

				local Query = string.lower(Items["Search"].Instance.Text)

				for _, Row in ipairs(PlayerList.Rows) do
					Row.Items["Button"].Instance.Visible = Query == "" or string.find(string.lower(Row.Player.Name), Query, 1, true) ~= nil
				end
			end)

			Library:Connect(UserInputService.InputEnded, function(Input)
				if Input.UserInputType ~= Enum.UserInputType.MouseButton1 and Input.UserInputType ~= Enum.UserInputType.Touch then
					return
				end

				if PriorityOpen and not Items["PriorityHolder"]:IsMouseOverFrame() and not Items["PriorityDropdown"]:IsMouseOverFrame() then
					PlayerList:SetPriorityOpen(false)
				end
			end)

			Library:Connect(Players.PlayerAdded, function()
				PlayerList:Refresh()
			end)

			Library:Connect(Players.PlayerRemoving, function(Player)
				if PlayerList.Selected == Player then
					PlayerList.Selected = nil
				end

				task.defer(function()
					PlayerList:Refresh()
				end)
			end)

			Flags[PlayerList.Flag] = PlayerList.Values

			SetFlags[PlayerList.Flag] = function(Value)
				if type(Value) == "table" then
					PlayerList.Values = Value
					Flags[PlayerList.Flag] = PlayerList.Values
					PaintRows()
					UpdateSettings()
				end
			end

			PlayerList:Refresh()

			return setmetatable(PlayerList, Library)
		end

		Library.InitSettings = function(Self, Params)
			local TargetWindow = (Params and Params.Pages) and Params or Self
			local SettingsPage = TargetWindow:Page({Name = "Settings"})

			local ConfigsSection = SettingsPage:Section({Name = "Configuration", Side = 1}) do
				local ConfigsDropdown = ConfigsSection:Dropdown({
					Name = "Configs",
					Flag = "configs_dropdown",
					Items = { },
					Multi = false,
					Callback = function(Value)
						ConfigSelected = Value
					end
				})

				local ConfigTextBox = ConfigsSection:Textbox({
					Name = "Config Name:",
					Flag = "config_name",
					Placeholder = "",
					Callback = function(Value)
						ConfigName = Value
					end
				})

				local ButtonGrid = Library:Create("Frame", {
					Name = "\0",
					Parent = ConfigsSection.Items["Content"].Instance,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 46),
					BorderSizePixel = 0
				})

				Library:Create("UIGridLayout", {
					Name = "\0",
					Parent = ButtonGrid.Instance,
					CellSize = UDim2.new(0.5, -2, 0, 22),
					CellPadding = UDim2.new(0, 4, 0, 4),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				local GridParent = {
					Window = SettingsPage.Window,
					Page = SettingsPage,
					Section = ConfigsSection,
					Items = {
						["Content"] = ButtonGrid
					}
				}

				GridParent.Items["Content"].Instance.Name = "\0"

				local SaveButton = Library:Button({
					Name = "Save",
					Parent = GridParent,
					Callback = function()
						if ConfigName then
							if ConfigName == "" then
								return
							end

							writefile(ConfigsFolder .. ConfigName .. ".json", Library:GetConfig())
							Library:GetConfigsList(ConfigsDropdown)

							Library:Notification{Name = "created config succesfully", Time = 3}
						end
					end
				})

				local LoadButton = Library:Button({
					Name = "Load",
					Parent = GridParent,
					Callback = function()
						if ConfigSelected then
							if isfile(ConfigsFolder .. ConfigSelected .. ".json") then
								local ConfigContent = readfile(ConfigsFolder .. ConfigSelected .. ".json")
								local Success, Error = Library:LoadConfig(ConfigContent)

								if Success then
									Library:Notification{Name = "loaded config succesfully", Time = 3}
								else
									Library:Notification{Name = "failed to load config: ".. Error, Time = 3}
								end
							end
						end
					end
				})

				local DeleteButton = Library:Button({
					Name = "Delete",
					Parent = GridParent,
					Callback = function()
						if ConfigSelected then
							if isfile(ConfigsFolder .. ConfigSelected .. ".json") then
								delfile(ConfigsFolder .. ConfigSelected .. ".json")
								Library:GetConfigsList(ConfigsDropdown)

								Library:Notification{Name = "deleted config succesfully", Time = 3}
							end
						end
					end
				})

				local RefreshButton = Library:Button({
					Name = "Refresh",
					Parent = GridParent,
					Callback = function()
						Library:GetConfigsList(ConfigsDropdown)
					end
				})

				Library:GetConfigsList(ConfigsDropdown)
			end

			local ScriptSection = SettingsPage:Section({Name = "Script", Side = 1}) do
				ScriptSection:Button({
					Name = "Unload",
					Tooltip = "unload the script and close the menu",
					Callback = function()
						pcall(function() Library:Exit() end)
					end,
				})
			end

			local MenuSection = SettingsPage:Section({Name = "Menu", Side = 1}) do
				MenuSection:Label({Name = "Menu Bind"}):Keybind({
					Flag = "menu_bind",
					Mode = "Toggle",
					Default = Enum.KeyCode.RightShift,
					Callback = function(Value)
						Library.MenuKeybind = Flags["menu_bind"].Key
					end
				})

				MenuSection:Dropdown({
					Name = "Easing Style",
					Items = {"Linear", "Quad", "Quart", "Back", "Bounce", "Circular", "Cubic", "Elastic", "Exponential", "Sine", "Quint"},
					Default = "Exponential",
					Callback = function(Value)
						Library.Animation.Style = Value
					end
				})

				MenuSection:Dropdown({
					Name = "Easing Direction",
					Items = {"In", "Out", "InOut"},
					Default = "Out",
					Callback = function(Value)
						Library.Animation.Direction = Value
					end
				})

				MenuSection:Slider({
					Name = "Tweening Speed",
					Min = 0,
					Max = 1,
					Default = 0.3,
					Decimals = 0.01,
					Callback = function(Value)
						Library.Animation.Time = Value
					end
				})

				MenuSection:Textbox({
					Name = "Menu Name",
					Flag = "menu_name",
					Placeholder = "",
					Callback = function(Value)
						if Value ~= "" then
							SettingsPage.Window.Items["ActualTitle"].Instance.Text = Value
						end
					end
				})
			end

			local HudSection = SettingsPage:Section({Name = "HUD", Side = 2}) do
				local WatermarkToggle = HudSection:Toggle({
					Name = "Watermark",
					Flag = "hud_watermark",
					Default = true,
					Callback = function(Value)
						if Library.WatermarkObject then
							Library.WatermarkObject:SetVisibility(Value)
						end
					end
				})

				HudSection:Dropdown({
					Name = "Options",
					Flag = "hud_options",
					Items = {"Game", "Status", "Fps", "Ping"},
					Default = {"Game", "Status", "Fps", "Ping"},
					Multi = true,
					Callback = function(Value)
						Library.WatermarkOptions = Value
					end
				})

				HudSection:Slider({
					Name = "Refresh Rate",
					Min = 0.05,
					Max = 2,
					Default = 0.1,
					Decimals = 0.01,
					Suffix = "s",
					Callback = function(Value)
						Library.WatermarkRefreshRate = Value
					end
				})

				HudSection:Toggle({
					Name = "Console",
					Flag = "hud_console",
					Default = true,
					Callback = function(Value)
						if Library.ConsoleObject then
							Library.ConsoleObject:SetVisibility(Value)
						end
					end
				})

				HudSection:Toggle({
					Name = "Keybind List",
					Flag = "hud_keybindlist",
					Default = true,
					Callback = function(Value)
						if Library.KeyList then
							Library.KeyList:SetVisibility(Value)
						end
					end
				})
			end

			local ThemingSection = SettingsPage:Section({Name = "Theming", Side = 2}) do
				for Index, Value in Library.Theme do
					ThemingSection:Label({Name = Index}):Colorpicker({
						Name = Index,
						Flag = Index,
						Default = Value,
						Callback = function(Value)
							Library.Theme[Index] = Value
							Library:ChangeTheme(Index, Value)
						end
					})
				end

				ThemingSection:Dropdown({
					Name = "Preset",
					Flag = "theme_preset",
					Items = Library.PresetOrder,
					Default = Library.CurrentTheme or "Vitality",
					Callback = function(Value)
						Library:SetTheme(Value)
					end
				})

				local ThemesDropdown = ThemingSection:Dropdown({
					Name = "Themes",
					Flag = "themes_dropdown",
					Items = { },
					Multi = false,
					Callback = function(Value)
						ThemeSelected = Value
					end
				})

				local ThemeTextBox = ThemingSection:Textbox({
					Name = "Theme Name:",
					Flag = "theme_name",
					Placeholder = "Theme name here...",
					Callback = function(Value)
						ThemeName = Value
					end
				})

				local ThemeGrid = Library:Create("Frame", {
					Name = "\0",
					Parent = ThemingSection.Items["Content"].Instance,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 46),
					BorderSizePixel = 0
				})

				Library:Create("UIGridLayout", {
					Name = "\0",
					Parent = ThemeGrid.Instance,
					CellSize = UDim2.new(0.5, -2, 0, 22),
					CellPadding = UDim2.new(0, 4, 0, 4),
					SortOrder = Enum.SortOrder.LayoutOrder
				})

				local ThemeGridParent = {
					Window = SettingsPage.Window,
					Page = SettingsPage,
					Section = ThemingSection,
					Items = {
						["Content"] = ThemeGrid
					}
				}

				ThemeGridParent.Items["Content"].Instance.Name = "\0"

				Library:Button({
					Name = "Save",
					Parent = ThemeGridParent,
					Callback = function()
						if ThemeName and ThemeName ~= "" then
							local ThemeSave = { }

							for ThemeIndex, ThemeValue in Library.Theme do
								ThemeSave[ThemeIndex] = "#" .. ThemeValue:ToHex()
							end

							writefile(Library.Directory .. Library.Folders.Themes .. "/" .. ThemeName .. ".json", HttpService:JSONEncode(ThemeSave))
							Library:GetThemesList(ThemesDropdown)

							Library:Notification{Name = "saved theme succesfully", Time = 3}
						end
					end
				})

				Library:Button({
					Name = "Load",
					Parent = ThemeGridParent,
					Callback = function()
						if ThemeSelected then
							if isfile(Library.Directory .. Library.Folders.Themes .. "/" .. ThemeSelected .. ".json") then
								local Success, Error = Library:SafeCall(function()
									local Decoded = HttpService:JSONDecode(readfile(Library.Directory .. Library.Folders.Themes .. "/" .. ThemeSelected .. ".json"))

									for ThemeIndex, ThemeValue in Decoded do
										if Library.Theme[ThemeIndex] then
											local Color = Color3.fromHex(ThemeValue)
											Library.Theme[ThemeIndex] = Color
											Library:ChangeTheme(ThemeIndex, Color)
											SetFlags[ThemeIndex](Color)
										end
									end
								end)

								if Success then
									Library:Notification{Name = "loaded theme succesfully", Time = 3}
								else
									Library:Notification{Name = "failed to load theme: ".. Error, Time = 3}
								end
							end
						end
					end
				})

				Library:Button({
					Name = "Delete",
					Parent = ThemeGridParent,
					Callback = function()
						if ThemeSelected then
							if isfile(Library.Directory .. Library.Folders.Themes .. "/" .. ThemeSelected .. ".json") then
								delfile(Library.Directory .. Library.Folders.Themes .. "/" .. ThemeSelected .. ".json")
								Library:GetThemesList(ThemesDropdown)

								Library:Notification{Name = "deleted theme succesfully", Time = 3}
							end
						end
					end
				})

				Library:Button({
					Name = "Refresh",
					Parent = ThemeGridParent,
					Callback = function()
						Library:GetThemesList(ThemesDropdown)
					end
				})

				Library:GetThemesList(ThemesDropdown)
			end

			return SettingsPage
		end

	end
end

			-- ================================================================
			-- Alpine presentation layer
			--
			-- Geometry is transcribed from apremake/src/ui:
			--   menu.cpp   window chrome, header, tabs, panel rectangles
			--   theme.h    metric::* constants
			--   draw.cpp   borders, accent rows, gradients, text placement
			--
			-- All coordinates are window-relative: the C++ reference origin is
			-- (ref_x, ref_y) = (4, 5), so every C++ absolute coordinate has 4 / 5
			-- subtracted and every inclusive bottom becomes a pixel size.
			-- One GDI pixel is one Roblox pixel. Nothing here is scaled.
			-- ================================================================

			-- this module is appended after Vitality's do-block, so the service
			-- locals it used are out of scope here
			local UserInputService = game:GetService("UserInputService")
			local RunService = game:GetService("RunService")
			local TweenService = game:GetService("TweenService")

			-- menu.cpp listens for VK_INSERT; Vitality's default is X. The menu
			-- notification and the C++ reference both advertise Insert, so make
			-- the actual bind agree with them.
			Library.MenuKeybind = tostring(Enum.KeyCode.Insert)

			local Alpine = { }
			Library.Alpine = Alpine

			Alpine.Metric = {
				WindowWidth = 644,
				WindowHeight = 668,

				DragHeight = 33,

				HeaderX = { 7, 151, 495 },
				HeaderWidth = { 140, 340, 142 },
				HeaderY = 7,
				HeaderHeight = 22,
				HeaderRow = 12,
				LogoX = 52,
				LogoY = 13,

				TabX = 13,
				TabY = 39,
				TabWidth = 618,
				TabHeight = 24,
				TabCellX = 14,
				TabCellY = 42,
				TabCellHeight = 20,
				TabCellWidth = { 123, 123, 123, 123, 124 },
				TabTextY = 52,

				ContentX = 13,
				ContentY = 67,
				ContentWidth = 618,
				ContentHeight = 588,
				PageInset = 2,

				ColumnGap = 4,
				ColumnLeft = 4,
				ColumnRight = 309,
				ColumnWidth = 301,
				ColumnTop = 4,

				PanelHeader = 25,
				PanelContentX = 6,
				PanelContentY = 19,
				PanelContentWidth = 289,
				PanelTopPad = 6,
				TitleOffset = 11,
				TitleIndent = 6,

				ToggleAdvance = 14,
				DropdownAdvance = 33,
				SliderAdvance = 27,

				CheckboxSize = 10,
				CheckboxLabel = 14,
				CheckboxOffset = -5,

				WidgetOffset = 8,
				SliderHeight = 10,
				ComboHeight = 16,
				ComboAdvance = 33,
				ComboTextIndent = 4,

				KeybindWidth = 32,
				KeybindHeight = 12,
				KeybindOffset = -6,
				SwatchWidth = 22,
				SwatchHeight = 10,
				SwatchOffset = -5,
				InlineGap = 4,
				SwatchGap = 6,

				DropdownItem = 15,
				ExpandSize = 11,
			}

			local M = Alpine.Metric

			local function RGB(R, G, B)
				return Color3.fromRGB(R, G, B)
			end

			Alpine.Color = {
				Black = RGB(0, 0, 0),
				WindowBand = RGB(22, 21, 22),
				OverlayBand = RGB(19, 19, 20),
				WindowEdge = RGB(70, 63, 73),
				EdgeGlow = RGB(128, 115, 132),

				Backdrop = RGB(15, 15, 15),
				Content = RGB(16, 16, 16),
				FrameLight = RGB(31, 33, 32),

				HeaderBorderTop = RGB(39, 35, 40),
				HeaderBorderGlow = RGB(55, 47, 53),
				HeaderAccentTop = RGB(59, 53, 61),
				HeaderAccentTopGlow = RGB(214, 211, 218),
				HeaderAccentBottom = RGB(48, 43, 50),
				HeaderAccentBottomGlow = RGB(205, 201, 208),
				HeaderFill = RGB(28, 25, 29),
				HeaderFillGlow = RGB(43, 41, 44),
				HeaderGradTop = RGB(26, 27, 29),
				HeaderGradBottom = RGB(16, 18, 17),

				PanelBorderTop = RGB(42, 38, 44),
				PanelBorderGlow = RGB(53, 50, 57),
				PanelAccentTop = RGB(59, 53, 61),
				PanelAccentTopGlow = RGB(214, 211, 218),
				PanelAccentBottom = RGB(48, 43, 50),
				PanelAccentBottomGlow = RGB(205, 201, 208),
				PanelFillGlow = RGB(39, 36, 41),
				PanelLight = RGB(32, 34, 33),
				PanelFill = RGB(13, 16, 15),
				FrameFill = RGB(19, 21, 21),
				TopBarTop = RGB(21, 22, 23),
				TopBarBottom = RGB(15, 17, 16),
				TextActive = RGB(118, 106, 122),
				TextSeparator = RGB(60, 61, 61),
				HealthTop = RGB(73, 56, 79),
				HealthBottom = RGB(52, 44, 55),
				HealthAccent = RGB(72, 56, 78),
				HealthShade = RGB(62, 48, 68),
				HealthLight = RGB(36, 30, 37),

				TabAccentTop = RGB(56, 50, 58),
				TabAccentTopGlow = RGB(212, 212, 214),
				TabAccentBottom = RGB(51, 46, 53),
				TabAccentBottomGlow = RGB(200, 200, 202),
				TabFillTop = RGB(17, 19, 18),
				TabFillBottom = RGB(15, 17, 16),
				TabHoverTop = RGB(25, 28, 27),
				TabHoverText = RGB(173, 175, 175),
				TabSelectedText = RGB(65, 64, 66),

				Text = RGB(246, 248, 248),
				TextDim = RGB(134, 136, 135),
				TextMessage = RGB(199, 201, 201),
				TextTitle = RGB(205, 207, 207),
				TextTarget = RGB(104, 116, 142),

				InputTop = RGB(27, 30, 29),
				InputBottom = RGB(19, 21, 21),
				InputHoverTop = RGB(33, 37, 35),
				InputHoverBottom = RGB(23, 25, 25),

				CheckboxTop = RGB(24, 26, 26),
				CheckboxBottom = RGB(15, 17, 17),
				CheckedTop = RGB(56, 57, 61),
				CheckedBottom = RGB(43, 44, 48),

				TrackTop = RGB(27, 30, 29),
				TrackHoverTop = RGB(31, 34, 33),
				TrackBottom = RGB(16, 18, 18),
				FillTop = RGB(66, 51, 72),
				FillHoverTop = RGB(62, 53, 68),
				FillBottom = RGB(50, 42, 52),
			}

			local C = Alpine.Color

			-- Base overlays that stay on Vitality's renderer (notifications, console,
			-- watermark) read Library.Theme; point those slots at the same palette so
			-- nothing on screen keeps the old purple defaults.
			for Key, Value in {
				Background = C.Content,
				Inline = C.HeaderGradTop,
				Content = C.Backdrop,
				Text = C.Text,
				["Outline 1"] = C.FrameLight,
				["Outline 2"] = C.Content,
				["Outline 3"] = C.FrameFill,
				["Outline 4"] = C.Black,
				["Inactive Text"] = C.TextDim,
				Accent = RGB(118, 106, 122),
				["Hovered Element"] = C.InputTop,
				["Slider Track"] = C.TrackTop,
				["Section Box"] = C.Content,
				["Console Body"] = C.PanelFill,
				["Console Tab"] = C.HeaderGradTop,
				Element = C.InputTop,
			} do
				Library.Theme[Key] = Value
			end

			local function Make(Class, Properties)
				local Parent = Properties.Parent

				if type(Parent) == "table" and Parent.Instance then
					Parent = Parent.Instance
					Properties.Parent = Parent
				end

				local Object = Library:Create(Class, Properties)

				-- floating layers (a toggle's Settings panel) live above the
				-- section they overlap; bump every child it owns
				if Object.Instance:IsA("GuiObject") then
					local Ancestor = Parent

					while Ancestor do
						local Layer = Ancestor:GetAttribute("AlpineLayer")

						if Layer then
							Object.Instance.ZIndex += Layer
							break
						end

						Ancestor = Ancestor.Parent
					end
				end

				return Object
			end

			local function Frame(Parent, X, Y, W, H, Color, Transparency, ZIndex)
				return Make("Frame", {
					Parent = Parent,
					Position = UDim2.fromOffset(X, Y),
					Size = UDim2.fromOffset(W, H),
					BackgroundColor3 = Color or C.Black,
					BackgroundTransparency = Transparency or 0,
					BorderSizePixel = 0,
					ZIndex = ZIndex or 1,
				})
			end

			local function Fill(Parent, X, Y, W, H, Color, ZIndex)
				return Frame(Parent, X, Y, W, H, Color, 0, ZIndex or 1)
			end

			local function Gradient(Object, Top, Bottom, Rotation)
				return Make("UIGradient", {
					Parent = Object,
					Rotation = Rotation or 90,
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Top),
						ColorSequenceKeypoint.new(1, Bottom),
					}),
				})
			end

			local function Label(Parent, X, CenterY, Width, Text, Color, Align, ZIndex)
				-- CenterY is a C++ text baseline, not the centre of the label box.
				-- VerdanaPixel at 12px has an 8px cap, so its visual centre sits
				-- about three pixels above the baseline.
				return Make("TextLabel", {
					Parent = Parent,
					Position = UDim2.fromOffset(X, CenterY - 11),
					Size = UDim2.fromOffset(Width, 16),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Text = tostring(Text or ""),
					TextColor3 = Color or C.Text,
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					TextXAlignment = Align or Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Center,
					TextScaled = false,
					TextWrapped = false,
					TextStrokeTransparency = 1,
					TextTruncate = Enum.TextTruncate.AtEnd,
					RichText = false,
					ZIndex = ZIndex or 2,
				})
			end

			-- draw::accent: a base-colour bar with a moving shine peak. The C++
			-- renderer sweeps a 2*spread highlight across the bar every 4.5s; the
			-- same motion is one tweened gradient band here. Radius nil uses 12%
			-- of the bar width, matching draw::accent without an explicit radius.
			local function Shine(Parent, X, Y, Width, Height, Base, Peak, ZIndex, Radius)
				local Z = ZIndex or 2
				local Row = Frame(Parent, X, Y, Width, Height, C.Black, 1, Z)
				Row.Instance.BackgroundTransparency = 1
				Row.Instance.ClipsDescendants = true

				Fill(Row, 0, 0, Width, Height, Base, Z + 1)

				local Spread = Radius or math.max(4, math.floor(Width * 0.12))
				local BandWidth = Spread * 2
				local Band = Frame(Row, -BandWidth, 0, BandWidth, Height, Peak, 0, Z + 2)
				local Lower = Base:Lerp(Peak, 0.15625)

				Make("UIGradient", {
					Parent = Band.Instance,
					Rotation = 0,
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Base),
						ColorSequenceKeypoint.new(0.25, Lower),
						ColorSequenceKeypoint.new(0.5, Peak),
						ColorSequenceKeypoint.new(0.75, Lower),
						ColorSequenceKeypoint.new(1, Base),
					}),
				})

				local Tween = TweenService:Create(Band.Instance,
					TweenInfo.new(4.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false, 0),
					{ Position = UDim2.fromOffset(Width, 0) })
				Tween:Play()

				return Row
			end

			Alpine.Make = Make
			Alpine.Frame = Frame
			Alpine.Fill = Fill
			Alpine.Gradient = Gradient
			Alpine.Label = Label
			Alpine.Shine = Shine

			local LogoMask = {
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
			}

			local Flags = Library.Flags
			local SetFlags = Library.SetFlags

			Alpine.Flags = Flags

			-- The presentation layer is z-layered relative to its parents (window
			-- chrome 0..2, content 1, tabs 2, header 3, rows 4, labels 5..7,
			-- popups 500). ScreenGuis are Global by default, where a child at z0
			-- would sort behind the window background and vanish. The window's
			-- own layer is switched to Sibling when it is registered below.

			local function HeaderBox(Parent, X, Y, Width, Height)
				Fill(Parent, X, Y, Width, Height, C.Black, 3)
				Fill(Parent, X + 1, Y + 1, Width - 2, Height - 2, C.FrameLight, 4)

				Shine(Parent, X + 2, Y + 1, Width - 4, 1, C.HeaderBorderTop, C.HeaderBorderGlow, 5)
				Shine(Parent, X + 2, Y + 2, Width - 4, 1, C.HeaderAccentTop, C.HeaderAccentTopGlow, 5)
				Shine(Parent, X + 2, Y + 3, Width - 4, 1, C.HeaderAccentBottom, C.HeaderAccentBottomGlow, 5)
				Shine(Parent, X + 2, Y + 4, Width - 4, 1, C.HeaderFill, C.HeaderFillGlow, 5)

				local Body = Fill(Parent, X + 2, Y + 5, Width - 4, Height - 7, C.HeaderGradTop, 4)
				Gradient(Body, C.HeaderGradTop, C.HeaderGradBottom)
			end

			-- ----------------------------------------------------------------
			-- window shell
			-- ----------------------------------------------------------------
			Library.Window = function(Self, Params)
				Params = Params or { }

				local Window = {
					Name = Params.Name or Params.name or "Window",
					UserName = Params.UserName or Params.username or "dbxlll",
					BuildDate = Params.BuildDate or Params.builddate or "hello",
					BuildType = Params.BuildType or Params.buildtype or "wow man",

					IsOpen = true,
					Pages = { },
					Items = { },
				}

				local Items = { }
				Window.Items = Items

				local Main = Frame(Library.Holder.Instance, 0, 0, M.WindowWidth, M.WindowHeight, C.Black)
				Main.Instance.Name = "\0"
				-- A top-left anchored window makes the first drag exact. With the
				-- old half-anchor the first drag read Position.Offset (zero) instead
				-- of the real centre and teleported the window away.
				Main.Instance.AnchorPoint = Vector2.new(0, 0)

				local StartScreen = Library.Holder.Instance.AbsoluteSize

				if not StartScreen or StartScreen.X <= 0 or StartScreen.Y <= 0 then
					StartScreen = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize
						or Vector2.new(1920, 1080)
				end
				Main.Instance.Position = UDim2.fromOffset(
					math.floor((StartScreen.X - M.WindowWidth) * 0.5),
					math.floor((StartScreen.Y - M.WindowHeight) * 0.5)
				)
				-- draw::edge_glow: five 1px rings just outside the window, edge_glow
				-- colour at 2.17x accent, alphas {70,40,22,11,5} * menu_glow 0.5
				local GlowColor = RGB(128, 115, 132)
				local GlowAlpha = { 70, 40, 22, 11, 5 }

				for Ring = 1, 5 do
					local Spread = Ring
					local Transparency = 1 - (GlowAlpha[Ring] / 255) * 0.5

					Frame(Main, -Spread, -Spread, M.WindowWidth + Spread * 2, 1, GlowColor, Transparency, 0)
					Frame(Main, -Spread, M.WindowHeight + Spread - 1, M.WindowWidth + Spread * 2, 1, GlowColor, Transparency, 0)
					Frame(Main, -Spread, -Spread + 1, 1, M.WindowHeight + Spread * 2 - 2, GlowColor, Transparency, 0)
					Frame(Main, M.WindowWidth + Spread - 1, -Spread + 1, 1, M.WindowHeight + Spread * 2 - 2, GlowColor, Transparency, 0)
				end

				local Layer = Library:RegisterWindow(Main)

				-- RegisterWindow puts the window on a fresh ScreenGui, which is
				-- Global by default; the Alpine layer is z-layered per parent.
				if Layer and Layer.Instance then
					Layer.Instance.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				end

				Items["MainFrame"] = Main

				-- draw::window
				Fill(Main, 1, 1, M.WindowWidth - 2, M.WindowHeight - 2, C.WindowEdge, 0)
				Fill(Main, 2, 2, M.WindowWidth - 4, M.WindowHeight - 4, C.Black, 0)
				Fill(Main, 3, 3, M.WindowWidth - 6, M.WindowHeight - 6, C.WindowBand, 0)

				Shine(Main, 6, 5, M.WindowWidth - 12, 1, C.HeaderAccentTop, C.HeaderAccentTopGlow, 1)
				Shine(Main, 6, 6, M.WindowWidth - 12, 1, C.HeaderAccentBottom, C.HeaderAccentBottomGlow, 1)

				-- backdrop framed rect (7..636, 33..660)
				Fill(Main, 7, 33, 630, 628, C.Black, 0)
				Fill(Main, 8, 34, 628, 626, C.FrameLight, 0)
				Fill(Main, 9, 35, 626, 624, C.Backdrop, 0)

				-- content framed rect (13,67) 618x588
				local Content = Fill(Main, M.ContentX, M.ContentY, M.ContentWidth, M.ContentHeight, C.Black, 1)
				Fill(Content, 1, 1, M.ContentWidth - 2, M.ContentHeight - 2, C.FrameLight, 1)
				Fill(Content, 2, 2, M.ContentWidth - 4, M.ContentHeight - 4, C.Content, 1)
				Items["Content"] = Content

				-- header
				local Title = Frame(Main, 0, 0, M.WindowWidth, M.DragHeight, C.Black, 1, 3)
				Items["Title"] = Title

				-- menu.cpp drag area: the full 33px header strip, nothing below it
				local DragButton = Make("TextButton", {
					Parent = Title.Instance,
					Size = UDim2.fromOffset(M.WindowWidth, M.DragHeight),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Text = "",
					AutoButtonColor = false,
					ZIndex = 7,
				})

				local Dragging = false
				local DragStart, StartPosition

				DragButton:Connect("InputBegan", function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
						Dragging = true
						DragStart = Input.Position
						StartPosition = Main.Instance.AbsolutePosition
					end
				end)

				Library:Connect(UserInputService.InputChanged, function(Input)
					if not Dragging then
						return
					end

					if Input.UserInputType ~= Enum.UserInputType.MouseMovement and Input.UserInputType ~= Enum.UserInputType.Touch then
						return
					end

					local Delta = Input.Position - DragStart
					local Screen = Main.Instance.Parent.AbsoluteSize

					Main.Instance.Position = UDim2.fromOffset(
						math.clamp(StartPosition.X + Delta.X, 0, math.max(0, Screen.X - M.WindowWidth)),
						math.clamp(StartPosition.Y + Delta.Y, 0, math.max(0, Screen.Y - M.WindowHeight))
					)
				end)

				Library:Connect(UserInputService.InputEnded, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
						Dragging = false
					end
				end)

				HeaderBox(Title, M.HeaderX[1], M.HeaderY, M.HeaderWidth[1], M.HeaderHeight)
				HeaderBox(Title, M.HeaderX[2], M.HeaderY, M.HeaderWidth[2], M.HeaderHeight)
				HeaderBox(Title, M.HeaderX[3], M.HeaderY, M.HeaderWidth[3], M.HeaderHeight)

				-- draw::mask: all outline pixels first, then all fill pixels
				for RowIndex, Row in ipairs(LogoMask) do
					for Column = 1, #Row do
						if string.sub(Row, Column, Column) == "#" then
							Fill(Title, M.LogoX + Column - 2, M.LogoY + RowIndex - 2, 3, 3, C.Black, 6)
						end
					end
				end

				for RowIndex, Row in ipairs(LogoMask) do
					for Column = 1, #Row do
						if string.sub(Row, Column, Column) == "#" then
							Fill(Title, M.LogoX + Column - 1, M.LogoY + RowIndex - 1, 1, 1, C.Text, 6)
						end
					end
				end

				Label(Title, M.HeaderX[2], M.HeaderY + M.HeaderRow, M.HeaderWidth[2],
					Window.UserName .. " | " .. Window.BuildDate, C.Text, Enum.TextXAlignment.Center, 6)
				Label(Title, M.HeaderX[3], M.HeaderY + M.HeaderRow, M.HeaderWidth[3],
					Window.BuildType, C.Text, Enum.TextXAlignment.Center, 6)

				local Actual = Frame(Title, 0, 0, 1, 1, C.Black, 1, 1)
				Actual.Instance.Visible = false
				Items["ActualTitle"] = Actual

				local IconBar = Frame(Main, 0, 0, 1, 1, C.Black, 1, 1)
				IconBar.Instance.Visible = false
				Items["IconBar"] = IconBar

				-- tab bar (13,39) 618x24
				local Pages = Fill(Main, M.TabX, M.TabY, M.TabWidth, M.TabHeight, C.Black, 2)
				Shine(Pages, 1, 1, M.TabWidth - 2, 1, C.TabAccentTop, C.TabAccentTopGlow, 2)
				Shine(Pages, 1, 2, M.TabWidth - 2, 1, C.TabAccentBottom, C.TabAccentBottomGlow, 2)
				Items["Pages"] = Pages

				-- page viewport inside the content frame. This is a plain clipping
				-- frame: each page owns the single ScrollingFrame, so there is no
				-- outer scroll region whose CanvasSize could clip the page away.
				local Viewport = Make("Frame", {
					Parent = Content.Instance,
					Position = UDim2.fromOffset(M.PageInset, M.PageInset),
					Size = UDim2.fromOffset(M.ContentWidth - M.PageInset * 2, M.ContentHeight - M.PageInset * 2),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					ZIndex = 2,
				})
				Items["Viewport"] = Viewport
				Window.Viewport = Viewport

				function Window:RefreshCanvas()
					-- each page owns its own ScrollingFrame and drives its own
					-- CanvasSize; the viewport is only a fixed clipping frame
				end

				function Window:SetOpen(Bool)
					Window.IsOpen = Bool
					Main.Instance.Visible = Bool

					if Alpine.OnWindowToggle then
						Alpine.OnWindowToggle(Bool)
					end

					if not Bool then
						-- popups live on the Holder ScreenGui, not inside Main, so
						-- hiding the window must dismiss them explicitly.
						if Alpine.ClosePopup then
							Alpine.ClosePopup()
						end

						if Alpine.CloseSettings then
							Alpine.CloseSettings()
						end
					end

					for _, Value in Library.OpenFrames do
						Value:SetOpen(false)
					end
				end

				function Window:Center()
					local Screen = Main.Instance.Parent.AbsoluteSize

					Main.Instance.AnchorPoint = Vector2.new(0, 0)
					Main.Instance.Position = UDim2.fromOffset(
						math.floor((Screen.X - M.WindowWidth) * 0.5),
						math.floor((Screen.Y - M.WindowHeight) * 0.5)
					)
				end

				function Window:InitSettings()
					return Library.InitSettings(Window)
				end

				Library:Connect(UserInputService.InputBegan, function(Input)
					if tostring(Input.KeyCode) ~= Library.MenuKeybind and tostring(Input.UserInputType) ~= Library.MenuKeybind then
						return
					end

					if UserInputService:GetFocusedTextBox() then
						return
					end

					Window:SetOpen(not Window.IsOpen)
				end)

				if Alpine.SetupOverlay then
					Alpine.SetupOverlay(Window)
				end

				return setmetatable(Window, Library)
			end

			-- ----------------------------------------------------------------
			-- pages / tabs
			-- ----------------------------------------------------------------
			Library.Page = function(Self, Params)
				Params = Params or { }

				local Page = {
					Name = Params.Name or Params.name or "Page",
					Window = Self,
					ColumnsData = { },
					Items = { },
					Active = false,
				}

				local Index = #Self.Pages + 1
				local CellX = M.TabCellX

				for I = 1, Index - 1 do
					CellX += M.TabCellWidth[I] or 123
				end

				local Width = M.TabCellWidth[Index] or 123

				local Tab = Make("TextButton", {
					Name = "\0",
					Parent = Self.Items["Pages"].Instance,
					Position = UDim2.fromOffset(CellX - M.TabX, M.TabCellY - M.TabY),
					Size = UDim2.fromOffset(Width, M.TabCellHeight),
					BackgroundColor3 = C.TabFillTop,
					BackgroundTransparency = 0,
					BorderSizePixel = 0,
					Text = "",
					AutoButtonColor = false,
					ZIndex = 3,
				})

				local Shade = Gradient(Tab, C.TabFillTop, C.TabFillBottom)

				if Index > 1 then
					Fill(Tab, 0, 0, 1, M.TabCellHeight, C.Black, 4)
				end

				local TabLabel = Label(Tab, Index > 1 and 1 or 0, M.TabTextY - M.TabCellY,
					Width - (Index > 1 and 1 or 0), Page.Name, C.TextDim, Enum.TextXAlignment.Center, 4)

				Page.Items["Inactive"] = Tab
				Page.Items["Text"] = TabLabel
				Page.Items["Shade"] = Shade

				-- A plain clipped Frame, not a ScrollingFrame. The old page used a
				-- ScrollingFrame with a CanvasSize that was repeatedly reset to a
				-- zero width by Roblox's layout pass, which clipped every panel in
				-- game. This frame owns no canvas at all; the columns are moved
				-- vertically for scrolling, so there is nothing to clip them away.
				local PageFrame = Make("Frame", {
					Parent = Self.Items["Viewport"].Instance,
					Position = UDim2.fromOffset(0, 0),
					Size = UDim2.fromOffset(M.ContentWidth - M.PageInset * 2, M.ContentHeight - M.PageInset * 2),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Visible = (#Self.Pages == 0),
					ZIndex = 4,
				})
				Page.Items["Page"] = PageFrame

				Page.Scroll = 0
				Page.ScrollTarget = 0
				Page.ContentHeight = M.ContentHeight - M.PageInset * 2

				local Scrollbar = Frame(Self.Items["Viewport"], 0, 0, 2, 20, C.FillTop, 0, 5)
				Scrollbar.Instance.Visible = false
				Page.Items["Scrollbar"] = Scrollbar

				function Page:UpdateScrollbar()
					local View = PageFrame.Instance.AbsoluteSize.Y
					local Range = (Page.ContentHeight or View) - View

					if Range <= 1 or View <= 0 or not Page.Active then
						Scrollbar.Instance.Visible = false
						return
					end

					local Track = math.max(12, math.floor(View * View / (View + Range)))
					local Scroll = math.clamp(Page.Scroll or 0, 0, Range)
					local Top = 2 + math.floor((View - Track) * (Scroll / Range) + 0.5)

					Scrollbar.Instance.Position = UDim2.fromOffset(PageFrame.Instance.AbsoluteSize.X - 2, Top)
					Scrollbar.Instance.Size = UDim2.fromOffset(2, Track)
					Scrollbar.Instance.Visible = true
				end

				local function Column(X)
					local Holder = Frame(PageFrame, X, 0, M.ColumnWidth, M.ContentHeight - M.PageInset * 2, C.Black, 1)
					Holder.Instance.BackgroundTransparency = 1
					Make("UIPadding", {
						Parent = Holder.Instance,
						PaddingTop = UDim.new(0, M.ColumnTop),
						PaddingBottom = UDim.new(0, 6),
					})
					Make("UIListLayout", {
						Parent = Holder.Instance,
						Padding = UDim.new(0, M.ColumnGap),
						SortOrder = Enum.SortOrder.LayoutOrder,
					})

					return Holder
				end

				local Left = Column(M.ColumnLeft)
				local Right = Column(M.ColumnRight)

				Page.Items["LeftColumn"] = Left
				Page.Items["RightColumn"] = Right
				Page.ColumnsData[1] = Left
				Page.ColumnsData[2] = Right
				Self.Items["Column1"] = Left
				Self.Items["Column2"] = Right

				local ColumnHeights = { 0, 0 }

				function Page:ApplyScroll()
					local View = PageFrame.Instance.AbsoluteSize.Y
					local Range = math.max(0, (Page.ContentHeight or View) - View)

					Page.ScrollTarget = math.clamp(Page.ScrollTarget or 0, 0, Range)
					Page.Scroll = math.clamp(Page.Scroll or 0, 0, Range)

					local Offset = -math.floor(Page.Scroll)

					Left.Instance.Position = UDim2.fromOffset(M.ColumnLeft, Offset)
					Right.Instance.Position = UDim2.fromOffset(M.ColumnRight, Offset)
					Page:UpdateScrollbar()
				end

				function Page:RefreshScrollBounds()
					local PageHeight = M.ContentHeight - M.PageInset * 2
					Page.ContentHeight = math.max(PageHeight,
						ColumnHeights[1] + M.ColumnTop + 6,
						ColumnHeights[2] + M.ColumnTop + 6)

					Page:ApplyScroll()
					Self:RefreshCanvas()
				end

				for ColumnIndex, ColumnFrame in ipairs({ Left, Right }) do
					local Layout = ColumnFrame.Instance:FindFirstChildOfClass("UIListLayout")

					Library:Connect(Layout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
						ColumnHeights[ColumnIndex] = Layout.AbsoluteContentSize.Y
						Page:RefreshScrollBounds()
					end)
				end

				-- custom scrollbar: C++ scroll_step=40 and approach speed=16. The
				-- columns themselves move; no ScrollingFrame canvas is involved.
				Library:Connect(UserInputService.InputChanged, function(Input)
					if not Page.Active or Input.UserInputType ~= Enum.UserInputType.MouseWheel then
						return
					end

					local MousePos = UserInputService:GetMouseLocation()
					local Pos = PageFrame.Instance.AbsolutePosition
					local Size = PageFrame.Instance.AbsoluteSize

					if MousePos.X < Pos.X or MousePos.Y < Pos.Y or MousePos.X > Pos.X + Size.X or MousePos.Y > Pos.Y + Size.Y then
						return
					end

					local Range = math.max(0, (Page.ContentHeight or Size.Y) - Size.Y)
					Page.ScrollTarget = math.clamp((Page.ScrollTarget or 0) - (Input.Position.Z or 0) * 40, 0, Range)
				end)

				Library:Connect(RunService.Heartbeat, function(Delta)
					if not Page.Active then
						return
					end

					local View = PageFrame.Instance.AbsoluteSize.Y
					local Range = math.max(0, (Page.ContentHeight or View) - View)
					Page.ScrollTarget = math.clamp(Page.ScrollTarget or 0, 0, Range)

					local Difference = (Page.ScrollTarget or 0) - (Page.Scroll or 0)

					if math.abs(Difference) > 0.05 then
						Page.Scroll = (Page.Scroll or 0) + Difference * math.min(1, Delta * 16)
						Page:ApplyScroll()
					elseif Page.Scroll ~= Page.ScrollTarget then
						Page.Scroll = Page.ScrollTarget
						Page:ApplyScroll()
					end
				end)

				function Page:SetSelected(Bool)
					Page.Active = Bool

					-- menu.cpp: selection only moves the text colour; the cell fill stays
					-- the tab gradient and never turns into an accent block. A selected
					-- tab also drops the hover tint (hover is gated on !selected).
					TabLabel.Instance.TextColor3 = Bool and C.TabSelectedText or C.TextDim

					if Bool then
						Shade.Instance.Color = ColorSequence.new(C.TabFillTop, C.TabFillBottom)
					else
						Page:UpdateScrollbar()
					end
				end

				function Page:Turn()
					local Old = Self.Current

					if Old == Page then
						return
					end

					if Old then
						Old.Items["Page"].Instance.Visible = false
						Old:SetSelected(false)
					end

					PageFrame.Visible = true
					Self.Current = Page
					Page:SetSelected(true)

					-- menu.cpp resets g_scroll_target on tab change
					Page.Scroll = 0
					Page.ScrollTarget = 0
					Page:ApplyScroll()

					Self:RefreshCanvas()

					if Alpine.OnPageTurn then
						Alpine.OnPageTurn(Page)
					end
				end

				Tab:Connect("MouseButton1Down", function()
					Page:Turn()
				end)

				Tab:Connect("MouseEnter", function()
					if not Page.Active then
						TabLabel.Instance.TextColor3 = C.TabHoverText
						Shade.Instance.Color = ColorSequence.new(C.TabHoverTop, C.TabFillBottom)
					end
				end)

				Tab:Connect("MouseLeave", function()
					if not Page.Active then
						TabLabel.Instance.TextColor3 = C.TextDim
						Shade.Instance.Color = ColorSequence.new(C.TabFillTop, C.TabFillBottom)
					end
				end)

				table.insert(Self.Pages, Page)

				if #Self.Pages == 1 then
					Page:Turn()
				end

				return setmetatable(Page, Library)
			end

			-- ----------------------------------------------------------------
			-- section / panel / row engine
			-- ----------------------------------------------------------------
			Library.Section = function(Self, Params)
				Params = Params or { }

				local Section = {
					Name = Params.Name or Params.name or "Section",
					Side = Params.Side or Params.side or 1,

											Window = Self.Window,
						Page = Self,
						Items = { },
						Rows = 0,
						Cursor = 0,
						ContentWidth = Params.ContentWidth or M.PanelContentWidth,
					}

				local Panel = Frame(Self.ColumnsData[Section.Side].Instance, 0, 0, M.ColumnWidth, 26, C.Black, 1)
				Panel.Instance.BackgroundTransparency = 1
				Section.Items["Section"] = Panel

				local Outer = Fill(Panel, 0, 0, M.ColumnWidth, 26, C.Black, 1)
				local Light = Fill(Panel, 1, 1, M.ColumnWidth - 2, 24, C.PanelLight, 1)
				local Body = Fill(Panel, 2, 5, M.ColumnWidth - 4, 19, C.PanelFill, 1)

				Shine(Panel, 1, 1, M.ColumnWidth - 2, 1, C.PanelBorderTop, C.PanelBorderGlow, 2)
				Shine(Panel, 1, 2, M.ColumnWidth - 2, 1, C.PanelAccentTop, C.PanelAccentTopGlow, 2)
				Shine(Panel, 1, 3, M.ColumnWidth - 2, 1, C.PanelAccentBottom, C.PanelAccentBottomGlow, 2)
				Shine(Panel, 2, 4, M.ColumnWidth - 4, 1, C.PanelFill, C.PanelFillGlow, 2)

				local Header = Frame(Panel, 0, 0, M.ColumnWidth, M.PanelHeader, C.Black, 3)
				Header.Instance.BackgroundTransparency = 1
				Section.Items["Header"] = Header

				local Content = Frame(Panel, M.PanelContentX, M.PanelContentY, M.PanelContentWidth, 0, C.Black, 3)
				Content.Instance.BackgroundTransparency = 1
				Content.Instance.AutomaticSize = Enum.AutomaticSize.Y
				Section.Items["Content"] = Content

				local Padding = Make("UIPadding", {
					Parent = Content.Instance,
					PaddingTop = UDim.new(0, M.PanelTopPad),
					PaddingBottom = UDim.new(0, 0),
				})
				Section.Items["ContentPadding"] = Padding

				local Layout = Make("UIListLayout", {
					Parent = Content.Instance,
					Padding = UDim.new(0, 0),
					SortOrder = Enum.SortOrder.LayoutOrder,
				})
				Section.Items["ContentLayout"] = Layout

				local Title = Label(Panel, M.TitleIndent, M.TitleOffset, M.ColumnWidth - M.TitleIndent * 2,
					Section.Name, C.TextTitle, Enum.TextXAlignment.Left, 4)
				Section.Items["Text"] = Title

				function Section:Refresh()
					local Height = 26 + Section.Cursor

					Panel.Instance.Size = UDim2.fromOffset(M.ColumnWidth, Height)
					Outer.Instance.Size = UDim2.fromOffset(M.ColumnWidth, Height)
					Light.Instance.Size = UDim2.fromOffset(M.ColumnWidth - 2, math.max(1, Height - 2))
					Body.Instance.Size = UDim2.fromOffset(M.ColumnWidth - 4, math.max(1, Height - 7))

					if Self.Window then
						Self.Window:RefreshCanvas()
					end
				end

				function Section:_Row(Advance)
					local Row = Frame(Content, 0, 0, Section.ContentWidth or M.PanelContentWidth, Advance, C.Black, 4)
					Row.Instance.BackgroundTransparency = 1
					Row.Instance.LayoutOrder = Section.Rows

					Section.Rows += 1
					Section.Cursor += Advance
					Section:Refresh()

					return Row
				end

				Section:Refresh()

				return setmetatable(Section, Library)
			end

			-- ================================================================
			-- Alpine widgets
			--
			-- widgets.cpp: checkbox 10x10 at row-5, label at 14, keybind 32x12
			-- at row-6, swatch 22x10 at row-5, slider track at row+8 h10,
			-- combo field at row+8 h16. No extra row gap.
			-- ================================================================

			local Alpine = Library.Alpine
			local M = Alpine.Metric
			local C = Alpine.Color
			local Make, Frame, Fill, Gradient, Label = Alpine.Make, Alpine.Frame, Alpine.Fill, Alpine.Gradient, Alpine.Label
			local TweenService = game:GetService("TweenService")
			local RunService = game:GetService("RunService")
			local Flags = Library.Flags
			local SetFlags = Library.SetFlags

			-- Overlay consumers (keybind list, ESP preview) used to poll the flags
			-- four times a second. Fire once from the widget setters instead so
			-- the panels react in the same frame as the click.
			Library.FlagListeners = Library.FlagListeners or { }

			function Library:OnFlagChanged(Callback)
				table.insert(Library.FlagListeners, Callback)

				return {
					Disconnect = function()
						local Index = table.find(Library.FlagListeners, Callback)

						if Index then
							table.remove(Library.FlagListeners, Index)
						end
					end,
				}
			end

			local function NotifyFlagChanged(Flag, Value)
				for _, Callback in ipairs(Library.FlagListeners) do
					task.defer(Callback, Flag, Value)
				end
			end

			local function Shade(Color, Amount)
				local Target = Amount >= 0 and 1 or 0
				local Factor = math.abs(Amount)

				return Color3.new(
					Color.R + (Target - Color.R) * Factor,
					Color.G + (Target - Color.G) * Factor,
					Color.B + (Target - Color.B) * Factor
				)
			end

			local function Hover(Button, Enter, Leave)
				Button:Connect("MouseEnter", Enter)
				Button:Connect("MouseLeave", Leave)
			end

			-- widgets.cpp place_inline: gap is applied before the slot, and the
			-- next slot starts one pixel left of this one
			local function Inline(Toggle, Width, Gap)
				local Right = (Toggle.InlineRight or M.PanelContentWidth) - (Toggle.InlineGap or 0)
				local X = Right - Width + 1

				Toggle.InlineRight = X - 1
				Toggle.InlineGap = Gap

				return X
			end

			Alpine.Inline = Inline

			-- ----------------------------------------------------------------
			-- toggle
			-- ----------------------------------------------------------------
			Library.Toggle = function(Self, Params)
				Params = Params or { }

				local Toggle = {
					Name = Params.Name or Params.name or "Toggle",
					Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
					Default = Params.Default or Params.default or false,
					Callback = Params.Callback or Params.callback or function() end,
					Tooltip = Params.Tooltip or Params.tooltip,

					Window = Self.Window,
					Page = Self.Page,
					Section = Self,

					Value = false,
					Items = { },
					IsRowWidget = true,
					InlineRight = (Self.ContentWidth or M.PanelContentWidth) - 1,
					InlineGap = 0,
				}

				local Width = Self.ContentWidth or M.PanelContentWidth
				local Row = Self:_Row(M.ToggleAdvance)

				-- widgets.cpp hitbox is row-6 .. row+7. The visible checkbox sits at
				-- row-5, so the old button (starting at row) only covered the lower
				-- half of the box and clicks looked completely dead. Move the button
				-- up by six pixels and keep its children at the same absolute rows.
				local Button = Make("TextButton", {
					Name = "\0",
					Parent = Row.Instance,
					Position = UDim2.fromOffset(0, -6),
					Size = UDim2.fromOffset(Width, M.ToggleAdvance),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Text = "",
					Active = true,
					AutoButtonColor = false,
					ZIndex = 5,
				})

				-- widgets.cpp checkbox: 1px black border, 8x8 gradient inside
				local Checkbox = Frame(Button, 0, 1, M.CheckboxSize, M.CheckboxSize, C.Black, 0, 5)
				local FillBox = Frame(Checkbox, 1, 1, M.CheckboxSize - 2, M.CheckboxSize - 2, C.CheckboxTop, 0, 5)
				local FillGradient = Gradient(FillBox, C.CheckboxTop, C.CheckboxBottom)

				local Name = Label(Button, M.CheckboxLabel, 6, Width - M.CheckboxLabel,
					Toggle.Name, C.TextDim, Enum.TextXAlignment.Left, 6)

				Toggle.Items["Toggle"] = Button
				Toggle.Items["Indicator"] = Checkbox
				Toggle.Items["Inline"] = FillBox
				Toggle.Items["Text"] = Name
				Toggle.Items["Row"] = Row
				Toggle.Items["SubElements"] = Row

				local Hovered = false

				local function Paint()
					local Top = Toggle.Value and C.CheckedTop or (Hovered and C.InputHoverTop or C.CheckboxTop)
					local Bottom = Toggle.Value and C.CheckedBottom or C.CheckboxBottom

					FillGradient.Instance.Color = ColorSequence.new(Top, Bottom)
					Name.Instance.TextColor3 = (Toggle.Value or Hovered) and C.Text or C.TextDim
				end

				function Toggle:Set(Bool)
					Toggle.Value = Bool and true or false

					Flags[Toggle.Flag] = Toggle.Value
					Paint()
					NotifyFlagChanged(Toggle.Flag, Toggle.Value)

					task.defer(function()
						Library:SafeCall(Toggle.Callback, Toggle.Value)
					end)
				end

				function Toggle:Get()
					return Toggle.Value
				end

				function Toggle:SetVisibility(Bool)
					Row.Instance.Visible = Bool
				end

				function Toggle:SetText(Text)
					Name.Instance.Text = tostring(Text)
				end

				function Toggle:SetOpen(Bool)
					Toggle:Set(Bool)
				end

				Hover(Button, function()
					Hovered = true
					Paint()
				end, function()
					Hovered = false
					Paint()
				end)

				Button:Connect("MouseButton1Down", function()
					Toggle:Set(not Toggle.Value)
				end)

				Toggle:Set(Toggle.Default)

				SetFlags[Toggle.Flag] = function(Value)
					Toggle:Set(Value)
				end

				Self.LastWidget = Toggle

				return setmetatable(Toggle, Library)
			end

			-- ----------------------------------------------------------------
			-- keybind
			-- ----------------------------------------------------------------
			local Keybinds = { }
			local Listening

			local function InputName(Input)
				if Input.UserInputType == Enum.UserInputType.Keyboard then
					return Input.KeyCode.Name
				end

				local Name = Input.UserInputType.Name

				if string.match(Name, "^MouseButton%d$") then
					return "m" .. string.sub(Name, -1)
				end

				return nil
			end

			Library:Connect(UserInputService.InputBegan, function(Input)
				if Listening then
					if Input.UserInputType == Enum.UserInputType.Keyboard then
						Listening:SetKey(Input.KeyCode == Enum.KeyCode.Escape and "None" or Input.KeyCode.Name)
					elseif string.match(Input.UserInputType.Name, "^MouseButton%d$") then
						-- the click that started listening must not bind m1 itself
						if Input.UserInputType == Enum.UserInputType.MouseButton1 and Listening.AwaitingRelease then
							return
						end

						Listening:SetKey(InputName(Input))
					else
						Listening:Render()
					end

					Listening = nil
					return
				end

				if not UserInputService:GetFocusedTextBox() then
					for _, Bind in ipairs(Keybinds) do
						if Bind:Matching(Input) then
							Bind:Press(true)
						end
					end
				end
			end)

			Library:Connect(UserInputService.InputEnded, function(Input)
				if Listening and Input.UserInputType == Enum.UserInputType.MouseButton1 then
					Listening.AwaitingRelease = nil
				end

				for _, Bind in ipairs(Keybinds) do
					if Bind:Matching(Input) then
						Bind:Press(false)
					end
				end
			end)

			Library.CreateKeybind = function(Self, Data)
				Data = Data or { }

				local Keybind = {
					Flag = Data.Flag or Data.flag,
					Name = Data.Name or Data.name or "Keybind",
					Default = Data.Default or Data.default,
					Callback = Data.Callback or Data.callback or function() end,
					Mode = Data.Mode or Data.mode or "Toggle",
					Gate = Data.Toggle,
					Value = "None",
					Items = { },
				}

				local Button = Make("TextButton", {
					Name = "\0",
					Parent = (Data.Row or Data.Parent).Instance,
					Position = UDim2.fromOffset(Data.X or 0, M.KeybindOffset),
					Size = UDim2.fromOffset(M.KeybindWidth, M.KeybindHeight),
					BackgroundColor3 = C.Black,
					BackgroundTransparency = 0,
					BorderSizePixel = 0,
					Text = "",
					AutoButtonColor = false,
					ZIndex = 6,
				})

				local Input = Fill(Button, 1, 1, M.KeybindWidth - 2, M.KeybindHeight - 2, C.InputTop, 6)
				local InputGradient = Gradient(Input, C.InputTop, C.InputBottom)
				local KeyLabel = Label(Button, 0, 6, M.KeybindWidth, "-", C.TextDim, Enum.TextXAlignment.Center, 7)

				Keybind.Items["KeyButton"] = Button
				Keybind.Items["KeybindWindow"] = Button

				local Hovered = false

				function Keybind:Render()
					KeyLabel.Instance.Text = tostring(Keybind.Value or "-")
					KeyLabel.Instance.TextColor3 = Hovered and C.Text or C.TextDim
					InputGradient.Instance.Color = ColorSequence.new(
						Hovered and C.InputHoverTop or C.InputTop,
						Hovered and C.InputHoverBottom or C.InputBottom
					)
				end

				function Keybind:SetKey(Key)
					Keybind.Value = (Key == nil or Key == "") and "None" or tostring(Key)
					Keybind:Render()

					if Keybind.Flag then
						Flags[Keybind.Flag] = {
							Mode = Keybind.Mode,
							Key = Keybind.Value,
						}

						NotifyFlagChanged(Keybind.Flag, Flags[Keybind.Flag])
					end

					if Keybind.Gate and Keybind.Mode == "Always" then
						Keybind.Gate:Set(true)
					end
				end

				function Keybind:Set(Key)
					Keybind:SetKey(Key)
				end

				function Keybind:Get()
					return Keybind.Value
				end

				function Keybind:SetMode(Mode)
					Keybind.Mode = Mode or "Toggle"

					if Keybind.Flag then
						Flags[Keybind.Flag] = {
							Mode = Keybind.Mode,
							Key = Keybind.Value,
						}

						NotifyFlagChanged(Keybind.Flag, Flags[Keybind.Flag])
					end

					if Keybind.Gate then
						if Keybind.Mode == "Always" then
							Keybind.Gate:Set(true)
						elseif Keybind.Mode == "Hold" then
							Keybind.Gate:Set(false)
						end
					end
				end

				function Keybind:Matching(Input)
					return Keybind.Value ~= "None" and Keybind.Value ~= "" and InputName(Input) == Keybind.Value
				end

				function Keybind:Press(Down)
					if Keybind.Gate == nil or Keybind.Value == "None" then
						return
					end

					if Keybind.Mode == "Toggle" then
						if Down then
							Keybind.Gate:Set(not Keybind.Gate:Get())
						end
					elseif Keybind.Mode == "Hold" then
						Keybind.Gate:Set(Down)
					end
				end

				Hover(Button, function()
					Hovered = true
					Keybind:Render()
				end, function()
					Hovered = false
					Keybind:Render()
				end)

				Button:Connect("MouseButton1Down", function()
					Listening = Keybind
					Keybind.AwaitingRelease = true
					KeyLabel.Instance.Text = "..."
				end)

				Button:Connect("MouseButton2Down", function()
					if Listening ~= Keybind then
						Alpine.OpenModeMenu(Button, Keybind)
					end
				end)

				Keybind:SetKey(Keybind.Default)

				if Keybind.Flag then
					SetFlags[Keybind.Flag] = function(Value)
						if type(Value) == "table" then
							if Value.Mode then
								Keybind:SetMode(Value.Mode)
							end

							if Value.Key then
								Keybind:SetKey(Value.Key)
							end
						else
							Keybind:SetKey(Value)
						end
					end
				end

				table.insert(Keybinds, Keybind)

				return setmetatable(Keybind, Library)
			end

			function Library:Keybind(Data)
				Data = Data or { }

				local Target = self.LastWidget

				if Target and Target.IsRowWidget and Target.Keybind then
					return Target:Keybind(Data)
				end

				local Row = self:_Row(M.ToggleAdvance)
				local X = Data.X or ((self.ContentWidth or M.PanelContentWidth) - M.KeybindWidth)

				return Library.CreateKeybind(self, {
					Row = Row,
					X = X,
					Flag = Data.Flag,
					Default = Data.Default,
					Mode = Data.Mode,
					Callback = Data.Callback,
					Name = Data.Name,
				})
			end

			-- ----------------------------------------------------------------
			-- slider
			-- ----------------------------------------------------------------
			Library.Slider = function(Self, Params)
				Params = Params or { }

				local Slider = {
					Name = Params.Name or Params.name or "Slider",
					Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
					Default = Params.Default or Params.default or 0,
					Min = Params.Min or Params.min or 0,
					Max = Params.Max or Params.max or 100,
					Callback = Params.Callback or Params.callback or function() end,
					Decimals = Params.Decimals or Params.decimals or 0,
					Suffix = Params.Suffix or Params.suffix or "",
					Value = 0,
					Items = { },
				}

				-- Alpine passes decimal places (2); the base theme sliders pass a raw
				-- step (0.01). Normalise both to places + step.
				local Places = Slider.Decimals

				if Places <= 0 then
					Places = 0
				elseif Places % 1 ~= 0 then
					Places = math.max(0, math.ceil(-math.log10(Places)))
				end

				local Step = Places > 0 and (10 ^ -Places) or 1
				local Width = Self.ContentWidth or M.PanelContentWidth
				local Row = Self:_Row(M.SliderAdvance)

				local Name = Label(Row, 2, 0, Width - 4, Slider.Name, C.Text, Enum.TextXAlignment.Left, 5)
				local Track = Make("TextButton", {
					Name = "\0",
					Parent = Row.Instance,
					Position = UDim2.fromOffset(0, M.WidgetOffset),
					Size = UDim2.fromOffset(Width, M.SliderHeight),
					BackgroundColor3 = C.Black,
					BackgroundTransparency = 0,
					BorderSizePixel = 0,
					Text = "",
					AutoButtonColor = false,
					ZIndex = 5,
				})

				local Inner = Fill(Track, 1, 1, Width - 2, M.SliderHeight - 2, C.TrackTop, 5)
				local TrackGradient = Gradient(Inner, C.TrackTop, C.TrackBottom)

				local Accent = Fill(Track, 1, 1, 0, M.SliderHeight - 2, C.FillTop, 6)
				local FillGradient = Gradient(Accent, C.FillTop, C.FillBottom)

				local function PaintHover(Hovered)
					TrackGradient.Instance.Color = ColorSequence.new(
						Hovered and C.TrackHoverTop or C.TrackTop,
						C.TrackBottom
					)
					FillGradient.Instance.Color = ColorSequence.new(
						Hovered and C.FillHoverTop or C.FillTop,
						C.FillBottom
					)
				end

				local Readout = Label(Track, 0, 5, Width, "", C.Text, Enum.TextXAlignment.Center, 7)
				Readout.Instance.TextTransparency = 1

				Slider.Items["Slider"] = Row
				Slider.Items["RealSlider"] = Track
				Slider.Items["Accent"] = Accent
				Slider.Items["Text"] = Name
				Slider.Items["Value"] = Readout

				local function Format(Value)
					if Places <= 0 then
						return tostring(math.floor(Value + 0.5)) .. Slider.Suffix
					end

					return string.format("%." .. Places .. "f", Value) .. Slider.Suffix
				end

				local function Paint()
					local Span = math.max(Slider.Max - Slider.Min, 1e-9)
					local Fraction = math.clamp((Slider.Value - Slider.Min) / Span, 0, 1)
					local Filled = math.floor((Width - 2) * Fraction + 0.5)

					Accent.Instance.Size = UDim2.fromOffset(Filled, M.SliderHeight - 2)
					Readout.Instance.Text = Format(Slider.Value)
				end

				function Slider:Set(Value, Silent)
					local Number = math.clamp(tonumber(Value) or Slider.Min, Slider.Min, Slider.Max)

					Number = math.floor(Number / Step + 0.5) * Step
					Slider.Value = Number + 0.0
					Flags[Slider.Flag] = Slider.Value
					Paint()
					NotifyFlagChanged(Slider.Flag, Slider.Value)

					if not Silent then
						task.defer(function()
							Library:SafeCall(Slider.Callback, Slider.Value)
						end)
					end
				end

				function Slider:Get()
					return Slider.Value
				end

				function Slider:SetRange(Low, High)
					if Low then
						Slider.Min = Low
					end

					if High then
						Slider.Max = High
					end

					Slider:Set(Slider.Value)
				end

				function Slider:SetVisibility(Bool)
					Row.Instance.Visible = Bool
				end

				function Slider:SetText(Text)
					Name.Instance.Text = tostring(Text)
				end

				local Hovered = false
				local Dragging = false

				local function SetFromMouse()
					local Mouse = UserInputService:GetMouseLocation()
					local Position = Track.Instance.AbsolutePosition
					local Size = Track.Instance.AbsoluteSize
					local Fraction = math.clamp((Mouse.X - Position.X - 1) / math.max(Size.X - 2, 1), 0, 1)

					Slider:Set(Slider.Min + (Slider.Max - Slider.Min) * Fraction)
				end

				Hover(Track, function()
					Hovered = true
					Readout.Instance.TextTransparency = 0
					PaintHover(true)
				end, function()
					Hovered = false

					if not Dragging then
						Readout.Instance.TextTransparency = 1
						PaintHover(false)
					end
				end)

				Library:Connect(Track.Instance.InputBegan, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
						Dragging = true
						Readout.Instance.TextTransparency = 0
						PaintHover(true)
						SetFromMouse()
					end
				end)

				Library:Connect(UserInputService.InputChanged, function(Input)
					if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
						SetFromMouse()
					end
				end)

				Library:Connect(UserInputService.InputEnded, function(Input)
					if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) and Dragging then
						Dragging = false

						if not Hovered then
							Readout.Instance.TextTransparency = 1
							PaintHover(false)
						end
					end
				end)

				SetFlags[Slider.Flag] = function(Value)
					Slider:Set(Value)
				end

				Slider:Set(Slider.Default, true)

				Self.LastWidget = Slider

				return setmetatable(Slider, Library)
			end

			-- ----------------------------------------------------------------
			-- dropdown / multi dropdown
			-- ----------------------------------------------------------------
			local function Arrow(Parent, Right)
				local Rows = { }

				for Index = 0, 2 do
					Rows[Index] = Fill(Parent, Right - 8 + Index, 6 + Index, 6 - Index * 2, 1, C.Text, 8)
				end

				return function(Open)
					for Index = 0, 2 do
						local Inset = Open and (2 - Index) or Index

						Rows[Index].Instance.Position = UDim2.fromOffset(Right - 8 + Inset, 6 + Index)
						Rows[Index].Instance.Size = UDim2.fromOffset(6 - Inset * 2, 1)
					end
				end
			end

			Library.Dropdown = function(Self, Params)
				Params = Params or { }

				local Multi = Params.Multi or Params.multi or false
				local Options = Params.Options or Params.Items or Params.Values or Params.items or { }

				local Dropdown = {
					Name = Params.Name or Params.name or "Dropdown",
					Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
					Callback = Params.Callback or Params.callback or function() end,
					Multi = Multi,
					Options = Options,
					Items = { },
				}

				local Width = Self.ContentWidth or M.PanelContentWidth
				local Row = Self:_Row(M.ComboAdvance)

				local Name = Label(Row, 2, 0, Width - 4, Dropdown.Name, C.Text, Enum.TextXAlignment.Left, 5)
				local Field = Make("TextButton", {
					Name = "\0",
					Parent = Row.Instance,
					Position = UDim2.fromOffset(0, M.WidgetOffset),
					Size = UDim2.fromOffset(Width, M.ComboHeight),
					BackgroundColor3 = C.Black,
					BackgroundTransparency = 0,
					BorderSizePixel = 0,
					Text = "",
					AutoButtonColor = false,
					ZIndex = 5,
				})

				local Inner = Fill(Field, 1, 1, Width - 2, M.ComboHeight - 2, C.InputTop, 5)
				local FieldGradient = Gradient(Inner, C.InputTop, C.InputBottom)
				local Preview = Label(Field, M.ComboTextIndent, 8, Width - 22, "None", C.Text, Enum.TextXAlignment.Left, 7)

				local PaintArrow = Arrow(Field, Width)

				Dropdown.Items["Dropdown"] = Field
				Dropdown.Items["RealDropdown"] = Field
				Dropdown.Items["Text"] = Name
				Dropdown.Items["Value"] = Preview

				if Multi then
					Dropdown.Value = { }

					for _, Option in ipairs(Params.Default or Params.default or { }) do
						table.insert(Dropdown.Value, Option)
					end
				else
					Dropdown.Value = Params.Default or Params.default or Options[1]
				end

				local Hovered = false

				local function PreviewText()
					if Multi then
						return #Dropdown.Value > 0 and table.concat(Dropdown.Value, ", ") or "None"
					end

					return tostring(Dropdown.Value or "None")
				end

				local function PaintField()
					Preview.Instance.Text = PreviewText()
					Preview.Instance.TextColor3 = (Multi and #Dropdown.Value == 0) and C.TextDim or C.Text
					FieldGradient.Instance.Color = ColorSequence.new(
						Hovered and C.InputHoverTop or C.InputTop,
						Hovered and C.InputHoverBottom or C.InputBottom
					)
					Name.Instance.TextColor3 = C.Text
				end

				function Dropdown:Get()
					return Dropdown.Value
				end

				function Dropdown:Set(Value)
					if Multi then
						Dropdown.Value = type(Value) == "table" and Value or { }
					else
						Dropdown.Value = Value
					end

					Flags[Dropdown.Flag] = Dropdown.Value
					PaintField()
					NotifyFlagChanged(Dropdown.Flag, Dropdown.Value)

					task.defer(function()
						Library:SafeCall(Dropdown.Callback, Dropdown.Value)
					end)
				end

				function Dropdown:Refresh(List)
					Dropdown.Options = List or { }
				end

				function Dropdown:Add(Value)
					table.insert(Dropdown.Options, Value)
				end

				function Dropdown:Remove(Value)
					local Index = table.find(Dropdown.Options, Value)

					if Index then
						table.remove(Dropdown.Options, Index)
					end
				end

				function Dropdown:SetText(Text)
					Name.Instance.Text = tostring(Text)
				end

				function Dropdown:SetVisibility(Bool)
					Row.Instance.Visible = Bool
				end

				function Dropdown:SetSearchOpen()
				end

				function Dropdown:SetOpen(Bool)
					if Bool then
						Dropdown:Open()
					else
						Alpine.ClosePopup(Dropdown)
					end
				end

				function Dropdown:Open()
					Alpine.ClosePopup(Dropdown)
					PaintArrow(true)

					local Count = #Dropdown.Options
					local Height = Count * M.DropdownItem + 2
					local Position = Field.Instance.AbsolutePosition
					local Size = Field.Instance.AbsoluteSize

					local Popup = Frame(Library.Holder.Instance, 0, 0, Width, Height, C.Black, 0, 500)
					local Viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
					local Top = Position.Y + Size.Y + 1

					if Top + Height > Viewport.Y then
						Top = Position.Y - Height - 1
					end

					Popup.Instance.Position = UDim2.fromOffset(Position.X, Top)
					Fill(Popup, 1, 1, Width - 2, Height - 2, C.InputBottom, 501)

					for Index, Option in ipairs(Dropdown.Options) do
						local Item = Make("TextButton", {
							Name = "\0",
							Parent = Popup.Instance,
							Position = UDim2.fromOffset(1, 1 + (Index - 1) * M.DropdownItem),
							Size = UDim2.fromOffset(Width - 2, M.DropdownItem - 1),
							BackgroundColor3 = C.InputHoverTop,
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Text = "",
							AutoButtonColor = false,
							ZIndex = 502,
						})
						Gradient(Item, C.InputHoverTop, C.InputHoverBottom)

						local Selected = (Multi and table.find(Dropdown.Value, Option) ~= nil) or (not Multi and Dropdown.Value == Option)
						local ItemLabel = Label(Item, M.ComboTextIndent - 1, 7, Width - 12, tostring(Option),
							Selected and C.Text or C.TextDim, Enum.TextXAlignment.Left, 503)

						Item:Connect("MouseEnter", function()
							Item.Instance.BackgroundTransparency = 0
							ItemLabel.Instance.TextColor3 = C.Text
						end)

						Item:Connect("MouseLeave", function()
							Item.Instance.BackgroundTransparency = 1
							ItemLabel.Instance.TextColor3 = Selected and C.Text or C.TextDim
						end)

						Item:Connect("MouseButton1Down", function()
							if Multi then
								local At = table.find(Dropdown.Value, Option)

								if At then
									table.remove(Dropdown.Value, At)
								else
									table.insert(Dropdown.Value, Option)
								end

								Flags[Dropdown.Flag] = Dropdown.Value
								PaintField()

								task.defer(function()
									Library:SafeCall(Dropdown.Callback, Dropdown.Value)
								end)
							else
								Dropdown:Set(Option)
								Alpine.ClosePopup(Dropdown)
							end
						end)
					end

					Alpine.SetPopup(Dropdown, Popup, Field)
				end

				function Dropdown:OnPopupClose()
					PaintArrow(false)
				end

				Hover(Field, function()
					Hovered = true
					PaintField()
				end, function()
					Hovered = false
					PaintField()
				end)

				Field:Connect("MouseButton1Down", function()
					if Alpine.Popup and Alpine.Popup.Owner == Dropdown then
						Alpine.ClosePopup(Dropdown)
					else
						Dropdown:Open()
					end
				end)

				SetFlags[Dropdown.Flag] = function(Value)
					Dropdown:Set(Value)
				end

				Dropdown:Set(Dropdown.Value)
				Self.LastWidget = Dropdown

				return setmetatable(Dropdown, Library)
			end

			function Library:MultiDropdown(Params)
				Params = Params or { }
				Params.Multi = true

				return Library.Dropdown(self, Params)
			end

			-- ----------------------------------------------------------------
			-- popups
			-- ----------------------------------------------------------------
			Alpine.Popup = nil

			function Alpine.ClosePopup(Owner)
				local Popup = Alpine.Popup

				if not Popup then
					return
				end

				if Owner and Popup.Owner ~= Owner then
					return
				end

				Alpine.Popup = nil

				if Popup.Owner and Popup.Owner.OnPopupClose then
					Popup.Owner:OnPopupClose()
				end

				Popup.Frame.Instance:Destroy()
			end

			function Alpine.SetPopup(Owner, Frame, Anchor)
				Alpine.Popup = {
					Owner = Owner,
					Frame = Frame,
					Anchor = Anchor,
				}
			end

			Library:Connect(UserInputService.InputBegan, function(Input)
				local Popup = Alpine.Popup

				if not Popup then
					return
				end

				if Input.UserInputType ~= Enum.UserInputType.MouseButton1 and Input.UserInputType ~= Enum.UserInputType.MouseButton2 then
					return
				end

				local Mouse = UserInputService:GetMouseLocation()
				local Box = Popup.Frame.Instance.AbsolutePosition
				local Size = Popup.Frame.Instance.AbsoluteSize
				local Anchor = Popup.Anchor and Popup.Anchor.Instance

				local Inside = Mouse.X >= Box.X and Mouse.X <= Box.X + Size.X and Mouse.Y >= Box.Y and Mouse.Y <= Box.Y + Size.Y

				if Anchor then
					local AP = Anchor.AbsolutePosition
					local AS = Anchor.AbsoluteSize

					Inside = Inside or (Mouse.X >= AP.X and Mouse.X <= AP.X + AS.X and Mouse.Y >= AP.Y and Mouse.Y <= AP.Y + AS.Y)
				end

				if not Inside then
					Alpine.ClosePopup()
				end
			end)

			function Alpine.OpenModeMenu(Anchor, Keybind)
				Alpine.ClosePopup()

				local Modes = { "Hold", "Toggle", "Always" }
				local Width = 60
				local Height = #Modes * M.DropdownItem + 2
				local Position = Anchor.Instance.AbsolutePosition
				local Size = Anchor.Instance.AbsoluteSize

				local Popup = Frame(Library.Holder.Instance, 0, 0, Width, Height, C.Black, 0, 500)
				Popup.Instance.Position = UDim2.fromOffset(Position.X + Size.X - Width + 1, Position.Y + Size.Y + 1)
				Fill(Popup, 1, 1, Width - 2, Height - 2, C.InputBottom, 501)

				for Index, Mode in ipairs(Modes) do
					local Item = Make("TextButton", {
						Name = "\0",
						Parent = Popup.Instance,
						Position = UDim2.fromOffset(1, 1 + (Index - 1) * M.DropdownItem),
						Size = UDim2.fromOffset(Width - 2, M.DropdownItem - 1),
						BackgroundColor3 = C.InputHoverTop,
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Text = "",
						AutoButtonColor = false,
						ZIndex = 502,
					})

					local ItemLabel = Label(Item, 4, 7, Width - 8, Mode,
						Keybind.Mode == Mode and C.Text or C.TextDim, Enum.TextXAlignment.Left, 503)

					Item:Connect("MouseEnter", function()
						Item.Instance.BackgroundTransparency = 0
						ItemLabel.Instance.TextColor3 = C.Text
					end)

					Item:Connect("MouseLeave", function()
						Item.Instance.BackgroundTransparency = 1
						ItemLabel.Instance.TextColor3 = Keybind.Mode == Mode and C.Text or C.TextDim
					end)

					Item:Connect("MouseButton1Down", function()
						Keybind:SetMode(Mode)
						Alpine.ClosePopup()
					end)
				end

				Alpine.SetPopup(Keybind, Popup, Anchor)
			end

			-- ----------------------------------------------------------------
			-- toggle inline widgets
			-- ----------------------------------------------------------------
			function ToggleKeybind(Toggle, Data)
				Data = Data or { }

				local X = Inline(Toggle, M.KeybindWidth, M.InlineGap)

				return Library.CreateKeybind(Toggle.Section, {
					Parent = Toggle.Items["Row"],
					Row = Toggle.Items["Row"],
					X = X,
					Toggle = Toggle,
					GateByToggle = Data.GateByToggle,
					Flag = Data.Flag or ("key_" .. tostring(Toggle.Flag)),
					Default = Data.Default,
					Mode = Data.Mode,
					Callback = Data.Callback,
					Name = Data.Name or Toggle.Name,
				})
			end

			-- attached below so the Toggle metatable is Library and the method
			-- is available on every toggle
			function Library.ToggleKeybindMethod(Toggle, Data)
				return ToggleKeybind(Toggle, Data)
			end

			-- ----------------------------------------------------------------
			-- colorpicker
			-- ----------------------------------------------------------------
			local Checkers = {
				{ 0, 0, 6, 4 },
				{ 6, 4, 6, 4 },
				{ 12, 0, 6, 4 },
				{ 18, 4, 6, 4 },
			}

			local function Checker(Parent, X, Y, W, H)
				Fill(Parent, X, Y, W, H, Color3.fromRGB(170, 170, 170), 6)

				for Row = 0, math.ceil(H / 8) - 1 do
					for Column = 0, math.ceil(W / 12) - 1 do
						if (Row + Column) % 2 == 1 then
							Fill(Parent, X + Column * 12, Y + Row * 8, math.min(12, W - Column * 12), math.min(8, H - Row * 8), Color3.fromRGB(136, 136, 136), 7)
						end
					end
				end
			end

			local function HexOf(Color)
				local Success, Value = pcall(function()
					return Color:ToHex()
				end)

				return Success and Value or "FFFFFF"
			end

			Library.CreateColorpicker = function(Self, Data)
				Data = Data or { }

				local Picker = {
					Flag = Data.Flag or Data.flag,
					Name = Data.Name or Data.name or "Color",
					Value = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
					Alpha = Data.Alpha or Data.alpha or 1,
					Callback = Data.Callback or Data.callback or function() end,
					Items = { },
					IsRowWidget = false,
				}

				local Row = Data.Row
				local X = Data.X or 0

				local Swatch = Make("TextButton", {
					Name = "\0",
					Parent = (Row or Data.Parent).Instance,
					Position = UDim2.fromOffset(X, M.SwatchOffset),
					Size = UDim2.fromOffset(M.SwatchWidth, M.SwatchHeight),
					BackgroundColor3 = C.Black,
					BackgroundTransparency = 0,
					BorderSizePixel = 0,
					Text = "",
					AutoButtonColor = false,
					ZIndex = 6,
				})

				-- 6x4 checker under the colour, exactly like widgets.cpp color_swatch
				local CheckerBase = Frame(Swatch, 1, 1, M.SwatchWidth - 2, M.SwatchHeight - 2, Color3.fromRGB(170, 170, 170), 1, 5)

				for Row = 0, 1 do
					for Column = 0, 3 do
						if (Row + Column) % 2 == 1 then
							Fill(CheckerBase, Column * 6, Row * 4, math.min(6, M.SwatchWidth - 2 - Column * 6), 4, Color3.fromRGB(136, 136, 136), 5)
						end
					end
				end

				local Inside = Fill(Swatch, 1, 1, M.SwatchWidth - 2, M.SwatchHeight - 2, Picker.Value, 6)
				local SwatchGradient = Gradient(Inside, Picker.Value, Shade(Picker.Value, -0.2))

				Picker.Items["ColorpickerButton"] = Swatch
				Picker.Items["ColorpickerWindow"] = Swatch
				Picker.Hue, Picker.Saturation, Picker.Brightness = Picker.Value:ToHSV()

				local Popup, PopupParts

				local function FlagsUpdate()
					if Picker.Flag then
						Flags[Picker.Flag] = {
							Color = "#" .. HexOf(Picker.Value),
							HexValue = HexOf(Picker.Value),
							Alpha = Picker.Alpha,
							Transparency = 1 - Picker.Alpha,
						}
					end
				end

				local function PaintSwatch()
					Inside.Instance.BackgroundColor3 = Picker.Value
					Inside.Instance.BackgroundTransparency = 1 - math.clamp(Picker.Alpha, 0, 1)
					SwatchGradient.Instance.Color = ColorSequence.new(
						Picker.Value,
						Shade(Picker.Value, -0.2)
					)
				end

				local function HexFull()
					return "#" .. HexOf(Picker.Value)
						.. string.format("%02X", math.floor(math.clamp(Picker.Alpha, 0, 1) * 255 + 0.5))
				end

				function Picker:Update()
					Picker.Value = Color3.fromHSV(Picker.Hue, Picker.Saturation, Picker.Brightness)
					PaintSwatch()
					FlagsUpdate()
					NotifyFlagChanged(Picker.Flag, Picker.Value)

					if PopupParts then
						PopupParts:Refresh()
					end

					task.defer(function()
						Library:SafeCall(Picker.Callback, Picker.Value, Picker.Alpha)
					end)
				end

				function Picker:Set(Color, Alpha)
					if typeof(Color) == "Color3" then
						Picker.Hue, Picker.Saturation, Picker.Brightness = Color:ToHSV()
						Picker.Value = Color
					end

					if type(Alpha) == "number" then
						Picker.Alpha = math.clamp(Alpha, 0, 1)
					end

					PaintSwatch()
					FlagsUpdate()
					NotifyFlagChanged(Picker.Flag, Picker.Value)

					if PopupParts then
						PopupParts:Refresh()
					end
				end

				function Picker:Get()
					return Picker.Value, Picker.Alpha
				end

				function Picker:SetVisibility(Bool)
					Swatch.Instance.Visible = Bool
				end

				function Picker:SetOpen(Bool)
					if not Bool then
						Alpine.ClosePopup(Picker)
						return
					end

					if Alpine.Popup and Alpine.Popup.Owner == Picker then
						return
					end

					Alpine.ClosePopup()

					local Width, Height = 181, 201
					local Position = Swatch.Instance.AbsolutePosition
					local Size = Swatch.Instance.AbsoluteSize
					local Viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
					local X = math.clamp(Position.X + Size.X - Width + 1, 0, math.max(0, Viewport.X - Width))
					local Y = Position.Y + Size.Y + 3

					if Y + Height > Viewport.Y then
						Y = Position.Y - Height - 2
					end

					Popup = Frame(Library.Holder.Instance, 0, 0, Width, Height, C.Black, 0, 500)
					Popup.Instance.Position = UDim2.fromOffset(X, Y)

					Fill(Popup, 1, 1, Width - 2, Height - 2, C.PanelLight, 501)
					Fill(Popup, 2, 5, Width - 4, Height - 7, C.PanelFill, 501)
					Library.Alpine.Shine(Popup, 1, 1, Width - 2, 1, C.PanelBorderTop, C.PanelBorderGlow, 502)
					Library.Alpine.Shine(Popup, 1, 2, Width - 2, 1, C.PanelAccentTop, C.PanelAccentTopGlow, 502)
					Library.Alpine.Shine(Popup, 1, 3, Width - 2, 1, C.PanelAccentBottom, C.PanelAccentBottomGlow, 502)
					Library.Alpine.Shine(Popup, 2, 4, Width - 4, 1, C.PanelFill, C.PanelFillGlow, 502)

					-- picker.cpp make_layout: outer boxes are black frames, the colour
					-- fields are inset by 2 on every side
					Fill(Popup, 7, 7, 150, 150, C.Black, 503)

					local Saturation = Fill(Popup, 9, 9, 146, 146, Color3.new(1, 1, 1), 504)
					local SaturationGradient = Gradient(Saturation, Color3.new(1, 1, 1), Color3.new(1, 1, 1), 0)
					local Shade = Fill(Popup, 9, 9, 146, 146, Color3.new(0, 0, 0), 505)
					local ShadeGradient = Make("UIGradient", {
						Parent = Shade.Instance,
						Rotation = 90,
						Transparency = NumberSequence.new({
							NumberSequenceKeypoint.new(0, 1),
							NumberSequenceKeypoint.new(1, 0),
						}),
					})

					Fill(Popup, 161, 7, 13, 150, C.Black, 503)
					local Hue = Fill(Popup, 163, 9, 9, 146, Color3.new(1, 1, 1), 504)

					for Segment = 0, 5 do
						local Top = 9 + math.floor(146 * Segment / 6 + 0.5)
						local Bottom = 9 + math.floor(146 * (Segment + 1) / 6 + 0.5) - 1

						local Piece = Fill(Popup, 163, Top, 9, math.max(1, Bottom - Top + 1), Color3.fromHSV(Segment / 6, 1, 1), 505)
						Gradient(Piece, Color3.fromHSV(Segment / 6, 1, 1), Color3.fromHSV((Segment + 1) / 6, 1, 1))
					end

					Fill(Popup, 7, 161, 167, 13, C.Black, 503)
					local AlphaBase = Fill(Popup, 9, 163, 163, 9, Color3.fromRGB(140, 140, 140), 504)

					for Row = 0, 2 do
						local Y = 163 + Row * 4
						local H = math.min(4, 172 - Y)

						for Column = 0, 40 do
							if (Row + Column) % 2 == 1 then
								local X = 9 + Column * 4
								local W = math.min(4, 172 - X)

								if W > 0 and H > 0 then
									Fill(Popup, X, Y, W, H, Color3.fromRGB(92, 92, 92), 504)
								end
							end
						end
					end

					local Alpha = Fill(Popup, 9, 163, 163, 9, Picker.Value, 505)
					local AlphaGradient = Make("UIGradient", {
						Parent = Alpha.Instance,
						Rotation = 0,
						Transparency = NumberSequence.new({
							NumberSequenceKeypoint.new(0, 1),
							NumberSequenceKeypoint.new(1, 0),
						}),
					})

					local Mark = Frame(Popup, 0, 0, 6, 6, C.Black, 0, 506)
					Mark.Instance.BackgroundTransparency = 1
					Fill(Mark, 0, 0, 6, 1, C.Text, 506)
					Fill(Mark, 0, 5, 6, 1, C.Text, 506)
					Fill(Mark, 0, 0, 1, 6, C.Text, 506)
					Fill(Mark, 5, 0, 1, 6, C.Text, 506)

					local HueMark = Fill(Popup, 160, 0, 15, 2, C.Text, 506)
					local AlphaMark = Fill(Popup, 0, 160, 2, 15, C.Text, 506)

					local HexBox = Make("TextBox", {
						Name = "\0",
						Parent = Popup.Instance,
						Position = UDim2.fromOffset(7, 178),
						Size = UDim2.fromOffset(147, 16),
						BackgroundColor3 = C.Black,
						BackgroundTransparency = 0,
						BorderSizePixel = 0,
						Text = HexFull(),
						TextColor3 = C.Text,
						TextSize = Library.FontSize,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Center,
						ClearTextOnFocus = false,
						FontFace = Library.Font,
						ZIndex = 505,
					})

					Fill(HexBox, 1, 1, 145, 14, C.FrameLight, 505)
					local HexInner = Fill(HexBox, 2, 2, 143, 12, C.InputTop, 505)
					Gradient(HexInner, C.InputTop, C.InputBottom)
					local HexPadding = Make("UIPadding", { Parent = HexBox.Instance, PaddingLeft = UDim.new(0, 6) })

					local Paste = Make("TextButton", {
						Name = "\0",
						Parent = Popup.Instance,
						Position = UDim2.fromOffset(158, 178),
						Size = UDim2.fromOffset(16, 16),
						BackgroundColor3 = C.Black,
						BackgroundTransparency = 0,
						BorderSizePixel = 0,
						Text = "",
						AutoButtonColor = false,
						ZIndex = 505,
					})
					Fill(Paste, 1, 1, 14, 14, C.FrameLight, 505)
					local PasteInner = Fill(Paste, 2, 2, 12, 12, C.InputTop, 505)
					Gradient(PasteInner, C.InputTop, C.InputBottom)

					local Dragging
					local DragConnection
					local DragEnd

					local function StopDrag()
						Dragging = nil

						if DragConnection then
							DragConnection:Disconnect()
							DragConnection = nil
						end

						if DragEnd then
							DragEnd:Disconnect()
							DragEnd = nil
						end
					end

					local function Apply()
						Picker.Value = Color3.fromHSV(Picker.Hue, Picker.Saturation, Picker.Brightness)
						PaintSwatch()
						FlagsUpdate()

						if PopupParts then
							PopupParts:Refresh()
						end
					end

					local function Refresh()
						local HueColor = Color3.fromHSV(Picker.Hue, 1, 1)

						SaturationGradient.Instance.Color = ColorSequence.new(Color3.new(1, 1, 1), HueColor)
						Alpha.Instance.BackgroundColor3 = Picker.Value

						local SX = 9 + math.floor(Picker.Saturation * 145 + 0.5) - 2
						local SY = 9 + math.floor((1 - Picker.Brightness) * 145 + 0.5) - 2

						Mark.Instance.Position = UDim2.fromOffset(SX, SY)
						HueMark.Instance.Position = UDim2.fromOffset(160, 9 + math.floor(Picker.Hue * 145 + 0.5))
						AlphaMark.Instance.Position = UDim2.fromOffset(9 + math.floor(Picker.Alpha * 161 + 0.5), 160)
						HexBox.Instance.Text = HexFull()
					end

					local function Drag(From, To, Function)
						local Area = Make("TextButton", {
							Name = "\0",
							Parent = Popup.Instance,
							Position = UDim2.fromOffset(From[1], From[2]),
							Size = UDim2.fromOffset(To[1], To[2]),
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Text = "",
							Active = true,
							AutoButtonColor = false,
							ZIndex = 508,
						})

						Area:Connect("InputBegan", function(Input)
							if Input.UserInputType ~= Enum.UserInputType.MouseButton1 and Input.UserInputType ~= Enum.UserInputType.Touch then
								return
							end

							Dragging = Function
							Function()

							-- The old picker only applied the point under the initial
							-- click; dragging the saturation/hue/alpha bars did nothing.
							if not DragConnection then
								DragConnection = UserInputService.InputChanged:Connect(function(Move)
									if Dragging and (Move.UserInputType == Enum.UserInputType.MouseMovement or Move.UserInputType == Enum.UserInputType.Touch) then
										Dragging()
									end
								end)
							end

							if not DragEnd then
								DragEnd = UserInputService.InputEnded:Connect(function(Ended)
									if Ended.UserInputType == Enum.UserInputType.MouseButton1 or Ended.UserInputType == Enum.UserInputType.Touch then
										StopDrag()
									end
								end)
							end
						end)
					end

					Drag({ 7, 7 }, { 150, 150 }, function()
						local Mouse = UserInputService:GetMouseLocation()
						local Position = Saturation.Instance.AbsolutePosition
						local Size = Saturation.Instance.AbsoluteSize

						Picker.Saturation = math.clamp((Mouse.X - Position.X) / math.max(Size.X - 1, 1), 0, 1)
						Picker.Brightness = math.clamp(1 - (Mouse.Y - Position.Y) / math.max(Size.Y - 1, 1), 0, 1)
						Apply()
					end)

					Drag({ 161, 7 }, { 13, 150 }, function()
						local Mouse = UserInputService:GetMouseLocation()
						local Position = Hue.Instance.AbsolutePosition
						local Size = Hue.Instance.AbsoluteSize

						Picker.Hue = math.clamp((Mouse.Y - Position.Y) / math.max(Size.Y - 1, 1), 0, 0.999)
						Apply()
					end)

					Drag({ 7, 161 }, { 167, 13 }, function()
						local Mouse = UserInputService:GetMouseLocation()
						local Position = Alpha.Instance.AbsolutePosition
						local Size = Alpha.Instance.AbsoluteSize

						Picker.Alpha = math.clamp((Mouse.X - Position.X) / math.max(Size.X - 1, 1), 0, 1)
						Apply()
					end)

					HexBox.Instance.FocusLost:Connect(function()
						local Text = HexBox.Instance.Text

						if string.sub(Text, 1, 1) == "#" then
							Text = string.sub(Text, 2)
						end

						local AlphaValue

						if #Text == 8 then
							local Byte = tonumber(string.sub(Text, 7, 8), 16)

							if Byte then
								AlphaValue = Byte / 255
							end

							Text = string.sub(Text, 1, 6)
						end

						if #Text == 6 then
							local Ok, Color = pcall(Color3.fromHex, Text)

							if Ok and Color then
								Picker:Set(Color, AlphaValue)
							end
						end

						Refresh()
					end)

					Paste:Connect("MouseButton1Down", function()
						if getclipboard then
							local Ok, Text = pcall(getclipboard)

							if Ok and type(Text) == "string" then
								if string.sub(Text, 1, 1) == "#" then
									Text = string.sub(Text, 2)
								end

								local AlphaValue

								if #Text == 8 then
									local Byte = tonumber(string.sub(Text, 7, 8), 16)

									if Byte then
										AlphaValue = Byte / 255
									end

									Text = string.sub(Text, 1, 6)
								end

								if #Text == 6 then
									local Success, Color = pcall(Color3.fromHex, Text)

									if Success and Color then
										Picker:Set(Color, AlphaValue)
									end
								end
							end
						end

						Refresh()
					end)

					PopupParts = {
						Refresh = Refresh,
					}

					Refresh()
					Alpine.SetPopup(Picker, Popup, Swatch)
				end

				Swatch:Connect("MouseButton1Down", function()
					if Alpine.Popup and Alpine.Popup.Owner == Picker then
						Picker:SetOpen(false)
					else
						Picker:SetOpen(true)
					end
				end)

				if Picker.Flag then
					SetFlags[Picker.Flag] = function(Color, Alpha)
						if type(Color) == "table" then
							if Color.Color then
								local Ok, Parsed = pcall(Color3.fromHex, string.gsub(Color.Color, "#", ""))

								if Ok and Parsed then
									Picker:Set(Parsed, Color.Alpha)
								end
							end
						elseif typeof(Color) == "Color3" then
							Picker:Set(Color, Alpha)
						end
					end
				end

				FlagsUpdate()
				PaintSwatch()

				return setmetatable(Picker, Library)
			end

			-- ----------------------------------------------------------------
			-- toggle: keybind / swatch / settings / popup
			-- ----------------------------------------------------------------
			function Library.AttachKeybind(Toggle, Data)
				return ToggleKeybind(Toggle, Data)
			end

			local ToggleMeta = nil

			local function ToggleKeybindMethod(Toggle, Data)
				return ToggleKeybind(Toggle, Data)
			end

			local function ToggleColorpickerMethod(Toggle, Data)
				Data = Data or { }

				local X = Inline(Toggle, M.SwatchWidth, M.SwatchGap)

				return Library.CreateColorpicker(Toggle.Section, {
					Parent = Toggle.Items["Row"],
					Row = Toggle.Items["Row"],
					X = X,
					Flag = Data.Flag or ("color_" .. tostring(Toggle.Flag)),
					Default = Data.Default,
					Alpha = Data.Alpha,
					Callback = Data.Callback,
					Name = Data.Name or Toggle.Name,
				})
			end

			local OpenSettings

			local function InsideMouse(Data)
				local Object = Data.Instance
				local Mouse = UserInputService:GetMouseLocation()
				local Position = Object.AbsolutePosition
				local Size = Object.AbsoluteSize

				return Mouse.X >= Position.X and Mouse.X <= Position.X + Size.X
					and Mouse.Y >= Position.Y and Mouse.Y <= Position.Y + Size.Y
			end

			Library:Connect(UserInputService.InputBegan, function(Input)
				if not OpenSettings then
					return
				end

				if Input.UserInputType ~= Enum.UserInputType.MouseButton1 and Input.UserInputType ~= Enum.UserInputType.Touch then
					return
				end

				local Panel = OpenSettings.Items["Section"]
				local Expander = OpenSettings.Items["Expander"]

				if InsideMouse(Panel) or (Expander and InsideMouse(Expander)) then
					return
				end

				OpenSettings:SetOpen(false)
			end)

			Alpine.CloseSettings = function()
				if OpenSettings then
					OpenSettings:SetOpen(false)
				end
			end

			local function ToggleSettingsMethod(Toggle, Data)
				Data = Data or { }

				local Section = Toggle.Section
				local RowOffset = (Section.Cursor or M.ToggleAdvance) - M.ToggleAdvance
				local RowWidth = Section.ContentWidth or M.PanelContentWidth

				local Settings = {
					Name = Data.Name or Toggle.Name,
					Items = { },
					Rows = 0,
					Cursor = 0,
					Window = Toggle.Window,
					Page = Toggle.Page,
					Section = Section,
					IsSettings = true,
					Open = false,
					ContentWidth = 277,
					InlineRight = 276,
					InlineGap = 0,
				}

				-- widgets.cpp begin_settings: 291 wide, content at +6 / +23, 277 wide,
				-- height = first row + rows + 2 + 1 border
				local Width = 291
				local Top = M.PanelContentY + M.PanelTopPad + RowOffset + 9

				local Panel = Frame(Section.Items["Section"], M.PanelContentX, Top, Width, 26, C.Black, 20)
				Panel.Instance.Visible = false
				Panel.Instance:SetAttribute("AlpineLayer", 100)

				local Outer = Fill(Panel, 0, 0, Width, 26, C.Black, 20)
				local Light = Fill(Panel, 1, 1, Width - 2, 24, C.PanelLight, 20)
				local Body = Fill(Panel, 2, 5, Width - 4, 19, C.PanelFill, 20)
				Library.Alpine.Shine(Panel, 1, 1, Width - 2, 1, C.PanelBorderTop, C.PanelBorderGlow, 21)
				Library.Alpine.Shine(Panel, 1, 2, Width - 2, 1, C.PanelAccentTop, C.PanelAccentTopGlow, 21)
				Library.Alpine.Shine(Panel, 1, 3, Width - 2, 1, C.PanelAccentBottom, C.PanelAccentBottomGlow, 21)
				Library.Alpine.Shine(Panel, 2, 4, Width - 4, 1, C.PanelFill, C.PanelFillGlow, 21)

				local Title = Label(Panel, M.PanelContentX, 9, Width - 12, Settings.Name, C.Text, Enum.TextXAlignment.Left, 22)

				local Content = Frame(Panel, M.PanelContentX, 23, Settings.ContentWidth, 0, C.Black, 22)
				Content.Instance.BackgroundTransparency = 1
				Content.Instance.AutomaticSize = Enum.AutomaticSize.Y

				Make("UIPadding", { Parent = Content.Instance, PaddingTop = UDim.new(0, 0), PaddingBottom = UDim.new(0, 0) })
				Make("UIListLayout", { Parent = Content.Instance, Padding = UDim.new(0, 0), SortOrder = Enum.SortOrder.LayoutOrder })

				Settings.Items["Content"] = Content
				Settings.Items["Section"] = Panel
				Settings.Items["Text"] = Title

				-- expander on the toggle row (11x11, plus / minus)
				local ExpanderX = Inline(Toggle, M.ExpandSize, M.InlineGap)
				local Expander = Make("TextButton", {
					Parent = Toggle.Items["Row"].Instance,
					Position = UDim2.fromOffset(ExpanderX, M.KeybindOffset),
					Size = UDim2.fromOffset(M.ExpandSize, M.ExpandSize),
					BackgroundColor3 = C.Black,
					BorderSizePixel = 0,
					Text = "",
					AutoButtonColor = false,
					ZIndex = 7,
				})
				local ExpInner = Fill(Expander, 1, 1, M.ExpandSize - 2, M.ExpandSize - 2, C.InputTop, 7)
				local ExpGradient = Gradient(ExpInner, C.InputTop, C.InputBottom)
				local PlusV = Fill(Expander, 5, 3, 1, 5, C.Text, 8)
				local PlusH = Fill(Expander, 3, 5, 5, 1, C.Text, 8)
				local Minus = Fill(Expander, 3, 5, 5, 1, C.Text, 8)
				Minus.Instance.Visible = false

				Settings.Items["Expander"] = Expander

				local function PaintExpander(Hovered)
					ExpGradient.Instance.Color = ColorSequence.new(
						Hovered and C.InputHoverTop or C.InputTop,
						Hovered and C.InputHoverBottom or C.InputBottom
					)
				end

				local function Resize()
					local Height = 26 + Settings.Cursor

					Panel.Instance.Size = UDim2.fromOffset(Width, Height)
					Outer.Instance.Size = UDim2.fromOffset(Width, Height)
					Light.Instance.Size = UDim2.fromOffset(Width - 2, math.max(1, Height - 2))
					Body.Instance.Size = UDim2.fromOffset(Width - 4, math.max(1, Height - 7))
				end

				function Settings:_Row(Advance)
					local Row = Frame(Content, 0, 0, Settings.ContentWidth, Advance, C.Black, 22)
					Row.Instance.BackgroundTransparency = 1
					Row.Instance.LayoutOrder = Settings.Rows

					Settings.Rows += 1
					Settings.Cursor += Advance
					Resize()

					return Row
				end

				function Settings:SetOpen(Bool)
					Settings.Open = Bool and true or false
					Panel.Instance.Visible = Settings.Open
					PlusV.Instance.Visible = not Settings.Open
					PlusH.Instance.Visible = not Settings.Open
					Minus.Instance.Visible = Settings.Open

					if Settings.Open then
						if OpenSettings and OpenSettings ~= Settings then
							OpenSettings:SetOpen(false)
						end

						OpenSettings = Settings
					elseif OpenSettings == Settings then
						OpenSettings = nil
					end
				end

				function Settings:Refresh()
					Resize()
				end

				Expander:Connect("MouseEnter", function()
					PaintExpander(true)
				end)

				Expander:Connect("MouseLeave", function()
					PaintExpander(false)
				end)

				Expander:Connect("MouseButton1Down", function()
					Settings:SetOpen(not Settings.Open)
				end)

				Resize()

				Toggle.SettingsItem = Settings

				return setmetatable(Settings, Library)
			end

			-- every toggle gets these three inline constructors
			local BaseToggle = Library.Toggle

			Library.Toggle = function(Self, Params)
				local Toggle = BaseToggle(Self, Params)

				Toggle.Keybind = function(_, Data)
					return ToggleKeybindMethod(Toggle, Data)
				end

				Toggle.Colorpicker = function(_, Data)
					return ToggleColorpickerMethod(Toggle, Data)
				end

				Toggle.Settings = function(_, Data)
					return ToggleSettingsMethod(Toggle, Data)
				end

				Toggle.Popup = function(_, Data)
					return ToggleSettingsMethod(Toggle, Data)
				end

				return Toggle
			end

			-- section-level constructors attach to the last row widget
			function Library:Colorpicker(Data)
				Data = Data or { }

				local Target = self.LastWidget

				if Target and Target.IsRowWidget and Target.Colorpicker then
					return Target:Colorpicker(Data)
				end

				local Row = self:_Row(M.ToggleAdvance)

				if Data.Name and Data.Name ~= "" then
					Label(Row, 2, 7, (self.ContentWidth or M.PanelContentWidth) - 40, Data.Name, C.Text, Enum.TextXAlignment.Left, 5)
				end

				return Library.CreateColorpicker(self, {
					Row = Row,
					X = (self.ContentWidth or M.PanelContentWidth) - M.SwatchWidth,
					Flag = Data.Flag,
					Default = Data.Default,
					Alpha = Data.Alpha,
					Callback = Data.Callback,
					Name = Data.Name,
				})
			end

			-- ----------------------------------------------------------------
			-- label row (Section:Label, used by InitSettings theme rows)
			-- ----------------------------------------------------------------
			Library.Label = function(Self, Params)
				Params = Params or { }

				local Object = {
					Name = Params.Name or Params.name or "Label",
					Section = Self,
					Window = Self.Window,
					Page = Self.Page,
					Items = { },
					IsRowWidget = true,
					InlineRight = (Self.ContentWidth or M.PanelContentWidth) - 1,
					InlineGap = 0,
				}

				local Row = Self:_Row(M.ToggleAdvance)
				local Text = Label(Row, 2, 7, (Self.ContentWidth or M.PanelContentWidth) - 4, Object.Name, C.Text, Enum.TextXAlignment.Left, 5)

				Object.Items["Label"] = Row
				Object.Items["Text"] = Text

				function Object:SetText(Value)
					Text.Instance.Text = tostring(Value)
				end

				function Object:Colorpicker(Data)
					Data = Data or { }

					local X = Inline(Object, M.SwatchWidth, M.SwatchGap)

					return Library.CreateColorpicker(Self, {
						Parent = Row,
						Row = Row,
						X = X,
						Flag = Data.Flag,
						Default = Data.Default,
						Alpha = Data.Alpha,
						Callback = Data.Callback,
						Name = Data.Name or Object.Name,
					})
				end

				function Object:Keybind(Data)
					Data = Data or { }

					local X = Inline(Object, M.KeybindWidth, M.InlineGap)

					return Library.CreateKeybind(Self, {
						Parent = Row,
						Row = Row,
						X = X,
						Flag = Data.Flag,
						Default = Data.Default,
						Mode = Data.Mode,
						Callback = Data.Callback,
					})
				end

				return setmetatable(Object, Library)
			end

			-- ----------------------------------------------------------------
			-- notifications (notify.cpp)
			-- 35px panel, title left / timer right on row 11, message on row 25,
			-- 10px screen margin under the 26px top bar, 4px stack gap.
			-- ----------------------------------------------------------------
			local Toasts = { }

			-- VerdanaPixel advance widths for ASCII 32..126 at TextSize 12,
			-- read straight from the hosted TTF. TextBounds is not reliable
			-- before the first render, and a toast is often created in the
			-- same frame as the call, so measuring a hidden label there can
			-- return zero and clip the message.
			local Advance = {
				4, 4, 5, 8, 7, 11, 7, 3, 5, 5, 7, 8, 4, 5, 4, 5,
				7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 5, 5, 8, 8, 8, 6,
				10, 7, 7, 8, 8, 6, 6, 8, 8, 5, 5, 7, 6, 9, 7, 9,
				7, 9, 8, 7, 7, 8, 7, 11, 7, 7, 7, 5, 5, 5, 8, 6,
				6, 7, 7, 5, 7, 7, 4, 7, 7, 3, 3, 7, 3, 11, 7, 7,
				7, 7, 4, 6, 4, 7, 6, 7, 7, 6, 6, 6, 5, 6, 8,
			}

			local function MeasureText(Text)
				local Total = 0

				for Index = 1, #Text do
					Total += Advance[string.byte(Text, Index) - 31] or 6
				end

				return Total
			end

			local function Collect(Object, List)
				for _, Child in Object:GetChildren() do
					if Child:IsA("TextLabel") or Child:IsA("TextButton") or Child:IsA("TextBox") then
						table.insert(List, { Object = Child, Property = "TextTransparency" })
					elseif Child:IsA("Frame") then
						table.insert(List, { Object = Child, Property = "BackgroundTransparency" })
					end

					Collect(Child, List)
				end
			end

			local function Tween(Object, Properties, Time)
				if TweenService and TweenService.Create then
					TweenService:Create(Object, TweenInfo.new(Time, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), Properties):Play()
				else
					for Key, Value in Properties do
						Object[Key] = Value
					end
				end
			end

			local function Restack()
				local Cursor = 36

				for _, Toast in ipairs(Toasts) do
					-- only the stack offset moves; the entrance / exit slide owns X
					Tween(Toast.Frame.Instance, {
						Position = UDim2.fromOffset(Toast.Frame.Instance.Position.X.Offset, Cursor),
					}, 0.18)
					Cursor += 39
				end
			end

			local function RemoveToast(Toast)
				local At = table.find(Toasts, Toast)

				if not At then
					return
				end

				table.remove(Toasts, At)

				for _, Entry in Toast.Fade do
					Tween(Entry.Object, { [Entry.Property] = 1 }, 0.25)
				end

				Tween(Toast.Frame.Instance, { Position = UDim2.fromOffset(-6, Toast.Frame.Instance.Position.Y.Offset) }, 0.25)
				task.delay(0.3, function()
					Toast.Frame.Instance:Destroy()
				end)

				Restack()
			end

			Library.Notification = function(Self, Params)
				Params = Params or { }

				if Library.NotificationsEnabled == false then
					return
				end

				local Title = tostring(Params.Title or Params.title or Params.Name or "")
				local Message = tostring(Params.Text or Params.text or Params.Message or "")
				local Duration = tonumber(Params.Time or Params.time) or 5
				local TimerText = string.format("%.1fs", Duration)

				local Header = MeasureText(Title) + MeasureText(TimerText) + 22
				local Body = MeasureText(Message) + 14
				local Width = math.ceil(math.max(150, Header, Body))
				local Height = 35

				local ToastFrame = Frame(Library.Holder.Instance, -6, 0, Width, Height, C.Black, 1, 399)
				Fill(ToastFrame, 1, 1, Width - 2, Height - 2, C.PanelLight, 400)
				Fill(ToastFrame, 2, 5, Width - 4, Height - 7, C.PanelFill, 400)
				Library.Alpine.Shine(ToastFrame, 1, 1, Width - 2, 1, C.PanelBorderTop, C.PanelBorderGlow, 401)
				Library.Alpine.Shine(ToastFrame, 1, 2, Width - 2, 1, C.PanelAccentTop, C.PanelAccentTopGlow, 401)
				Library.Alpine.Shine(ToastFrame, 1, 3, Width - 2, 1, C.PanelAccentBottom, C.PanelAccentBottomGlow, 401)
				Library.Alpine.Shine(ToastFrame, 2, 4, Width - 4, 1, C.PanelFill, C.PanelFillGlow, 401)

				local TimerWidth = math.ceil(MeasureText(TimerText))
				local TitleLabel = Label(ToastFrame, 6, 11, math.max(20, Width - TimerWidth - 20), Title, C.Text, Enum.TextXAlignment.Left, 402)
				local TimerLabel = Label(ToastFrame, Width - 6 - TimerWidth, 11, TimerWidth, TimerText, C.Text, Enum.TextXAlignment.Right, 402)
				local MessageLabel = Label(ToastFrame, 5, 25, Width - 10, Message, C.TextMessage, Enum.TextXAlignment.Left, 402)

				local Toast = {
					Frame = ToastFrame,
					Fade = { },
				}

				local Fade = { { Object = ToastFrame.Instance, Property = "BackgroundTransparency" } }

				Collect(ToastFrame.Instance, Fade)
				Toast.Fade = Fade

				for _, Entry in Fade do
					Entry.Object[Entry.Property] = 1
				end

				ToastFrame.Instance.Position = UDim2.fromOffset(-6, 36 + #Toasts * 39)
				table.insert(Toasts, Toast)
				Restack()

				Tween(ToastFrame.Instance, {
					Position = UDim2.fromOffset(10, ToastFrame.Instance.Position.Y.Offset),
				}, 0.25)

				for _, Entry in Fade do
					Tween(Entry.Object, { [Entry.Property] = 0 }, 0.25)
				end

				local Ends = os.clock() + Duration
				local Clock = Library:Connect(RunService.Heartbeat, function()
					TimerLabel.Instance.Text = string.format("%.1fs", math.max(0, Ends - os.clock()))
				end)

				task.delay(Duration, function()
					if Clock then
						Clock:Disconnect()
					end

					RemoveToast(Toast)
				end)

				return setmetatable(Toast, Library)
			end

			-- ----------------------------------------------------------------
			-- compatibility surface used by Main.lua
			-- ----------------------------------------------------------------
			Library.SourceUI = Library.SourceUI or { }

			function Library:SetSourceUI(Name, Value)
				Library.SourceUI[tostring(Name)] = Value ~= false

				if Name == "players" and Library.PlayerListObject then
					Library.PlayerListObject:SetVisibility(Value ~= false)
				elseif Name == "keybinds" and Library.KeyList then
					Library.KeyList:SetVisibility(Value ~= false)
				elseif Name == "watermark" and Library.WatermarkObject then
					Library.WatermarkObject:SetVisibility(Value ~= false)
				end
			end

			Library.Fps = Library.Fps or { Value = 0, Frames = 0, Last = os.clock() }

			function Library.Fps.Push()
				local Now = os.clock()

				Library.Fps.Frames += 1

				if Now - Library.Fps.Last >= 1 then
					Library.Fps.Value = math.floor(Library.Fps.Frames / (Now - Library.Fps.Last) + 0.5)
					Library.Fps.Frames = 0
					Library.Fps.Last = Now
				end
			end

			function Library.Fps.Get()
				return Library.Fps.Value
			end

			function Library:Diagnostics()
				local Count = 0

				for _, Ok in Library.FontStatus or { } do
					if Ok then
						Count += 1
					end
				end

				print(("[Alpine] pixel fonts %d/3 | text size %d | bar %d | theme %s")
					:format(Count, Library.FontSize, Library.BarFontSize or 13, tostring(Library.CurrentTheme)))

				for Name, Source in Library.FontSources or { } do
					print("[Alpine] font source", Name, tostring(Source))
				end

				for Name, Error in Library.FontErrors or { } do
					print("[Alpine] font error", Name, tostring(Error))
				end

				print(("[Alpine] window %dx%d | content %dx%d | panel %d")
					:format(M.WindowWidth, M.WindowHeight, M.ContentWidth, M.ContentHeight, M.ColumnWidth))

				return Library.FontStatus
			end


			-- ----------------------------------------------------------------
			-- overlay.cpp: top bar, watermark, keybind list, target hud
			-- ----------------------------------------------------------------
			Alpine.Overlay = Alpine.Overlay or { }

			local Overlay = Alpine.Overlay

			Overlay.State = Overlay.State or {
				watermark = true,
				players = false,
				waypoints = false,
				themes = false,
				keybinds = true,
				target_hud = true,
				dex = false,
				configs = false,
				perf = false,
			}

			local function TextAt(Parent, X, CenterY, Width, Value, Color, Font, Size, Align, ZIndex)
				return Make("TextLabel", {
					Parent = Parent,
					-- CenterY is the C++ baseline; the pixel face centres three
					-- pixels above it inside a 16px box.
					Position = UDim2.fromOffset(X, CenterY - 11),
					Size = UDim2.fromOffset(Width, 16),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Text = tostring(Value or ""),
					TextColor3 = Color or C.Text,
					FontFace = Font or Library.Font,
					TextSize = Size or Library.FontSize,
					TextXAlignment = Align or Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Center,
					TextScaled = false,
					TextWrapped = false,
					TextStrokeTransparency = 1,
					TextTruncate = Enum.TextTruncate.AtEnd,
					RichText = false,
					ZIndex = ZIndex or 10,
				})
			end

			local GlowRings = { 70, 40, 22, 11, 5 }

			-- draw::window + draw::window_glow for the floating overlays
			local function Chrome(Panel, Width, Height)
				for Ring = 1, 5 do
					local Spread = Ring
					local Transparency = 1 - (GlowRings[Ring] / 255) * 0.5

					Frame(Panel, -Spread, -Spread, Width + Spread * 2, 1, C.EdgeGlow, Transparency, 1)
					Frame(Panel, -Spread, Height + Spread - 1, Width + Spread * 2, 1, C.EdgeGlow, Transparency, 1)
					Frame(Panel, -Spread, -Spread + 1, 1, Height + Spread * 2 - 2, C.EdgeGlow, Transparency, 1)
					Frame(Panel, Width + Spread - 1, -Spread + 1, 1, Height + Spread * 2 - 2, C.EdgeGlow, Transparency, 1)
				end

				Fill(Panel, 0, 0, Width, Height, C.Black, 2)
				Fill(Panel, 1, 1, Width - 2, Height - 2, C.WindowEdge, 2)
				Fill(Panel, 2, 2, Width - 4, Height - 4, C.Black, 2)
				Fill(Panel, 3, 3, Width - 6, Height - 6, C.OverlayBand, 2)

				Alpine.Shine(Panel, 6, 5, Width - 12, 1, C.HeaderAccentTop, C.HeaderAccentTopGlow, 3)
				Alpine.Shine(Panel, 6, 6, Width - 12, 1, C.HeaderAccentBottom, C.HeaderAccentBottomGlow, 3)
			end

			-- draw::frame
			local function FrameBox(Panel, X, Y, Width, Height, ZIndex, FillColor)
				Fill(Panel, X, Y, Width, Height, C.Black, ZIndex)
				Fill(Panel, X + 1, Y + 1, Width - 2, Height - 2, C.FrameLight, ZIndex)
				Fill(Panel, X + 2, Y + 2, Width - 4, Height - 4, FillColor or C.FrameFill, ZIndex)
			end

			-- draw::panel (used by tool hint boxes)
			local function PanelBox(Parent, X, Y, Width, Height, ZIndex)
				local Z = ZIndex or 8

				Fill(Parent, X, Y, Width, Height, C.Black, Z)
				Alpine.Shine(Parent, X + 1, Y + 1, Width - 2, 1, C.PanelBorderTop, C.PanelBorderGlow, Z)
				Alpine.Shine(Parent, X + 1, Y + 2, Width - 2, 1, C.PanelAccentTop, C.PanelAccentTopGlow, Z)
				Alpine.Shine(Parent, X + 1, Y + 3, Width - 2, 1, C.PanelAccentBottom, C.PanelAccentBottomGlow, Z)
				Alpine.Shine(Parent, X + 1, Y + 4, Width - 2, 1, C.PanelFill, C.PanelFillGlow, Z)
				Fill(Parent, X + 1, Y + 5, Width - 2, Height - 6, C.PanelFill, Z)
				Fill(Parent, X + 1, Y + 4, 1, Height - 5, C.PanelLight, Z)
				Fill(Parent, X + Width - 2, Y + 4, 1, Height - 5, C.PanelLight, Z)
				Fill(Parent, X + 1, Y + Height - 2, Width - 2, 1, C.PanelLight, Z)
			end

			-- draw::text_field / render_input in tools.cpp
			local function ToolInput(Parent, X, Y, Width, Height, ZIndex)
				local Z = ZIndex or 10

				Fill(Parent, X, Y, Width, Height, C.Black, Z)
				local Inner = Make("Frame", {
					Parent = Parent,
					Position = UDim2.fromOffset(X + 1, Y + 1),
					Size = UDim2.fromOffset(Width - 2, Height - 2),
					BackgroundColor3 = C.InputTop,
					BackgroundTransparency = 0,
					BorderSizePixel = 0,
					ZIndex = Z,
				})

				Gradient(Inner, C.InputTop, C.InputBottom)
				return Inner
			end

			local function ToolField(Parent, X, Y, Width, Text, Placeholder, Changed, ZIndex)
				local Height = 18

				ToolInput(Parent, X, Y, Width, Height, ZIndex or 10)

				local Box = Make("TextBox", {
					Parent = Parent,
					Position = UDim2.fromOffset(X + 5, Y + 1),
					Size = UDim2.fromOffset(Width - 10, Height - 2),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Text = Text or "",
					PlaceholderText = Placeholder or "",
					PlaceholderColor3 = C.TextDim,
					TextColor3 = C.Text,
					FontFace = Library.Font,
					TextSize = Library.FontSize,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Center,
					TextScaled = false,
					ClearTextOnFocus = false,
					ZIndex = (ZIndex or 10) + 2,
				})

				if Changed then
					Box.Instance:GetPropertyChangedSignal("Text"):Connect(function()
						Changed(Box.Instance.Text)
					end)
				end

				return Box
			end

			local function ToolButton(Parent, X, Y, Width, Height, Text, Clicked, ZIndex)
				local Z = ZIndex or 14
				local Button = Make("TextButton", {
					Parent = Parent,
					Position = UDim2.fromOffset(X, Y),
					Size = UDim2.fromOffset(Width, Height),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Text = "",
					AutoButtonColor = false,
					ZIndex = Z,
				})

				Fill(Button, 0, 0, Width, Height, C.Black, 1)
				local Inner = Fill(Button, 1, 1, Width - 2, Height - 2, C.InputTop, 1)
				local Shade = Gradient(Inner, C.InputTop, C.InputBottom)
				local Label = TextAt(Button, 0, Height / 2, Width, Text, C.Text, Library.Font, Library.FontSize, Enum.TextXAlignment.Center, 2)

				Button:Connect("MouseEnter", function()
					Shade.Instance.Color = ColorSequence.new(C.InputHoverTop, C.InputHoverBottom)
					Label.Instance.TextColor3 = C.Text
				end)

				Button:Connect("MouseLeave", function()
					Shade.Instance.Color = ColorSequence.new(C.InputTop, C.InputBottom)
				end)

				Button:Connect("MouseButton1Down", function()
					if Clicked then
						Clicked()
					end
				end)

				return Button
			end

			local function ToolSearch(Parent, X, Y, Width, Placeholder, Changed, ZIndex)
				local FieldWidth = Width - 50
				local Box = ToolField(Parent, X, Y, FieldWidth, "", Placeholder, Changed, ZIndex)

				ToolButton(Parent, X + Width - 46, Y, 46, 18, "Clear", function()
					Box.Instance.Text = ""
				end, ZIndex)

				return Box, Y + 18
			end

			local function ToolRow(Parent, X, Y, Width, Text, Selected, Clicked, ZIndex)
				local Z = ZIndex or 12
				local Row = Make("TextButton", {
					Parent = Parent,
					Position = UDim2.fromOffset(X, Y),
					Size = UDim2.fromOffset(Width, 17),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Text = "",
					AutoButtonColor = false,
					ZIndex = Z,
				})

				local Hover = Fill(Row, 0, 0, Width, 17, C.InputHoverTop, 1)
				Hover.Instance.BackgroundTransparency = 1

				local Pick = Fill(Row, 0, 0, Width, 17, C.FillTop, 1)
				Gradient(Pick, C.FillTop, C.FillBottom)
				Pick.Instance.BackgroundTransparency = Selected and 0 or 1

				TextAt(Row, 5, 8.5, Width - 10, Text, C.Text, Library.Font, Library.FontSize, Enum.TextXAlignment.Left, 2)

				Row:Connect("MouseEnter", function()
					if not Selected then
						Hover.Instance.BackgroundTransparency = 0.65
					end
				end)

				Row:Connect("MouseLeave", function()
					Hover.Instance.BackgroundTransparency = 1
				end)

				Row:Connect("MouseButton1Down", function()
					if Clicked then
						Clicked()
					end
				end)

				return Row
			end

			local function ToolNotify(Message)
				if Library.Notification then
					Library:Notification({
						Title = "hello world",
						Message = Message,
						Time = 5,
					})
				end
			end

			local ToolAvatar

			local function BuildPlayersTool(Overlay, Tool, Body, W, H)
				local InnerX, InnerY = 5, 5
				local InnerW = W - 10
				local ListY = InnerY + 18 + 5
				local InfoY = H - 100
				local ListH = InfoY - 5 - 1 - ListY
				local Selected = -1
				local Query = ""
				local Names = { "dbxlll", "hi again" }

				FrameBox(Body, InnerX, ListY, InnerW, ListH, 8, C.PanelFill)
				FrameBox(Body, InnerX, InfoY, InnerW, 96, 8, C.PanelFill)

				local Rows = Make("Frame", {
					Parent = Body,
					Position = UDim2.fromOffset(InnerX, ListY),
					Size = UDim2.fromOffset(InnerW, ListH),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					ZIndex = 10,
				})

				ToolAvatar(Body, 10, InfoY + 5, 87, 87, 9)

				local SelectLabel = TextAt(Body, InnerX, InfoY + 48, InnerW, "select a player", C.TextDim, Library.Font, Library.FontSize, Enum.TextXAlignment.Center, 12)
				local NameLabel = TextAt(Body, 106, InfoY + 15, InnerW - 111, "", C.Text, Library.BoldFont, Library.FontSize, Enum.TextXAlignment.Left, 12)
				local HealthLabel = TextAt(Body, 106, InfoY + 31, InnerW - 111, "health: 100 / 100", C.TextDim, Library.Font, Library.FontSize, Enum.TextXAlignment.Left, 12)
				local TeamLabel = TextAt(Body, 106, InfoY + 45, InnerW - 111, "team: none", C.TextDim, Library.Font, Library.FontSize, Enum.TextXAlignment.Left, 12)
				local DistLabel = TextAt(Body, 106, InfoY + 59, InnerW - 111, "distance: 0 studs", C.TextDim, Library.Font, Library.FontSize, Enum.TextXAlignment.Left, 12)

				local function RefreshInfo()
					local Has = Selected >= 0 and Selected < #Names

					SelectLabel.Instance.Visible = not Has
					NameLabel.Instance.Visible = Has
					HealthLabel.Instance.Visible = Has
					TeamLabel.Instance.Visible = Has
					DistLabel.Instance.Visible = Has

					if Has then
						NameLabel.Instance.Text = Names[Selected + 1]
					end
				end

				local function RefreshRows()
					Rows.Instance:ClearAllChildren()

					local Found = 0
					local Lower = string.lower(Query)

					for Index, Name in ipairs(Names) do
						if Lower == "" or string.find(string.lower(Name), Lower, 1, true) then
							local Row = ToolRow(Rows, 2, 2 + Found * 17, InnerW - 4, Name, Selected == Index - 1, function()
								Selected = Selected == Index - 1 and -1 or Index - 1
								RefreshRows()
								RefreshInfo()
							end, 11)

							Row.Instance.Name = "\0"
							Found += 1
						end
					end

					if Found == 0 then
						TextAt(Rows, 0, ListH / 2, InnerW, "no players found", C.TextDim, Library.Font, Library.FontSize, Enum.TextXAlignment.Center, 11)
					end
				end

				ToolField(Body, InnerX, InnerY, InnerW, "", "search players...", function(Text)
					Query = Text
					RefreshRows()
				end, 10)

				RefreshRows()
				RefreshInfo()
			end

			local function BuildWaypointsTool(Overlay, Tool, Body, W, H)
				local InnerX, InnerY = 5, 5
				local InnerW = W - 10
				local ListY = 28
				local ButtonsTop = H - 40
				local ListH = ButtonsTop - 5 - 1 - ListY
				local Selected = -1
				local Waypoints = { }

				FrameBox(Body, InnerX, ListY, InnerW, ListH, 8, C.PanelFill)

				local Rows = Make("Frame", {
					Parent = Body,
					Position = UDim2.fromOffset(7, ListY + 2),
					Size = UDim2.fromOffset(InnerW - 4, ListH - 4),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					ZIndex = 10,
				})

				local Field

				local function Refresh()
					Rows.Instance:ClearAllChildren()

					for Index, Name in ipairs(Waypoints) do
						ToolRow(Rows, 0, (Index - 1) * 17, InnerW - 8, Name, Selected == Index - 1, function()
							Selected = Selected == Index - 1 and -1 or Index - 1

							if Selected >= 0 then
								Field.Instance.Text = Waypoints[Selected + 1]
							end

							Refresh()
						end, 11)
					end
				end

				Field = ToolField(Body, InnerX, InnerY, InnerW, "", "waypoint name...", nil, 10)

				local Half = math.floor((InnerW - 4) * 0.5)
				local SecondX = InnerX + Half + 4
				local SecondW = InnerW - Half - 4

				ToolButton(Body, InnerX, ButtonsTop, Half, 16, "Save", function()
					local Name = Field.Instance.Text

					if Name == "" then
						ToolNotify("enter a waypoint name first")
					elseif #Waypoints >= 64 then
						ToolNotify("waypoint list is full")
					else
						table.insert(Waypoints, Name)
						Selected = #Waypoints - 1
						Refresh()
						ToolNotify("saved waypoint " .. Name)
					end
				end)

				ToolButton(Body, SecondX, ButtonsTop, SecondW, 16, "Overwrite", function()
					if Selected < 0 then
						ToolNotify("select a waypoint first")
					else
						if Field.Instance.Text ~= "" then
							Waypoints[Selected + 1] = Field.Instance.Text
						end

						ToolNotify("overwrote waypoint " .. Waypoints[Selected + 1])
						Refresh()
					end
				end)

				ToolButton(Body, InnerX, ButtonsTop + 20, Half, 16, "Delete", function()
					if Selected < 0 then
						ToolNotify("select a waypoint first")
					else
						ToolNotify("deleted waypoint " .. Waypoints[Selected + 1])
						table.remove(Waypoints, Selected + 1)
						Selected = -1
						Refresh()
					end
				end)

				ToolButton(Body, SecondX, ButtonsTop + 20, SecondW, 16, "Teleport", function()
					if Selected < 0 then
						ToolNotify("select a waypoint first")
					else
						ToolNotify("teleported to " .. Waypoints[Selected + 1])
					end
				end)

				Refresh()
			end

			local function BuildConfigsTool(Overlay, Tool, Body, W, H)
				local InnerX, InnerY = 5, 5
				local InnerW = W - 10
				local ListY = 28
				local ButtonsTop = H - 60
				local ListH = ButtonsTop - 5 - 1 - ListY
				local const = "Hi dbxlll"
				local Selected = false
				local Field
				local RowPick

				FrameBox(Body, InnerX, ListY, InnerW, ListH, 8, C.PanelFill)

				local Row = ToolRow(Body, InnerX + 2, ListY + 2, InnerW - 4, const, false, function()
					Selected = not Selected

					if Selected then
						Field.Instance.Text = const
					end

					if RowPick then
						RowPick.BackgroundTransparency = Selected and 0 or 1
					end
				end, 12)

				RowPick = Row.Instance:FindFirstChild("Pick")

				if not RowPick then
					-- ToolRow names its children positionally; use the second fill it owns.
					local Fills = { }

					for _, Child in Row.Instance:GetChildren() do
						if Child:IsA("Frame") then
							table.insert(Fills, Child)
						end
					end

					RowPick = Fills[2]
				end

				TextAt(Body, InnerX + 7 + MeasureText(const) + 4, ListY + 10.5, 100, "(autoloading)", C.TextDim, Library.Font, Library.FontSize, Enum.TextXAlignment.Left, 13)

				Field = ToolField(Body, InnerX, InnerY, InnerW, "", "config name...", nil, 10)

				local Buttons = { "Save", "Overwrite", "Load", "Delete", "Refresh", "Set Autoload" }
				local Messages = {
					"saved config hi dbxlll",
					"overwrote config hi dbxlll",
					"loaded config hi dbxlll",
					"hi dbxlll is the only config, it stays",
					"found 1 config",
					"hi dbxlll set to autoload",
				}

				local Half = math.floor((InnerW - 4) * 0.5)

				for Index, Text in ipairs(Buttons) do
					local X = InnerX + (Index % 2 == 1 and 0 or Half + 4)
					local Width = Index % 2 == 1 and Half or InnerW - Half - 4
					local Y = ButtonsTop + math.floor((Index - 1) / 2) * 20

					ToolButton(Body, X, Y, Width, 16, Text, function()
						ToolNotify(Messages[Index])
					end)
				end
			end

			local function BuildDexTool(Overlay, Tool, Body, W, H)
				local InnerX, InnerY = 5, 5
				local InnerW = W - 10
				local HintH = 110
				local HintY = H - 5 - HintH + 1
				local TreeY = 28
				local TreeH = HintY - 5 - 1 - TreeY

				ToolSearch(Body, InnerX, InnerY, InnerW, "Search name or class...", function() end, 10)
				FrameBox(Body, InnerX, TreeY, InnerW, TreeH, 8, C.PanelFill)
				PanelBox(Body, InnerX, HintY, InnerW, HintH, 8)
				TextAt(Body, InnerX, HintY + HintH / 2, InnerW, "Right-click for options, left-click to select", C.TextDim, Library.Font, Library.FontSize, Enum.TextXAlignment.Center, 12)
			end

			local function BuildPerfTool(Overlay, Tool, Body, W, H)
				local InnerX, InnerY = 5, 5
				local InnerW = W - 10
				local HeaderY = 28
				local ListY = HeaderY + 20
				local InfoH = 150
				local InfoY = H - 5 - InfoH + 1
				local ListH = InfoY - 5 - 1 - ListY
				local Columns = {
					{ "Thread ^", 0.0 },
					{ "Hz", 0.42 },
					{ "avg ms", 0.54 },
					{ "CPU%", 0.68 },
					{ "Hz graph", 0.80 },
				}

				ToolSearch(Body, InnerX, InnerY, InnerW, "Filter thread name...", function() end, 10)
				FrameBox(Body, InnerX, HeaderY, InnerW, 17, 8, C.PanelFill)

				local Span = InnerW - 10

				for _, Column in ipairs(Columns) do
					TextAt(Body, InnerX + 5 + math.floor(Span * Column[2]), HeaderY + 8.5, 100, Column[1], C.TextDim, Library.Font, Library.FontSize, Enum.TextXAlignment.Left, 11)
				end

				FrameBox(Body, InnerX, ListY, InnerW, ListH, 8, C.PanelFill)

				local ThreadRows = {
					{ "Render", "60", "16.67", "42.1" },
					{ "Heartbeat", "60", "16.67", "31.4" },
					{ "Script", "20", "3.00", "12.8" },
					{ "Physics", "60", "1.40", "6.2" },
				}

				for Index, Row in ipairs(ThreadRows) do
					local Y = ListY + 10 + (Index - 1) * 15

					TextAt(Body, InnerX + 6, Y, 140, Row[1], C.Text, Library.Font, Library.FontSize, Enum.TextXAlignment.Left, 11)
					TextAt(Body, InnerX + 5 + math.floor(Span * 0.42), Y, 44, Row[2], C.TextDim, Library.Font, Library.FontSize, Enum.TextXAlignment.Left, 11)
					TextAt(Body, InnerX + 5 + math.floor(Span * 0.54), Y, 44, Row[3], C.TextDim, Library.Font, Library.FontSize, Enum.TextXAlignment.Left, 11)
					TextAt(Body, InnerX + 5 + math.floor(Span * 0.68), Y, 44, Row[4], C.TextDim, Library.Font, Library.FontSize, Enum.TextXAlignment.Left, 11)
				end

				PanelBox(Body, InnerX, InfoY, InnerW, InfoH, 8)
				TextAt(Body, InnerX + 8, InfoY + 14, InnerW - 16, "Frame time graph", C.Text, Library.Font, Library.FontSize, Enum.TextXAlignment.Left, 12)
				TextAt(Body, InnerX + 8, InfoY + 14, InnerW - 16, "0 - 33 ms", C.TextDim, Library.Font, Library.FontSize, Enum.TextXAlignment.Right, 12)

				local GraphX = InnerX + 8
				local GraphY = InfoY + 22
				local GraphW = InnerW - 16
				local GraphH = InfoH - 30
				local BarCount = 48
				local BarWidth = math.max(1, math.floor((GraphW - 2) / BarCount))
				local Heights = table.create(BarCount, 0)
				local Bars = { }

				Fill(Body, GraphX, GraphY, GraphW, GraphH, C.Content, 9)

				for Index = 1, 3 do
					local Y = GraphY + math.floor(GraphH * (Index - 1) / 3)
					Fill(Body, GraphX, Y, GraphW, 1, C.FrameLight, 10)
				end

				for Index = 1, BarCount do
					local Bar = Fill(Body, GraphX + (Index - 1) * BarWidth, GraphY + GraphH - 1, BarWidth, 1, C.FillTop, 11)
					table.insert(Bars, Bar)
				end

				local LastGraph = 0

				Library:Connect(RunService.Heartbeat, function()
					local Now = os.clock()

					if Now - LastGraph < 0.1 or not Body.Instance.Parent or not Tool.Panel.Instance.Visible then
						return
					end

					LastGraph = Now

					local Fps = math.max(1, Library.Fps:Get() or 60)
					local Milliseconds = math.clamp(1000 / Fps, 0, 33)

					table.remove(Heights, 1)
					table.insert(Heights, Milliseconds)

					for Index, Bar in ipairs(Bars) do
						local Height = math.max(1, math.floor(Heights[Index] / 33 * (GraphH - 2) + 0.5))
						Bar.Instance.Size = UDim2.fromOffset(BarWidth, Height)
						Bar.Instance.Position = UDim2.fromOffset(GraphX + (Index - 1) * BarWidth, GraphY + GraphH - Height)
					end
				end)
			end

			local function BuildColorsTool(Overlay, Tool, Body, W, H)
				local Rows = {
					{ "Accent", C.HeaderAccentTop },
					{ "Shine", C.TextTitle },
					{ "Outline", C.Black },
					{ "Text Outline", C.Black },
					{ "Border", C.FrameLight },
					{ "Background", C.Content },
					{ "Bg Top", C.HeaderGradTop },
					{ "Bg Bot", C.HeaderGradBottom },
					{ "Child Fill", C.PanelFill },
					{ "Child Top", C.InputTop },
					{ "Child Bot", C.InputBottom },
					{ "Grab", C.FillTop },
					{ "Text", C.Text },
					{ "Text Dim", C.TextDim },
					{ "Grad Top", C.FillTop },
					{ "Grad Bot", C.FillBottom },
				}

				local FirstY = 11

				for Index, Entry in ipairs(Rows) do
					local Y = FirstY + (Index - 1) * 14

					TextAt(Body, 8, Y, 140, Entry[1], C.Text, Library.Font, Library.FontSize, Enum.TextXAlignment.Left, 10)

					local SwatchX = W - 29
					Fill(Body, SwatchX, Y - 5, 22, 10, C.Black, 10)
					local Swatch = Fill(Body, SwatchX + 1, Y - 4, 20, 8, Entry[2], 10)
					Gradient(Swatch, Entry[2], Color3.new(Entry[2].R * 0.8, Entry[2].G * 0.8, Entry[2].B * 0.8))
				end

				local SliderY = FirstY + #Rows * 14

				TextAt(Body, 8, SliderY, 88, "Menu Glow", C.Text, Library.Font, Library.FontSize, Enum.TextXAlignment.Left, 10)
				Fill(Body, 104, SliderY - 3, W - 112, 10, C.Black, 10)
				Fill(Body, 105, SliderY - 2, W - 114, 8, C.InputBottom, 10)
				Fill(Body, 105, SliderY - 2, math.floor((W - 114) * 0.25), 8, C.TabAccentTop, 10)

				TextAt(Body, 8, SliderY + 27, 88, "Bg Blur", C.Text, Library.Font, Library.FontSize, Enum.TextXAlignment.Left, 10)
				Fill(Body, 104, SliderY + 24, W - 112, 10, C.Black, 10)
				Fill(Body, 105, SliderY + 25, W - 114, 8, C.InputBottom, 10)

				local ComboY = SliderY + 54
				TextAt(Body, 8, ComboY + 8, 88, "Preset", C.Text, Library.Font, Library.FontSize, Enum.TextXAlignment.Left, 10)
				ToolInput(Body, 104, ComboY, W - 112, 16, 10)
				TextAt(Body, 109, ComboY + 8, W - 130, "Default", C.Text, Library.Font, Library.FontSize, Enum.TextXAlignment.Left, 12)
				TextAt(Body, W - 24, ComboY + 8, 12, "v", C.TextDim, Library.BarFont, Library.BarFontSize, Enum.TextXAlignment.Center, 12)

				ToolButton(Body, 8, ComboY + 33, W - 16, 16, "Apply Theme", function()
					ToolNotify("applied the Default theme")
				end)
			end

			function ToolAvatar(Parent, X, Y, Width, Height, ZIndex)
				local Z = ZIndex or 9

				Fill(Parent, X, Y, Width, Height, C.Black, Z)
				local Inner = Fill(Parent, X + 1, Y + 1, Width - 2, Height - 2, C.InputTop, Z)
				Gradient(Inner, C.InputTop, C.InputBottom)

				local Clip = Make("Frame", {
					Parent = Parent,
					Position = UDim2.fromOffset(X + 1, Y + 1),
					Size = UDim2.fromOffset(Width - 2, Height - 2),
					BackgroundTransparency = 1,
					ClipsDescendants = true,
					ZIndex = Z + 1,
				})

				local HeadSize = math.floor(math.min(Width, Height) * 0.34)
				local Head = Make("Frame", {
					Parent = Clip,
					Position = UDim2.fromOffset(math.floor((Width - HeadSize) * 0.5) - 1, math.floor(Height * 0.34) - math.floor(HeadSize * 0.5)),
					Size = UDim2.fromOffset(HeadSize, HeadSize),
					BackgroundColor3 = C.TextDim,
					BackgroundTransparency = 0.75,
					BorderSizePixel = 0,
					ZIndex = Z + 2,
				})

				Make("UICorner", { Parent = Head.Instance, CornerRadius = UDim.new(0.5, 0) })

				local Body = Make("Frame", {
					Parent = Clip,
					Position = UDim2.fromOffset(math.floor(Width * 0.31), math.floor(Height * 0.34) + HeadSize + 3),
					Size = UDim2.fromOffset(math.floor(Width * 0.38) * 2, Height),
					BackgroundColor3 = C.TextDim,
					BackgroundTransparency = 0.75,
					BorderSizePixel = 0,
					ZIndex = Z + 2,
				})

				Make("UICorner", { Parent = Body.Instance, CornerRadius = UDim.new(0.5, 0) })
			end

			function Overlay:Apply()
				if self.WatermarkPanel then
					self.WatermarkPanel.Instance.Visible = self.State.watermark
				end

				if self.KeybindsPanel then
					self.KeybindsPanel.Instance.Visible = self.State.keybinds
				end

				if self.TargetHudPanel then
					self.TargetHudPanel.Instance.Visible = self.State.target_hud
				end

				self:ApplyTools()
			end

			function Overlay:ApplyTools()
				if not self.Tools then
					return
				end

				local Open = self.Window and self.Window.IsOpen

				for Key, Tool in self.Tools do
					Tool.Panel.Instance.Visible = Open and self.State[Key] or false
				end

				if self.PreviewPanel then
					local VisualsPage = self.Window.Pages[2]
					local IsVisuals = VisualsPage ~= nil and self.Window.Current == VisualsPage
					self.PreviewPanel.Instance.Visible = Open and IsVisuals or false

					if self.RefreshPreview then
						self:RefreshPreview()
					end
				end
			end

			function Overlay:SetFlag(Name, Value)
				local Key = tostring(Name)
				self.State[Key] = Value ~= false
				self:Apply()

				if self.Items and self.Items[Key] then
					self:PaintItem(self.Items[Key])
				end
			end

			function Overlay:PaintItem(Item)
				local Active = self.State[Item.Key]

				Item.Button.Instance.TextColor3 = Item.Hovered and C.Text or (Active and C.TextActive or C.TextTitle)
				Item.Button.Instance.FontFace = Active and (Library.BoldFont or Library.Font) or (Library.BarFont or Library.Font)
			end

			function Overlay:ToggleFlag(Key)
				local Value = not self.State[Key]
				self:SetFlag(Key, Value)

				local Lower = string.lower(Key)
				local Message = Lower .. " " .. (Value and "enabled" or "disabled")

				if Library.Notification then
					Library:Notification({
						Title = self.Window and self.Window.UserName or "dbxlll",
						Message = Message,
						Time = 5,
					})
				end
			end

			function Overlay:BuildWatermark(Screen)
				local Window = self.Window
				local Name = tostring(Window.UserName or "dbxlll")
				local Build = "build: " .. tostring(Window.BuildDate or "")
				local Slash = MeasureText("/")
				local Content = MeasureText(Name) + 55 + MeasureText(Build) + Slash * 2 + 7 * 4
				local Width = math.ceil(Content + 12 + 10 + 12)
				local Height = 32
				local Panel = Make("Frame", {
					Parent = self.Root,
					Position = UDim2.fromOffset(Screen.X - 26 - Width, 26 + 20),
					Size = UDim2.fromOffset(Width, Height),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 20,
				})

				Chrome(Panel, Width, Height)
				FrameBox(Panel, 6, 8, Width - 12, Height - 14, 8)

				local X = 6 + 12
				local NameLabel = TextAt(Panel, X, 17, MeasureText(Name), Name, C.Text, Library.BoldFont, Library.FontSize, Enum.TextXAlignment.Left, 9)
				X += MeasureText(Name) + 7
				TextAt(Panel, X, 17, Slash, "/", C.TextSeparator, Library.BoldFont, Library.FontSize, Enum.TextXAlignment.Left, 9)
				X += Slash + 7

				local FpsLabel = TextAt(Panel, X, 17, 55, "fps: 60", C.Text, Library.BoldFont, Library.FontSize, Enum.TextXAlignment.Center, 9)
				X += 55 + 7
				TextAt(Panel, X, 17, Slash, "/", C.TextSeparator, Library.BoldFont, Library.FontSize, Enum.TextXAlignment.Left, 9)
				X += Slash + 7
				TextAt(Panel, X, 17, MeasureText(Build), Build, C.Text, Library.BoldFont, Library.FontSize, Enum.TextXAlignment.Left, 9)

				self.WatermarkPanel = Panel
				self.WatermarkName = NameLabel

				local FpsLast = 0

				Library:Connect(RunService.Heartbeat, function()
					local Now = os.clock()

					if Now - FpsLast < 1 or not Panel.Instance.Parent then
						return
					end

					FpsLast = Now
					FpsLabel.Instance.Text = "fps: " .. tostring(Library.Fps and Library.Fps:Get() or 60)
				end)
			end

			function Overlay:CollectBinds()
				local Binds = { }
				local Order = {
					{ Flag = "aimbot.key", Enabled = "aimbot.enabled", Name = "aimbot" },
					{ Flag = "orbit.key", Enabled = "orbit.enabled", Name = "orbit" },
					{ Flag = "silent.key", Enabled = "silent.enabled", Name = "silent aim" },
					{ Flag = "trigger.key", Enabled = "trigger.enabled", Name = "triggerbot" },
					{ Flag = "visuals.key", Enabled = "visuals.enabled", Name = "esp" },
				}

				for _, Entry in ipairs(Order) do
					local Bind = Flags[Entry.Flag]
					local Enabled = Flags[Entry.Enabled]

					if Enabled == nil then
						Enabled = true
					end

					if type(Bind) == "table" and Enabled then
						local Key = tostring(Bind.Key or "None")
						local Mode = tostring(Bind.Mode or "Toggle")
						local Text

						if Mode == "Always" or Key == "None" then
							Text = "(Always)"
						else
							Text = "(" .. Key .. ", " .. string.lower(Mode) .. ")"
						end

						table.insert(Binds, { Name = Entry.Name, Mode = Text })
					end
				end

				return Binds
			end

			function Overlay:BuildKeybinds(Screen, Force)
				if not self.Root then
					return
				end

				local Binds = self:CollectBinds()
				local Signature = ""

				for _, Bind in ipairs(Binds) do
					Signature ..= Bind.Name .. "|" .. Bind.Mode .. ";"
				end

				if not Force and Signature == self.BindSignature then
					return
				end

				self.BindSignature = Signature

				if not self.KeybindsPanel then
					self.KeybindsPanel = Make("Frame", {
						Parent = self.Root,
						Position = UDim2.fromOffset(10, math.floor(Screen.Y * 0.4)),
						Size = UDim2.fromOffset(152, 32),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						ZIndex = 30,
					})
				end

				local Panel = self.KeybindsPanel
				Panel.Instance:ClearAllChildren()

				local Width = 152

				for _, Bind in ipairs(Binds) do
					local Needed = math.ceil(12 + 9 + MeasureText(Bind.Name) + 20 + MeasureText(Bind.Mode) + 8)
					Width = math.max(Width, Needed)
				end

				local BodyHeight = #Binds > 0 and (4 + #Binds * 14) or 0
				local Height = 26 + (BodyHeight > 0 and BodyHeight + 3 or 0) + 6

				Panel.Instance.Size = UDim2.fromOffset(Width, Height)

				Chrome(Panel, Width, Height)
				FrameBox(Panel, 6, 8, Width - 12, 18, 8)
				TextAt(Panel, 11, 17, Width - 22, "Keybinds", C.Text, Library.BoldFont, Library.FontSize, Enum.TextXAlignment.Left, 9)

				if BodyHeight > 0 then
					FrameBox(Panel, 6, 29, Width - 12, BodyHeight, 8)

					for Index, Bind in ipairs(Binds) do
						local Row = 29 + 9 + (Index - 1) * 14

						TextAt(Panel, 6 + 9, Row, Width - 37, Bind.Name, C.Text, Library.Font, Library.FontSize, Enum.TextXAlignment.Left, 9)
						TextAt(Panel, 6, Row, Width - 21, Bind.Mode, C.TextDim, Library.Font, Library.FontSize, Enum.TextXAlignment.Right, 9)
					end
				end

				Panel.Instance.Visible = self.State.keybinds
			end

			function Overlay:BuildTargetHud(Screen)
				local Width, Height = 192, 84
				local Panel = Make("Frame", {
					Parent = self.Root,
					Position = UDim2.fromOffset(Screen.X - 26 - Width, 26 + 20 + 32 + 6),
					Size = UDim2.fromOffset(Width, Height),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 40,
				})

				Chrome(Panel, Width, Height)

				local TitleWidth = Width - 12
				FrameBox(Panel, 6, 8, TitleWidth, 18, 8)
				TextAt(Panel, 6, 17, TitleWidth, "Target", C.Text, Library.BoldFont, Library.FontSize, Enum.TextXAlignment.Center, 9)

				local BodyWidth = Width - 12
				local BodyHeight = Height - 36
				FrameBox(Panel, 6, 30, BodyWidth, BodyHeight, 8)

				-- draw::avatar is a gradient box in target_hud
				Fill(Panel, 8, 32, 44, 44, C.Black, 9)
				local Pfp = Fill(Panel, 9, 33, 42, 42, C.InputTop, 9)
				Gradient(Pfp, C.InputTop, C.InputBottom)

				TextAt(Panel, 55, 38, 100, "ext", C.TextTarget, Library.Font, Library.FontSize, Enum.TextXAlignment.Left, 9)

				local BarWidth = Width - 64
				local BarHeight = 30
				local BarX, BarY = 54, 44

				Fill(Panel, BarX, BarY, BarWidth, BarHeight, C.Black, 9)
				Fill(Panel, BarX + 1, BarY + 1, BarWidth - 2, BarHeight - 2, C.InputBottom, 9)

				if BarWidth > 4 then
					Fill(Panel, BarX + 1, BarY + 1, BarWidth - 2, BarHeight - 2, C.HealthLight, 10)
					Fill(Panel, BarX + 2, BarY + 2, BarWidth - 4, BarHeight - 4, C.HealthTop, 10)
					local Health = Fill(Panel, BarX + 2, BarY + 2, BarWidth - 4, BarHeight - 4, C.HealthTop, 11)
					Gradient(Health, C.HealthTop, C.HealthBottom)
					Fill(Panel, BarX + 2, BarY + 2, BarWidth - 4, 1, C.HealthAccent, 12)
					Fill(Panel, BarX + 2, BarY + 3, BarWidth - 4, 1, C.HealthShade, 12)
				end

				TextAt(Panel, BarX, BarY + 15, BarWidth, "100 / 100", C.Text, Library.Font, Library.FontSize, Enum.TextXAlignment.Center, 13)

				self.TargetHudPanel = Panel
			end

			function Overlay:BuildTopBar(Screen)
				local Window = self.Window
				local Bar = Make("Frame", {
					Parent = self.Root,
					Position = UDim2.fromOffset(0, 0),
					Size = UDim2.new(1, 0, 0, 26),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 50,
				})

				local function BarFill(Y, Height, Color, ZIndex)
					return Make("Frame", {
						Parent = Bar,
						Position = UDim2.fromOffset(0, Y),
						Size = UDim2.new(1, 0, 0, Height),
						BackgroundColor3 = Color,
						BorderSizePixel = 0,
						ZIndex = ZIndex or 51,
					})
				end

				local BarWidth = Screen.X

				if not BarWidth or BarWidth <= 0 then
					BarWidth = 1920
				end

				Alpine.Shine(Bar, 0, 0, BarWidth, 1, C.HeaderAccentTop, C.HeaderAccentTopGlow, 51, 64)
				Alpine.Shine(Bar, 0, 1, BarWidth, 1, C.HeaderAccentBottom, C.HeaderAccentBottomGlow, 51, 64)
				local Body = BarFill(2, 23, C.TopBarTop, 51)
				Gradient(Body, C.TopBarTop, C.TopBarBottom)
				BarFill(25, 1, C.Black, 52)

				local Content = Make("Frame", {
					Parent = Bar,
					Position = UDim2.fromOffset(10, 0),
					Size = UDim2.new(1, -20, 1, 0),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 53,
				})

				Make("UIListLayout", {
					Parent = Content.Instance,
					FillDirection = Enum.FillDirection.Horizontal,
					Padding = UDim.new(0, 7),
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Center,
				})

				local Order = 0
				local Brand = tostring(Window.UserName or "dbxlll")

				Make("TextLabel", {
					Parent = Content.Instance,
					LayoutOrder = 1,
					AutomaticSize = Enum.AutomaticSize.X,
					Size = UDim2.fromOffset(0, 16),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Text = Brand,
					TextColor3 = C.Text,
					FontFace = Library.BoldFont,
					TextSize = Library.FontSize,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Center,
					TextScaled = false,
					TextStrokeTransparency = 1,
					ZIndex = 53,
				})

				Order += 1

				Make("TextLabel", {
					Parent = Content.Instance,
					LayoutOrder = 2,
					AutomaticSize = Enum.AutomaticSize.X,
					Size = UDim2.fromOffset(0, 16),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Text = "|",
					TextColor3 = C.TextSeparator,
					FontFace = Library.BarFont,
					TextSize = Library.BarFontSize,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Center,
					TextScaled = false,
					TextStrokeTransparency = 1,
					ZIndex = 53,
				})

				Order += 1

				local Items = {
					{ Text = "Watermark", Key = "watermark" },
					{ Text = "Players", Key = "players" },
					{ Text = "Waypoints", Key = "waypoints" },
					{ Text = "Themes", Key = "themes" },
					{ Text = "Keybinds", Key = "keybinds" },
					{ Text = "Target HUD", Key = "target_hud" },
					{ Text = "Dex", Key = "dex" },
					{ Text = "Config", Key = "configs" },
					{ Text = "Perf", Key = "perf" },
				}

				self.Items = { }

				for _, Item in ipairs(Items) do
					Order += 1

					Make("TextLabel", {
						Parent = Content.Instance,
						LayoutOrder = Order,
						AutomaticSize = Enum.AutomaticSize.X,
						Size = UDim2.fromOffset(0, 16),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Text = "/",
						TextColor3 = C.TextSeparator,
						FontFace = Library.BarFont,
						TextSize = Library.BarFontSize,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Center,
						TextScaled = false,
						TextStrokeTransparency = 1,
						ZIndex = 53,
					})

					Order += 1

					local Button = Make("TextButton", {
						Parent = Content.Instance,
						LayoutOrder = Order,
						AutomaticSize = Enum.AutomaticSize.X,
						Size = UDim2.fromOffset(0, 26),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Text = "",
						AutoButtonColor = false,
						ZIndex = 54,
					})

					Make("UIPadding", {
						Parent = Button.Instance,
						PaddingLeft = UDim.new(0, 3),
						PaddingRight = UDim.new(0, 3),
					})

					Button.Instance.Text = Item.Text
					Button.Instance.TextColor3 = C.TextTitle
					Button.Instance.TextSize = Library.BarFontSize
					Button.Instance.FontFace = Library.BarFont
					Button.Instance.TextXAlignment = Enum.TextXAlignment.Left
					Button.Instance.TextYAlignment = Enum.TextYAlignment.Center
					Button.Instance.TextScaled = false
					Button.Instance.TextStrokeTransparency = 1

					local Entry = {
						Key = Item.Key,
						Text = Item.Text,
						Button = Button,
						Hovered = false,
					}

					Button:Connect("MouseButton1Down", function()
						self:ToggleFlag(Item.Key)
					end)

					Button:Connect("MouseEnter", function()
						Entry.Hovered = true
						self:PaintItem(Entry)
					end)

					Button:Connect("MouseLeave", function()
						Entry.Hovered = false
						self:PaintItem(Entry)
					end)

					self.Items[Item.Key] = Entry
					self:PaintItem(Entry)
				end

				local Clock = Make("TextLabel", {
					Parent = Bar,
					AnchorPoint = Vector2.new(1, 0),
					Position = UDim2.new(1, -10, 0, 6),
					Size = UDim2.fromOffset(180, 16),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Text = "",
					TextColor3 = C.Text,
					FontFace = Library.BarFont,
					TextSize = Library.BarFontSize,
					TextXAlignment = Enum.TextXAlignment.Right,
					TextYAlignment = Enum.TextYAlignment.Center,
					TextScaled = false,
					TextStrokeTransparency = 1,
					ZIndex = 55,
				})

				self.TopBar = Bar

				local MainFrame = Window.Items and Window.Items.MainFrame

				local function UpdateInteractive()
					local Visible = Window.IsOpen and MainFrame and MainFrame.Instance.Visible or false

					for _, Entry in self.Items do
						Entry.Button.Instance.Active = Visible
					end

					self:ApplyTools()
				end

				UpdateInteractive()

				if MainFrame then
					MainFrame.Instance:GetPropertyChangedSignal("Visible"):Connect(UpdateInteractive)
				end

				local ClockLast = 0

				Library:Connect(RunService.Heartbeat, function()
					local Now = os.clock()

					if Now - ClockLast < 1 or not Bar.Instance.Parent then
						return
					end

					ClockLast = Now
					Clock.Instance.Text = os.date("%I:%M %p %m/%d/%Y") or ""
				end)
			end

			function Overlay:BuildPreview(Screen)
				local Width = 330
				local Height = 668
				local WindowLeft = math.floor((Screen.X - 644) * 0.5)
				local WindowTop = math.floor((Screen.Y - Height) * 0.5)
				local X = math.clamp(WindowLeft + 644 + 10, 8, math.max(8, Screen.X - Width - 8))

				local Panel = Make("Frame", {
					Parent = self.Root,
					Position = UDim2.fromOffset(X, WindowTop),
					Size = UDim2.fromOffset(Width, Height),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Visible = false,
					ZIndex = 45,
				})

				Chrome(Panel, Width, Height)
				FrameBox(Panel, 6, 8, Width - 12, 18, 8)
				TextAt(Panel, 6, 17, Width - 12, "Preview", C.Text, Library.BoldFont, Library.FontSize, Enum.TextXAlignment.Center, 9)
				FrameBox(Panel, 6, 30, Width - 12, Height - 36, 8)

				-- A real ESP preview instead of the empty box that used to ship.
				-- The silhouette is the same avatar renderer used by the playerlist;
				-- the outline, name, health and distance follow the live visual flags.
				local AvatarX, AvatarY, AvatarW, AvatarH = 84, 108, 162, 330
				ToolAvatar(Panel, AvatarX, AvatarY, AvatarW, AvatarH, 11)

				local BoxLeft, BoxTop = 70, 88
				local BoxWidth, BoxHeight = 190, 360
				local BoxLines = {
					Fill(Panel, BoxLeft, BoxTop, BoxWidth, 1, C.FillTop, 12),
					Fill(Panel, BoxLeft, BoxTop + BoxHeight - 1, BoxWidth, 1, C.FillTop, 12),
					Fill(Panel, BoxLeft, BoxTop, 1, BoxHeight, C.FillTop, 12),
					Fill(Panel, BoxLeft + BoxWidth - 1, BoxTop, 1, BoxHeight, C.FillTop, 12),
				}

				local Name = TextAt(Panel, BoxLeft, BoxTop - 9, BoxWidth, "dbxlll", C.Text, Library.Font, Library.FontSize, Enum.TextXAlignment.Left, 13)
				local Distance = TextAt(Panel, BoxLeft, BoxTop + BoxHeight + 11, BoxWidth, "42m", C.TextDim, Library.Font, Library.FontSize, Enum.TextXAlignment.Left, 13)

				local HealthBack = Fill(Panel, BoxLeft - 10, BoxTop, 5, BoxHeight, C.Black, 12)
				local HealthFill = Fill(Panel, BoxLeft - 10, BoxTop + 1, 3, BoxHeight - 2, C.FillTop, 13)

				local PreviewParts = {
					Box = BoxLines,
					Name = Name,
					Distance = Distance,
					HealthBack = HealthBack,
					HealthFill = HealthFill,
				}

				self.PreviewParts = PreviewParts
				self.PreviewPanel = Panel

				function Overlay:RefreshPreview()
					local Parts = self.PreviewParts

					if not Parts then
						return
					end

					local Visuals = Library.Flags or { }
					local BoxOn = Visuals["visuals.box"] ~= false
					local NameOn = Visuals["visuals.name"] ~= false
					local HealthOn = Visuals["visuals.health_bar"] ~= false
					local DistanceOn = Visuals["visuals.distance"] == true

					for _, Line in ipairs(Parts.Box) do
						Line.Instance.Visible = BoxOn
					end

					Parts.Name.Instance.Visible = NameOn
					Parts.Distance.Instance.Visible = DistanceOn
					Parts.HealthBack.Instance.Visible = HealthOn
					Parts.HealthFill.Instance.Visible = HealthOn
				end

				self:RefreshPreview()

				local MainFrame = self.Window.Items and self.Window.Items.MainFrame

				if MainFrame then
					local function Follow()
						local Position = MainFrame.Instance.AbsolutePosition
						local FollowX = math.clamp(Position.X + 644 + 10, 8, math.max(8, Screen.X - Width - 8))
						local FollowY = math.clamp(Position.Y, 0, math.max(0, Screen.Y - Height))

						Panel.Instance.Position = UDim2.fromOffset(math.floor(FollowX), math.floor(FollowY))
					end

					Follow()
					MainFrame.Instance:GetPropertyChangedSignal("Position"):Connect(Follow)
				end
			end

			function Overlay:BuildTools(Screen)
				self.Tools = { }

				local Definitions = {
					{ Key = "players", Title = "Playerlist", W = 440, H = 340, Build = BuildPlayersTool },
					{ Key = "waypoints", Title = "Waypoints", W = 355, H = 388, Build = BuildWaypointsTool },
					{ Key = "themes", Title = "Colors", W = 230, H = 373, Build = BuildColorsTool },
					{ Key = "dex", Title = "Dex Explorer", W = 490, H = 680, Build = BuildDexTool },
					{ Key = "configs", Title = "Config", W = 296, H = 338, Build = BuildConfigsTool },
					{ Key = "perf", Title = "Thread Performance", W = 540, H = 710, Build = BuildPerfTool },
				}

				for Index, Definition in ipairs(Definitions) do
					local W, H = Definition.W, Definition.H
					local Shift = (Index - 1) * 24
					local X = math.floor((Screen.X - W) * 0.5) + Shift
					local Y = math.floor((Screen.Y - H) * 0.5) + Shift

					X = math.clamp(X, 0, math.max(0, Screen.X - W))
					Y = math.clamp(Y, 26, math.max(26, Screen.Y - H))

					local Panel = Make("Frame", {
						Parent = self.Root,
						Position = UDim2.fromOffset(X, Y),
						Size = UDim2.fromOffset(W, H),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Visible = false,
						ZIndex = 60 + Index,
					})

					local Tool = {
						Key = Definition.Key,
						Panel = Panel,
						W = W,
						H = H,
					}

					Chrome(Panel, W, H)
					FrameBox(Panel, 6, 8, W - 12, 18, 8)
					TextAt(Panel, 6, 17, W - 12, Definition.Title, C.Text, Library.BoldFont, Library.FontSize, Enum.TextXAlignment.Center, 9)

					local Body = Make("Frame", {
						Parent = Panel,
						Position = UDim2.fromOffset(6, 30),
						Size = UDim2.fromOffset(W - 12, H - 36),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						ClipsDescendants = true,
						ZIndex = 10,
					})

					FrameBox(Panel, 6, 30, W - 12, H - 36, 8)
					Definition.Build(self, Tool, Body, W - 12, H - 36)

					local Drag = Make("TextButton", {
						Parent = Panel,
						Position = UDim2.fromOffset(6, 8),
						Size = UDim2.fromOffset(W - 12, 18),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Text = "",
						AutoButtonColor = false,
						ZIndex = 20,
					})

					Drag:Connect("InputBegan", function(Input)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
							self.DragTool = Tool
							self.DragMouse = Input.Position
							self.DragPosition = Panel.Instance.Position
						end
					end)

					self.Tools[Definition.Key] = Tool
				end
			end

			function Overlay.Setup(Window)
				if Overlay.Root then
					Overlay.Window = Window
					return
				end

				Overlay.Window = Window

				local Screen = Vector2.new(1920, 1080)

				if workspace.CurrentCamera then
					Screen = workspace.CurrentCamera.ViewportSize
				end

				local Layer = Library:CreateLayer()
				Layer.Instance.DisplayOrder = 900000
				Layer.Instance.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

				local Root = Make("Frame", {
					Parent = Layer.Instance,
					Size = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 1,
				})

				Overlay.Root = Root
				Overlay.Layer = Layer

				Overlay:BuildWatermark(Screen)
				Overlay:BuildKeybinds(Screen, true)
				Overlay:BuildTargetHud(Screen)
				Overlay:BuildTopBar(Screen)
				Overlay:BuildTools(Screen)
				Overlay:BuildPreview(Screen)
				Overlay:Apply()

				-- Immediate consumers: keybind list, page visibility and the ESP
				-- preview no longer wait for the quarter-second polling pass.
				Library:OnFlagChanged(function(Flag)
					if not Overlay.Root then
						return
					end

					Overlay:BuildKeybinds(Screen, false)

					if type(Flag) == "string" and string.sub(Flag, 1, 8) == "visuals." then
						if Overlay.RefreshPreview then
							Overlay:RefreshPreview()
						end
					end
				end)

				Alpine.OnPageTurn = function()
					Overlay:ApplyTools()

					if Overlay.RefreshPreview then
						Overlay:RefreshPreview()
					end
				end

				Alpine.OnWindowToggle = function()
					Overlay:ApplyTools()
				end

				Library:Connect(UserInputService.InputChanged, function(Input)
					if not Overlay.DragTool or Input.UserInputType ~= Enum.UserInputType.MouseMovement then
						return
					end

					local Tool = Overlay.DragTool
					local Start = Overlay.DragMouse
					local Base = Overlay.DragPosition
					local X = Base.X.Offset + (Input.Position.X - Start.X)
					local Y = Base.Y.Offset + (Input.Position.Y - Start.Y)

					X = math.clamp(X, 0, math.max(0, Screen.X - Tool.W))
					Y = math.clamp(Y, 26, math.max(26, Screen.Y - Tool.H))

					Tool.Panel.Instance.Position = UDim2.fromOffset(math.floor(X), math.floor(Y))
				end)

				Library:Connect(UserInputService.InputEnded, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						Overlay.DragTool = nil
					end
				end)

				Library.WatermarkObject = {
					SetVisibility = function(Value)
						Overlay:SetFlag("watermark", Value)
					end,
				}

				Library.KeyList = {
					SetVisibility = function(Value)
						Overlay:SetFlag("keybinds", Value)
					end,
				}

				if Library.Fps then
					if (Library.Fps.Value or 0) <= 0 then
						Library.Fps.Value = 60
					end

					Library:Connect(RunService.RenderStepped, function()
						Library.Fps.Push()
					end)
				end

				local BindLast = 0

				Library:Connect(RunService.Heartbeat, function()
					local Now = os.clock()

					if Now - BindLast < 0.5 or not Root.Instance.Parent then
						return
					end

					BindLast = Now
					Overlay:BuildKeybinds(Screen, false)
					Overlay:ApplyTools()
				end)

				if Library.Notification then
					task.defer(function()
						Library:Notification({
							Title = Window.UserName,
							Message = "press insert to toggle the menu",
							Time = 5,
						})
					end)
				end
			end

			Alpine.SetupOverlay = function(Window)
				Overlay.Setup(Window)
			end


getgenv().Library = Library
return Library
