local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")

local INTER = "rbxassetid://12187365364"
local Vec2, Dim2 = Vector2.new, UDim2.new
local Offset = UDim2.fromOffset
local RGB = Color3.fromRGB
local floor, round = math.floor, math.round
local FULL = 99


local Metrics = {
	Pad = 10, Gap = 6, SectionGap = 10,
	Radius = 3, SmallRadius = 2, CardRadius = 4, PillRadius = 5, PopupRadius = 5, FloatRadius = 6, WindowRadius = 6,
	WindowW = 586, WindowH = 466, MinWindowW = 520, MinWindowH = 380, SidebarW = 141, ContentX = 142, ColumnW = 207,
	TabW = 121, TabH = 28, TabPitch = 32, CategoryToTab = 25, TabToCategory = 25, FirstCategory = 56, SearchH = 28,
	Row = 16, TopBar = 26, HeaderH = 24, HeaderDescH = 40,
	DividerH = 9, SliderH = 33, DropdownH = 47, InputH = 26, ButtonH = 28, ListRowH = 24,
	ToggleW = 28, ToggleH = 16, ToggleKnob = 10, Knob = 11, PickerKnob = 8, TrackH = 9, TrackY = 24, TrackInset = 5,
	ChipH = 16, ValueChipH = 17, Swatch = 14, ChipGap = 2,
    SidebarShut = 48, SidebarMin = 120, SidebarMax = 200,
}

local Themes = {
	Blossom = {
		Background = RGB(42, 44, 52), Tab = RGB(48, 50, 58), Outline = RGB(65, 68, 80), Inline = RGB(56, 58, 68),
		Text = RGB(232, 234, 245), InactiveText = RGB(126, 130, 148), Accent = RGB(113, 159, 226), Element = RGB(54, 57, 68),
		Gradient = RGB(172, 187, 209), Shadow = RGB(0, 0, 0), HoveredElement = RGB(72, 77, 90),
	},
	Afterglow = {
		Background = RGB(34, 28, 25), Tab = RGB(30, 23, 20), Outline = RGB(60, 46, 38), Inline = RGB(42, 33, 29),
		Text = RGB(240, 232, 226), InactiveText = RGB(140, 122, 110), Accent = RGB(255, 145, 60), Element = RGB(49, 34, 27),
		Gradient = RGB(172, 167, 163), Shadow = RGB(0, 0, 0), HoveredElement = RGB(70, 51, 42),
	},
	Frostbite = {
		Background = RGB(22, 30, 38), Tab = RGB(16, 25, 32), Outline = RGB(42, 58, 72), Inline = RGB(27, 38, 47),
		Text = RGB(228, 240, 248), InactiveText = RGB(114, 136, 152), Accent = RGB(86, 219, 255), Element = RGB(28, 39, 52),
		Gradient = RGB(164, 172, 178), Shadow = RGB(0, 0, 0), HoveredElement = RGB(44, 60, 74),
	},
	Volt = {
		Background = RGB(24, 24, 20), Tab = RGB(18, 18, 14), Outline = RGB(54, 54, 40), Inline = RGB(32, 32, 26),
		Text = RGB(242, 242, 226), InactiveText = RGB(134, 134, 112), Accent = RGB(255, 250, 76), Element = RGB(32, 32, 26),
		Gradient = RGB(170, 170, 158), Shadow = RGB(0, 0, 0), HoveredElement = RGB(58, 58, 44),
	},
	Obsidian = {
		Background = RGB(16, 16, 18), Tab = RGB(12, 11, 14), Outline = RGB(44, 42, 52), Inline = RGB(24, 24, 29),
		Text = RGB(234, 232, 244), InactiveText = RGB(118, 114, 134), Accent = RGB(159, 109, 255), Element = RGB(24, 23, 31),
		Gradient = RGB(166, 164, 175), Shadow = RGB(0, 0, 0), HoveredElement = RGB(236, 240, 248),
	},
	["Sakura Drift"] = {
		Background = RGB(38, 28, 34), Tab = RGB(32, 23, 29), Outline = RGB(70, 50, 62), Inline = RGB(48, 35, 43),
		Text = RGB(248, 234, 242), InactiveText = RGB(150, 122, 138), Accent = RGB(255, 155, 205), Element = RGB(44, 46, 48),
		Gradient = RGB(176, 166, 172), Shadow = RGB(0, 0, 0), HoveredElement = RGB(77, 53, 67),
	},
	["Neon Mirage"] = {
		Background = RGB(22, 16, 34), Tab = RGB(17, 12, 28), Outline = RGB(54, 40, 82), Inline = RGB(32, 23, 48),
		Text = RGB(238, 232, 252), InactiveText = RGB(128, 114, 160), Accent = RGB(255, 86, 255), Element = RGB(30, 21, 46),
		Gradient = RGB(144, 163, 182), Shadow = RGB(0, 0, 0), HoveredElement = RGB(56, 39, 84),
	},
	["Copper Dust"] = {
		Background = RGB(39, 30, 25), Tab = RGB(34, 25, 20), Outline = RGB(72, 54, 42), Inline = RGB(49, 36, 28),
		Text = RGB(244, 232, 220), InactiveText = RGB(148, 124, 104), Accent = RGB(243, 152, 86), Element = RGB(51, 34, 22),
		Gradient = RGB(173, 164, 155), Shadow = RGB(0, 0, 0), HoveredElement = RGB(77, 56, 42),
	},
	Abyss = {
		Background = RGB(12, 20, 28), Tab = RGB(8, 15, 22), Outline = RGB(30, 48, 62), Inline = RGB(18, 30, 40),
		Text = RGB(222, 236, 246), InactiveText = RGB(100, 128, 148), Accent = RGB(52, 176, 238), Element = RGB(16, 28, 38),
		Gradient = RGB(158, 169, 176), Shadow = RGB(0, 0, 0), HoveredElement = RGB(32, 51, 67),
	},
	Porcelain = {
		Background = RGB(250, 248, 244), Tab = RGB(236, 234, 230), Outline = RGB(214, 212, 208), Inline = RGB(255, 255, 255),
		Text = RGB(44, 46, 54), InactiveText = RGB(140, 142, 150), Accent = RGB(133, 176, 255), Element = RGB(255, 255, 255),
		Gradient = RGB(214, 218, 226), Shadow = RGB(120, 120, 120), HoveredElement = RGB(255, 255, 255),
	},
	Graphite = {
		Background = RGB(32, 30, 30), Tab = RGB(40, 40, 40), Outline = RGB(58, 60, 62), Inline = RGB(42, 45, 46),
		Text = RGB(236, 236, 250), InactiveText = RGB(128, 128, 134), Accent = RGB(105, 159, 237), Element = RGB(44, 46, 46),
		Gradient = RGB(190, 190, 190), Shadow = RGB(0, 0, 0), HoveredElement = RGB(67, 70, 72),
	},
    	Emerald = {
		Background = RGB(20, 30, 26), Tab = RGB(15, 24, 20), Outline = RGB(38, 60, 50), Inline = RGB(26, 40, 34),
		Text = RGB(226, 244, 236), InactiveText = RGB(108, 138, 124), Accent = RGB(72, 214, 150), Element = RGB(24, 38, 32),
		Gradient = RGB(164, 176, 170), Shadow = RGB(0, 0, 0), HoveredElement = RGB(42, 66, 55),
	},
	Crimson = {
		Background = RGB(30, 20, 22), Tab = RGB(24, 15, 17), Outline = RGB(62, 40, 44), Inline = RGB(40, 27, 30),
		Text = RGB(246, 230, 232), InactiveText = RGB(146, 114, 120), Accent = RGB(236, 72, 90), Element = RGB(38, 24, 27),
		Gradient = RGB(176, 164, 166), Shadow = RGB(0, 0, 0), HoveredElement = RGB(68, 44, 49),
	},
	Midnight = {
		Background = RGB(18, 20, 34), Tab = RGB(13, 15, 28), Outline = RGB(40, 45, 74), Inline = RGB(26, 29, 48),
		Text = RGB(228, 232, 250), InactiveText = RGB(112, 120, 156), Accent = RGB(96, 120, 255), Element = RGB(24, 27, 46),
		Gradient = RGB(164, 168, 184), Shadow = RGB(0, 0, 0), HoveredElement = RGB(42, 48, 80),
	},
	Mocha = {
		Background = RGB(36, 29, 26), Tab = RGB(30, 24, 21), Outline = RGB(66, 54, 47), Inline = RGB(46, 38, 33),
		Text = RGB(240, 230, 220), InactiveText = RGB(146, 128, 114), Accent = RGB(196, 148, 110), Element = RGB(44, 35, 30),
		Gradient = RGB(174, 168, 162), Shadow = RGB(0, 0, 0), HoveredElement = RGB(70, 58, 50),
	},
	["Lavender Haze"] = {
		Background = RGB(36, 32, 48), Tab = RGB(30, 26, 42), Outline = RGB(64, 58, 88), Inline = RGB(46, 41, 62),
		Text = RGB(240, 236, 252), InactiveText = RGB(138, 130, 168), Accent = RGB(184, 160, 255), Element = RGB(42, 37, 58),
		Gradient = RGB(172, 168, 184), Shadow = RGB(0, 0, 0), HoveredElement = RGB(70, 63, 96),
	},
	Lagoon = {
		Background = RGB(18, 32, 34), Tab = RGB(13, 26, 28), Outline = RGB(36, 64, 66), Inline = RGB(24, 42, 44),
		Text = RGB(224, 244, 242), InactiveText = RGB(106, 142, 142), Accent = RGB(64, 224, 208), Element = RGB(22, 38, 40),
		Gradient = RGB(162, 176, 176), Shadow = RGB(0, 0, 0), HoveredElement = RGB(40, 70, 72),
	},
	Monochrome = {
		Background = RGB(24, 24, 24), Tab = RGB(18, 18, 18), Outline = RGB(52, 52, 52), Inline = RGB(32, 32, 32),
		Text = RGB(240, 240, 240), InactiveText = RGB(130, 130, 130), Accent = RGB(225, 225, 225), Element = RGB(30, 30, 30),
		Gradient = RGB(180, 180, 180), Shadow = RGB(0, 0, 0), HoveredElement = RGB(58, 58, 58),
	},
	["Mint Frost"] = {
		Background = RGB(244, 250, 248), Tab = RGB(230, 240, 237), Outline = RGB(200, 216, 211), Inline = RGB(255, 255, 255),
		Text = RGB(36, 52, 48), InactiveText = RGB(122, 142, 136), Accent = RGB(60, 190, 150), Element = RGB(255, 255, 255),
		Gradient = RGB(208, 222, 218), Shadow = RGB(120, 120, 120), HoveredElement = RGB(236, 246, 243),
	},
	Rosewater = {
		Background = RGB(252, 246, 247), Tab = RGB(240, 230, 233), Outline = RGB(222, 206, 211), Inline = RGB(255, 255, 255),
		Text = RGB(58, 40, 46), InactiveText = RGB(156, 134, 142), Accent = RGB(236, 110, 150), Element = RGB(255, 255, 255),
		Gradient = RGB(224, 210, 215), Shadow = RGB(120, 120, 120), HoveredElement = RGB(250, 236, 240),
	},
}
local ThemeOrder = {
	"Blossom", "Afterglow", "Frostbite", "Volt", "Obsidian", "Sakura Drift", "Neon Mirage", "Copper Dust", "Abyss", "Porcelain", "Graphite",
	"Emerald", "Crimson", "Midnight", "Mocha", "Lavender Haze", "Lagoon", "Monochrome", "Mint Frost", "Rosewater",
}
local ThemeKeys = {
	{ "Background", "Background" }, { "Tab", "Tab" }, { "Outline", "Outline" }, { "Inline", "Inline" },
	{ "Text", "Text" }, { "Inactive Text", "InactiveText" }, { "Accent", "Accent" }, { "Element", "Element" },
	{ "Gradient", "Gradient" }, { "Shadow", "Shadow" }, { "Hovered Element", "HoveredElement" },
}
local Casings = { "Normal", "Lower Case", "Upper Case", "Bold Case" }
local Fonts = {
	Inter = INTER,
	["Builder Sans"] = "rbxasset://fonts/families/BuilderSans.json",
	Roboto = "rbxasset://fonts/families/Roboto.json",
	Montserrat = "rbxasset://fonts/families/Montserrat.json",
	["Source Sans Pro"] = "rbxasset://fonts/families/SourceSansPro.json",
	Ubuntu = "rbxasset://fonts/families/Ubuntu.json",
	Nunito = "rbxasset://fonts/families/Nunito.json",
	Arimo = "rbxasset://fonts/families/Arimo.json",
}
local FontOrder = { "Inter", "Builder Sans", "Roboto", "Montserrat", "Source Sans Pro", "Ubuntu", "Nunito", "Arimo" }
local WeightOrder = { "Regular", "Medium", "SemiBold", "Bold" }

local Current = table.clone(Themes.Crimson)
local Casing = "Normal"
local FontFamily = INTER
local BodyWeight = Enum.FontWeight.SemiBold
local NotifyPlacements = { "Top Left", "Top Right", "Bottom Left", "Bottom Right" }
local NotifyTypes = {
	Info = { Icon = "status-info", Color = function() return Current.Accent end, Duration = 3 },
	Success = { Icon = "status-success", Color = function() return RGB(112, 205, 132) end, Duration = 3 },
	Warning = { Icon = "status-warning", Color = function() return RGB(240, 180, 70) end, Duration = 4 },
	Error = { Icon = "status-error", Color = function() return RGB(235, 95, 95) end, Duration = 5 },
}

local Presets = {
	Fast = { W = 42, Z = 1 },
	Knob = { W = 44, Z = 0.86 },
	Follow = { W = 34, Z = 1 },
	Smooth = { W = 26, Z = 1 },
	Soft = { W = 19, Z = 1 },
	Settle = { W = 24, Z = 0.8 },
}

local Active, Tracks, Jobs = {}, {}, {}
local EPS = { number = 0.0015, Color3 = 0.003, UDim2 = 0.4, Vector2 = 0.4 }

local function encode(v)
	local kind = typeof(v)
	if kind == "number" then return { v } end
	if kind == "Color3" then return { v.R, v.G, v.B } end
	if kind == "UDim2" then return { v.X.Scale, v.X.Offset, v.Y.Scale, v.Y.Offset } end
	if kind == "Vector2" then return { v.X, v.Y } end
	error("cannot animate " .. kind)
end

local function decode(kind, x)
	if kind == "number" then return x[1] end
	if kind == "Color3" then return Color3.new(math.clamp(x[1], 0, 1), math.clamp(x[2], 0, 1), math.clamp(x[3], 0, 1)) end
	if kind == "UDim2" then return Dim2(x[1], round(x[2]), x[3], round(x[4])) end
	return Vec2(round(x[1]), round(x[2]))
end

local function untrack(entry)
	entry.Dead = true
	local map = Tracks[entry.Target]
	if map and map[entry.Prop] == entry then
		map[entry.Prop] = nil
		if next(map) == nil then Tracks[entry.Target] = nil end
	end
end

local function animate(target, prop, goal, preset, opts)
	local map = Tracks[target]
	if not map then map = {}; Tracks[target] = map end
	local entry = map[prop]
	if not entry then
		local from = encode(target[prop])
		local vel = {}
		for i = 1, #from do vel[i] = 0 end
		entry = { Target = target, Prop = prop, Kind = typeof(goal), X = from, V = vel }
		map[prop] = entry
		table.insert(Active, entry)
	end
	entry.G, entry.Goal = encode(goal), goal
	entry.P = Presets[preset or "Smooth"]
	entry.Done = opts and opts.Done or nil
	entry.Step = opts and opts.Step or nil
end

local function snap(target, prop, value)
	local map = Tracks[target]
	local entry = map and map[prop]
	if entry then untrack(entry) end
	target[prop] = value
end

local function place(target, prop, value, animated, preset)
	if animated then animate(target, prop, value, preset) else snap(target, prop, value) end
end

local function stepAnimator(dt)
	dt = math.min(dt, 1 / 20)
	local cache = {}
	local i = 1
	while i <= #Active do
		local e = Active[i]
		if e.Dead then
			Active[i] = Active[#Active]
			Active[#Active] = nil
		else
			local c = cache[e.P]
			if not c then
				local w, z = e.P.W, e.P.Z
				local t = dt
				if z >= 1 then
					local k = math.exp(-w * t)
					c = { k * (1 + w * t), k * t, -k * w * w * t, k * (1 - w * t) }
				else
					local wd = w * math.sqrt(1 - z * z)
					local k, co, si = math.exp(-z * w * t), math.cos(wd * t), math.sin(wd * t)
					c = { k * (co + z * w * si / wd), k * si / wd, -k * w * w * si / wd, k * (co - z * w * si / wd) }
				end
				cache[e.P] = c
			end
			local x, v, g = e.X, e.V, e.G
			local eps, settled = EPS[e.Kind], true
			local velEps = eps * e.P.W
			for n = 1, #x do
				local d = x[n] - g[n]
				local nv = c[3] * d + c[4] * v[n]
				local nd = c[1] * d + c[2] * v[n]
				x[n], v[n] = g[n] + nd, nv
				local channelEps = (e.Kind == "UDim2" and n % 2 == 1) and 0.0005 or eps
				if math.abs(nd) > channelEps or math.abs(nv) > velEps then settled = false end
			end
			if settled then
				e.Target[e.Prop] = e.Goal
				if e.Step then e.Step(e.Goal) end
				local done = e.Done
				untrack(e)
				Active[i] = Active[#Active]
				Active[#Active] = nil
				if done then task.spawn(done) end
			else
				local value = decode(e.Kind, x)
				if value ~= e.Last then
					e.Last = value
					e.Target[e.Prop] = value
					if e.Step then e.Step(value) end
				end
				i += 1
			end
		end
	end
end

local FrameConnection
local sweepHover
local function ensureLoop()
	if FrameConnection then return end
	FrameConnection = RunService.RenderStepped:Connect(function(dt)
		stepAnimator(dt)
		for job in Jobs do job(dt) end
		sweepHover()
	end)
end

local Bound, ByKey, Dynamic, Cased, NoFade = {}, {}, {}, {}, {}

local function resolve(source)
	if type(source) == "function" then return source() end
	return Current[source]
end

local function forget(inst)
	local bindings = Bound[inst]
	if bindings then
		for prop, source in bindings do
			if type(source) == "string" then
				local set = ByKey[source]
				if set then set[inst] = nil end
			end
		end
	end
	Bound[inst], Dynamic[inst], Cased[inst], Tracks[inst], NoFade[inst] = nil, nil, nil, nil, nil
end

local function bind(inst, prop, source)
	local bindings = Bound[inst]
	if not bindings then
		bindings = {}
		Bound[inst] = bindings
		inst.Destroying:Once(function() forget(inst) end)
	end
	bindings[prop] = source
	if type(source) == "string" then
		local set = ByKey[source]
		if not set then set = {}; ByKey[source] = set end
		set[inst] = prop
	else
		Dynamic[inst] = true
	end
	inst[prop] = resolve(source)
end

local function refresh(inst, preset)
	local bindings = Bound[inst]
	if not bindings then return end
	for prop, source in bindings do
		local value = resolve(source)
		if preset == false or typeof(value) == "ColorSequence" then
			snap(inst, prop, value)
		else
			animate(inst, prop, value, preset or "Fast")
		end
	end
end

local function applyCase(text)
	if Casing == "Lower Case" then return string.lower(text) end
	if Casing == "Upper Case" or Casing == "Bold Case" then return string.upper(text) end
	return text
end

local function fontOf(weight)
	if Casing == "Bold Case" then weight = Enum.FontWeight.Bold end
	return Font.new(FontFamily, weight or BodyWeight, Enum.FontStyle.Normal)
end

local function setText(inst, text, prop)
	prop = prop or "Text"
	local entry = Cased[inst]
	if not entry then entry = {}; Cased[inst] = entry end
	entry[prop] = text
	inst[prop] = applyCase(text)
end

local function applyTextSettings()
	for inst, entry in Cased do
		for prop, raw in entry do
			if prop == "Text" or prop == "PlaceholderText" then inst[prop] = applyCase(raw) end
		end
		inst.FontFace = fontOf(entry.Weight)
	end
end

local TEXT_CLASSES = { TextLabel = true, TextButton = true, TextBox = true }

local function new(class, props, parent)
	local inst = Instance.new(class)
	if inst:IsA("GuiObject") then
		inst.BorderSizePixel = 0
		inst.BackgroundTransparency = 1
	end
	if class == "TextButton" then
		inst.AutoButtonColor = false
		inst.Text = ""
	end
	if TEXT_CLASSES[class] then
		if class ~= "TextButton" then Cased[inst] = {} end
		if class == "TextBox" then inst.Text = "" end
		inst.FontFace = fontOf(nil)
		inst.TextSize = 13
		inst.TextXAlignment = Enum.TextXAlignment.Left
		inst.TextYAlignment = Enum.TextYAlignment.Top
	end
    	if class == "ScrollingFrame" then
		inst.ScrollBarThickness = 0
		inst.ScrollBarImageTransparency = 1
		inst.TopImage, inst.MidImage, inst.BottomImage = "", "", ""
	end
	local bg, fg, radius, border
	if props then
		for key, value in props do
			if key == "Bg" then bg = value
			elseif key == "Fg" then fg = value
			elseif key == "Radius" then radius = value
			elseif key == "Border" then border = value
			elseif key == "Weight" then
				Cased[inst].Weight = value
				inst.FontFace = fontOf(value)
			elseif (key == "Text" and class ~= "TextBox" or key == "PlaceholderText") and TEXT_CLASSES[class] then
				setText(inst, value, key)
			else
				inst[key] = value
			end
		end
	end
	if bg then
		if not (props and props.BackgroundTransparency) then inst.BackgroundTransparency = 0 end
		bind(inst, "BackgroundColor3", bg)
	end
	if fg then bind(inst, "TextColor3", fg) end
	if radius then
		local corner = Instance.new("UICorner")
		corner.CornerRadius = radius >= FULL and UDim.new(0.5, 0) or UDim.new(0, radius)
		corner.Parent = inst
	end
	if border then
		local stroke = Instance.new("UIStroke")
		stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		stroke.Thickness = 1
		bind(stroke, "Color", border)
		stroke.Parent = inst
	end
	if parent then inst.Parent = parent end
	return inst
end

local function capOffset(rowH, size)
	local capHeight = round(size * 0.7)
	return math.ceil((rowH - capHeight) / 2 - round(size * 0.16))
end

local function label(parent, o)
	local size, rowH = o.TextSize or 12, o.RowH or Metrics.Row
	local x = o.X or 0
	return new("TextLabel", {
		Fg = o.Fg or "Text", Text = o.Text or "", TextSize = size, Weight = o.Weight, TextTruncate = o.Truncate,
		TextTransparency = o.TextTransparency, ZIndex = o.ZIndex,
		Position = Offset(x, (o.Y or 0) + capOffset(rowH, size)),
		Size = o.W and Offset(o.W, rowH) or Dim2(1, -x - (o.Right or 0), 0, rowH),
	}, parent)
end

local function centeredLabel(parent, width, o)
	o.Truncate = Enum.TextTruncate.AtEnd
	local text = label(parent, o)
	local y, rowH = text.Position.Y.Offset, o.RowH or Metrics.Row
	local function fit()
		text.Size = Offset(width - 12, rowH)
		text.Position = Offset(floor((width - math.min(math.ceil(text.TextBounds.X), width - 12)) / 2), y)
	end
	text:GetPropertyChangedSignal("TextBounds"):Connect(fit)
	fit()
	return text, function(newWidth)
		width = newWidth
		fit()
	end
end

local function addGradient(inst)
	local gradient = Instance.new("UIGradient")
	gradient.Rotation = 90
	bind(gradient, "Color", function() return ColorSequence.new(Color3.new(1, 1, 1), Current.Gradient) end)
	gradient.Parent = inst
	return gradient
end

local Shadows = {
	Large = { Blur = 10, Spread = 0, Transparency = 0.3 },
	PickerKnob = { Blur = 6, Spread = 6, Transparency = 0.5 },
}

local ShadowsAvailable = pcall(function() Instance.new("UIShadow"):Destroy() end)

local function addShadow(inst, style)
	if not ShadowsAvailable then return nil end
	local preset = Shadows[style]
	local shadow = Instance.new("UIShadow")
	shadow.BlurRadius = UDim.new(0, preset.Blur)
	shadow.Spread = Offset(preset.Spread, preset.Spread)
	shadow.Transparency = preset.Transparency
	bind(shadow, "Color", "Shadow")
	shadow.Parent = inst
	return shadow
end

local function fire(callback, ...)
	if callback then task.spawn(callback, ...) end
end

local function clamp01(n) return math.clamp(n, 0, 1) end

local TouchPoint

local function trackTouch(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		TouchPoint = Vec2(input.Position.X, input.Position.Y) + GuiService:GetGuiInset()
	elseif input.UserInputType == Enum.UserInputType.MouseMovement then
		TouchPoint = nil
	end
end

local function isClick(input)
	trackTouch(input)
	return input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch
end

local ScreenRef
local Focus
local LayerScale = 1
local TouchOnly = UserInputService.TouchEnabled and not UserInputService.MouseEnabled

local function mousePos()
	local location = TouchPoint or UserInputService:GetMouseLocation()
	if ScreenRef then return location + ScreenRef.AbsolutePosition end
	return location
end

local function toLayer(point)
	if ScreenRef then point = point - ScreenRef.AbsolutePosition end
	return point / LayerScale
end

local function inside(frame, point, margin)
	margin = margin or 0
	local p, s = frame.AbsolutePosition, frame.AbsoluteSize
	return point.X >= p.X - margin and point.X <= p.X + s.X + margin and point.Y >= p.Y - margin and point.Y <= p.Y + s.Y + margin
end

local function lockScrolling(locked)
	if not TouchOnly or not Focus then return end
	for _, tab in Focus.Tabs do
		for _, column in tab.Columns do
			column.Scroll.ScrollingEnabled = not locked
		end
	end
end

local function beginDrag(onMove, onEnd, onFrame)
	local last
	local function job(dt)
		local point = mousePos()
		if not last or point ~= last then
			last = point
			if onMove then onMove(point) end
		end
		if onFrame then onFrame(point, dt) end
	end
	Jobs[job] = true
	lockScrolling(true)
	local ended
	ended = UserInputService.InputEnded:Connect(function(input)
		if isClick(input) then
			ended:Disconnect()
			Jobs[job] = nil
			lockScrolling(false)
			local point = mousePos()
			if onMove and point ~= last then onMove(point) end
			if onEnd then onEnd(point) end
		end
	end)
end

local HoverSet = {}

local function isShown(inst)
	local node = inst
	while node and node:IsA("GuiObject") do
		if not node.Visible then return false end
		node = node.Parent
	end
	return true
end

local function covered(inst, point)
	local win = Focus
	if not win then return false end
	local dropdown = win.OpenDropdown
	if dropdown then
		if inst:IsDescendantOf(dropdown.Panel) then return false end
		if inside(dropdown.Panel, point) then return true end
	end
	local popup = win.ActivePopup
	if popup and inside(popup.Frame, point) and not inst:IsDescendantOf(popup.Frame) then return true end
	if win.Search and win.Search.Open and not inst:IsDescendantOf(win.Search.Overlay) then return true end
	return false
end

local function hoverable(inst, onEnter, onLeave)
	local entered = false
	local function leave()
		if not entered then return end
		entered = false
		HoverSet[inst] = nil
		onLeave()
	end
	inst.MouseEnter:Connect(function()
		if entered or covered(inst, mousePos()) then return end
		entered = true
		HoverSet[inst] = leave
		onEnter()
	end)
	inst.MouseLeave:Connect(leave)
	inst.Destroying:Once(function() HoverSet[inst] = nil end)
end

function sweepHover()
	if next(HoverSet) == nil then return end
	local point = mousePos()
	for inst, leave in HoverSet do
		if not inside(inst, point) or not isShown(inst) or covered(inst, point) then leave() end
	end
end

local Fader = {}
Fader.__index = Fader

local function newFader(root)
	return setmetatable({ Root = root, Alpha = 1, Entries = nil }, Fader)
end

local function captureFade(root)
	local entries = {}
	local function add(inst, prop)
		if NoFade[inst] or (Tracks[inst] and Tracks[inst][prop]) then return end
		local base = inst[prop]
		if base < 1 then table.insert(entries, { inst, prop, base }) end
	end
	local function visit(inst)
		if inst:IsA("GuiObject") then
			if inst ~= root and not inst.Visible then return end
			add(inst, "BackgroundTransparency")
			if TEXT_CLASSES[inst.ClassName] then add(inst, "TextTransparency") end
			if inst:IsA("ImageLabel") then add(inst, "ImageTransparency") end
		elseif inst:IsA("UIStroke") or inst.ClassName == "UIShadow" then
			add(inst, "Transparency")
		end
		for _, child in inst:GetChildren() do visit(child) end
	end
	visit(root)
	return entries
end

function Fader:_apply(alpha)
	local entries = self.Entries
	if not entries then return end
	for _, e in entries do
		e[1][e[2]] = 1 - (1 - e[3]) * alpha
	end
end

function Fader:Show(onDone, preset)
	if not self.Entries then
		self.Entries = captureFade(self.Root)
		self.Alpha = 0
		self:_apply(0)
	end
	self.Root.Visible = true
	animate(self, "Alpha", 1, preset or "Smooth", {
		Step = function(value) self:_apply(value) end,
		Done = function()
			self.Entries = nil
			if onDone then onDone() end
		end,
	})
end

function Fader:Hide(onDone, preset)
	if not self.Entries then
		self.Entries = captureFade(self.Root)
		self.Alpha = 1
	end
	animate(self, "Alpha", 0, preset or "Fast", {
		Step = function(value) self:_apply(value) end,
		Done = function()
			self.Root.Visible = false
			self:_apply(1)
			self.Entries = nil
			if onDone then onDone() end
		end,
	})
end

local Icons = {
	target = { { "f", 0.5, 0.5, 15, 15, FULL }, { "h", 3, 3, 10, 10, FULL }, { "f", 4.8, 4.8, 6.4, 6.4, FULL } },
	bullet = { { "f", 1, 4, 3, 8, 1 }, { "f", 5, 4, 6, 8, 1 }, { "f", 8.2, 5.2, 5.6, 5.6, 1, 45 } },
	smile = {
		{ "f", 1, 1, 14, 14, FULL }, { "h", 4.4, 5, 2.6, 2.6, FULL }, { "h", 9, 5, 2.6, 2.6, FULL },
		{ "h", 4.6, 9.8, 6.8, 2, FULL },
	},
	globe = {
		{ "f", 1, 1, 14, 14, FULL }, { "h", 3, 3.2, 4.4, 3, FULL, -20 }, { "h", 8.2, 8, 4.6, 3.8, FULL, 20 },
		{ "h", 9.8, 2.8, 2.6, 2, FULL }, { "h", 3.4, 9.6, 2.6, 2.6, FULL },
	},
	bomb = { { "f", 1, 4, 11, 11, FULL }, { "f", 9.2, 2.8, 4, 3, 0.5, 45 }, { "f", 12.8, 0.8, 2.4, 2.4, FULL } },
	file = {
		{ "f", 3, 1, 10, 14, 1.5 }, { "h", 10.6, -0.8, 4.2, 4.2, 0, 45 }, { "h", 5.5, 7.5, 5, 1.1, 0 },
		{ "h", 5.5, 10.3, 5, 1.1, 0 },
	},
	gear = {
		{ "f", 6.5, 0.8, 3, 14.4, 0.6, 0 }, { "f", 6.5, 0.8, 3, 14.4, 0.6, 45 }, { "f", 6.5, 0.8, 3, 14.4, 0.6, 90 },
		{ "f", 6.5, 0.8, 3, 14.4, 0.6, 135 }, { "f", 2.6, 2.6, 10.8, 10.8, FULL }, { "h", 5.6, 5.6, 4.8, 4.8, FULL },
	},
	robot = {
		{ "f", 7.2, 2, 1.6, 3.5, 0 }, { "f", 6.4, 0.5, 3.2, 3.2, FULL }, { "f", 2.2, 5, 11.6, 9.4, 2 },
		{ "f", 0.2, 8, 1.4, 4, 0.5 }, { "f", 14.4, 8, 1.4, 4, 0.5 }, { "h", 4.6, 7.6, 2.5, 2.5, FULL },
		{ "h", 8.9, 7.6, 2.5, 2.5, FULL }, { "h", 5.4, 11.4, 5.2, 1.1, 0 },
	},
	wrench = {
		{ "f", 5.6, 4.2, 3.8, 12.6, 1.4, 45 }, { "f", 8.8, 0.8, 6.6, 6.6, FULL },
		{ "h", 11.4, -1.2, 3.2, 5.8, 0, 45 },
	},
	cube = {
		{ "f", 4, 1.1, 8, 13.8, 0, 0 }, { "f", 4, 1.1, 8, 13.8, 0, 60 }, { "f", 4, 1.1, 8, 13.8, 0, 120 },
		{ "h", 7.5, 8, 1, 6.6, 0, 0 }, { "h", 4.6, 2.6, 1, 6.8, 0, 120 }, { "h", 10.4, 2.6, 1, 6.8, 0, 60 },
	},
	search = { { "r", 2, 2, 9, 9, FULL, 0, 1.7 }, { "f", 9.6, 11.2, 5.6, 2, FULL, 45 } },
	user = { { "f", 5, 1, 6, 6, FULL }, { "f", 2.5, 8.5, 11, 6.5, 3 } },
	key = {
		{ "f", 1, 8.5, 7, 7, FULL }, { "f", 6.2, 5, 9, 2.2, 0.6, -45 }, { "f", 11.2, 4.6, 3.4, 2, 0.4, 45 },
		{ "h", 3.1, 10.6, 2.8, 2.8, FULL },
	},
	grip = { { "f", 5.5, 11.3, 11, 1.5, FULL, -45 }, { "f", 10.2, 12.7, 5.6, 1.5, FULL, -45 } },
        discord = {
        { "f", 1, 3, 14, 10, 4.5 }, { "f", 2.4, 1.8, 3.4, 3.4, 1, 45 }, { "f", 10.2, 1.8, 3.4, 3.4, 1, 45 },
        { "h", 4.2, 6.6, 2.2, 3, FULL }, { "h", 9.6, 6.6, 2.2, 3, FULL },
    },
	check = { { "f", 2, 8.4, 6.2, 2, FULL, 45 }, { "f", 5.2, 6.8, 10, 2, FULL, -45 } },
    chevron = { { "f", 2, 6.75, 7, 2, FULL, 45 }, { "f", 7, 6.75, 7, 2, FULL, -45 } },
    minus = { { "f", 3, 7, 10, 2, FULL } },
    close = { { "f", 1.5, 7, 13, 2, FULL, 45 }, { "f", 1.5, 7, 13, 2, FULL, -45 } },
	layout = { { "f", 0.5, 1, 15, 4.5, 1 }, { "f", 0.5, 6.5, 7, 8.5, 1 }, { "f", 8.5, 6.5, 7, 8.5, 1 } },
	reset = { { "r", 2.6, 2.6, 10.8, 10.8, FULL, 0, 1.8 }, { "h", 9.5, 0.5, 6, 5.5, 0 }, { "f", 9.2, 1.2, 4.6, 4.6, 0.5, 45 } },
    ["status-success"] = { { "f", 0.5, 0.5, 15, 15, FULL }, { "h", 3.8, 8.45, 3.9, 1.6, FULL, 45 }, { "h", 5.8, 7.3, 7.2, 1.6, FULL, -45 } },
    ["status-error"] = { { "f", 0.5, 0.5, 15, 15, FULL }, { "h", 4.5, 7.2, 7, 1.6, FULL, 45 }, { "h", 4.5, 7.2, 7, 1.6, FULL, -45 } },
    ["status-warning"] = { { "f", 2.6, 2.6, 10.8, 10.8, 2, 45 }, { "h", 7.2, 4.4, 1.6, 4.6, FULL }, { "h", 7.2, 10, 1.6, 1.6, FULL } },
    ["status-info"] = { { "f", 0.5, 0.5, 15, 15, FULL }, { "h", 7.2, 4.2, 1.6, 1.6, FULL }, { "h", 7.2, 6.8, 1.6, 5, FULL } },
	logo = (function()
		local parts = { { "f", 0.6, 0.6, 14.8, 14.8, FULL } }
		for arm = 0, 2 do
			for step = 0, 3 do
				local degrees = arm * 120 + step * 42
				local angle, radius = math.rad(degrees), 6.3 - step * 1.45
				local cx, cy = 8 + math.cos(angle) * radius, 8 + math.sin(angle) * radius
				table.insert(parts, { "h", cx - 2, cy - 0.6, 4, 1.2, FULL, degrees + 118 })
			end
		end
		table.insert(parts, { "h", 7, 7, 2, 2, FULL })
		return parts
	end)(),
}

local LUCIDE_URL = "https://github.com/latte-soft/lucide-roblox/releases/latest/download/lucide-roblox.luau"
local LucideProvider, LucideResolved = nil, false
local LucideCache, LucideWarned = {}, {}

local function asProvider(source)
	if type(source) == "table" and type(source.GetAsset) == "function" then
		return function(name, size) return source.GetAsset(name, size) end
	end
	if type(source) == "function" then return source end
	return nil
end

local function setLucide(source)
	LucideProvider, LucideResolved = asProvider(source), true
	table.clear(LucideCache)
end

local function lucideProvider()
	if LucideResolved then return LucideProvider end
	local win = Focus
	if win then win:_busy(1, "Downloading icons") end
	local ok, result = pcall(function() return loadstring(game:HttpGet(LUCIDE_URL))() end)
	if win then win:_busy(-1) end
	setLucide(ok and result or nil)
	if not LucideProvider then warn("[Blossom] Lucide icons unavailable: " .. tostring(result)) end
	return LucideProvider
end

local function lucideImage(name)
	if LucideCache[name] ~= nil then return LucideCache[name] or nil end
	local result = false
	local provider = lucideProvider()
	if provider then
for _, candidate in { name, "lucide-" .. name } do
	for _, request in { 48, false } do
		local ok, asset = pcall(provider, candidate, request or nil)
		if ok and asset then
			if type(asset) == "table" then
				local url = asset.Url or (asset.Id and "rbxassetid://" .. asset.Id)
				if url then result = { Image = url, RectSize = asset.ImageRectSize, RectOffset = asset.ImageRectOffset } end
			elseif type(asset) == "number" then
				result = { Image = "rbxassetid://" .. asset }
			elseif type(asset) == "string" then
				result = { Image = asset }
			end
			if result then break end
		end
	end
	if result then break end
end
		if not result and not LucideWarned[name] then
			LucideWarned[name] = true
			warn(('[Blossom] Unknown icon "%s"'):format(name))
		end
	end
	LucideCache[name] = result
	return result or nil
end

local function imageFor(name)
	if string.find(name, "rbxasset", 1, true) then return { Image = name } end
	local forced = string.match(name, "^lucide:(.+)$")
	if not forced and Icons[name] then return nil end
	return lucideImage(forced or name)
end

local function makeIcon(parent, name, size, color, hole, props)
	props = props or {}
	local root = new("Frame", { Name = "Icon", Size = Offset(size, size), Position = props.Position, AnchorPoint = props.AnchorPoint, ZIndex = props.ZIndex }, parent)
	local icon = { Root = root, Parts = {} }
	local image = type(name) == "string" and imageFor(name)
	if image then
		local picture = new("ImageLabel", { Size = Dim2(1, 0, 1, 0), Image = image.Image }, root)
		if image.RectSize then
			picture.ImageRectSize = image.RectSize
			picture.ImageRectOffset = image.RectOffset or Vector2.zero
		end
		bind(picture, "ImageColor3", color)
		table.insert(icon.Parts, picture)
	else
		local scale = size / 16
		for _, part in Icons[name] or Icons.cube do
			local kind, x, y, w, h, radius, rotation, thickness = table.unpack(part, 1, 8)
			local frame = new("Frame", {
				Position = UDim2.fromScale(x / 16, y / 16), Size = UDim2.fromScale(w / 16, h / 16),
				Rotation = rotation or 0, Radius = radius and radius > 0 and (radius >= FULL and FULL or math.max(1, round(radius * scale))) or nil,
			}, root)
			if kind == "r" then
				local stroke = new("UIStroke", { Thickness = (thickness or 1.5) * scale }, frame)
				bind(stroke, "Color", color)
				table.insert(icon.Parts, stroke)
			else
				frame.BackgroundTransparency = 0
				bind(frame, "BackgroundColor3", kind == "h" and hole or color)
				table.insert(icon.Parts, frame)
			end
		end
	end
	function icon.Update(preset)
		for _, part in icon.Parts do refresh(part, preset) end
	end
	return icon
end

local function interactive(target, base, hover, press, handle)
	local state = { Hover = false, Press = false }
	local source = handle or target
	bind(target, "BackgroundColor3", function()
		if state.Press and press then return Current[press] end
		if state.Hover then return Current[hover or "HoveredElement"] end
		return Current[base]
	end)
	hoverable(source, function() state.Hover = true; refresh(target) end, function() state.Hover, state.Press = false, false; refresh(target) end)
	if source:IsA("GuiButton") then
		source.MouseButton1Down:Connect(function() state.Press = true; refresh(target) end)
		source.MouseButton1Up:Connect(function() state.Press = false; refresh(target) end)
	end
	return state
end

local Window, Tab, Section, Column = {}, {}, {}, {}
Window.__index, Tab.__index, Section.__index, Column.__index = Window, Tab, Section, Column

local function formatNumber(value, decimals)
	if decimals and decimals > 0 then return string.format("%." .. decimals .. "f", value) end
	return tostring(floor(value + 0.5))
end

local function keyName(key)
	if key == nil then return "-" end
	local short = {
		LeftShift = "LS", RightShift = "RS", LeftControl = "LC", RightControl = "RC", LeftAlt = "LA", RightAlt = "RA",
		MouseButton1 = "M1", MouseButton2 = "M2", MouseButton3 = "M3", Return = "Ent", Backspace = "Bk",
		One = "1", Two = "2", Three = "3", Four = "4", Five = "5", Six = "6", Seven = "7", Eight = "8", Nine = "9", Zero = "0",
	}
	return short[key.Name] or key.Name
end

local function makeChip(parent, text, anchorRight, outerHeight)
	local height = (outerHeight or Metrics.ChipH) - 2
	local chip = new("Frame", {
		Bg = "Element", Radius = Metrics.Radius, Border = "Outline", Size = Offset(16, height),
		AnchorPoint = anchorRight and Vec2(1, 0) or nil,
	}, parent)
	addGradient(chip)
	local caption = label(chip, { Fg = "InactiveText", Text = text, TextSize = 11, X = 4, RowH = height })
	return chip, caption
end

local function fitChip(chip, text, minimum, onFit)
	local height = chip.Size.Y.Offset
	local function apply(bounds)
		local width = math.max((minimum or 2) - 2, bounds + 8)
		chip.Size = Offset(width, height)
		text.Position = Offset(floor((width - bounds) / 2), text.Position.Y.Offset)
		if onFit then onFit(width + 2) end
		return width
	end
	local function fit() apply(math.ceil(text.TextBounds.X)) end
	text:GetPropertyChangedSignal("TextBounds"):Connect(fit)
	fit()
	return apply, fit
end

local function makeEditable(chip, text, read, write, apply, fit)
	local height = chip.Size.Y.Offset
	local hit = new("TextButton", { Size = Dim2(1, 0, 1, 0), ZIndex = 2 }, chip)
	interactive(chip, "Element", nil, nil, hit)
	local editing = false
	local stroke = chip:FindFirstChildOfClass("UIStroke")
	bind(stroke, "Color", function() return editing and Current.Accent or Current.Outline end)
	local box = new("TextBox", {
		Fg = "Text", TextSize = 11, Visible = false, ZIndex = 3, ClearTextOnFocus = false,
		Position = Offset(4, capOffset(height, 11)), Size = Dim2(1, -8, 0, height),
	}, chip)
	box:GetPropertyChangedSignal("Text"):Connect(function()
		if editing then apply(math.ceil(box.TextBounds.X)) end
	end)
	hit.MouseButton1Click:Connect(function()
		editing = true
		refresh(stroke)
		box.Text = read()
		text.Visible, box.Visible = false, true
		box:CaptureFocus()
		box.CursorPosition = #box.Text + 1
		box.SelectionStart = 1
	end)
	box.FocusLost:Connect(function()
		if not editing then return end
		editing = false
		refresh(stroke)
		local number = tonumber(string.match(box.Text, "%-?%d*%.?%d+") or "")
		box.Visible, text.Visible = false, true
		if number then write(number) end
		fit()
	end)
end

function Column:Layout(animated)
	local y = 0
	for _, section in self.Sections do
		section.Y = y
		if not section.Dragging and not section.Dropping then
			place(section.Root, "Position", Offset(0, y), animated, "Settle")
		end
		y += section.TotalH + Metrics.SectionGap
	end
	self.ContentH = math.max(0, y - Metrics.SectionGap)
	self.Scroll.CanvasSize = Offset(0, self.ContentH)
	self:ClampScroll()
end

function Column:ClampScroll()
	self.Target = math.clamp(self.Target, 0, math.max(0, self.ContentH - (self.Tab.Window.Height - Metrics.TopBar - Metrics.Pad)))
end

function Column:ScrollTo(y)
	self.Target = y
	self:ClampScroll()
	animate(self.Scroll, "CanvasPosition", Vec2(0, self.Target), "Soft")
end

function Section:Layout(animated)
	local y, any = Metrics.Pad, false
	for _, item in self.Items do
		if item.Visible then
			item.Y, any = y, true
			place(item.Frame, "Position", Offset(0, y), animated)
			y += item.Height + Metrics.Gap
		end
	end
	if any then y -= Metrics.Gap end
	self.CardH = y + Metrics.Pad
	local shown = not self.Collapsed
	self.TotalH = shown and (self.HeaderH + self.CardH) or (Metrics.HeaderH - 8)
    place(self.Header, "Size", Dim2(1, 0, 0, (shown and self.HeaderH or Metrics.HeaderH) - 8), animated)
	place(self.Card, "Size", Dim2(1, -2, 0, shown and (self.CardH - 2) or 0), animated)
	if not self.Dragging then place(self.Root, "Size", Dim2(1, 0, 0, self.TotalH), animated) end
	if self.Column then self.Column:Layout(animated) end
end

function Section:SetCollapsed(collapsed, animated)
	if self.Collapsed == collapsed then return end
	self.Collapsed = collapsed
	if collapsed then self.Window:CloseFloating() else self.Card.Visible = true end
	place(self.Chevron.Root, "Rotation", collapsed and -90 or 0, animated, "Smooth")
    if self.Description then
	place(self.Description, "TextTransparency", collapsed and 1 or 0, animated, "Fast")
    end
	self:Layout(animated)
	if collapsed then
		if animated then
			task.delay(0.4, function()
				if self.Collapsed then self.Card.Visible = false end
			end)
		else
			self.Card.Visible = false
		end
	end
end

function Section:_item(height, kind, name, indexed)
	self.Window:_tick(kind, name)
	local frame = new("Frame", { Size = Dim2(1, 0, 0, height) }, self.Body)
	local item = { Frame = frame, Height = height, Kind = kind, Name = name, Section = self, Slots = {}, Visible = true, Y = 0 }
	table.insert(self.Items, item)
	if name and indexed ~= false then table.insert(self.Window.Index, item) end
	self:Layout(false)
	return item
end

local function layoutSlots(item)
	local x = 0
	for _, slot in item.Slots do
		x += slot.Gap
		slot.Frame.Position = Dim2(1, -x - 1, 0, floor((Metrics.Row - slot.Height) / 2) + 1)
		x += slot.Width
	end
	if item.Label then item.Label.Size = Dim2(1, -(x + Metrics.Gap), 0, Metrics.Row) end
end

local function addSlot(item, frame, width, height, gap)
	local slot = { Frame = frame, Width = width, Height = height, Gap = #item.Slots == 0 and 0 or gap }
	frame.AnchorPoint = Vec2(1, 0)
	table.insert(item.Slots, slot)
	layoutSlots(item)
	return slot
end

local function attachKeybind(section, item, options)
	local win = section.Window
	local object = {
		Key = options.Key, Mode = options.Mode or "Toggle", Listening = false, Enabled = not (TouchOnly and options.Gear),
		OnPress = options.OnPress, OnRelease = options.OnRelease, Name = options.Name,
	}
	if TouchOnly and options.Gear then
		local chip, caption = makeChip(item.Frame, "")
		caption.Visible = false
		chip.Size = Offset(22, Metrics.ChipH - 2)
		local icon = makeIcon(chip, "gear", 10, function()
			return object.Enabled and Current.Accent or Current.InactiveText
		end, "Element", { Position = Offset(6, 2) })
		local hit = new("TextButton", { Position = Offset(-4, -4), Size = Offset(30, 22), ZIndex = 2 }, chip)
		addSlot(item, chip, 24, Metrics.ChipH, Metrics.Gap + 2)
		interactive(chip, "Element", nil, nil, hit)
		function object.Refresh()
			icon.Update()
			if object.OnKeyChanged then object.OnKeyChanged() end
		end
		function object:Set(key)
			object.Key = key
			object.Refresh()
		end
		function object:SetEnabled(value)
			object.Enabled = value == true
			object.Refresh()
		end
		hit.MouseButton1Click:Connect(function() win:OpenKeybindMenu(chip, object) end)
		object.Chip, object.Label = chip, caption
		table.insert(win.Binds, object)
		return object
	end
	local chip, text = makeChip(item.Frame, keyName(object.Key))
	local button = new("TextButton", { Size = Dim2(1, 0, 1, 0), ZIndex = 2 }, chip)
	local slot = addSlot(item, chip, 18, Metrics.ChipH, Metrics.Gap + 2)
	fitChip(chip, text, 18, function(width)
		slot.Width = width
		layoutSlots(item)
	end)
	interactive(chip, "Element", nil, nil, button)
	bind(text, "TextColor3", function()
		if object.Listening then return Current.Accent end
		return Current.InactiveText
	end)
	function object.Refresh()
		setText(text, object.Listening and "..." or keyName(object.Key))
		refresh(text)
		if object.OnKeyChanged then object.OnKeyChanged() end
	end
	function object:Set(key)
		object.Key = key
		object.Refresh()
	end
	button.MouseButton1Click:Connect(function()
		object.Listening = true
		win.Listening = object
		object.Refresh()
	end)
	button.MouseButton2Click:Connect(function() win:OpenKeybindMenu(chip, object) end)
	object.Chip, object.Label = chip, text
	table.insert(win.Binds, object)
	return object
end

local function attachColor(section, item, options)
	local win = section.Window
	local color = {
		Value = options.Default or Color3.new(1, 1, 1), Alpha = options.Alpha or 0, Animation = "None",
		Callback = options.Callback, Flag = options.Flag,
	}
	local swatch = new("TextButton", {
		Size = Offset(Metrics.Swatch - 2, Metrics.Swatch - 2), Radius = Metrics.Radius, BackgroundTransparency = 0,
		BackgroundColor3 = color.Value, Border = "Outline",
	}, item.Frame)
	addSlot(item, swatch, Metrics.Swatch, Metrics.Swatch, Metrics.Gap + 2)
	color.Swatch = swatch
	function color:Set(value, alpha, silent)
		color.Value = value
		if alpha ~= nil then color.Alpha = alpha end
		swatch.BackgroundColor3 = value
		if win.Picker.Target == color and not win.Picker.Dragging then win.Picker.Sync() end
		if not silent then fire(color.Callback, value, color.Alpha) end
	end
	swatch.MouseButton1Click:Connect(function() win:OpenPicker(swatch, color) end)
	table.insert(win.Colors, color)
	return color
end

local function addInlineControls(section, item, options, name)
	local keybind, color
	if options.Color then
		color = attachColor(section, item, { Default = options.Color, Alpha = options.ColorAlpha, Callback = options.ColorCallback })
	end
	if options.Keybind ~= nil then
		keybind = attachKeybind(section, item, { Key = options.Keybind, Mode = options.KeybindMode, Name = options.KeybindName or name, Gear = options.GearOnTouch })
	end
	return keybind, color
end

local function register(section, object, options, item)
	local win = section.Window
	if options.Description then win:_describe(item, options.Description) end
	win.FlagOwners[item] = object
	if options.NoSave then return nil end
	local base = options.Flag or (section.Tab.Name .. "/" .. section.Name .. "/" .. tostring(options.Name or item.Kind))
	local flag, count = base, 1
	while win.Flags[flag] do
		count += 1
		flag = base .. "#" .. count
	end
	win.Flags[flag] = object
	object.Flag = flag
	object.Early = options.Early
	return flag
end

function Section:Toggle(options)
	local win, name = self.Window, options.Name
	local item = self:_item(Metrics.Row, "Toggle", name)
	local toggle = { Value = options.Default == true, Item = item, Callback = options.Callback }
	local hit = new("TextButton", { Position = Offset(0, -3), Size = Dim2(1, 0, 1, 6) }, item.Frame)
	local hovering = false
	local text = label(item.Frame, {
		Text = name, Truncate = Enum.TextTruncate.AtEnd,
		Fg = function()
			if toggle.Value then return Current.Text end
			return hovering and Current.InactiveText:Lerp(Current.Text, 0.45) or Current.InactiveText
		end,
	})
	item.Label = text
	local track = new("Frame", {
		Bg = function() return toggle.Value and Current.Accent or Current.Element end,
		Size = Offset(Metrics.ToggleW - 2, Metrics.ToggleH - 2), Radius = FULL, Border = "Outline",
	}, item.Frame)
	addGradient(track)
	local knob = new("Frame", {
		Bg = function() return toggle.Value and Current.Text or Current.InactiveText end,
		Size = Offset(Metrics.ToggleKnob, Metrics.ToggleKnob), Radius = FULL,
	}, track)
	addSlot(item, track, Metrics.ToggleW, Metrics.ToggleH, 0)

	local function render(animated)
		local x = toggle.Value and Metrics.ToggleW - 2 - Metrics.ToggleKnob - 2 or 2
		place(knob, "Position", Offset(x, 2), animated, "Knob")
		local preset = animated and "Fast" or false
		refresh(track, preset); refresh(knob, preset); refresh(text, preset)
	end
	local function syncHotkey()
		if toggle.Keybind then win:SetHotkeyActive(toggle.Keybind, toggle.Value) end
	end

	function toggle:Set(value, silent)
		value = value == true
		if value == toggle.Value then return end
		toggle.Value = value
		render(true)
		syncHotkey()
		if not silent then fire(toggle.Callback, value) end
	end

	hoverable(hit, function()
		hovering = true
		refresh(text)
	end, function()
		hovering = false
		refresh(text)
	end)
	hit.MouseButton1Click:Connect(function() toggle:Set(not toggle.Value) end)

	local hotkeyName = options.KeybindName or (name == "Enabled" and self.Name) or name
	options.KeybindName = hotkeyName
	options.GearOnTouch = true
	toggle.Keybind, toggle.Color = addInlineControls(self, item, options, hotkeyName)
	if toggle.Keybind then
		toggle.Keybind.Owner = toggle
		toggle.Keybind.OnPress = function()
			if toggle.Keybind.Mode == "Hold" then toggle:Set(true) else toggle:Set(not toggle.Value) end
		end
		toggle.Keybind.OnRelease = function()
			if toggle.Keybind.Mode == "Hold" then toggle:Set(false) end
		end
		toggle.Keybind.OnKeyChanged = syncHotkey
	end
	render(false)
	syncHotkey()
	local flag = register(self, toggle, options, item)
	if flag and toggle.Keybind then win.Flags[flag .. "/Key"] = toggle.Keybind end
	if flag and toggle.Color then win.Flags[flag .. "/Color"] = toggle.Color end
	return toggle
end

function Section:Label(options)
	local name = options.Name or options.Text
	local item = self:_item(Metrics.Row, "Label", name, false)
    if options.Description then self.Window:_describe(item, options.Description) end
	local text = label(item.Frame, { Text = name, Truncate = Enum.TextTruncate.AtEnd })
	item.Label = text
	local object = { Item = item, Instance = text }
	function object:Set(value) setText(text, value) end
	object.Keybind, object.Color = addInlineControls(self, item, options, name)
	return object
end

function Section:Divider()
	local item = self:_item(Metrics.DividerH, "Divider", nil, false)
	new("Frame", { Bg = "Element", Position = Offset(1, 1), Size = Dim2(1, -2, 1, -2), Radius = FULL, Border = "Outline" }, item.Frame)
	return item
end

function Section:Keybind(options)
	local item = self:_item(Metrics.Row, "Keybind", options.Name)
	item.Label = label(item.Frame, { Text = options.Name, Truncate = Enum.TextTruncate.AtEnd })
	local object = attachKeybind(self, item, { Key = options.Default, Mode = options.Mode, Name = options.Name, OnPress = options.Callback })
	object.Item = item
	register(self, object, options, item)
	return object
end

function Section:Colorpicker(options)
	local item = self:_item(Metrics.Row, "Colorpicker", options.Name, options.Indexed)
	item.Label = label(item.Frame, { Text = options.Name, Truncate = Enum.TextTruncate.AtEnd })
	local object = attachColor(self, item, options)
	object.Item = item
	register(self, object, options, item)
	return object
end

local function trackWidth(win)
	return win.ColumnW - Metrics.Pad * 2 - 2
end

local function makeTrack(parent)
	local track = new("Frame", {
		Bg = "Element", Position = Offset(1, Metrics.TrackY + 1), Size = Dim2(1, -2, 0, Metrics.TrackH - 2),
		Radius = FULL, Border = "Outline",
	}, parent)
	addGradient(track)
	local fill = new("Frame", { Name = "Fill", Bg = "Accent", Radius = FULL, Size = Dim2(0, 0, 1, 0) }, track)
	addGradient(fill)
	local hit = new("TextButton", { Position = Offset(-4, Metrics.Row), Size = Dim2(1, 8, 0, Metrics.Row + 1), ZIndex = 4 }, parent)
	return track, fill, hit
end

local function makeKnob(track)
	return new("Frame", { Name = "Knob", Bg = "Text", Size = Offset(Metrics.Knob, Metrics.Knob), Radius = FULL, ZIndex = 3 }, track)
end

local function knobPixels(alpha, width)
	return round(Metrics.TrackInset + alpha * (width - Metrics.TrackInset * 2))
end

local function placeKnob(knob, pixels, animated)
	place(knob, "Position", Offset(pixels - floor(Metrics.Knob / 2), floor((Metrics.TrackH - 2 - Metrics.Knob) / 2)), animated, "Follow")
end

local function alphaAt(track, point)
	local inset = Metrics.TrackInset * LayerScale
	return clamp01((point.X - track.AbsolutePosition.X - inset) / (track.AbsoluteSize.X - inset * 2))
end

function Section:Slider(options)
	local item = self:_item(Metrics.SliderH, "Slider", options.Name)
	local caption = label(item.Frame, { Text = options.Name, Truncate = Enum.TextTruncate.AtEnd })
	local minimum, maximum = options.Min or 0, options.Max or 100
	local decimals, suffix = options.Decimals or 0, options.Suffix or ""
	local slider = { Value = minimum, Item = item, Callback = options.Callback }
	local chip, chipText = makeChip(item.Frame, "", true, Metrics.ValueChipH)
	chip.Position = Dim2(1, -1, 0, 0)
	local apply, fit = fitChip(chip, chipText, 24, function(width) caption.Size = Dim2(1, -(width + Metrics.Gap), 0, Metrics.Row) end)
	local track, fill, hit = makeTrack(item.Frame)
	local knob = makeKnob(track)

	local function render(animated)
		local alpha = maximum == minimum and 0 or (slider.Value - minimum) / (maximum - minimum)
		local pixels = knobPixels(alpha, trackWidth(self.Window))
		placeKnob(knob, pixels, animated)
		place(fill, "Size", Dim2(0, pixels, 1, 0), animated, "Follow")
	end

	function slider:Set(value, silent, animated)
		local step = 10 ^ -decimals
		value = math.clamp(floor(value / step + 0.5) * step, minimum, maximum)
		local changed = value ~= slider.Value
		slider.Value = value
		setText(chipText, formatNumber(value, decimals) .. suffix)
		render(animated ~= false)
		if changed and not silent then fire(slider.Callback, value) end
	end

	makeEditable(chip, chipText, function() return formatNumber(slider.Value, decimals) end, function(number) slider:Set(number) end, apply, fit)

	local function fromMouse(point)
		slider:Set(minimum + (maximum - minimum) * alphaAt(track, point))
	end
	hit.InputBegan:Connect(function(input)
		if not isClick(input) then return end
		fromMouse(mousePos())
		beginDrag(fromMouse)
	end)

	table.insert(self.Window.ResizeJobs, function() render(false) end)
	slider:Set(options.Default or minimum, true, false)
	register(self, slider, options, item)
	return slider
end

function Section:RangeSlider(options)
	local item = self:_item(Metrics.SliderH, "Range Slider", options.Name)
	local caption = label(item.Frame, { Text = options.Name, Truncate = Enum.TextTruncate.AtEnd })
	local minimum, maximum = options.Min or 0, options.Max or 100
	local decimals, suffix = options.Decimals or 0, options.Suffix or ""
	local default = options.Default or { minimum, maximum }
	local range = { Value = { default[1], default[2] }, Item = item, Callback = options.Callback }
	local highChip, highText = makeChip(item.Frame, "", true, Metrics.ValueChipH)
	local lowChip, lowText = makeChip(item.Frame, "", true, Metrics.ValueChipH)
	highChip.Position = Dim2(1, -1, 0, 0)
	local highWidth, lowWidth = 24, 24
	local function layoutChips()
		lowChip.Position = Dim2(1, -(highWidth + Metrics.ChipGap + 1), 0, 0)
		caption.Size = Dim2(1, -(highWidth + lowWidth + Metrics.ChipGap + Metrics.Gap), 0, Metrics.Row)
	end
	local applyHigh, fitHigh = fitChip(highChip, highText, 24, function(width) highWidth = width; layoutChips() end)
	local applyLow, fitLow = fitChip(lowChip, lowText, 24, function(width) lowWidth = width; layoutChips() end)
	local track, fill, hit = makeTrack(item.Frame)
	local lowKnob, highKnob = makeKnob(track), makeKnob(track)

	local function alphaOf(value) return (value - minimum) / (maximum - minimum) end

	local function render(animated)
		local width = trackWidth(self.Window)
		local low, high = knobPixels(alphaOf(range.Value[1]), width), knobPixels(alphaOf(range.Value[2]), width)
		placeKnob(lowKnob, low, animated)
		placeKnob(highKnob, high, animated)
		place(fill, "Position", Dim2(0, low, 0, 0), animated, "Follow")
		place(fill, "Size", Dim2(0, high - low, 1, 0), animated, "Follow")
	end

	function range:Set(value, silent, animated)
		range.Value = { math.min(value[1], value[2]), math.max(value[1], value[2]) }
		setText(lowText, formatNumber(range.Value[1], decimals) .. suffix)
		setText(highText, formatNumber(range.Value[2], decimals) .. suffix)
		render(animated ~= false)
		if not silent then fire(range.Callback, range.Value) end
	end

	local function snapped(value)
		local step = 10 ^ -decimals
		return math.clamp(floor(value / step + 0.5) * step, minimum, maximum)
	end

	makeEditable(lowChip, lowText, function() return formatNumber(range.Value[1], decimals) end, function(number)
		range:Set({ math.min(snapped(number), range.Value[2]), range.Value[2] })
	end, applyLow, fitLow)
	makeEditable(highChip, highText, function() return formatNumber(range.Value[2], decimals) end, function(number)
		range:Set({ range.Value[1], math.max(snapped(number), range.Value[1]) })
	end, applyHigh, fitHigh)

	local active = 1
	local function valueAt(point)
		return snapped(minimum + (maximum - minimum) * alphaAt(track, point))
	end
	local function fromMouse(point)
		local value, nextValue = valueAt(point), { range.Value[1], range.Value[2] }
		if active == 1 then
			nextValue[1] = math.min(value, nextValue[2])
		else
			nextValue[2] = math.max(value, nextValue[1])
		end
		range:Set(nextValue)
	end
	hit.InputBegan:Connect(function(input)
		if not isClick(input) then return end
		local point = mousePos()
		local value = valueAt(point)
		active = math.abs(value - range.Value[1]) <= math.abs(value - range.Value[2]) and 1 or 2
		fromMouse(point)
		beginDrag(fromMouse)
	end)

	table.insert(self.Window.ResizeJobs, function() render(false) end)
	range:Set(range.Value, true, false)
	register(self, range, options, item)
	return range
end

local SEARCH_BAR_H = 32

local function buildDropdown(win, parent, options)
	local dropdown = {
		Options = options.Options or {}, Multi = options.Multi == true, Open = false,
		Value = options.Multi and {} or options.Default, Callback = options.Callback,
	}
	if options.Multi and options.Default then
		for _, value in options.Default do dropdown.Value[value] = true end
	end

	local input = new("TextButton", {
		Position = Offset(1, (options.Y or 0) + 1), Size = Dim2(1, -2, 0, Metrics.InputH - 2), Radius = Metrics.Radius, BackgroundTransparency = 0,
	}, parent)
	interactive(input, "Element")
	addGradient(input)
	local stroke = new("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 1 }, input)
	bind(stroke, "Color", function() return dropdown.Open and Current.Accent or Current.Outline end)
	local value = label(input, { Fg = "InactiveText", TextSize = 13, X = 7, RowH = Metrics.InputH - 2, Right = 8, Truncate = Enum.TextTruncate.AtEnd })

	local panel = new("TextButton", { Bg = "Background", BackgroundTransparency = 1, Radius = Metrics.Radius, Visible = false, Size = Offset(10, 0) }, win.Dropdowns)
	local panelStroke = new("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 1, Transparency = 1 }, panel)
	bind(panelStroke, "Color", "Outline")

	local searchBar = new("Frame", { Visible = false, Size = Dim2(1, 0, 0, SEARCH_BAR_H) }, panel)
	local searchField = new("Frame", {
		Bg = "Element", BackgroundTransparency = 1, Radius = Metrics.Radius,
		Position = Offset(5, 5), Size = Dim2(1, -10, 0, SEARCH_BAR_H - 10),
	}, searchBar)
	local searchStroke = new("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 1, Transparency = 1 }, searchField)
	local searchFocused = false
	bind(searchStroke, "Color", function() return searchFocused and Current.Accent or Current.Outline end)
	local searchBox = new("TextBox", {
		Fg = "Text", TextSize = 12, PlaceholderText = "Search...", Text = "", ClearTextOnFocus = false, TextTransparency = 1,
		Position = Offset(8, capOffset(SEARCH_BAR_H - 10, 12)), Size = Dim2(1, -16, 0, 16),
	}, searchField)
	bind(searchBox, "PlaceholderColor3", "InactiveText")

	local list = new("ScrollingFrame", { Size = Dim2(1, 0, 1, 0), ScrollBarThickness = 0, CanvasSize = Offset(0, 0) }, panel)
	local rows, panelH, barH, flipped, searchable, query = {}, 0, 0, false, false, ""
	local emptyText = label(panel, { Fg = "InactiveText", Text = options.Empty or "No options", TextSize = 13, X = 9, RowH = Metrics.ListRowH, Right = 8, TextTransparency = 1 })
	local emptyY = emptyText.Position.Y.Offset
	dropdown.Reveal = 0

	local function isSelected(option)
		if dropdown.Multi then return dropdown.Value[option] == true end
		return dropdown.Value == option
	end

	local function caption()
		if not dropdown.Multi then return dropdown.Value and tostring(dropdown.Value) or "None" end
		local names = {}
		for _, option in dropdown.Options do
			if dropdown.Value[option] then table.insert(names, tostring(option)) end
		end
		return #names > 0 and table.concat(names, ", ") or "None"
	end

	local function applyRow(row)
		local reveal = dropdown.Reveal
		row.Button.BackgroundTransparency = 1 - math.max(row.Sel, row.Hov) * reveal
		row.Bar.BackgroundTransparency = 1 - row.Sel * reveal
		row.Text.TextTransparency = 1 - reveal
	end

	local function applyReveal()
		local reveal = dropdown.Reveal
		panel.BackgroundTransparency = 1 - reveal
		panelStroke.Transparency = 1 - reveal
		emptyText.TextTransparency = 1 - reveal
		searchField.BackgroundTransparency = 1 - reveal
		searchStroke.Transparency = 1 - reveal
		searchBox.TextTransparency = 1 - reveal
		for _, row in rows do applyRow(row) end
	end

	local function paint(animated)
		local preset = animated and "Fast" or false
		for _, row in rows do
			local selected = isSelected(row.Option)
			if animated then
				animate(row, "Sel", selected and 1 or 0, "Fast", { Step = function() applyRow(row) end })
			else
				snap(row, "Sel", selected and 1 or 0)
				applyRow(row)
			end
			place(row.Text, "Position", Offset(selected and 17 or 8, row.TextY), animated, "Smooth")
			refresh(row.Text, preset)
			refresh(row.Button, preset)
		end
		setText(value, caption())
	end

	local function applyFilter()
		local needle = string.lower(query)
		local shown = 0
		for _, row in rows do
			local match = needle == "" or string.find(string.lower(tostring(row.Option)), needle, 1, true) ~= nil
			row.Button.Visible = match
			if match then
				row.Y = shown * Metrics.ListRowH
				snap(row.Button, "Position", Offset(0, row.Y))
				shown += 1
			end
		end
		list.CanvasSize = Offset(0, shown * Metrics.ListRowH)
		list.CanvasPosition = Vec2(0, 0)
		emptyText.Visible = shown == 0
		setText(emptyText, #dropdown.Options == 0 and (options.Empty or "No options") or "No results")
	end

	local function rebuild()
		for _, row in rows do row.Button:Destroy() end
		rows = {}
		for index, option in dropdown.Options do
			local row = { Option = option, Sel = 0, Hov = 0, Hovering = false, Y = (index - 1) * Metrics.ListRowH }
			row.Button = new("TextButton", {
				Bg = function() return row.Hovering and Current.Inline or Current.Tab end,
				BackgroundTransparency = 1, Position = Offset(0, row.Y), Size = Dim2(1, 0, 0, Metrics.ListRowH),
				Radius = Metrics.Radius,
			}, list)
			row.Bar = new("Frame", { Bg = "Accent", BackgroundTransparency = 1, Position = Offset(7, 6), Size = Offset(2, 12) }, row.Button)
			row.Text = label(row.Button, {
				Text = tostring(option), X = 8, TextSize = 13, RowH = Metrics.ListRowH, Right = 18, Truncate = Enum.TextTruncate.AtEnd, TextTransparency = 1,
				Fg = function() return isSelected(option) and Current.Text or Current.InactiveText end,
			})
			row.TextY = row.Text.Position.Y.Offset
			local function step() applyRow(row) end
			hoverable(row.Button, function()
				row.Hovering = true
				refresh(row.Button)
				animate(row, "Hov", 1, "Fast", { Step = step })
			end, function()
				row.Hovering = false
				refresh(row.Button)
				animate(row, "Hov", 0, "Fast", { Step = step })
			end)
			row.Button.MouseButton1Click:Connect(function()
				if dropdown.Multi then
					dropdown.Value[option] = not dropdown.Value[option] or nil
					paint(true)
					fire(dropdown.Callback, dropdown.Value)
				else
					dropdown:Set(option)
					dropdown:Toggle(false)
				end
			end)
			table.insert(rows, row)
		end
		applyFilter()
		paint(false)
	end

	local function measure()
		searchable = options.Search == true or (options.Search ~= false and #dropdown.Options > 5)
		barH = searchable and SEARCH_BAR_H or 0
		searchBar.Visible = searchable
		list.Position = Offset(0, barH)
		list.Size = Dim2(1, 0, 1, -barH)
		emptyText.Position = Offset(9, barH + emptyY)
		panelH = barH + math.clamp(#dropdown.Options, 1, options.MaxRows or 10) * Metrics.ListRowH
	end

	searchBox:GetPropertyChangedSignal("Text"):Connect(function()
		query = searchBox.Text
		applyFilter()
	end)
	searchBox.Focused:Connect(function() searchFocused = true; refresh(searchStroke) end)
	searchBox.FocusLost:Connect(function(enterPressed)
		searchFocused = false
		refresh(searchStroke)
		if enterPressed and query ~= "" and not dropdown.Multi then
			for _, row in rows do
				if row.Button.Visible then
					dropdown:Set(row.Option)
					dropdown:Toggle(false)
					break
				end
			end
		end
	end)

	local function follow()
		local p, s = input.AbsolutePosition, input.AbsoluteSize
		local top = win.Screen.AbsolutePosition.Y
		local bottom = top + win.Screen.AbsoluteSize.Y
		local height, gap = panelH * LayerScale, 6 * LayerScale
		flipped = p.Y + s.Y + gap + height > bottom - 8 and p.Y - gap - height > top + 8
		local goal = toLayer(Vec2(p.X, flipped and p.Y - gap or p.Y + s.Y + gap))
		panel.AnchorPoint = flipped and Vec2(0, 1) or Vec2(0, 0)
		panel.Position = Offset(goal.X, goal.Y)
	end
	dropdown.Follow = follow

	function dropdown:Toggle(open)
		if open == nil then open = not dropdown.Open end
		if open == dropdown.Open then return end
		dropdown.Open = open
		refresh(stroke)
		local width = input.AbsoluteSize.X / LayerScale
		if open then
			if win.OpenDropdown and win.OpenDropdown ~= dropdown then win.OpenDropdown:Toggle(false) end
			win.OpenDropdown = dropdown
			searchBox.Text, query = "", ""
			applyFilter()
			measure()
			follow()
			panel.Visible = true
			panel.Size = Offset(width, panelH)
			animate(dropdown, "Reveal", 1, "Fast", { Step = applyReveal })
			local listH = panelH - barH
			local selectedIndex = not dropdown.Multi and table.find(dropdown.Options, dropdown.Value)
			local furthest = math.max(0, #dropdown.Options * Metrics.ListRowH - listH)
			list.CanvasPosition = Vec2(0, selectedIndex and math.clamp(floor((selectedIndex - 1) * Metrics.ListRowH - (listH - Metrics.ListRowH) / 2), 0, furthest) or 0)
			for index, row in rows do
				local y = row.Y
				row.Button.Position = Offset(0, y + 6)
				task.delay(math.min(index, 10) * 0.012, function()
					if row.Button.Parent then place(row.Button, "Position", Offset(0, y), dropdown.Open, "Smooth") end
				end)
			end
			if searchable then
				task.defer(function()
					if dropdown.Open then searchBox:CaptureFocus() end
				end)
			end
		else
			if win.OpenDropdown == dropdown then win.OpenDropdown = nil end
			searchBox:ReleaseFocus()
			animate(dropdown, "Reveal", 0, "Fast", {
				Step = applyReveal,
				Done = function() panel.Visible = false end,
			})
		end
	end

	function dropdown:Set(newValue, silent)
		if dropdown.Multi then
			dropdown.Value = {}
			for _, option in newValue do dropdown.Value[option] = true end
		else
			dropdown.Value = newValue
		end
		paint(true)
		if not silent then fire(dropdown.Callback, dropdown.Multi and dropdown.Value or newValue) end
	end

	function dropdown:SetOptions(newOptions)
		dropdown.Options = newOptions
		rebuild()
		if dropdown.Open then
			measure()
			panel.Size = Offset(input.AbsoluteSize.X / LayerScale, panelH)
		end
	end

	dropdown.Input, dropdown.Panel = input, panel
	input.MouseButton1Click:Connect(function()
		if win.DropdownClosedBy == input and os.clock() - win.DropdownClosedAt < 0.25 then return end
		dropdown:Toggle()
	end)
	rebuild()
	return dropdown
end

function Section:Dropdown(options)
	local item = self:_item(Metrics.DropdownH, "Dropdown", options.Name)
	label(item.Frame, { Text = options.Name, Truncate = Enum.TextTruncate.AtEnd })
	options.Y = Metrics.DropdownH - Metrics.InputH
	local dropdown = buildDropdown(self.Window, item.Frame, options)
	dropdown.Item = item
	register(self, dropdown, options, item)
	return dropdown
end

function Section:Button(options)
	local item = self:_item(Metrics.ButtonH, "Button", options.Name)
	if options.Description then self.Window:_describe(item, options.Description) end
	local win = self.Window
	local button = new("TextButton", { Position = Offset(1, 1), Size = Dim2(1, -2, 0, Metrics.ButtonH - 2), Radius = Metrics.Radius, Border = "Outline", BackgroundTransparency = 0 }, item.Frame)
	interactive(button, "Element", "HoveredElement", "Inline")
	addGradient(button)
	local _, setWidth = centeredLabel(button, trackWidth(win), { Text = options.Name, TextSize = 13, RowH = Metrics.ButtonH - 2 })
	table.insert(win.ResizeJobs, function() setWidth(trackWidth(win)) end)
	local object = { Item = item, Instance = button, Callback = options.Callback }
	button.MouseButton1Click:Connect(function() fire(object.Callback) end)
	return object
end

function Section:Textbox(options)
	local item = self:_item(Metrics.InputH, "Textbox", options.Name or options.Placeholder)
	local frame = new("Frame", { Bg = "Element", Position = Offset(1, 1), Size = Dim2(1, -2, 0, Metrics.InputH - 2), Radius = Metrics.Radius, Border = "Outline" }, item.Frame)
	addGradient(frame)
	local box = new("TextBox", {
		Fg = "Text", PlaceholderText = options.Placeholder or options.Name or "", Text = options.Default or "", TextSize = 13,
		Position = Offset(7, capOffset(Metrics.InputH - 2, 13)), Size = Dim2(1, -14, 0, 18), ClearTextOnFocus = false,
	}, frame)
	bind(box, "PlaceholderColor3", "InactiveText")
	local object = { Item = item, Instance = box, Value = box.Text, Callback = options.Callback }
	function object:Set(text, silent)
		box.Text = text
		object.Value = text
		if not silent then fire(object.Callback, text) end
	end
	local stroke = frame:FindFirstChildOfClass("UIStroke")
	local focused = false
	bind(stroke, "Color", function() return focused and Current.Accent or Current.Outline end)
	box.Focused:Connect(function() focused = true; refresh(stroke) end)
	box.FocusLost:Connect(function()
		focused = false
		refresh(stroke)
		object:Set(box.Text)
	end)
	register(self, object, options, item)
	return object
end

function Section:Listbox(options)
	local height = options.Height or 177
	local item = self:_item(height, "Listbox", options.Name, false)
	local frame = new("ScrollingFrame", {
		Bg = "Inline", Position = Offset(1, 1), Size = Dim2(1, -2, 0, height - 2), Radius = Metrics.Radius, Border = "Outline",
		ScrollBarThickness = 0, CanvasSize = Offset(0, 0),
	}, item.Frame)
	local listbox = { Options = {}, Value = nil, Item = item, Callback = options.Callback }
	local rows = {}
	local emptyText = label(frame, { Fg = "InactiveText", Text = options.Empty or "Nothing here yet", TextSize = 13, X = 10, Y = 2, RowH = Metrics.ListRowH, Right = 8 })

	local function paint(animated)
		local preset = animated and "Fast" or false
		for _, row in rows do
			local selected = listbox.Value == row.Option
			refresh(row.Text, preset)
			place(row.Text, "Position", Offset(selected and 17 or 8, row.TextY), animated, "Smooth")
			place(row.Bar, "BackgroundTransparency", selected and 0 or 1, animated, "Fast")
		end
	end

	function listbox:Set(value, silent)
		listbox.Value = value
		paint(true)
		if not silent then fire(listbox.Callback, value) end
	end

	function listbox:SetOptions(optionsList)
		for _, row in rows do row.Button:Destroy() end
		rows, listbox.Options = {}, optionsList
		for index, option in optionsList do
			local row = { Option = option }
			row.Button = new("TextButton", {
				Bg = "HoveredElement", BackgroundTransparency = 1, Position = Offset(2, 2 + (index - 1) * Metrics.ListRowH),
				Size = Dim2(1, -4, 0, Metrics.ListRowH), Radius = Metrics.SmallRadius,
			}, frame)
			NoFade[row.Button] = true
			row.Bar = new("Frame", { Bg = "Accent", BackgroundTransparency = 1, Position = Offset(6, 6), Size = Offset(2, 12) }, row.Button)
			row.Text = label(row.Button, {
				Text = option, X = 8, TextSize = 13, RowH = Metrics.ListRowH, Right = 18, Truncate = Enum.TextTruncate.AtEnd,
				Fg = function() return listbox.Value == option and Current.Text or Current.InactiveText end,
			})
			row.TextY = row.Text.Position.Y.Offset
			hoverable(row.Button, function() animate(row.Button, "BackgroundTransparency", 0, "Fast") end, function() animate(row.Button, "BackgroundTransparency", 1, "Fast") end)
			row.Button.MouseButton1Click:Connect(function() listbox:Set(option) end)
			table.insert(rows, row)
		end
		frame.CanvasSize = Offset(0, 4 + #optionsList * Metrics.ListRowH)
		emptyText.Visible = #optionsList == 0
		paint(false)
	end

	listbox:SetOptions(options.Options or {})
	return listbox
end

function Section:_beginDrag(immediate)
	if self.Dropping then return end
	local win, start = self.Window, mousePos()
	local grab = start - self.Root.AbsolutePosition
	local stroke = self.Card:FindFirstChildOfClass("UIStroke")
	local lifted, ghost, ghostFader = false, nil, nil

	local function slotPosition(column)
		return column.Scroll.AbsolutePosition + Vec2(0, (self.Y - column.Scroll.CanvasPosition.Y) * LayerScale)
	end

	local function targetFor(point)
		local page = self.Tab
		local left, right = page.Columns[1], page.Columns[2]
		local boundary = (left.Scroll.AbsolutePosition.X + left.Scroll.AbsoluteSize.X + right.Scroll.AbsolutePosition.X) / 2
		local column = point.X < boundary and left or right
		local current = table.find(column.Sections, self)
		local index = 1
		for position, other in column.Sections do
			if other ~= self then
				local middle = column.Scroll.AbsolutePosition.Y + (other.Y + other.TotalH / 2 - column.Scroll.CanvasPosition.Y) * LayerScale
				local bias = ((current and position < current) and -14 or 14) * LayerScale
				if point.Y > middle + bias then index += 1 end
			end
		end
		return column, index
	end

	local function lift()
		lifted = true
		self.Dragging = true
		win:CloseFloating()
		local layer = toLayer(self.Root.AbsolutePosition)
		self.Root.Parent = win.DragLayer
		self.Root.Size = Offset(win.ColumnW, self.TotalH)
		self.Root.Position = Offset(layer.X, layer.Y)
		refresh(stroke)
		ghost = new("Frame", {
			Bg = "Accent", BackgroundTransparency = 0.92, Radius = Metrics.CardRadius, Border = "Accent",
			Position = Offset(layer.X, layer.Y), Size = Offset(win.ColumnW, self.TotalH), ZIndex = -1,
		}, win.DragLayer)
		ghostFader = newFader(ghost)
		ghost.Visible = false
		ghostFader:Show(nil, "Fast")
	end

	local function move(point)
		if not lifted then
			if (point - start).Magnitude < 5 then return end
			lift()
		end
		local goal = toLayer(point - grab)
		animate(self.Root, "Position", Offset(goal.X, goal.Y), "Follow")
		local column, index = targetFor(point)
		local current = table.find(column.Sections, self)
		if column ~= self.Column or current ~= index then
			local previous = self.Column
			table.remove(previous.Sections, table.find(previous.Sections, self))
			table.insert(column.Sections, math.min(index, #column.Sections + 1), self)
			self.Column = column
			if previous ~= column then previous:Layout(true) end
			column:Layout(true)
		end
	end

	local function frame(point)
		if not lifted then return end
		local column = self.Column
		local scroll = column.Scroll
		local top, bottom = scroll.AbsolutePosition.Y, scroll.AbsolutePosition.Y + scroll.AbsoluteSize.Y
		if point.X >= scroll.AbsolutePosition.X and point.X <= scroll.AbsolutePosition.X + scroll.AbsoluteSize.X then
			if point.Y < top + 36 then column:ScrollTo(column.Target - 8)
			elseif point.Y > bottom - 36 then column:ScrollTo(column.Target + 8) end
		end
		local slot = toLayer(slotPosition(column))
		animate(ghost, "Position", Offset(slot.X, slot.Y), "Smooth")
	end

	if immediate then lift() end

	beginDrag(move, function()
		if not lifted then return end
		local column = self.Column
		column:Layout(true)
		self.Dragging = false
		self.Dropping = true
		refresh(stroke)
		local goal = toLayer(slotPosition(column))
		local doomed = ghost
		ghostFader:Hide(function() doomed:Destroy() end)
		animate(self.Root, "Position", Offset(goal.X, goal.Y), "Smooth", {
			Done = function()
				self.Dropping = false
				self.Root.Parent = column.Scroll
				self.Root.Size = Dim2(1, 0, 0, self.TotalH)
				self.Root.Position = Offset(0, self.Y)
			end,
		})
	end, frame)
end

function Tab:Section(options)
	self.Window:_tick("Section", options.Name)
	local win = self.Window
	local column = self.Columns[options.Side or 1]
	local headerH = options.Description and Metrics.HeaderDescH or Metrics.HeaderH
	local root = new("Frame", { Name = options.Name, Size = Dim2(1, 0, 0, headerH) }, column.Scroll)
	local header = new("TextButton", { Size = Dim2(1, 0, 0, headerH - 8) }, root)
	local hovering = false
	local titleColor = function() return hovering and Current.Text or Current.InactiveText end
	local icon = makeIcon(header, options.Icon or "cube", 16, titleColor, "Tab")
	local title = label(header, { Text = options.Name, X = 27, Right = 24, Fg = titleColor, Truncate = Enum.TextTruncate.AtEnd })
    local description
    if options.Description then
	description = label(header, { Fg = "InactiveText", Text = options.Description, TextSize = 11, RowH = 14, Y = 18, Truncate = Enum.TextTruncate.AtEnd })
    end
	local fold = new("TextButton", { AnchorPoint = Vec2(1, 0), Position = Dim2(1, 0, 0, 0), Size = Offset(24, Metrics.Row), ZIndex = 2 }, header)
	local chevron = makeIcon(fold, "chevron", 14, titleColor, "Tab", { AnchorPoint = Vec2(0.5, 0.5), Position = Offset(12, Metrics.Row / 2) })
	local section
	local card = new("Frame", {
		Bg = "Inline", Active = true, ClipsDescendants = true, Position = Offset(1, headerH + 1), Size = Dim2(1, -2, 0, 0),
		Radius = Metrics.CardRadius,
	}, root)
	local stroke = new("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 1 }, card)
	bind(stroke, "Color", function() return section and section.Dragging and Current.Accent or Current.Outline end)
	local body = new("Frame", { Position = Offset(Metrics.Pad - 1, -1), Size = Dim2(1, -(Metrics.Pad - 1) * 2, 1, 2) }, card)
    section = setmetatable({
	Window = win, Tab = self, Column = column, Name = options.Name, Root = root, Card = card, Body = body,
	Items = {}, HeaderH = headerH, TotalH = headerH, CardH = 0, Y = 0, Dragging = false, Dropping = false, Title = title,
	Chevron = chevron, Collapsed = false, Header = header, Description = description,
    }, Section)
	table.insert(column.Sections, section)
	table.insert(win.Sections, section)
	hoverable(header, function() hovering = true; icon.Update(); chevron.Update(); refresh(title) end, function() hovering = false; icon.Update(); chevron.Update(); refresh(title) end)
	header.InputBegan:Connect(function(input)
		trackTouch(input)
		local kind = input.UserInputType
		if kind == Enum.UserInputType.MouseButton1 then
			section:_beginDrag()
		elseif kind == Enum.UserInputType.Touch then
			local origin = input.Position
			task.delay(0.35, function()
				local state = input.UserInputState
				if state == Enum.UserInputState.End or state == Enum.UserInputState.Cancel then return end
				if (input.Position - origin).Magnitude > 10 then return end
				if section.Dragging or section.Dropping then return end
				section:_beginDrag(true)
			end)
		end
	end)
	fold.MouseButton1Click:Connect(function() section:SetCollapsed(not section.Collapsed, true) end)
	section:Layout(false)
	if options.Collapsed then section:SetCollapsed(true, false) end
	return section
end

local function guiParent(screen)
	local ok = false
	if typeof(gethui) == "function" then
		ok = pcall(function() screen.Parent = gethui() end)
	end
	if not ok then
		ok = pcall(function() screen.Parent = game:GetService("CoreGui") end)
	end
	if not ok or not screen.Parent then
		screen.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
	end
end

local function sidebarStep(entry, before)
	if entry.Kind == "Category" then return before and Metrics.TabToCategory or 0 end
	return (before and before.Kind == "Category") and Metrics.CategoryToTab or Metrics.TabPitch
end

function Window:_layoutSidebar(animated)
	local y, fullY, previous, fullPrevious = Metrics.FirstCategory, Metrics.FirstCategory, nil, nil
	for _, entry in self.SidebarItems do
		fullY += sidebarStep(entry, fullPrevious)
		fullPrevious = entry
		if entry.Kind == "Category" then
			y += sidebarStep(entry, previous)
			previous = entry
			entry.Y = y
			place(entry.Root, "Position", Offset(0, y - 8), animated, "Smooth")
		elseif entry.Category and entry.Category.Collapsed and not self.SidebarCollapsed then
			if not entry.Hidden then
				entry.Hidden = true
				if animated then entry.Fader:Hide() else entry.Button.Visible = false end
			end
		else
			y += sidebarStep(entry, previous)
			previous = entry
			entry.Y = y - Metrics.TabH / 2
			local goal = Offset(Metrics.Pad, entry.Y)
			if entry.Hidden then
				entry.Hidden = false
				snap(entry.Button, "Position", goal)
				if animated then entry.Fader:Show() else entry.Button.Visible = true end
			else
				place(entry.Button, "Position", goal, animated, "Smooth")
			end
		end
	end
	self.SidebarY = fullY
	self:_syncIndicator(animated)
end

function Window:_syncIndicator(animated)
	local tab = self.CurrentTab
	if not tab then return end
	if tab.Hidden then
		if self.IndicatorOn then
			self.IndicatorOn = false
			if animated then self.IndicatorFader:Hide() else self.Indicator.Visible = false end
		end
		return
	end
	local goal = Offset(Metrics.Pad + 1, tab.Y + 1)
	if self.IndicatorOn then
		place(self.Indicator, "Position", goal, animated, "Soft")
	else
		self.IndicatorOn = true
		snap(self.Indicator, "Position", goal)
		if animated then self.IndicatorFader:Show() else self.Indicator.Visible = true end
	end
end

function Window:Category(name)
	self:_tick("Category", name)
	local window = self
	local root = new("TextButton", { Size = Offset(self.SidebarW, 16) }, self.Sidebar)
	local hovering = false
	local color = function() return hovering and Current.Text or Current.InactiveText end
	local text = label(root, { Fg = color, Text = name, TextSize = 9, X = Metrics.Pad, Y = 2, RowH = 12, W = 100 })
	local arrow = makeIcon(root, "chevron", 12, color, "Background", {
		AnchorPoint = Vec2(0.5, 0.5), Position = Offset(self.SidebarW - Metrics.Pad - 8, 8),
	})
	local rule = new("Frame", { Bg = "Outline", Position = Offset(floor((self.SidebarW - 20) / 2), 7), Size = Offset(20, 1), Visible = false }, root)
	local category = { Kind = "Category", Name = name, Root = root, Collapsed = false, Arrow = arrow, Text = text, Rule = rule }
	function category:SetCollapsed(collapsed, animated)
		if self.Collapsed == collapsed then return end
		self.Collapsed = collapsed
		place(arrow.Root, "Rotation", collapsed and -90 or 0, animated, "Smooth")
		window:_layoutSidebar(animated)
	end
	hoverable(root, function()
		hovering = true
		refresh(text)
		arrow.Update()
	end, function()
		hovering = false
		refresh(text)
		arrow.Update()
	end)
	root.MouseButton1Click:Connect(function()
		if window.SidebarCollapsed then return end
		category:SetCollapsed(not category.Collapsed, true)
	end)
	self.CurrentCategory = category
	table.insert(self.SidebarItems, category)
	self:_layoutSidebar(false)
	return category
end

function Window:Tab(options)
	self:_tick("Tab", options.Name)
	local tab = setmetatable({
		Window = self, Name = options.Name, Kind = "Tab", Y = 0, Hidden = false, Category = self.CurrentCategory,
	}, Tab)
	local button = new("TextButton", { Size = Offset(self.SidebarW - Metrics.Pad * 2, Metrics.TabH), ZIndex = 2, ClipsDescendants = true }, self.Sidebar)
	tab.Button = button
	tab.Fader = newFader(button)
	local hovering = false
	local isActive = function() return self.CurrentTab == tab end
	local color = function() return (isActive() or hovering) and Current.Text or Current.InactiveText end
	local hole = function() return isActive() and Current.Inline or Current.Background end
	tab.Icon = makeIcon(button, options.Icon or "cube", 16, color, hole, { Position = Offset(6, 6) })
	tab.Label = label(button, { Text = options.Name, X = 33, TextSize = 13, RowH = Metrics.TabH, Fg = color, Right = 6, Truncate = Enum.TextTruncate.AtEnd })
	tab.LabelY = tab.Label.Position.Y.Offset

	tab.Page = new("Frame", { Name = options.Name, Size = Dim2(1, 0, 1, 0), Visible = false }, self.Pages)
	tab.Columns = {}
	for index = 1, 2 do
		local scroll = new("ScrollingFrame", {
			Position = Offset(Metrics.Pad + (index - 1) * (self.ColumnW + Metrics.Pad), 0),
			Size = Dim2(0, self.ColumnW, 1, 0), ScrollBarThickness = 0, CanvasSize = Offset(0, 0),
			ScrollingEnabled = not UserInputService.MouseEnabled, ClipsDescendants = true,
		}, tab.Page)
		local column = setmetatable({ Scroll = scroll, Sections = {}, Target = 0, ContentH = 0, Tab = tab, ShowTop = false, ShowBottom = false }, Column)
		local function edge(position, rotation)
			local frame = new("Frame", { Bg = "Tab", BackgroundTransparency = 1, Position = position, Size = Offset(self.ColumnW, 14), ZIndex = 4 }, tab.Page)
			new("UIGradient", { Rotation = rotation, Transparency = NumberSequence.new(1, 0) }, frame)
			return frame
		end
		local edgeX = Metrics.Pad + (index - 1) * (self.ColumnW + Metrics.Pad)
		column.FadeTop, column.FadeBottom = edge(Offset(edgeX, 0), 270), edge(Dim2(0, edgeX, 1, -14), 90)
		table.insert(self.Columns, column)
		tab.Columns[index] = column
	end

	local function paint()
		tab.Icon.Update()
		refresh(tab.Label)
		animate(tab.Label, "Position", Offset(hovering and not isActive() and 35 or 33, tab.LabelY), "Smooth")
	end
	tab.Paint = paint
	hoverable(button, function() hovering = true; paint() end, function() hovering = false; paint() end)
	button.MouseButton1Click:Connect(function() self:SelectTab(tab) end)
	table.insert(self.Tabs, tab)
    table.insert(self.SidebarItems, tab)
    self:_layoutSidebar(false)
	if not self.CurrentTab then self:SelectTab(tab, true) end
	return tab
end

function Window:SelectTab(tab, instant)
	if self.CurrentTab == tab then return end
	local previous = self.CurrentTab
	self.CurrentTab = tab
	self:CloseFloating()
	if previous then
		previous.Page.Visible = false
		previous.Paint()
	end
	tab.Page.Visible = true
	tab.Paint()
    self:_syncIndicator(not instant)
	if not instant then
		self.Veil.BackgroundTransparency = 0
		animate(self.Veil, "BackgroundTransparency", 1, "Soft")
		tab.Page.Position = Offset(0, 10)
		animate(tab.Page, "Position", Offset(0, 0), "Soft")
	end
end

function Window:SetHotkeyActive(object, active)
	local entry = self.HotkeyEntries[object]
	local shouldShow = object.Enabled ~= false and (TouchOnly or (active and object.Key ~= nil))
	local extra = TouchOnly and 28 or 0
	local function caption()
		if TouchOnly then return object.Name or "Key" end
		return (object.Name or "Key") .. " - " .. keyName(object.Key)
	end
	if shouldShow and not entry then
		local frame = new("Frame", { Bg = "Background", Size = Offset(40, 24), Radius = Metrics.FloatRadius, Border = "Outline", Visible = false }, self.Hotkeys)
		new("Frame", { Bg = "Accent", Position = Offset(1, 5), Size = Offset(2, 14), Radius = Metrics.SmallRadius }, frame)
		local text = label(frame, { TextSize = 12, X = Metrics.Pad, RowH = 24, Weight = Enum.FontWeight.SemiBold })
		entry = { Frame = frame, Label = text, Fader = newFader(frame) }
		self.HotkeyEntries[object] = entry
		table.insert(self.HotkeyOrder, object)
		local function fit()
			frame.Size = Offset(math.ceil(text.TextBounds.X) + Metrics.Pad * 2 + extra, 24)
		end
		text:GetPropertyChangedSignal("TextBounds"):Connect(fit)
		setText(text, caption())
		fit()
		local owner = object.Owner
		if TouchOnly and owner then
			local track = new("Frame", {
				Bg = function() return owner.Value and Current.Accent or Current.Element end,
				AnchorPoint = Vec2(1, 0), Position = Dim2(1, -9, 0, 7), Size = Offset(20, 10), Radius = FULL, Border = "Outline",
			}, frame)
			local knob = new("Frame", {
				Bg = function() return owner.Value and Current.Text or Current.InactiveText end,
				Position = Offset(2, 2), Size = Offset(6, 6), Radius = FULL,
			}, track)
			local hit = new("TextButton", { Size = Dim2(1, 0, 1, 0), ZIndex = 2 }, frame)
			function entry.Render(animated)
				place(knob, "Position", Offset(owner.Value and 12 or 2, 2), animated, "Knob")
				local preset = animated and "Fast" or false
				refresh(track, preset)
				refresh(knob, preset)
			end
			hit.MouseButton1Click:Connect(function() owner:Set(not owner.Value) end)
			entry.Render(false)
		end
		frame.Position = Offset(-14, 33 * #self.HotkeyOrder + 1)
		entry.Fader:Show()
	elseif entry and shouldShow then
		setText(entry.Label, caption())
		if entry.Render then entry.Render(true) end
		return
	elseif entry then
		self.HotkeyEntries[object] = nil
		table.remove(self.HotkeyOrder, table.find(self.HotkeyOrder, object))
		animate(entry.Frame, "Position", Offset(-14, entry.Frame.Position.Y.Offset), "Smooth")
		entry.Fader:Hide(function() entry.Frame:Destroy() end)
	else
		return
	end
	for index, key in self.HotkeyOrder do
		animate(self.HotkeyEntries[key].Frame, "Position", Offset(1, 33 * index + 1), "Settle")
	end
end

function Window:_notifyAnchor()
	return Vec2(self.NotifyRight and 1 or 0, self.NotifyBottom and 1 or 0)
end

function Window:_notifyPosition(slot, slide)
	local right, bottom, offset = self.NotifyRight, self.NotifyBottom, slot * 36
	return Dim2(right and 1 or 0, right and slide or -slide, bottom and 1 or 0, bottom and -offset or offset)
end

function Window:SetNotifyPlacement(name, silent)
	if not table.find(NotifyPlacements, name) then name = NotifyPlacements[1] end
	self.NotifyPlacement = name
	self.NotifyRight = string.find(name, "Right", 1, true) ~= nil
	self.NotifyBottom = string.find(name, "Bottom", 1, true) ~= nil
	local count = #self.NotifyStack
	for index, item in self.NotifyStack do
		item.Slot = self.NotifyBottom and index - 1 or count - index
		item.Frame.AnchorPoint = self:_notifyAnchor()
		snap(item.Frame, "Position", self:_notifyPosition(item.Slot, 0))
	end
	if not silent then self:Notify(('Notifications moved to %s.'):format(string.lower(name))) end
end

function Window:Notify(options, typeName)
	if type(options) == "string" then options = { Text = options, Type = typeName } end
	local kind = NotifyTypes[options.Type or "Success"] or NotifyTypes.Success
	local frame = new("Frame", { Bg = "Background", Size = Offset(60, 28), Radius = Metrics.FloatRadius, Border = "Outline", Visible = false }, self.Notifications)
	makeIcon(frame, options.Icon or kind.Icon, 14, kind.Color, "Background", { Position = Offset(8, 7) })
	local text = label(frame, { Text = options.Text, TextSize = 12, X = 28, RowH = 28, W = 340, Truncate = Enum.TextTruncate.AtEnd })
	local entry = { Frame = frame, Fader = newFader(frame), Slot = 0 }
	local function fit() frame.Size = Offset(math.min(math.ceil(text.TextBounds.X), 340) + 38, 28) end
	text:GetPropertyChangedSignal("TextBounds"):Connect(fit)
	fit()
	table.insert(self.NotifyStack, 1, entry)
	local function stack()
		local count = #self.NotifyStack
		for index, item in self.NotifyStack do
			item.Slot = self.NotifyBottom and index - 1 or count - index
			if not item.Placed then
				item.Placed = true
				item.Frame.AnchorPoint = self:_notifyAnchor()
				item.Frame.Position = self:_notifyPosition(item.Slot, 36)
			end
			animate(item.Frame, "Position", self:_notifyPosition(item.Slot, 0), "Settle")
		end
	end
	function entry.Dismiss()
		if entry.Gone then return end
		entry.Gone = true
		table.remove(self.NotifyStack, table.find(self.NotifyStack, entry))
		animate(frame, "Position", self:_notifyPosition(entry.Slot, 36), "Smooth")
		entry.Fader:Hide(function() frame:Destroy() end)
		stack()
	end
	stack()
	entry.Fader:Show()
	if #self.NotifyStack > 6 then self.NotifyStack[#self.NotifyStack].Dismiss() end
	task.delay(options.Duration or kind.Duration, entry.Dismiss)
end

function Window:ApplyTheme(name, silent)
	local theme = Themes[name]
	if not theme then return end
	for key, value in theme do Current[key] = value end
	self.ThemeName = name
	local hidden = {}
	for _, tab in self.Tabs do
		if tab ~= self.CurrentTab then
			for _, inst in tab.Page:GetDescendants() do hidden[inst] = true end
		end
	end
	for inst in Bound do refresh(inst, not hidden[inst] and "Soft" or false) end
	for _, row in self.ThemeRows do row.Color:Set(Current[row.Key], nil, true) end
	if not silent then self:Notify(('Applied "%s" theme.'):format(name)) end
end

function Window:SetThemeColor(key, color)
	Current[key] = color
	self.PendingThemeKeys[key] = true
end

function Window:_flushThemeColors(dt)
	self.ThemeClock += dt
	if next(self.PendingThemeKeys) == nil or self.ThemeClock < 1 / 30 then return end
	self.ThemeClock = 0
	for key in self.PendingThemeKeys do
		local set = ByKey[key]
		if set then
			for inst, prop in set do snap(inst, prop, Current[key]) end
		end
		self.PendingThemeKeys[key] = nil
	end
	for inst in Dynamic do refresh(inst, false) end
end

function Window:SetCasing(name, silent)
	Casing = name
	applyTextSettings()
	if not silent then self:Notify(('Set casing to "%s".'):format(name)) end
end

function Window:SetFont(name)
	FontFamily = Fonts[name] or name
	applyTextSettings()
end

function Window:SetTextWeight(name)
	BodyWeight = Enum.FontWeight[name]
	applyTextSettings()
end

function Window:CloseFloating()
	if self.OpenDropdown then self.OpenDropdown:Toggle(false) end
	self:ClosePopup()
end

function Window:ClosePopup()
	local popup = self.ActivePopup
	if not popup then return end
	self.ActivePopup = nil
	self.LastPopupAnchor, self.LastPopupTime = popup.Anchor, os.clock()
	if popup.OnClose then popup.OnClose() end
	local position = popup.Frame.Position
	animate(popup.Frame, "Position", Offset(position.X.Offset, position.Y.Offset - 4), "Fast")
	popup.Fader:Hide()
end

function Window:_openPopup(popup, anchor, absolute)
	if self.LastPopupAnchor == anchor and os.clock() - self.LastPopupTime < 0.2 then return false end
	self:ClosePopup()
	local point = toLayer(absolute)
	local viewport, size = self.Screen.AbsoluteSize / LayerScale, popup.Frame.Size
	local x = math.clamp(floor(point.X), 8, math.max(8, viewport.X - size.X.Offset - 8))
	local y = math.clamp(floor(point.Y), 8, math.max(8, viewport.Y - size.Y.Offset - 8))
	popup.Anchor = anchor
	popup.Frame.Position = Offset(x, y - 6)
	animate(popup.Frame, "Position", Offset(x, y), "Settle")
	popup.Fader:Show()
	self.ActivePopup = popup
	return true
end

function Window:OpenKeybindMenu(chip, object)
	local menu = self.KeybindMenu
	menu.Target = object
	menu.Paint(false)
	local p, s = chip.AbsolutePosition, chip.AbsoluteSize
	self:_openPopup(menu, chip, Vec2(p.X, p.Y + s.Y + Metrics.Gap))
end

function Window:OpenPicker(swatch, color)
	local picker = self.Picker
	if self.LastPopupAnchor == swatch and os.clock() - self.LastPopupTime < 0.2 then return end
	local p, s = swatch.AbsolutePosition, swatch.AbsoluteSize
	picker.Target = color
	picker.Sync()
	self:_openPopup(picker, swatch, Vec2(p.X - 8, p.Y + s.Y + Metrics.Pad))
end

function Window:_clamped(target, x, y, unit)
	unit = unit or 1
	local screen, size, anchor = self.Screen.AbsoluteSize, target.AbsoluteSize, target.AnchorPoint
	local keep = math.min(60, size.X)
	local px, py = x * unit, y * unit
	local left = math.clamp(px - anchor.X * size.X, keep - size.X, math.max(keep - size.X, screen.X - keep))
	local top = math.clamp(py - anchor.Y * size.Y, 0, math.max(0, screen.Y - 30))
	return Offset(round((left + anchor.X * size.X) / unit), round((top + anchor.Y * size.Y) / unit))
end

function Window:_modalPosition(offsetY)
	return Offset(floor((self.Width - 420) / 2), floor((self.Height - 340) / 2) + offsetY)
end

local function evenClamp(value, minimum, maximum)
	local clamped = math.clamp(floor(value), minimum, math.max(minimum, maximum))
	return clamped - clamped % 2
end

function Window:_minHeight()
	local needed = math.ceil(self.SidebarY + Metrics.TabH / 2 + Metrics.Gap + Metrics.SearchH + Metrics.Pad)
	return evenClamp(math.max(self.MinSize.Y, needed + needed % 2), 0, math.huge)
end

function Window:_applySize(width, height)
	self.Width, self.Height = width, height
	self.ColumnW = floor((width - self.SidebarW - 1 - Metrics.Pad * 3) / 2)
	self.Holder.Size = Offset(width, height)
	for _, tab in self.Tabs do
		for index, column in tab.Columns do
			local x = Metrics.Pad + (index - 1) * (self.ColumnW + Metrics.Pad)
			column.Scroll.Position = Offset(x, 0)
			column.Scroll.Size = Dim2(0, self.ColumnW, 1, 0)
			column.FadeTop.Position, column.FadeTop.Size = Offset(x, 0), Offset(self.ColumnW, 14)
			column.FadeBottom.Position, column.FadeBottom.Size = Dim2(0, x, 1, -14), Offset(self.ColumnW, 14)
			column:ClampScroll()
			if column.Scroll.CanvasPosition.Y > column.Target then
				snap(column.Scroll, "CanvasPosition", Vec2(0, column.Target))
			end
		end
	end
	for _, job in self.ResizeJobs do job() end
	if self.Search and not self.Search.Open then self.Search.Modal.Position = self:_modalPosition(0) end
end

function Window:SetSize(width, height)
	width = evenClamp(width, self.MinSize.X, math.huge)
	height = evenClamp(height, self:_minHeight(), math.huge)
	local position, scale = self.Holder.Position, self.Fit
	snap(self.Holder, "Position", Offset(round(position.X.Offset + (width - self.Width) * scale / 2), round(position.Y.Offset + (height - self.Height) * scale / 2)))
	self.Moved[self.Holder] = true
	self:_applySize(width, height)
	self:_applyFit()
end

function Window:_beginResize(axisX, axisY, onEnd)
	if self.Search.Open then
		if onEnd then onEnd() end
		return
	end
	self:CloseFloating()
	local scale = self.Fit
	local start, startW, startH = mousePos(), self.Width, self.Height
	local minHeight = self:_minHeight()
	local position = self.Holder.Position
	local left, top = position.X.Offset - startW * scale / 2, position.Y.Offset - startH * scale / 2
	beginDrag(function(point)
		local delta, screen = (point - start) / scale, self.Screen.AbsoluteSize
		local width = axisX == 1 and evenClamp(startW + delta.X, self.MinSize.X, (screen.X - left - 4) / scale) or startW
		local height = axisY == 1 and evenClamp(startH + delta.Y, minHeight, (screen.Y - top - 4) / scale) or startH
		if width == self.Width and height == self.Height then return end
		self.Moved[self.Holder] = true
		snap(self.Holder, "Position", Offset(round(left + width * scale / 2), round(top + height * scale / 2)))
		self:_applySize(width, height)
	end, onEnd)
end

function Window:_buildResize()
	local hovering, resizing = 0, false
	local color = function() return (hovering > 0 or resizing) and Current.InactiveText or Current.Outline end
	local grip = makeIcon(self.Root, "grip", TouchOnly and 16 or 12, color, "Tab", { AnchorPoint = Vec2(1, 1), Position = Dim2(1, -2, 1, -2), ZIndex = 15 })
	local edge, corner = TouchOnly and 16 or 6, TouchOnly and 32 or 18
	local function handle(name, position, size, anchor, axisX, axisY)
		local button = new("TextButton", { Name = name, AnchorPoint = anchor, Position = position, Size = size, ZIndex = 16 }, self.Root)
		hoverable(button, function() hovering += 1; grip.Update() end, function() hovering -= 1; grip.Update() end)
		button.InputBegan:Connect(function(input)
			if not isClick(input) then return end
			resizing = true
			grip.Update()
			self:_beginResize(axisX, axisY, function()
				resizing = false
				grip.Update()
			end)
		end)
		table.insert(self.ResizeHandles, button)
	end
	handle("ResizeRight", Dim2(1, 3, 0, 12), Dim2(0, edge, 1, -(corner + 12)), Vec2(1, 0), 1, 0)
	handle("ResizeBottom", Dim2(0, 12, 1, 3), Dim2(1, -(corner + 12), 0, edge), Vec2(0, 1), 0, 1)
	handle("ResizeCorner", Dim2(1, 3, 1, 3), Offset(corner, corner), Vec2(1, 1), 1, 1)
end

function Window:_makeDraggable(handle, target, allowed, layered)
	handle.InputBegan:Connect(function(input)
		if not isClick(input) then return end
		local start, origin = mousePos(), target.Position
		if allowed and not allowed(start) then return end
		beginDrag(function(point)
			local unit = layered and LayerScale or 1
			local delta = point - start
			if delta.Magnitude < 1 and not self.Moved[target] then return end
			self.Moved[target] = true
			animate(target, "Position", self:_clamped(target, origin.X.Offset + delta.X / unit, origin.Y.Offset + delta.Y / unit, unit), "Follow")
		end)
	end)
end

function Window:_overControl(point)
	if self.Search.Open then return true end
    if inside(self.Controls, point) then return true end
	if self.OpenDropdown and inside(self.OpenDropdown.Panel, point) then return true end
	if self.ActivePopup and inside(self.ActivePopup.Frame, point) then return true end
	if inside(self.SearchButton, point) then return true end
	for _, handle in self.ResizeHandles do
		if inside(handle, point) then return true end
	end
    for _, entry in self.SidebarItems do
	if entry.Kind == "Category" then
		if inside(entry.Root, point) then return true end
	elseif not entry.Hidden and inside(entry.Button, point) then
		return true
	end
    end
	if self.CurrentTab then
		for _, column in self.CurrentTab.Columns do
			if inside(column.Scroll, point) then
				for _, section in column.Sections do
					if inside(section.Root, point) then return true end
				end
			end
		end
	end
	return false
end

function Window:_popupFrame(width, height)
	local wrapper = new("Frame", { Size = Offset(width, height), Visible = false, Active = true }, self.Popups)
	local body = new("TextButton", { Bg = "Background", Size = Dim2(1, 0, 1, 0), Radius = Metrics.PopupRadius, Border = "Outline" }, wrapper)
	addShadow(body, "Large")
	local controls = {}
	self:_makeDraggable(body, wrapper, function(point)
		for _, control in controls do
			if inside(control, point, 6) then return false end
		end
		return true
	end, true)
	return wrapper, body, controls
end

function Window:_buildKeybindMenu()
	local pad, gap, rowH = Metrics.Pad, Metrics.Gap, Metrics.InputH
	local width = 202
	local inner = width - pad * 2
	local half = (inner - gap) / 2
	local height = TouchOnly and (pad * 2 + rowH) or (pad * 2 + rowH * 2 + gap)
	local frame, body, controls = self:_popupFrame(width, height)
	local menu = { Frame = frame, Fader = newFader(frame), Target = nil }

	if TouchOnly then
		local row = new("TextButton", {
			Position = Offset(pad + 1, pad + 1), Size = Offset(inner - 2, rowH - 2), Radius = Metrics.Radius,
			Border = "Outline", BackgroundTransparency = 0,
		}, body)
		interactive(row, "Element")
		addGradient(row)
		label(row, { Text = "Hotkey", X = 8, RowH = rowH - 2, Right = 44 })
		local function isOn() return menu.Target ~= nil and menu.Target.Enabled ~= false end
		local track = new("Frame", {
			Bg = function() return isOn() and Current.Accent or Current.Element end,
			Position = Offset(inner - 2 - 8 - (Metrics.ToggleW - 2), floor((rowH - 2 - (Metrics.ToggleH - 2)) / 2)),
			Size = Offset(Metrics.ToggleW - 2, Metrics.ToggleH - 2), Radius = FULL, Border = "Outline",
		}, row)
		addGradient(track)
		local knob = new("Frame", {
			Bg = function() return isOn() and Current.Text or Current.InactiveText end,
			Size = Offset(Metrics.ToggleKnob, Metrics.ToggleKnob), Radius = FULL,
		}, track)
		table.insert(controls, row)

		function menu.Paint(animated)
			if not menu.Target then return end
			place(knob, "Position", Offset(isOn() and Metrics.ToggleW - 2 - Metrics.ToggleKnob - 2 or 2, 2), animated, "Knob")
			local preset = animated and "Fast" or false
			refresh(track, preset)
			refresh(knob, preset)
		end
		row.MouseButton1Click:Connect(function()
			if not menu.Target then return end
			menu.Target:SetEnabled(not (menu.Target.Enabled ~= false))
			menu.Paint(true)
		end)
		self.KeybindMenu = menu
		return
	end

	local pill = new("Frame", { Bg = "Accent", Size = Offset(half - 2, rowH - 2), Position = Offset(pad + half + gap + 1, pad + 1), Radius = Metrics.Radius, Border = "Outline" }, body)
	addGradient(pill)
	local onToggle = new("TextButton", { Position = Offset(pad, pad), Size = Offset(half, rowH), ZIndex = 2 }, body)
	centeredLabel(onToggle, half, { Text = "On Toggle", RowH = rowH })
	local onHold = new("TextButton", { Position = Offset(pad + half + gap, pad), Size = Offset(half, rowH), ZIndex = 2 }, body)
	centeredLabel(onHold, half, { Text = "On Hold", RowH = rowH })
	local reset = new("TextButton", { Position = Offset(pad + 1, pad + rowH + gap + 1), Size = Offset(inner - 2, rowH - 2), Radius = Metrics.Radius, Border = "Outline", BackgroundTransparency = 0 }, body)
	interactive(reset, "Element")
	addGradient(reset)
	table.insert(controls, onToggle)
	table.insert(controls, onHold)
	table.insert(controls, reset)
	local center = floor(inner / 2)
	makeIcon(reset, "reset", 14, "Text", "Element", { Position = Offset(center - 32, 5) })
	label(reset, { Text = "Reset", X = center - 12, RowH = rowH - 2, W = 50 })

	function menu.Paint(animated)
		local target = menu.Target
		if not target then return end
		local x = target.Mode == "Hold" and pad + half + gap or pad
		place(pill, "Position", Offset(x + 1, pad + 1), animated, "Knob")
	end
	onToggle.MouseButton1Click:Connect(function()
		if menu.Target then menu.Target.Mode = "Toggle"; menu.Paint(true) end
	end)
	onHold.MouseButton1Click:Connect(function()
		if menu.Target then menu.Target.Mode = "Hold"; menu.Paint(true) end
	end)
	reset.MouseButton1Click:Connect(function()
		if menu.Target then menu.Target:Set(nil) end
		self:ClosePopup()
	end)
	self.KeybindMenu = menu
end

function Window:_buildPicker()
	local pad, gap = Metrics.Pad, Metrics.Gap
	local width = 216
	local svW, svH, barW = width - pad * 3 - 12, 168, 12
	local alphaY = pad + svH + pad
	local labelY = alphaY + barW + pad
	local inputY = labelY + Metrics.Row + gap
	local frame, body, controls = self:_popupFrame(width, inputY + Metrics.InputH + pad)
	local picker = { Frame = frame, Fader = newFader(frame), Target = nil, H = 0, S = 0, V = 1, Alpha = 0, Dragging = false }

	local sv = new("Frame", { BackgroundTransparency = 0, Position = Offset(pad + 1, pad + 1), Size = Offset(svW - 2, svH - 2), Radius = Metrics.Radius, Border = "Outline" }, body)
	local white = new("Frame", { BackgroundTransparency = 0, BackgroundColor3 = Color3.new(1, 1, 1), Size = Dim2(1, 0, 1, 0), Radius = Metrics.Radius }, sv)
	new("UIGradient", { Transparency = NumberSequence.new(0, 1) }, white)
	local black = new("Frame", { BackgroundTransparency = 0, BackgroundColor3 = Color3.new(0, 0, 0), Size = Dim2(1, 0, 1, 0), Radius = Metrics.Radius }, sv)
	new("UIGradient", { Rotation = 90, Transparency = NumberSequence.new(1, 0) }, black)

	local function ringKnob(parent)
		local size = Metrics.PickerKnob
		local knob = new("Frame", { Name = "Knob", BackgroundTransparency = 0, AnchorPoint = Vec2(0.5, 0.5), Size = Offset(size, size), Radius = FULL, ZIndex = 3 }, parent)
		local ring = new("UIStroke", { Thickness = 2 }, knob)
		bind(ring, "Color", "Text")
		addShadow(knob, "PickerKnob")
		return knob
	end
	local svKnob = ringKnob(sv)
	picker.SVKnob = svKnob
	local INSET = (Metrics.PickerKnob + 4) / 2 - 1
	local function along(scale) return round(INSET - INSET * 2 * scale) end
	local function fromPointer(position, origin, length)
		local inset = INSET * LayerScale
		return clamp01((position - origin - inset) / (length - inset * 2))
	end

	local hue = new("Frame", { BackgroundTransparency = 0, BackgroundColor3 = Color3.new(1, 1, 1), Position = Offset(pad * 2 + svW + 1, pad + 1), Size = Offset(barW - 2, svH - 2), Radius = Metrics.Radius, Border = "Outline" }, body)
	local keys = {}
	for index = 0, 6 do
		table.insert(keys, ColorSequenceKeypoint.new(index / 6, Color3.fromHSV((index / 6) % 1, 1, 1)))
	end
	new("UIGradient", { Rotation = 90, Color = ColorSequence.new(keys) }, hue)
	local hueKnob = ringKnob(hue)

	local alphaBar = new("Frame", { Bg = "Background", Position = Offset(pad + 1, alphaY + 1), Size = Offset(width - pad * 2 - 2, barW - 2), Radius = Metrics.Radius, Border = "Outline" }, body)
	local alphaClip = new("CanvasGroup", { Name = "AlphaClip", BackgroundTransparency = 0, BackgroundColor3 = Color3.new(1, 1, 1), Size = Dim2(1, 0, 1, 0), Radius = Metrics.Radius }, alphaBar)
	for column = 0, 48 do
		for row = 0, 2 do
			if (column + row) % 2 == 1 then
				new("Frame", { BackgroundTransparency = 0, BackgroundColor3 = RGB(190, 190, 190), Position = Offset(column * 4, row * 4), Size = Offset(4, 4) }, alphaClip)
			end
		end
	end
	local alphaFill = new("Frame", { BackgroundTransparency = 0, Size = Dim2(1, 0, 1, 0) }, alphaClip)
	new("UIGradient", { Transparency = NumberSequence.new(0, 1) }, alphaFill)
	local alphaKnob = ringKnob(alphaBar)

	label(body, { Text = "Animations", X = pad, Y = labelY })
	local holder = new("Frame", { Position = Offset(pad, inputY), Size = Offset(width - pad * 2, Metrics.InputH) }, body)
	for _, control in { sv, hue, alphaBar, holder } do table.insert(controls, control) end

	local function paint()
		local color = Color3.fromHSV(picker.H, picker.S, picker.V)
		local pure = Color3.fromHSV(picker.H, 1, 1)
		sv.BackgroundColor3 = pure
		svKnob.BackgroundColor3 = color
		svKnob.Position = Dim2(picker.S, along(picker.S), 1 - picker.V, along(1 - picker.V))
		hueKnob.Position = Dim2(0.5, 0, picker.H, along(picker.H))
		hueKnob.BackgroundColor3 = pure
		alphaFill.BackgroundColor3 = color
		alphaKnob.Position = Dim2(picker.Alpha, along(picker.Alpha), 0.5, 0)
		alphaKnob.BackgroundColor3 = color
	end

	local function commit()
		paint()
		if picker.Target then picker.Target:Set(Color3.fromHSV(picker.H, picker.S, picker.V), picker.Alpha) end
	end

	function picker.Sync()
		local target = picker.Target
		if not target then return end
		local h, s, v = target.Value:ToHSV()
		if s > 0 and v > 0 then picker.H = h end
		picker.S, picker.V, picker.Alpha = s, v, target.Alpha or 0
		paint()
		if picker.Animation then picker.Animation:Set(target.Animation or "None", true) end
	end

	local function dragArea(area, knob, update)
		local hit = new("TextButton", { Position = Offset(-6, -6), Size = Dim2(1, 12, 1, 12), ZIndex = 5 }, area)
		hit.InputBegan:Connect(function(input)
			if not isClick(input) then return end
			picker.Dragging = true
			update(mousePos())
			beginDrag(update, function() picker.Dragging = false end)
		end)
	end
	dragArea(sv, svKnob, function(point)
		picker.S = fromPointer(point.X, sv.AbsolutePosition.X, sv.AbsoluteSize.X)
		picker.V = 1 - fromPointer(point.Y, sv.AbsolutePosition.Y, sv.AbsoluteSize.Y)
		commit()
	end)
	dragArea(hue, hueKnob, function(point)
		picker.H = math.min(fromPointer(point.Y, hue.AbsolutePosition.Y, hue.AbsoluteSize.Y), 0.9999)
		commit()
	end)
	dragArea(alphaBar, alphaKnob, function(point)
		picker.Alpha = fromPointer(point.X, alphaBar.AbsolutePosition.X, alphaBar.AbsoluteSize.X)
		commit()
	end)

	self.Picker = picker
	picker.Animation = buildDropdown(self, holder, {
		Options = { "None", "Rainbow", "Pulse" }, Default = "None", MaxRows = 3,
		Callback = function(value)
			if picker.Target then picker.Target.Animation = value end
		end,
	})
	picker.OnClose = function() picker.Animation:Toggle(false) end
end

function Window:_buildSearch()
	local width, height, pad = 420, 340, Metrics.Pad
	local overlay = new("TextButton", {
		BackgroundTransparency = 0.45, BackgroundColor3 = Color3.new(0, 0, 0), Size = Dim2(1, 0, 1, 0), Visible = false,
		ZIndex = 20, Radius = Metrics.WindowRadius,
	}, self.Root)
	local modal = new("TextButton", {
		Bg = "Background", Position = self:_modalPosition(0), Size = Offset(width, height), Radius = Metrics.WindowRadius, Border = "Outline",
	}, overlay)
	label(modal, { Text = self.Title, TextSize = 14, Weight = Enum.FontWeight.SemiBold, X = pad * 2, Y = pad + 2, RowH = 20 })
	local field = new("Frame", { Bg = "Inline", Position = Offset(pad * 2 + 1, 43), Size = Offset(width - pad * 4 - 2, 34), Radius = Metrics.PillRadius, Border = "Outline" }, modal)
	makeIcon(field, "search", 14, "InactiveText", "Inline", { Position = Offset(10, 10) })
	local box = new("TextBox", {
		Fg = "Text", PlaceholderText = "Search...", Text = "", Position = Offset(34, capOffset(34, 13)), Size = Dim2(1, -45, 0, 20), ClearTextOnFocus = false,
	}, field)
	bind(box, "PlaceholderColor3", "InactiveText")
	local results = new("ScrollingFrame", {
		Position = Offset(pad * 2, 88), Size = Offset(width - pad * 4 + 6, height - 88 - pad), CanvasSize = Offset(0, 0),
	}, modal)

	local noResults = centeredLabel(modal, width, { Fg = "InactiveText", Text = "No results", Y = 170 })
	noResults.Visible = false
	local search = { Overlay = overlay, Modal = modal, Fader = newFader(overlay), Open = false, Rows = {}, Dirty = false, Box = box, Order = {} }

    local function goTo(entry)
	    self:CloseSearch()
	    local section = entry.Section or entry
	    local category = section.Tab.Category
	    if category and category.Collapsed then category:SetCollapsed(false, false) end
        if section.Collapsed then section:SetCollapsed(false, false) end
		self:SelectTab(section.Tab)
		section.Column:ScrollTo(section.Y + (entry.Section and section.HeaderH + entry.Y or 0) - 40)
		if entry.Frame then
			local flash = new("Frame", {
				Bg = "Accent", BackgroundTransparency = 0.7, Position = Offset(-6, -3), Size = Dim2(1, 12, 1, 6), Radius = Metrics.Radius, ZIndex = 0,
			}, entry.Frame)
			task.delay(0.2, function()
				animate(flash, "BackgroundTransparency", 1, "Soft", { Done = function() flash:Destroy() end })
			end)
		end
	end

	local function retire(row)
		row.Retired = true
		row.Frame:Destroy()
	end

	local function makeRow(entry, name, sub, y)
		local frame = new("TextButton", {
			Bg = "HoveredElement", BackgroundTransparency = 1, Position = Offset(10, y), Size = Offset(width - pad * 4, 44), Radius = Metrics.Radius,
		}, results)
		NoFade[frame] = true
		local row = { Frame = frame, Y = y, Retired = false }
		row.Bar = new("Frame", { Bg = "Accent", BackgroundTransparency = 1, Position = Offset(4, 8), Size = Offset(3, 28), Radius = Metrics.SmallRadius }, frame)
		row.Name = label(frame, { Text = name, TextSize = 13, X = 14, Y = 5, RowH = 18, TextTransparency = 1, Right = 10, Truncate = Enum.TextTruncate.AtEnd })
		row.Sub = label(frame, { Fg = "InactiveText", Text = sub, TextSize = 11, X = 14, Y = 22, RowH = 16, TextTransparency = 1, Right = 10, Truncate = Enum.TextTruncate.AtEnd })
		hoverable(frame, function() animate(frame, "BackgroundTransparency", 0.4, "Fast") end, function() animate(frame, "BackgroundTransparency", 1, "Fast") end)
		frame.MouseButton1Click:Connect(function() goTo(entry) end)
		return row
	end

	local function sync()
		local text = box.Text
		setText(self.SearchLabel, text ~= "" and text or "Search...")
		local wanted, order = {}, {}
		if text ~= "" then
			local needle = string.lower(text)
			local function add(entry, name, sub)
				if #order < 30 and name and string.find(string.lower(name), needle, 1, true) then
					wanted[entry] = true
					table.insert(order, { entry, name, sub })
				end
			end
			for _, section in self.Sections do
				add(section, section.Name, section.Tab.Name .. " / " .. section.Name .. "  \u{00B7}  Section")
			end
			for _, item in self.Index do
				add(item, item.Name, item.Section.Tab.Name .. " / " .. item.Section.Name .. "  \u{00B7}  " .. item.Kind)
			end
		end
		for entry, row in search.Rows do
			if not wanted[entry] then
				search.Rows[entry] = nil
				retire(row)
			end
		end
		local fresh = 0
		for index, data in order do
			local entry, y = data[1], (index - 1) * 48
			local row = search.Rows[entry]
			if row then
				row.Y = y
				animate(row.Frame, "Position", Offset(0, y), "Smooth")
			else
				row = makeRow(entry, data[2], data[3], y)
				search.Rows[entry] = row
				fresh += 1
				task.delay(math.min(fresh, 8) * 0.025, function()
					if row.Retired then return end
					animate(row.Frame, "Position", Offset(0, row.Y), "Smooth")
					animate(row.Bar, "BackgroundTransparency", 0, "Smooth")
					animate(row.Name, "TextTransparency", 0, "Smooth")
					animate(row.Sub, "TextTransparency", 0, "Smooth")
				end)
			end
		end
		results.CanvasSize = Offset(0, #order * 48)
		search.Order = order
		noResults.Visible = text ~= "" and #order == 0
	end

	box:GetPropertyChangedSignal("Text"):Connect(function() search.Dirty = true end)
	box.FocusLost:Connect(function(enterPressed)
		if UserInputService:IsKeyDown(Enum.KeyCode.Escape) then
			self:CloseSearch()
		elseif enterPressed then
			if search.Dirty then
				search.Dirty = false
				sync()
			end
			if search.Order[1] then goTo(search.Order[1][1]) end
		end
	end)
	overlay.MouseButton1Click:Connect(function() self:CloseSearch() end)
	search.Sync = sync
	self.Search = search
end

function Window:OpenSearch()
	local search = self.Search
	if search.Open then return end
	search.Open = true
	self:CloseFloating()
	search.Modal.Position = self:_modalPosition(10)
	animate(search.Modal, "Position", self:_modalPosition(0), "Smooth")
	search.Fader:Show()
	search.Box:CaptureFocus()
end

function Window:CloseSearch()
	local search = self.Search
	if not search.Open then return end
	search.Open = false
	search.Box:ReleaseFocus()
	animate(search.Modal, "Position", self:_modalPosition(7), "Fast")
	search.Fader:Hide()
end

function Window:_layoutHeader()
	local width, logo, title = self.SidebarW, self.Logo, self.SidebarTitle
	local expanded = width >= Metrics.SidebarMin
	title.Visible = expanded
	if not expanded then
		logo.Root.Position = Offset(floor((width - 20) / 2), 15)
		return
	end
	local room = width - Metrics.Pad * 2 - 28
	local key = width .. "|" .. title.Text .. "|" .. FontFamily
	if key ~= self.HeaderKey then
		local size = 16
		title.TextSize = size
		while title.TextBounds.X > room and size > 10 do
			size -= 1
			title.TextSize = size
		end
		if title.TextBounds.X > 0 then self.HeaderKey = key end
	end
	local bounds = math.ceil(title.TextBounds.X)
	local left = floor((width - 28 - bounds) / 2)
	logo.Root.Position = Offset(left, 15)
	title.Position = Offset(left + 28, 11 + capOffset(28, title.TextSize))
	title.Size = Offset(bounds + 1, 28)
end

function Window:_applySidebar(width)
	self.SidebarW = width
	local tabW = width - Metrics.Pad * 2
	local compact = width < Metrics.SidebarMin
	self.Sidebar.Size = Dim2(0, width, 1, 0)
	self.Divider.Position = Offset(width, 0)
	self.Content.Position = Offset(width + 1, 0)
	self.Content.Size = Dim2(1, -(width + 1), 1, 0)
	self.CollapseButton.Position = Offset(width - 9, 4)
	self.Indicator.Size = Offset(tabW - 2, Metrics.TabH - 2)
	self.SearchButton.Size = Offset(tabW - 2, Metrics.SearchH - 2)
	self.SearchLabel.Visible = not compact
	for _, entry in self.SidebarItems do
		if entry.Kind == "Category" then
			entry.Root.Size = Offset(width, 16)
			entry.Arrow.Root.Position = Offset(width - Metrics.Pad - 8, 8)
			entry.Rule.Position = Offset(floor((width - 20) / 2), 7)
			entry.Text.Visible = not compact
			entry.Arrow.Root.Visible = not compact
			entry.Rule.Visible = compact
		else
			entry.Button.Size = Offset(tabW, Metrics.TabH)
			entry.Label.Visible = not compact
		end
	end
	self:_layoutHeader()
	self:_applySize(self.Width, self.Height)
end

function Window:SetSidebarCollapsed(collapsed, animated)
	if self.SidebarCollapsed == collapsed then return end
	self.SidebarCollapsed = collapsed
	self:CloseFloating()
	place(self.CollapseIcon.Root, "Rotation", collapsed and -90 or 90, animated, "Smooth")
	self:_layoutSidebar(animated)
	local goal = collapsed and Metrics.SidebarShut or Metrics.SidebarW
	if animated then
		animate(self, "SidebarAnim", goal, "Smooth", {
			Step = function(value)
				local width = round(value)
				if width ~= self.SidebarW then self:_applySidebar(width) end
			end,
		})
	else
		snap(self, "SidebarAnim", goal)
		self:_applySidebar(goal)
	end
end

function Window:_buildSidebarControls()
	local root = self.Root
	self.Divider = new("Frame", { Bg = "Outline", Position = Offset(self.SidebarW, 0), Size = Dim2(0, 1, 1, 0) }, root)
	local button = new("TextButton", {
		Name = "SidebarToggle", Position = Offset(self.SidebarW - 9, 4), Size = Offset(18, 18), Radius = FULL,
		Border = "Outline", BackgroundTransparency = 0, ZIndex = 7,
	}, root)
	interactive(button, "Background", "Inline", "Element")
	self.CollapseButton = button
	self.CollapseIcon = makeIcon(button, "chevron", 12, "InactiveText", "Background", { AnchorPoint = Vec2(0.5, 0.5), Position = Offset(9, 9) })
	self.CollapseIcon.Root.Rotation = 90
	button.MouseButton1Click:Connect(function()
		if self.Search.Open then return end
		self:SetSidebarCollapsed(not self.SidebarCollapsed, true)
	end)
	table.insert(self.ResizeHandles, button)
end

function Window:SetVisible(visible)
	if self.Visible == visible then return end
	self.Visible = visible
	self:CloseFloating()
	self.ModalButton.Visible = visible
	if visible and self.Minimized then
		self.Minimized = false
		self.FloatFader:Hide()
	end
	local fit = self.Fit
	if not self.Scale.Parent then
		self.Scale.Scale = visible and fit * 0.97 or fit
		self.Scale.Parent = self.Holder
	end
	if visible then
		animate(self.Scale, "Scale", fit, "Smooth", {
			Done = function()
				if self.Visible and self.Fit == 1 then self.Scale.Parent = nil end
			end,
		})
		self.Fader:Show()
	else
		animate(self.Scale, "Scale", fit * 0.97, "Fast")
		self.Fader:Hide()
	end
end

function Window:Toggle()
	if self.Load and not self.Load.Done then return end
	self:SetVisible(not self.Visible)
end

function Window:_buildFloatButton()
	local button = new("TextButton", {
		Name = "Restore", Size = Offset(40, 40), Radius = FULL, Border = "Outline", BackgroundTransparency = 0,
		Visible = false, Active = true,
	}, self.Screen)
	interactive(button, "Background", "Inline", "Element")
	addShadow(button, "Large")
	makeIcon(button, "logo", 20, "Accent", "Background", { Position = Offset(10, 10) })
	button.InputBegan:Connect(function(input)
		if not isClick(input) then return end
		local start, origin, moved = mousePos(), button.Position, false
		beginDrag(function(point)
			local delta = point - start
			if not moved and delta.Magnitude < 5 then return end
			moved = true
			self.Moved[button] = true
			animate(button, "Position", self:_clamped(button, origin.X.Offset + delta.X, origin.Y.Offset + delta.Y), "Follow")
		end, function()
			if not moved then self:Restore() end
		end)
	end)
	self.FloatButton = button
	self.FloatFader = newFader(button)
end

function Window:Minimize()
	if not self.Visible then return end
	self:SetVisible(false)
	self.Minimized = true
	self.FloatFader:Show()
end

function Window:Restore()
	self:SetVisible(true)
end

function Window:Close()
	if self.Closing then return end
	self.Closing = true
	self:CloseFloating()
	self.ModalButton.Visible = false
	for _, frame in { self.Watermark, self.Hotkeys, self.FloatButton } do
		if frame.Visible then newFader(frame):Hide() end
	end
	self.Fader:Hide(function() self:Destroy() end)
end

local ConfigMemory = {}
local DEFAULT_FOLDER = "Blossom"

local function cleanFolder(path)
	path = string.gsub(tostring(path or DEFAULT_FOLDER), "\\", "/")
	path = string.gsub(path, "[^%w%s_%-%./]", "_")
	path = string.gsub(path, "^/+", "")
	path = string.gsub(path, "/+$", "")
	if path == "" then return DEFAULT_FOLDER end
	return path
end

local function ensureFolder(path)
	if typeof(isfolder) ~= "function" or typeof(makefolder) ~= "function" then return end
	local built
	for part in string.gmatch(path, "[^/]+") do
		built = built and (built .. "/" .. part) or part
		if not isfolder(built) then makefolder(built) end
	end
end

local function configPath(folder, name) return folder .. "/" .. name .. ".json" end

local function memoryFor(folder)
	local store = ConfigMemory[folder]
	if not store then
		store = { Configs = {} }
		ConfigMemory[folder] = store
	end
	return store
end

function Window:_serialize()
	local data = {}
	for flag, object in self.Flags do
		local value = object.Value
		if object.Swatch then
			value = { Color = object.Value:ToHex(), Alpha = object.Alpha }
		elseif object.Chip then
			value = { Key = object.Key and object.Key.Name or false, Mode = object.Mode, Enabled = object.Enabled ~= false }
		elseif object.Multi then
			local list = {}
			for option, enabled in object.Value do
				if enabled then table.insert(list, option) end
			end
			value = list
		end
		if value ~= nil then data[flag] = value end
	end
	return HttpService:JSONEncode(data)
end

function Window:_deserialize(json)
	local data = HttpService:JSONDecode(json)
	local order = {}
	for flag in data do
		if self.Flags[flag] then table.insert(order, flag) end
	end
	table.sort(order, function(a, b)
		local early = self.Flags[a].Early == true
		if early ~= (self.Flags[b].Early == true) then return early end
		return a < b
	end)
	self.Restoring = true
	for _, flag in order do
		local object, value = self.Flags[flag], data[flag]
		if object.Swatch then
			object:Set(Color3.fromHex(value.Color), value.Alpha)
		elseif object.Chip then
			object.Mode = value.Mode or object.Mode
			local key = nil
			if value.Key then
				key = string.find(value.Key, "MouseButton", 1, true) and Enum.UserInputType[value.Key] or Enum.KeyCode[value.Key]
			end
			object:Set(key)
			if object.SetEnabled then object:SetEnabled(value.Enabled ~= false) end
		else
			object:Set(value)
		end
	end
	self.Restoring = false
end

function Window:ListConfigs()
	local names = {}
	local folder = self.ConfigFolder
	if typeof(listfiles) == "function" and typeof(isfolder) == "function" and isfolder(folder) then
		for _, path in listfiles(folder) do
			local name = string.match(path, "([^/\\]+)%.json$")
			if name then table.insert(names, name) end
		end
	else
		for name in memoryFor(folder).Configs do table.insert(names, name) end
	end
	table.sort(names)
	return names
end

function Window:SaveConfig(name)
	local json = self:_serialize()
	local folder = self.ConfigFolder
	if typeof(writefile) == "function" then
		ensureFolder(folder)
		writefile(configPath(folder, name), json)
	else
		memoryFor(folder).Configs[name] = json
	end
end

function Window:LoadConfig(name)
	local folder = self.ConfigFolder
	local json
	if typeof(readfile) == "function" and typeof(isfile) == "function" and isfile(configPath(folder, name)) then
		json = readfile(configPath(folder, name))
	else
		json = memoryFor(folder).Configs[name]
	end
	if json then self:_deserialize(json); return true end
	return false
end

function Window:DeleteConfig(name)
	local folder = self.ConfigFolder
	if typeof(delfile) == "function" and typeof(isfile) == "function" and isfile(configPath(folder, name)) then
		delfile(configPath(folder, name))
	end
	memoryFor(folder).Configs[name] = nil
end

local B64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local CODE_PREFIX = "MYSTRIX:"
local DISCORD_INVITE = "https://discord.gg/46JkThWjPB"

local function b64encode(data)
	local out = {}
	for i = 1, #data, 3 do
		local a, b, c = string.byte(data, i, i + 2)
		local n = a * 65536 + (b or 0) * 256 + (c or 0)
		local i1, i2, i3, i4 = floor(n / 262144) % 64, floor(n / 4096) % 64, floor(n / 64) % 64, n % 64
		table.insert(out, string.sub(B64, i1 + 1, i1 + 1) .. string.sub(B64, i2 + 1, i2 + 1)
			.. (b and string.sub(B64, i3 + 1, i3 + 1) or "=") .. (c and string.sub(B64, i4 + 1, i4 + 1) or "="))
	end
	return table.concat(out)
end

local function b64decode(text)
	text = (string.gsub(text, "[^%w%+/]", ""))
	local out = {}
	for i = 1, #text, 4 do
		local chunk = string.sub(text, i, i + 3)
		local count, n = #chunk, 0
		for j = 1, 4 do
			local ch = string.sub(chunk, j, j)
			local index = ch ~= "" and string.find(B64, ch, 1, true) or nil
			n = n * 64 + (index and index - 1 or 0)
		end
		local bytes = string.char(floor(n / 65536) % 256, floor(n / 256) % 256, n % 256)
		if count == 4 then
			table.insert(out, bytes)
		elseif count == 3 then
			table.insert(out, string.sub(bytes, 1, 2))
		elseif count == 2 then
			table.insert(out, string.sub(bytes, 1, 1))
		end
	end
	return table.concat(out)
end

local function copyToClipboard(text)
	local copy = (typeof(setclipboard) == "function" and setclipboard) or (typeof(toclipboard) == "function" and toclipboard)
		or (typeof(syn) == "table" and syn.write_clipboard)
	if not copy then return false end
	return pcall(copy, text)
end

local function readConfig(folder, name)
	if typeof(readfile) == "function" and typeof(isfile) == "function" and isfile(configPath(folder, name)) then
		return readfile(configPath(folder, name))
	end
	return memoryFor(folder).Configs[name]
end

function Window:ExportConfig(name)
	local json
	if name then
		json = readConfig(self.ConfigFolder, name)
		if not json then return nil end
	else
		json = self:_serialize()
	end
	return CODE_PREFIX .. b64encode(json)
end

function Window:ImportConfig(code)
	code = string.gsub(tostring(code), "^%s+", "")
	code = string.gsub(code, "%s+$", "")
	if string.sub(code, 1, #CODE_PREFIX) ~= CODE_PREFIX then return false end
	local json = b64decode(string.sub(code, #CODE_PREFIX + 1))
	local ok = pcall(function()
		self:_deserialize(json)
	end)
	self.Restoring = false
	return ok
end

local AUTOLOAD_PATH = "Mystrix/autoload.txt"
local AutoloadMemory

local function readAutoload(folder)
	local path = folder .. "/autoload.txt"
	if typeof(readfile) == "function" and typeof(isfile) == "function" then
		return isfile(path) and readfile(path) or nil
	end
	return memoryFor(folder).Autoload
end

local function writeAutoload(folder, name)
	local path = folder .. "/autoload.txt"
	if typeof(writefile) ~= "function" then
		memoryFor(folder).Autoload = name
	elseif name then
		ensureFolder(folder)
		writefile(path, name)
	elseif typeof(delfile) == "function" and typeof(isfile) == "function" and isfile(path) then
		delfile(path)
	end
end

function Window:BuildSettings(tab)
	local selected
	local saved = readAutoload(self.ConfigFolder)
	local autoloadOn, autoloadName = saved ~= nil, saved
	local autoloadList
    local profiles = tab:Section({ Name = "Profiles", Icon = "folder", Side = 1 })
	profiles:Label({ Name = "Configs" })
	local listbox = profiles:Listbox({ Height = 177, Empty = "No configs yet", Options = self:ListConfigs(), Callback = function(value) selected = value end })
	local nameBox = profiles:Textbox({ Placeholder = "Config name", NoSave = true })
	local function refreshList()
		local names = self:ListConfigs()
		listbox:SetOptions(names)
		autoloadList:SetOptions(names)
	end
	profiles:Button({ Name = "Create", Callback = function()
		local name = nameBox.Instance.Text
		if name == "" then self:Notify("Enter a config name first.", "Warning"); return end
		self:SaveConfig(name)
		refreshList()
		self:Notify(('Created "%s".'):format(name))
	end })
	profiles:Button({ Name = "Load", Callback = function()
		if selected and self:LoadConfig(selected) then self:Notify(('Loaded "%s".'):format(selected)) end
	end })
	profiles:Button({ Name = "Delete", Callback = function()
		if selected then
			self:DeleteConfig(selected)
			self:Notify(('Deleted "%s".'):format(selected))
			selected = nil
			refreshList()
		end
	end })
	profiles:Button({ Name = "Overwrite", Callback = function()
		if selected then
			self:SaveConfig(selected)
			self:Notify(('Overwrote "%s".'):format(selected))
		end
	end })
	local importBox
	profiles:Button({ Name = "Export", Callback = function()
		local code = self:ExportConfig(selected)
		if not code then
			self:Notify("Could not export that config.", "Error")
			return
		end
		if copyToClipboard(code) then
			self:Notify(selected and ('Copied "%s" code to clipboard.'):format(selected) or "Copied current settings code to clipboard.")
		else
			importBox:Set(code, true)
			self:Notify("Clipboard unavailable, code placed in the box below.", "Warning")
		end
	end })
	importBox = profiles:Textbox({ Placeholder = "Paste config code", NoSave = true, Callback = function(text)
		if text == "" then return end
		if self:ImportConfig(text) then
			self:Notify("Imported config.")
		else
			self:Notify("Invalid config code.", "Error")
		end
		importBox:Set("", true)
	end })

	local function storeAutoload() writeAutoload(self.ConfigFolder, autoloadOn and autoloadName or nil) end
    local autoload = tab:Section({ Name = "Autoload", Icon = "zap", Side = 1 })
	autoload:Toggle({ Name = "Load on start", Default = autoloadOn, NoSave = true, Callback = function(value)
		autoloadOn = value
		storeAutoload()
	end })
	autoloadList = autoload:Dropdown({ Name = "Config", Options = self:ListConfigs(), Default = saved, Empty = "No configs yet", NoSave = true, Callback = function(value)
		autoloadName = value
		storeAutoload()
	end })

		local theming = tab:Section({ Name = "Theming", Icon = "palette", Side = 2 })
	theming:Dropdown({ Name = "Theme", Options = ThemeOrder, Default = self.ThemeName, MaxRows = 11, Early = true, Callback = function(value) self:ApplyTheme(value, self.Restoring) end })
	theming:Dropdown({ Name = "Casing", Options = Casings, Default = Casing, Callback = function(value) self:SetCasing(value, self.Restoring) end })
	theming:Divider()
	for _, pair in ThemeKeys do
		local key = pair[2]
		local color = theming:Colorpicker({ Name = pair[1], Default = Current[key], Callback = function(value) self:SetThemeColor(key, value) end })
		table.insert(self.ThemeRows, { Key = key, Color = color })
	end

	local menu = tab:Section({ Name = "Menu", Icon = "sliders-horizontal", Side = 2 })
	local menuBind = menu:Keybind({ Name = "Menu Key", Default = self.MenuKey })
	menuBind.OnKeyChanged = function() self.MenuKey = menuBind.Key end
	menu:Toggle({ Name = "Watermark", Default = true, Callback = function(value)
		self.ShowWatermark = value
		if self.Revealed then self.Watermark.Visible = value end
	end })
	menu:Toggle({ Name = "Hotkey List", Default = true, Callback = function(value)
		self.ShowHotkeys = value
		if self.Revealed then self.Hotkeys.Visible = value end
	end })
	menu:Dropdown({ Name = "Font", Options = FontOrder, Default = "Inter", Callback = function(value) self:SetFont(value) end })
	menu:Dropdown({ Name = "Text Weight", Options = WeightOrder, Default = BodyWeight.Name, Callback = function(value) self:SetTextWeight(value) end })
	menu:Dropdown({ Name = "Notifications", Options = NotifyPlacements, Default = self.NotifyPlacement, Callback = function(value) self:SetNotifyPlacement(value, self.Restoring) end })

	if saved then
		task.defer(function()
			if self:LoadConfig(saved) then self:Notify(('Autoloaded "%s".'):format(saved)) end
		end)
	end
end

function Window:_buildWatermark(options)
	local player = Players.LocalPlayer
	local frame = new("Frame", { Bg = "Background", Size = Offset(298, 28), Radius = Metrics.FloatRadius, Border = "Outline", Active = true }, self.Screen)
	makeIcon(frame, "logo", 16, "Accent", "Background", { Position = Offset(8, 6) })
	local function text(value, size, weight)
		return label(frame, { Text = value, TextSize = size, Weight = weight, RowH = 28, W = 10 })
	end
	local function sep()
		return new("Frame", { Bg = "Outline", Position = Offset(0, 7), Size = Offset(1, 14) }, frame)
	end
	local first, firstSep = text(options.Script or "blossom.lua", 12, Enum.FontWeight.Medium), sep()
	local second, secondSep = text(options.Build or "release", 12, Enum.FontWeight.SemiBold), sep()
	local userIcon = makeIcon(frame, "user", 13, "Text", "Background")
	local third = text(("%s (@%s)"):format(player.DisplayName, player.Name), 11, Enum.FontWeight.SemiBold)
	local function layout()
		local x = 31
		for _, entry in { { first, firstSep }, { second, secondSep } } do
			local width = math.ceil(entry[1].TextBounds.X)
			entry[1].Size = Offset(width + 1, 28)
			entry[1].Position = Offset(x, entry[1].Position.Y.Offset)
			x += width + 8
			entry[2].Position = Offset(x, 7)
			x += 9
		end
		userIcon.Root.Position = Offset(x, 7)
		x += 20
		local width = math.ceil(third.TextBounds.X)
		third.Size = Offset(width + 1, 28)
		third.Position = Offset(x, third.Position.Y.Offset)
		frame.Size = Offset(x + width + Metrics.Pad, 28)
		self:_placeOverlays()
	end
	for _, entry in { first, second, third } do
		entry:GetPropertyChangedSignal("TextBounds"):Connect(layout)
	end
	self.Watermark = frame
	self.WatermarkLayout = layout
	self:_makeDraggable(frame, frame)
end

function Window:_buildHotkeys()
	local holder = new("Frame", { Size = Offset(200, 300) }, self.Screen)
	local head = new("Frame", { Bg = "Background", Position = Offset(1, 1), Size = Offset(88, 25), Radius = Metrics.FloatRadius, Border = "Outline", Active = true }, holder)
	makeIcon(head, "key", 14, "Accent", "Background", { Position = Offset(9, 5) })
	local text = label(head, { Text = "Hotkeys", TextSize = 12, Weight = Enum.FontWeight.SemiBold, X = 31, RowH = 25 })
	local function fit() head.Size = Offset(math.ceil(text.TextBounds.X) + 41, 25) end
	text:GetPropertyChangedSignal("TextBounds"):Connect(fit)
	fit()
	self.Hotkeys = holder
	self:_makeDraggable(head, holder)
end

local TextService = game:GetService("TextService")

function Window:_describe(item, text)
	item.Description = text
	table.insert(self.Described, item)
end

function Window:_buildTooltip()
	local frame = new("Frame", { Bg = "Background", Border = "Outline", Radius = Metrics.FloatRadius, Size = Offset(40, 24), Visible = false }, self.Tooltips)
	local text = new("TextLabel", { Fg = "Text", TextSize = 11, TextWrapped = true, Text = "", Position = Offset(8, 6), Size = Offset(20, 12) }, frame)
	self.Tip = { Frame = frame, Text = text, Fader = newFader(frame), Shown = false, Item = nil, Since = 0 }
end

function Window:_tipContent(text)
	local tip = self.Tip
	local params = Instance.new("GetTextBoundsParams")
	params.Text = applyCase(text)
	params.Font = fontOf(nil)
	params.Size = 11
	params.Width = 190
	local ok, bounds = pcall(TextService.GetTextBoundsAsync, TextService, params)
	if not ok then bounds = Vec2(190, 14) end
	local width, height = math.ceil(bounds.X) + 2, math.ceil(bounds.Y)
	setText(tip.Text, text)
	tip.Text.Size = Offset(width, height)
	tip.Frame.Size = Offset(width + 16, height + 12)
end

function Window:_tipPlace(animated)
	local tip = self.Tip
	local size = tip.Frame.Size
	local viewport = self.Screen.AbsoluteSize / LayerScale
	local mouse = toLayer(mousePos())
	local x = math.clamp(floor(mouse.X + 14), 8, math.max(8, viewport.X - size.X.Offset - 8))
	local y = mouse.Y + 18
	if y + size.Y.Offset > viewport.Y - 8 then y = mouse.Y - size.Y.Offset - 10 end
	place(tip.Frame, "Position", Offset(x, math.max(8, floor(y))), animated, "Follow")
end

function Window:_hideTooltip()
	local tip = self.Tip
	if not tip.Shown then return end
	tip.Shown = false
	tip.Fader:Hide()
end

function Window:_updateTooltip()
	local tip = self.Tip
	local target
	local blocked = not self.Visible or self.Closing or TouchOnly or self.Search.Open or self.OpenDropdown or self.ActivePopup
		or self.Listening or UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
	if not blocked and self.CurrentTab then
		local point = mousePos()
		for _, item in self.Described do
			local section = item.Section
			if item.Visible and section.Tab == self.CurrentTab and not section.Collapsed and not section.Dragging
				and inside(item.Frame, point) and inside(section.Column.Scroll, point) then
				target = item
				break
			end
		end
	end
	if target ~= tip.Item then
		tip.Item = target
		tip.Since = os.clock()
		if not target then
			self:_hideTooltip()
		elseif tip.Shown then
			self:_tipContent(target.Description)
			self:_tipPlace(false)
		end
	end
	if not target then return end
	if tip.Shown then
		self:_tipPlace(true)
	elseif os.clock() - tip.Since >= 0.4 then
		tip.Shown = true
		self:_tipContent(target.Description)
		self:_tipPlace(false)
		tip.Fader:Show()
	end
end

function Window:_placeOverlays()
	local size = self.Screen.AbsoluteSize
	if size.X <= 0 then return end
	if not self.Moved[self.Holder] then self.Holder.Position = Offset(floor(size.X / 2), floor(size.Y / 2)) end
	if self.Watermark and not self.Moved[self.Watermark] then
		self.Watermark.Position = Offset(floor((size.X - self.Watermark.Size.X.Offset) / 2), size.Y - 44)
	end
    if self.FloatButton and not self.Moved[self.FloatButton] then
		self.FloatButton.Position = Offset(floor(size.X / 2) - 20, 16)
	end
    if self.Loader then self.Loader.Position = Offset(floor(size.X / 2), floor(size.Y / 2)) end
	if self.Hotkeys and not self.Moved[self.Hotkeys] then self.Hotkeys.Position = Offset(14, floor((size.Y - 300) / 2)) end
end

function Window:Destroy()
	for _, connection in self.Connections do connection:Disconnect() end
	table.clear(Jobs)
	table.clear(HoverSet)
	for _, entry in Active do entry.Dead = true end
	table.clear(Active)
	table.clear(Tracks)
	if FrameConnection then
		FrameConnection:Disconnect()
		FrameConnection = nil
	end
	if Focus == self then Focus = nil end
	if ScreenRef == self.Screen then ScreenRef = nil end
	self.Screen:Destroy()
end

local function headerButton(parent, iconName, x, hoverColor)
	local hovering = false
	local button = new("TextButton", {
		Position = Offset(x, 4), Size = Offset(18, 18), Radius = Metrics.Radius, BackgroundTransparency = 0,
	}, parent)
	bind(button, "BackgroundColor3", function() return hovering and Current.Inline or Current.Tab end)
	local icon = makeIcon(button, iconName, 14, function()
		if not hovering then return Current.InactiveText end
		return hoverColor or Current.Text
	end, function() return hovering and Current.Inline or Current.Tab end, { Position = Offset(2, 2) })
	hoverable(button, function()
		hovering = true
		refresh(button)
		icon.Update()
	end, function()
		hovering = false
		refresh(button)
		icon.Update()
	end)
	return button
end

function Window:_applyFit()
	local view = self.Screen.AbsoluteSize
	if view.X <= 0 or view.Y <= 0 then return end
	local fit = math.min((view.X - 24) / self.Width, (view.Y - 24) / self.Height, 1)
	fit = math.clamp(floor(fit * 100) / 100, 0.4, 1)
	LayerScale = fit
	self.Fit = fit
	for _, layer in self.Layers do
		layer.Scale.Scale = fit
		layer.Frame.Size = Offset(math.ceil(view.X / fit), math.ceil(view.Y / fit))
	end
	if self.Visible then
		snap(self.Scale, "Scale", fit)
		self.Scale.Parent = fit == 1 and nil or self.Holder
	end
end

local function loadFile(folder, key)
	return folder .. "/load_" .. (string.gsub(key, "[^%w_%-]", "_")) .. ".txt"
end

function Window:_buildLoader(options)
	local width, height, pad = 280, 82, 14
	local frame = new("Frame", {
		Name = "Loader", Bg = "Background", AnchorPoint = Vec2(0.5, 0.5), Size = Offset(width, height),
		Radius = Metrics.WindowRadius, Border = "Outline", ZIndex = 60, Visible = false, Active = true,
	}, self.Screen)
	addShadow(frame, "Large")
	makeIcon(frame, "logo", 20, "Accent", "Background", { Position = Offset(pad, 12) })
	label(frame, { Text = self.Title, TextSize = 14, Weight = Enum.FontWeight.Bold, X = pad + 28, Y = 10, RowH = 24, W = 150 })
	local percent = label(frame, { Text = "0%", TextSize = 12, Fg = "InactiveText", X = width - pad - 60, Y = 10, RowH = 24, W = 60 })
	percent.TextXAlignment = Enum.TextXAlignment.Right
	local counter = label(frame, { Text = "", TextSize = 11, Fg = "InactiveText", X = width - pad - 60, Y = 36, RowH = 16, W = 60 })
	counter.TextXAlignment = Enum.TextXAlignment.Right
	local status = label(frame, { Text = "Starting", TextSize = 11, Fg = "InactiveText", X = pad, Y = 36, RowH = 16, Right = pad + 64, Truncate = Enum.TextTruncate.AtEnd })
	local track = new("Frame", { Bg = "Element", Position = Offset(pad + 1, 61), Size = Offset(width - pad * 2 - 2, 8), Radius = FULL, Border = "Outline" }, frame)
	local fill = new("Frame", { Bg = "Accent", Size = Dim2(0, 0, 1, 0), Radius = FULL }, track)
	addGradient(fill)

	local key = options.Script or self.Title
	local total = options.Total
	if not total then
		pcall(function()
			local path = loadFile(self.ConfigFolder, key)
			if typeof(isfile) == "function" and typeof(readfile) == "function" and isfile(path) then
				total = tonumber(readfile(path))
			end
		end)
	end

	local load = {
		Active = true, Done = false, Count = 0, Busy = 0, Progress = 0, Total = total, Key = key,
		Last = os.clock(), Slice = os.clock(), Idle = options.LoadIdle or 0.8, Budget = TouchOnly and 0.01 or 0.014,
		Frame = frame, Fader = newFader(frame), PercentText = "0%",
	}
	function load.Render(value)
		fill.Size = Dim2(value, 0, 1, 0)
		local text = floor(value * 100) .. "%"
		if text ~= load.PercentText then
			load.PercentText = text
			setText(percent, text)
		end
	end
	function load.SetStatus(text, count)
		setText(status, text)
		local shown = load.Total and load.Total > 0 and (count .. " / " .. load.Total) or tostring(count)
		setText(counter, shown)
	end
	self.Load = load
	self.Loader = frame
	load.Fader:Show()
end

function Window:_tick(kind, name)
	local load = self.Load
	if not load or not load.Active then return end
	load.Count += 1
	load.Last = os.clock()
	load.SetStatus(name and ("Creating %s: %s"):format(kind, tostring(name)) or ("Creating " .. kind), load.Count)
	local goal
	if load.Total and load.Total > 0 then
		goal = math.min(load.Count / load.Total, 0.98)
	else
		goal = 0.95 * (1 - 1 / (1 + load.Count / 20))
	end
	animate(load, "Progress", goal, "Smooth", { Step = load.Render })
	if os.clock() - load.Slice > load.Budget then
		task.wait()
		load.Slice = os.clock()
	end
end

function Window:_busy(delta, text)
	local load = self.Load
	if not load or not load.Active then return end
	load.Busy += delta
	load.Last = os.clock()
	if text then load.SetStatus(text, load.Count) end
end

function Window:FinishLoading()
	local load = self.Load
	if not load or not load.Active then return end
	load.Active = false
	load.SetStatus("Ready", load.Count)
	if load.Count > 0 then
		pcall(function()
			if typeof(writefile) == "function" then
				ensureFolder(self.ConfigFolder)
				writefile(loadFile(self.ConfigFolder, load.Key), tostring(load.Count))
			end
		end)
	end
	animate(load, "Progress", 1, "Smooth", {
		Step = load.Render,
		Done = function()
			task.delay(0.15, function() self:_reveal() end)
		end,
	})
end

function Window:_showOverlays()
	self.Revealed = true
	if self.ShowWatermark ~= false then newFader(self.Watermark):Show() end
	if self.ShowHotkeys ~= false then newFader(self.Hotkeys):Show() end
end

function Window:_reveal()
	local load = self.Load
	if self.Closing or not self.Screen.Parent or load.Done then return end
	load.Done = true
	load.Fader:Hide(function()
		self.Loader = nil
		load.Frame:Destroy()
	end)
	self:SetVisible(true)
	self:_showOverlays()
end

local Blossom = { Themes = Themes, ThemeOrder = ThemeOrder, Metrics = Metrics, Fonts = Fonts, NotifyTypes = NotifyTypes }

local LastWindow
Blossom.SetLucide = setLucide
function Blossom.new(options)
	options = options or {}
	local globalEnv = typeof(getgenv) == "function" and getgenv() or nil
	local previous = LastWindow or (globalEnv and globalEnv.__BlossomWindow)
	if previous then pcall(previous.Destroy, previous) end
	local themeName = Themes[options.Theme] and options.Theme or "Crimson"
	for key, value in Themes[themeName] do Current[key] = value end
	if options.Font then FontFamily = Fonts[options.Font] or options.Font end
	if options.Lucide ~= nil then setLucide(options.Lucide) end
	local minSize = options.MinSize or Vec2(Metrics.MinWindowW, Metrics.MinWindowH)
	minSize = Vec2(minSize.X - minSize.X % 2, minSize.Y - minSize.Y % 2)
	local startSize = options.Size or Vec2(Metrics.WindowW, Metrics.WindowH)
	local startW, startH = evenClamp(startSize.X, minSize.X, math.huge), evenClamp(startSize.Y, minSize.Y, math.huge)
	local win = setmetatable({
		Width = startW, Height = startH, MinSize = minSize, ColumnW = floor((startW - Metrics.SidebarW - 1 - Metrics.Pad * 3) / 2),
		SidebarW = Metrics.SidebarW, SidebarOpenW = Metrics.SidebarW, SidebarAnim = Metrics.SidebarW, SidebarCollapsed = false,
		ResizeJobs = {}, ResizeHandles = {},
		Title = options.Title or "Blossom",	ConfigFolder = cleanFolder(options.ConfigFolder), Tabs = {}, Sections = {}, Columns = {}, Index = {}, Binds = {}, Colors = {}, Flags = {},
		ThemeRows = {}, HotkeyEntries = {}, HotkeyOrder = {}, NotifyStack = {}, Connections = {}, Jobs = {}, Moved = {}, PendingThemeKeys = {}, FlagOwners = {},Described = {},
		ThemeClock = 0, SidebarY = Metrics.FirstCategory, SidebarItems = {}, IndicatorOn = false,
		Visible = true, ThemeName = themeName, MenuKey = options.MenuKey or Enum.KeyCode.RightShift,
		LastPopupTime = 0, DropdownClosedAt = 0,
	}, Window)
	ensureLoop()
	LastWindow, Focus = win, win
	if globalEnv then globalEnv.__BlossomWindow = win end

	local screen = new("ScreenGui", { Name = "Blossom", ResetOnSpawn = false, IgnoreGuiInset = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 100 })
	guiParent(screen)
	win.Screen = screen
	ScreenRef = screen

	local holder = new("Frame", {
		Name = "Window", AnchorPoint = Vec2(0.5, 0.5), Size = Offset(win.Width, win.Height), ZIndex = 10,
	}, screen)
	win.Holder = holder
	win.Scale = new("UIScale", { Scale = 0.97 })
	local root = new("Frame", { Bg = "Background", Active = true, Size = Dim2(1, 0, 1, 0), Radius = Metrics.WindowRadius, Border = "Outline" }, holder)
	addShadow(root, "Large")
	win.Root = root
	win.Fader = newFader(holder)
	win.ModalButton = new("TextButton", { Modal = true, Size = Offset(1, 1) }, holder)

	local sidebar = new("Frame", { Size = Dim2(0, Metrics.SidebarW, 1, 0) }, root)
	win.Sidebar = sidebar
	win.Logo = makeIcon(sidebar, "logo", 20, "Accent", "Background", { Position = Offset(Metrics.Pad * 2, 15) })
	win.SidebarTitle = label(sidebar, { Text = win.Title, TextSize = 16, Weight = Enum.FontWeight.Bold, Y = 11, RowH = 28, W = 85 })
	win.SidebarTitle:GetPropertyChangedSignal("TextBounds"):Connect(function() win:_layoutHeader() end)
	win.Indicator = new("Frame", { Bg = "Inline", Size = Offset(Metrics.TabW - 2, Metrics.TabH - 2), Radius = Metrics.PillRadius, Border = "Outline", Visible = false }, sidebar)
	win.IndicatorFader = newFader(win.Indicator)
	local searchButton = new("TextButton", {
		Position = Dim2(0, Metrics.Pad + 1, 1, -(Metrics.Pad + Metrics.SearchH) + 1), Size = Offset(Metrics.TabW - 2, Metrics.SearchH - 2),
		Radius = Metrics.PillRadius, Border = "Outline", BackgroundTransparency = 0, ClipsDescendants = true,
	}, sidebar)
	interactive(searchButton, "Inline")
	win.SearchButton = searchButton
	makeIcon(searchButton, "search", 14, "InactiveText", "Inline", { Position = Offset(6, 6) })
	win.SearchLabel = label(searchButton, { Fg = "InactiveText", Text = "Search...", X = 30, RowH = Metrics.SearchH - 2, Right = 6 })
	searchButton.MouseButton1Click:Connect(function() win:OpenSearch() end)

	local content = new("Frame", { Bg = "Tab", Position = Offset(Metrics.SidebarW + 1, 0), Size = Dim2(1, -(Metrics.SidebarW + 1), 1, 0), Radius = Metrics.WindowRadius }, root)
	win.Content = content
	new("Frame", { Name = "CornerPatch", Bg = "Tab", Size = Dim2(0, 12, 1, 0) }, content)
	win.Pages = new("Frame", {
		Name = "Pages", Position = Offset(0, Metrics.TopBar), Size = Dim2(1, 0, 1, -(Metrics.TopBar + Metrics.Pad)), ClipsDescendants = true,
	}, content)
	win.Veil = new("Frame", { Bg = "Tab", BackgroundTransparency = 1, Size = Dim2(1, 0, 1, 0), ZIndex = 5 }, win.Pages)
	local controls = new("Frame", {
		Name = "Controls", AnchorPoint = Vec2(1, 0), Position = Dim2(1, -Metrics.Pad, 0, 0), Size = Offset(62, Metrics.TopBar), ZIndex = 3,
	}, root)
	win.Controls = controls
	headerButton(controls, "discord", 0, RGB(114, 137, 218)).MouseButton1Click:Connect(function()
		if copyToClipboard(DISCORD_INVITE) then
			win:Notify("Discord invite copied to clipboard.")
		else
			win:Notify("Clipboard unavailable on this executor.", "Warning")
		end
	end)
	headerButton(controls, "minus", 22).MouseButton1Click:Connect(function() win:Minimize() end)
	headerButton(controls, "close", 44, RGB(235, 95, 95)).MouseButton1Click:Connect(function() win:Close() end)
	win.DragLayer = new("Frame", { Name = "Drag", Size = Dim2(1, 0, 1, 0), ZIndex = 30 }, screen)
	win.Popups = new("Frame", { Name = "Popups", Size = Dim2(1, 0, 1, 0), ZIndex = 40 }, screen)
	win.Dropdowns = new("Frame", { Name = "Dropdowns", Size = Dim2(1, 0, 1, 0), ZIndex = 45 }, screen)
	win.Notifications = new("Frame", { Name = "Notifications", Position = Offset(16, 16), Size = Dim2(1, -32, 1, -32), ZIndex = 50 }, screen)
    win.Tooltips = new("Frame", { Name = "Tooltips", Size = Dim2(1, 0, 1, 0), ZIndex = 55 }, screen)

	win.Fit = 1
	win.Layers = {}
	for _, layer in { win.DragLayer, win.Popups, win.Dropdowns, win.Tooltips } do
		table.insert(win.Layers, { Frame = layer, Scale = new("UIScale", nil, layer) })
	end
    win:_buildTooltip()
	win:_buildWatermark(options)
	win:_buildHotkeys()
	win:_buildKeybindMenu()
	win:_buildPicker()
	win:_buildSearch()
    win:_buildSidebarControls()
	win:_layoutHeader()
	if options.Resizable ~= false then win:_buildResize() end
	win:_buildFloatButton()
	win:_applyFit()
	win:_placeOverlays()
	win:SetNotifyPlacement(options.NotifyPosition, true)
	win.WatermarkLayout()
	table.insert(win.Connections, screen:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		win:_applyFit()
		win:_placeOverlays()
	end))
	table.insert(win.Connections, UserInputService.InputChanged:Connect(trackTouch))
	win:_makeDraggable(root, holder, function(point) return not win:_overControl(point) end)

	table.insert(win.Connections, UserInputService.InputBegan:Connect(function(input, processed)
		if isClick(input) then
			local point = mousePos()
			local dropdown = win.OpenDropdown
			local overDropdown = dropdown and inside(dropdown.Panel, point)
			if dropdown and not overDropdown then
				if inside(dropdown.Input, point) then
					win.DropdownClosedBy, win.DropdownClosedAt = dropdown.Input, os.clock()
				end
				dropdown:Toggle(false)
			end
			if win.ActivePopup and not overDropdown and not inside(win.ActivePopup.Frame, point, 6) then
				win:ClosePopup()
			end
		end
		local listening = win.Listening
		if listening then
			local isKey = input.UserInputType == Enum.UserInputType.Keyboard
			local isMouse = input.UserInputType == Enum.UserInputType.MouseButton2 or input.UserInputType == Enum.UserInputType.MouseButton3
			if isKey or isMouse then
				win.Listening = nil
				listening.Listening = false
				if isKey and input.KeyCode == Enum.KeyCode.Escape then
					listening.Key = nil
				else
					listening.Key = isKey and input.KeyCode or input.UserInputType
				end
				listening.Refresh()
			elseif isClick(input) then
				win.Listening = nil
				listening.Listening = false
				listening.Refresh()
			end
			return
		end
		if processed then return end
		if input.KeyCode == win.MenuKey then win:Toggle() end
		for _, object in win.Binds do
			if object.Key and object.Enabled ~= false and (object.Key == input.KeyCode or object.Key == input.UserInputType) and object.OnPress then
				object.OnPress()
			end
		end
	end))

	table.insert(win.Connections, UserInputService.InputEnded:Connect(function(input)
		for _, object in win.Binds do
			if object.Key and (object.Key == input.KeyCode or object.Key == input.UserInputType) and object.OnRelease then
				object.OnRelease()
			end
		end
	end))

	table.insert(win.Connections, UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseWheel or not win.Visible or win.Search.Open or not win.CurrentTab then return end
		local point = mousePos()
		local dropdown = win.OpenDropdown
		if dropdown then
			if inside(dropdown.Panel, point) then return end
			dropdown:Toggle(false)
		end
		for _, column in win.CurrentTab.Columns do
			if inside(column.Scroll, point) then
				column:ScrollTo(column.Target - input.Position.Z * 60)
			end
		end
	end))

	local clock, colorClock = 0, 0
	local function perFrame(dt)
		clock += dt
		colorClock += dt
		win:_flushThemeColors(dt)
        win:_updateTooltip()
        local load = win.Load
		if load and load.Active and load.Busy == 0 then
			local idle = os.clock() - load.Last
			local limit = load.Total and load.Count >= load.Total and 0.25 or load.Idle
			if (load.Count > 0 and idle > limit) or idle > 10 then win:FinishLoading() end
		end
		if win.OpenDropdown then win.OpenDropdown.Follow() end
		if win.CurrentTab then
			for _, column in win.CurrentTab.Columns do
				local y = column.Scroll.CanvasPosition.Y
				local showTop, showBottom = y > 1, y < column.ContentH - column.Scroll.AbsoluteSize.Y - 1
				if showTop ~= column.ShowTop then
					column.ShowTop = showTop
					animate(column.FadeTop, "BackgroundTransparency", showTop and 0 or 1, "Fast")
				end
				if showBottom ~= column.ShowBottom then
					column.ShowBottom = showBottom
					animate(column.FadeBottom, "BackgroundTransparency", showBottom and 0 or 1, "Fast")
				end
			end
		end
		if win.Search.Dirty then
			win.Search.Dirty = false
			win.Search.Sync()
		end
		if colorClock >= 1 / 30 then
			colorClock = 0
			for _, color in win.Colors do
				if color.Animation == "Rainbow" then
					local _, s, v = color.Value:ToHSV()
					color:Set(Color3.fromHSV((clock * 0.25) % 1, math.max(s, 0.5), math.max(v, 0.6)))
				elseif color.Animation == "Pulse" then
					local h, s = color.Value:ToHSV()
					color:Set(Color3.fromHSV(h, s, 0.65 + math.sin(clock * 4) * 0.35))
				end
			end
		end
	end
	Jobs[perFrame] = true
	table.insert(win.Jobs, perFrame)

	holder.Visible, win.Visible = false, false
	win.Watermark.Visible, win.Hotkeys.Visible = false, false
	if options.Loading == false then
		task.defer(function()
			if win.Screen.Parent == nil then return end
			win:SetVisible(true)
			win:_showOverlays()
		end)
	else
		win:_buildLoader(options)
		win:_placeOverlays()
	end

	return win
end


-- Expose internals for the adapter layer
Blossom._internals = {
    new = new,
    label = label,
    centeredLabel = centeredLabel,
    Metrics = Metrics,
    Current = Current,
    place = place,
    bind = bind,
    refresh = refresh,
    addGradient = addGradient,
    addShadow = addShadow,
    interactive = interactive,
    hoverable = hoverable,
    makeIcon = makeIcon,
    fire = fire,
    round = round,
    formatNumber = formatNumber,
    keyName = keyName,
    makeChip = makeChip,
    fitChip = fitChip,
    makeEditable = makeEditable,
    addSlot = addSlot,
    layoutSlots = layoutSlots,
    buildDropdown = buildDropdown,
    attachColor = attachColor,
    attachKeybind = attachKeybind,
    register = register,
    trackWidth = trackWidth,
    ensureLoop = ensureLoop,
    applyTextSettings = applyTextSettings,
    setLucide = setLucide,
    newFader = newFader,
    guiParent = guiParent,
    Offset = Offset,
    Dim2 = Dim2,
    Vec2 = Vec2,
    RGB = RGB,
    Casing = Casing,
    Casings = Casings,
    Fonts = Fonts,
    Themes = Themes,
    Bound = Bound,
    ByKey = ByKey,
    Dynamic = Dynamic,
}



local _component = (function(Blossom)
-- ============================================================================
-- Blossom UI Adapter for chain.lua
-- ----------------------------------------------------------------------------
-- This adapter wraps the Blossom UI library to expose the juju-style API
-- surface that chain.lua consumes. Blossom is a fundamentally different UI
-- framework, so this file builds custom control renderers inside Blossom
-- sections that produce the exact `drawings` table structure chain.lua
-- manipulates directly (drawings["toggle_border"]["Color"], etc.).
--
-- Usage: loadstring(source)() returns { menu, flags, create_connection,
-- round, tween, drawing_proxy }
-- ============================================================================

-- Blossom is passed as parameter

-- ---------------------------------------------------------------------------
-- Internals exposed from Blossom source
-- ---------------------------------------------------------------------------
local _int = Blossom._internals
local new      = _int.new
local label    = _int.label
local Metrics  = _int.Metrics
local Current  = _int.Current
local place    = _int.place
local bind     = _int.bind
local refresh  = _int.refresh
local addGrad  = _int.addGradient
local inter    = _int.interactive
local hov      = _int.hoverable
local mkIcon   = _int.makeIcon
local addShadow = _int.addShadow
local fire     = _int.fire
local rnd      = _int.round
local fmtNum   = _int.formatNumber
local keyNm    = _int.keyName
local mkChip   = _int.makeChip
local addSlot  = _int.addSlot
local layoutSlots = _int.layoutSlots
local fitChip  = _int.fitChip
local buildDropdown = _int.buildDropdown
local mkEditable = _int.makeEditable
local ensureLoop = _int.ensureLoop
local applyText = _int.applyTextSettings
local ByKey    = _int.ByKey
local Bound    = _int.Bound
local Dynamic  = _int.Dynamic
local Casing   = _int.Casing
local Fonts    = _int.Fonts
local Themes   = _int.Themes
local guiParent = _int.guiParent
local newFader = _int.newFader
local attachColor = _int.attachColor
local attachKeybind = _int.attachKeybind
local register = _int.register
local trackWidth = _int.trackWidth
local centeredLabel = _int.centeredLabel
local setLucide = _int.setLucide
local Offset   = _int.Offset
local Dim2     = _int.Dim2
local Vec2     = _int.Vec2
local RGB      = _int.RGB
local Casings  = _int.Casings

-- ---------------------------------------------------------------------------
-- Drawing Proxy
-- chain.lua manipulates drawings via ["Color"], ["Position"], ["Size"],
-- ["Visible"], ["Text"], ["Transparency"], ["ZIndex"], ["Filled"], etc.
-- For Frames, "Color" maps to BackgroundColor3 and "Transparency" to
-- BackgroundTransparency. For TextLabels, "Color" and "Text" are direct.
-- ---------------------------------------------------------------------------
local function make_drawing(inst)
    local proxy = {}
    local isFrame = inst:IsA("Frame") or inst:IsA("ImageLabel") or inst:IsA("Image")
    local mt = {
        __index = function(self, key)
            if key == "Color" then
                if isFrame then return inst.BackgroundColor3 else return inst.Color end
            elseif key == "Transparency" then
                if isFrame then return inst.BackgroundTransparency else return inst.Transparency end
            elseif key == "Filled" then
                return rawget(self, "_filled")
            else
                return inst[key]
            end
        end,
        __newindex = function(self, key, value)
            if key == "Color" then
                if isFrame then inst.BackgroundColor3 = value else inst.Color = value end
            elseif key == "Transparency" then
                if isFrame then inst.BackgroundTransparency = value else inst.Transparency = value end
            elseif key == "Filled" then
                rawset(self, "_filled", value)
                if isFrame then inst.BackgroundTransparency = value and 0 or 1 end
            else
                inst[key] = value
            end
        end,
    }
    setmetatable(proxy, mt)
    return proxy
end

local drawing_proxy = {}
function drawing_proxy.new(class, properties)
    local inst
    if class == "Text" then
        inst = new("TextLabel", { BackgroundTransparency = 1 })
    else
        inst = new("Frame", {})
    end
    if properties then
        for key, value in pairs(properties) do
            if key == "Parent" then
                inst.Parent = value
            elseif key == "Color" then
                if inst:IsA("Frame") then inst.BackgroundColor3 = value else inst.Color = value end
            elseif key == "Transparency" then
                if inst:IsA("Frame") then inst.BackgroundTransparency = value else inst.Transparency = value end
            elseif key == "Filled" then
                -- handled by proxy
            else
                inst[key] = value
            end
        end
    end
    local proxy = make_drawing(inst)
    rawset(proxy, "_filled", properties and properties["Filled"] or true)
    rawset(proxy, "_instance", inst)
    return proxy
end

-- ---------------------------------------------------------------------------
-- Signal system
-- chain.lua uses Connect(signal, callback) where signal has a Connect method.
-- ---------------------------------------------------------------------------
local function new_signal()
    local callbacks = {}
    local signal = {}
    function signal:Connect(callback)
        local conn = { Connected = true, Disconnect = function() end }
        callbacks[#callbacks + 1] = { cb = callback, conn = conn }
        return conn
    end
    function signal:Fire(...)
        for _, entry in ipairs(callbacks) do
            pcall(entry.cb, ...)
        end
    end
    function signal:DisconnectAll()
        callbacks = {}
    end
    return signal
end

local function create_connection(signal, callback)
    if type(signal) == "table" and type(signal.Connect) == "function" then
        return signal:Connect(callback)
    end
    return nil
end

-- ---------------------------------------------------------------------------
-- Round / Tween
-- ---------------------------------------------------------------------------
local function round(value, decimals)
    local factor = 10 ^ (decimals or 0)
    return math.floor(value * factor + 0.5) / factor
end

local function tween(target, properties)
    for key, value in pairs(properties or {}) do
        local prop = key
        if prop == "tween_position" then prop = "Position"
        elseif prop == "tween_size" then prop = "Size" end
        target[prop] = value
    end
end

-- ---------------------------------------------------------------------------
-- Colors table (maps Blossom theme to juju color names)
-- ---------------------------------------------------------------------------
local colors = {
    accent       = Current.Accent,
    border       = Current.Outline,
    highlighted  = Current.HoveredElement,
    shadow       = RGB(0, 0, 0),
    active_text  = Current.Text,
    inactive_text = Current.InactiveText,
    dark_text    = Current.InactiveText,
    background   = Current.Background,
    section      = Current.Inline,
}

local function update_colors()
    colors.accent       = Current.Accent
    colors.border       = Current.Outline
    colors.highlighted  = Current.HoveredElement
    colors.active_text  = Current.Text
    colors.inactive_text = Current.InactiveText
    colors.dark_text    = Current.InactiveText
    colors.background   = Current.Background
    colors.section      = Current.Inline
end

-- ---------------------------------------------------------------------------
-- Flags table
-- ---------------------------------------------------------------------------
local flags = {}

-- ---------------------------------------------------------------------------
-- Window creation
-- ---------------------------------------------------------------------------
local win = Blossom.new({
    Title = "neko.com",
    Script = "neko.com",
    Build = "chain",
    Theme = "Crimson",
    Font = "Inter",
    MenuKey = Enum.KeyCode.RightShift,
})

local menu = {}
menu["colors"] = colors
menu["theme"] = win.ThemeName or "Crimson"
menu["autoload"] = nil
menu["favorites"] = {}
menu["settings"] = {}
menu["groups"] = {}
menu["ordered_groups"] = {}

-- ---------------------------------------------------------------------------
-- Section wrapper
-- ---------------------------------------------------------------------------
local sections_by_name = {}

local function wrap_section(blossom_section, group, tab_obj, name, side)
    local section = {
        _blossom = blossom_section,
        group = group,
        tab = tab_obj,
        name = name,
        side = side or 1,
        elements = {},
        border = make_drawing(blossom_section.Card),
        inside = blossom_section.Body,
    }
    -- Store border position/size base for chain.lua manipulation
    section._border_base_pos = blossom_section.Card.Position
    section._border_base_size = blossom_section.Card.Size

    function section:create_element(spec, elements, is_note)
        return create_element(blossom_section, section, spec, elements, is_note)
    end

    function section:create_settings(count)
        return create_settings_section(blossom_section, section, count)
    end

    sections_by_name[name] = section
    return section
end

-- ---------------------------------------------------------------------------
-- Element creation
-- ---------------------------------------------------------------------------
local function create_element(blossom_section, section, spec, elements, is_note)
    local name = spec["name"] or ""
    local row_height = Metrics.Row

    -- Determine row height based on control types
    for key, _ in pairs(elements or {}) do
        if key == "slider" then row_height = Metrics.SliderH
        elseif key == "dropdown" then row_height = Metrics.DropdownH
        elseif key == "textbox" then row_height = Metrics.InputH
        elseif key == "button" then row_height = Metrics.ButtonH
        end
    end

    -- Create item via Blossom's _item
    local item = blossom_section:_item(row_height, "Element", name)

    local element = {
        name = name,
        drawings = {},
        visible = true,
        frame = item.Frame,
        _item = item,
        _section = section,
    }

    -- Create label text
    local text_inst = label(item.Frame, {
        Text = name,
        Truncate = Enum.TextTruncate.AtEnd,
    })
    element.drawings["text"] = make_drawing(text_inst)

    -- Position controls on the right side
    local control_x = 1  -- start from right
    local control_w = 0

    for key, control_spec in pairs(elements or {}) do
        if key == "toggle" then
            create_toggle(element, item, control_spec, control_x)
        elseif key == "slider" then
            create_slider(element, item, control_spec, control_x)
        elseif key == "dropdown" then
            create_dropdown(element, item, control_spec, control_x)
        elseif key == "colorpicker" then
            create_colorpicker(element, item, control_spec, control_x)
        elseif key == "keybind" then
            create_keybind(element, item, control_spec, control_x)
        elseif key == "textbox" then
            create_textbox(element, item, control_spec, control_x)
        elseif key == "button" then
            create_button(element, item, control_spec, control_x)
        elseif key == "info" then
            create_info(element, item, control_spec, control_x)
        end
    end

    -- Note elements: just text, no controls
    if is_note then
        text_inst.Text = name
        text_inst:SetAttribute("NoteMode", true)
    end

    -- Set flag fields
    for key, control_spec in pairs(elements or {}) do
        if key == "toggle" and control_spec["flag"] then
            element.toggle_flag = control_spec["flag"]
            if flags[element.toggle_flag] == nil then
                flags[element.toggle_flag] = control_spec["default"] or false
            end
        elseif key == "slider" and control_spec["flag"] then
            element.slider_flag = control_spec["flag"]
            if flags[element.slider_flag] == nil then
                flags[element.slider_flag] = control_spec["default"] or 0
            end
        elseif key == "dropdown" and control_spec["flag"] then
            element.dropdown_flag = control_spec["flag"]
            if flags[element.dropdown_flag] == nil then
                flags[element.dropdown_flag] = control_spec["default"] or {}
            end
        elseif key == "keybind" and control_spec["flag"] then
            element.keybind_flag = control_spec["flag"]
        elseif key == "textbox" and control_spec["flag"] then
            element.textbox_flag = control_spec["flag"]
            if flags[element.textbox_flag] == nil then
                flags[element.textbox_flag] = control_spec["default"] or ""
            end
        elseif key == "colorpicker" then
            if control_spec["color_flag"] then element.color_flag = control_spec["color_flag"]
            if flags[element.color_flag] == nil then
                flags[element.color_flag] = control_spec["default_color"] or Color3.new(1, 1, 1)
            end end
            if control_spec["transparency_flag"] then element.transparency_flag = control_spec["transparency_flag"]
            if flags[element.transparency_flag] == nil then
                flags[element.transparency_flag] = control_spec["default_transparency"] or 0
            end end
        end
    end

    -- Default visibility
    element.visible = true

    -- Add to section's elements list
    section.elements[#section.elements + 1] = element

    return element
end

-- ---------------------------------------------------------------------------
-- Control renderers
-- ---------------------------------------------------------------------------

-- Toggle
local function create_toggle(element, item, spec, control_x)
    local flag = spec["flag"]
    local default_val = spec["default"] or false

    -- Toggle track
    local track = new("Frame", {
        Size = Offset(Metrics.ToggleW, Metrics.ToggleH),
        Radius = Metrics.Radius,
        BackgroundColor3 = default_val and colors.accent or colors.border,
        BorderTransparency = 0,
        Position = Offset(-1, -3),
    }, item.Frame)
    addGrad(track)
    element.drawings["toggle_border"] = make_drawing(track)

    -- Toggle knob
    local knob = new("Frame", {
        Size = Offset(Metrics.ToggleKnob, Metrics.ToggleKnob),
        Radius = Metrics.Radius,
        BackgroundColor3 = default_val and colors.active_text or colors.inactive_text,
        Position = Offset(1, 1),
    }, track)
    element.drawings["toggle_knob"] = make_drawing(knob)

    -- Click area
    local click = new("TextButton", {
        Size = Dim2(1, 0, 1, Metrics.Row),
        BackgroundTransparency = 1,
        Position = Offset(-2, -4),
    }, item.Frame)
    element.drawings["toggle_click"] = make_drawing(click)

    -- Checkmark
    local check = label(item.Frame, {
        Text = "✓",
        TextSize = 10,
        Color = colors.active_text,
        Transparency = default_val and 0.5 or 1,
        Position = Offset(-1, -3),
        Visible = false,
    })
    element.drawings["checkmark"] = make_drawing(check)

    -- Signal
    element.on_toggle_change = new_signal()

    -- Method
    function element:set_toggle(value)
        value = value == true
        flags[flag] = value
        track.BackgroundColor3 = value and colors.accent or colors.border
        knob.BackgroundColor3 = value and colors.active_text or colors.inactive_text
        knob.Position = Offset(value and (Metrics.ToggleW - Metrics.ToggleKnob - 2) or 1, 1)
        check.Transparency = value and 0.5 or 1
        check.Visible = value
        if element.on_toggle_change then element.on_toggle_change:Fire(value) end
    end

    -- Click handler
    click.MouseButton1Click:Connect(function()
        element:set_toggle(not flags[flag])
    end)

    -- Set initial state
    element:set_toggle(default_val)
end

-- Slider
local function create_slider(element, item, spec, control_x)
    local flag = spec["flag"]
    local default_val = spec["default"] or 0
    local minimum = spec["min"] or 0
    local maximum = spec["max"] or 100
    local decimals = spec["decimals"] or 0
    local suffix = spec["suffix"] or ""

    -- Track
    local track = new("Frame", {
        Size = Offset(trackWidth(win) - 60, Metrics.TrackH),
        Radius = Metrics.Radius,
        BackgroundColor3 = colors.border,
        Position = Offset(-1, -2),
    }, item.Frame)
    addGrad(track)
    element.drawings["slider_border"] = make_drawing(track)

    -- Fill line
    local fill = new("Frame", {
        Size = Dim2(0, 0, 1, 0),
        Radius = Metrics.Radius,
        BackgroundColor3 = colors.accent,
        Parent = track,
    })
    addGrad(fill)
    element.drawings["slider_line"] = make_drawing(fill)

    -- Value text
    local text_inst = label(item.Frame, {
        Text = fmtNum(default_val, decimals) .. suffix,
        TextSize = 11,
        Color = colors.active_text,
        Position = Offset(-1, -2),
    })
    element.drawings["slider_text"] = make_drawing(text_inst)

    -- Click/drag area
    local hit = new("TextButton", {
        Size = Dim2(1, 0, 1, Metrics.Row),
        BackgroundTransparency = 1,
        Position = Offset(-4, -4),
    }, item.Frame)
    element.drawings["slider_click"] = make_drawing(hit)

    -- Signal
    element.on_slider_change = new_signal()

    local function update_fill(value)
        local alpha = (value - minimum) / (maximum - minimum)
        local pixels = rnd(Metrics.TrackInset + alpha * (track.AbsoluteSize.X - Metrics.TrackInset * 2), 0)
        fill.Size = Dim2(0, pixels, 1, 0)
        text_inst.Text = fmtNum(value, decimals) .. suffix
    end

    function element:set_slider(value)
        value = math.clamp(value, minimum, maximum)
        flags[flag] = value
        update_fill(value)
        if element.on_slider_change then element.on_slider_change:Fire(value) end
    end

    local dragging = false
    local function from_mouse(point)
        local rect = track.AbsolutePosition
        local x = (point.X - rect.X) / track.AbsoluteSize.X
        x = math.clamp(x, 0, 1)
        element:set_slider(minimum + (maximum - minimum) * x)
    end

    hit.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            from_mouse(input.Position)
        end
    end)
    hit.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    -- Drag on window
    win.Root.InputBegan:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMove or input.UserInputType == Enum.UserInputType.Touch) then
            from_mouse(input.Position)
        end
    end)
    win.Root.InputEnded:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragging = false
        end
    end)

    element:set_slider(default_val)
end

-- Dropdown
local function create_dropdown(element, item, spec, control_x)
    local flag = spec["flag"]
    local options = spec["options"] or {}
    local default_val = spec["default"] or {}
    local requires_one = spec["requires_one"]

    -- Input frame
    local input = new("Frame", {
        Size = Dim2(1, 0, 0, Metrics.InputH),
        Radius = Metrics.Radius,
        BackgroundColor3 = colors.section,
        BorderTransparency = 0,
        Position = Offset(-1, -1),
    }, item.Frame)
    addGrad(input)
    element.drawings["dropdown_border"] = make_drawing(input)

    -- Text label
    local text_inst = label(input, {
        Text = "",
        TextSize = 12,
        Color = colors.active_text,
        Position = Offset(6, 0),
    })
    element.drawings["dropdown_text"] = make_drawing(text_inst)

    -- Arrow
    local arrow = new("Frame", {
        Size = Offset(8, 8),
        Radius = 2,
        BackgroundColor3 = colors.inactive_text,
        Position = Offset(-6, 0),
        AnchorPoint = Vec2(0.5, 0.5),
    }, input)
    element.drawings["dropdown_arrow"] = make_drawing(arrow)

    -- Click area
    local click = new("TextButton", {
        Size = Dim2(1, 0, 1, Metrics.InputH),
        BackgroundTransparency = 1,
        Position = Offset(-1, -1),
    }, item.Frame)
    element.drawings["dropdown_click"] = make_drawing(click)

    -- Signal
    element.on_dropdown_change = new_signal()

    local function update_text()
        local val = flags[flag]
        if type(val) == "table" then
            local parts = {}
            for _, opt in pairs(val) do
                parts[#parts + 1] = tostring(opt)
            end
            text_inst.Text = table.concat(parts, ", ")
        else
            text_inst.Text = tostring(val)
        end
    end

    function element:set_dropdown(value)
        if type(value) ~= "table" then value = { value } end
        flags[flag] = value
        update_text()
        if element.on_dropdown_change then element.on_dropdown_change:Fire(value) end
    end

    function element:set_options(new_options)
        options = new_options or {}
    end

    -- Build a simple dropdown popup
    local popup_open = false
    local popup = nil

    local function rebuild_popup()
        if popup then popup:Destroy() end
        popup = new("Frame", {
            Size = Dim2(1, 0, 0, #options * Metrics.ListRowH + 4),
            Radius = Metrics.Radius,
            BackgroundColor3 = colors.background,
            BorderTransparency = 0,
            Position = Offset(0, Metrics.InputH + 2),
            Visible = false,
        }, input)
        for i, opt in ipairs(options) do
            local row = new("TextButton", {
                Size = Dim2(1, 0, 0, Metrics.ListRowH),
                BackgroundTransparency = 1,
                Position = Offset(0, i * Metrics.ListRowH),
            }, popup)
            local row_text = label(row, {
                Text = tostring(opt),
                TextSize = 12,
                Color = colors.active_text,
                Position = Offset(6, 0),
            })
            local is_selected = false
            if type(flags[flag]) == "table" then
                for _, v in pairs(flags[flag]) do
                    if v == opt then is_selected = true end
                end
            end
            if is_selected then
                row_text.Color = colors.accent
            end
            row.MouseButton1Click:Connect(function()
                element:set_dropdown({ opt })
                popup.Visible = false
                popup_open = false
            end)
        end
    end

    click.MouseButton1Click:Connect(function()
        if popup_open then
            popup.Visible = false
            popup_open = false
            return
        end
        rebuild_popup()
        popup.Visible = true
        popup_open = true
    end)

    update_text()
end

-- Colorpicker
local function create_colorpicker(element, item, spec, control_x)
    local color_flag = spec["color_flag"]
    local transparency_flag = spec["transparency_flag"]
    local default_color = spec["default_color"] or Color3.new(1, 1, 1)
    local default_transparency = spec["default_transparency"] or 0

    -- Swatch
    local swatch = new("TextButton", {
        Size = Offset(Metrics.Swatch, Metrics.Swatch),
        Radius = Metrics.Radius,
        BackgroundColor3 = default_color,
        BorderTransparency = 0,
        Position = Offset(-1, -3),
    }, item.Frame)
    addGrad(swatch)
    element.drawings["colorpicker_border"] = make_drawing(swatch)

    -- Signals
    element.on_color_change = new_signal()
    element.on_transparency_change = new_signal()

    function element:set_color(color)
        if color_flag then flags[color_flag] = color end
        swatch.BackgroundColor3 = color
        if element.on_color_change then element.on_color_change:Fire(color) end
    end

    function element:set_colorpicker_transparency(alpha)
        if transparency_flag then flags[transparency_flag] = alpha end
        swatch.BackgroundTransparency = alpha
        if element.on_transparency_change then element.on_transparency_change:Fire(alpha) end
    end

    -- Click to open Blossom's color picker
    swatch.MouseButton1Click:Connect(function()
        win:OpenPicker(swatch, {
            Value = swatch.BackgroundColor3,
            Alpha = swatch.BackgroundTransparency,
            Callback = function(color, alpha)
                element:set_color(color)
                element:set_colorpicker_transparency(alpha)
            end,
        })
    end)

    -- Set initial state
    if color_flag then flags[color_flag] = default_color end
    if transparency_flag then flags[transparency_flag] = default_transparency end
    swatch.BackgroundTransparency = default_transparency
end

-- Keybind
local function create_keybind(element, item, spec, control_x)
    local flag = spec["flag"]
    local default_key = spec["default"]

    -- Chip
    local chip = new("Frame", {
        Size = Offset(60, Metrics.ChipH),
        Radius = Metrics.Radius,
        BackgroundColor3 = colors.section,
        BorderTransparency = 0,
        Position = Offset(-1, -3),
    }, item.Frame)
    addGrad(chip)
    element.drawings["keybind_border"] = make_drawing(chip)

    -- Text
    local text_inst = label(chip, {
        Text = keyNm(default_key) or "None",
        TextSize = 11,
        Color = colors.active_text,
        Position = Offset(0, 0),
        Size = Dim2(1, 0, 1, 1),
    })
    element.drawings["keybind_text"] = make_drawing(text_inst)

    -- Click area
    local click = new("TextButton", {
        Size = Dim2(1, 0, 1, Metrics.Row),
        BackgroundTransparency = 1,
        Position = Offset(-2, -4),
    }, item.Frame)
    element.drawings["keybind_click"] = make_drawing(click)

    -- Signal
    element.on_key_change = new_signal()

    local listening = false

    function element:set_key(key)
        if flag then flags[flag] = key end
        text_inst.Text = keyNm(key) or "None"
        if element.on_key_change then element.on_key_change:Fire(key) end
    end

    local function start_listening()
        if listening then return end
        listening = true
        text_inst.Text = "Press..."
        text_inst.Color = colors.accent
        local function handler(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                element:set_key(input.KeyCode)
                listening = false
                text_inst.Color = colors.active_text
                win.Root.InputBegan:Disconnect(handler)
            end
        end
        win.Root.InputBegan:Connect(handler)
    end

    click.MouseButton1Click:Connect(function()
        if listening then
            listening = false
            text_inst.Color = colors.active_text
        else
            start_listening()
        end
    end)

    if flag and flags[flag] == nil then
        flags[flag] = default_key
    end
end

-- Textbox
local function create_textbox(element, item, spec, control_x)
    local flag = spec["flag"]
    local default_val = spec["default"] or ""

    -- Input frame
    local input = new("Frame", {
        Size = Dim2(1, 0, 0, Metrics.InputH),
        Radius = Metrics.Radius,
        BackgroundColor3 = colors.section,
        BorderTransparency = 0,
        Position = Offset(-1, -1),
    }, item.Frame)
    addGrad(input)
    element.drawings["textbox_border"] = make_drawing(input)

    -- TextBox
    local box = new("TextBox", {
        Text = default_val,
        TextSize = 12,
        Color = colors.active_text,
        Position = Offset(6, 0),
        Size = Dim2(1, 0, -12, 1),
    }, input)
    element.drawings["textbox_text"] = make_drawing(box)

    -- Signal
    element.on_textbox_change = new_signal()

    function element:set_textbox(value)
        if flag then flags[flag] = value end
        box.Text = value
        if element.on_textbox_change then element.on_textbox_change:Fire(value) end
    end

    box.FocusLost:Connect(function()
        if flag then flags[flag] = box.Text end
    end)

    if flag and flags[flag] == nil then
        flags[flag] = default_val
    end
end

-- Button
local function create_button(element, item, spec, control_x)
    local confirmation = spec["confirmation"]

    -- Button frame
    local btn = new("TextButton", {
        Size = Dim2(1, -2, 0, Metrics.ButtonH - 2),
        Radius = Metrics.Radius,
        BackgroundColor3 = colors.section,
        BorderTransparency = 0,
        Position = Offset(1, 1),
    }, item.Frame)
    addGrad(btn)
    element.drawings["button_border"] = make_drawing(btn)

    -- Button text
    local text_inst = label(btn, {
        Text = element.name,
        TextSize = 13,
        Color = colors.active_text,
    })
    element.drawings["button_text"] = make_drawing(text_inst)

    -- Signal
    element.on_clicked = new_signal()

    btn.MouseButton1Click:Connect(function()
        if confirmation then
            -- Simple confirmation: toggle text
            if btn:GetAttribute("Confirming") then
                btn:SetAttribute("Confirming", nil)
                text_inst.Text = element.name
                text_inst.Color = colors.active_text
            else
                btn:SetAttribute("Confirming", true)
                text_inst.Text = "Confirm?"
                text_inst.Color = colors.accent
            end
            return
        end
        if element.on_clicked then element.on_clicked:Fire() end
    end)
end

-- Info
local function create_info(element, item, spec, control_x)
    local text_inst = label(item.Frame, {
        Text = "",
        TextSize = 11,
        Color = colors.inactive_text,
        Position = Offset(-1, -3),
        Size = Dim2(1, 0, 1, 1),
    })
    element.drawings["info_text"] = make_drawing(text_inst)

    function element:set_info(key, value)
        if key == "Text" then
            text_inst.Text = tostring(value)
        end
    end
end

-- ---------------------------------------------------------------------------
-- Settings section (for gear)
-- ---------------------------------------------------------------------------
local function create_settings_section(blossom_section, parent_element, count)
    local settings = { sections = {} }
    for i = 1, count do
        -- Create a new Blossom section in the same tab for settings
        local settings_blossom = blossom_section.Tab:Section({
            Name = (parent_element.name or "settings") .. "_settings_" .. i,
            Side = blossom_section.Column and 1 or 1,
            Collapsed = true,
        })
        local settings_section = wrap_section(settings_blossom, blossom_section.Window and {} or {}, settings_blossom.Tab, (parent_element.name or "settings") .. "_settings_" .. i, 1)
        settings.sections[i] = settings_section
    end
    return settings
end

-- ---------------------------------------------------------------------------
-- Group / Tab creation
-- ---------------------------------------------------------------------------
local function create_group(name)
    local category = win:Category(name)
    local group = {
        _category = category,
        name = name,
        ordered_tabs = {},
        frame = make_drawing(category.Root),
    }

    function group:create_tab(tab_name)
        local tab = win:Tab({ Name = tab_name, Icon = "circle" })
        local tab_obj = {
            _tab = tab,
            name = tab_name,
            frame = make_drawing(tab.Page),
            ordered_tabs = {},
        }
        group.ordered_tabs[#group.ordered_tabs + 1] = tab_obj
        return tab_obj
    end

    function group:create_section(tab_name, name, side, size, offset)
        -- Find the tab by name
        local tab_obj = nil
        for _, t in ipairs(group.ordered_tabs) do
            if t.name == tab_name then tab_obj = t end
        end
        if not tab_obj then return nil end

        local blossom_section = tab_obj._tab:Section({
            Name = name,
            Side = side or 1,
        })
        local section = wrap_section(blossom_section, group, tab_obj, name, side)
        return section
    end

    menu["groups"][#menu["groups"] + 1] = group
    menu["ordered_groups"][#menu["ordered_groups"] + 1] = group
    return group
end

-- ---------------------------------------------------------------------------
-- Menu functions
-- ---------------------------------------------------------------------------

menu["create_group"] = function(name)
    return create_group(name)
end

menu["toggle_menu"] = function()
    win:Toggle()
end

menu["is_menu_open"] = function()
    return win.Visible == true
end

menu["get_frame"] = function()
    return win.Root, win.Holder
end

menu["set_logo"] = function(data)
    -- No-op: logo was removed from chain.lua
end

menu["set_accent_color"] = function(color)
    win:SetThemeColor("Accent", color)
    update_colors()
end

menu["get_theme_list"] = function()
    local list = {}
    for name in pairs(Themes) do
        list[#list + 1] = name
    end
    table.sort(list)
    return list
end

menu["new_notification"] = function(text, typ, duration)
    win:Notify({
        Text = tostring(text),
        Type = typ or "Success",
        Duration = duration or 3,
    })
end

menu["is_typing"] = function()
    return false
end

menu["is_binding"] = function()
    return false
end

menu["close_context"] = function()
    win:ClosePopup()
end

menu["on_open_context"] = function()
    -- No-op hook
end

menu["add_right_click"] = function(handle, object, callback)
    if not handle or not object then return end
    local conn
    conn = object.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            callback(input)
        end
    end)
    return conn
end

menu["add_click"] = function(handle, object, callback)
    if not handle or not object then return end
    return object.MouseButton1Click:Connect(callback)
end

menu["add_hover"] = function(handle, object, enter, leave)
    if not handle or not object then return end
    object.MouseEntered:Connect(enter)
    object.MouseLeaved:Connect(leave)
end

menu["add_scroll"] = function(handle, object, callback)
    if not handle or not object then return end
    if object:IsA("ScrollingFrame") then
        return object.CanvasChanged:Connect(callback)
    end
end

menu["create_bind_entry"] = function(name, kind)
    local data = {
        method = 1,
        original_value = false,
        value = false,
        activated = false,
        type = kind or 3,
        element = { name = tostring(name) },
    }
    local drawings = {}
    return data, drawings
end

menu["get_bind_drawings"] = function(data)
    return {}
end

menu["show_bind"] = function(data)
    -- No-op: Blossom handles keybind UI internally
end

menu["hide_bind"] = function(data)
    -- No-op
end

menu["get_tab_name"] = function()
    if win.CurrentTab then return win.CurrentTab.Name end
    return nil
end

menu["remove_section_from_layout"] = function(section)
    if section and section._blossom then
        section._blossom.Collapsed = true
        section._blossom:SetCollapsed(true, false)
    end
end

menu["update_layout"] = function()
    for _, section in pairs(sections_by_name) do
        if section._blossom then
            section._blossom:Layout(false)
        end
    end
end

-- ---------------------------------------------------------------------------
-- Config save/load
-- ---------------------------------------------------------------------------
local CONFIG_DIR = (getgenv().custom_folder or "juju recode") .. "/chain_configs"

menu["save_config"] = function(name, data)
    local ok = pcall(function()
        if not isfolder(CONFIG_DIR) then makefolder(CONFIG_DIR) end
        local path = CONFIG_DIR .. "/" .. tostring(name) .. ".json"
        writefile(path, HTTPService:JSONEncode(data))
    end)
    return ok
end

menu["load_config"] = function(name)
    local data = nil
    pcall(function()
        local path = CONFIG_DIR .. "/" .. tostring(name) .. ".json"
        if isfile(path) then
            data = HTTPService:JSONDecode(readfile(path))
        end
    end)
    if type(data) == "table" then
        -- Apply flags from config
        for key, value in pairs(data["flags"] or {}) do
            flags[key] = value
        end
        menu["autoload"] = data["autoload"]
        menu["theme"] = data["theme"] or menu["theme"]
    end
    return data
end

menu["get_config_data"] = function()
    local data = {
        flags = {},
        autoload = menu["autoload"],
        theme = menu["theme"],
        favorites = menu["favorites"],
    }
    for key, value in pairs(flags) do
        data.flags[key] = value
    end
    return data
end

menu["get_config_list"] = function()
    local list = {}
    pcall(function()
        if isfolder(CONFIG_DIR) then
            for _, file in ipairs(list_files(CONFIG_DIR)) do
                if file:match("%.json$") then
                    list[#list + 1] = file:gsub("%.json$", "")
                end
            end
        end
    end)
    return list
end

-- ---------------------------------------------------------------------------
-- Theme application
-- ---------------------------------------------------------------------------
menu["apply_theme"] = function(name)
    if Themes[name] then
        win:ApplyTheme(name, true)
        menu["theme"] = name
        update_colors()
    end
end

-- ---------------------------------------------------------------------------
-- Element visibility
-- ---------------------------------------------------------------------------
local function set_element_visible(element, visible)
    element.visible = visible
    if element._item then
        element._item.Visible = visible
        element._item.Frame.Visible = visible
    end
end

-- Patch element methods to include set_visible
local orig_create_element = create_element
function create_element(blossom_section, section, spec, elements, is_note)
    local element = orig_create_element(blossom_section, section, spec, elements, is_note)
    function element:set_visible(visible)
        set_element_visible(element, visible)
    end
    function element:set_info(key, value)
        if element.drawings and element.drawings["info_text"] then
            if key == "Text" then
                element.drawings["info_text"]._instance.Text = tostring(value)
            end
        elseif element.drawings and element.drawings["text"] then
            if key == "Text" then
                element.drawings["text"]._instance.Text = tostring(value)
            end
        end
    end
    function element:set_options(options)
        -- Find dropdown and update
        if element.drawings and element.drawings["dropdown_border"] then
            -- Dropdown options update handled internally
        end
    end
    function element:remove()
        if element._item then
            element._item.Frame:Destroy()
            local idx = table.find(section.elements, element)
            if idx then table.remove(section.elements, idx) end
        end
    end
    return element
end

-- ---------------------------------------------------------------------------
-- Return
-- ---------------------------------------------------------------------------
return {
    menu = menu,
    flags = flags,
    create_connection = create_connection,
    round = round,
    tween = tween,
    drawing_proxy = drawing_proxy,
}

end)(Blossom)

return _component
