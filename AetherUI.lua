getgenv().aether = {
    options = {
        intro = false,
        unlock_fps = {
            enabled = false,
            value = 999
        },
        notification = {
            enabled = false,
            color = Color3.fromRGB(244, 244, 244),
            duration = 2.5
        },
        lowgfx = false,
        mute_boombox = false
    },
    panic = {
        enabled = false,
        keybind = "n"
    },
    silent_aim = {
        enabled = false,
        notify_on_target = false,
        auto_select = false,
        anti_aim_viewer = false,
        manipulation = false,
        target_hud = false,
        part = {
            value = "Head",
            type = "Custom", -- Custom, Closest Part, Closest Point
        },
        prediction = {
            enabled = false,

            x = 0,
            y = 0,
        },
        visualisation = {
            tracer = {
                visible = false,
                color = Color3.fromRGB(255,255,255),
                thickness = 1.4,
                outline = false,
                Position = "Mouse", -- Mouse, Barrel
            },
            circle = {
                visible = false,
                color = Color3.fromRGB(255,255,255),
            },
        },
    },
    aim_assist = {
        enabled = false,
        notify_on_target = false,
        method = "Camera", -- Camera, Mouse
        keybind = "mb2",
        keybind_type = "hold",
        part = {
            value = "Head",
            type = "Custom", -- Custom, Closest Part, Closest Point
        },
        prediction = {
            enabled = false,
            x = 0,
            y = 0,
        },
        smoothness = {
            enabled = false,
            x = 0.035,
            y = 0.035,
            easing_style = "Linear",
            easing_direction = "InOut", 
        },
        shake = {
            enabled = false,
            x = 5,
            y = 5,
            z = 5
        }
    },
    trigger_bot = {
        enabled = false,
        delay = 0.01,
        method = "Tool Activation",

        hitbox = {
            visualise = {
                enabled = false,
                locked_on_color = Color3.fromRGB(255, 255, 255),
                not_locked_on_color = Color3.fromRGB(255, 0, 0),
            },
            size_x = 1.11,
            size_y = 1.9
        },

        whitelist = {
            enabled = false,
            player_list = {"spadeuw"}
        }
    },
    checks = {
        team_check = false,
        grabbed_check = false,
        knocked_check = false,
        crew_check = false,
        health_check = false,
        visible_check = false,
        friend_check = false,
        forcefield_check = false,
        range_check = false,
        range = 500
    },
    field_of_view = {
        silent_aim = {
            visible = false,
            outline = false,
            color = Color3.fromRGB(255, 255, 255),
            radius = 100,
            sides = 60,
            thickness = 1.5
        },
        aim_assist = {
            radius = 999
        }
    },
    world = {
        texture_changer = {
            enabled = false,
            color = Color3.fromRGB(1,1,1),
            material = "Brick"
        },
    },
    macro = {
        enabled = false,
        keybind = "c"
    },
    movement = {
        walk_speed = {
            enabled = false,
            keybind = "c",
            speed = 100
        },
        jump_power = {
            enabled = false,
            keybind = "c",
            amount = 100
        }
    }
}

if getgenv().loaded then
   return
end

getgenv().loaded = true

if (not LPH_OBFUSCATED) then
    LPH_NO_VIRTUALIZE = function(...) return (...) end;
    LPH_JIT_MAX = function(...) return (...) end;
    LPH_JIT_ULTRA = function(...) return (...) end;
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/refs/heads/main/Source.lua"))()

local circle_drawing_lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/sonic-x64/aether/refs/heads/main/circle_drawing.lua"))()

-- variables
local uis = cloneref(game:GetService("UserInputService"))
local players = cloneref(game:GetService("Players"))
local ws = cloneref(game:GetService("Workspace"))
local http_service = cloneref(game:GetService("HttpService"))
local gui_service = cloneref(game:GetService("GuiService"))
local lighting = cloneref(game:GetService("Lighting"))
local run = cloneref(game:GetService("RunService"))
local stats = cloneref(game:GetService("Stats"))
local coregui = cloneref(game:GetService("CoreGui"))
local debris = cloneref(game:GetService("Debris"))
local tween_service = cloneref(game:GetService("TweenService"))
local sound_service = cloneref(game:GetService("SoundService"))
local starter_gui = cloneref(game:GetService("StarterGui"))
local rs = cloneref(game:GetService("ReplicatedStorage"))

local vec2 = Vector2.new
local vec3 = Vector3.new
local dim2 = UDim2.new
local dim = UDim.new 
local rect = Rect.new
local cfr = CFrame.new
local empty_cfr = cfr()
local point_object_space = empty_cfr.PointToObjectSpace
local angle = CFrame.Angles
local dim_offset = UDim2.fromOffset

local color = Color3.new
local hsv = Color3.fromHSV
local rgb = Color3.fromRGB
local hex = Color3.fromHex
local rgbseq = ColorSequence.new
local rgbkey = ColorSequenceKeypoint.new
local numseq = NumberSequence.new
local numkey = NumberSequenceKeypoint.new

local camera = ws.CurrentCamera
local lp = players.LocalPlayer 
local mouse = lp:GetMouse() 
local gui_offset = gui_service:GetGuiInset().Y

local max = math.max 
local floor = math.floor 
local min = math.min 
local abs = math.abs 
local noise = math.noise
local rad = math.rad 
local random = math.random 
local pow = math.pow 
local sin = math.sin 
local pi = math.pi 
local tan = math.tan 
local atan2 = math.atan2 
local cos = math.cos 
local round = math.round;
local clamp = math.clamp; 
local ceil = math.ceil; 
local sqrt = math.sqrt;
local acos = math.acos; 

local insert = table.insert 
local find = table.find 
local remove = table.remove
local concat = table.concat
-- 

local funcs = {}
local cache = {}
local esp_cache = {}
local hitpoints = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso", "LeftUpperArm", "LeftLowerArm", "LeftHand", "RightUpperArm", "RightLowerArm", "RightHand", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot", "RightUpperLeg", "RightLowerLeg", "RightFoot"}
cache.last_trigger_time = 0
cache.last_refresh = 0
cache.last_esp_refresh = 0
cache.lines_visible = false
cache.menu_opened = true
cache.triggerbot_active = false
cache.indicator_reset = false 
cache.desync_active = false
cache.desync_attach_to_target_active = false
local is_manipulated = false
local offset = 2
local font_size = 12
local font_size_indicator = 12
local font_indicator = nil
local accent_color = Color3.fromRGB(96, 120, 190)
local vec2 = Vector2.new
local vec3 = Vector3.new
local cframe = CFrame.new
local function create_esp() end
local entities = game:GetService("Players")
local local_entity = entities.LocalPlayer
local mouse = local_entity:GetMouse()
local camera = workspace.CurrentCamera
local run_service = game:GetService("RunService")
local replicatedstorage = game:GetService("ReplicatedStorage")
local uis = game:GetService("UserInputService")
local core_gui = game:GetService("CoreGui")
local original_shoot_sounds = {}
local original_shoot_volume = {}

local screen_gui = Instance.new("ScreenGui")
screen_gui.Parent = core_gui

local screen_gui_indicator = Instance.new("ScreenGui")
screen_gui_indicator.Parent = core_gui
screen_gui_indicator.IgnoreGuiInset = true

local indicators_ammo = Instance.new("TextLabel", screen_gui_indicator)
indicators_ammo.Size = UDim2.new(0, 100, 0, 20)
indicators_ammo.BackgroundTransparency = 1
indicators_ammo.TextColor3 = Color3.fromRGB(255, 255, 255)
indicators_ammo.Text = ""
indicators_ammo.Name = "ammoooo"
indicators_ammo.TextSize = 12
indicators_ammo.TextScaled = false
indicators_ammo.AnchorPoint = Vector2.new(0.5, 0)
indicators_ammo.TextXAlignment = Enum.TextXAlignment.Center 

local indicators_ammo_outline = Instance.new("UIStroke", indicators_ammo)
indicators_ammo_outline.Color = Color3.fromRGB(0, 0, 0)
indicators_ammo_outline.Thickness = 1

local hit_sounds = {
    ['Minecraft Hit'] = "4018616850",
    ["Bameware"] = "3124331820",
    ["Skeet"] = "4753603610",
    ["Bonk"] = "3765689841",
    ["Lazer Beam"] = "130791043",
    ["HitMarker"] = "8543972310",
    ["Windows XP Error"] = "160715357",
    ["TF2 Hitsound"] = "3455144981",
    ["TF2 Critical"] = "296102734",
    ["BitchBot"] = "5709456554",
    ["BitchBot Head"] = "5043539486",
    ["BitchBot Body"] = "3744371342",
    ["Csgo"] = "7269900245",
    ["TF2 Bat"] = "3333907347",
    ['Bow Hit'] = "1053296915",
    ['Bow'] = "3442683707",
    ['OSU'] = "7147454322",
    ['Steve'] = "5869422451",
    ['1nn'] = "7349055654",
    ['Rust'] = "3744371091",
    ["TF2 Pan"] = "3431749479",
    ["Neverlose"] = "8679627751",
    ["Mario"] = "5709456554",
}

local animations = {
    ["Yungblud Jump"] = "rbxassetid://15609995579",
    ["Rthro Run"] = "rbxassetid://10921261968",
    ["Punching"] = "rbxassetid://10717116749",
    ["Adidas Fall"] = "rbxassetid://18537367238",
    ["Adidas Run"] = "rbxassetid://140296101132217",
    ["Godmode"] = "rbxassetid://94067170508495",
    ["Old Town Road"] = "rbxassetid://10714391240",
    ["Floss"] = "rbxassetid://10714340543",
    ["TMNT"] = "rbxassetid://18665811005",
    ["Wake Up Call"] = "rbxassetid://10714168145",
    ["Fashion Roadkill"] = "rbxassetid://136831243854748",
    ["Left N Right"] = "rbxassetid://80995190624232",
    ["Side To Side"] = "rbxassetid://10714366910",
    ["It Ain't My Fault"] = "rbxassetid://10714374267"
}
local animationid = animations["Yungblud Jump"]
local danceTrack

local aura_module = {}
local aura_enabled = false
local auraColors = {
ColorSequenceKeypoint.new(0, Color3.fromRGB(96, 120, 190)),
ColorSequenceKeypoint.new(0.499, Color3.fromRGB(112, 138, 219)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(54, 94, 217)),
}
local auraTypes = {}
local attachments = {}
local particles = {}
local charConnection

local function clearAll()
	for _, att in ipairs(attachments) do
		if att and att.Parent then
			att:Destroy()
		end
	end
	attachments = {}
	particles = {}
end

local function updateColors()
  for _, p in ipairs(particles) do
    if p and p.Parent then
    p.Color = ColorSequence.new(auraColors)
    end
  end
end

                local function createAngelic()
                    local character = local_entity.Character

                    if not character then
                        return
                    end

                    local torso = character:FindFirstChild('Torso') or character:FindFirstChild('UpperTorso')

                    if not torso then
                        return
                    end

                    local attachment1 = Instance.new('Attachment')

                    attachment1.CFrame = CFrame.new(-1.012, 0.5, 0.852, 0.966, 0, 0.259, 0, 1, 0, 
-0.259, 0, 0.966)
                    attachment1.Parent = torso

                    table.insert(attachments, attachment1)

                    local emitter1 = Instance.new('ParticleEmitter')

                    emitter1.Lifetime = NumberRange.new(1, 1)
                    emitter1.LockedToPart = true
                    emitter1.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0.944),
                        NumberSequenceKeypoint.new(0.2, 0),
                        NumberSequenceKeypoint.new(0.8, 0),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    emitter1.LightEmission = 1
                    emitter1.Color = ColorSequence.new(auraColors)
                    emitter1.Speed = NumberRange.new(0.05, 0.05)
                    emitter1.Size = NumberSequence.new(2.75, 3.5)
                    emitter1.Rate = 4
                    emitter1.Texture = 'http://www.roblox.com/asset/?id=13267054240'
                    emitter1.EmissionDirection = Enum.NormalId.Back
                    emitter1.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
                    emitter1.Rotation = NumberRange.new(-15, -15)
                    emitter1.Parent = attachment1

                    table.insert(particles, emitter1)

                    local attachment2 = Instance.new('Attachment')

                    attachment2.CFrame = CFrame.new(1.167, 0.5, 0.852, 0.966, 0, 
-0.259, 0, 1, 0, 0.259, 0, 0.966)
                    attachment2.Parent = torso

                    table.insert(attachments, attachment2)

                    local emitter2 = Instance.new('ParticleEmitter')

                    emitter2.Lifetime = NumberRange.new(1, 1)
                    emitter2.LockedToPart = true
                    emitter2.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0.944),
                        NumberSequenceKeypoint.new(0.2, 0),
                        NumberSequenceKeypoint.new(0.8, 0),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    emitter2.LightEmission = 1
                    emitter2.Color = ColorSequence.new(auraColors)
                    emitter2.Speed = NumberRange.new(0.05, 0.05)
                    emitter2.Size = NumberSequence.new(2.75, 3.5)
                    emitter2.Rate = 4
                    emitter2.Texture = 'http://www.roblox.com/asset/?id=13267054240'
                    emitter2.EmissionDirection = Enum.NormalId.Front
                    emitter2.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
                    emitter2.Rotation = NumberRange.new(-15, -15)
                    emitter2.Parent = attachment2

                    table.insert(particles, emitter2)

                    local attachment3 = Instance.new('Attachment')

                    attachment3.CFrame = CFrame.new(0, 0.3, 0)
                    attachment3.Parent = torso

                    table.insert(attachments, attachment3)

                    local emitter3 = Instance.new('ParticleEmitter')

                    emitter3.Lifetime = NumberRange.new(2, 2)
                    emitter3.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
                    emitter3.SpreadAngle = Vector2.new(180, 180)
                    emitter3.LockedToPart = true
                    emitter3.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.5, 0.3),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    emitter3.LightEmission = 1
                    emitter3.Color = ColorSequence.new(auraColors)
                    emitter3.VelocitySpread = 180
                    emitter3.Speed = NumberRange.new(0.5, 0.5)
                    emitter3.Brightness = 2
                    emitter3.Size = NumberSequence.new(3, 4)
                    emitter3.Rate = 5
                    emitter3.Texture = 'rbxassetid://11402221943'
                    emitter3.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
                    emitter3.Rotation = NumberRange.new(0, 360)
                    emitter3.Parent = attachment3

                    table.insert(particles, emitter3)
                end

                local function createAmbient()
                    local character = local_entity.Character

                    if not character then
                        return
                    end

                    local hrp = character:FindFirstChild('HumanoidRootPart')

                    if not hrp then
                        return
                    end

                    local attachment = Instance.new('Attachment')

                    attachment.CFrame = CFrame.new(0, -2.75, 0)
                    attachment.Parent = hrp

                    table.insert(attachments, attachment)

                    local emitter1 = Instance.new('ParticleEmitter')

                    emitter1.Lifetime = NumberRange.new(2, 2)
                    emitter1.SpreadAngle = Vector2.new(0.001, 0.001)
                    emitter1.LockedToPart = true
                    emitter1.Transparency = NumberSequence.new(0, 1)
                    emitter1.LightEmission = 1
                    emitter1.Color = ColorSequence.new(auraColors)
                    emitter1.VelocitySpread = 0.001
                    emitter1.Squash = NumberSequence.new(0)
                    emitter1.Speed = NumberRange.new(0.001, 0.001)
                    emitter1.Brightness = 2
                    emitter1.Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(0.3, 1),
                        NumberSequenceKeypoint.new(0.6, 2.5),
                        NumberSequenceKeypoint.new(0.8, 4),
                        NumberSequenceKeypoint.new(1, 6),
                    })
                    emitter1.RotSpeed = NumberRange.new(-600, 600)
                    emitter1.Texture = 
[[https://assetgame.roblox.com/asset/?id=12713358087&assetName=crescent]]
                    emitter1.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
                    emitter1.Rotation = NumberRange.new(0, 360)
                    emitter1.Parent = attachment

                    table.insert(particles, emitter1)

                    local emitter2 = Instance.new('ParticleEmitter')

                    emitter2.Lifetime = NumberRange.new(2, 2)
                    emitter2.SpreadAngle = Vector2.new(0.001, 0.001)
                    emitter2.LockedToPart = true
                    emitter2.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(0.6, 0.2),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    emitter2.LightEmission = 1
                    emitter2.Color = ColorSequence.new(auraColors)
                    emitter2.VelocitySpread = 0.001
                    emitter2.Squash = NumberSequence.new(0, 2)
                    emitter2.Speed = NumberRange.new(0.001, 0.001)
                    emitter2.Brightness = 2
                    emitter2.Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(0.3, 1),
                        NumberSequenceKeypoint.new(0.6, 2.5),
                        NumberSequenceKeypoint.new(0.8, 4),
                        NumberSequenceKeypoint.new(1, 6),
                    })
                    emitter2.RotSpeed = NumberRange.new(-30, 30)
                    emitter2.Texture = 'rbxassetid://7216849325'
                    emitter2.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
                    emitter2.Rotation = NumberRange.new(0, 360)
                    emitter2.Parent = attachment

                    table.insert(particles, emitter2)

                    local emitter3 = Instance.new('ParticleEmitter')

                    emitter3.Lifetime = NumberRange.new(2, 2)
                    emitter3.SpreadAngle = Vector2.new(0.001, 0.001)
                    emitter3.LockedToPart = true
                    emitter3.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.2, 0.3),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    emitter3.LightEmission = 1
                    emitter3.Color = ColorSequence.new(auraColors)
                    emitter3.VelocitySpread = 0.001
                    emitter3.Squash = NumberSequence.new(0)
                    emitter3.Speed = NumberRange.new(0.001, 0.001)
                    emitter3.Brightness = 2
                    emitter3.Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(0.3, 2),
                        NumberSequenceKeypoint.new(0.6, 5),
                        NumberSequenceKeypoint.new(0.8, 8),
                        NumberSequenceKeypoint.new(1, 12),
                    })
                    emitter3.RotSpeed = NumberRange.new(-40, 40)
                    emitter3.Texture = 'rbxassetid://7216855136'
                    emitter3.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
                    emitter3.Rotation = NumberRange.new(0, 360)
                    emitter3.Parent = attachment

                    table.insert(particles, emitter3)
                end

                local function createNimb()
                    local character = local_entity.Character

                    if not character then
                        return
                    end

                    local head = character:FindFirstChild('Head')

                    if not head then
                        return
                    end

                    local attachment = Instance.new('Attachment')

                    attachment.CFrame = CFrame.new(-0.25, 0.933, 0.259, 0.469, -0.25, 
-0.847, -0.117, 0.933, -0.34, 0.875, 0.259, 0.408)
                    attachment.Parent = head

                    table.insert(attachments, attachment)

                    local emitter1 = Instance.new('ParticleEmitter')

                    emitter1.Lifetime = NumberRange.new(1, 1)
                    emitter1.SpreadAngle = Vector2.new(5, 5)
                    emitter1.LockedToPart = true
                    emitter1.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.2, 0),
                        NumberSequenceKeypoint.new(0.8, 0),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    emitter1.LightEmission = 1
                    emitter1.Color = ColorSequence.new(auraColors)
                    emitter1.VelocitySpread = 5
                    emitter1.Speed = NumberRange.new(0.001, 0.001)
                    emitter1.Brightness = 2
                    emitter1.Size = NumberSequence.new(2.5, 3)
                    emitter1.RotSpeed = NumberRange.new(-400, 400)
                    emitter1.Rate = 7
                    emitter1.Texture = 'rbxassetid://8819682608'
                    emitter1.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
                    emitter1.Rotation = NumberRange.new(0, 360)
                    emitter1.Parent = attachment

                    table.insert(particles, emitter1)

                    local emitter2 = Instance.new('ParticleEmitter')

                    emitter2.Lifetime = NumberRange.new(1, 1)
                    emitter2.SpreadAngle = Vector2.new(5, 5)
                    emitter2.LockedToPart = true
                    emitter2.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.2, 0),
                        NumberSequenceKeypoint.new(0.8, 0),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    emitter2.LightEmission = 1
                    emitter2.Color = ColorSequence.new(auraColors)
                    emitter2.VelocitySpread = 5
                    emitter2.Speed = NumberRange.new(0.001, 0.001)
                    emitter2.Brightness = 2
                    emitter2.Size = NumberSequence.new(2, 3)
                    emitter2.RotSpeed = NumberRange.new(-400, 400)
                    emitter2.Rate = 7
                    emitter2.Texture = 'rbxassetid://8819682608'
                    emitter2.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
                    emitter2.Rotation = NumberRange.new(0, 360)
                    emitter2.Parent = attachment

                    table.insert(particles, emitter2)
                end
                local function createTornado()
                    local character = local_entity.Character

                    if not character then
                        return
                    end

                    local hrp = character:FindFirstChild('HumanoidRootPart')

                    if not hrp then
                        return
                    end

                    local attachment = Instance.new('Attachment')

                    attachment.CFrame = CFrame.new(0, -3, 0)
                    attachment.Parent = hrp

                    table.insert(attachments, attachment)

                    local emitter = Instance.new('ParticleEmitter')

                    emitter.LightInfluence = 1
                    emitter.LockedToPart = true
                    emitter.LightEmission = 1
                    emitter.Color = ColorSequence.new(auraColors)
                    emitter.Speed = NumberRange.new(0.01, 0.01)
                    emitter.Size = NumberSequence.new(6, 10)
                    emitter.RotSpeed = NumberRange.new(360, 360)
                    emitter.Rate = 1
                    emitter.Texture = 'http://www.roblox.com/asset/?id=8553497052'
                    emitter.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
                    emitter.Parent = attachment

                    table.insert(particles, emitter)
                end

local function refreshAuras()
	clearAll()
	if not aura_enabled then return end

	if auraTypes.Angelic then createAngelic() end
	if auraTypes.Ambient then createAmbient() end
	if auraTypes.Nimb then createNimb() end
	if auraTypes.Tornado then createTornado() end
end

local function onCharacterAdded()
	if aura_enabled then
		task.wait(0.5)
		refreshAuras()
	end
end

function aura_module.setEnabled(val)
	aura_enabled = val

	if val then
		if not charConnection then
			charConnection = local_entity.CharacterAdded:Connect(onCharacterAdded)
		end
		if local_entity.Character then
			task.delay(0.5, refreshAuras)
		end
	else
		if charConnection then
			charConnection:Disconnect()
			charConnection = nil
		end
		clearAll()
	end
end

function aura_module.setAuraTypes(types)
	auraTypes = {}
	for _, t in ipairs(types or {}) do
		auraTypes[t] = true
	end
	refreshAuras()
end

function aura_module.setAuraColor(index, color)
    auraColors[index] = ColorSequenceKeypoint.new(
      auraColors[index].Time,
      color
    )
  updateColors()
end

local hit_effect_module = {}

local effectTemplates = {}
local templatesCreated = false

local effectColor = Color3.fromRGB(255, 255, 255)
local selectedEffects = {}
local activeEmitters = {} 

local effectLifetime = 1 

local function createEffectTemplates()
	if templatesCreated then return end
	templatesCreated = true

                    local particleAttachment = Instance.new('Attachment')
                    local dots1 = Instance.new('ParticleEmitter')

                    dots1.Name = 'Dots 1'
                    dots1.LightEmission = 1
                    dots1.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
                    dots1.LockedToPart = false
                    dots1.ZOffset = 10
                    dots1.Texture = 'rbxassetid://7216849075'
                    dots1.VelocitySpread = 360
                    dots1.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(1, 0.663),
                    })
                    dots1.Lifetime = NumberRange.new(1, 5)
                    dots1.Speed = NumberRange.new(1, 210)
                    dots1.SpreadAngle = Vector2.new(360, -360)
                    dots1.Rate = 60
                    dots1.Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0.1),
                        NumberSequenceKeypoint.new(0.428, 0),
                        NumberSequenceKeypoint.new(1, 0.627),
                    })
                    dots1.Enabled = false
                    dots1.Parent = particleAttachment

                    local dots2 = Instance.new('ParticleEmitter')

                    dots2.Name = 'Dots 2'
                    dots2.LightEmission = 1
                    dots2.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
                    dots2.LockedToPart = false
                    dots2.ZOffset = 10
                    dots2.Texture = 'rbxassetid://7216849075'
                    dots2.VelocitySpread = 360
                    dots2.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(1, 0.663),
                    })
                    dots2.Lifetime = NumberRange.new(1, 5)
                    dots2.Speed = NumberRange.new(1, 210)
                    dots2.SpreadAngle = Vector2.new(360, -360)
                    dots2.Rate = 100
                    dots2.Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0.1),
                        NumberSequenceKeypoint.new(0.502, 1.438),
                        NumberSequenceKeypoint.new(0.925, 1.125),
                        NumberSequenceKeypoint.new(1, 0.397),
                    })
                    dots2.Enabled = false
                    dots2.Orientation = Enum.ParticleOrientation.FacingCamera
                    dots2.Parent = particleAttachment
                    effectTemplates['Particle'] = particleAttachment

                    local bloodAttachment = Instance.new('Attachment')
                    local blood02 = Instance.new('ParticleEmitter')

                    blood02.Name = 'Blood-02'
                    blood02.Lifetime = NumberRange.new(0.5, 0.75)
                    blood02.SpreadAngle = Vector2.new(90, 90)
                    blood02.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.125, 0.5),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    blood02.Color = ColorSequence.new(Color3.fromRGB(130, 0, 0))
                    blood02.VelocitySpread = 90
                    blood02.Speed = NumberRange.new(5, 10)
                    blood02.Size = NumberSequence.new(0.5, 2)
                    blood02.Acceleration = Vector3.new(0, -20, 0)
                    blood02.RotSpeed = NumberRange.new(-90, 90)
                    blood02.Rate = 250
                    blood02.Texture = 'rbxassetid://241576804'
                    blood02.Rotation = NumberRange.new(-360, 360)
                    blood02.Enabled = false
                    blood02.Parent = bloodAttachment

                    local blood01 = Instance.new('ParticleEmitter')

                    blood01.Name = 'Blood-01'
                    blood01.Lifetime = NumberRange.new(0.5, 0.5)
                    blood01.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
                    blood01.SpreadAngle = Vector2.new(10, 10)
                    blood01.LockedToPart = true
                    blood01.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.105985, 0),
                        NumberSequenceKeypoint.new(0.5024938, 0),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    blood01.Color = ColorSequence.new(Color3.fromRGB(130, 0, 0))
                    blood01.VelocitySpread = 10
                    blood01.Speed = NumberRange.new(0.01, 0.01)
                    blood01.ZOffset = 0.5
                    blood01.Size = NumberSequence.new(2.1875, 3.5625)
                    blood01.Rate = 10
                    blood01.Texture = 'rbxassetid://16668936898'
                    blood01.EmissionDirection = Enum.NormalId.Front
                    blood01.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
                    blood01.Rotation = NumberRange.new(-360, 360)
                    blood01.Enabled = false
                    blood01.Parent = bloodAttachment

                    local blood03 = Instance.new('ParticleEmitter')

                    blood03.Name = 'Blood-03'
                    blood03.LightInfluence = 1
                    blood03.Lifetime = NumberRange.new(0.25, 0.5)
                    blood03.SpreadAngle = Vector2.new(360, 360)
                    blood03.LockedToPart = true
                    blood03.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.25, 0),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    blood03.Color = ColorSequence.new(Color3.fromRGB(100, 0, 0))
                    blood03.VelocitySpread = 360
                    blood03.Squash = NumberSequence.new(0, -3)
                    blood03.Speed = NumberRange.new(15, 25)
                    blood03.Size = NumberSequence.new(0.125, 0.6874996)
                    blood03.Acceleration = Vector3.new(0, -75, 0)
                    blood03.Rate = 100
                    blood03.Texture = 'rbxassetid://4509687978'
                    blood03.Orientation = Enum.ParticleOrientation.VelocityParallel
                    blood03.Enabled = false
                    blood03.Parent = bloodAttachment

                    local blood05 = Instance.new('ParticleEmitter')

                    blood05.Name = 'Blood-05'
                    blood05.Lifetime = NumberRange.new(0.75, 0.75)
                    blood05.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
                    blood05.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.5037407, 0),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    blood05.Color = ColorSequence.new(Color3.fromRGB(130, 0, 0))
                    blood05.Speed = NumberRange.new(0.001, 0.001)
                    blood05.ZOffset = 4
                    blood05.Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0.25),
                        NumberSequenceKeypoint.new(0.3764706, 2.0625, 0.5763994),
                        NumberSequenceKeypoint.new(1, 2.6875, 0.125),
                    })
                    blood05.Rate = 5
                    blood05.Texture = 'rbxassetid://16664856199'
                    blood05.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
                    blood05.Rotation = NumberRange.new(-360, 360)
                    blood05.Enabled = false
                    blood05.Parent = bloodAttachment

                    local blood04 = Instance.new('ParticleEmitter')

                    blood04.Name = 'Blood-04'
                    blood04.LightInfluence = 1
                    blood04.Lifetime = NumberRange.new(0.25, 0.5)
                    blood04.SpreadAngle = Vector2.new(180, 180)
                    blood04.LockedToPart = true
                    blood04.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.25, 0),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    blood04.Color = ColorSequence.new(Color3.fromRGB(100, 0, 0))
                    blood04.VelocitySpread = 180
                    blood04.Squash = NumberSequence.new(0, -3)
                    blood04.Speed = NumberRange.new(29, 29)
                    blood04.Size = NumberSequence.new(0.125, 0.6874996)
                    blood04.Acceleration = Vector3.new(0, -45, 0)
                    blood04.Rate = 100
                    blood04.Texture = 'rbxassetid://4509687978'
                    blood04.Orientation = Enum.ParticleOrientation.VelocityParallel
                    blood04.Enabled = false
                    blood04.Parent = bloodAttachment
                    effectTemplates['Blood'] = bloodAttachment

                    local lightAttachment = Instance.new('Attachment')
                    local light1 = Instance.new('ParticleEmitter')

                    light1.LightInfluence = 1
                    light1.Lifetime = NumberRange.new(1, 1)
                    light1.LockedToPart = true
                    light1.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.2066596, 0),
                        NumberSequenceKeypoint.new(0.4947146, 0),
                        NumberSequenceKeypoint.new(0.7996829, 0),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    light1.LightEmission = 1
                    light1.Speed = NumberRange.new(0, 0)
                    light1.ZOffset = 4
                    light1.Size = NumberSequence.new(7.5)
                    light1.RotSpeed = NumberRange.new(100, 100)
                    light1.Rate = 1
                    light1.Texture = 'rbxassetid://271370648'
                    light1.Enabled = false
                    light1.Parent = lightAttachment

                    local light2 = Instance.new('ParticleEmitter')

                    light2.LightInfluence = 1
                    light2.Lifetime = NumberRange.new(1, 1)
                    light2.LockedToPart = true
                    light2.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.4947146, 0),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    light2.LightEmission = 1
                    light2.Speed = NumberRange.new(0, 0)
                    light2.ZOffset = 5
                    light2.Size = NumberSequence.new(7.5)
                    light2.Rate = 2
                    light2.Texture = 'rbxassetid://13275495915'
                    light2.Enabled = false
                    light2.Parent = lightAttachment

                    local light3 = Instance.new('ParticleEmitter')

                    light3.LightInfluence = 1
                    light3.Lifetime = NumberRange.new(1, 1)
                    light3.LockedToPart = true
                    light3.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(0.5042283, 0.49375),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    light3.LightEmission = 1
                    light3.Speed = NumberRange.new(0, 0)
                    light3.ZOffset = 5
                    light3.Size = NumberSequence.new(0, 7.4375)
                    light3.Rate = 3
                    light3.Texture = 'rbxassetid://15267994078'
                    light3.Rotation = NumberRange.new(-360, 360)
                    light3.Enabled = false
                    light3.Parent = lightAttachment
                    effectTemplates['Light'] = lightAttachment

                    local lightningAttachment = Instance.new('Attachment')
                    local startAttachment = Instance.new('Attachment')

                    startAttachment.Name = 'Start'
                    startAttachment.CFrame = CFrame.new(0, 20, 0)
                    startAttachment.Parent = lightningAttachment

                    local endAttachment = Instance.new('Attachment')

                    endAttachment.Name = 'End'
                    endAttachment.CFrame = CFrame.new(0, 0, 0)
                    endAttachment.Parent = lightningAttachment

                    local beam1 = Instance.new('Beam')

                    beam1.FaceCamera = true
                    beam1.ZOffset = 0.3
                    beam1.TextureSpeed = 1.5
                    beam1.Width1 = 5
                    beam1.Width0 = 2
                    beam1.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.0112219, 0),
                        NumberSequenceKeypoint.new(0.9912719, 0),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    beam1.TextureLength = 0.5
                    beam1.LightEmission = 1
                    beam1.Texture = 'rbxassetid://7216850022'
                    beam1.Attachment0 = startAttachment
                    beam1.Attachment1 = endAttachment
                    beam1.Parent = startAttachment

                    local beam2 = Instance.new('Beam')

                    beam2.FaceCamera = true
                    beam2.ZOffset = 0.3
                    beam2.TextureSpeed = 1.5
                    beam2.Width1 = 5
                    beam2.Width0 = 2
                    beam2.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.0112219, 0),
                        NumberSequenceKeypoint.new(0.9912719, 0),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    beam2.TextureLength = 0.5
                    beam2.LightEmission = 1
                    beam2.Texture = 'rbxassetid://7216850022'
                    beam2.Attachment0 = startAttachment
                    beam2.Attachment1 = endAttachment
                    beam2.Parent = startAttachment

                    local lightningOne = Instance.new('ParticleEmitter')

                    lightningOne.Name = 'Lightning One'
                    lightningOne.FlipbookFramerate = NumberRange.new(17, 17)
                    lightningOne.Lifetime = NumberRange.new(0.1, 1)
                    lightningOne.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
                    lightningOne.LockedToPart = true
                    lightningOne.Speed = NumberRange.new(0.01, 0.01)
                    lightningOne.Brightness = 15
                    lightningOne.ZOffset = 3
                    lightningOne.Size = NumberSequence.new(5)
                    lightningOne.Rate = 5
                    lightningOne.Texture = 'rbxassetid://14582813693'
                    lightningOne.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
                    lightningOne.Rotation = NumberRange.new(-360, 360)
                    lightningOne.Enabled = false
                    lightningOne.Parent = endAttachment

                    local lightningTwo = Instance.new('ParticleEmitter')

                    lightningTwo.Name = 'Lightning two'
                    lightningTwo.FlipbookFramerate = NumberRange.new(17, 17)
                    lightningTwo.Lifetime = NumberRange.new(0.1, 1)
                    lightningTwo.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
                    lightningTwo.LockedToPart = true
                    lightningTwo.Speed = NumberRange.new(0.01, 0.01)
                    lightningTwo.Brightness = 15
                    lightningTwo.ZOffset = 3
                    lightningTwo.Size = NumberSequence.new(5)
                    lightningTwo.Rate = 5
                    lightningTwo.Texture = 'rbxassetid://14582813693'
                    lightningTwo.Orientation = Enum.ParticleOrientation.VelocityParallel
                    lightningTwo.Rotation = NumberRange.new(-360, 360)
                    lightningTwo.Enabled = false
                    lightningTwo.Parent = endAttachment

                    local glow = Instance.new('ParticleEmitter')

                    glow.Name = 'Glow'
                    glow.Lifetime = NumberRange.new(0.4, 0.4)
                    glow.SpreadAngle = Vector2.new(360, 360)
                    glow.Transparency = NumberSequence.new(0, 1)
                    glow.LightEmission = 1
                    glow.Drag = 15
                    glow.VelocitySpread = 360
                    glow.Speed = NumberRange.new(0.0099825, 0.0099825)
                    glow.Brightness = 5
                    glow.ZOffset = 4
                    glow.Size = NumberSequence.new(5)
                    glow.Rate = 2
                    glow.Texture = 'rbxassetid://13305806509'
                    glow.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
                    glow.Enabled = false
                    glow.Parent = endAttachment
                    effectTemplates['Lightning'] = lightningAttachment

                    local blackFlashAttachment = Instance.new('Attachment')
                    local pe2 = Instance.new('ParticleEmitter')

                    pe2.Name = '2'
                    pe2.LightInfluence = 0.2
                    pe2.Lifetime = NumberRange.new(0.1, 0.25)
                    pe2.SpreadAngle = Vector2.new(360, 360)
                    pe2.LockedToPart = true
                    pe2.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(0.037522, 0.291925),
                        NumberSequenceKeypoint.new(0.13103, 0.602484),
                        NumberSequenceKeypoint.new(0.259083, 0.78882),
                        NumberSequenceKeypoint.new(0.403812, 0.906832),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    pe2.LightEmission = 1
                    pe2.Color = ColorSequence.new(Color3.fromRGB(255, 17, 17))
                    pe2.VelocitySpread = 360
                    pe2.Speed = NumberRange.new(0.0135816, 0.0135816)
                    pe2.Brightness = 10
                    pe2.Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(0.064513, 5.37),
                        NumberSequenceKeypoint.new(0.236513, 11.31),
                        NumberSequenceKeypoint.new(0.586513, 15.7),
                        NumberSequenceKeypoint.new(1, 18.56),
                    })
                    pe2.RotSpeed = NumberRange.new(-20, 20)
                    pe2.Rate = 3
                    pe2.Texture = 'rbxassetid://10149702982'
                    pe2.EmissionDirection = Enum.NormalId.Front
                    pe2.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
                    pe2.Rotation = NumberRange.new(-360, 360)
                    pe2.Enabled = false
                    pe2.Parent = blackFlashAttachment

                    local lightning3 = Instance.new('ParticleEmitter')

                    lightning3.Name = 'Lightning3'
                    lightning3.Lifetime = NumberRange.new(0.25, 0.41)
                    lightning3.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
                    lightning3.SpreadAngle = Vector2.new(16, 16)
                    lightning3.LockedToPart = true
                    lightning3.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.0280971, 0),
                        NumberSequenceKeypoint.new(0.523627, 0.0875),
                        NumberSequenceKeypoint.new(0.569604, 0.43125),
                        NumberSequenceKeypoint.new(0.633461, 0.7875),
                        NumberSequenceKeypoint.new(0.747126, 0.95),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    lightning3.Color = ColorSequence.new(Color3.fromRGB(255, 17, 17))
                    lightning3.Drag = 5
                    lightning3.VelocitySpread = 16
                    lightning3.Speed = NumberRange.new(0.0077598, 0.0077598)
                    lightning3.ZOffset = 5.3460002
                    lightning3.Size = NumberSequence.new(9.31)
                    lightning3.Rate = 3
                    lightning3.Texture = 'rbxassetid://14934040881'
                    lightning3.EmissionDirection = Enum.NormalId.Front
                    lightning3.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
                    lightning3.Rotation = NumberRange.new(-360, 360)
                    lightning3.Enabled = false
                    lightning3.Parent = blackFlashAttachment

                    local flare1 = Instance.new('ParticleEmitter')

                    flare1.Name = 'Flare1'
                    flare1.Lifetime = NumberRange.new(0.6, 1.3)
                    flare1.SpreadAngle = Vector2.new(180, 180)
                    flare1.LockedToPart = true
                    flare1.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0.602871),
                        NumberSequenceKeypoint.new(0.113611, 0.842105, 0.0191388),
                        NumberSequenceKeypoint.new(0.457399, 0.9625),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    flare1.LightEmission = 1
                    flare1.Drag = 10
                    flare1.VelocitySpread = 180
                    flare1.Speed = NumberRange.new(72.6485977, 290.5939941)
                    flare1.Brightness = 0.75
                    flare1.ZOffset = 3.459456
                    flare1.Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0.58, 3.49),
                        NumberSequenceKeypoint.new(0.1, 6.27, 3.49),
                        NumberSequenceKeypoint.new(0.2, 9.86, 3.49),
                        NumberSequenceKeypoint.new(0.3, 12.52, 3.49),
                        NumberSequenceKeypoint.new(0.4, 14.59, 3.49),
                        NumberSequenceKeypoint.new(0.5, 16.25, 3.49),
                        NumberSequenceKeypoint.new(0.6, 17.59, 3.49),
                        NumberSequenceKeypoint.new(0.7, 18.66, 3.49),
                        NumberSequenceKeypoint.new(0.8, 19.49, 3.49),
                        NumberSequenceKeypoint.new(0.9, 20.08, 3.49),
                        NumberSequenceKeypoint.new(1, 20.34, 3.49),
                    })
                    flare1.Rate = 3
                    flare1.Texture = 'rbxassetid://15883763954'
                    flare1.EmissionDirection = Enum.NormalId.Front
                    flare1.Orientation = Enum.ParticleOrientation.VelocityParallel
                    flare1.Rotation = NumberRange.new(-360, 360)
                    flare1.Enabled = false
                    flare1.Parent = blackFlashAttachment

                    local flash = Instance.new('ParticleEmitter')

                    flash.Name = 'Flash'
                    flash.Lifetime = NumberRange.new(0.07, 0.2)
                    flash.SpreadAngle = Vector2.new(-360, 360)
                    flash.LockedToPart = true
                    flash.LightEmission = 1
                    flash.Color = ColorSequence.new(Color3.fromRGB(255, 17, 17))
                    flash.VelocitySpread = -360
                    flash.Squash = NumberSequence.new(0.15)
                    flash.Speed = NumberRange.new(0.0197291, 0.0197291)
                    flash.Brightness = 15
                    flash.ZOffset = 3.9599998
                    flash.Size = NumberSequence.new(25.55, 0)
                    flash.Rate = 3
                    flash.Texture = 'rbxassetid://15446757636'
                    flash.Orientation = Enum.ParticleOrientation.VelocityParallel
                    flash.Rotation = NumberRange.new(-360, 360)
                    flash.Enabled = false
                    flash.Parent = blackFlashAttachment

                    local impactFlare = Instance.new('ParticleEmitter')

                    impactFlare.Name = 'ImpactFlare'
                    impactFlare.Lifetime = NumberRange.new(0.1, 0.2)
                    impactFlare.SpreadAngle = Vector2.new(360, 360)
                    impactFlare.LockedToPart = true
                    impactFlare.LightEmission = 1
                    impactFlare.Color = ColorSequence.new(Color3.fromRGB(255, 17, 17))
                    impactFlare.VelocitySpread = 360
                    impactFlare.Squash = NumberSequence.new(-0.25)
                    impactFlare.Speed = NumberRange.new(0.159667, 0.159667)
                    impactFlare.Brightness = 15
                    impactFlare.ZOffset = 3.9599998
                    impactFlare.Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(0.146875, 21.95),
                        NumberSequenceKeypoint.new(0.475, 5.59),
                        NumberSequenceKeypoint.new(1, 0),
                    })
                    impactFlare.Rate = 3
                    impactFlare.Texture = 'rbxassetid://15860138158'
                    impactFlare.Orientation = Enum.ParticleOrientation.VelocityParallel
                    impactFlare.Enabled = false
                    impactFlare.Parent = blackFlashAttachment
                    effectTemplates['BlackFlash'] = blackFlashAttachment

                    local gravityAttachment = Instance.new('Attachment')
                    local gradient = Instance.new('ParticleEmitter')

                    gradient.Name = 'Gradient'
                    gradient.Lifetime = NumberRange.new(0.6, 0.6)
                    gradient.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.578059, 0.7375),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    gradient.LightEmission = 1
                    gradient.Color = ColorSequence.new(Color3.fromRGB(114, 44, 255))
                    gradient.Speed = NumberRange.new(0.0629003, 0.0629003)
                    gradient.Brightness = 4
                    gradient.Size = NumberSequence.new(0, 35.7745705)
                    gradient.RotSpeed = NumberRange.new(500, 800)
                    gradient.Rate = 3
                    gradient.Texture = 'rbxassetid://8030746658'
                    gradient.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
                    gradient.Rotation = NumberRange.new(-360, 360)
                    gradient.Enabled = false
                    gradient.Parent = gravityAttachment

                    local specs = Instance.new('ParticleEmitter')

                    specs.Name = 'Specs'
                    specs.Lifetime = NumberRange.new(0.85, 1)
                    specs.SpreadAngle = Vector2.new(-30, 30)
                    specs.LightEmission = 1
                    specs.Color = ColorSequence.new(Color3.fromRGB(81, 62, 189))
                    specs.VelocitySpread = -30
                    specs.Speed = NumberRange.new(5, 10)
                    specs.Brightness = 4
                    specs.Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(0.1672474, 0.8749998, 0.4375),
                        NumberSequenceKeypoint.new(1, 0),
                    })
                    specs.Rate = 35
                    specs.Texture = 'rbxassetid://8030760338'
                    specs.Enabled = false
                    specs.Parent = gravityAttachment

                    local specs3 = Instance.new('ParticleEmitter')

                    specs3.Name = 'Specs3'
                    specs3.Lifetime = NumberRange.new(0.2, 0.4)
                    specs3.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.2606061, 0),
                        NumberSequenceKeypoint.new(1, 0),
                    })
                    specs3.LightEmission = 1
                    specs3.Color = ColorSequence.new(Color3.fromRGB(114, 44, 255))
                    specs3.Drag = 1
                    specs3.Squash = NumberSequence.new(0, 3)
                    specs3.Speed = NumberRange.new(5, 10)
                    specs3.Brightness = 3
                    specs3.Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(0.110303, 4.0975556),
                        NumberSequenceKeypoint.new(1, 0),
                    })
                    specs3.ShapeInOut = Enum.ParticleEmitterShapeInOut.InAndOut
                    specs3.Rate = 70
                    specs3.Texture = 'rbxassetid://8801300936'
                    specs3.Orientation = Enum.ParticleOrientation.FacingCameraWorldUp
                    specs3.Enabled = false
                    specs3.Parent = gravityAttachment

                    local lines = Instance.new('ParticleEmitter')

                    lines.Name = 'Lines'
                    lines.LightInfluence = 1
                    lines.Lifetime = NumberRange.new(0.2, 0.3)
                    lines.LockedToPart = true
                    lines.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.244546, 0),
                        NumberSequenceKeypoint.new(0.5, 0),
                        NumberSequenceKeypoint.new(0.738232, 0),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    lines.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0))
                    lines.Squash = NumberSequence.new(0, 2.7750001)
                    lines.Speed = NumberRange.new(1, 1)
                    lines.Brightness = 0.645
                    lines.ZOffset = 1.01
                    lines.Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(0.100266, 0),
                        NumberSequenceKeypoint.new(0.5092024, 1.6249996, 0.645087),
                        NumberSequenceKeypoint.new(0.899734, 0),
                        NumberSequenceKeypoint.new(1, 0),
                    })
                    lines.VelocityInheritance = 1
                    lines.Rate = 200
                    lines.Texture = 'rbxassetid://8984664353'
                    lines.EmissionDirection = Enum.NormalId.Back
                    lines.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
                    lines.Enabled = false
                    lines.Parent = gravityAttachment

                    local lines1 = Instance.new('ParticleEmitter')

                    lines1.Name = 'Lines1'
                    lines1.Lifetime = NumberRange.new(0.2, 0.3)
                    lines1.LockedToPart = true
                    lines1.LightEmission = 1
                    lines1.Color = ColorSequence.new(Color3.fromRGB(126, 66, 255))
                    lines1.Squash = NumberSequence.new(0, 1.1999998)
                    lines1.Speed = NumberRange.new(1, 1)
                    lines1.Brightness = 15
                    lines1.ZOffset = 1.01
                    lines1.Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(0.100266, 0),
                        NumberSequenceKeypoint.new(0.5153374, 2.2499995, 0.645087),
                        NumberSequenceKeypoint.new(0.899734, 0),
                        NumberSequenceKeypoint.new(1, 0),
                    })
                    lines1.VelocityInheritance = 1
                    lines1.Rate = 200
                    lines1.Texture = 'rbxassetid://8984664353'
                    lines1.EmissionDirection = Enum.NormalId.Back
                    lines1.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
                    lines1.Enabled = false
                    lines1.Parent = gravityAttachment
                    effectTemplates['Gravity'] = gravityAttachment

                    local meteorAttachment = Instance.new('Attachment')
                    local meteorStart = Instance.new('Attachment')

                    meteorStart.Name = 'MeteorStart'
                    meteorStart.CFrame = CFrame.new(0, 25, 0)
                    meteorStart.Parent = meteorAttachment

                    local meteorEnd = Instance.new('Attachment')

                    meteorEnd.Name = 'MeteorEnd'
                    meteorEnd.CFrame = CFrame.new(0, 0, 0)
                    meteorEnd.Parent = meteorAttachment

                    local trail = Instance.new('Trail')

                    trail.FaceCamera = true
                    trail.Color = ColorSequence.new(Color3.fromRGB(79, 25, 255))
                    trail.WidthScale = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(0.0666667, 0.13125),
                        NumberSequenceKeypoint.new(0.180117, 0.23125),
                        NumberSequenceKeypoint.new(0.3309942, 0.2375),
                        NumberSequenceKeypoint.new(0.4842105, 0.16875),
                        NumberSequenceKeypoint.new(0.5918128, 0.1),
                        NumberSequenceKeypoint.new(0.7274854, 0.05),
                        NumberSequenceKeypoint.new(1, 0),
                    })
                    trail.Transparency = NumberSequence.new(0)
                    trail.Lifetime = 0.2
                    trail.Brightness = 13
                    trail.Attachment0 = meteorStart
                    trail.Attachment1 = meteorEnd
                    trail.Parent = meteorAttachment

                    local fireSpiky = Instance.new('ParticleEmitter')

                    fireSpiky.Name = 'FireGroundSpikeyFire'
                    fireSpiky.Lifetime = NumberRange.new(0.1, 0.3)
                    fireSpiky.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
                    fireSpiky.SpreadAngle = Vector2.new(40, 40)
                    fireSpiky.LightEmission = 0.1
                    fireSpiky.Color = ColorSequence.new(Color3.fromRGB(72, 26, 255))
                    fireSpiky.Drag = 9
                    fireSpiky.FlipbookStartRandom = true
                    fireSpiky.VelocitySpread = 40
                    fireSpiky.Speed = NumberRange.new(100, 200)
                    fireSpiky.Brightness = 4.57
                    fireSpiky.ZOffset = -0.1146465
                    fireSpiky.Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 14.1784506, 0.3640427),
                        NumberSequenceKeypoint.new(0.374578, 16.1989517, 0.3758909),
                        NumberSequenceKeypoint.new(1, 10.3182821, 0.689132),
                    })
                    fireSpiky.Rate = 30
                    fireSpiky.Texture = 'http://www.roblox.com/asset/?id=13136714025'
                    fireSpiky.EmissionDirection = Enum.NormalId.Back
                    fireSpiky.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
                    fireSpiky.Rotation = NumberRange.new(0, 360)
                    fireSpiky.Enabled = false
                    fireSpiky.Parent = meteorEnd

                    local stars = Instance.new('ParticleEmitter')

                    stars.Name = 'Stars'
                    stars.Lifetime = NumberRange.new(0.15, 0.25)
                    stars.SpreadAngle = Vector2.new(30, 30)
                    stars.LockedToPart = true
                    stars.LightEmission = 0.6
                    stars.Color = ColorSequence.new(Color3.fromRGB(69, 44, 255))
                    stars.Drag = 26
                    stars.VelocitySpread = 30
                    stars.Squash = NumberSequence.new(0.2624998, 0.5625)
                    stars.Speed = NumberRange.new(0.1326618, 0.1326618)
                    stars.Brightness = 6.885
                    stars.ZOffset = 3
                    stars.Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(0.2652124, 1.1607907, 0.820863),
                        NumberSequenceKeypoint.new(0.398578, 4.1880746, 1.0401549),
                        NumberSequenceKeypoint.new(0.480578, 7.5677743, 1.1607915),
                        NumberSequenceKeypoint.new(0.530578, 4.3972955, 1.0044292),
                        NumberSequenceKeypoint.new(0.7210103, 1.4095318, 0.7420586),
                        NumberSequenceKeypoint.new(1, 0),
                    })
                    stars.Rate = 50
                    stars.Texture = 'rbxassetid://16722791958'
                    stars.EmissionDirection = Enum.NormalId.Back
                    stars.Rotation = NumberRange.new(150, 150)
                    stars.Enabled = false
                    stars.Parent = meteorEnd

                    local sparks = Instance.new('ParticleEmitter')

                    sparks.Name = 'Sparks'
                    sparks.Lifetime = NumberRange.new(0.2, 0.4)
                    sparks.SpreadAngle = Vector2.new(50, 50)
                    sparks.Color = ColorSequence.new(Color3.fromRGB(84, 41, 255))
                    sparks.Drag = 8
                    sparks.VelocitySpread = 50
                    sparks.Speed = NumberRange.new(141.4421234, 183.8747559)
                    sparks.Brightness = 12
                    sparks.ZOffset = -0.3245147
                    sparks.Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(0.2594719, 1.777688, 0.3979976),
                        NumberSequenceKeypoint.new(1, 0),
                    })
                    sparks.Acceleration = Vector3.new(0, -282.8842468261719, 0)
                    sparks.RotSpeed = NumberRange.new(-30, 30)
                    sparks.Rate = 40
                    sparks.Texture = 'rbxassetid://11995504618'
                    sparks.EmissionDirection = Enum.NormalId.Back
                    sparks.Orientation = Enum.ParticleOrientation.VelocityParallel
                    sparks.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
                    sparks.Enabled = false
                    sparks.Parent = meteorEnd

                    local meteorFlash = Instance.new('ParticleEmitter')

                    meteorFlash.Name = 'Flash'
                    meteorFlash.Lifetime = NumberRange.new(0.07, 0.12)
                    meteorFlash.SpreadAngle = Vector2.new(30, 30)
                    meteorFlash.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.1301587, 0.6625),
                        NumberSequenceKeypoint.new(0.2412698, 0.91875),
                        NumberSequenceKeypoint.new(0.4952381, 0.74375),
                        NumberSequenceKeypoint.new(0.7603174, 0.94375),
                        NumberSequenceKeypoint.new(0.8857143, 0.8375),
                        NumberSequenceKeypoint.new(1, 1),
                    })
                    meteorFlash.Color = ColorSequence.new(Color3.fromRGB(108, 34, 255))
                    meteorFlash.Drag = 14
                    meteorFlash.FlipbookStartRandom = true
                    meteorFlash.VelocitySpread = 30
                    meteorFlash.Speed = NumberRange.new(57.6029854, 230.4119415)
                    meteorFlash.Brightness = 14
                    meteorFlash.ZOffset = 1.7270366
                    meteorFlash.Size = NumberSequence.new(5.0313563, 6.708528)
                    meteorFlash.Rate = 80
                    meteorFlash.Texture = 'rbxassetid://11995386251'
                    meteorFlash.EmissionDirection = Enum.NormalId.Back
                    meteorFlash.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
                    meteorFlash.Rotation = NumberRange.new(0, 360)
                    meteorFlash.Enabled = false
                    meteorFlash.Parent = meteorEnd
                    effectTemplates['Meteor'] = meteorAttachment
end

local function applyColor(inst, color)
	for _, d in ipairs(inst:GetDescendants()) do
		if d:IsA("ParticleEmitter") then
			d.Color = ColorSequence.new(color)
		end
	end
end

local function emitAll(inst)
	for _, d in ipairs(inst:GetDescendants()) do
		if d:IsA("ParticleEmitter") then
			d.Color = ColorSequence.new(effectColor)
			table.insert(activeEmitters, d)

			local count = d:GetAttribute("EmitCount") or d.Rate or 10
			d:Emit(count)
		end
	end
end

function hit_effect_module:SetSelectedEffects(list)
	selectedEffects = {}
	for _, name in ipairs(list or {}) do
		selectedEffects[name] = true
	end
end

function hit_effect_module:AddEffect(name)
	selectedEffects[name] = true
end

function hit_effect_module:RemoveEffect(name)
	selectedEffects[name] = nil
end

function hit_effect_module:ClearEffects()
	selectedEffects = {}
end

function hit_effect_module:SetColor(color)
	effectColor = color

	for i = #activeEmitters, 1, -1 do
		local emitter = activeEmitters[i]
		if emitter and emitter.Parent then
			emitter.Color = ColorSequence.new(color)
		else
			table.remove(activeEmitters, i)
		end
	end
end

function hit_effect_module:SetLifetime(seconds)
	effectLifetime = seconds
end

function hit_effect_module:Play(character)
    if not character then return end

    createEffectTemplates()

    local root =
        character:FindFirstChild("HumanoidRootPart")
        or character:FindFirstChild("Torso")
        or character:FindFirstChild("UpperTorso")

    if not root then return end

    for effectName in pairs(selectedEffects) do
        local template = effectTemplates[effectName]
        if template then
            local effect = template:Clone()
            applyColor(effect, effectColor)
            effect.Parent = root

            for _, d in ipairs(effect:GetDescendants()) do
                if d:IsA("ParticleEmitter") then
                    d.Lifetime = NumberRange.new(0, effectLifetime)
                end
            end

            emitAll(effect)

            task.delay(effectLifetime, function()
                if effect then
                    effect:Destroy()
                end
            end)
        end
    end
end

local self_chams_module = {}
do
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")

    local lp = Players.LocalPlayer
    local enabled = false
    local color = Color3.fromRGB(155, 125, 175)
    local transparency = 0
    local reflectance = 0
    local material = 'ForceField'
    local addEffect = 'none'
    local particleColor = Color3.fromRGB(255, 255, 255)
    local particleTransparency = 0
    local charConnection

    local cachedData = {
        parts = {},
        accessories = {},
        clothing = {},
        bodyColors = nil,
    }

    local r15Parts = {
        'LeftFoot', 'LeftLowerLeg', 'LeftUpperLeg',
        'RightFoot', 'RightLowerLeg', 'RightUpperLeg',
        'LeftHand', 'LeftLowerArm', 'LeftUpperArm',
        'RightHand', 'RightLowerArm', 'RightUpperArm',
        'LowerTorso', 'UpperTorso', 'Head',
    }

    local partSet = {}
    for _, name in ipairs(r15Parts) do
        partSet[name] = true
    end

    -- Helpers
    local function isR15Part(name)
        return partSet[name] == true
    end

    local function cacheCharacter(char)
        if not char then return end

        cachedData.parts = {}
        cachedData.accessories = {}
        cachedData.clothing = {}
        cachedData.bodyColors = nil

        for _, child in ipairs(char:GetChildren()) do
            if isR15Part(child.Name) and (child:IsA('MeshPart') or child:IsA('BasePart')) then
                cachedData.parts[child.Name] = {
                    Material = child.Material,
                    Color = child.Color,
                    Transparency = child.Transparency,
                    Reflectance = child.Reflectance,
                    TextureID = child:IsA('MeshPart') and child.TextureID or nil,
                }
            elseif child:IsA("Accessory") then
                local handle = child:FindFirstChild("Handle")
                if handle and (handle:IsA("MeshPart") or handle:IsA("BasePart")) then
                    cachedData.accessories[child] = {
                        Material = handle.Material,
                        Color = handle.Color,
                        Transparency = handle.Transparency,
                        Reflectance = handle.Reflectance,
                        TextureID = handle:IsA('MeshPart') and handle.TextureID or nil,
                    }
                end
            end
        end

        for _, desc in ipairs(char:GetDescendants()) do
            if desc:IsA('Shirt') then
                cachedData.clothing.Shirt = desc.ShirtTemplate
            elseif desc:IsA('Pants') then
                cachedData.clothing.Pants = desc.PantsTemplate
            elseif desc:IsA('BodyColors') then
                cachedData.bodyColors = {
                    HeadColor3 = desc.HeadColor3,
                    LeftArmColor3 = desc.LeftArmColor3,
                    LeftLegColor3 = desc.LeftLegColor3,
                    RightArmColor3 = desc.RightArmColor3,
                    RightLegColor3 = desc.RightLegColor3,
                    TorsoColor3 = desc.TorsoColor3,
                }
            end
        end
    end

    local function removeParticles(char)
        if not char then return end
        for _, part in ipairs(char:GetChildren()) do
            if isR15Part(part.Name) then
                local stars = part:FindFirstChild('stars')
                local specks = part:FindFirstChild('Specks')
                if stars then pcall(function() stars:Destroy() end) end
                if specks then pcall(function() specks:Destroy() end) end
            end
        end
    end

    local function applyStars(char)
        if not char then return end
        for _, part in ipairs(char:GetChildren()) do
            if isR15Part(part.Name) and (part:IsA('MeshPart') or part:IsA('BasePart')) then
                local existing = part:FindFirstChild('stars')
                if existing then existing:Destroy() end

                pcall(function()
                    local stars = Instance.new('ParticleEmitter')
                    stars.Name = 'stars'
                    stars.Lifetime = NumberRange.new(0.45, 0.9)
                    stars.LockedToPart = true
                    stars.LightEmission = 1
                    stars.Drag = 5
                    stars.Squash = NumberSequence.new(-0.1)
                    stars.Speed = NumberRange.new(0.001, 0.001)
                    stars.Brightness = 3
                    stars.ZOffset = 1
                    stars.Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(0.508, 0.05, 0.05),
                        NumberSequenceKeypoint.new(1, 0),
                    })
                    stars.Rate = 150
                    stars.Texture = 'rbxassetid://1084996976'
                    stars.EmissionDirection = Enum.NormalId.Bottom
                    stars.Color = ColorSequence.new(particleColor)
                    stars.Transparency = NumberSequence.new(particleTransparency)
                    stars.Parent = part
                end)
            end
        end
    end

    local function applyParticles(char)
        if not char then return end
        for _, part in ipairs(char:GetChildren()) do
            if isR15Part(part.Name) and (part:IsA('MeshPart') or part:IsA('BasePart')) then
                local existing = part:FindFirstChild('Specks')
                if existing then existing:Destroy() end

                pcall(function()
                    local specks = Instance.new('ParticleEmitter')
                    specks.Name = 'Specks'
                    specks.Lifetime = NumberRange.new(0.22, 0.22)
                    specks.SpreadAngle = Vector2.new(90, 90)
                    local t = particleTransparency
                    specks.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, math.min(1, t + 0.8)),
                        NumberSequenceKeypoint.new(0.25, math.max(0, t - 0.1)),
                        NumberSequenceKeypoint.new(1, math.min(1, t + 0.8)),
                    })
                    specks.LightEmission = 1
                    specks.Color = ColorSequence.new(particleColor)
                    specks.Drag = 5
                    specks.Squash = NumberSequence.new(0)
                    specks.Speed = NumberRange.new(1, 1)
                    specks.Brightness = 4.2
                    specks.Size = NumberSequence.new(0.15)
                    specks.Acceleration = Vector3.new(0, -15, 0)
                    specks.RotSpeed = NumberRange.new(-45, 45)
                    specks.Rate = 100
                    specks.Texture = 'rbxassetid://7216849703'
                    specks.Parent = part
                end)
            end
        end
    end

    local function applyChams(char, skipParticles)
        if not char then return end

        local function applyPropsToPart(p)
            p.Material = Enum.Material[material]
            p.Color = color
            if p:IsA('MeshPart') then p.TextureID = '' end
            p.Reflectance = reflectance
            p.Transparency = transparency
        end

        for _, desc in ipairs(char:GetDescendants()) do
            if desc:IsA('Pants') or desc:IsA('Shirt') then
                pcall(function() desc:Destroy() end)
            end
        end

        for _, child in ipairs(char:GetChildren()) do
            if isR15Part(child.Name) and (child:IsA('MeshPart') or child:IsA('BasePart')) then
                pcall(function() applyPropsToPart(child) end)
            elseif child:IsA("Accessory") then
                local handle = child:FindFirstChild("Handle")
                if handle and (handle:IsA("MeshPart") or handle:IsA("BasePart")) then
                    pcall(function() applyPropsToPart(handle) end)
                end
            end
        end

        if not skipParticles then
            if addEffect == 'stars' then
                applyStars(char)
            elseif addEffect == 'particles' then
                applyParticles(char)
            else
                removeParticles(char)
            end
        end
    end

    local function restoreCharacter(char)
        if not char then return end
        removeParticles(char)

        for _, part in ipairs(char:GetChildren()) do
            if isR15Part(part.Name) and cachedData.parts[part.Name] then
                local data = cachedData.parts[part.Name]
                pcall(function()
                    part.Material = data.Material
                    part.Color = data.Color
                    part.Transparency = data.Transparency
                    part.Reflectance = data.Reflectance
                    if part:IsA('MeshPart') and data.TextureID then
                        part.TextureID = data.TextureID
                    end
                end)
            end
        end

        for acc, data in pairs(cachedData.accessories) do
            if acc and acc.Parent == char then
                local handle = acc:FindFirstChild("Handle")
                if handle then
                    pcall(function()
                        handle.Material = data.Material
                        handle.Color = data.Color
                        handle.Transparency = data.Transparency
                        handle.Reflectance = data.Reflectance
                        if handle:IsA('MeshPart') and data.TextureID then
                            handle.TextureID = data.TextureID
                        end
                    end)
                end
            end
        end

        if cachedData.clothing.Shirt then
            pcall(function()
                local shirt = Instance.new('Shirt')
                shirt.ShirtTemplate = cachedData.clothing.Shirt
                shirt.Parent = char
            end)
        end
        if cachedData.clothing.Pants then
            pcall(function()
                local pants = Instance.new('Pants')
                pants.PantsTemplate = cachedData.clothing.Pants
                pants.Parent = char
            end)
        end
    end

    -- Public Interface
    function self_chams_module:setEnabled(val)
        enabled = val
        local char = lp.Character

        if enabled then
            cacheCharacter(char)
            applyChams(char)

            if charConnection then
                charConnection:Disconnect()
            end

            charConnection = lp.CharacterAdded:Connect(function(newChar)
                newChar:WaitForChild('Humanoid')
                task.wait(1.1)
                if enabled then
                    cacheCharacter(newChar)
                    applyChams(newChar)
                    task.wait(0.5)
                    applyChams(newChar)
                end
            end)
        else
            if charConnection then
                charConnection:Disconnect()
                charConnection = nil
            end
            restoreCharacter(char)
        end
    end

    function self_chams_module:setColor(c)
        color = c
        if enabled then applyChams(lp.Character) end
    end

    function self_chams_module:setTransparency(t)
        transparency = t
        if enabled then applyChams(lp.Character) end
    end

    function self_chams_module:setReflectance(r)
        reflectance = r
        if enabled then applyChams(lp.Character) end
    end

    function self_chams_module:setMaterial(m)
        material = m
        if enabled then applyChams(lp.Character) end
    end

    function self_chams_module:setAddEffect(e)
        addEffect = e
        if enabled then
            removeParticles(lp.Character)
            if e == 'stars' then
                applyStars(lp.Character)
            elseif e == 'particles' then
                applyParticles(lp.Character)
            end
        end
    end

    function self_chams_module:setParticleColor(c)
        particleColor = c
        if enabled then self_chams_module:setAddEffect(addEffect) end
    end

    function self_chams_module:setParticleTransparency(t)
        particleTransparency = t
        if enabled then self_chams_module:setAddEffect(addEffect) end
    end
end

local library = {
    directory = "aether",
    folders = {
        "/fonts",
        "/configs",
        "/images"
    },
    flags = {},
    config_flags = {},
    visible_flags = {}, 
    guis = {}, 
    connections = {},   
    notifications = {},
    playerlist_data = {},
    Notifs = {},
    current_tab, 
    current_element_open, 
    dock_button_holder,  
    old_config; 
    font, 
    keybind_list,
    binds = {}, 
    
    copied_flag; 
    is_rainbow;

    display_orders = 0; 
}

local flags = library.flags
local config_flags = library.config_flags

funcs.get_mouse_location = function()
    return vec2(uis:GetMouseLocation().X, uis:GetMouseLocation().Y)
end

funcs.world_to_view_port_point = function(position)
    return camera:WorldToViewportPoint(position)
end

funcs.shoot = function(tool)
    if tool then
        local current_time = tick() 
        if current_time - cache.last_trigger_time >= getgenv().aether.trigger_bot.delay then
            cache.last_trigger_time = current_time 
            task.spawn(function()
                task.wait(getgenv().aether.trigger_bot.delay) 

                if getgenv().aether.trigger_bot.method == "Tool Activation" then
                    tool:Activate()
                else
                    mouse1press()
                end
            end)
        end
    end
end

funcs.is_alive = function(plr)
    return plr
            and plr.Character
            and plr.Character:FindFirstChildOfClass("Humanoid")
            and plr.Character:FindFirstChildOfClass("Humanoid").Health > 0
            and true
        or false
end

funcs.is_knocked = function(entity) 
    if entity.Character:FindFirstChild("BodyEffects") then
        return entity.Character.BodyEffects["K.O"].Value
    end
    return false
end

funcs.is_grabbed = function(entity)
    return entity.Character:FindFirstChild('GRABBING_CONSTRAINT')
end

funcs.has_forcefield = function(entity)
    return entity.Character:FindFirstChild("ForceField")
end

funcs.find_crew = function(entity)
    if entity:FindFirstChild("DataFolder") and entity.DataFolder:FindFirstChild("Information") and entity.DataFolder.Information:FindFirstChild("Crew") and local_entity:FindFirstChild("DataFolder") and local_entity.DataFolder:FindFirstChild("Information") and local_entity.DataFolder.Information:FindFirstChild("Crew") then
        if local_entity.DataFolder.Information.Crew.Value ~= nil and entity.DataFolder.Information.Crew.Value ~= nil and entity.DataFolder.Information.Crew.Value ~= "" and local_entity.DataFolder.Information.Crew.Value ~= "" then 
            return local_entity.DataFolder.Information.Crew.Value == entity.DataFolder.Information.Crew.Value
        end
    end
    return false
end

funcs.is_visible = function(part, character)
    local origin = camera.CFrame.Position
    local destination = part.Position
    local direction = (destination - origin).Unit * (destination - origin).Magnitude
    
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {local_entity.Character, camera}
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.IgnoreWater = true
    
    local result = workspace:Raycast(origin, direction, params)
    
    if result then
        return result.Instance:IsDescendantOf(character)
    end
    return false
end

funcs.get_distance = function(part)
    return (part.Position - workspace.CurrentCamera.CFrame.Position).Magnitude
end

local chars = {}
funcs.generate_string = function(length)
    if #chars == 0 then
        for i = 97, 122 do table.insert(chars, string.char(i)) end
        for i = 65, 90 do table.insert(chars, string.char(i)) end
        for i = 48, 57 do table.insert(chars, string.char(i)) end 
    end
    
    local result = {}
    
    for i = 1, length do
        local index = math.random(1, #chars) 
        table.insert(result, chars[index])
    end
    
    return table.concat(result)
end

funcs.has_weapon = function(entity)
    if not entity then return false end
    if not entity.Character then return false end

    local tool = entity.Character:FindFirstChildWhichIsA("Tool")
    if not tool then return false end

    if tool:FindFirstChild("Ammo") then
        return true
    end

    local script_instance = tool:FindFirstChild("Script")
    if script_instance and script_instance:FindFirstChild("Ammo") then
        return true
    end

    return false
end

funcs.get_tool_name = function(entity)
    local tool_name

    if funcs.has_weapon(entity) then
        local tool = entity.Character:FindFirstChildWhichIsA("Tool")
        
        tool_name = tool.Name
    else
        tool_name = "None"
    end

    return tool_name
end

funcs.get_weapon_ammo = function()
    if not cache.equipped_tool then
        return "None", "None"
    end

    if game.PlaceId == 9825515356 or game.PlaceId == 138995385694035 then
        local script = cache.equipped_tool:FindFirstChild("Script")
        local ammo = script and script:FindFirstChild("Ammo")
        local max_ammo = script and script:FindFirstChild("MaxAmmo")

        return ammo and ammo.Value or "None", max_ammo and max_ammo.Value or "None"
    end

    local ammo = cache.equipped_tool:FindFirstChild("Ammo")
    local max_ammo = cache.equipped_tool:FindFirstChild("MaxAmmo")

    return ammo and ammo.Value or "None", max_ammo and max_ammo.Value or "None"
end


funcs.get_flag = function(entity)
    if not entity or not entity.Character then
        return "Unknown"
    end

    local humanoid = entity.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        return "Unknown"
    end

    if funcs.is_knocked(entity) then
        return "Dead"
    end

    local state = humanoid:GetState()

    if state == Enum.HumanoidStateType.Freefall then
        return "Falling"
    elseif state == Enum.HumanoidStateType.Jumping then
        return "Jumping"
    elseif state == Enum.HumanoidStateType.Swimming then
        return "Swimming"
    elseif state == Enum.HumanoidStateType.Climbing then
        return "Climbing"
    elseif state == Enum.HumanoidStateType.Seated then
        return "Seated"
    elseif state == Enum.HumanoidStateType.Ragdoll then
        return "Ragdolled"
    elseif state == Enum.HumanoidStateType.GettingUp then
        return "Getting Up"
    elseif humanoid.MoveDirection.Magnitude > 0 then
        return "Moving"
    elseif humanoid.Health <= 0 then
        return "Dead"
    else
        return "Standing"
    end
end

funcs.get_bot = function()
    for _, entity in ipairs(workspace.Bots:GetChildren()) do
        if entity:FindFirstChildWhichIsA("Humanoid") then
            return entity
        end
    end

    return nil
end

funcs.find_nearest_entity = LPH_NO_VIRTUALIZE(function(radius)
    local nearest_target = nil
    local shortest_distance = radius
    
    for _, entity in ipairs(entities:GetPlayers()) do
        if entity ~= local_entity and entity.Character then
            local character = entity.Character
            local humanoid_root_part = character:FindFirstChild("HumanoidRootPart")

            if (getgenv().aether.checks.grabbed_check and funcs.is_grabbed(entity)) or 
               (getgenv().aether.checks.knocked_check and funcs.is_knocked(entity)) or 
               (getgenv().aether.checks.health_check and not funcs.is_alive(entity)) or 
               (getgenv().aether.checks.range_check and funcs.get_distance(humanoid_root_part) >= getgenv().aether.checks.range) or
               (getgenv().aether.checks.crew_check and funcs.find_crew(entity)) or 
               (getgenv().aether.checks.team_check and entity.TeamColor == local_entity.TeamColor) or
               (getgenv().aether.checks.visible_check and not funcs.is_visible(humanoid_root_part, character)) or 
               (getgenv().aether.checks.forcefield_check and funcs.has_forcefield(entity)) then
                continue
            end

            if humanoid_root_part then
                local screen_position, onscreen = camera:WorldToViewportPoint(humanoid_root_part.Position)
                if onscreen then
                    local distance = (vec2(screen_position.X, screen_position.Y) - cache.mouse_position).Magnitude
                    if distance < shortest_distance then
                        nearest_target = entity
                        shortest_distance = distance
                    end
                end
            end
        end
    end
    return nearest_target
end)

local function brighten(color, amount)
    local h, s, v = color:ToHSV()
    return Color3.fromHSV(h, s, math.clamp(v + amount, 0, 1))
end

local function darken(color, amount)
    local h, s, v = color:ToHSV()
    return Color3.fromHSV(h, s, math.clamp(v - amount, 0, 1))
end

funcs.random_color = function()
    return Color3.fromRGB(
        math.random(0, 255),
        math.random(0, 255),
        math.random(0, 255)
    )
end

funcs.check_cam_view = function(pos)
    return (pos - camera.CFrame.Position):Dot(camera.CFrame.LookVector) > -5                            
end

funcs.change_avatar = function(id)
    if not flags["avatar_changer_enabled"] then return end

    task.wait(1)

    local char = local_entity.Character
    if not (char and char:FindFirstChild("Humanoid")) then return end

    local hum = char.Humanoid

    for _, item in ipairs(char:GetChildren()) do
        if item:IsA("Shirt") or item:IsA("Pants") or item:IsA("Accessory") then
            item:Destroy()
        end
    end

    local success, userId = pcall(function()
        return entities:GetUserIdFromNameAsync(id)
    end)
    if not success then return end

    local desc_success, description = pcall(function()
        return entities:GetHumanoidDescriptionFromUserId(userId)
    end)
    if not desc_success then return end

    if flags["avatar_changer_remove_width"] then
        description.WidthScale = 0.85
        description.DepthScale = 0.85
        description.HeightScale = 1
        description.HeadScale = 1
    end

    hum:ApplyDescriptionClientServer(description)

    if flags["avatar_changer_remove_width"] then
        task.wait()
        if hum:FindFirstChild("BodyWidthScale") then
            hum.BodyWidthScale.Value = 0.85
            hum.BodyDepthScale.Value = 0.85
            hum.BodyHeightScale.Value = 1
            hum.HeadScale.Value = 1
        end
    end
end

funcs.animinit = function(character)
    local humanoid = character:WaitForChild("Humanoid")
    local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)

    funcs.load_animation = function(animId)
        if danceTrack and danceTrack.IsPlaying then
            danceTrack:Stop()
        end

        local anim = Instance.new("Animation")
        anim.AnimationId = animId
        danceTrack = animator:LoadAnimation(anim)
        danceTrack.Priority = Enum.AnimationPriority.Action

        if flags["animation_spoofer_enabled"] then
            danceTrack:Play(0)
            danceTrack:AdjustSpeed(0)
        end
    end

    funcs.load_animation(animationid)

    local frameTime = 0
    local lastUpdateTime = tick()

    funcs.play_dance = function()
        if not flags["animation_spoofer_enabled"] then return end

        if danceTrack and not danceTrack.IsPlaying then
            danceTrack:Play(0)
            danceTrack:AdjustSpeed(0)
        end
    end

    funcs.update_animation = function()
        if not flags["animation_spoofer_enabled"] or not danceTrack then return end
        frameTime = 1 / flags["animation_spoofer_fps"]

        local currentTime = tick()
        local deltaTime = currentTime - lastUpdateTime
        if deltaTime >= frameTime then
            local newTimePosition = danceTrack.TimePosition + deltaTime
            danceTrack.TimePosition = newTimePosition % danceTrack.Length
            lastUpdateTime = currentTime
        end
    end

    humanoid.Running:Connect(function(speed)
        if flags["animation_spoofer_enabled"] and speed > 0 then
            if not danceTrack.IsPlaying then
                funcs.play_dance()
            end
        end
    end)
end

if local_entity.Character then
    funcs.animinit(local_entity.Character)
end

local_entity.CharacterAdded:Connect(funcs.animinit)

local_entity.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid")

    if flags["avatar_changer_enabled"] then
        local id = flags["avatar_changer_custom_user"] ~= "" and flags["avatar_changer_custom_user"] or flags["avatar_changer_user"]

        funcs.change_avatar(id)

        if flags["self_chams_enabled"] then
            self_chams_module:setEnabled(true)
        end
    end
end)

local lighting_backup = {
    Ambient = lighting.Ambient,
    OutdoorAmbient = lighting.OutdoorAmbient,
    ColorShift_Bottom = lighting.ColorShift_Bottom,
    ColorShift_Top = lighting.ColorShift_Top,
    FogColor = lighting.FogColor,
    FogEnd = lighting.FogEnd ,
    FogStart = lighting.FogStart ,
    ExposureCompensation = lighting.ExposureCompensation,
    Brightness = lighting. Brightness,
    ClockTime = lighting.ClockTime,
    GlobalShadows = lighting.GlobalShadows,
    Technology = lighting.Technology
}

local r6_dummy = game:GetObjects("rbxassetid://9474737816")[1]
r6_dummy.Head.Face:Destroy()

for _, v in pairs(r6_dummy:GetChildren()) do
    if v:IsA("BasePart") then
        v.Transparency = 0
        v.Material = Enum.Material.Neon
        v.Color = Color3.fromRGB(96, 120, 190)
        v.CanCollide = false
        v.Anchored = true
    end
end

r6_dummy.PrimaryPart = r6_dummy:FindFirstChild("HumanoidRootPart") or r6_dummy:FindFirstChildWhichIsA("BasePart")

for _, v in pairs(r6_dummy:GetChildren()) do
    if v:IsA("BasePart") and v ~= r6_dummy.PrimaryPart then
        weld = Instance.new("WeldConstraint")
        weld.Part0 = r6_dummy.PrimaryPart
        weld.Part1 = v
        weld.Parent = r6_dummy.PrimaryPart
    end
end

r6_dummy.Parent = workspace

local themepresets = {
    Default = {
        ["outline"] = rgb(10, 10, 10),
        ["inline"] = rgb(45, 45, 45),
        ["accent"] = rgb(96, 120, 190),
        ["high_contrast"] = rgb(20, 20, 20),
        ["low_contrast"] = rgb(30, 30, 30),
        ["text"] = rgb(180, 180, 180),
        ["text_outline"] = rgb(0, 0, 0),
        ["glow"] = rgb(96, 120, 190),
    },
    Nebula = {
        ["outline"] = rgb(13, 1, 6),
        ["inline"] = rgb(32, 8, 18),
        ["accent"] = rgb(150, 42, 85),
        ["high_contrast"] = rgb(24, 5, 13),
        ["low_contrast"] = rgb(18, 4, 10),
        ["text"] = rgb(180, 180, 180),
        ["text_outline"] = rgb(0, 0, 0),
        ["glow"] = rgb(150, 42, 85),
    },
    Temple = {
        ["outline"] = rgb(10, 10, 10),
        ["inline"] = rgb(45, 45, 45),
        ["accent"] = rgb(220, 142, 240),
        ["high_contrast"] = rgb(28, 28, 28),
        ["low_contrast"] = rgb(28, 28, 28),
        ["text"] = rgb(180, 180, 180),
        ["text_outline"] = rgb(0, 0, 0),
        ["glow"] = rgb(220, 142, 240),
    },
    Abyss = {
        ["outline"] = rgb(10, 10, 10),
        ["inline"] = rgb(45, 45, 45),
        ["accent"] = rgb(140, 135, 180),
        ["high_contrast"] = rgb(30, 30, 30),
        ["low_contrast"] = rgb(20, 20, 20),
        ["text"] = rgb(255, 255, 255),
        ["text_outline"] = rgb(10, 10, 10),
        ["glow"] = rgb(140, 135, 180),
    },
    Fatality = {
        ["outline"] = rgb(15, 15, 40),
        ["inline"] = rgb(50, 40, 80),
        ["accent"] = rgb(240, 15, 80),
        ["high_contrast"] = rgb(35, 25, 70),
        ["low_contrast"] = rgb(25, 20, 50),
        ["text"] = rgb(200, 200, 255),
        ["text_outline"] = rgb(10, 10, 10),
        ["glow"] = rgb(240, 15, 80),
    },
    Neverlose = {
        ["outline"] = rgb(0, 0, 5),
        ["inline"] = rgb(10, 30, 40),
        ["accent"] = rgb(0, 180, 240),
        ["high_contrast"] = rgb(0, 15, 30),
        ["low_contrast"] = rgb(5, 5, 20),
        ["text"] = rgb(255, 255, 255),
        ["text_outline"] = rgb(15, 15, 40),
        ["glow"] = rgb(0, 180, 240),
    },
    Aimware = {
        ["outline"] = rgb(0, 0, 5),
        ["inline"] = rgb(55, 55, 55),
        ["accent"] = rgb(200, 40, 40),
        ["high_contrast"] = rgb(43, 43, 43),
        ["low_contrast"] = rgb(25, 25, 25),
        ["text"] = rgb(232, 232, 232),
        ["text_outline"] = rgb(10, 10, 10),
        ["glow"] = rgb(200, 40, 40),
    },
    Youtube = {
        ["outline"] = rgb(0, 0, 0),
        ["inline"] = rgb(57, 57, 57),
        ["accent"] = rgb(255, 0, 0),
        ["high_contrast"] = rgb(35, 35, 35),
        ["low_contrast"] = rgb(15, 15, 15),
        ["text"] = rgb(241, 241, 241),
        ["text_outline"] = rgb(18, 18, 18),
        ["glow"] = rgb(255, 0, 0),
    },
    Gamesense = {
        ["outline"] = rgb(0, 0, 0),
        ["inline"] = rgb(40, 40, 40),
        ["accent"] = rgb(167, 217, 77),
        ["high_contrast"] = rgb(23, 23, 23),
        ["low_contrast"] = rgb(12, 12, 12),
        ["text"] = rgb(255, 255, 255),
        ["text_outline"] = rgb(20, 20, 20),
        ["glow"] = rgb(167, 217, 77),
    },
    Onetap = {
        ["outline"] = rgb(0, 0, 0),
        ["inline"] = rgb(78, 81, 88),
        ["accent"] = rgb(221, 168, 93),
        ["high_contrast"] = rgb(44, 48, 55),
        ["low_contrast"] = rgb(31, 33, 37),
        ["text"] = rgb(214, 217, 224),
        ["text_outline"] = rgb(0, 0, 0),
        ["glow"] = rgb(221, 168, 93),
    },
    Entropy = {
        ["outline"] = rgb(10, 10, 10),
        ["inline"] = rgb(76, 74, 82),
        ["accent"] = rgb(129, 187, 233),
        ["high_contrast"] = rgb(61, 58, 67),
        ["low_contrast"] = rgb(48, 47, 55),
        ["text"] = rgb(220, 220, 220),
        ["text_outline"] = rgb(0, 0, 0),
        ["glow"] = rgb(129, 187, 233),
    },
    Interwebz = {
        ["outline"] = rgb(26, 26, 26),
        ["inline"] = rgb(64, 54, 79),
        ["accent"] = rgb(201, 101, 75),
        ["high_contrast"] = rgb(41, 31, 56),
        ["low_contrast"] = rgb(31, 22, 43),
        ["text"] = rgb(252, 252, 252),
        ["text_outline"] = rgb(0, 0, 0),
        ["glow"] = rgb(201, 101, 75),
    },
    Dracula = {
        ["outline"] = rgb(32, 33, 38),
        ["inline"] = rgb(60, 56, 77),
        ["accent"] = rgb(154, 129, 179),
        ["high_contrast"] = rgb(42, 44, 56),
        ["low_contrast"] = rgb(37, 39, 48),
        ["text"] = rgb(220, 220, 220),
        ["text_outline"] = rgb(0, 0, 0),
        ["glow"] = rgb(154, 129, 179),
    },
    Spotify = {
        ["outline"] = rgb(10, 10, 10),
        ["inline"] = rgb(41, 41, 41),
        ["accent"] = rgb(30, 215, 96),
        ["high_contrast"] = rgb(24, 24, 24),
        ["low_contrast"] = rgb(18, 18, 18),
        ["text"] = rgb(208, 208, 208),
        ["text_outline"] = rgb(0, 0, 0),
        ["glow"] = rgb(30, 215, 96),
    },
    Sublime = {
        ["outline"] = rgb(0, 0, 0),
        ["inline"] = rgb(72, 73, 72),
        ["accent"] = rgb(255, 152, 0),
        ["high_contrast"] = rgb(50, 51, 45),
        ["low_contrast"] = rgb(40, 41, 35),
        ["text"] = rgb(232, 255, 255),
        ["text_outline"] = rgb(0, 0, 0),
        ["glow"] = rgb(255, 152, 0),
    },
    Vape = {
        ["outline"] = rgb(10, 10, 10),
        ["inline"] = rgb(54, 54, 54),
        ["accent"] = rgb(38, 134, 106),
        ["high_contrast"] = rgb(31, 31, 31),
        ["low_contrast"] = rgb(26, 26, 26),
        ["text"] = rgb(220, 220, 220),
        ["text_outline"] = rgb(0, 0, 0),
        ["glow"] = rgb(38, 134, 106),
    },
    Neko = {
        ["outline"] = rgb(0, 0, 0),
        ["inline"] = rgb(45, 45, 45),
        ["accent"] = rgb(210, 31, 106),
        ["high_contrast"] = rgb(23, 23, 23),
        ["low_contrast"] = rgb(19, 19, 19),
        ["text"] = rgb(255, 255, 255),
        ["text_outline"] = rgb(10, 10, 10),
        ["glow"] = rgb(210, 31, 106),
    },
    Corn = {
        ["outline"] = rgb(0, 0, 0),
        ["inline"] = rgb(51, 51, 51),
        ["accent"] = rgb(255, 144, 0),
        ["high_contrast"] = rgb(37, 37, 37),
        ["low_contrast"] = rgb(25, 25, 25),
        ["text"] = rgb(220, 220, 220),
        ["text_outline"] = rgb(0, 0, 0),
        ["glow"] = rgb(255, 144, 0),
    },
    Minecraft = {
        ["outline"] = rgb(0, 0, 0),
        ["inline"] = rgb(51, 51, 51),
        ["accent"] = rgb(39, 206, 64),
        ["high_contrast"] = rgb(51, 51, 51),
        ["low_contrast"] = rgb(38, 38, 38),
        ["text"] = rgb(255, 255, 255),
        ["text_outline"] = rgb(0, 0, 0),
        ["glow"] = rgb(39, 206, 64),
    },
    Nord = {
        ["outline"] = rgb(46, 52, 64),
        ["inline"] = rgb(59, 66, 82),
        ["accent"] = rgb(136, 192, 208),
        ["high_contrast"] = rgb(67, 76, 94),
        ["low_contrast"] = rgb(54, 60, 74),
        ["text"] = rgb(236, 239, 244),
        ["text_outline"] = rgb(0, 0, 0),
        ["glow"] = rgb(136, 192, 208),
    },
    Monokai = {
        ["outline"] = rgb(20, 20, 20),
        ["inline"] = rgb(39, 40, 34),
        ["accent"] = rgb(249, 38, 114),
        ["high_contrast"] = rgb(50, 50, 50),
        ["low_contrast"] = rgb(30, 30, 30),
        ["text"] = rgb(248, 248, 242),
        ["text_outline"] = rgb(0, 0, 0),
        ["glow"] = rgb(249, 38, 114),
    },
    Obsidian = {
        ["outline"] = rgb(5, 5, 5),
        ["inline"] = rgb(28, 28, 28),
        ["accent"] = rgb(120, 130, 150),
        ["high_contrast"] = rgb(38, 38, 38),
        ["low_contrast"] = rgb(18, 18, 18),
        ["text"] = rgb(210, 210, 210),
        ["text_outline"] = rgb(0, 0, 0),
        ["glow"] = rgb(120, 130, 150),
    },
    RosePine = {
        ["outline"] = rgb(25, 23, 36),
        ["inline"] = rgb(31, 29, 46),
        ["accent"] = rgb(235, 188, 186),
        ["high_contrast"] = rgb(40, 38, 58),
        ["low_contrast"] = rgb(28, 26, 40),
        ["text"] = rgb(224, 222, 244),
        ["text_outline"] = rgb(0, 0, 0),
        ["glow"] = rgb(235, 188, 186),
    },
}

local theme_names = {}
for name in pairs(themepresets) do
    table.insert(theme_names, name)
end
table.sort(theme_names)

local themes = {
    preset = {
        ["outline"] = hex("#0A0A0A"), -- 
        ["inline"] = hex("#2D2D2D"), --
        ["accent"] = hex("#6078BE"), --
        ["high_contrast"] = hex("#141414"),
        ["low_contrast"] = hex("#1E1E1E"),
        ["text"] = hex("#B4B4B4"),
        ["text_outline"] = rgb(0, 0, 0),
        ["glow"] = hex("#6078BE"), 
    },

    utility = {
        ["outline"] = {
            ["BackgroundColor3"] = {}, 	
            ["Color"] = {}, 
        },
        ["inline"] = {
            ["BackgroundColor3"] = {}, 	
            ["ImageColor3"] = {},
        },
        ["accent"] = {
            ["BackgroundColor3"] = {}, 	
            ["TextColor3"] = {}, 
            ["ImageColor3"] = {}, 
            ["ScrollBarImageColor3"] = {} 
        },
        ["contrast"] = {
            ["Color"] = {}, 	
        },
        ["text"] = {
            ["TextColor3"] = {}, 	
        },
        ["text_outline"] = {
            ["Color"] = {}, 	
        },
        ["glow"] = {
            ["ImageColor3"] = {}, 	
        }, 
        ["high_contrast"] = {
            ["BackgroundColor3"] = {},
        },
        ["low_contrast"] = {
            ["BackgroundColor3"] = {},
        }
    }, 

    find = {
        ["Frame"] = "BackgroundColor3", 
        ["TextLabel"] = "TextColor3", 
        ["UIGradient"] = "Color",
        ["UIStroke"] = "Color",
        ["ImageLabel"] = "ImageColor3",
        ["TextButton"] = "BackgroundColor3", 
        ["ScrollingFrame"] = "ScrollBarImageColor3"
    }
}

local keys = {
    [Enum.KeyCode.LeftShift] = "LS",
    [Enum.KeyCode.RightShift] = "RS",
    [Enum.KeyCode.LeftControl] = "LC",
    [Enum.KeyCode.RightControl] = "RC",
    [Enum.KeyCode.Insert] = "INS",
    [Enum.KeyCode.Backspace] = "BS",
    [Enum.KeyCode.Return] = "Ent",
    [Enum.KeyCode.LeftAlt] = "LA",
    [Enum.KeyCode.RightAlt] = "RA",
    [Enum.KeyCode.CapsLock] = "CAPS",
    [Enum.KeyCode.One] = "1",
    [Enum.KeyCode.Two] = "2",
    [Enum.KeyCode.Three] = "3",
    [Enum.KeyCode.Four] = "4",
    [Enum.KeyCode.Five] = "5",
    [Enum.KeyCode.Six] = "6",
    [Enum.KeyCode.Seven] = "7",
    [Enum.KeyCode.Eight] = "8",
    [Enum.KeyCode.Nine] = "9",
    [Enum.KeyCode.Zero] = "0",
    [Enum.KeyCode.KeypadOne] = "Num1",
    [Enum.KeyCode.KeypadTwo] = "Num2",
    [Enum.KeyCode.KeypadThree] = "Num3",
    [Enum.KeyCode.KeypadFour] = "Num4",
    [Enum.KeyCode.KeypadFive] = "Num5",
    [Enum.KeyCode.KeypadSix] = "Num6",
    [Enum.KeyCode.KeypadSeven] = "Num7",
    [Enum.KeyCode.KeypadEight] = "Num8",
    [Enum.KeyCode.KeypadNine] = "Num9",
    [Enum.KeyCode.KeypadZero] = "Num0",
    [Enum.KeyCode.Minus] = "-",
    [Enum.KeyCode.Equals] = "=",
    [Enum.KeyCode.Tilde] = "~",
    [Enum.KeyCode.LeftBracket] = "[",
    [Enum.KeyCode.RightBracket] = "]",
    [Enum.KeyCode.RightParenthesis] = ")",
    [Enum.KeyCode.LeftParenthesis] = "(",
    [Enum.KeyCode.Semicolon] = ",",
    [Enum.KeyCode.Quote] = "'",
    [Enum.KeyCode.BackSlash] = "\\",
    [Enum.KeyCode.Comma] = ",",
    [Enum.KeyCode.Period] = ".",
    [Enum.KeyCode.Slash] = "/",
    [Enum.KeyCode.Asterisk] = "*",
    [Enum.KeyCode.Plus] = "+",
    [Enum.KeyCode.Period] = ".",
    [Enum.KeyCode.Backquote] = "`",
    [Enum.UserInputType.MouseButton1] = "MB1",
    [Enum.UserInputType.MouseButton2] = "MB2",
    [Enum.UserInputType.MouseButton3] = "MB3",
    [Enum.KeyCode.Escape] = "ESC",
    [Enum.KeyCode.Space] = "SPC",
}
    
library.__index = library

for _, path in next, library.folders do 
    makefolder(library.directory .. path)
end 

if not isfile(library.directory .. "/fonts/proggyclean.ttf") then
    writefile(library.directory .. "/fonts/proggyclean.ttf", game:HttpGet("https://github.com/f1nobe7650/Nebula/raw/refs/heads/main/fs-tahoma-8px.ttf"))
end

if not isfile(library.directory .. "/fonts/smallestpixel.ttf") then
    writefile(library.directory .. "/fonts/smallestpixel.ttf", game:HttpGet("https://github.com/sonic-x64/aether/raw/refs/heads/main/SmallestPixel.ttf"))
end

if not isfile(library.directory .. "/fonts/tahomabold.ttf") then
    writefile(library.directory .. "/fonts/tahomabold.ttf", game:HttpGet("https://github.com/sonic-x64/aether/raw/refs/heads/main/TahomaBold.ttf"))
end

if not isfile(library.directory .. "/fonts/fortnite.ttf") then
    writefile(library.directory .. "/fonts/fortnite.ttf", game:HttpGet("https://github.com/sonic-x64/anxiety/raw/main/fortnite.ttf"))
end

local Fonts = {}

local ProggyCleanFace = {
    name = "ProggyClean",
    faces = {
        {
            name = "Regular",
            weight = 400,
            style = "normal",
            assetId = getcustomasset(library.directory .. "/fonts/proggyclean.ttf")
        }
    }
}

writefile( library.directory .. "/fonts/ProggyClean.font.json", http_service:JSONEncode(ProggyCleanFace))

library.font = Font.new( getcustomasset(library.directory .. "/fonts/ProggyClean.font.json"), Enum.FontWeight.Regular)

local SmallestPixelFace = {
    name = "SmallestPixel7",
    faces = {
        {
            name = "Regular",
            weight = 400,
            style = "normal",
            assetId = getcustomasset(library.directory .. "/fonts/smallestpixel.ttf")
        }
    }
}

writefile(library.directory .. "/fonts/SmallestPixel.font.json", http_service:JSONEncode(SmallestPixelFace))

Fonts.SmallestPixel = Font.new(getcustomasset(library.directory .. "/fonts/SmallestPixel.font.json"), Enum.FontWeight.Regular)

local TahomaBoldFace = {
    name = "TahomaBold",
    faces = {
        {
            name = "Regular",
            weight = 700,
            style = "normal",
            assetId = getcustomasset(library.directory .. "/fonts/tahomabold.ttf")
        }
    }
}

writefile(library.directory .. "/fonts/TahomaBold.font.json", http_service:JSONEncode(TahomaBoldFace))

Fonts.TahomaBold = Font.new(getcustomasset(library.directory .. "/fonts/TahomaBold.font.json"), Enum.FontWeight.Bold)

local FortniteFace = {
    name = "Fortnite",
    faces = {
        {
            name = "Regular",
            weight = 700,
            style = "normal",
            assetId = getcustomasset(library.directory .. "/fonts/fortnite.ttf")
        }
    }
}

writefile(library.directory .. "/fonts/fortnite.font.json", http_service:JSONEncode(FortniteFace))

Fonts.Fortnite = Font.new(getcustomasset(library.directory .. "/fonts/fortnite.font.json"), Enum.FontWeight.Bold)

cache.assetpath = "https://github.com/Horizon89002/Empyrean.lua/blob/main/image.png?raw=true" 
cache.filepath = library.directory .. "/hit_overlay.png"

if not isfile(cache.assetpath) then
    local success, imageData = pcall(function()
        return game:HttpGet(cache.assetpath)
    end)
    if success and imageData then
        writefile(cache.filepath, imageData)
    end
end

local success, result = pcall(function()
    return getcustomasset(cache.filepath)
end)
if success then
    cache.assetpath = result
end

local config_holder 
-- 

-- library functions 
-- misc functions
    function library:hoverify(hover, parent) 
        local hover_instance = library:create("Frame", {
            Parent = parent,
            BackgroundTransparency = 1,
            BorderColor3 = rgb(0, 0, 0),
            Size = dim2(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = themes.preset.accent,
            ZIndex = 1;
        }) library:apply_theme(hover_instance, "accent", "BackgroundColor3") 

        hover.MouseEnter:Connect(function()
            library:tween(hover_instance, {
                BackgroundTransparency = 0, 
            }) 
        end)
        
        hover.MouseLeave:Connect(function()
            library:tween(hover_instance, {
                BackgroundTransparency = 1, 
            }) 
        end)

        return hover_instance;
    end 

    function library:hovering(Object)
        if type(Object) == "table" then 
            local Pass = false;

            for _,obj in Object do 
                if library:hovering(obj) then 
                    Pass = true
                    return Pass
                end 
            end 
        else 
            local y_cond = Object.AbsolutePosition.Y <= mouse.Y and mouse.Y <= Object.AbsolutePosition.Y + Object.AbsoluteSize.Y
            local x_cond = Object.AbsolutePosition.X <= mouse.X and mouse.X <= Object.AbsolutePosition.X + Object.AbsoluteSize.X
            
            return (y_cond and x_cond)
        end 
    end  

    function library:make_resizable(frame) 
        local Frame = Instance.new("TextButton")
        Frame.Position = dim2(1, -10, 1, -10)
        Frame.BorderColor3 = rgb(0, 0, 0)
        Frame.Size = dim2(0, 10, 0, 10)
        Frame.BorderSizePixel = 0
        Frame.BackgroundColor3 = rgb(255, 255, 255)
        Frame.Parent = frame
        Frame.BackgroundTransparency = 1 
        Frame.Text = ""

        local resizing = false 
        local start_size 
        local start 
        local og_size = frame.Size  

        Frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                resizing = true
                start = input.Position
                start_size = frame.Size
            end
        end)

        Frame.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                resizing = false
            end
        end)

        library:connection(uis.InputChanged, function(input, game_event) 
            if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
                local viewport_x = camera.ViewportSize.X
                local viewport_y = camera.ViewportSize.Y

                local current_size = dim2(
                    start_size.X.Scale,
                    math.clamp(
                        start_size.X.Offset + (input.Position.X - start.X),
                        og_size.X.Offset,
                        viewport_x
                    ),
                    start_size.Y.Scale,
                    math.clamp(
                        start_size.Y.Offset + (input.Position.Y - start.Y),
                        og_size.Y.Offset,
                        viewport_y
                    )
                )
                frame.Size = current_size
            end
        end)
    end

    function library:draggify(frame)
        local dragging = false 
        local start_size = frame.Position
        local start 

        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                start = input.Position
                start_size = frame.Position

                if library.current_element_open then 
                    library.current_element_open.set_visible(false)
                    library.current_element_open.open = false 
                    library.current_element_open = nil 
                end 

                if frame.Parent:IsA("ScreenGui") and frame.Parent.DisplayOrder ~= 999999 then 
                    library.display_orders += 1 -- shit code
                    frame.Parent.DisplayOrder = library.display_orders
                end   
            end
        end)

        frame.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        library:connection(uis.InputChanged, function(input, game_event) 
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local viewport_x = camera.ViewportSize.X
                local viewport_y = camera.ViewportSize.Y

                local current_position = dim2(
                    0,
                    clamp(
                        start_size.X.Offset + (input.Position.X - start.X),
                        0,
                        viewport_x - frame.Size.X.Offset
                    ),
                    0,
                    clamp(
                        start_size.Y.Offset + (input.Position.Y - start.Y),
                        0,
                        viewport_y - frame.Size.Y.Offset
                    )
                )

                frame.Position = current_position
            end
        end)
    end

    function library:new_drawing(class, properties)
        local ins = Drawing.new(class)

        for _, v in next, properties do 
            ins[_] = v
        end 

        insert(aether.drawings, ins)

        return ins 
    end 
    
    function library:new_item(class, properties) 
        local ins = Instance.new(class)

        for _, v in next, properties do 
            ins[_] = v
        end 

        insert(aether.instances, ins)

        return ins 
    end 

    function library:convert_enum(enum)
        local enum_parts = {}
    
        for part in string.gmatch(enum, "[%w_]+") do
            insert(enum_parts, part)
        end
    
        local enum_table = Enum
        for i = 2, #enum_parts do
            local enum_item = enum_table[enum_parts[i]]
    
            enum_table = enum_item
        end
    
        return enum_table
    end

    function library:tween(obj, properties) 
        local tween = tween_service:Create(obj, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0), properties):Play()
            
        return tween
    end 

    function library:config_list_update() 
        if not config_holder then return end 
    
        local list = {}
    
        for idx, file in next, listfiles(library.directory .. "/configs") do
            local name = string.sub(file:gsub(library.directory .. "/configs\\", ""):gsub(library.directory .. "\\configs\\", ""), 1, -5)
            list[#list + 1] = name
        end
        
        config_holder.refresh_options(list)
    end 

    function library:get_config()
        local Config = {}
    
        for _, v in flags do
            if type(v) == "table" and v.key then
                Config[_] = {active = v.active, mode = v.mode, key = tostring(v.key)}
            elseif type(v) == "table" and v["Transparency"] and v["Color"] then
                Config[_] = {Transparency = v["Transparency"], Color = v["Color"]:ToHex()}
            else
                Config[_] = v
            end
        end 
        
        return http_service:JSONEncode(Config)
    end

    function library:load_config(config_json)
        local config = http_service:JSONDecode(config_json)

        for flag, value in next, config do
            local set_flag = library.config_flags[flag]
            if not set_flag then
                continue
            end

            if type(value) == "table" then
                if value.Color and value.Transparency then
                    set_flag(hex(value.Color), value.Transparency)
                elseif value.key ~= nil or value.mode ~= nil then
                    set_flag(value)
                elseif value.active ~= nil then
                    set_flag(value.active)
                else
                    set_flag(value)
                end
            else
                set_flag(value)
            end
        end
    end

    function library:round(number, float) 
        local multiplier = 1 / (float or 1)

        return floor(number * multiplier + 0.5) / multiplier
    end 

    function library:apply_theme(instance, theme, property) 
        insert(themes.utility[theme][property], instance)
    end

    function library:update_theme(theme, color)
        for _, property in next, themes.utility[theme] do 

            for m, object in next, property do 
                if object[_] == themes.preset[theme] or object.ClassName == "UIGradient" then
                    object[_] = color 
                end
            end 
        end 

        themes.preset[theme] = color 
    end 

    function library:connection(signal, callback)
        local connection = signal:Connect(callback)
        
        insert(library.connections, connection)

        return connection 
    end

    function library:apply_stroke(parent) 
        local stroke = library:create("UIStroke", {
            Parent = parent,
            Color = themes.preset.text_outline, 
            LineJoinMode = Enum.LineJoinMode.Miter
        }) 
        
        library:apply_theme(stroke, "text_outline", "Color")
    end

    function library:create(instance, options)
        local ins = Instance.new(instance) 
        
        for prop, value in next, options do 
            ins[prop] = value
        end
        
        if instance == "TextLabel" or instance == "TextButton" or instance == "TextBox" then 	
            library:apply_theme(ins, "text", "TextColor3")
            library:apply_stroke(ins)
        elseif instance == "ScreenGui" then 
            insert(library.guis, ins)
        end
        
        return ins 
    end
    
-- 

-- elements 
    local tooltip_sgui = library:create("ScreenGui", {
        Enabled = true,
        Parent = gethui(),
        Name = "",
        DisplayOrder = 500, 
    })

    function library:tool_tip(options) 
        local cfg = {
            name = options.name or "hi", 
            path = options.path or nil, 
        }

        if cfg.path then 
            local watermark_outline = library:create("Frame", {
                Parent = tooltip_sgui,
                Name = "",
                Size = dim2(0, 0, 0, 22),
                Position = dim2(0, 500, 0, 300),
                BorderColor3 = rgb(0, 0, 0),
                BorderSizePixel = 0,
                Visible = false,
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundColor3 = themes.preset.outline
            })
            
            local watermark_inline = library:create("Frame", {
                Parent = watermark_outline,
                Name = "",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.inline
            })
            
            local watermark_background = library:create("Frame", {
                Parent = watermark_inline,
                Name = "",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            local UIGradient = library:create("UIGradient", {
                Parent = watermark_background,
                Name = "",
                Color = rgbseq{rgbkey(0, rgb(41, 41, 55)), rgbkey(1, rgb(35, 35, 47))}
            }); library:apply_theme(UIGradient, "contrast", "Color")
            
            local text = library:create("TextLabel", {
                Parent = watermark_background,
                Name = "",
                FontFace = library.font,
                TextColor3 = themes.preset.text,
                BorderColor3 = rgb(0, 0, 0),
                Text = " " .. cfg.name .. " ",
                Size = dim2(0, 0, 1, 0),
                BackgroundTransparency = 1,
                Position = dim2(0, 0, 0, -1),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.X,
                TextSize = 12,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            local UIStroke = library:create("UIStroke", {
                Parent = text,
                Name = "",
                LineJoinMode = Enum.LineJoinMode.Miter
            })

            cfg.path.MouseEnter:Connect(function()
                watermark_outline.Visible = true 
            end)   

            cfg.path.MouseLeave:Connect(function()
                watermark_outline.Visible = false 
            end)

            library:connection(uis.InputChanged, function(input)
                if watermark_outline.Visible and input.UserInputType == Enum.UserInputType.MouseMovement then
                    watermark_outline.Position = dim_offset(input.Position.X + 10, input.Position.Y + 10)
                end
            end)
        end 
        
        return cfg
    end 

    function library:panel(options) 
        local cfg = {
            name = options.text or options.name or "Window", 
            size = options.size or dim2(0, 530, 0, 590),
            position = options.position or dim2(0, 500, 0, 500),
            anchor_point = options.anchor_point or vec2(0, 0),

            -- button
            image = options.image or "rbxassetid://79856374238119",
            open = options.open or true,

            -- ignore
            items = {},
        }
        
        local items = cfg.items do 
            -- Panel
                items.sgui = library:create("ScreenGui", {
                    Enabled = true,
                    Parent = gethui(),
                    Name = "" 
                })
                
                items.main_holder = library:create("Frame", {
                    Parent = items.sgui,
                    Name = "",
                    AnchorPoint = vec2(cfg.anchor_point.X, cfg.anchor_point.Y),
                    Position = cfg.position,
                    Active = true, 
                    BorderColor3 = rgb(0, 0, 0),
                    Size = cfg.size,
                    BorderSizePixel = 0,
                    BackgroundColor3 = themes.preset.outline
                })
                library:draggify(items.main_holder)
                library:make_resizable(items.main_holder)

                local Close = library:create( "TextButton" , {
                    Parent = items.main_holder;
                    FontFace = library.font;
                    Name = "\0";
                    AnchorPoint = vec2(1, 0);
                    Active = false;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "X";
                    Size = dim2(0, 0, 0, 0);
                    Selectable = false;
                    Position = dim2(1, -7, 0, 5);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Right;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextColor3 = themes.preset.text;
                    TextSize = 12;
                    ZIndex = 100;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                library:create( "UIStroke" , {
                    Parent = Close
                });         
                
                Close.MouseButton1Click:Connect(function()
                    items.sgui.Enabled = false;
                end)

                --library:apply_theme(main_holder, "outline", "BackgroundColor3") 
                
                items.window_inline = library:create("Frame", {
                    Parent = items.main_holder,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = themes.preset.accent
                })
                
                library:apply_theme(items.window_inline, "accent", "BackgroundColor3") 
                
                items.window_holder = library:create("Frame", {
                    Parent = items.window_inline,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = themes.preset.outline,
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                            
                items.UIGradient = library:create("UIGradient", {
                    Parent = items.window_holder,
                    Name = "",
                    Rotation = 90,
                    Color = rgbseq{
                    rgbkey(0, rgb(41, 41, 55)),
                    rgbkey(1, rgb(35, 35, 47))
                }
                })
    
                library:apply_theme(items.UIGradient, "contrast", "Color") 
                
                items.text = library:create("TextLabel", {
                    Parent = items.window_holder,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = themes.preset.accent,
                    BorderColor3 = rgb(0, 0, 0),
                    Text = cfg.name,
                    BackgroundTransparency = 1,
                    Position = dim2(0, 2, 0, 4),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextSize = 12,
                    BackgroundColor3 = rgb(255, 255, 255)
                }) library:apply_theme(items.text, "accent", "TextColor3")
                
                items.UIStroke = library:create("UIStroke", {
                    Parent = items.text,
                    Name = "",
                    LineJoinMode = Enum.LineJoinMode.Miter
                })
                
                items.UIPadding = library:create("UIPadding", {
                    Parent = items.window_holder,
                    Name = "",
                    PaddingBottom = dim(0, 4),
                    PaddingRight = dim(0, 4),
                    PaddingLeft = dim(0, 4)
                })
                
                items.outline = library:create("Frame", {
                    Parent = items.window_holder,
                    Name = "",
                    Position = dim2(0, 0, 0, 18),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, 0, 1, -18),
                    BorderSizePixel = 0,
                    BackgroundColor3 = themes.preset.inline
                })
                
                library:apply_theme(items.outline, "inline", "BackgroundColor3") 
                
                items.inline = library:create("Frame", {
                    Parent = items.outline,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = themes.preset.outline
                })
                
                library:apply_theme(items.inline, "outline", "BackgroundColor3") 
                
                items.holder = library:create("Frame", {
                    Parent = items.inline,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                items.UIGradient = library:create("UIGradient", {
                    Parent = items.holder,
                    Name = "",
                    Rotation = 90,
                    Color = rgbseq{
                        rgbkey(0, rgb(41, 41, 55)),
                        rgbkey(1, rgb(35, 35, 47))
                    }
                })
                
                library:apply_theme(items.UIGradient, "contrast", "Color") 
                
                items.UIPadding = library:create("UIPadding", {
                    Parent = items.holder,
                    Name = "",
                    PaddingTop = dim(0, 5),
                    PaddingBottom = dim(0, 5),
                    PaddingRight = dim(0, 5),
                    PaddingLeft = dim(0, 5)
                })
                
                items.glow = library:create("ImageLabel", {
                    Parent = items.main_holder,
                    Name = "",
                    ImageColor3 = themes.preset.glow,
                    ScaleType = Enum.ScaleType.Slice,
                    BorderColor3 = rgb(0, 0, 0),
                    BackgroundColor3 = rgb(255, 255, 255),
                    Visible = true,
                    Image = "http://www.roblox.com/asset/?id=18245826428",
                    BackgroundTransparency = 1,
                    ImageTransparency = 0.8, 
                    Position = dim2(0, -20, 0, -20),
                    Size = dim2(1, 40, 1, 40),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    SliceCenter = rect(vec2(21, 21), vec2(79, 79))
                }) library:apply_theme(items.glow, "glow", "ImageColor3") 
            -- 
            
            -- Button
                items.button = library:create("TextButton", {
                    Parent = library.dock_holder,
                    Name = "",
                    TextColor3 = rgb(0, 0, 0),
                    BorderColor3 = rgb(0, 0, 0),
                    Text = "",
                    Size = dim2(0, 25, 0, 25),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = themes.preset.inline
                })
                
                local button_inline = library:create("Frame", {
                    Parent = items.button,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = themes.preset.outline
                }) library:apply_theme(button_inline, "outline", "BackgroundColor3") 
                
                local button_inline = library:create("Frame", {
                    Parent = button_inline,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                }) library:apply_theme(button_inline, "inline", "BackgroundColor3")
                
                local UIGradient = library:create("UIGradient", {
                    Parent = button_inline,
                    Name = "",
                    Rotation = 90,
                    Color = rgbseq{
                        rgbkey(0, rgb(35, 35, 47)),
                        rgbkey(1, rgb(41, 41, 55))
                    }
                }) library:apply_theme(UIGradient, "contrast", "Color") 
                
                items.Icon = library:create("ImageLabel", {
                    Parent = button_inline,
                    Name = "",
                    ImageColor3 = themes.preset.accent,
                    Image = cfg.image,
                    BackgroundTransparency = 1,
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                }) library:apply_theme(items.Icon, "accent", "ImageColor3") library:apply_theme(items.Icon, "inline", "ImageColor3") 
                
                local UIPadding = library:create("UIPadding", {
                    Parent = button_inline,
                    Name = "",
                    PaddingTop = dim(0, 4),
                    PaddingBottom = dim(0, 4),
                    PaddingRight = dim(0, 4),
                    PaddingLeft = dim(0, 4)
                })
            -- 

            library:tool_tip({name = cfg.name, path = items.button})
        end 

        items.sgui:GetPropertyChangedSignal("Enabled"):Connect(function()
            items.Icon.ImageColor3 = items.sgui.Enabled and themes.preset.accent or themes.preset.inline
        end)

        items.button.MouseButton1Click:Connect(function()
            items.sgui.Enabled = not items.sgui.Enabled
        end)
        
        return setmetatable(cfg, library)
    end 

    local sgui = library:create("ScreenGui", {
        Enabled = true,
        Parent = gethui(),
        Name = "",
        DisplayOrder = 999999, 
    })

    local notif_holder = library:create("ScreenGui", {
        Parent = gethui(),
        Name = "",
        IgnoreGuiInset = true, 
        DisplayOrder = 999999, 
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })

    function library:fold_elements(origin, elements)
        for _, x in next, elements do 
            local flag = library.visible_flags[x]

            if flag then    
                flag(flags[origin])
            end     
        end 
    end 

    function library:indicator() 
        local cfg = {
            items = {};
        }

        local items = cfg.items; do 
            items.Window = library:create( "Frame" , {
                Parent = sgui;
                Name = "\0";
                AnchorPoint = vec2(0.5, 0.5);
                Position = dim2(0.5, 0, 0.5, math.floor(camera.ViewportSize.Y * 0.3));
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(0, 322, 0, 147);
                BorderSizePixel = 0;
                BackgroundColor3 = themes.preset.outline
            });	library:apply_theme(items.Window, "outline", "BackgroundColor3");
            
            items.InfoTitle = library:create( "TextLabel" , {
                FontFace = library.font;
                TextColor3 = themes.preset.text;
                BorderColor3 = rgb(0, 0, 0);
                Text = "Indicators";
                Parent = items.Window;
                Name = "\0";
                Size = dim2(1, 0, 0, 0);
                Position = dim2(0, 7, 0, 5);
                BackgroundTransparency = 1;
                TextXAlignment = Enum.TextXAlignment.Left;
                BorderSizePixel = 0;
                ZIndex = 5;
                AutomaticSize = Enum.AutomaticSize.Y;
                TextSize = 12;
            }); 

            items.Accent = library:create( "Frame" , {
                Parent = items.Window;
                Name = "\0";
                Position = dim2(0, 1, 0, 1);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, -2, 1, -2);
                BorderSizePixel = 0;
                BackgroundColor3 = themes.preset.accent
            });	library:apply_theme(items.Accent, "accent", "BackgroundColor3")
            
            items.Background = library:create( "Frame" , {
                Parent = items.Accent;
                Name = "\0";
                Position = dim2(0, 1, 0, 1);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, -2, 1, -2);
                BorderSizePixel = 0;
                BackgroundColor3 = themes.preset.high_contrast
            });	library:apply_theme(items.Background, "high_contrast", "BackgroundColor3")
            
            items.Inline = library:create( "Frame" , {
                Parent = items.Background;
                Name = "\0";
                Position = dim2(0, 4, 0, 18);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, -8, 1, -22);
                BorderSizePixel = 0;
                BackgroundColor3 = themes.preset.outline
            });	library:apply_theme(items.Inline, "outline", "BackgroundColor3")
            
            items.Outline = library:create( "Frame" , {
                Parent = items.Inline;
                Name = "\0";
                Position = dim2(0, 1, 0, 1);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, -2, 1, -2);
                BorderSizePixel = 0;
                BackgroundColor3 = themes.preset.inline
            });	library:apply_theme(items.Outline, "inline", "BackgroundColor3")
            
            items.LowContrast = library:create( "Frame" , {
                Parent = items.Outline;
                Name = "\0";
                Position = dim2(0, 1, 0, 1);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, -2, 1, -2);
                BorderSizePixel = 0;
                BackgroundColor3 = themes.preset.low_contrast
            });	library:apply_theme(items.LowContrast, "low_contrast", "BackgroundColor3")
            
            items.Inline = library:create( "Frame" , {
                Parent = items.LowContrast;
                Name = "\0";
                Position = dim2(0, 4, 0, 4);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, -8, 1, -8);
                BorderSizePixel = 0;
                BackgroundColor3 = themes.preset.inline
            });	library:apply_theme(items.Inline, "inline", "BackgroundColor3")
            
            items.Outline = library:create( "Frame" , {
                Parent = items.Inline;
                Name = "\0";
                Position = dim2(0, 1, 0, 1);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, -2, 1, -2);
                BorderSizePixel = 0;
                BackgroundColor3 = themes.preset.outline
            });	library:apply_theme(items.Outline, "outline", "BackgroundColor3")
            
            items.LowContrast = library:create( "Frame" , {
                Parent = items.Outline;
                Name = "\0";
                Position = dim2(0, 1, 0, 1);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, -2, 1, -2);
                BorderSizePixel = 0;
                BackgroundColor3 = themes.preset.low_contrast
            });	library:apply_theme(items.LowContrast, "low_contrast", "BackgroundColor3"); local image_holder = items.LowContrast;
            
            items.Inline = library:create( "Frame" , {
                Parent = items.LowContrast;
                Name = "\0";
                Position = dim2(0, 4, 0, 4);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, -8, 1, -8);
                BorderSizePixel = 0;
                BackgroundColor3 = themes.preset.inline
            });	library:apply_theme(items.Inline, "inline", "BackgroundColor3")
            
            items.Outline = library:create( "Frame" , {
                Parent = items.Inline;
                Name = "\0";
                Position = dim2(0, 1, 0, 1);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, -2, 1, -2);
                BorderSizePixel = 0;
                BackgroundColor3 = themes.preset.outline
            });	library:apply_theme(items.Outline, "outline", "BackgroundColor3")
            
            items.LowContrast = library:create( "Frame" , {
                Parent = items.Outline;
                Name = "\0";
                Position = dim2(0, 1, 0, 1);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, -2, 1, -2);
                BorderSizePixel = 0;
                BackgroundColor3 = themes.preset.low_contrast
            });	library:apply_theme(items.LowContrast, "low_contrast", "BackgroundColor3")

            items.InfoTitle = library:create( "TextLabel" , {
                FontFace = library.font;
                TextColor3 = themes.preset.text;
                BorderColor3 = rgb(0, 0, 0);
                Text = "Info";
                Parent = items.Outline;
                Name = "\0";
                Size = dim2(1, 0, 0, 0);
                Position = dim2(0, 7, 0, 5);
                BackgroundTransparency = 1;
                TextXAlignment = Enum.TextXAlignment.Left;
                BorderSizePixel = 0;
                ZIndex = 5;
                AutomaticSize = Enum.AutomaticSize.Y;
                TextSize = 12;
            });

            library:create( "UIStroke" , {
                Parent = items.InfoTitle
            });
            
            items.Accent = library:create( "Frame" , {
                Name = "\0";
                Parent = items.LowContrast;
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, 0, 0, 2);
                BackgroundColor3 = themes.preset.accent;
                BorderSizePixel = 0;
            });	library:apply_theme(items.Accent, "accent", "BackgroundColor3");
            
            items.Shadow = library:create( "Frame" , {
                AnchorPoint = vec2(0, 1);
                Parent = items.Accent;
                Name = "\0";
                Position = dim2(0, 0, 1, 0);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, 0, 0, 1);
                BorderSizePixel = 0;
                BackgroundColor3 = themes.preset.accent;
            }); library:apply_theme(items.Shadow, "accent", "BackgroundColor3");
            
            library:create( "UIGradient" , {
                Rotation = 90;
                Parent = items.Shadow;
                Color = rgbseq{rgbkey(0, rgb(150, 150, 150)), rgbkey(1, rgb(150, 150, 150))}
            });
            
            items.holder = library:create( "Frame" , {
                Parent = items.LowContrast;
                Name = "\0";
                Position = dim2(0, 76, 0, 21);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, -80, 0, 0);
                BorderSizePixel = 0;
            });	

            library:create("UIListLayout", {
                Parent = items.holder,
                Padding = dim(0, 4),
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            })

            items.Inline = library:create( "Frame" , {
                Parent = image_holder;
                Name = "\0";
                Position = dim2(0, 10, 0, 28);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(0, 68, 0, 67);
                BorderSizePixel = 0;
                BackgroundColor3 = themes.preset.outline
            });	library:apply_theme(items.Inline, "outline", "BackgroundColor3")
            
            items.Outline = library:create( "Frame" , {
                Parent = items.Inline;
                Name = "\0";
                Position = dim2(0, 1, 0, 1);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, -2, 1, -2);
                BorderSizePixel = 0;
                BackgroundColor3 = themes.preset.inline
            });	library:apply_theme(items.Outline, "inline", "BackgroundColor3")
            
            items.LowContrast = library:create( "Frame" , {
                Parent = items.Outline;
                Name = "\0";
                Position = dim2(0, 1, 0, 1);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, -2, 1, -2);
                BorderSizePixel = 0;
                BackgroundColor3 = themes.preset.low_contrast
            });	library:apply_theme(items.LowContrast, "low_contrast", "BackgroundColor3")

            items.Profile = library:create( "ImageLabel" , {
                BorderColor3 = rgb(0, 0, 0);
                Parent = items.LowContrast;
                Image = "rbxasset://textures/ui/GuiImagePlaceholder.png";
                BackgroundTransparency = 1;
                Name = "\0";
                Size = dim2(1, 0, 1, 0);
                BorderSizePixel = 0;
            });	

            local section = setmetatable(items, library)
            items.label = section:label({name = "Player: "})
            items.slider = section:slider({name = "Health", custom = rgb(28, 110, 26), min = 0, max = 100, default = 50, input = true})
            
            library:create( "UIStroke" , {
                Parent = items.InfoTitle
            });            
        end

        function cfg.set_position(position)
            local tween_info = TweenInfo.new(
                0.45,
                Enum.EasingStyle.Sine,      
                Enum.EasingDirection.Out
            )

            tween_service:Create(items.Window, tween_info, {Position = position}):Play()
        end

        function cfg.set_visible(bool)
            items.Window.Visible = bool
        end 

        function cfg.change_health(int)
            items.slider.set(int)
        end

        function cfg.change_profile(player)
            items.label.set(string.format("Player: %s", player.DisplayName))
            items.Profile.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=".. player.UserId .."&width=420&height=420&format=png"
        end 

        return setmetatable(cfg, library)
    end     

    function library:window(properties)
        local window = {opened = true}            
        local opened = {}
        local dock_outline;
        local blur = library:create( "BlurEffect" , {
            Parent = lighting;
            Enabled = true;
            Size = 15
        });    

        library.cache = library:create("ScreenGui", {
            Enabled = false,
            Parent = gethui(),
            Name = "" 
        })

        function window.set_menu_visibility(bool) 
            window.opened = bool 
            cache.menu_opened = bool
            
            if bool then 
                for _,gui in opened do 
                    gui.Enabled = true 
                    opened = {}
                end 
            else
                for _,gui in library.guis do 
                    if gui.Enabled then 
                        gui.Enabled = false
                        table.insert(opened, gui)
                    end
                end
            end

            library:tween(blur, {Size = bool and (flags["Blur Size"] or 15) or 0})

            dock_outline.Visible = bool;

            sgui.Enabled = true
            notif_holder.Enabled = true
            tooltip_sgui.Enabled = true
            library.cache.Enabled = false

            for _,tooltip in tooltip_sgui:GetChildren() do 
                tooltip.Visible = false;
            end 

            if library.current_element_open then 
                library.current_element_open.set_visible(false)
                library.current_element_open.open = false 
                library.current_element_open = nil 
            end
        end 

        -- dock init
            dock_outline = library:create("Frame", {
                Parent = sgui,
                Name = "",
                Visible = true,
                BorderColor3 = rgb(0, 0, 0),
                AnchorPoint = vec2(0.5, 0),
                Position = dim2(0.5, 0, 0, 20),
                Size = dim2(0, 157, 0, 39),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.outline
            }); 

            library:apply_theme(dock_outline, "outline", "BackgroundColor3"); 
            dock_outline.Position = dim2(0, dock_outline.AbsolutePosition.X, 0, dock_outline.AbsolutePosition.Y); 
            dock_outline.AnchorPoint = vec2(0, 0); 
            library:draggify(dock_outline);

            local dock_inline = library:create("Frame", {
                Parent = dock_outline,
                Name = "",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.inline
            }) library:apply_theme(dock_inline, "inline", "BackgroundColor3") 
            
            local dock_holder = library:create("Frame", {
                Parent = dock_inline,
                Name = "",
                Size = dim2(1, -2, 1, -2),
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = themes.preset.outline,
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            }) library:apply_theme(dock_holder, "outline", "BackgroundColor3") 
            
            local accent = library:create("Frame", {
                Parent = dock_holder,
                Name = "",
                Size = dim2(1, 0, 0, 2),
                BorderColor3 = rgb(0, 0, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.accent
            }) library:apply_theme(accent, "accent", "BackgroundColor3") 
            
            local UIGradient = library:create("UIGradient", {
                Parent = accent,
                Name = "",
                Rotation = 90,
                Color = rgbseq{
                rgbkey(0, rgb(255, 255, 255)),
                rgbkey(1, rgb(167, 167, 167))
            }
            })
            
            local button_holder = library:create("Frame", {
                Parent = dock_holder,
                Name = "",
                BackgroundTransparency = 1,
                Size = dim2(1, 0, 1, 0),
                BorderColor3 = rgb(0, 0, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            }) library.dock_holder = button_holder;
            
            local UIListLayout = library:create("UIListLayout", {
                Parent = button_holder,
                Name = "",
                Padding = dim(0, 5),
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder
            })
            
            local UIPadding = library:create("UIPadding", {
                Parent = button_holder,
                Name = "",
                PaddingTop = dim(0, 6),
                PaddingBottom = dim(0, 4),
                PaddingRight = dim(0, 4),
                PaddingLeft = dim(0, 4)
            })
                    
            local UIGradient = library:create("UIGradient", {
                Parent = dock_holder,
                Name = "",
                Rotation = 90,
                Color = rgbseq{
                    rgbkey(0, rgb(41, 41, 55)),
                    rgbkey(1, rgb(35, 35, 47))
                }
            }) library:apply_theme(UIGradient, "contrast", "Color") 
        -- 

        -- keybind list
            local outline = library:create("Frame", {
                Parent = sgui,
                Name = "",
                Visible = false, 
                Active = true,
                Draggable = true, 
                Position = dim2(0, 50, 0, 200),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(0, 182, 0, 25),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.outline
            })
            library:apply_theme(outline, "outline", "BackgroundColor3") 
            library:draggify(outline)
            library:make_resizable(outline)
            library.keybind_list_frame = outline 
            
            local inline = library:create("Frame", {
                Parent = outline,
                Name = "",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.inline
            })
            library:apply_theme(inline, "inline", "BackgroundColor3")

            local background = library:create("Frame", {
                Parent = inline,
                Name = "",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            local UIGradient = library:create("UIGradient", {
                Parent = background,
                Name = "",
                Rotation = 90,
                Color = rgbseq{
                    rgbkey(0, themes.preset.high_contrast),
                    rgbkey(1, themes.preset.low_contrast)
                }
            })
            library:apply_theme(UIGradient, "contrast", "Color") 
            
            local bg = library:create("Frame", {
                Parent = background,
                Name = "a",
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, 0, 0, 2),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.accent
            }); library:apply_theme(bg, "accent", "BackgroundColor3")
            
            
            library:create("UIGradient", {
                Parent = bg,
                Name = "",
                Enabled = true, 
                Rotation = 90,
                Color = rgbseq{
                    rgbkey(0, rgb(255, 255, 255)),
                    rgbkey(1, rgb(167, 167, 167))
                }
            })
            
            local text = library:create("TextLabel", {
                Parent = background,
                Name = "",
                FontFace = library.font,
                TextColor3 = themes.preset.text,
                BorderColor3 = rgb(0, 0, 0),
                Text = "Keybinds",
                BackgroundTransparency = 1,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Size = dim2(1, 0, 1, 0),
                BorderSizePixel = 0,
                TextSize = 12,
                BackgroundColor3 = themes.preset.text
            }, "text")
            
            local UIStroke = library:create("UIStroke", {
                Parent = text,
                Name = "",
                LineJoinMode = Enum.LineJoinMode.Miter
            })
            
            local text_holder = library:create("Frame", {
                Parent = background,
                Name = "",
                Position = dim2(0, -2, 1, 1),
                Size = dim2(1, 4, 0, 0),
                BorderColor3 = rgb(0, 0, 0),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = themes.preset.outline
            })
            library:apply_theme(text_holder, "outline", "BackgroundColor3")

            local inline = library:create("Frame", {
                Parent = text_holder,
                Name = "",
                Size = dim2(1, -2, 1, -2),
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                BorderSizePixel = 0,
                --AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = themes.preset.inline
            })
            library:apply_theme(inline, "inline", "BackgroundColor3")
            
            local background = library:create("Frame", {
                Parent = inline,
                Name = "",
                Size = dim2(1, -2, 1, -2),
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                BorderSizePixel = 0,
                --AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            library.keybind_list = background
            
            local UIGradient = library:create("UIGradient", {
                Parent = background,
                Name = "",
                Rotation = 90,
                Color = rgbseq{
                    rgbkey(0, themes.preset.high_contrast),
                    rgbkey(1, themes.preset.low_contrast)
                }
            })
            library:apply_theme(UIGradient, "contrast", "Color") 
            
            library:create("UIListLayout", {
                Parent = background,
                Name = "",
                Padding = dim(0, -1),
                SortOrder = Enum.SortOrder.LayoutOrder
            })
            
            library:create("UIPadding", {
                Parent = background,
                Name = "",
                PaddingBottom = dim(0, 4),
                PaddingLeft = dim(0, 5)
            })
        --  

        -- main window
            local main_window = library:panel({
                name = properties and properties.name or "aether | ", 
                size = dim2(0, 604, 0, 628),
                position = dim2(0, (camera.ViewportSize.X / 2) - 302 - 96, 0, (camera.ViewportSize.Y / 2) - 421 - 12),
                image = "rbxassetid://98823308062942",
            })

            local items = main_window.items

            window["tab_holder"] = library:create("Frame", {
                Parent = items.holder,
                Name = " ",
                BackgroundTransparency = 1,
                Size = dim2(1, 0, 0, 22),
                BorderColor3 = rgb(0, 0, 0),
                ZIndex = 5,
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            })

            library:create("UIListLayout", {
                Parent = window["tab_holder"],
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalFlex = Enum.UIFlexAlignment.Fill,
                Padding = dim(0, 2),
                SortOrder = Enum.SortOrder.LayoutOrder
            })

            local section_holder = library:create("Frame", {
                Parent = items.holder,
                Name = " ",
                BackgroundTransparency = 1,
                Position = dim2(0, -1, 0, 19),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, 0, 1, -22),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            window["section_holder"] = section_holder

            local outline = library:create("Frame", {
                Parent = section_holder,
                Name = "\0",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, 0, 1, 2),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.outline
            })
            
            library:apply_theme(outline, "outline", "BackgroundColor3") 

            local inline = library:create("Frame", {
                Parent = outline,
                Name = "\0",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.inline
            })
            
            library:apply_theme(inline, "inline", "BackgroundColor3") 

            local background = library:create("Frame", {
                Parent = inline,
                Name = "\0",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            })

            library.section_holder = background

            library:create("UIPadding", {
                Parent = background,
                PaddingTop = dim(0, 4),
                PaddingBottom = dim(0, 4),
                PaddingRight = dim(0, 4),
                PaddingLeft = dim(0, 4)
            })

            local UIGradient = library:create("UIGradient", {
                Parent = background,
                Rotation = 90,
                Color = rgbseq{
                    rgbkey(0, rgb(41, 41, 55)),
                    rgbkey(1, rgb(35, 35, 47))
                }
            })
            
            library:apply_theme(UIGradient, "contrast", "Color") 
            library:make_resizable(items.main_holder) 
        -- 

        -- theming 
            local style = library:panel({
                name = "Style", 
                anchor_point = vec2(0, 0),
                size = dim2(0, 394, 0, 464),
                position = dim2(0, main_window.items.main_holder.AbsolutePosition.X + main_window.items.main_holder.AbsoluteSize.X + 2, 0, main_window.items.main_holder.AbsolutePosition.Y),
                image = "rbxassetid://115194686863276",
            })

            local watermark = library:watermark({default = os.date('aether |  - %b %d %Y - %H:%M:%S')})  

            task.spawn(function()
                while task.wait(1) do 

                    local date = os.date('%b %d %Y')
                    local time = os.date('%H:%M:%S')

                    local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
                    local gameId = game.PlaceId

                    watermark.change_text(string.format("Aether - Beta | Build: Live | Game: %s | GameId: %s | Date: %s | Time: %s ", gameName, gameId, date, time))
                end 
            end)

            local items = style.items

            local column = setmetatable(items, library):column() 
            local section = column:section({name = "Theme"})
            section:label({name = "Accent"})
            :colorpicker({name = "Accent", color = themes.preset.accent, flag = "accent", callback = function(color, alpha)
                accent_color = string.format("rgb(%d, %d, %d)", flags["Accent"].Color.R * 255, flags["Accent"].Color.G * 255, flags["Accent"].Color.B * 255)

                library:update_theme("accent", color)
            end, flag = "Accent"})
            section:label({name = "Contrast"})
            :colorpicker({name = "Low", color = themes.preset.low_contrast, flag = "low_contrast", callback = function(color)
                if (flags["high_contrast"] and flags["low_contrast"]) then 
                    library:update_theme("contrast", rgbseq{
                        rgbkey(0, flags["low_contrast"].Color),
                        rgbkey(1, flags["high_contrast"].Color)
                    })
                end 

                library:update_theme("low_contrast", flags["low_contrast"].Color)
            end})
            :colorpicker({name = "High", color = themes.preset.high_contrast, flag = "high_contrast", callback = function(color)
                library:update_theme("contrast", rgbseq{
                    rgbkey(0, flags["low_contrast"].Color),
                    rgbkey(1, flags["high_contrast"].Color)
                })

                library:update_theme("high_contrast", flags["high_contrast"].Color)
            end})
            section:label({name = "Inline"})
            :colorpicker({name = "Inline", color = themes.preset.inline, callback = function(color, alpha)
                library:update_theme("inline", color)
            end, flag = "Inline"})
            section:label({name = "Outline"})
            :colorpicker({name = "Outline", color = themes.preset.outline, callback = function(color, alpha)
                library:update_theme("outline", color)
            end, flag = "Outline"})
            section:label({name = "Text Color"})
            :colorpicker({name = "Main", color = themes.preset.text, callback = function(color, alpha)
                library:update_theme("text", color)
            end, flag = "Main"})
            :colorpicker({name = "Outline", color = themes.preset.text_outline, callback = function(color, alpha)
                library:update_theme("text_outline", color)
            end, flag = "Outline"})
            section:label({name = "Glow"})
            :colorpicker({name = "Glow", color = themes.preset.glow, callback = function(color, alpha)
                library:update_theme("glow", color)
            end, flag = "Glow"})
            section:slider({name = "Blur Size", flag = "Blur Size", min = 0, max = 56, default = 15, interval = 1, callback = function(int)
                if window.opened then 
                    blur.Size = int
                end
            end})

            section:dropdown({
                name = "Theme",
                flag = "selected_theme",
                items = theme_names,
                default = "Default"
            })

            section:button_holder({})
            section:button({
                name = "Apply Theme",
                callback = function()
                    local theme_name = flags["selected_theme"]
                    local theme = themepresets[theme_name]
                    if not theme then return end

                    if theme.accent and library.config_flags["Accent"] then
                        library.config_flags["Accent"](theme.accent)
                        accent_color = string.format(
                            "rgb(%d, %d, %d)",
                            theme.accent.R * 255,
                            theme.accent.G * 255,
                            theme.accent.B * 255
                        )
                    end

                    library:notification({text = "Changed Theme to: " ..theme_name, time = flags["notification_duration"]})

                    library.config_flags["low_contrast"](theme.low_contrast)
                    library.config_flags["high_contrast"](theme.high_contrast)
                    library.config_flags["Inline"](theme.inline)
                    library.config_flags["Outline"](theme.outline)
                    library.config_flags["Main"](theme.text)
                    library.config_flags["Outline"](theme.text_outline)
                    library.config_flags["Glow"](theme.glow)
                    library.config_flags["Blur Size"](theme.blur_size)

                    if theme.low_contrast and theme.high_contrast then
                        library:update_theme("contrast", rgbseq{
                            rgbkey(0, theme.low_contrast),
                            rgbkey(1, theme.high_contrast)
                        })
                    end
                end
            })

            section:button_holder({})
            section:button({
                name = "Random Color Theme",
                callback = function()
                    local excluded_flags = {
                        low_contrast = true,
                        state_color = true,
                        name_color = true,
                        tool_color = true,
                        distance_color = true,
                        high_contrast = true,
                        boxglow_color1 = true,
                        boxglow_color2 = true,
                        boxglow_color3 = true,
                        boxfill_color1 = true,
                        boxfill_color2 = true,
                        boxfill_color3 = true,
                        Inline = true,
                        Outline = true,
                        Main = true,
                        ["Blur Size"] = true,
                        text_outline = true
                    }

                    local color = funcs.random_color()
                    local alpha = 1

                    local brighter = brighten(color, 0.12)
                    local darker = darken(color, 0.12)

                    library.config_flags["boxglow_color1"](brighter, 1)
                    library.config_flags["boxglow_color2"](color, 1)
                    library.config_flags["boxglow_color3"](darker, 1)

                    library.config_flags["boxfill_color1"](brighter, 1)
                    library.config_flags["boxfill_color2"](color, 1)
                    library.config_flags["boxfill_color3"](darker, 1)

                    library.config_flags["aura_color_1"](brighter, 1)
                    library.config_flags["aura_color_2"](color, 1)
                    library.config_flags["aura_color_3"](darker, 1)

                    library.config_flags["silentaim_fov_gradient_color1"](brighter, 1)
                    library.config_flags["silentaim_fov_gradient_color2"](color, 1)
                    library.config_flags["silentaim_fov_gradient_color3"](darker, 1)

                    for flag, setter in pairs(library.config_flags) do
                        local flag_value = flags[flag]

                        if not excluded_flags[flag] and typeof(setter) == "function" and typeof(flag_value) == "table" and typeof(flag_value.Color) == "Color3" and typeof(flag_value.Transparency) == "number" then
                            setter(color, alpha)
                        end
                    end
                end
            })

            local section = column:section({name = "Other"})
            section:label({name = "UI Bind"})
            :keybind({callback = window.set_menu_visibility, key = Enum.KeyCode.Insert})
            section:toggle({name = "Keybind List", flag = "keybind_list", callback = function(bool)
                library.keybind_list_frame.Visible = bool
            end})
            section:toggle({name = "Watermark", flag = "watermark", callback = function(bool)
                watermark.set_visible(bool)
            end})
            section:toggle({name = "Unlock FPS", flag = "unlockfps", callback = function(bool)
                if bool then
                    setfpscap(flags["fpsamount"])
                end
            end})
            section:dropdown({name = "Notification Position", flag = "notification_position", items = {"Left", "Bottom"}, default = "Left"})
            section:slider({name = "Notification Duration", flag = "notification_duration", min = 0.5, max = 5, default = 3, interval = 0.1})
            section:button_holder({})
            section:button({name = "Copy JobId", callback = function()
                setclipboard(game.JobId)
            end})
            section:button_holder({})
            section:button({name = "Copy GameID", callback = function()
                setclipboard(game.GameId)
            end})
            section:button_holder({})
            section:button({name = "Copy Join Script", callback = function()
                setclipboard('game:GetService("TeleportService"):TeleportToPlaceInstance(' .. game.PlaceId .. ', "' .. game.JobId .. '", game.Players.LocalPlayer)')
            end})
            section:button_holder({})
            section:button({name = "Rejoin", callback = function()
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
            end})
            section:button_holder({})
            section:button({name = "Join New Server", callback = function()
                local apiRequest = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
                local data = apiRequest.data[random(1, #apiRequest.data)]
                    
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, data.id)
            end})
            section:slider({name = "FPS", flag = "fpsamount", min = 30, max = 999, default = 240, interval = 1, callback = function(int)                 
                if bool then
                    setfpscap(int)
                end 
            end})
        -- 

        -- cfg holder
            local holder = library:panel({
                name = "Configurations", 
                size = dim2(0, 324, 0, 410),
                position = dim2(0, items.main_holder.AbsolutePosition.X + items.main_holder.AbsoluteSize.X + 2, 0, items.main_holder.AbsolutePosition.Y),
                image = "rbxassetid://105199726008012",
            }) 

            local items = holder.items

            getgenv().load_config = function(name)
                library:load_config(readfile(library.directory .. "/configs/" .. name .. ".cfg"))
            end 

            local column = setmetatable(items, library):column() 
            local section = column:section({name = "Options"})
                config_holder = section:list({flag = "config_name_list"})
                section:textbox({flag = "config_name_text_box"})
                section:button_holder({})
                section:button({name = "Create", callback = function()
                    writefile(library.directory .. "/configs/" .. flags["config_name_text_box"] .. ".cfg", library:get_config())
                    library:config_list_update()
                end})
                section:button({name = "Delete", callback = function()
                    delfile(library.directory .. "/configs/" .. flags["config_name_list"] .. ".cfg")
                    library:config_list_update()
                end})
                section:button_holder({})
                section:button({name = "Load", callback = function()
                    library:load_config(readfile(library.directory .. "/configs/" .. flags["config_name_list"] .. ".cfg"))
                    library:notification({text = "Loaded Config: " .. flags["config_name_list"], time = flags["notification_duration"]})
                end})
                section:button({name = "Overwrite", callback = function()
                    writefile(library.directory .. "/configs/" .. flags["config_name_list"] .. ".cfg", library:get_config())
                    library:notification({text = "Overwritten settings to Config: " .. flags["config_name_list"], time = flags["notification_duration"]})
                    library:config_list_update()
                end})
                section:button_holder({})
                section:button({name = "Refresh Configs", callback = function()
                    library:config_list_update()
                end})
                section:button_holder({})
                section:button({name = "Unload Config", callback = function()
                    library:load_config(library.old_config)
                end})
                section:button({name = "Unload Menu", callback = function()
                    library:load_config(library.old_config)

                    for _, gui in library.guis do 
                        gui:Destroy() 
                    end 

                    for _, connection in library.connections do 
                        connection:Disconnect() 
                    end

                    blur:Destroy()
                end})
        -- 
                
        -- esp preview
            local holder = library:panel({
                name = "ESP Preview", 
                anchor_point = vec2(0, 0),
                size = dim2(0, 300, 0, 325),
                position = dim2(0, style.items.main_holder.AbsolutePosition.X, 0, style.items.main_holder.AbsolutePosition.Y + style.items.main_holder.AbsoluteSize.Y + 2),
                image = "rbxassetid://77684377836328",
            })  
            
            local items = holder.items
            
            local column = setmetatable(items, library):column() 
            window.esp_section = column:section({name = "Main"})
        --  

        -- playerlist 
            local holder = library:panel({
                name = "Playerlist", 
                anchor_point = vec2(0, 0),
                size = dim2(0, 529, 0, 470),
                position = dim2(0, main_window.items.main_holder.AbsolutePosition.X - 531, 0, main_window.items.main_holder.AbsolutePosition.Y),
                image = "rbxassetid://107070078834415",
            })  
            
            local items = holder.items

            local column = setmetatable(items, library):column() 
            local section = column:section({name = "Playerlist"})
            local playerlist = section:playerlist({})
            section:dropdown({name = "Priority", items = {"Enemy", "Priority", "Neutral", "Friendly"}, default = "Neutral", flag = "PLAYERLIST_DROPDOWN", callback = function(text)
                library.prioritize(text)
            end})
            section:button_holder({})
            section:button({name = "Teleport", flag = "teleport_to", callback = function() local_entity.Character:FindFirstChild("HumanoidRootPart").CFrame = entities[library.selected_player].Character:FindFirstChild("HumanoidRootPart").CFrame end})
            section:toggle({name = "View", flag = "view", callback = function(nigger) 
                if nigger then
                    camera.CameraSubject = entities[library.selected_player].Character.Humanoid
                else
                    if camera.CameraSubject ~= local_entity.Character.Humanoid then
                        camera.CameraSubject = local_entity.Character.Humanoid
                    end
                end
            end})
            section:toggle({name = "Bring", tooltip = "Only works for some games (client sided)", flag = "loopbring", callback = function(state)
                if state then
                    task.spawn(function()
                        while flags["loopbring"] do
                            task.wait()
                            local target = entities[library.selected_player]
                            if target and target.Character and local_entity.Character then
                                local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                                local lhrp = local_entity.Character:FindFirstChild("HumanoidRootPart")
                                if hrp and lhrp then
                                    hrp.CFrame = lhrp.CFrame + (lhrp.CFrame.LookVector * 5)
                                end
                            end
                        end
                    end)
                end
            end})
        return setmetatable(window, library)
    end

    function library:watermark(options) 
        local cfg = {
            default = options.text or options.default or os.date('drain.lol | %b %d %Y | %H:%M')
        }

        local watermark_outline = library:create("Frame", {
            Parent = sgui,
            Name = "",
            BorderColor3 = rgb(0, 0, 0),
            AnchorPoint = vec2(1, 1),
            Position = dim2(1, -20, 0, 20),
            Size = dim2(0, 0, 0, 24),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundColor3 = themes.preset.outline
        }) library:apply_theme(watermark_outline, "outline", "BackgroundColor3") 
        watermark_outline.Position = dim_offset(watermark_outline.AbsolutePosition.X, watermark_outline.AbsolutePosition.Y)
        library:draggify(watermark_outline)

        local watermark_inline = library:create("Frame", {
            Parent = watermark_outline,
            Name = "",
            Position = dim2(0, 1, 0, 1),
            BorderColor3 = rgb(0, 0, 0),
            Size = dim2(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = themes.preset.inline
        }) library:apply_theme(watermark_inline, "inline", "BackgroundColor3") 
        
        local watermark_background = library:create("Frame", {
            Parent = watermark_inline,
            Name = "",
            Position = dim2(0, 1, 0, 1),
            BorderColor3 = rgb(0, 0, 0),
            Size = dim2(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        })
        
        local UIGradient = library:create("UIGradient", {
            Parent = watermark_background,
            Name = "",
            Rotation = 90,
            Color = rgbseq{
                rgbkey(0, rgb(41, 41, 55)),
                rgbkey(1, rgb(35, 35, 47))
            }
        }) library:apply_theme(UIGradient, "contrast", "Color") 
        
        local text = library:create("TextLabel", {
            Parent = watermark_background,
            Name = "",
            FontFace = library.font,
            TextColor3 = themes.preset.text,
            BorderColor3 = rgb(0, 0, 0),
            Text = "  drain.lol | Beta | Aug 29 2024 | 07:29:00  ", -- RAPE HEX
            Size = dim2(0, 0, 1, 0),
            BackgroundTransparency = 1,
            Position = dim2(0, -1, 0, 1),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X,
            TextSize = 12,
            BackgroundColor3 = rgb(255, 255, 255)
        })
        
        library:create("UIStroke", {
            Parent = text,
            Name = "",
            LineJoinMode = Enum.LineJoinMode.Miter
        })
        
        local accent = library:create("Frame", {
            Parent = watermark_outline,
            Name = "",
            Position = dim2(0, 2, 0, 2),
            BorderColor3 = rgb(0, 0, 0),
            Size = dim2(1, -4, 0, 2),
            BorderSizePixel = 0,
            BackgroundColor3 = themes.preset.accent
        }) library:apply_theme(accent, "accent", "BackgroundColor3") 
        
        local UIGradient = library:create("UIGradient", {
            Parent = accent,
            Name = "",
            Rotation = 90,
            Color = rgbseq{
                rgbkey(0, rgb(255, 255, 255)),
                rgbkey(1, rgb(167, 167, 167))
            }
        })
        
        function cfg.change_text(input)
            text.Text = "  ".. input .."  "
        end 

        function cfg.set_visible(bool) 
            watermark_outline.Visible = bool
        end 


        cfg.change_text(cfg.default)

        return cfg 

    end 

function library:esp_preview(properties)
    local cfg = {items = {}, rotation = 0; objects = {};}
    local lp = game:GetService("Players").LocalPlayer
    local run = game:GetService("RunService")

    lp.Character.Archivable = true
    local character = lp.Character:Clone()

    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid:FindFirstChild("Animator") then
        local animator = Instance.new("Animator")
        animator.Parent = humanoid
    end

    if character:FindFirstChild("Animate") then
        character.Animate:Destroy()
    end

    local items = cfg.items
    do
        items.viewportframe = library:create("ViewportFrame", {
            Parent = self.holder,
            BackgroundTransparency = 1,
            Size = dim2(1, 0, 0, 220),
            Position = dim2(0, 0, 0, 10),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255),
            Active = true,
            ZIndex = 1
        })

        items.worldmodel = library:create("WorldModel", {
            Parent = items.viewportframe
        })

        items.camera = library:create("Camera", {
            FieldOfView = 50,
            CameraType = Enum.CameraType.Scriptable,
            Parent = items.viewportframe
        })
    end

    items.viewportframe.CurrentCamera = items.camera
    character.Parent = items.worldmodel

    local rootPos = Vector3.new(0, 0, -10)

    character:SetPrimaryPartCFrame(
        CFrame.new(rootPos) * CFrame.Angles(0, math.rad(180), 0)
    )

    items.camera.CFrame = CFrame.new(Vector3.new(0, 0, 0), rootPos)

    local objects = cfg.objects; do 
        objects[ "holder" ] = library:create( "Frame" , {
            Parent = items.viewportframe,
            Name = "\0",
            BackgroundTransparency = 1,
            Position = dim2(0.5, 0, 0.5, 10),
            Size = dim2(0, 135, 0, 190),
            AnchorPoint = vec2(0.5, 0.5),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        });

        objects[ "box_outline" ] = library:create( "UIStroke" , {
            Parent = library.cache; 
            Color = rgb(0, 0, 0);
            LineJoinMode = Enum.LineJoinMode.Miter;
            Thickness = 1;
        });
        
        objects[ "box_handler" ] = library:create( "Frame" , {
            Parent = library.cache,
            Name = "\0",
            BackgroundTransparency = 1,
            Position = dim2(0, 1, 0, 1),
            Size = dim2(1, -2, 1, -2),
            BorderSizePixel = 0
        });

        objects["box_glow"] = library:create("ImageLabel", {
            Parent = library.cache;
            Name = "\0";
            BackgroundTransparency = 1;
            Image = "http://www.roblox.com/asset/?id=18245826428";
            ImageColor3 = rgb(255, 255, 255);
            ImageTransparency = 0.8;
            ScaleType = Enum.ScaleType.Slice;
            SliceCenter = Rect.new(21, 21, 79, 79);
            Size = dim2(1, 40, 1, 40);
            Position = dim2(0, -20, 0, -20);
            ZIndex = 2;
            Visible = true;
        });
        
        objects["box_glow_gradient"] = library:create("UIGradient", {
            Parent = objects["box_glow"];
            Rotation = 90;
            Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.000, Color3.fromRGB(0, 255, 128)),
                ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 128, 255))
            }
        });

        objects[ "box_filled" ] = library:create( "Frame" , {
            Parent = objects[ "box_handler" ];
            Name = "\0";
            AnchorPoint = Vector2.new(0, 0);
            BackgroundTransparency = 0.3;
            Position = dim2(0, 1, 0, 1);
            BorderColor3 = rgb(0, 0, 0);
            Size = dim2(1, -2, 1, -2);
            BorderSizePixel = 0;
            BackgroundColor3 = rgb(255, 255, 255);
        });

        objects[ "box_filled_gradient" ] = library:create( "UIGradient" , {
            Parent = objects[ "box_filled" ];
            Rotation = 90;
            Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.000, Color3.fromRGB(0, 255, 128)),
                ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 128, 255))
            }
        });

        objects[ "box_color" ] = library:create( "UIStroke" , {
            Color = flags["box_color"].Color;
            LineJoinMode = Enum.LineJoinMode.Miter;
            Name = "\0";
            Parent = objects[ "box_handler" ];
            Thickness = 1;
        });

        objects[ "outline" ] = library:create( "Frame" , {
            Parent = objects[ "box_handler" ];
            Name = "\0";
            BackgroundTransparency = 1;
            Position = dim2(0, 1, 0, 1);
            BorderColor3 = rgb(0, 0, 0);
            Size = dim2(1, -2, 1, -2);
            BorderSizePixel = 0;
            BackgroundColor3 = rgb(255, 255, 255);
        });

        library:create( "UIStroke" , {
            Parent = objects[ "outline" ];
            Color = rgb(0, 0, 0);
            LineJoinMode = Enum.LineJoinMode.Miter;
            Thickness = 1;
        });
        
        objects[ "corners" ] = library:create( "Frame" , {
            Visible = true;
            Parent = library.cache;
            BackgroundTransparency = 1;
            Size = dim2(1, 0, 1, 0);
            BorderSizePixel = 0;
        });

        local function create_corner(name, pos, size, anchor)
            local line = library:create("Frame", {
                Parent = objects["corners"],
                Position = pos,
                AnchorPoint = anchor or vec2(0,0),
                Size = size,
                BackgroundColor3 = rgb(0, 0, 0),
                BorderSizePixel = 0,
            })
            library:create("Frame", {
                Parent = line,
                Position = dim2(0, 1, 0, 1),
                Size = dim2(1, -2, 1, -2),
                BackgroundColor3 = flags["box_color"].Color,
                BorderSizePixel = 0,
            })
        end

        create_corner("1", dim2(0, -1, 0, -1), dim2(0.3, 0, 0, 3))
        create_corner("2", dim2(0, -1, 0, -1), dim2(0, 3, 0.2, 0))
        create_corner("3", dim2(1, 1, 0, -1), dim2(0.3, 0, 0, 3), vec2(1,0))
        create_corner("4", dim2(1, 1, 0, -1), dim2(0, 3, 0.2, 0), vec2(1,0))
        create_corner("5", dim2(0, -1, 1, 1), dim2(0.3, 0, 0, 3), vec2(0,1))
        create_corner("6", dim2(0, -1, 1, 1), dim2(0, 3, 0.2, 0), vec2(0,1))
        create_corner("7", dim2(1, 1, 1, 1), dim2(0.3, 0, 0, 3), vec2(1,1))
        create_corner("8", dim2(1, 1, 1, 1), dim2(0, 3, 0.2, 0), vec2(1,1))

        -- Labels
        objects[ "name" ] = library:create( "TextLabel" , {
            FontFace = library.font;
            Parent = library.cache;
            TextColor3 = flags["name_color"].Color;
            BorderColor3 = rgb(0, 0, 0);
            Text = string.format("%s (@%s)", lp.DisplayName, lp.Name);
            Name = "\0";
            TextStrokeTransparency = 0;
            AnchorPoint = vec2(0.5, 1);
            Size = dim2(1, 0, 0, 0);
            BackgroundTransparency = 1;
            Position = dim2(0.5, 0, 0, -5);
            BorderSizePixel = 0;
            AutomaticSize = Enum.AutomaticSize.Y;
            TextSize = 12;
        });

        objects[ "healthbar_holder" ] = library:create( "Frame" , {
            AnchorPoint = vec2(1, 0);
            Parent = library.cache;
            Position = dim2(0, -3, 0, 0);
            Size = dim2(0, 4, 1, 0);
            BackgroundColor3 = rgb(0, 0, 0);
            BorderSizePixel = 0;
        });
        
        objects[ "healthbar" ] = library:create( "Frame" , {
            Parent = objects[ "healthbar_holder" ];
            Position = dim2(0, 1, 0, 1);
            Size = dim2(1, -2, 1, -2);
            BackgroundColor3 = rgb(255, 255, 255);
            BorderSizePixel = 0;
        });

        objects[ "healthbar_gradient" ] = library:create( "UIGradient" , {
            Parent = objects[ "healthbar" ];
            Rotation = 90;
            Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.000, Color3.fromRGB(0, 255, 128)),
                ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 128, 255))
            }
        });

        objects[ "distance" ] = library:create( "TextLabel" , {
            FontFace = library.font;
            TextColor3 = flags["distance_color"].Color;
            Text = "[271m]";
            Parent = library.cache;
            TextStrokeTransparency = 0;
            AnchorPoint = vec2(0.5, 0);
            Size = dim2(1, 0, 0, 0);
            BackgroundTransparency = 1;
            Position = dim2(0.5, 0, 1, 5);
            AutomaticSize = Enum.AutomaticSize.Y;
            TextSize = 12;
        });

        objects[ "weapon" ] = library:create( "TextLabel" , {
            FontFace = library.font;
            TextColor3 = flags["tool_color"].Color;
            Text = "[Weapon]";
            Parent = library.cache;
            TextStrokeTransparency = 0;
            AnchorPoint = vec2(0.5, 0);
            Size = dim2(1, 0, 0, 0);
            BackgroundTransparency = 1;
            Position = dim2(0.5, 0, 1, 17);
            AutomaticSize = Enum.AutomaticSize.Y;
            TextSize = 12;
        });
    end 
    
    local currentTrack = nil

    -- [SECTION 4] Animation Menu UI
    objects["anim_menu"] = library:create("Frame", {
        Parent = items.viewportframe;
        Name = "AnimMenu";
        Visible = false;
        Size = dim2(0, 140, 0, 50);
        BackgroundColor3 = rgb(255, 255, 255);
        BorderColor3 = rgb(0, 0, 0);
        BorderSizePixel = 1;
        AutomaticSize = Enum.AutomaticSize.Y;
    });

    local gradientttt = library:create("UIGradient", {
        Parent = objects["anim_menu"],
        Rotation = 90,
        Color = rgbseq{
            rgbkey(0, rgb(41, 41, 55)),
            rgbkey(1, rgb(35, 35, 47))
        }
    })
    library:apply_theme(gradientttt, "contrast", "Color") 

    library:create("UIStroke", {
        Parent = objects["anim_menu"];
        Color = rgb(0, 0, 0);
        Thickness = 1;
    });

    library:create("UIListLayout", {
        Parent = objects["anim_menu"],
        Padding = dim(0, 5),
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center
    })

    library:create("UIPadding", {
        Parent = objects["anim_menu"],
        PaddingTop = dim(0, 5),
        PaddingBottom = dim(0, 5),
        PaddingLeft = dim(0, 5),
        PaddingRight = dim(0, 5),
    })

    -- Styled TextBox
    local input_outline = library:create("Frame", {
        Parent = objects["anim_menu"],
        Name = "InputOutline",
        Size = dim2(1, 0, 0, 18),
        BorderColor3 = rgb(0, 0, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = themes.preset.outline
    })
    library:apply_theme(input_outline, "outline", "BackgroundColor3")

    local input_inline = library:create("Frame", {
        Parent = input_outline,
        Position = dim2(0, 1, 0, 1),
        Size = dim2(1, -2, 1, -2),
        BorderColor3 = rgb(0, 0, 0),
        ZIndex = 2,
        BorderSizePixel = 0,
        BackgroundColor3 = themes.preset.inline
    })
    library:apply_theme(input_inline, "inline", "BackgroundColor3")

    local input_bg = library:create("Frame", {
        Parent = input_inline,
        Position = dim2(0, 1, 0, 1),
        Size = dim2(1, -2, 1, -2),
        ZIndex = 2,
        BorderColor3 = rgb(0, 0, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = rgb(255, 255, 255)
    })

    local input_gradient = library:create("UIGradient", {
        Parent = input_bg,
        Rotation = 90,
        Color = rgbseq{
            rgbkey(0, rgb(41, 41, 55)),
            rgbkey(1, rgb(35, 35, 47))
        }
    })
    library:apply_theme(input_gradient, "contrast", "Color") 

    objects["anim_input"] = library:create("TextBox", {
        Parent = input_bg,
        Size = dim2(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "",
        PlaceholderText = "Animation ID",
        TextColor3 = themes.preset.text,
        FontFace = library.font,
        TextSize = 12,
        ZIndex = 3,
        TextWrapped = true,
        TextTruncate = Enum.TextTruncate.SplitWord
    })
    
    library:hoverify(input_outline, input_outline)

    -- Styled Button
    objects["anim_play"] = library:create("TextButton", {
        Parent = objects["anim_menu"],
        Name = "PlayButton",
        Size = dim2(1, 0, 0, 18),
        BackgroundColor3 = themes.preset.outline,
        Text = "",
        AutoButtonColor = false,
        BorderColor3 = rgb(0, 0, 0),
        BorderSizePixel = 0
    })
    library:apply_theme(objects["anim_play"], "outline", "BackgroundColor3")
    library:hoverify(objects["anim_play"], objects["anim_play"])

    local btn_inline = library:create("Frame", {
        Parent = objects["anim_play"],
        Position = dim2(0, 1, 0, 1),
        Size = dim2(1, -2, 1, -2),
        BorderColor3 = rgb(0, 0, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = themes.preset.inline
    })
    library:apply_theme(btn_inline, "inline", "BackgroundColor3")

    local btn_bg = library:create("Frame", {
        Parent = btn_inline,
        Position = dim2(0, 1, 0, 1),
        Size = dim2(1, -2, 1, -2),
        BorderColor3 = rgb(0, 0, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = rgb(255, 255, 255)
    })

    local btn_grad = library:create("UIGradient", {
        Parent = btn_bg,
        Rotation = 90,
        Color = rgbseq{
            rgbkey(0, rgb(41, 41, 55)),
            rgbkey(1, rgb(35, 35, 47))
        }
    })
    library:apply_theme(btn_grad, "contrast", "Color")

    library:create("TextLabel", {
        Parent = btn_bg,
        Size = dim2(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "Play Animation",
        TextColor3 = themes.preset.text,
        FontFace = library.font,
        TextSize = 12,
        ZIndex = 12,
        TextWrapped = true,
        TextTruncate = Enum.TextTruncate.SplitWord
    })

    -- [SECTION 5] Interaction Logic
    items.viewportframe.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            objects["anim_menu"].Visible = not objects["anim_menu"].Visible
            local mPos = input.Position
            local fPos = items.viewportframe.AbsolutePosition
            objects["anim_menu"].Position = dim2(0, mPos.X - fPos.X, 0, mPos.Y - fPos.Y)
        end
    end)

    objects["anim_play"].MouseButton1Click:Connect(function()
        local id = objects["anim_input"].Text
        id = string.match(id, "%d+")
        
        if id then
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://" .. id
            
            local char_hum = character:FindFirstChild("Humanoid")
            if char_hum then
                if not char_hum:FindFirstChild("Animator") then
                    Instance.new("Animator", char_hum)
                end

                if currentTrack then 
                    currentTrack:Stop() 
                end
                
                local success, track = pcall(function()
                    return char_hum:LoadAnimation(anim)
                end)

                if success and track then
                    currentTrack = track
                    track.Looped = true
                    track:Play()
                else
                   objects["anim_input"].Text = "Error"
                end
            end
        else
            objects["anim_input"].Text = "Invalid ID"
            task.delay(1, function()
                objects["anim_input"].Text = ""
            end)
        end
    end)

    cfg.change_health = function()
        if flags[ "healthbar_holder" ] and flags[ "healthbar_holder" ].Parent ~= objects[ "holder" ] then 
            return 
        end

        local humanoid = character.Humanoid
            
        local multiplier = humanoid.MaxHealth * math.abs(math.sin(tick() * 2)) / humanoid.MaxHealth
            
        objects[ "healthbar" ].Size = UDim2.new(1, -2, multiplier, -2)
        objects[ "healthbar" ].Position = UDim2.new(0, 1, 1 - multiplier, 1)
        objects[ "healthbar_gradient" ].Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.000, flags["healthbar_color1"].Color),
            ColorSequenceKeypoint.new(0.499, flags["healthbar_color2"].Color),
            ColorSequenceKeypoint.new(1.000, flags["healthbar_color3"].Color)
        }
    end 

    function cfg.refresh_elements( )                                
        objects.holder.Parent = flags["esp_enabled"] and items.viewportframe or library.cache

        local temp = {
            ["name_enabled"] = objects["name"]; 
            ["name_color"] = {objects["name"]};
            ["healthbar_enabled"] = objects[ "healthbar_holder" ];
            ["distance_enabled"] = objects[ "distance" ];
            ["tool_enabled"] = objects[ "weapon" ];
            ["distance_color"] = {objects[ "distance" ]};
            ["tool_color"] = {objects[ "weapon" ]};
        }

        for flag,object in temp do 
            if type(object) == "table" then 
                object[1].TextColor3 = flags[flag].Color
            else 
                object.Parent = flags[flag] and objects[ "holder" ] or library.cache
            end
        end 
        
        local is_corner = flags[ "box_type" ] == "Corner"

        if flags["esp_font"] == "ProggyClean" then
            objects["weapon"].FontFace = library.font
            objects["distance"].FontFace = library.font
            objects["name"].FontFace = library.font
            objects["weapon"].TextSize = 12
            objects["distance"].TextSize = 12
            objects["name"].TextSize = 12
        elseif flags["esp_font"] == "TahomaBold" then
            objects["weapon"].FontFace = Fonts[flags["esp_font"]]
            objects["distance"].FontFace = Fonts[flags["esp_font"]]
            objects["name"].FontFace = Fonts[flags["esp_font"]]
            objects["weapon"].TextSize = 11
            objects["distance"].TextSize = 11
            objects["name"].TextSize = 11
        else
            objects["weapon"].FontFace = Fonts[flags["esp_font"]]
            objects["distance"].FontFace = Fonts[flags["esp_font"]]
            objects["name"].FontFace = Fonts[flags["esp_font"]]
            objects["weapon"].TextSize = 9
            objects["distance"].TextSize = 9
            objects["name"].TextSize = 9
        end

        if flags["box_enabled"] then 
            objects["box_color"].Color = flags["box_color"].Color 
            objects["box_filled_gradient"].Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.000, flags["boxfill_color1"].Color),
                ColorSequenceKeypoint.new(0.499, flags["boxfill_color2"].Color),
                ColorSequenceKeypoint.new(1.000, flags["boxfill_color3"].Color)
            }
            objects["box_glow_gradient"].Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.000, flags["boxglow_color1"].Color),
                ColorSequenceKeypoint.new(0.499, flags["boxglow_color2"].Color),
                ColorSequenceKeypoint.new(1.000, flags["boxglow_color3"].Color)
            }

            if is_corner then 
                objects[ "corners" ].Parent = objects["holder"]
                
                objects[ "box_handler" ].Parent = library.cache
                objects[ "box_outline" ].Parent = library.cache
            else 
                objects[ "corners" ].Parent = library.cache
                
                objects[ "box_outline" ].Parent = objects["holder"]
                objects[ "box_handler" ].Parent = objects[ "holder" ]
                if flags["boxglow_enabled"] then
                    objects[ "box_glow" ].Parent = objects[ "box_handler" ]
                else
                    objects[ "box_glow" ].Parent = library.cache
                end
                if flags["boxfill_enabled"] then
                    objects[ "box_filled" ].Parent = objects[ "box_handler" ]
                else
                    objects[ "box_filled" ].Parent = library.cache
                end
            end 
        else
            objects[ "corners" ].Parent =  library.cache
            objects[ "box_handler" ].Parent = library.cache
            objects[ "box_filled" ].Parent = library.cache
            objects[ "box_outline" ].Parent = library.cache
            objects[ "box_glow" ].Parent = library.cache
        end 

        for _, corner in objects[ "corners" ]:GetChildren() do
            if corner:IsA("Frame") and corner:FindFirstChild("Frame") then
                 corner.Frame.BackgroundColor3 = flags["box_color"].Color
            end
        end
    end

    task.spawn(function()
        while true do 
            task.wait()
            cfg.change_health()
        end 
    end)

    return setmetatable(cfg, library)
end

    function library:refresh_notifications()  	
        for _, notif in next, library.notifications do 
            tween_service:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {Position = dim2(0, 20, 0, 72 + (_ * 28))}):Play()
        end     
    end

    function library:updateNotifsPositions()
        local positionFlag = flags["notification_position"] 

        for i, v in ipairs(library.Notifs) do
            if positionFlag == "Bottom" then
                local baseY = 50
                tween_service:Create(
                    v.Container,
                    TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
                    {
                        Position = UDim2.new(
                            0.5, 0, 
                            1, -baseY - ((i - 1) * 25) 
                        ),
                        AnchorPoint = Vector2.new(0.5, 1)
                    }
                ):Play()
            else
                local Position = Vector2.new(20, 20)
                tween_service:Create(
                    v.Container,
                    TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
                    {
                        Position = UDim2.new(
                            0, Position.X,
                            0, Position.Y + (i * 25)
                        ),
                        AnchorPoint = Vector2.new(0, 0)
                    }
                ):Play()
            end
        end
    end


-- Create a notification
function library:notification(properties)
	local cfg = {
		time = properties.time or 5,
		text = properties.text or properties.name or "Notification",
		flashing = false,
	}

	local notification = {Container = nil, Objects = {}}

    local NotifContainer = Instance.new('Frame', notif_holder)
    NotifContainer.Name = "NotifContainer"

    if flags["notification_position"] == "Bottom" then
        NotifContainer.AnchorPoint = Vector2.new(0.5, 1)
        NotifContainer.Position = UDim2.new(0.5, 0, 1, -50)
    else
        NotifContainer.AnchorPoint = Vector2.new(0, 0)
        NotifContainer.Position = UDim2.new(0, 20, 0, 20)
    end

    NotifContainer.AutomaticSize = Enum.AutomaticSize.X
    NotifContainer.Size = UDim2.new(0, 120, 0, 16)
    NotifContainer.BackgroundColor3 = Color3.new(1, 1, 1)
    NotifContainer.BackgroundTransparency = 1
    NotifContainer.BorderSizePixel = 0
    NotifContainer.ZIndex = 99999999
    notification.Container = NotifContainer

	local Notif = Instance.new("Frame")
	Notif.Name = "Notif"
	Notif.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Notif.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Notif.Position = UDim2.new(0, 0, 0, 0)
	Notif.AutomaticSize = Enum.AutomaticSize.X
	Notif.Size = UDim2.new(0, 120, 0, 18)
	Notif.Parent = NotifContainer
	Notif.BackgroundTransparency = 1
	table.insert(notification.Objects, Notif)

	local DisabledGradient = Instance.new("UIGradient")
	DisabledGradient.Name = "DisabledGradient"
	DisabledGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(47, 47, 47)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(26, 26, 26)),
	})
	DisabledGradient.Rotation = 90
	DisabledGradient.Parent = Notif

	-- Stroke
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Name = "UIStroke"
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
	UIStroke.Thickness = 2
	UIStroke.Transparency = 1
	UIStroke.Parent = Notif
	table.insert(notification.Objects, UIStroke)

	-- Text
	local Value = Instance.new("TextLabel")
	Value.Name = "Value"
	Value.FontFace = library.font
	Value.Text = cfg.text
	Value.TextColor3 = Color3.fromRGB(255, 255, 255)
	Value.TextSize = 12
	Value.TextStrokeTransparency = 0
	Value.TextTransparency = 1
	Value.TextXAlignment = Enum.TextXAlignment.Left
	Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Value.BackgroundTransparency = 1
	Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Value.BorderSizePixel = 0
	Value.RichText = true
	Value.Position = UDim2.new(0, 6, 0, 0)
	Value.Size = UDim2.new(0, 0, 1, 0)
	Value.Parent = Notif
	Value.AutomaticSize = Enum.AutomaticSize.X
	table.insert(notification.Objects, Value)

	-- Padding
	local UIPadding = Instance.new("UIPadding")
	UIPadding.Name = "UIPadding"
	UIPadding.PaddingRight = UDim.new(0, 6)
	UIPadding.Parent = Notif

	-- Accent
	local Accent = Instance.new("Frame")
	Accent.Name = "Accent"
	Accent.BackgroundColor3 = flags["Accent"].Color
	Accent.BorderColor3 = Color3.fromRGB(20, 20, 20)
	Accent.Size = UDim2.new(0, 2, 1, 0)
	Accent.BackgroundTransparency = 1
	table.insert(notification.Objects, Accent)

	local UIGradient = Instance.new("UIGradient")
	UIGradient.Name = "UIGradient"
	UIGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145)),
	})
	UIGradient.Rotation = 0
	UIGradient.Parent = Accent

	Accent.Parent = Notif

	-- Remove function
	function notification:remove()
		table.remove(library.Notifs, table.find(library.Notifs, notification))
		library:updateNotifsPositions()
		task.wait(0.5)
		notification.Container:Destroy()
	end

	-- Animate appearance and disappearance
	task.spawn(function()
		Notif.AnchorPoint = Vector2.new(1, 0)
		for _, v in next, notification.Objects do
			if v:IsA("Frame") then
				tween_service:Create(v, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
			elseif v:IsA("UIStroke") then
				tween_service:Create(v, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Transparency = 0.8}):Play()
			end
		end
		tween_service:Create(Notif, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {AnchorPoint = Vector2.new(0, 0)}):Play()
		tween_service:Create(Value, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
		task.wait(cfg.time)
		tween_service:Create(Notif, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {AnchorPoint = Vector2.new(1, 0)}):Play()
		for _, v in next, notification.Objects do
			if v:IsA("Frame") then
				tween_service:Create(v, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
			elseif v:IsA("UIStroke") then
				tween_service:Create(v, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Transparency = 1}):Play()
			end
		end
		tween_service:Create(Value, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
	end)

	task.delay(cfg.time, function()
		notification:remove()
	end)

	-- Add to library
	table.insert(library.Notifs, notification)
	library:updateNotifsPositions()

	return notification
end


    function library:tab(options)	
        local cfg = {
            name = options.name or "tab", 
            enabled = false, 
        }
        
        -- button instances
            local tab_holder = library:create("TextButton", {
                Parent = self.tab_holder,
                FontFace = library.font,
                TextColor3 = themes.preset.text,
                BorderColor3 = rgb(0, 0, 0),
                Text = "",
                Name = "\0",
                BorderSizePixel = 0,
                Size = dim2(0, 0, 1, -2),
                ZIndex = 5,
                TextSize = 12,
                BackgroundColor3 = themes.preset.outline,
                AutoButtonColor = false
            }) library:apply_theme(tab_holder, "outline", "BackgroundColor3") 

            local inline = library:create("Frame", {
                Parent = tab_holder,
                Size = dim2(1, -2, 1, 0),
                Name = "\0",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                ZIndex = 5,
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.inline
            }) library:apply_theme(inline, "inline", "BackgroundColor3") 

            local background = library:create("Frame", {
                Parent = inline,
                Size = dim2(1, -2, 1, -1),
                Name = "\0",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                ZIndex = 5,
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            })

            local UIGradient = library:create("UIGradient", {
                Parent = background,
                Rotation = 90,
                Color = rgbseq{rgbkey(0, rgb(41, 41, 55)), rgbkey(1, rgb(35, 35, 47))}
            }) library:apply_theme(UIGradient, "contrast", "Color") 

            local text = library:create("TextLabel", {
                Parent = background,
                FontFace = library.font,
                TextColor3 = themes.preset.text,
                BorderColor3 = rgb(0, 0, 0),
                Text = cfg.name,
                Name = "\0",
                BackgroundTransparency = 1,
                Size = dim2(1, 0, 1, 0),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.X,
                TextSize = 12,
                ZIndex = 5,
                BackgroundColor3 = rgb(255, 255, 255)
            }, "text")
            library:apply_theme(text, "accent", "TextColor3")
        -- 

        -- section instances 
            local section_holder = library:create("Frame", {
                Parent = library.section_holder,
                BackgroundTransparency = 1,
                Name = "\0",
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, 0, 1, 0),
                BorderSizePixel = 0,
                Visible = false,
                BackgroundColor3 = rgb(255, 255, 255)
            })
        
            cfg["holder"] = section_holder

            library:create("UIListLayout", {
                Parent = section_holder,
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalFlex = Enum.UIFlexAlignment.Fill,
                Padding = dim(0, 4),
                SortOrder = Enum.SortOrder.LayoutOrder
            })
        -- 

        function cfg.open_tab()
            if library.current_tab and library.current_tab[1] ~= background then 
                local button = library.current_tab[1]
                button.Size = dim2(1, -2, 1, -1)
                button:FindFirstChildOfClass("UIGradient").Rotation = 90
                button:FindFirstChildOfClass("TextLabel").TextColor3 = themes.preset.text
                    
                library.current_tab[2].Visible = false
                
                library.current_tab = nil
            end
            
            library.current_tab = {
                background, section_holder
            }
            
            local button = library.current_tab[1] 
            button.Size = dim2(1, -2, 1, 0) -- ENABLED
            button:FindFirstChildOfClass("UIGradient").Rotation = -90
            button:FindFirstChildOfClass("TextLabel").TextColor3 = themes.preset.accent 

            library.current_tab[2].Visible = true 

            if library.current_element_open and library.current_element_open ~= cfg then 
                library.current_element_open.set_visible(false)
                library.current_element_open.open = false 
                library.current_element_open = nil 
            end
        end
        
        tab_holder.MouseButton1Click:Connect(cfg.open_tab)
        
        return setmetatable(cfg, library) 
    end

    function library:column(path) 
        local cfg = {}
        
        local holder = path or self.holder
        
        local column = library:create("Frame", {
            Parent = holder,
            BackgroundTransparency = 1,
            Name = "\0",
            BorderColor3 = rgb(0, 0, 0),
            Size = dim2(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = themes.preset.inline
        }) library:apply_theme(column, "inline", "BackgroundColor3") 
        
        library:create("UIListLayout", {
            Parent = column,
            Padding = dim(0, 4),
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalFlex = Enum.UIFlexAlignment.Fill
        })
        
        cfg["holder"] = column

        return setmetatable(cfg, library) 
    end

    function library:multi_section(options)
        local cfg = {
            names = options.names or {"First", "Second", "Third"}, 
            sections = {},
        }

        local section = library:create("Frame", {
            Parent = self.holder,
            Name = "",
            BorderColor3 = rgb(0, 0, 0),
            Size = dim2(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = themes.preset.inline
        }) library:apply_theme(section, "inline", "BackgroundColor3")
        
        local inline = library:create("Frame", {
            Parent = section,
            Name = "",
            Position = dim2(0, 1, 0, 1),
            BorderColor3 = rgb(0, 0, 0),
            Size = dim2(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = themes.preset.outline
        }) library:apply_theme(inline, "outline", "BackgroundColor3") 
        
        local __background = library:create("Frame", {
            Parent = inline,
            Name = "",
            ClipsDescendants = true,
            Position = dim2(0, 1, 0, 1),
            BorderColor3 = rgb(0, 0, 0),
            Size = dim2(1, -2, 1, -2),
            BorderSizePixel = 0,
            ZIndex = 1,
            BackgroundColor3 = rgb(255, 255, 255)
        })
        
        local accent = library:create("Frame", {
            Parent = __background,
            Name = "",
            Size = dim2(1, 0, 0, 2),
            BorderColor3 = rgb(0, 0, 0),
            ZIndex = 3,
            BorderSizePixel = 0,
            BackgroundColor3 = themes.preset.accent
        }) library:apply_theme(accent, "accent", "BackgroundColor3")
        
        local UIGradient = library:create("UIGradient", {
            Parent = accent,
            Name = "",
            Rotation = 90,
            Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(167, 167, 167))}
        }) 
        
        local UIGradient = library:create("UIGradient", {
            Parent = __background,
            Name = "",
            Rotation = 90,
            Color = rgbseq{rgbkey(0, rgb(41, 41, 55)), rgbkey(1, rgb(35, 35, 47))}
        }) library:apply_theme(UIGradient, "contrast", "Color") 
        
        local tab_holder = library:create("Frame", {
            Parent = __background,
            Name = "",
            ClipsDescendants = true,
            BackgroundTransparency = 1,
            Position = dim2(0, -1, 0, 0),
            BorderColor3 = rgb(0, 0, 0),
            Size = dim2(1, 2, 0, 21),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        }) 
        
        library:create("UIListLayout", {
            Parent = tab_holder,
            Name = "",
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalFlex = Enum.UIFlexAlignment.Fill,
            Padding = dim(0, -3),
            SortOrder = Enum.SortOrder.LayoutOrder
        })
        
        for _, tab in next, cfg.names do 
            local multi = {
                open = false, 
            } 

            -- Tab
                local tabb = library:create("TextButton", {
                    Parent = tab_holder,
                    Name = "",
                    AutoButtonColor = false,
                    FontFace = library.font,
                    TextColor3 = themes.preset.text,
                    BorderColor3 = rgb(0, 0, 0),
                    Text = "",
                    BorderSizePixel = 0,
                    Size = dim2(0, 0, 1, 0),
                    ZIndex = 1,
                    TextSize = 12,
                    BackgroundColor3 = themes.preset.outline
                }) library:apply_theme(tabb, "outline", "BackgroundColor3") 
                
                local background = library:create("Frame", {
                    Parent = tabb,
                    Name = "",
                    Size = dim2(1, 0, 1, -2),
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    ZIndex = 1,
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                local UIGradient = library:create("UIGradient", {
                    Parent = background,
                    Name = "",
                    Rotation = 90,
                    Color = rgbseq{rgbkey(0, rgb(41, 41, 55)), rgbkey(1, rgb(35, 35, 47))}
                }) library:apply_theme(UIGradient, "contrast", "Color")
                
                local text = library:create("TextLabel", {
                    Parent = background,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = themes.preset.text,
                    BorderColor3 = rgb(0, 0, 0),
                    Text = tab,
                    BackgroundTransparency = 1,
                    Size = dim2(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = rgb(255, 255, 255)
                }) library:apply_theme(text, "accent", "TextColor3")
                
                local UIStroke = library:create("UIStroke", {
                    Parent = text,
                    Name = "",
                    LineJoinMode = Enum.LineJoinMode.Miter
                })
            -- 

            -- Element Handler
                local ScrollingFrame = library:create("ScrollingFrame", {
                    Parent = __background,
                    Name = "",
                    ScrollBarImageColor3 = themes.preset.accent,
                    Active = true,
                    MidImage = "rbxassetid://103468666327206",
                    TopImage = "rbxassetid://103468666327206",
                    BottomImage = "rbxassetid://103468666327206",
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 2,
                    Size = dim2(1, 0, 1, -20),
                    Visible = false, 
                    BackgroundTransparency = 1,
                    Position = dim2(0, 0, 0, 24),
                    BackgroundColor3 = rgb(255, 255, 255),
                    BorderColor3 = rgb(0, 0, 0),
                    BorderSizePixel = 0,
                    ScrollBarThickness = 2,
                    CanvasSize = dim2(0, 0, 0, 0)
                }) library:apply_theme(ScrollingFrame, "accent", "ScrollBarImageColor3") 
                
                local elements = library:create("Frame", {
                    Parent = ScrollingFrame,
                    Name = "",
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, 0, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                }) multi.holder = elements
                
                local UIListLayout = library:create("UIListLayout", {
                    Parent = elements,
                    Name = "",
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    Padding = dim(0, 4)
                })
                
                local UIPadding = library:create("UIPadding", {
                    Parent = ScrollingFrame,
                    Name = "",
                    PaddingBottom = dim(0, 60)
                })
            --
            
            function multi:open_tab(bool) 
                ScrollingFrame.Visible = bool 
                UIGradient.Rotation = bool and -90 or 90
                tabb.Size = dim2(0, 0, 1, bool and 1 or 0)
                text.TextColor3 = bool and themes.preset.accent or themes.preset.text
            end

            library:connection(tabb.MouseButton1Click, function()
                for _, multi_s in next, cfg.sections do 
                    multi_s:open_tab(false)
                end

                if library.current_element_open then 
                    library.current_element_open.set_visible(false)
                    library.current_element_open.open = false 
                    library.current_element_open = nil 
                end

                multi:open_tab(true) 
            end)

            cfg.sections[#cfg.sections + 1] = setmetatable(multi, library)
        end 

        cfg.sections[1]:open_tab(true)

        return unpack(cfg.sections)
    end 

    function library:separator(options)
        options = options or {}

        local outline = library:create("Frame", {
            Parent = self.holder,
            Name = "\0",
            Size = dim2(1, -12, 0, options.height or 2),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(0, 0, 0)
        })

        local inline = library:create("Frame", {
            Parent = outline,
            Name = "\0",
            Position = dim2(0, 1, 0, 1),
            Size = dim2(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = themes.preset.inline
        })
        library:apply_theme(inline, "inline", "BackgroundColor3")

        return outline
    end

    function library:textlabel(options)
        options = options or {}
        
        local label = library:create("TextLabel", {
            Parent = self.holder,
            Name = "Label",
            Size = dim2(1, -12, 0, options.size or 12),
            BackgroundTransparency = 1,
            FontFace = library.font,
            Text = options.text or "Text Label",
            TextColor3 = themes.preset.text,
            TextSize = options.textsize or 12,
            TextXAlignment = Enum.TextXAlignment[options.align or "Left"], 
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y 
        })

        library:create("UIStroke", {
            Parent = label,
            LineJoinMode = Enum.LineJoinMode.Miter,
            Thickness = 1,
            Transparency = 0.5
        })

        library:apply_theme(label, "text", "TextColor3")

        return label
    end

    function library:section(options)
        local cfg = {
            name = options.name or "Section", 
            size = options.size or dim2(1, 0, 1, 0),
        }
        
        local section = library:create("Frame", {
            Parent = self.holder,
            Name = "\0",
            BorderColor3 = rgb(0, 0, 0),
            Size = cfg.size,
            BorderSizePixel = 0,
            BackgroundColor3 = themes.preset.inline
        }) library:apply_theme(section, "inline", "BackgroundColor3") 

        local inline = library:create("Frame", {
            Parent = section,
            Name = "\0",
            Position = dim2(0, 1, 0, 1),
            BorderColor3 = rgb(0, 0, 0),
            Size = dim2(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = themes.preset.outline
        }) library:apply_theme(inline, "outline", "BackgroundColor3") 

        local background = library:create("Frame", {
            Parent = inline,
            Name = "\0",
            Position = dim2(0, 1, 0, 1),
            BorderColor3 = rgb(0, 0, 0),
            Size = dim2(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        })

        local text = library:create("TextLabel", {
            Parent = background,
            FontFace = library.font,
            TextColor3 = themes.preset.text,
            BorderColor3 = rgb(0, 0, 0),
            Text = cfg.name,
            Name = "\0",
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0),
            Position = dim2(0.5, 0, 0, 4),   
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
            TextSize = 12,
            BackgroundColor3 = rgb(255, 255, 255)
        })

        library:create("UIStroke", {
            Parent = text,
            LineJoinMode = Enum.LineJoinMode.Miter
        })

        local accent = library:create("Frame", {
            Parent = background,
            Name = "\0",
            BorderColor3 = rgb(0, 0, 0),
            Size = dim2(1, 0, 0, 2),
            BorderSizePixel = 0,
            BackgroundColor3 = themes.preset.accent
        }) library:apply_theme(accent, "accent", "BackgroundColor3") 

        local UIGradienti = library:create("UIGradient", {
            Parent = accent,
            Rotation = 90,
            Color = rgbseq{
                rgbkey(0, rgb(255, 255, 255)),
                rgbkey(1, rgb(167, 167, 167))
            }
        })

        local UIGradient = library:create("UIGradient", {
            Parent = background,
            Rotation = 90,
            Color = rgbseq{
                rgbkey(0, rgb(41, 41, 55)),
                rgbkey(1, rgb(35, 35, 47))
            }
        }) library:apply_theme(UIGradient, "contrast", "Color") 

        local ScrollingFrame = library:create("ScrollingFrame", {
            Parent = background,
            ScrollBarImageColor3 = themes.preset.accent,
            Active = true,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollBarThickness = 2,
            MidImage = "rbxassetid://103468666327206",
            TopImage = "rbxassetid://103468666327206",
            BottomImage = "rbxassetid://103468666327206",
            Size = dim2(1, 0, 1, -20),
            BackgroundTransparency = 1,
            Position = dim2(0, 0, 0, 20),
            BackgroundColor3 = rgb(255, 255, 255),
            BorderColor3 = rgb(0, 0, 0),
            BorderSizePixel = 0,
            CanvasSize = dim2(0, 0, 0, 0)
        }) library:apply_theme(ScrollingFrame, "accent", "ScrollBarImageColor3") 

        ScrollingFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
            if library.current_element_open then 
                library.current_element_open.set_visible(false)
                library.current_element_open.open = false 
                library.current_element_open = nil
            end
        end) 

        local elements = library:create("Frame", {
            Parent = ScrollingFrame,
            Name = "\0",
            BorderColor3 = rgb(0, 0, 0),
            Size = dim2(1, 0, 0, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        })
        cfg.holder = elements 

        library:create("UIListLayout", {
            Parent = elements,
            Padding = dim(0, 4),
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        library:create("UIPadding", {
            Parent = ScrollingFrame,
            PaddingBottom = dim(0, 10)
        })

        return setmetatable(cfg, library)
    end

function library:slider(options)
    local cfg = {
        name = options.name or nil,
        suffix = options.suffix or "",
        flag = options.flag or tostring(2^789),
        callback = options.callback or function() end, 
        visible = options.visible or true, 
        compact = options.compact or false,
        input_disabled = options.input or false,
        custom_color = options.custom or nil; 

        min = options.min or options.minimum or 0,
        max = options.max or options.maximum or 100,
        intervals = options.interval or options.decimal or 1,
        default = options.default or 10,

        dragging = false,
        value = options.default or 10, 
    } 

    -- Instances 
    local slider_REAL = library:create("TextLabel", {
        Parent = self.holder,
        FontFace = library.font,
        TextColor3 = themes.preset.text,
        BorderColor3 = rgb(0, 0, 0),
        Text = "",
        Name = "slider",
        ZIndex = 1,
        -- Adjusted height for compact mode container
        Size = dim2(1, -8, 0, cfg.compact and 17 or 12),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutomaticSize = cfg.compact and Enum.AutomaticSize.None or Enum.AutomaticSize.Y,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextSize = 12,
        BackgroundColor3 = rgb(255, 255, 255)
    })
    
    local TEXT_LABEL; 
    -- Hide top label if compact is enabled
    if cfg.name and not cfg.compact then 
        local left_components = library:create("Frame", {
            Parent = slider_REAL,
            Name = "left_components",
            BackgroundTransparency = 1,
            Position = dim2(0, 2, 0, -1),
            BorderColor3 = rgb(0, 0, 0),
            Size = dim2(0, 0, 0, 14),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        })
        
        TEXT_LABEL = library:create("TextLabel", {
            Parent = left_components,
            FontFace = library.font,
            TextColor3 = themes.preset.text,
            BorderColor3 = rgb(0, 0, 0),
            Text = cfg.name,
            Name = "text",
            BackgroundTransparency = 1,
            Size = dim2(0, 0, 1, -1),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X,
            TextSize = 12,
            BackgroundColor3 = rgb(255, 255, 255)
        }, "text")

        library:create("UIListLayout", {
            Parent = left_components,
            Padding = dim(0, 5),
            Name = "_",
            FillDirection = Enum.FillDirection.Horizontal
        })
    end 
    
    local bottom_components = library:create("Frame", {
        Parent = slider_REAL,
        Name = "bottom_components",
        Position = dim2(0, 0, 0, (cfg.name and not cfg.compact) and 15 or 0),
        BorderColor3 = rgb(0, 0, 0),
        Size = dim2(1, 0, 0, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = rgb(255, 255, 255)
    })
    
    local slider = library:create("TextButton", {
        Parent = bottom_components,
        Name = "slider",
        Position = dim2(0, 0, 0, 2),
        BorderColor3 = rgb(0, 0, 0),
        Size = dim2(1, -1, 1, cfg.compact and 14 or 12),
        BorderSizePixel = 0,
        BackgroundColor3 = themes.preset.outline,
        Text = "",
        AutoButtonColor = false,
    }) library:apply_theme(slider, "outline", "BackgroundColor3") 

    if not cfg.input_disabled then 
        library:hoverify(slider_REAL, slider)
    end

    local inline = library:create("Frame", {
        Parent = slider,
        Name = "inline",
        Position = dim2(0, 1, 0, 1),
        BorderColor3 = rgb(0, 0, 0),
        Size = dim2(1, -2, 1, -2),
        BorderSizePixel = 0,
        ZIndex = 1;
        BackgroundColor3 = themes.preset.inline
    }) library:apply_theme(inline, "inline", "BackgroundColor3") 

    local background = library:create("Frame", {
        Parent = inline,
        Name = "background",
        Position = dim2(0, 1, 0, 1),
        BorderColor3 = rgb(0, 0, 0),
        Size = dim2(1, -2, 1, -2),
        BorderSizePixel = 0,
    }) 
    
    local contrast = library:create("Frame", {
        Parent = background,
        Name = "contrast",
        BorderColor3 = rgb(0, 0, 0),
        Size = dim2(1, 0, 1, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = rgb(255, 255, 255)
    })
    
    local slidertext = library:create("TextLabel", {
        Parent = contrast,
        FontFace = library.font,
        TextColor3 = themes.preset.text,
        BorderColor3 = rgb(0, 0, 0),
        Text = "",
        Name = "text",
        BackgroundTransparency = 1,
        Position = dim2(0, 0, 0, -1),
        Size = dim2(1, 0, 1, 0),
        BorderSizePixel = 0,
        TextSize = 12,
        ZIndex = 2,
        -- Centered text alignment
        TextXAlignment = Enum.TextXAlignment.Center,
        BackgroundColor3 = rgb(255, 255, 255)
    })
    
    local fill = library:create("Frame", {
        Parent = contrast,
        Name = "fill",
        BorderColor3 = rgb(0, 0, 0),
        Size = dim2(1, 0, 1, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = cfg.custom_color or themes.preset.accent
    }) if not cfg.custom_color then library:apply_theme(fill, "accent", "BackgroundColor3") end; 
    
    local UIGradient = library:create("UIGradient", {
        Parent = fill,
        Rotation = 90,
        Color = rgbseq{
            rgbkey(0, rgb(255, 255, 255)),
            rgbkey(1, rgb(167, 167, 167))
        }
    })
    
    local UIGradient = library:create("UIGradient", {
        Parent = contrast,
        Rotation = 90,
        Color = rgbseq{
            rgbkey(0, rgb(41, 41, 55)),
            rgbkey(1, rgb(35, 35, 47))
        }
    }); library:apply_theme(UIGradient, "contrast", "Color")
    
    local UIGradient = library:create("UIGradient", {
        Parent = background,
        Rotation = 90,
        Color = rgbseq{
            rgbkey(0, rgb(255, 255, 255)),
            rgbkey(1, rgb(167, 167, 167))
        }
    })
    
    library:create("UIListLayout", {
        Parent = bottom_components,
        Padding = dim(0, 10),
        Name = "_",
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    function cfg.set(value)
        if type(value) == "userdata" then 
            return 
        end

        cfg.value = math.clamp(library:round(value, cfg.intervals), cfg.min, cfg.max)

        fill.Size = dim2((cfg.value - cfg.min) / (cfg.max - cfg.min), 0, 1, 0)
        
        -- FORMAT: name: value/max (or just value/max if no name)
        local value_text = tostring(cfg.value) .. cfg.suffix .. "/" .. tostring(cfg.max) .. cfg.suffix
        if cfg.compact and cfg.name then
            slidertext.Text = cfg.name .. ": " .. value_text
        else
            slidertext.Text = value_text
        end

        flags[cfg.flag] = cfg.value
        cfg.callback(flags[cfg.flag])
    end

    function cfg.set_element_visible(bool)
        slider_REAL.Visible = bool 
        if TEXT_LABEL then 
            TEXT_LABEL.Visible = bool 
        end 
    end

    if not cfg.input_disabled then 
        library:connection(uis.InputChanged, function(input)
            if cfg.dragging and input.UserInputType == Enum.UserInputType.MouseMovement then 
                local size_x = (input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X
                local value = ((cfg.max - cfg.min) * size_x) + cfg.min
                cfg.set(value)
            end
        end)

        library:connection(uis.InputEnded, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                cfg.dragging = false 
            end 
        end)

        slider.MouseButton1Down:Connect(function()
            cfg.dragging = true
        end)
    end

    if cfg.tooltip then 
        library:tool_tip({name = cfg.tooltip, path = slider_REAL})
    end

    cfg.set(cfg.default)
    cfg.set_element_visible(cfg.visible)
            
    config_flags[cfg.flag] = cfg.set

    library.config_flags[cfg.flag] = cfg.set
    library.visible_flags[cfg.flag] = cfg.set_element_visible

    return setmetatable(cfg, library) 
end

    function library:toggle(options)
        local cfg = {
            enabled = options.enabled or nil,
            name = options.name or "Toggle",
            flag = options.flag or tostring(random(1,9999999)),
            callback = options.callback or function() end,
            default = options.default or false,
            unsafe = options.unsafe or false,
            colorpicker = options.color or nil,
            visible = options.visible or true,
            tooltip = options.tooltip or nil,
        }

        -- instances
            local toggle_holder = library:create("TextButton", {
                Parent = self.holder,
                FontFace = library.font,
                TextColor3 = rgb(151, 151, 151),
                BorderColor3 = rgb(0, 0, 0),
                Text = "",
                Name = "toggle",
                ZIndex = 1,
                Size = dim2(1, -8, 0, 12),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                AutomaticSize = Enum.AutomaticSize.Y,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextSize = 12,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            local right_components = library:create("Frame", {
                Parent = toggle_holder,
                Name = "right_components",
                Position = dim2(1, -1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(0, 0, 0, 12),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            cfg["right_holder"] = right_components
        
            local list = library:create("UIListLayout", {
                Parent = right_components,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                Padding = dim(0, 4),
                Name = "list",
                SortOrder = Enum.SortOrder.LayoutOrder
            })
        
            library:create("UIPadding", {
                Parent = toggle_holder
            })
        
            local left_components = library:create("Frame", {
                Parent = toggle_holder,
                Name = "left_components",
                BackgroundTransparency = 1,
                Position = dim2(0, 0, 0, 0),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(0, 0, 0, 14),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            })

            
            local text = library:create("TextLabel", {
                Parent = left_components,
                FontFace = library.font,
                TextColor3 = themes.preset.text,
                BorderColor3 = rgb(0, 0, 0),
                Text = cfg.name,
                Name = "text",
                BackgroundTransparency = 1,
                Size = dim2(0, 0, 1, -1),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.X,
                TextSize = 12,
                BackgroundColor3 = rgb(255, 255, 255)
            })

            if cfg.unsafe then
                text.TextColor3 = rgb(177, 57, 57)
            else
                text.TextColor3 = themes.preset.text
            end
        
            library:create("UIStroke", {
                Parent = text,
                LineJoinMode = Enum.LineJoinMode.Miter
            })
        
            library:create("UIListLayout", {
                Parent = left_components,
                Padding = dim(0, 5),
                Name = "_",
                FillDirection = Enum.FillDirection.Horizontal
            })
        
            local toggle = library:create("TextButton", {
                Parent = left_components,
                Name = "!toggle",
                Text = "",
                AutoButtonColor = false,
                Position = dim2(0, 0, 0, 2),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(0, 14, 0, 14),
                BorderSizePixel = 0,
                ZIndex = 1, 
                BackgroundColor3 = themes.preset.outline
            }) library:apply_theme(toggle, "outline", "BackgroundColor3") 
            library:apply_theme(toggle, "accent", "BackgroundColor3") 

            local inline = library:create("Frame", {
                Parent = toggle,
                Name = "inline",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                ZIndex = 2;
                BackgroundColor3 = themes.preset.inline
            }) library:apply_theme(inline, "inline", "BackgroundColor3") 
        
            local accent = library:create("Frame", {
                Parent = inline,
                BackgroundTransparency = 1;
                ZIndex = 3;
                Name = "background",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.accent
            })
            library:apply_theme(accent, "accent", "BackgroundColor3") 

            local UIGradient = library:create("UIGradient", {
                Parent = accent,
                Rotation = 90,
                Color = rgbseq{
                    rgbkey(0, rgb(255, 255, 255)),
                    rgbkey(1, rgb(167, 167, 167))
                }
            })

            local background = library:create("Frame", {
                Parent = inline,
                ZIndex = 2;
                Name = "background",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            library:apply_theme(background, "accent", "BackgroundColor3") 

            local UIGradient = library:create("UIGradient", {
                Parent = background,
                Rotation = 90,
                Name = "_",
                Color = rgbseq{
                    rgbkey(0, rgb(41, 41, 55)),
                    rgbkey(1, rgb(35, 35, 47))
                }
            }) library:apply_theme(UIGradient, "contrast", "Color") 
        --  

        library:hoverify(toggle_holder, toggle)

        function cfg.set(bool)
            cfg.enabled = bool 
            library:tween(accent, {BackgroundTransparency = bool and 0 or 1})
            flags[cfg.flag] = bool
            cfg.callback(bool)
        end

        function cfg.set_element_visible(bool)
            toggle_holder.Visible = bool 
        end 
    
        library:connection(toggle_holder.MouseButton1Click, function()
            cfg.enabled = not cfg.enabled
    
            cfg.set(cfg.enabled)
        end)

        library:connection(toggle.MouseButton1Click, function()
            cfg.enabled = not cfg.enabled
    
            cfg.set(cfg.enabled)
        end)

        if cfg.tooltip then 
            library:tool_tip({name = cfg.tooltip, path = toggle_holder})
        end

        cfg.set(cfg.default)
        
        cfg.set_element_visible(cfg.visible)
        
        library.config_flags[cfg.flag] = cfg.set
        library.visible_flags[cfg.flag] = cfg.set_element_visible

        return setmetatable(cfg, library)
    end
    
    function library:colorpicker(options)
        local parent = self.right_holder
        
        local cfg = {
            name = options.name or "Color", 
            flag = options.flag or tostring(2^789),
            color = options.color or color(1, 1, 1), -- Default to white color if not provided
            alpha = options.alpha or 1,
            callback = options.callback or function() end,
            right_holder = self.right_holder,
        }

        local dragging_sat = false 
        local dragging_hue = false 
        local dragging_alpha = false 

        local h, s, v = cfg.color:ToHSV() 
        local a = cfg.alpha 
        
        -- colorpicker button 
            local colorpicker_button = library:create("TextButton", {
                Parent = parent,
                Name = "outline",
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(0, 24, 0, 14),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.outline,
                Text = "",
                AutoButtonColor = false,
            }) library:apply_theme(colorpicker_button, "outline", "BackgroundColor3") 
        
            local inline = library:create("Frame", {
                Parent = colorpicker_button,
                Name = "inline",
                ZIndex = 2;
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.inline
            }) library:apply_theme(inline, "inline", "BackgroundColor3") 
        
            local handler = library:create("Frame", {
                Parent = inline,
                Name = "handler",
                ZIndex = 2;
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(250, 165, 27)
            })

            library:hoverify(colorpicker_button, colorpicker_button)
        
            local UIGradient = library:create("UIGradient", {
                Parent = handler,
                Rotation = 90,
                Color = rgbseq{
                    rgbkey(0, rgb(255, 255, 255)),
                    rgbkey(1, rgb(167, 167, 167))
                }
            })
        -- 

        -- colorpicker instances
            local colorpicker_holder = library:create("Frame", {
                Parent = sgui,
                Name = "colorpicker",
                Position = dim2(0, colorpicker_button.AbsolutePosition.X + 1, 0, colorpicker_button.AbsolutePosition.Y + 17),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(0, 190, 0, 210),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.outline,
                Visible = false,
                ZIndex = 1
            }) library:apply_theme(colorpicker_holder, "outline", "BackgroundColor3") 

            library:make_resizable(colorpicker_holder)
            
            local window_inline = library:create("Frame", {
                Parent = colorpicker_holder,
                Name = "window_inline",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.accent
            }) library:apply_theme(window_inline, "accent", "BackgroundColor3") 
            
            local window_holder = library:create("Frame", {
                Parent = window_inline,
                Name = "window_holder",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = themes.preset.outline,
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            })

            local UIGradient = library:create("UIGradient", {
                Parent = window_holder,
                Rotation = 90,
                Name = "_",
                Color = rgbseq{
                rgbkey(0, rgb(41, 41, 55)),
                rgbkey(1, rgb(35, 35, 47))
            }
            }) library:apply_theme(UIGradient, "contrast", "Color") 
            
            local text = library:create("TextLabel", {
                Parent = window_holder,
                FontFace = library.font,
                TextColor3 = themes.preset.text,
                BorderColor3 = rgb(0, 0, 0),
                Text = cfg.name,
                Name = "text",
                BackgroundTransparency = 1,
                Position = dim2(0, 2, 0, 4),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.XY,
                TextSize = 12,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            library:create("UIStroke", {
                Parent = text,
                LineJoinMode = Enum.LineJoinMode.Miter
            })
            
            library:create("UIPadding", {
                Parent = window_holder,
                Name = "_",
                PaddingBottom = dim(0, 4),
                PaddingRight = dim(0, 4),
                PaddingLeft = dim(0, 4)
            })
            
            local main_holder = library:create("Frame", {
                Parent = window_holder,
                Name = "main_holder",
                Position = dim2(0, 0, 0, 20),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, 0, 1, -40),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.inline
            }) library:apply_theme(main_holder, "inline", "BackgroundColor3") 
            
            cfg.holder = library:create( "Frame" , {
                Parent = colorpicker_holder;
                Name = "\0";
                Position = dim2(0, 6, 1, -21);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, -120, 0, 0);
                BorderSizePixel = 0;
            });
            
            local RainbowToggle = setmetatable(cfg, library):toggle({name = "Rainbow", flag = cfg.flag .. "_RAINBOW_FLAG"})

            cfg.holder = library:create( "Frame" , {
                Parent = colorpicker_holder;
                Name = "\0";
                Position = dim2(1, 2, 1, -23);
                BorderColor3 = rgb(0, 0, 0);
                AnchorPoint = vec2(1, 0);
                Size = dim2(1, -80, 0, 0);
                BorderSizePixel = 0;
            });
            
            local section = setmetatable(cfg, library)
            section:button_holder({})
            section:button({name = "Copy", callback = function()
                library.copied_flag = flags[cfg.flag]
                library.is_rainbow = cfg.flag .. "_RAINBOW_FLAG"
            end})
            section:button({name = "Paste", callback = function()
                cfg.set(library.copied_flag.Color, library.copied_flag.Transparency)
            end})

            local main_holder_inline = library:create("Frame", {
                Parent = main_holder,
                Name = "main_holder_inline",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.outline
            }) library:apply_theme(main_holder_inline, "outline", "BackgroundColor3") 
            
            local main_holder_background = library:create("Frame", {
                Parent = main_holder_inline,
                Name = "main_holder_background",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            local UIGradient = library:create("UIGradient", {
                Parent = main_holder_background,
                Rotation = 90,
                Name = "_",
                Color = rgbseq{
                    rgbkey(0, rgb(41, 41, 55)),
                    rgbkey(1, rgb(35, 35, 47))
                }
            }) library:apply_theme(UIGradient, "contrast", "Color") 
            
            library:create("UIPadding", {
                Parent = main_holder_background,
                PaddingTop = dim(0, 4),
                Name = "_",
                PaddingBottom = dim(0, 4),
                PaddingRight = dim(0, 4),
                PaddingLeft = dim(0, 4)
            })
            
            local alpha = library:create("TextButton", {
                Parent = main_holder_background,
                AnchorPoint = vec2(0, 0.5),
                Name = "alpha",
                Position = dim2(0, 0, 1, -8),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -20, 0, 14),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.inline,
                Text = "",
                AutoButtonColor = false,
            }) library:apply_theme(alpha, "inline", "BackgroundColor3") 
            
            local outline = library:create("Frame", {
                Parent = alpha,
                Name = "outline",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.outline
            }) library:apply_theme(outline, "outline", "BackgroundColor3") 
            
            local alpha_drag = library:create("Frame", {
                Parent = outline,
                Name = "alpha_drag",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(0, 221, 255)
            })
            
            local alphaind = library:create("ImageLabel", {
                Parent = alpha_drag,
                ScaleType = Enum.ScaleType.Tile,
                BorderColor3 = rgb(0, 0, 0),
                Image = "rbxassetid://18274452449",
                BackgroundTransparency = 1,
                Name = "alphaind",
                Size = dim2(1, 0, 1, 0),
                TileSize = dim2(0, 6, 0, 6),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            local UIGradient = library:create("UIGradient", {
                Parent = alphaind,
                Transparency = numseq{
                    numkey(0, 0),
                    numkey(1, 1)
                }
            })
            
            local alpha_picker = library:create("Frame", {
                Parent = alpha_drag,
                Name = "alpha_picker",
                BorderMode = Enum.BorderMode.Inset,
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(0, 4, 1, 0),
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            local hue = library:create("TextButton", {
                Parent = main_holder_background,
                AnchorPoint = vec2(1, 0),
                Name = "hue",
                Position = dim2(1, -1, 0, 0),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(0, 14, 1, -20),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.inline,
                Text = "",
                AutoButtonColor = false
            })
            
            local outline = library:create("Frame", {
                Parent = hue,
                Name = "outline",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.outline
            })
            
            local Frame = library:create("Frame", {
                Parent = outline,
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            local UIGradient = library:create("UIGradient", {
                Parent = Frame,
                Rotation = 270,
                Color = rgbseq{
                    rgbkey(0, rgb(255, 0, 0)),
                    rgbkey(0.17000000178813934, rgb(255, 255, 0)),
                    rgbkey(0.33000001311302185, rgb(0, 255, 0)),
                    rgbkey(0.5, rgb(0, 255, 255)),
                    rgbkey(0.6700000166893005, rgb(0, 0, 255)),
                    rgbkey(0.8299999833106995, rgb(255, 0, 255)),
                    rgbkey(1, rgb(255, 0, 0))
                }
            }) 
            
            local hue_picker = library:create("Frame", {
                Parent = Frame,
                Name = "hue_picker",
                BorderMode = Enum.BorderMode.Inset,
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, 0, 0, 4),
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            local visualize = library:create("Frame", {
                Parent = main_holder_background,
                AnchorPoint = vec2(1, 1),
                Name = "visualize",
                Position = dim2(1, -1, 1, -1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(0, 14, 0, 14),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.inline
            }) library:apply_theme(visualize, "inline", "BackgroundColor3") 
            
            local outline = library:create("Frame", {
                Parent = visualize,
                Size = dim2(1, -2, 1, -2),
                Name = "outline",
                Active = true,
                BorderColor3 = rgb(0, 0, 0),
                Position = dim2(0, 1, 0, 1),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.outline
            }) library:apply_theme(outline, "outline", "BackgroundColor3") 
            
            local visualize = library:create("Frame", {
                Parent = outline,
                Size = dim2(1, -2, 1, -2),
                Name = "visualize",
                Active = true,
                BorderColor3 = rgb(0, 0, 0),
                Position = dim2(0, 1, 0, 1),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(0, 221, 255)
            })
            
            local satval_picker = library:create("Frame", {
                Parent = main_holder_background,
                Name = "satval_picker",
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -20, 1, -20),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.inline
            }) library:apply_theme(satval_picker, "inline", "BackgroundColor3") 
            
            local outline = library:create("Frame", {
                Parent = satval_picker,
                Name = "outline",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.outline
            }) library:apply_theme(outline, "outline", "BackgroundColor3") 
            
            local colorpicker = library:create("Frame", {
                Parent = outline,
                Name = "colorpicker",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(0, 221, 255)
            })
            
            local sat = library:create("TextButton", {
                Parent = colorpicker,
                Name = "sat",
                Size = dim2(1, 0, 1, 0),
                BorderColor3 = rgb(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255),
                Text = "",
                AutoButtonColor = false,
            })
            
            local UIGradient = library:create("UIGradient", {
                Parent = sat,
                Rotation = 270,
                Transparency = numseq{
                    numkey(0, 0),
                    numkey(1, 1)
                },
                Color = rgbseq{
                    rgbkey(0, rgb(0, 0, 0)),
                    rgbkey(1, rgb(0, 0, 0))
                }
            })
            
            local val = library:create("TextButton", {
                Parent = colorpicker,
                Name = "val",
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, 0, 1, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255),
                Text = "",
                AutoButtonColor = false,
            })
            
            local UIGradient = library:create("UIGradient", {
                Parent = val,
                Transparency = numseq{
                    numkey(0, 0),
                    numkey(1, 1)
                }
            })
            
            local satval_picker_REAL = library:create("Frame", {
                Parent = colorpicker,
                Name = "satval_picker_REAL",
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(0, 2, 0, 2),
                BorderSizePixel = 1,
                BackgroundColor3 = rgb(255, 255, 255),
                ZIndex = 3, 
            })
        -- 
            
        function cfg.set_visible(bool)
            colorpicker_holder.Visible = bool

            if bool then 
                if library.current_element_open and library.current_element_open ~= cfg then 
                    library.current_element_open.set_visible(false)
                    library.current_element_open.open = false 
                end

                library.current_element_open = cfg
                colorpicker_holder.Position = dim2(0, colorpicker_button.AbsolutePosition.X + 1, 0, colorpicker_button.AbsolutePosition.Y + 17)
            end
        end 

        colorpicker_button.MouseButton1Click:Connect(function()		
            cfg.open = not cfg.open

            cfg.set_visible(cfg.open) 
        end)

        function cfg.set(color, alpha)
            if color then 
                h, s, v = color:ToHSV()
            end 
        
            if alpha then 
                a = alpha
            end 
        
            local hsv_position = Color3.fromHSV(h, s, v)
            local Color = Color3.fromHSV(h, s, v)
            
            local value = 1 - h
            local offset = (value < 1) and 0 or -4
            hue_picker.Position = dim2(0, 0, value, offset)

            local offset = (a < 1) and 0 or -4
            alpha_picker.Position = dim2(a, offset, 0, 0)

            alpha_drag.BackgroundColor3 = Color3.fromHSV(h, s, v)
            
            visualize.BackgroundColor3 = Color
            handler.BackgroundColor3 = Color 

            colorpicker.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
            
            cfg.color = Color
            cfg.alpha = a
            
            local s_offset = (s < 1) and 0 or -3
            local v_offset = (1 - v < 1) and 0 or -3
            satval_picker_REAL.Position = dim2(s, s_offset, 1 - v, v_offset)

            flags[cfg.flag] = {} 
            flags[cfg.flag]["Color"] = Color
            flags[cfg.flag]["Transparency"] = a
        
            cfg.callback(Color, a)
        end

        function cfg.update_color() 
            local mouse = uis:GetMouseLocation() 

            if dragging_sat then	
                s = math.clamp((vec2(mouse.X, mouse.Y - gui_offset) - val.AbsolutePosition).X / val.AbsoluteSize.X, 0, 1)
                v = 1 - math.clamp((vec2(mouse.X, mouse.Y - gui_offset) - sat.AbsolutePosition).Y / sat.AbsoluteSize.Y, 0, 1)
            elseif dragging_hue then 
                h = math.clamp(1 - (vec2(mouse.X, mouse.Y - gui_offset) - hue.AbsolutePosition).Y / hue.AbsoluteSize.Y, 0, 1)
            elseif dragging_alpha then 
                a = math.clamp((vec2(mouse.X, mouse.Y - gui_offset) - alpha.AbsolutePosition).X / alpha.AbsoluteSize.X, 0, 1)
            end

            cfg.set(nil, nil)
        end
        
        alpha.MouseButton1Down:Connect(function()
            dragging_alpha = true 
        end)

        hue.MouseButton1Down:Connect(function()
            dragging_hue = true 
        end)

        sat.MouseButton1Down:Connect(function()
            dragging_sat = true  
        end)

        uis.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging_sat = false
                dragging_hue = false
                dragging_alpha = false 
            end
        end)

        uis.InputChanged:Connect(function(input)
            if (dragging_sat or dragging_hue or dragging_alpha) and input.UserInputType == Enum.UserInputType.MouseMovement then
                cfg.update_color() 
            end
        end)	

        task.spawn(function()
            while true do 
                task.wait()
                if flags[cfg.flag .. "_RAINBOW_FLAG"] then 
                    cfg.set(
                        hsv(math.abs(math.sin(tick())), 
                        s, 
                        v
                    ), a) 
                end     
            end     
        end)

        cfg.set(cfg.color, cfg.alpha)

        library.config_flags[cfg.flag] = cfg.set
    
        return setmetatable(cfg, library) 
    end

    function library:keybind(options)
        local parent = self.right_holder

        local cfg = {
            flag = options.flag or "SET ME A FLAG NOWWW!!!!",
            callback = options.callback or function() end,
            open = false,
            binding = nil, 
            name = options.name or nil, 
            ignore_key = options.ignore or false, 

            key = options.key or nil, 
            mode = options.mode or "toggle",
            active = options.default or false, 

            hold_instances = {},
        }

        flags[cfg.flag] = {} 
        
        local KEYBIND_ELEMENT;
        if cfg.name then 
            KEYBIND_ELEMENT = library:create("TextLabel", {
                Parent = library.keybind_list,
                Name = "",
                FontFace = library.font,
                TextColor3 = themes.preset.text,
                BorderColor3 = rgb(0, 0, 0),
                Text = "[ Hold ]  Fly - X",
                Size = dim2(1, -5, 0, 18),
                Visible = false, 
                Position = dim2(0, 5, 0, -1),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                AutomaticSize = Enum.AutomaticSize.Y,
                TextSize = 12,
                BackgroundColor3 = themes.preset.text
            }, "text")
        end 

        local element_outline = library:create("TextButton", {
            Parent = parent,
            Name = "",
            BorderColor3 = rgb(0, 0, 0),
            Text = "", 
            Size = dim2(0, 24, 0, 14),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundColor3 = themes.preset.outline
        }) library:apply_theme(element_outline, "outline", "BackgroundColor3")

        library:create("UIPadding", {
            Parent = element_outline,
            PaddingRight = dim(0, 2),
        })

        local instance = library:hoverify(element_outline, element_outline)
        instance.Size = dim2(1, 2, 1, 0)

        local inline = library:create("Frame", {
            Parent = element_outline,
            Name = "",
            Position = dim2(0, 1, 0, 1),
            BorderColor3 = rgb(0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.X,
            Size = dim2(1, -2, 1, -2),
            ZIndex = 2;
            BorderSizePixel = 0,
            BackgroundColor3 = themes.preset.inline
        }) library:apply_theme(inline, "inline", "BackgroundColor3") 

        library:create("UIPadding", {
            Parent = inline,
            PaddingRight = dim(0, 2),
        })
        
        local handler = library:create("Frame", {
            Parent = inline,
            Name = "",
            ZIndex = 2;
            Position = dim2(0, 1, 0, 1),
            BorderColor3 = rgb(0, 0, 0),
            Size = dim2(1, -2, 1, -2),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundColor3 = rgb(255, 255, 255)
        })

        local UIGradient = library:create("UIGradient", {
            Parent = handler,
            Name = "",
            Rotation = 90,
            Color = rgbseq{
                rgbkey(0, rgb(41, 41, 55)),
                rgbkey(1, rgb(35, 35, 47))
            }
        }); library:apply_theme(UIGradient, "contrast", "Color") 
        
        local key_text = library:create("TextLabel", {
            Parent = handler,
            Name = "",
            FontFace = library.font,
            TextColor3 = themes.preset.text,
            BorderColor3 = rgb(0, 0, 0),
            ZIndex = 2;
            Text = "b",
            Size = dim2(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Position = dim2(0, 0, 0, -2),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
            TextSize = 12,
            BackgroundColor3 = rgb(255, 255, 255)
        })

        library:create("UIPadding", {
            Parent = key_text,
            PaddingLeft = dim(0, 3),
            PaddingRight = dim(0, 2),
        })
        
        -- mode selector
            local keybind_selector = library:create("Frame", {
                Parent = sgui,
                Name = "",
                Position = dim2(0, element_outline.AbsolutePosition.X + 1, 0, element_outline.AbsolutePosition.Y + 17),
                BorderColor3 = rgb(255, 255, 255),
                BorderSizePixel = 2,
                Visible = false, 
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            library:create("UIListLayout", {
                Parent = keybind_selector,
                Name = "",
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalFlex = Enum.UIFlexAlignment.Fill,
                Padding = dim(0, 2)
            })
            
            local hold_button = library:create("TextButton", {
                Parent = keybind_selector,
                Name = "",
                FontFace = library.font,
                TextColor3 = themes.preset.text,
                BorderColor3 = rgb(0, 0, 0),
                Text = "hold",
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.XY,
                BorderSizePixel = 0,
                ZIndex = 2,
                TextSize = 12,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            library:create("UIStroke", {
                Parent = hold_button,
                Name = "",
                LineJoinMode = Enum.LineJoinMode.Miter
            })
            
            library:create("UIPadding", {
                Parent = keybind_selector,
                Name = "",
                PaddingTop = dim(0, 3),
                PaddingBottom = dim(0, 5),
                PaddingRight = dim(0, 5),
                PaddingLeft = dim(0, 5)
            })
            
            local toggle_button = library:create("TextButton", {
                Parent = keybind_selector,
                Name = "",
                FontFace = library.font,
                TextColor3 = themes.preset.text,
                BorderColor3 = rgb(0, 0, 0),
                Text = "toggle",
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.XY,
                BorderSizePixel = 0,
                ZIndex = 2,
                TextSize = 12,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            library:create("UIStroke", {
                Parent = toggle_button,
                Name = "",
                LineJoinMode = Enum.LineJoinMode.Miter
            })
            
            local always_button = library:create("TextButton", {
                Parent = keybind_selector,
                Name = "",
                FontFace = library.font,
                TextColor3 = themes.preset.text,
                BorderColor3 = rgb(0, 0, 0),
                Text = "always",
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.XY,
                BorderSizePixel = 0,
                ZIndex = 2,
                TextSize = 12,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            library:create("UIStroke", {
                Parent = always_button,
                Name = "",
                LineJoinMode = Enum.LineJoinMode.Miter
            })

            -- Hex has a big dick
            
            local UIGradient = library:create("UIGradient", {
                Parent = keybind_selector,
                Name = "",
                Rotation = 90,
                Color = rgbseq{
                    rgbkey(0, rgb(41, 41, 55)),
                    rgbkey(1, rgb(35, 35, 47))
                }
            }); library:apply_theme(UIGradient, "contrast", "Color")
            
            local UIStroke = library:create("UIStroke", {
                Parent = keybind_selector,
                Name = "",
                Color = themes.preset.inline,
                LineJoinMode = Enum.LineJoinMode.Miter,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })
        -- 

        -- init 
            function cfg.set_visible(bool)
                keybind_selector.Visible = bool
                keybind_selector.Position = dim2(0, element_outline.AbsolutePosition.X + 1, 0, element_outline.AbsolutePosition.Y + 17)

                if bool then 
                    if library.current_element_open and library.current_element_open ~= cfg then 
                        library.current_element_open.set_visible(false)
                        library.current_element_open.open = false 
                    end

                    library.current_element_open = cfg 
                end
            end 

            function cfg.set_mode(mode) 
                cfg.mode = mode 

                if mode == "always" then
                    cfg.set(true)
                elseif mode == "hold" then
                    cfg.set(false)
                end

                flags[cfg.flag]["mode"] = mode
                local accent = themes.preset.accent
                local normal = themes.preset.text

                hold_button.TextColor3 = cfg.mode == "hold" and accent or normal
                toggle_button.TextColor3 = cfg.mode == "toggle" and accent or normal
                always_button.TextColor3 = cfg.mode == "always" and accent or normal
            end 

            function cfg.set(input)
                if type(input) == "boolean" then 
                    local __cached = input 

                    if cfg.mode == "always" then 
                        __cached = true 
                    end 

                    cfg.active = __cached 
                    flags[cfg.flag]["active"] = __cached 
                    cfg.callback(__cached)
                elseif tostring(input):find("Enum") then 
                    input = input.Name == "Escape" and "none" or input
                    
                    cfg.key = input or "none"	

                    local _text = keys[cfg.key] or tostring(cfg.key):gsub("Enum.", "")
                    local _text2 = (tostring(_text):gsub("KeyCode.", ""):gsub("UserInputType.", "")) or "none"
                    cfg.key_name = _text2

                    flags[cfg.flag]["mode"] = cfg.mode 
                    flags[cfg.flag]["key"] = cfg.key 

                    key_text.Text = string.lower(_text2)

                    cfg.callback(cfg.active or false)
                elseif find({"toggle", "hold", "always"}, input) then 
                    cfg.set_mode(input)

                    if input == "always" then 
                        cfg.active = true 
                    end 

                    cfg.callback(cfg.active or false)
                elseif type(input) == "table" then 
                    input.key = type(input.key) == "string" and input.key ~= "none" and library:convert_enum(input.key) or input.key

                    input.key = input.key == Enum.KeyCode.Escape and "none" or input.key
                    cfg.key = input.key or "none"
                    
                    cfg.mode = input.mode or "toggle"

                    if input.active then
                        cfg.active = input.active
                    end

                    local text = tostring(cfg.key) ~= "Enums" and (keys[cfg.key] or tostring(cfg.key):gsub("Enum.", "")) or nil
                    local __text = text and (tostring(text):gsub("KeyCode.", ""):gsub("UserInputType.", ""))
                    
                    key_text.Text = string.lower(__text) or "none"
                    cfg.key_name = __text
                end 

                flags[cfg.flag] = {
                    mode = cfg.mode,
                    key = cfg.key, 
                    active = cfg.active
                }
                
                if cfg.name then 
                    KEYBIND_ELEMENT.Visible = cfg.active

                    library:tween(KEYBIND_ELEMENT, {
                        TextTransparency = cfg.active and 0 or 1, 
                    }) 

                    library:tween(KEYBIND_ELEMENT:FindFirstChildOfClass("UIStroke"), {
                        Transparency = cfg.active and 0 or 1, 
                    }) 
                    
                    local text = tostring(cfg.key) ~= "Enums" and (keys[cfg.key] or tostring(cfg.key):gsub("Enum.", "")) or nil
                    local __text = text and (tostring(text):gsub("KeyCode.", ""):gsub("UserInputType.", ""))

                    if cfg.name then 
                        KEYBIND_ELEMENT.Text = "[ " .. string.upper(string.sub(cfg.mode, 1, 1)) .. string.sub(cfg.mode, 2) .. " ] " .. cfg.name .. " - " .. __text
                    end
                end
            end


            -- ok bro its 30 april2025.. what is this code from october 2024 💀💀
            hold_button.MouseButton1Click:Connect(function()
                cfg.set_mode("hold") 
                cfg.set_visible(false)
                cfg.open = false 
            end) 

            toggle_button.MouseButton1Click:Connect(function()
                cfg.set_mode("toggle") 
                cfg.set_visible(false)
                cfg.open = false 
            end) 

            always_button.MouseButton1Click:Connect(function()
                cfg.set_mode("always") 
                cfg.set_visible(false)
                cfg.open = false 
            end) 
            
            element_outline.MouseButton2Click:Connect(function()
                cfg.open = not cfg.open 

                cfg.set_visible(cfg.open)
            end)

            element_outline.MouseButton1Down:Connect(function()
                task.wait()
                key_text.Text = "none"	

                if cfg.binding then return end 

                cfg.binding = library:connection(uis.InputBegan, function(input, game_event)  
                    local selected_key = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType

                    cfg.set(selected_key)

                    cfg.binding:Disconnect() 
                    cfg.binding = nil
                end)
            end)

            library:connection(uis.InputBegan, function(input, game_event) 
                local selected_key = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType

                if not game_event then 
                    if selected_key == cfg.key then 
                        if cfg.mode == "toggle" then 
                            cfg.active = not cfg.active
                            cfg.set(cfg.active)
                        elseif cfg.mode == "hold" then 
                            cfg.set(true)
                        end
                    end
                end
            end)

            library:connection(uis.InputEnded, function(input, game_event) 
                if game_event then 
                    return 
                end 

                local selected_key = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType
    
                if selected_key == cfg.key then
                    if cfg.mode == "hold" then 
                        cfg.set(false)
                    end
                end
            end)
    
            cfg.set({mode = cfg.mode, active = cfg.active, key = cfg.key})
    
            library.config_flags[cfg.flag] = cfg.set
        -- 
        
        library.config_flags[cfg.flag] = cfg.set

        return setmetatable(cfg, library) 
    end 

    function library:dropdown(options)
        local parent = self.holder 

        local cfg = {
            name = options.name or nil,
            flag = options.flag or tostring(random(1,9999999)),

            items = options.items or {"1", "2", "3"},
            callback = options.callback or function() end,
            multi = options.multi or false, 
            visible = options.visible or true,

            open = false, 
            option_instances = {}, 
            multi_items = {}, 
            scrolling = options.scrolling or false, 
            ignore = options.ignore or nil,
        }

        cfg.default = options.default or (cfg.multi and {cfg.items[1]}) or cfg.items[1] or nil

        -- dropdown elements
            local dropdown_REAL = library:create("TextLabel", {
                Parent = parent,
                FontFace = library.font,
                TextColor3 = themes.preset.text,
                BorderColor3 = rgb(0, 0, 0),
                Text = "",
                Name = "dropdown",
                ZIndex = 2,
                Size = dim2(1, -8, 0, 12),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                AutomaticSize = Enum.AutomaticSize.Y,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextSize = 12,
                BackgroundColor3 = rgb(255, 255, 255)
            })

            local main_text      
            if cfg.name then 
                local left_components = library:create("Frame", {
                    Parent = dropdown_REAL,
                    Name = "left_components",
                    BackgroundTransparency = 1,
                    Position = dim2(0, 2, 0, -1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(0, 0, 0, 14),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                })

                main_text = library:create("TextLabel", {
                    Parent = left_components,
                    FontFace = library.font,
                    TextColor3 = themes.preset.text,
                    BorderColor3 = rgb(0, 0, 0),
                    Text = cfg.name,
                    Name = "text",
                    BackgroundTransparency = 1,
                    Size = dim2(0, 0, 1, -1),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                library:create("UIStroke", {
                    Parent = main_text,
                    LineJoinMode = Enum.LineJoinMode.Miter
                })
                
                library:create("UIListLayout", {
                    Parent = left_components,
                    Padding = dim(0, 5),
                    Name = "_",
                    FillDirection = Enum.FillDirection.Horizontal
                })

                local right_components = library:create("Frame", {
                    Parent = dropdown_REAL,
                    Name = "right_components",
                    Position = dim2(1, -1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(0, 0, 0, 12),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                cfg["right_holder"] = right_components
    
                local list = library:create("UIListLayout", {
                    Parent = right_components,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                    Padding = dim(0, 4),
                    Name = "list",
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
            end 

            local bottom_components = library:create("Frame", {
                Parent = dropdown_REAL,
                Name = "bottom_components",
                Position = dim2(0, 0, 0, cfg.name and 15 or 0),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, 26, 0, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            local dropdown = library:create("TextButton", {
                Parent = bottom_components,
                Name = "dropdown",
                Position = dim2(0, 0, 0, 2),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -27, 1, 18),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.outline,
                Text = "",
                AutoButtonColor = false, 
            }) library:apply_theme(dropdown, "outline", "BackgroundColor3") 
            
            library:hoverify(dropdown_REAL, dropdown)

            local inline = library:create("Frame", {
                Parent = dropdown,
                Name = "inline",
                ZIndex = 2;
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.inline
            }) library:apply_theme(inline, "inline", "BackgroundColor3") 
            
            local background = library:create("Frame", {
                Parent = inline,
                Name = "background",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                ZIndex = 2;
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.accent
            }) library:apply_theme(background, "accent", "BackgroundColor3") 
            
            local contrast = library:create("Frame", {
                Parent = background,
                Name = "contrast",
                ZIndex = 2;
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, 0, 1, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            })

            local plus = library:create("TextLabel", {
                Parent = contrast,
                TextWrapped = true,
                TextColor3 = themes.preset.text,
                BorderColor3 = rgb(0, 0, 0),
                ZIndex = 2;
                Text = "+",
                Name = "plus",
                Size = dim2(1, -4, 1, 0),
                Position = dim2(0, 0, 0, -1),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Right,
                FontFace = library.font,
                TextTruncate = Enum.TextTruncate.AtEnd,
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            library:create("UIStroke", {
                Parent = plus,
                LineJoinMode = Enum.LineJoinMode.Miter
            })
            
            local text = library:create("TextLabel", {
                Parent = contrast,
                FontFace = library.font,
                TextColor3 = themes.preset.text,
                ZIndex = 2;
                BorderColor3 = rgb(0, 0, 0),
                Text = "aa",
                Name = "text",
                Size = dim2(1, -4, 1, 0),
                Position = dim2(0, 4, 0, -1),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextSize = 12,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            library:create("UIStroke", {
                Parent = text,
                LineJoinMode = Enum.LineJoinMode.Miter
            })
            
            local UIGradient = library:create("UIGradient", {
                Parent = contrast,
                Rotation = 90,
                Color = rgbseq{
                    rgbkey(0, rgb(41, 41, 55)),
                    rgbkey(1, rgb(35, 35, 47))
                }
            }) library:apply_theme(UIGradient, "contrast", "Color") 
            
            local UIGradient = library:create("UIGradient", {
                Parent = background,
                Rotation = 90,
                Color = rgbseq{
                    rgbkey(0, rgb(255, 255, 255)),
                    rgbkey(1, rgb(167, 167, 167))
                }
            }) library:apply_theme(UIGradient, "contrast", "Color") 
            
            library:create("UIListLayout", {
                Parent = bottom_components,
                Padding = dim(0, 10),
                Name = "_",
                SortOrder = Enum.SortOrder.LayoutOrder
            })     
        --

        -- dropdown holder
            local dropdown_holder = library:create("Frame", {
                Parent = sgui,
                BorderColor3 = rgb(0, 0, 0),
                Name = "dropdown_holder",
                BackgroundTransparency = 1,
                Position = dim2(0, dropdown.AbsolutePosition.X + 1, 0, dropdown.AbsolutePosition.Y + 22),
                Size = dim2(0, dropdown.AbsoluteSize.X, 0, cfg.scrolling and 180 or 0),
                BorderSizePixel = 0,
                AutomaticSize = cfg.scrolling and Enum.AutomaticSize.None or Enum.AutomaticSize.Y,
                BackgroundColor3 = themes.preset.outline,
                Visible = false
            })
            
            local inline = library:create("Frame", {
                Parent = dropdown_holder,
                Size = dim2(1, -2, 1, 2),
                Name = "inline",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.inline
            }) library:apply_theme(inline, "inline", "BackgroundColor3") 
            
            local background; 
            if not cfg.scrolling then 
                background = library:create("Frame", {
                    Parent = inline,
                    BorderColor3 = rgb(0, 0, 0),
                    Name = "background",
                    BackgroundTransparency = 1,
                    Position = dim2(0, 1, 0, 1),
                    Size = dim2(1, -2, 1, 1),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = themes.preset.accent
                })
                library:apply_theme(background, "accent", "BackgroundColor3") 
            else 
                background = library:create("ScrollingFrame", {
                    Parent = inline,
                    BorderColor3 = rgb(0, 0, 0),
                    Name = "background",
                    BackgroundTransparency = 1,
                    MidImage = "rbxassetid://103468666327206",
                    TopImage = "rbxassetid://103468666327206",
                    BottomImage = "rbxassetid://103468666327206",
                    Position = dim2(0, 1, 0, 1),
                    Size = dim2(1, -2, 1, 1),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = themes.preset.accent,
                    CanvasSize = dim2(0, 0, 0, 0),
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 2,
                    ScrollBarImageColor3 = themes.preset.accent
                })
                library:apply_theme(background, "accent", "BackgroundColor3") 
                library:apply_theme(background, "accent", "ScrollBarImageColor3") 
            end 
            
            local contrast = library:create("Frame", {
                Parent = background,
                Name = "contrast",
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, 0, 1, -3),
                BorderSizePixel = 0,
                ZIndex = 2, 
                BackgroundColor3 = rgb(255, 255, 255),
                AutomaticSize = cfg.scrolling and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
            }); 

            library:create("UIPadding", {
                Parent = contrast,
                PaddingTop = dim(0, 2),
                PaddingBottom = dim(0, 2),
                PaddingRight = dim(0, 0),
                PaddingLeft = dim(0, 4)
            })
            
            local UIGradient = library:create("UIGradient", {
                Parent = contrast,
                Rotation = 90,
                Color = rgbseq{
                    rgbkey(0, rgb(41, 41, 55)),
                    rgbkey(1, rgb(35, 35, 47))
                }
            }) library:apply_theme(UIGradient, "contrast", "Color") 
        
            library:create("UIListLayout", {
                Parent = contrast,
                Padding = dim(0, 5),
                SortOrder = Enum.SortOrder.LayoutOrder
            }) library:apply_theme(UIGradient, "contrast", "Color") 
            
            local UIGradient = library:create("UIGradient", {
                Parent = background,
                Rotation = 90,
                Color = rgbseq{
                    rgbkey(0, rgb(255, 255, 255)),
                    rgbkey(1, rgb(167, 167, 167))
                }
            }) library:apply_theme(UIGradient, "contrast", "Color") 
            
            local stroke = library:create("UIStroke", {
                Parent = inline,
                Color = themes.preset.outline,
                LineJoinMode = Enum.LineJoinMode.Miter
            }) library:apply_theme(stroke, "outline", "Color") 
        -- 
            
        function cfg.set_element_visible(bool)
            dropdown_REAL.Visible = bool 

            if main_text then 
                main_text.Visible = bool
            end 
        end 

        function cfg.set_visible(bool) 
            library.current_element_open = cfg.ignore or cfg

            dropdown_holder.Visible = bool

            plus.Text = bool and "-" or "+"
            plus.TextSize = bool and 12 or 8

            if bool then 
                if library.current_element_open and library.current_element_open ~= cfg and not cfg.ignore then 
                    library.current_element_open.set_visible(false)
                    library.current_element_open.open = false 
                end

                dropdown_holder.Size = dim2(0, dropdown.AbsoluteSize.X, 0, dropdown_holder.Size.Y.Offset)
                dropdown_holder.Position = dim2(0, dropdown.AbsolutePosition.X + 1, 0, dropdown.AbsolutePosition.Y + 22)                    
            end
        end

        function cfg.set(value) 
            local selected = {}

            local is_table = type(value) == "table"

            for _,v in next, cfg.option_instances do 
                if v.Text == value or (is_table and find(value, v.Text)) then 
                    insert(selected, v.Text)
                    cfg.multi_items = selected
                    v.TextColor3 = themes.preset.accent
                else 
                    v.TextColor3 = themes.preset.text
                end
            end

            text.Text = is_table and concat(selected, ", ") or selected[1] or "nun"
            flags[cfg.flag] = is_table and selected or selected[1]
            cfg.callback(flags[cfg.flag]) 
        end
        
        function cfg:refresh_options(refreshed_list) 
            for _, v in next, cfg.option_instances do 
                v:Destroy() 
            end

            cfg.option_instances = {} 

            for i,v in next, refreshed_list do 
                local TextButton = library:create("TextButton", {
                    Parent = contrast,
                    FontFace = library.font,
                    TextColor3 = themes.preset.text,
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, 0, 0, 0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 2, 
                    Text = v,
                    BackgroundColor3 = rgb(255, 255, 255)
                }) library:apply_theme(TextButton, "accent", "TextColor3") 
                
                library:create("UIStroke", {
                    Parent = TextButton,
                    LineJoinMode = Enum.LineJoinMode.Miter
                })

                insert(cfg.option_instances, TextButton)

                TextButton.MouseButton1Down:Connect(function()
                    if cfg.multi then 
                        local selected_index = find(cfg.multi_items, TextButton.Text)

                        if selected_index then 
                            remove(cfg.multi_items, selected_index)
                        else
                            insert(cfg.multi_items, TextButton.Text)
                        end

                        cfg.set(cfg.multi_items) 				
                    else 
                        cfg.set_visible(false)
                        cfg.open = false 

                        cfg.set(TextButton.Text)
                    end
                end)
            end
        end

        dropdown.MouseButton1Click:Connect(function()
            cfg.open = not cfg.open 

            cfg.set_visible(cfg.open)
        end)

        cfg:refresh_options(cfg.items) 

        cfg.set(cfg.default)
        
        library.config_flags[cfg.flag] = cfg.set
        library.visible_flags[cfg.flag] = cfg.set_element_visible

        cfg.set_element_visible(cfg.visible)

        return setmetatable(cfg, library)
    end 

    function library:list(options)
        local cfg = {
            callback = options and options.callback or function() end, 

            scale = options.size or 232, 
            items = options.items or {"1", "2", "3"}, 
            -- order = options.order or 1, 
            placeholdertext = options.placeholder or options.placeholdertext or "search here...",
            visible = options.visible or true,

            option_instances = {}, 
            current_instance = nil, 
            flag = options.flag or "SET A FLAG U NIGGER", 

        } 

        -- instances 
            local list_holder = library:create("TextLabel", {
                Parent = self.holder,
                Name = "",
                FontFace = library.font,
                TextColor3 = themes.preset.text,
                BorderColor3 = rgb(0, 0, 0),
                Text = "",
                ZIndex = 2,
                Size = dim2(1, -8, 0, 12),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                AutomaticSize = Enum.AutomaticSize.Y,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextSize = 12,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            local UIPadding = library:create("UIPadding", {
                Parent = list_holder,
                Name = "",
                PaddingLeft = dim(0, 1)
            })
            
            local UIStroke = library:create("UIStroke", {
                Parent = list_holder,
                Name = ""
            })
            
            local bottom_components = library:create("Frame", {
                Parent = list_holder,
                Name = "",
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, 26, 0, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            library:create("UIListLayout", {
                Parent = bottom_components,
                Name = "",
                Padding = dim(0, 10),
                SortOrder = Enum.SortOrder.LayoutOrder
            })
            
            local list = library:create("Frame", {
                Parent = bottom_components,
                Name = "",
                Position = dim2(0, 0, 0, 2),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -27, 1, cfg.scale),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.outline
            }) library:apply_theme(main_holder, "outline", "BackgroundColor3") 
            
            local inline = library:create("Frame", {
                Parent = list,
                Name = "",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.inline
            }) library:apply_theme(inline, "inline", "BackgroundColor3") 
            
            local background = library:create("Frame", {
                Parent = inline,
                Name = "",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.accent
            }) library:apply_theme(background, "accent", "BackgroundColor3") 
            
            local UIGradient = library:create("UIGradient", {
                Parent = background,
                Name = "",
                Rotation = 90,
                Color = rgbseq{
                rgbkey(0, rgb(255, 255, 255)),
                rgbkey(1, rgb(167, 167, 167))
            }
            }) library:apply_theme(UIGradient, "contrast", "Color") 
            
            local contrast = library:create("Frame", {
                Parent = background,
                Name = "",
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, 0, 1, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            local UIGradient = library:create("UIGradient", {
                Parent = contrast,
                Name = "",
                Rotation = 90,
                Color = rgbseq{
                rgbkey(0, rgb(41, 41, 55)),
                rgbkey(1, rgb(35, 35, 47))
            }
            }) library:apply_theme(UIGradient, "contrast", "Color") 
            
            local ScrollingFrame = library:create("ScrollingFrame", {
                Parent = contrast,
                Name = "",
                ScrollBarImageColor3 = themes.preset.accent,
                Active = true,
                MidImage = "rbxassetid://103468666327206",
                TopImage = "rbxassetid://103468666327206",
                BottomImage = "rbxassetid://103468666327206",
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ScrollBarThickness = 2,
                BackgroundTransparency = 1,
                Size = dim2(1, 0, 1, 0),
                BackgroundColor3 = rgb(255, 255, 255),
                BorderColor3 = rgb(0, 0, 0),
                BorderSizePixel = 0,
                CanvasSize = dim2(0, 0, 0, 0)
            }) library:apply_theme(ScrollingFrame, "accent", "ScrollBarImageColor3") 
            
            local UIPadding = library:create("UIPadding", {
                Parent = ScrollingFrame,
                Name = "",
                PaddingBottom = dim(0, 4),
                PaddingTop = dim(0, 4)
            })
            
            local UIListLayout = library:create("UIListLayout", {
                Parent = ScrollingFrame,
                Name = "",
                Padding = dim(0, 4),
                SortOrder = Enum.SortOrder.LayoutOrder
            })
        --  

        function cfg.render_option(text) 
            local TextButton = library:create("TextButton", {
                Parent = ScrollingFrame,
                Name = "",
                Text = tostring(text),
                FontFace = library.font,
                TextColor3 = themes.preset.text,
                BorderColor3 = rgb(0, 0, 0),
                BackgroundTransparency = 1,
                Size = dim2(1, 0, 0, 0),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y,
                TextSize = 12,
                BackgroundColor3 = rgb(255, 255, 255)
            })

            library:apply_theme(TextButton, "accent", "TextColor3") 

            local UIStroke = library:create("UIStroke", {
                Parent = TextButton,
                Name = ""
            })

            return TextButton 
        end 

        function cfg.set_element_visible(bool)
            list_holder.Visible = bool 
        end

        function cfg.refresh_options(options) 
            if type(options) == "function" then 
                return 
            end 

            for _, v in next, cfg.option_instances do 
                v:Destroy() 
            end 

            for _, option in next, options do 
                local button = cfg.render_option(option) 

                insert(cfg.option_instances, button)

                button.MouseButton1Click:Connect(function()
                    if cfg.current_instance and cfg.current_instance ~= button then 
                        cfg.current_instance.TextColor3 = themes.preset.text 
                    end 

                    cfg.current_instance = button 
                    button.TextColor3 = themes.preset.accent 

                    flags[cfg.flag] = button.text
                    cfg.callback(button.text)
                end)
            end 
        end     

        function cfg.filter_options(text)
            for _, v in next, cfg.option_instances do 
                if string.find(v.Text, text) then 
                    v.Visible = true 
                else 
                    v.Visible = false
                end
            end
        end 

        function cfg.set(value)
            for _, buttons in next, cfg.option_instances do 
                if buttons.Text == value then 
                    buttons.TextColor3 = themes.preset.accent 
                else 
                    buttons.TextColor3 = themes.preset.text 
                end 
            end 

            flags[cfg.flag] = value
            cfg.callback(value)
        end 

        cfg.refresh_options(cfg.items) 
        cfg.set_element_visible(cfg.visible)

        library.visible_flags[cfg.flag] = cfg.set_element_visible
        library.config_flags[cfg.flag] = cfg.set

        return setmetatable(cfg, library)
    end 

    function library:textbox(options)
        local cfg = {
            placeholder = options.placeholder or options.placeholdertext or options.holder or options.holdertext or "type here...",
            default = options.default,
            flag = options.flag or "SET ME NIGGA",
            callback = options.callback or function() end,
            visible = options.visible or true,
        }
        
        -- instances 
            local textbox_holder = library:create("TextLabel", {
                Parent = self.holder,
                Name = "",
                FontFace = library.font,
                TextColor3 = themes.preset.text,
                BorderColor3 = rgb(0, 0, 0),
                Text = "",
                ZIndex = 2,
                Size = dim2(1, -8, 0, 12),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                AutomaticSize = Enum.AutomaticSize.Y,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextSize = 12,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            library:create("UIPadding", {
                Parent = textbox_holder,
                Name = "",
                PaddingLeft = dim(0, 1)
            })
            
            library:create("UIStroke", {
                Parent = textbox_holder,
                Name = ""
            })
            
            local button = library:create("Frame", {
                Parent = textbox_holder,
                Name = "",
                Position = dim2(0, 0, 0, 2),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -27, 0, 18),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.outline
            })
            library:hoverify(textbox_holder, button)
            
            library:apply_theme(button, "outline", "BackgroundColor3") 
            
            local inline = library:create("Frame", {
                Parent = button,
                Name = "",
                Position = dim2(0, 1, 0, 1),
                ZIndex = 2;
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.inline
            })
            
            library:apply_theme(inline, "inline", "BackgroundColor3") 
            
            local background = library:create("Frame", {
                Parent = inline,
                Name = "",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                ZIndex = 2;
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.accent
            })
            
            library:apply_theme(background, "accent", "BackgroundColor3") 
            
            local TextBox = library:create("TextBox", {
                Parent = background,
                Name = "",
                CursorPosition = -1,
                FontFace = library.font,
                TextColor3 = themes.preset.text,
                BorderColor3 = rgb(0, 0, 0),
                Text = "", 
                Size = dim2(1, 0, 1, 0),
                BorderSizePixel = 0,
                TextWrapped = true,
                BackgroundTransparency = 1,
                TextTruncate = Enum.TextTruncate.SplitWord,
                PlaceholderText = "Type here...",
                ClearTextOnFocus = false,
                ZIndex = 3;
                TextSize = 12,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            library:create("UIStroke", {
                Parent = TextBox,
                Name = ""
            })
            
            local TextButton = library:create("TextButton", {
                Parent = background,
                Name = "",
                FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                TextColor3 = rgb(0, 0, 0),
                BorderColor3 = rgb(0, 0, 0),
                Text = "",
                AutoButtonColor = false,
                Size = dim2(1, 0, 1, 0),
                BorderSizePixel = 0,
                TextSize = 14,
                ZIndex = 2;
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            local UIGradient = library:create("UIGradient", {
                Parent = TextButton,
                Name = "",
                Rotation = 90,
                Color = rgbseq{
                    rgbkey(0, rgb(41, 41, 55)),
                    rgbkey(1, rgb(35, 35, 47))
                }
            })
            
            library:apply_theme(UIGradient, "contrast", "Color") 
            
            library:create("UIListLayout", {
                Parent = textbox_holder,
                Name = "",
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalFlex = Enum.UIFlexAlignment.Fill,
                Padding = dim(0, 4),
                SortOrder = Enum.SortOrder.LayoutOrder
            })
                
            TextBox:GetPropertyChangedSignal("Text"):Connect(function()
                flags[cfg.flag] = TextBox.text
                cfg.callback(TextBox.text)
            end)
        -- 

        function cfg.set_element_visible(bool)
            textbox_holder.Visible = bool 
        end

        function cfg.set(text) 
            flags[cfg.flag] = text
            TextBox.Text = text
            cfg.callback(text)
        end 

        if cfg.default then 
            cfg.set(cfg.default) 
        end 

        cfg.set_element_visible(cfg.visible)

        library.config_flags[cfg.flag] = cfg.set
        library.visible_flags[cfg.flag] = cfg.set_element_visible

        return setmetatable(cfg, library) 
    end 

    function library:button_holder(options) 
        local cfg = {
            flag = options.flag or "hi", 
            visible = options.visible or true,
        }

        local button_holder = library:create("TextLabel", {
            Parent = self.holder,
            Name = "",
            FontFace = library.font,
            TextColor3 = themes.preset.text,
            BorderColor3 = rgb(0, 0, 0),
            Text = "",
            ZIndex = 2,
            Size = dim2(1, -8, 0, 12),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            AutomaticSize = Enum.AutomaticSize.Y,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextSize = 12,
            BackgroundColor3 = rgb(255, 255, 255), 
        })

        self.current_holder = button_holder

        -- instances 
            library:create("UIStroke", {
                Parent = button_holder,
                Name = ""
            })
            
            library:create("UIListLayout", {
                Parent = button_holder,
                Name = "",
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalFlex = Enum.UIFlexAlignment.Fill,
                Padding = dim(0, 5),
                SortOrder = Enum.SortOrder.LayoutOrder
            })
        -- 
        
        function cfg.set_element_visible(bool)
            button_holder.Visible = bool 
        end

        cfg.set_element_visible(cfg.visible)

        library.visible_flags[cfg.flag] = cfg.set_element_visible

        return setmetatable(cfg, library)
    end 

    function library:button(options)
        local cfg = {
            callback = options.callback or function() end, 
            name = options.text or options.name or "Button",
        }   

        local button = library:create("TextButton", {
            Parent = self.current_holder,
            Name = "",
            Position = dim2(0, 0, 0, 2),
            BorderColor3 = rgb(0, 0, 0),
            Size = dim2(1, -27, 0, 18),
            BorderSizePixel = 0,
            BackgroundColor3 = themes.preset.outline,
            Text = ""
        })

        library:hoverify(button, button)
        
        library:apply_theme(button, "outline", "BackgroundColor3") 
        
        local inline = library:create("Frame", {
            Parent = button,
            Name = "",
            ZIndex = 2;
            Position = dim2(0, 1, 0, 1),
            BorderColor3 = rgb(0, 0, 0),
            Size = dim2(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = themes.preset.inline
        })
        
        library:apply_theme(inline, "inline", "BackgroundColor3") 
        
        local background = library:create("Frame", {
            Parent = inline,
            Name = "",
            ZIndex = 2;
            Position = dim2(0, 1, 0, 1),
            BorderColor3 = rgb(0, 0, 0),
            Size = dim2(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = themes.preset.accent
        })
        
        library:apply_theme(background, "accent", "BackgroundColor3") 
        
        local _UIGradient = library:create("UIGradient", {
            Parent = background,
            Name = "",
            Rotation = 90,
            Color = rgbseq{
                rgbkey(0, rgb(255, 255, 255)),
                rgbkey(1, rgb(167, 167, 167))
            }
        })
        
        library:apply_theme(_UIGradient, "contrast", "Color") 
        
        local contrast = library:create("Frame", {
            Parent = background,
            Name = "",
            ZIndex = 2;
            BorderColor3 = rgb(0, 0, 0),
            Size = dim2(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        })
        
        local UIGradient = library:create("UIGradient", {
            Parent = contrast,
            Name = "",
            Rotation = 90,
            Color = rgbseq{
                rgbkey(0, rgb(41, 41, 55)),
                rgbkey(1, rgb(35, 35, 47))
            }
        })
        
        library:apply_theme(UIGradient, "contrast", "Color") 
        
        local text = library:create("TextLabel", {
            Parent = contrast,
            Name = "",
            TextWrapped = true,
            ZIndex = 2;
            TextColor3 = themes.preset.text,
            BorderColor3 = rgb(0, 0, 0),
            Text = cfg.name,
            Size = dim2(1, -4, 1, 0),
            Position = dim2(0, 4, 0, -1),
            BackgroundTransparency = 1,
            TextTruncate = Enum.TextTruncate.AtEnd,
            BorderSizePixel = 0,
            FontFace = library.font,
            TextSize = 12,
            BackgroundColor3 = rgb(255, 255, 255)
        })
        
        local UIStroke = library:create("UIStroke", {
            Parent = text,
            Name = "",
            LineJoinMode = Enum.LineJoinMode.Miter
        })

        button.MouseButton1Click:Connect(function()
            cfg.callback() 
        end)

        return setmetatable(cfg, library)
    end 

    function library:label(options)
        local cfg = {name = options.text or options.name or "Label"}

        local dropdown = library:create("TextLabel", {
            Parent = self.holder,
            Name = "",
            FontFace = library.font,
            TextColor3 = themes.preset.text,
            BorderColor3 = rgb(0, 0, 0),
            Text = "",
            ZIndex = 2,
            Size = dim2(1, -8, 0, 12),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            AutomaticSize = Enum.AutomaticSize.Y,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextSize = 12,
            BackgroundColor3 = rgb(255, 255, 255)
        })
        
        local UIStroke = library:create("UIStroke", {
            Parent = dropdown,
            Name = ""
        })
        
        local left_components = library:create("Frame", {
            Parent = dropdown,
            Name = "",
            BackgroundTransparency = 1,
            Position = dim2(0, 2, 0, -1),
            BorderColor3 = rgb(0, 0, 0),
            Size = dim2(0, 0, 0, 14),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        })
        
        local TextLabel = library:create("TextLabel", {
            Parent = left_components,
            Name = "",
            FontFace = library.font,
            TextColor3 = themes.preset.text,
            BorderColor3 = rgb(0, 0, 0),
            Text = cfg.name,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            TextSize = 12,
            BackgroundColor3 = rgb(255, 255, 255)
        })

        local right_components = library:create("Frame", {
            Parent = dropdown,
            Name = "right_components",
            Position = dim2(1, -1, 0, 1),
            BorderColor3 = rgb(0, 0, 0),
            Size = dim2(0, 0, 0, 12),
            BorderSizePixel = 0,
            BackgroundColor3 = rgb(255, 255, 255)
        }) cfg.right_holder = right_components

        local list = library:create("UIListLayout", {
            Parent = right_components,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            Padding = dim(0, 4),
            Name = "list",
            SortOrder = Enum.SortOrder.LayoutOrder
        })
        
        local UIStroke = library:create("UIStroke", {
            Parent = TextLabel,
            Name = ""
        })

        function cfg.set(text) 
            TextLabel.Text = text 
        end 
                    
        return setmetatable(cfg, library)   
    end 

    function library:playerlist(options) 
        local cfg = {
            callback = options.callback or function() end, 

            labels = {
                name,
                display, 
                uid, 
            }
        }

        local selected_button; 

        local patterns = {
            ["Priority"] = rgb(255, 255, 0),
            ["Enemy"] = rgb(255, 0, 0),
            ["Neutral"] = themes.preset.text,
            ["Friendly"] = rgb(0, 255, 255)
        }

        -- elements 
            local playerlist_holder = library:create("TextLabel", {
                Parent = self.holder,
                Name = "",
                FontFace = library.font,
                TextColor3 = themes.preset.text,
                BorderColor3 = rgb(0, 0, 0),
                Text = "",
                ZIndex = 2,
                Size = dim2(1, -8, 0, 12),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                AutomaticSize = Enum.AutomaticSize.Y,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextSize = 12,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            local UIPadding = library:create("UIPadding", {
                Parent = playerlist_holder,
                Name = "",
                PaddingBottom = dim(0, -2),
                PaddingLeft = dim(0, 1)
            })
            
            local UIStroke = library:create("UIStroke", {
                Parent = playerlist_holder,
                Name = ""
            })
            
            local bottom_components = library:create("Frame", {
                Parent = playerlist_holder,
                Name = "",
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, 26, 0, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            library:create("UIListLayout", {
                Parent = bottom_components,
                Name = "",
                Padding = dim(0, 10),
                SortOrder = Enum.SortOrder.LayoutOrder
            })
            
            local list = library:create("Frame", {
                Parent = bottom_components,
                Name = "",
                Position = dim2(0, 0, 0, 2),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -27, 1, 232),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.outline
            }) library:apply_theme(list, "outline", "BackgroundColor3") 
            
            local inline = library:create("Frame", {
                Parent = list,
                Name = "",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.inline
            }) library:apply_theme(inline, "inline", "BackgroundColor3") 
            
            local background = library:create("Frame", {
                Parent = inline,
                Name = "",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.accent
            })
            
            local UIGradient = library:create("UIGradient", {
                Parent = background,
                Name = "",
                Rotation = 90,
                Color = rgbseq{
                    rgbkey(0, rgb(255, 255, 255)),
                    rgbkey(1, rgb(167, 167, 167))
                }
            }); library:apply_theme(UIGradient, "contrast", "Color") 
            
            local contrast = library:create("Frame", {
                Parent = background,
                Name = "",
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, 0, 1, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(255, 255, 255)
            })
            
            local UIGradient = library:create("UIGradient", {
                Parent = contrast,
                Name = "",
                Rotation = 90,
                Color = rgbseq{
                rgbkey(0, rgb(41, 41, 55)),
                rgbkey(1, rgb(35, 35, 47))
            }
            }); library:apply_theme(UIGradient, "contrast", "Color") 
            
            local ScrollingFrame = library:create("ScrollingFrame", {
                Parent = contrast,
                Name = "",
                ScrollBarImageColor3 = themes.preset.accent,
                Active = true,
                MidImage = "rbxassetid://103468666327206",
                TopImage = "rbxassetid://103468666327206",
                BottomImage = "rbxassetid://103468666327206",
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ScrollBarThickness = 2,
                BackgroundTransparency = 1,
                Size = dim2(1, 0, 1, 0),
                BackgroundColor3 = rgb(255, 255, 255),
                BorderColor3 = rgb(0, 0, 0),
                BorderSizePixel = 0,
                CanvasSize = dim2(0, 0, 0, 0)
            }) library:apply_theme(ScrollingFrame, "accent", "ScrollBarImageColor3") 
            
            local UIPadding = library:create("UIPadding", {
                Parent = ScrollingFrame,
                Name = "",
                PaddingTop = dim(0, 4),
                PaddingBottom = dim(0, 4),
                PaddingRight = dim(0, 4),
                PaddingLeft = dim(0, 4)
            })
            
            local UIListLayout = library:create("UIListLayout", {
                Parent = ScrollingFrame,
                Name = "",
                Padding = dim(0, 4),
                SortOrder = Enum.SortOrder.LayoutOrder
            })
        -- 

        function cfg.create_player(player) 
            library.playerlist_data[tostring(player)] = {}
            local path = library.playerlist_data[tostring(player)]
            
            local TextButton = library:create("TextButton", {
                Parent = ScrollingFrame,
                Name = "",
                FontFace = library.font,
                TextColor3 = themes.preset.text,
                BorderColor3 = rgb(0, 0, 0),
                Text = "",
                BackgroundTransparency = 1,
                Size = dim2(1, 0, 0, 0),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y,
                TextSize = 12,
                BackgroundColor3 = rgb(255, 255, 255)
            })

            local player_name = library:create("TextLabel", {
                Parent = TextButton,
                FontFace = library.font,
                TextColor3 = themes.preset.text,
                BorderColor3 = rgb(0, 0, 0),
                Text = tostring(player),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                AutomaticSize = Enum.AutomaticSize.Y,
                TextSize = 12,
                LayoutOrder = -100, 
                BackgroundColor3 = rgb(255, 255, 255)
            })
            library:apply_theme(player_name, "text", "TextColor3") 
            library:apply_theme(player_name, "accent", "TextColor3") 
                            
            -- local TextLabel = library:create("TextLabel", {
            --     Parent = TextButton,
            --     Name = "",
            --     FontFace = library.font,
            --     TextColor3 = themes.preset.text,
            --     BorderColor3 = rgb(0, 0, 0),
            --     Text = "None",
            --     BackgroundTransparency = 1,
            --     TextXAlignment = Enum.TextXAlignment.Left,
            --     BorderSizePixel = 0,
            --     AutomaticSize = Enum.AutomaticSize.Y,
            --     TextSize = 12,
            --     BackgroundColor3 = rgb(255, 255, 255)
            -- })
                            
            -- local Frame = library:create("Frame", {
            --     Parent = TextLabel,
            --     Name = "",
            --     Position = dim2(0, -10, 0, 0),
            --     BorderColor3 = rgb(0, 0, 0),
            --     Size = dim2(0, 1, 0, 12),
            --     BorderSizePixel = 0,
            --     BackgroundColor3 = themes.preset.outline
            -- }) library:apply_theme(main_holder, "outline", "BackgroundColor3") 
            
            local priority_text = library:create("TextLabel", {
                Parent = TextButton,
                Name = "",
                FontFace = library.font,
                TextColor3 = themes.preset.text,
                BorderColor3 = rgb(0, 0, 0),
                Text = "Neutral",
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y,
                TextSize = 12,
                BackgroundColor3 = rgb(255, 255, 255)
            })

            local Frame = library:create("Frame", {
                Parent = priority_text,
                Name = "",
                Position = dim2(0, -10, 0, 0),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(0, 1, 0, 12),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.outline
            }) library:apply_theme(main_holder, "outline", "BackgroundColor3") 
            
            local UIListLayout = library:create("UIListLayout", {
                Parent = TextButton,
                Name = "",
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalFlex = Enum.UIFlexAlignment.Fill,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalFlex = Enum.UIFlexAlignment.Fill
            })
            
            local UIPadding = library:create("UIPadding", {
                Parent = TextButton,
                Name = "",
                PaddingRight = dim(0, 2),
                PaddingLeft = dim(0, 2)
            })

            local line = library:create("Frame", {
                Parent = ScrollingFrame,
                Name = "",
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, 0, 0, 1),
                BorderSizePixel = 0,
                BackgroundColor3 = themes.preset.outline
            }) library:apply_theme(main_holder, "outline", "BackgroundColor3") 

            path.instance = TextButton 
            path.line = line 
            path.priority = "Neutral"
            path.priority_text = priority_text
            -- library.selected_player = players[tostring(player)]
                        
            TextButton.MouseButton1Click:Connect(function()
                if selected_button then 
                    selected_button.TextColor3 = themes.preset.text 
                    selected_button = nil 
                end     

                selected_button = player_name 
                player_name.TextColor3 = themes.preset.accent 

                library.selected_player = player_name.Text
                library.config_flags["PLAYERLIST_DROPDOWN"](path.priority_text.Text)

                if cfg.labels.name then 
                    cfg.labels.name.set("User: " .. player_name.Text)
                    cfg.labels.display.set("DisplayName: " .. players[player_name.Text].DisplayName)
                    cfg.labels.uid.set("User Id: " .. players[player_name.Text].UserId)
                end
            end)

            return path 
        end 

        function cfg.search(text)
            for _, player in next, players:GetPlayers() do 
                local name = tostring(player)
                local path = library.playerlist_data[name]

                if path then 
                    local sanity = string.lower(name):match(string.lower(text)) and true or false
                    path.instance.Visible = sanity
                    path.line.Visible = sanity
                end 
            end 
        end 

        function cfg.remove_player(player) 
            local path = library.playerlist_data[tostring(player)]
            path.instance:Destroy() 
            path.line:Destroy() 
            path = nil 
        end 

        function library.prioritize(text) 
            if not library.selected_player then 
                return 
            end 

            local path = library.playerlist_data[library.selected_player]
            path.priority_text.Text = text
            path.priority_text.TextColor3 = patterns[text]
            path.priority = text
        end 

        function library.get_priority(player) 
            local path = library.playerlist_data[tostring(player)]

            if path then 
                return path.priority
            end 
        end 

        players.PlayerAdded:Connect(cfg.create_player)
        players.PlayerRemoving:Connect(cfg.remove_player)
        
        for _, player in players:GetPlayers() do 
            if player ~= local_entity then
                local player_object = cfg.create_player(player.Name)
                insert(library.playerlist_data, player_object)
            end
        end 

        self:textbox({name = "Search", callback = function(txt)
            cfg.search(txt)
        end})
        cfg.labels.name = self:label({name = "Name: ??"})
        cfg.labels.display = self:label({name = "Display Name: ??"})
        cfg.labels.uid = self:label({name = "User Id: ??"})

        return setmetatable(cfg, library)
    end 
-- 
-- 
funcs.apply_esp_style = function(gui)
    if not gui or type(gui) ~= "table" then return end
    
    local selected_font = (flags["esp_font"] == "ProggyClean") and library.font or Fonts[flags["esp_font"]]
    local text_elements = {"DisplayName", "Studs", "Tool", "State", "Team"}
    
    for _, name in ipairs(text_elements) do
        local label = gui[name]
        
        if label and typeof(label) == "Instance" then
            label.FontFace = selected_font
            label.TextSize = font_size
        end
    end
end

local window = library:window({name = os.date('Aether |  - %b %d %Y'), size = dim2(0, 750, 0, 782)})

local Aiming = window:tab({name = "Combat"})
local Visuals = window:tab({name = "Visuals"})
local Character = window:tab({name = "Character"})
local Misc = window:tab({name = "Misc"})

-- Aiming
    local column =  Aiming:column() 
        local aimassist, silentaim  = column:multi_section({names = {"Aim Assist", "Silent Aim"}})
            aimassist:toggle({name = "Enabled", flag = "aimassist_enabled", callback = function(a) getgenv().aether.aim_assist.enabled = a end})
            :keybind({
                name = "Aim Assist",
                flag = "aimassist_bind",
                mode = "hold",
                callback = function(a)
                    if not getgenv().aether.aim_assist.enabled then
                        cache.aimassist_targetting = false
                        return
                    end

                    cache.aimassist_targetting = a

                    if a then
                        cache.closest_entity_aimassist = funcs.find_nearest_entity(getgenv().aether.field_of_view.aim_assist.radius)

                        if getgenv().aether.aim_assist.notify_on_target then
                            local tag = string.format('<font color="%s">[Aether]</font>', accent_color)

                            library:notification({
                                text = tag .. " Targetting: " .. cache.closest_entity_aimassist.DisplayName,
                                time = flags["notification_duration"]
                            })
                        end
                    end
                end
            })
            aimassist:dropdown({name = "Method", flag = "aimassist_method", items = {"Camera", "Mouse"}, default = "Camera", callback = function(a) getgenv().aether.aim_assist.method = a end})
            aimassist:toggle({name = "Notify on Target", flag = "aimassist_notification", callback = function(a) getgenv().aether.aim_assist.notify_on_target = a end})
            aimassist:dropdown({name = "Hit Point", flag = "aimassist_hitbox", items = hitpoints, default = "Head", callback = function(a) getgenv().aether.aim_assist.part.value = a end})
            aimassist:toggle({name = "Closest Part", flag = "aimassist_nearestpart", callback = function(a)
                if flags["aimassist_nearestpoint"] then
                    getgenv().aether.aim_assist.part.type = "Closest Point"
                elseif flags["aimassist_nearestpart"] then
                    getgenv().aether.aim_assist.part.type = "Closest Part"
                else
                    getgenv().aether.aim_assist.part.type = "Custom"
                end
            end})
            aimassist:toggle({name = "Closest Point", flag = "aimassist_nearestpoint", callback = function(a)
                if flags["aimassist_nearestpoint"] then
                    getgenv().aether.aim_assist.part.type = "Closest Point"
                elseif flags["aimassist_nearestpart"] then
                    getgenv().aether.aim_assist.part.type = "Closest Part"
                else
                    getgenv().aether.aim_assist.part.type = "Custom"
                end
            end})

            aimassist:toggle({name = "Prediction", flag = "aimassist_prediction", callback = function(a) getgenv().aether.aim_assist.prediction.enabled = a end})
            aimassist:toggle({name = "Smoothness", flag = "aimassist_smoothness", callback = function(a) getgenv().aether.aim_assist.smoothness.enabled = a end})
            aimassist:slider({name = "Prediction X", min = 0.1, max = 0.2, default = 0.125, interval = 0.0001, flag = "aimassist_prediction_x", callback = function(a) getgenv().aether.aim_assist.prediction.x = a end})
            aimassist:slider({name = "Prediction Y", min = 0.1, max = 0.2, default = 0.11, interval = 0.0001, flag = "aimassist_prediction_y", callback = function(a) getgenv().aether.aim_assist.prediction.y = a end})
            aimassist:slider({name = "Smoothness X", min = 0.0001, max = 1, default = 0.125, interval = 0.001, flag = "smoothness_x", callback = function(a) getgenv().aether.aim_assist.smoothness.x = a end})
            aimassist:slider({name = "Smoothness Y", min = 0.0001, max = 1, default = 0.11, interval = 0.001, flag = "smoothness_y", callback = function(a) getgenv().aether.aim_assist.smoothness.y = a end})
            aimassist:dropdown({name = "Easing Style", flag = "easing_style", items = {"Linear", "Sine", "Quad","Cubic","Quart","Quint","Exponential","Circular","Back","Bounce","Elastic"}, default = "Linear", callback = function(a) getgenv().aether.aim_assist.smoothness.easing_style = a end})
            aimassist:dropdown({name = "Easing Direction", flag = "easing_direction", items = {"In", "Out", "InOut"}, default = "In", callback = function(a) getgenv().aether.aim_assist.smoothness.easing_direction = a end})
            aimassist:toggle({name = "Shake", flag = "shake", callback = function(a) getgenv().aether.aim_assist.shake.enabled = a end})
            aimassist:slider({name = "Shake X", min = 1, max = 50, default = 5, interval = 1, flag = "shakey", callback = function(a) getgenv().aether.aim_assist.shake.x = a end})
            aimassist:slider({name = "Shake Y", min = 1, max = 50, default = 5, interval = 1, flag = "shakex", callback = function(a) getgenv().aether.aim_assist.shake.y = a end})
            aimassist:slider({name = "Shake Z", min = 1, max = 50, default = 5, interval = 1, flag = "shakez", callback = function(a) getgenv().aether.aim_assist.shake.z = a end})

            -- // silent aim
            silentaim:toggle({name = "Enabled", flag = "silentaim_enabled", callback = function(a) getgenv().aether.silent_aim.enabled = a end})
            :keybind({
                name = "Silent Aim",
                flag = "silentaim_bind",
                callback = function(a)
                    if not getgenv().aether.silent_aim.enabled or getgenv().aether.silent_aim.auto_select then
                        cache.silentaim_targetting = false
                        return
                    end

                    cache.silentaim_targetting = a

                    if a then
                        if flags["use_fov"] then
                            cache.closest_entity = funcs.find_nearest_entity(getgenv().aether.field_of_view.silent_aim.radius)
                        else
                            cache.closest_entity = funcs.find_nearest_entity(math.huge)
                        end

                        if getgenv().aether.silent_aim.notify_on_target then
                            local tag = string.format('<font color="%s">[Aether]</font>', accent_color)

                            library:notification({
                                text = tag .. " Targetting: " .. cache.closest_entity.DisplayName,
                                time = flags["notification_duration"]
                            })
                        end
                    end
                end
            })
            silentaim:toggle({name = "Notify on Target", flag = "silentaim_notificiation", callback = function(a) getgenv().aether.silent_aim.notify_on_target = a end})
            silentaim:toggle({name = "Auto Select", flag = "silentaim_autotarget", tooltip = "Selects targets for you. (Edit the delay slider if you want more fps.)", callback = function(a) getgenv().aether.silent_aim.auto_select = a end})
            silentaim:slider({name = "Delay", min = 0, max = 1000, default = 1, interval = 1, suffix = "ms", flag = "target_selector_refresh_time"})
            silentaim:dropdown({name = "Hit Point", flag = "silentaim_hitbox", items = hitpoints, default = "Head", callback = function(a) getgenv().aether.silent_aim.part.value = a end})
            silentaim:toggle({name = "Closest Part", flag = "silentaim_nearestpart", callback = function(a)
                if flags["silentaim_nearestpoint"] then
                    getgenv().aether.silent_aim.part.type = "Closest Point"
                elseif flags["silentaim_nearestpart"] then
                    getgenv().aether.silent_aim.part.type = "Closest Part"
                else
                    getgenv().aether.silent_aim.part.type = "Custom"
                end
            end})
            silentaim:toggle({name = "Closest Point", flag = "silentaim_nearestpoint", callback = function(a)
                if flags["silentaim_nearestpoint"] then
                    getgenv().aether.silent_aim.part.type = "Closest Point"
                elseif flags["silentaim_nearestpart"] then
                    getgenv().aether.silent_aim.part.type = "Closest Part"
                else
                    getgenv().aether.silent_aim.part.type = "Custom"
                end
            end})
            silentaim:toggle({name = "Prediction", flag = "silentaim_prediction", callback = function(a) getgenv().aether.silent_aim.prediction.enabled = a end})
            silentaim:slider({name = "Prediction X", min = 0.1, max = 0.2, default = 0.125, interval = 0.0001, flag = "silentaim_prediction_x", callback = function(a) getgenv().aether.silent_aim.prediction.x = a end})
            silentaim:slider({name = "Prediction Y", min = 0.1, max = 0.2, default = 0.11, interval = 0.0001, flag = "silentaim_prediction_y", callback = function(a) getgenv().aether.silent_aim.prediction.y = a end})
            silentaim:separator({height = 4.5})
            silentaim:toggle({name = "Manipulation", flag = "silentaim_manipulation", unsafe = true, callback = function(a) getgenv().aether.silent_aim.manipulation = a end})
            silentaim:toggle({name = "Remove Fire Rate", flag = "remove_firerate"})
            silentaim:toggle({name = "Auto Shoot", flag = "silentaim_autoshoot", callback = function(a) getgenv().aether.silent_aim.auto_shoot = a end})
            silentaim:separator({height = 4.5})
            silentaim:toggle({name = "Use FOV", flag = "use_fov"})
            silentaim:toggle({name = "Field of View", flag = "silentaim_fov", callback = function(a) getgenv().aether.field_of_view.silent_aim.visible = a end}):colorpicker({name = "Field of View Color", flag = "fovcolor", callback = function(a) getgenv().aether.field_of_view.silent_aim.color = a end})
            silentaim:toggle({name = "Outline", flag = "silentaim_fovoutline", callback = function(a) getgenv().aether.field_of_view.silent_aim.outline = a end})
            local fov_toggle_filled = silentaim:toggle({name = "Fill", flag = "silentaim_fov_gradient"})
            :colorpicker({name = "Field of View Gradient Color", color =  Color3.fromRGB(96, 120, 190), flag = "silentaim_fov_gradient_color1"})
            :colorpicker({name = "Field of View Gradient Color 2", color = Color3.fromRGB(112, 138, 219),  flag = "silentaim_fov_gradient_color2"})
            :colorpicker({name = "Field of View Gradient Color 3", color = Color3.fromRGB(54, 94, 217), flag = "silentaim_fov_gradient_color3"})
            silentaim:slider({name = "Radius", min = 1, max = 800, default = getgenv().aether.field_of_view.silent_aim.radius, interval = 1, flag = "silentaimfovradius", callback = function(a) getgenv().aether.field_of_view.silent_aim.radius = a end})
            silentaim:slider({name = "Thickness", min = 1, max = 5, default = getgenv().aether.field_of_view.silent_aim.thickness, interval = 0.1, flag = "silentaimfovthickness", callback = function(a) getgenv().aether.field_of_view.silent_aim.thickness = a end})
            silentaim:slider({name = "Fill Transparency", min = 0, max = 1, default = 0.2, interval = 0.1, flag = "silentaim_fov_fill_transparency"})
            silentaim:slider({name = "Sides", min = 1, max = 100, default = getgenv().aether.field_of_view.silent_aim.sides, interval = 1, suffix = "%", flag = "silentaimfovsides", callback = function(a) getgenv().aether.field_of_view.silent_aim.sides = a end})
            silentaim:toggle({name = "Stick To Barrel", flag = "fovsticktobarrel"})
            silentaim:slider({name = "Lerp Value", min = 0.01, max = 1, default = 0.05, interval = 0.01, flag = "fovsticktobarrel_lerp"})

    local column =  Aiming:column() 
        local triggerbot = column:section({name = "Trigger Bot", toggle = false})
            triggerbot:toggle({name = "Enabled", flag = "triggerbot", callback = function(a) getgenv().aether.trigger_bot.enabled = a end})
            :keybind({
                name = "Trigger Bot",
                flag = "triggerbot_bind",
                mode = "hold",
                callback = function(a)
                    if not getgenv().aether.trigger_bot.enabled then
                        cache.triggerbot_active = false
                        return
                    end

                    cache.triggerbot_active = a
                end
            })
            triggerbot:slider({name = "Delay", min = 0, max = 1, default = 0.01, interval = 0.01, suffix = "ms", flag = "triggerbot_delay", callback = function(a) getgenv().aether.trigger_bot.delay = a end})
            triggerbot:dropdown({name = "Method", flag = "triggerbot_method", items = {"Tool Activation", "Mouse Click"}, default = "Tool Activation", callback = function(a) getgenv().aether.trigger_bot.method = a end})
            local visualise_hitbox_toggle = triggerbot:toggle({name = "Visualise Hitbox", flag = "visualise_hitbox", callback = function(a) getgenv().aether.trigger_bot.hitbox.visualise.enabled = a end})
            visualise_hitbox_toggle:colorpicker({name = "Locked on Color", flag = "lockedoncolor", callback = function(a) getgenv().aether.trigger_bot.hitbox.visualise.locked_on_color = a end})
            visualise_hitbox_toggle:colorpicker({name = "Not Locked on Color", flag = "notlockedoncolor", color = getgenv().aether.trigger_bot.hitbox.visualise.not_locked_on_color, callback = function(a) getgenv().aether.trigger_bot.hitbox.visualise.not_locked_on_color = a end})
            triggerbot:slider({name = "Size X", min = 0.1, max = 2, default = getgenv().aether.trigger_bot.hitbox.size_x, interval = 0.01, flag = "triggerbotsizex", callback = function(a) getgenv().aether.trigger_bot.hitbox.size_x = a end})
            triggerbot:slider({name = "Size Y", min = 0.1, max = 2, default = getgenv().aether.trigger_bot.hitbox.size_y, interval = 0.01, flag = "triggerbotsizey", callback = function(a) getgenv().aether.trigger_bot.hitbox.size_y = a end})

        local checks, visualisation  = column:multi_section({names = {"Conditions", "Visualization"}})
        checks:toggle({name = "Team Check", flag = "teamcheck", callback = function(a) getgenv().aether.checks.team_check = a end})
        checks:toggle({name = "Health Check", flag = "healthcheck", callback = function(a) getgenv().aether.checks.health_check = a end})
        checks:toggle({name = "Visible Check", flag = "visiblecheck", callback = function(a) getgenv().aether.checks.visible_check = a end})
        checks:toggle({name = "Knocked Check", flag = "knockedcheck", callback = function(a) getgenv().aether.checks.knocked_check = a end})
        checks:toggle({name = "Grabbed Check", flag = "grabbedcheck", callback = function(a) getgenv().aether.checks.grabbed_check = a end})
        checks:toggle({name = "Crew Check", flag = "crewcheck", callback = function(a) getgenv().aether.checks.crew_check = a end})
        checks:toggle({name = "Forcefield Check", flag = "forcefieldcheck", callback = function(a) getgenv().aether.checks.forcefield_check = a end})
        checks:toggle({name = "Range Check", flag = "rangecheck", callback = function(a) getgenv().aether.checks.range_check = a end})
        checks:slider({name = "Range", min = 50, max = 999, default = getgenv().aether.checks.range, interval = 1, flag = "rangevalue", suffix = "m", callback = function(a) getgenv().aether.checks.range = a end})

        visualisation:toggle({name = "Tracer", flag = "tracer", callback = function(a) getgenv().aether.silent_aim.visualisation.tracer.visible = a end})
        :colorpicker({name = "Tracer Color", flag = "tracer_color", callback = function(a) getgenv().aether.silent_aim.visualisation.tracer.color = a end})
        visualisation:toggle({name = "Outline", flag = "tracer_outline", callback = function(a) getgenv().aether.silent_aim.visualisation.tracer.outline = a end})
        visualisation:slider({name = "Thickness", min = 1, max = 5, default = getgenv().aether.silent_aim.visualisation.tracer.thickness, interval = 0.1, flag = "tracerthickness", callback = function(a) getgenv().aether.silent_aim.visualisation.tracer.thickness = a end})
        visualisation:dropdown({name = "Position", flag = "tracer_position", items = {"Mouse", "Barrel"}, default = "Mouse"})
        visualisation:toggle({name = "3D Circle", flag = "circle", callback = function(a) getgenv().aether.silent_aim.visualisation.circle.visible = a end})
        :colorpicker({name = "3D Circle Color", flag = "circle_color", callback = function(a) getgenv().aether.silent_aim.visualisation.circle.color = a end})
        visualisation:toggle({name = "Target HUD", flag = "targethud", callback = function(a) getgenv().aether.silent_aim.target_hud = a end})
        visualisation:toggle({name = "Follow Target", flag = "targethud_followtarget", callback = function() cache.indicator_reset = false end})

-- Visuals
    local esp;
    local function update_elements() if esp and esp.refresh_elements then esp.refresh_elements() end end 
    local column = Visuals:column()
    local section, world  = column:multi_section({names = {"ESP", "World"}})
    section:toggle({name = "Enabled", flag = "esp_enabled", callback = function(b)        
        update_elements()
        
        if b == false then
            for i, player in ipairs(entities:GetChildren()) do
                if esp_cache[player.UserId] then
                    for _, element in pairs(esp_cache[player.UserId]) do
                        if element and element.Destroy then
                            element:Destroy()
                        end
                    end
                    esp_cache[player.UserId] = nil
                end
            end
        else
            for _, player in ipairs(entities:GetPlayers()) do
                if player ~= local_entity then
                    esp_cache[player.UserId] = create_esp()
                    funcs.apply_esp_style(esp_cache[player.UserId])
                end
            end
        end
    end})
    section:toggle({name = "Names", flag = "name_enabled", callback = update_elements()}):colorpicker({flag = "name_color", callback = update_elements})
    section:dropdown({name = "Name Type", flag = "name_type", items = {"DisplayName", "Name", "Name (DisplayName)", "DisplayName (Name)"}, default = "DisplayName"})
    local chams = section:toggle({name = "Chams", flag = "chams_enabled"})
    chams:colorpicker({name = "Fill Color", flag = "fill_color", color =  Color3.fromRGB(96, 120, 190)})
    chams:colorpicker({name = "Outline Color", flag = "outline_color", color = Color3.fromRGB(112, 138, 219)})
    section:slider({name = "Fill Transparency", min = 0, max = 1, default = 0.5, interval = 0.1, flag = "chams_fill_transparency"})
    section:slider({name = "Outline Transparency", min = 0, max = 1, default = 0, interval = 0.1, flag = "chams_outline_transparency"})
    section:toggle({name = "Visible Check", flag = "chams_visiblecheck"})
    local settings = section:toggle({name = "Boxes", flag = "box_enabled", callback = update_elements})
    local box_fill = section:toggle({name = "Box Fill", flag = "boxfill_enabled", callback = update_elements})
    box_fill:colorpicker({name = "Color 1 ", flag = "boxfill_color1", color =  Color3.fromRGB(96, 120, 190), callback = update_elements})
    box_fill:colorpicker({name = "Color 2 ", flag = "boxfill_color2", color = Color3.fromRGB(112, 138, 219), callback = update_elements})
    box_fill:colorpicker({name = "Color 3 ", flag = "boxfill_color3", color = Color3.fromRGB(54, 94, 217), callback = update_elements})
    local box_glow = section:toggle({name = "Box Glow", flag = "boxglow_enabled", callback = update_elements()})
    box_glow:colorpicker({name = "Box Glow Color 1", flag = "boxglow_color1", color =  Color3.fromRGB(96, 120, 190), callback = update_elements})
    box_glow:colorpicker({name = "Box Glow Color 2", flag = "boxglow_color2", color =  Color3.fromRGB(112, 138, 219), callback = update_elements})
    box_glow:colorpicker({name = "Box Glow Color 3", flag = "boxglow_color3", color =  Color3.fromRGB(54, 94, 217), callback = update_elements})
    section:toggle({name = "Rotate Glow", flag = "boxglow_rotate", callback = update_elements()})
    section:slider({name = "Glow Opacity", min = 0.4, max = 1, default = 0.8, interval = 0.1, flag = "boxglow_opacity"})
    section:toggle({name = "Rotate Fill", flag = "boxfill_animate", callback = update_elements()})
    section:dropdown({name = "Box Type", flag = "box_type", items = {"Corner", "Full"}, default = "Full", callback = update_elements})
    settings:colorpicker({name = "Box Color", flag = "box_color", color = themes.preset.accent, callback = update_elements})
    local toggle = section:toggle({name = "Healthbar", flag = "healthbar_enabled", callback = update_elements})
    toggle:colorpicker({name = "Healthbar Color1", flag = "healthbar_color1", color = Color3.fromRGB(0, 255, 0), callback = update_elements})
    toggle:colorpicker({name = "Healthbar Color2", flag = "healthbar_color2", color = Color3.fromRGB(255, 184, 0), callback = update_elements})
    toggle:colorpicker({name = "Healthbar Color3", flag = "healthbar_color3", color = Color3.fromRGB(255, 0, 0), callback = update_elements})
    local togglearmor = section:toggle({name = "Armorbar", flag = "armorbar_enabled", callback = update_elements})
    togglearmor:colorpicker({name = "Color 1", flag = "armorbar_color1", color = Color3.fromRGB(0, 123, 255), callback = update_elements})
    togglearmor:colorpicker({name = "Color 2", flag = "armorbar_color2", color = Color3.fromRGB(0, 207, 255), callback = update_elements})
    togglearmor:colorpicker({name = "Color 3", flag = "armorbar_color3", color = Color3.fromRGB(160, 239, 255), callback = update_elements})
    section:toggle({name = "Distance", flag = "distance_enabled", callback = update_elements})
    :colorpicker({name = "Distance Color", flag = "distance_color", callback = update_elements})
    section:toggle({name = "Weapon", flag = "tool_enabled", callback = update_elements})
    :colorpicker({name = "Weapon Color", flag = "tool_color", callback = update_elements})
    section:toggle({name = "State", flag = "state_enabled", callback = update_elements})
    :colorpicker({name = "State Color", flag = "state_color", callback = update_elements})
    section:toggle({name = "Team", flag = "team_enabled", callback = update_elements})
    :colorpicker({name = "Team Color", flag = "team_color", callback = update_elements})
    section:toggle({name = "Use Team Color", flag = "useteamcolor_enabled", callback = update_elements})
    section:dropdown({
        name = "Font", 
        flag = "esp_font", 
        items = {"ProggyClean", "SmallestPixel", "TahomaBold"}, 
        callback = function(val)
            if val == "SmallestPixel" then font_size = 9 offset = 3
            elseif val == "ProggyClean" then font_size = 12 offset = 2
            else font_size = 10 offset = 2 end

            for user_id, gui in pairs(esp_cache) do
                funcs.apply_esp_style(gui)
            end
        end
    })
    section:slider({name = "FPS", min = 30, max = 240, default = 240, interval = 1, flag = "esp_fps"})
    esp = window.esp_section:esp_preview({})
    world:toggle({name = "Ambient", flag = "ambient", callback = function(v)
        if not v then
            lighting.Ambient = lighting_backup.Ambient
        else
            lighting.Ambient = flags["ambient_color"].Color
        end
    end})
    :colorpicker({name = "Ambient", flag = "ambient_color", color = lighting_backup.Ambient, callback = function(color)
        if flags["ambient"] then
            lighting.Ambient = color
        end
    end})
    world:toggle({name = "Outdoor Ambient", flag = "outdoorambient", callback = function(v)
        if not v then
            lighting.OutdoorAmbient = lighting_backup.OutdoorAmbient
        else
            lighting.OutdoorAmbient = flags["outdoorambientcolor"].Color
        end
    end})
    :colorpicker({name = "Outdoor Ambient", flag = "outdoorambientcolor", color = lighting_backup.OutdoorAmbient, callback = function(color)
        if flags["outdoorambient"] then
            lighting.OutdoorAmbient = color
        end
    end})
    world:toggle({name = "ColorShift_Bottom", flag = "colorshiftbottom", callback = function(v)
        if not v then
            lighting.ColorShift_Bottom = lighting_backup.ColorShift_Bottom
        else
            lighting.ColorShift_Bottom = flags["ColorShit_Bottomcolor"].Color
        end
    end})
    :colorpicker({name = "ColorShift_Bottom", flag = "ColorShit_Bottomcolor", color = lighting_backup.ColorShift_Bottom, callback = function(color)
        if flags["colorshiftbottom"] then
            lighting.ColorShift_Bottom = color
        end
    end})
    world:toggle({name = "ColorShift_Top", flag = "colorshifttop", callback = function(v)
        if not v then
            lighting.ColorShift_Top = lighting_backup.ColorShift_Top
        else
            lighting.ColorShift_Top = flags["ColorShift_TopColor"].Color
        end
    end})
    :colorpicker({name = "ColorShift_Top", flag = "ColorShift_TopColor", color = lighting_backup.ColorShift_Top, callback = function(color)
        if flags["colorshifttop"] then
            lighting.ColorShift_Top = color
        end
    end})
    world:toggle({name = "Fog Color", flag = "fogcolorenabled", callback = function(v)
        if not v then
            lighting.FogColor = lighting_backup.FogColor
        else
            lighting.FogColor = flags["fogcolor"].Color
        end
    end})
    :colorpicker({name = "Fog Color", flag = "fogcolor", color = lighting_backup.FogColor, callback = function(color)
        if flags["fogcolorenabled"] then
            lighting.FogColor = color
        end
    end})
    world:toggle({name = "Fog Start", flag = "fogstart", callback = function(v)
        if not v then
            lighting.FogStart = lighting_backup.FogStart
        end
    end})
    world:slider({name = "Fog Start", min = 1, max = 1000, default = lighting_backup.FogStart, interval = 1, suffix = "m", flag = "fogstartvalue", callback = function(Value)
        lighting.FogStart = Value
    end})
    world:toggle({name = "Fog End", flag = "fogend", callback = function(v)
        if not v then
            lighting.FogEnd = lighting_backup.FogEnd
        end
    end})
    world:slider({name = "Fog End", min = 1, max = 1000, default = lighting_backup.FogEnd, interval = 1, suffix = "m", flag = "fogendvalue", callback = function(Value)
        lighting.FogEnd = Value
    end})
    world:toggle({
        name = "Atmosphere",
        flag = "atmosphere_enabled",
        callback = function(v)
            if v then
                if not cache.atmosphere then
                    cache.atmosphere = lighting:FindFirstChildOfClass("Atmosphere")

                    if not cache.atmosphere then
                        cache.atmosphere = Instance.new("Atmosphere")
                        cache.atmosphere.Parent = lighting
                    end
                end
            else
                if cache.atmosphere then
                    cache.atmosphere:Destroy()
                    cache.atmosphere = nil
                end
            end
        end
    })
    :colorpicker({name = "Atmosphere Color", flag = "atmosphere_color", color = Color3.fromRGB(255,255,255), callback = function(color)
        if flags["atmosphere_enabled"] and cache.atmosphere then
            cache.atmosphere.Color = color
        end
    end})
    :colorpicker({name = "Atmosphere Decay Color", flag = "atmosphere_decaycolor", color = Color3.fromRGB(255,255,255), callback = function(color)
        if flags["atmosphere_enabled"] and cache.atmosphere then
            cache.atmosphere.Decay = color
        end
    end})
    world:slider({name = "Glare", min = 0, max = 10, default = 1.5, interval = 0.1, flag = "atmosphere_glare", callback = function(Value)
        if flags["atmosphere_enabled"] and cache.atmosphere then
            cache.atmosphere.Glare = Value
        end
    end})
    world:slider({name = "Haze", min = 0, max = 10, default = 1.4, interval = 0.1, flag = "atmosphere_haze", callback = function(Value)
        if flags["atmosphere_enabled"] and cache.atmosphere then
            cache.atmosphere.Haze = Value
        end
    end})
    world:toggle({name = "Exposure Compensation", flag = "ExposureCompensation", callback = function(v)
        if not v then
            lighting.ExposureCompensation = lighting_backup.ExposureCompensation
        end
    end})
    world:slider({name = "Exposure Compensation", min = -5, max = 5, default = lighting_backup.ExposureCompensation, interval = 0.1, flag = "ExposureCompensationvalue", callback = function(Value)
        if flags["ExposureCompensation"] then
            lighting.ExposureCompensation = Value
        end
    end})
    world:toggle({name = "Brightness", flag = "brightness", callback = function(v)
        if not v then
            lighting.Brightness = lighting_backup.Brightness
        end
    end})
    world:slider({name = "Brightness", min = 0, max = 10, default = lighting_backup.Brightness, interval = 0.1, flag = "Brightnessvalue", callback = function(Value)
        if flags["brightness"] then
            lighting.Brightness = Value
        end
    end})
    world:toggle({name = "Clock Time", flag = "clocktime", callback = function(v)
        if not v then
            lighting.ClockTime = lighting_backup.ClockTime
        else
            lighting.ClockTime = flags["clocktimevalue"]
        end
    end})
    world:slider({name = "Clock Time", min = 0, max = 24, default = lighting_backup.ClockTime, interval = 0.1, suffix = "h", flag = "clocktimevalue", callback = function(Value)
        if flags["clocktime"] then
            lighting.ClockTime = Value
        end
    end})
    world:toggle({name = "Global Shadows", flag = "GlobalShadows", default = lighting_backup.GlobalShadows, callback = function(v)
        lighting.GlobalShadows = lighting_backup.GlobalShadows
    end})
    world:dropdown({name = "Technology", flag = "Technology", items = {'Voxel', 'Compatibility', 'ShadowMap', 'Future'}, multi = false, callback = function(v) lighting.Technology = Enum.Technology[v] end})
    local column = Visuals:column()
    local hit_detection_section, BulletTracers  = column:multi_section({names = {"Hit Detection", "Bullet Tracers"}})
    hit_detection_section:toggle({name = "Enabled", flag = "hitdetection_enabled"})
    hit_detection_section:toggle({name = "Hit-Logs", flag = "hitlogs_enabled"})
    hit_detection_section:toggle({name = "Custom Hit-Log Text", flag = "customhitlog_enabled"})
    hit_detection_section:textbox({name = "Hitlog format", flag = "hitlog_format", default = "Harmed {player} for {damage} in {hitpart}"})
    hit_detection_section:toggle({name = "Hit Screen", flag = "hitscreen_enabled"})
    :colorpicker({name = "Hit Screen Color", color = Color3.fromRGB(255, 0, 0), flag = "hitscreen_color"})
    hit_detection_section:toggle({name = "Damage Indicator", flag = "indicator_enabled"})
    :colorpicker({name = "Damage Indicator Color", color = Color3.fromRGB(255, 255, 0), flag = "indicator_color"})
    hit_detection_section:dropdown({name = "Indicator Type", flag = "indicator_type", items = {'Fortnite', 'Phantom Forces'}, multi = false})
    hit_detection_section:toggle({name = "Hit Effects", flag = "hit_effects"})
    :colorpicker({name = "Effect Color", color = Color3.fromRGB(96, 120, 190), flag = "hiteffect_color", callback = function(color) hit_effect_module:SetColor(color) end})
    hit_detection_section:dropdown({name = "Effect Type", flag = "hiteffect_type", items = {'Particle', 'Blood', 'Light', 'Lightning', 'BlackFlash', 'Gravity', 'Meteor'}, multi = true, callback = function(selected) hit_effect_module:SetSelectedEffects(selected) end})
    hit_detection_section:slider({name = "Life Time", min = 0.5, max = 5, default = 1, interval = 0.1, flag = "hiteffect_lifetime", callback = function(c) hit_effect_module:SetLifetime(c) end})

    BulletTracers:toggle({name = "Bullet Tracers", flag = "bullettracers_enabled"})
    :colorpicker({name = "Bullet Tracers Color", color = Color3.fromRGB(96, 120, 190), flag = "bullettracers_color"})
    BulletTracers:toggle({name = "Outline", flag = "bullettracers_outline"})
    BulletTracers:slider({name = "Life Time", min = 0.5, max = 5, default = 1.5, interval = 0.1, flag = "bullettracers_lfetime"})
    BulletTracers:slider({name = "Transparency", min = 0, max = 1, default = 1, interval = 0.1, flag = "bulletracers_transparency"})
    BulletTracers:toggle({name = "Lerp", flag = "bullettracers_lerp"})
    BulletTracers:slider({name = "Lerp Value", min = 0.01, max = 1, default = 0.25, interval = 0.01, flag = "bullettracers_lerpvalue"})
    BulletTracers:toggle({name = "Fade", flag = "bullettracers_fade"})
    BulletTracers:slider({name = "Fade Time", min = 0, max = 5, default = 0.5, interval = 0.01, flag = "bullettracers_fadetime"})

    local client_visuals, blabla  = column:multi_section({names = {"Character", "Client"}})
    local aura_toggle = client_visuals:toggle({
        name = "Aura",
        flag = "aura_enabled",
        callback = function(c)
            aura_module.setEnabled(c)
        end
    })

    aura_toggle:colorpicker({name = "Aura Color 1", color = Color3.fromRGB(96, 120, 190), flag = "aura_color_1", callback = function(color) aura_module.setAuraColor(1, color) end})
    aura_toggle:colorpicker({name = "Aura Color 2", color = Color3.fromRGB(96, 120, 190), flag = "aura_color_2", callback = function(color) aura_module.setAuraColor(2, color) end})
    aura_toggle:colorpicker({ name = "Aura Color 3", color = Color3.fromRGB(96, 120, 190), flag = "aura_color_3", callback = function(color) aura_module.setAuraColor(3, color) end})

    client_visuals:dropdown({name = "Aura Type", flag = "aura_type", items = {'Angelic', 'Ambient','Nimb','Tornado'}, multi = true, callback = function(nigga) aura_module.setAuraTypes(nigga) end})
    
    client_visuals:toggle({
        name = "Self Chams",
        flag = "self_chams_enabled",
        callback = function(c)
            self_chams_module:setEnabled(c)
        end
    })
    :colorpicker({name = "Self Chams Color", color = Color3.fromRGB(96, 120, 190), flag = "self_chams_color", callback = function(color) self_chams_module:setColor(color) end})
    client_visuals:slider({name = "Reflectance", min = 0, max = 1, default = 0, interval = 0.01, flag = "self_chams_reflectance", callback = function(c) self_chams_module:setReflectance(c) end})
    client_visuals:slider({name = "Transparency", min = 0, max = 1, default = 0.67, interval = 0.01, flag = "self_chams_transparency", callback = function(c) self_chams_module:setTransparency(c) end})
    client_visuals:dropdown({name = "Material", flag = "self_chams_material", items = {'Neon', 'ForceField','SmoothPlastic'}, multi = false, callback = function(nigga) self_chams_module:setMaterial(nigga) end})
    client_visuals:toggle({
        name = "Particles",
        flag = "self_chams_particles",
        callback = function(varvarvar)
            if varvarvar then
                self_chams_module:setAddEffect(flags["self_chams_particlevalues"] or 'stars')
            else
                self_chams_module:setAddEffect('none')
            end
        end
    })
    :colorpicker({name = "Self Chams Color", color = Color3.fromRGB(96, 120, 190), flag = "self_chams_particle_color", callback = function(color) self_chams_module:setParticleColor(color) end})
    client_visuals:dropdown({name = "Particle Type", flag = "self_chams_particlevalues", items = {'particles', "stars"}, multi = false, callback = function(nigga)
        if flags["self_chams_particles"] then
            self_chams_module:setAddEffect(nigga) 
        end
    end})

    client_visuals:separator({height = 4.5})
    client_visuals:toggle({
        name = "Avatar Changer",
        flag = "avatar_changer_enabled",
        callback = function(state)
            if state then
                funcs.change_avatar(flags["avatar_changer_user"])

                if flags["self_chams_enabled"] then
                    self_chams_module:setEnabled(true)
                end
            end
        end
    })
    client_visuals:toggle({name = "Remove Width Scale", flag = "avatar_changer_remove_width"})
    client_visuals:dropdown({name = "User", flag = "avatar_changer_user", items = {'post_simulation', "spadeuw", "yepitag", "hexxedy", "Nex5us", "dtbbullet", "MrFlimFlam"}, multi = false, callback = function(id) 
        if flags["avatar_changer_enabled"] then
            funcs.change_avatar(id)

            if flags["self_chams_enabled"] then
                self_chams_module:setEnabled(true)
            end
        end
    end})
    client_visuals:textbox({name = "Custom User", flag = "avatar_changer_custom_user", default = "spadeuw", callback = function(input) 

        if flags["avatar_changer_enabled"] then
            if typeof(input) ~= "string" or input == "" then
                return
            end

            local success, userId = pcall(function()
                return entities:GetUserIdFromNameAsync(input)
            end)

            if not success or not userId then
                return
            end

            funcs.change_avatar(input)

            if flags["self_chams_enabled"] then
                self_chams_module:setEnabled(true)
            end
        end
    end})

    blabla:toggle({
        name = "Override Shoot Sound",
        flag = "overrideshootsound_enabled",
        callback = function(c)
            if not c then
                if not local_entity then return end

                local function resetTool(tool)
                    local handle = tool:FindFirstChild("Handle")
                    if not handle then return end

                    local shoot_sound = handle:FindFirstChild("ShootSound")
                    if not shoot_sound then return end

                    local original = original_shoot_sounds[shoot_sound]
                    if original then
                        shoot_sound.SoundId = original
                    end

                    local original_volume = original_shoot_volume[shoot_sound]
                    if original_volume then
                        shoot_sound.Volume = original_volume
                    end
                end

                if local_entity.Character then
                    for _, tool in ipairs(local_entity.Character:GetChildren()) do
                        if tool:IsA("Tool") then
                            resetTool(tool)
                        end
                    end
                end

                if local_entity:FindFirstChild("Backpack") then
                    for _, tool in ipairs(local_entity.Backpack:GetChildren()) do
                        if tool:IsA("Tool") then
                            resetTool(tool)
                        end
                    end
                end

                original_shoot_sounds = {}
                original_shoot_volume = {}
            end
        end
    })
    blabla:dropdown({name = "Sound", flag = "overrideshootsound_id", items = {"Minecraft Hit","Bameware","Skeet","Bonk","HitMarker","Lazer Beam","Windows XP Error","TF2 Hitsound","TF2 Critical","TF2 Bat","Bow Hit","Bow","OSU","BitchBot","BitchBot Body","Steve","1nn", "Rust","TF2 Pan","Neverlose","Mario"}, default = "Bow Hit"})
    blabla:slider({name = "Volume", min = 0.1, max = 5, default = 0.5, interval = 0.1, flag = "overrideshootsound_volume"})
    blabla:separator({height = 4.5})
    blabla:textlabel({text = "Indicators", align = "Center"})
    blabla:toggle({name = "Manipulated", flag = "manipulated_indicator"}):colorpicker({name = "Manipulated Indicator Color", color = Color3.fromRGB(96, 120, 190), flag = "manipulated_indicator_color"})
    blabla:toggle({name = "Ammo", flag = "ammo_indicator"}):colorpicker({name = "Ammo Indicator Color", color = Color3.fromRGB(96, 120, 190), flag = "ammo_indicator_color", callback = function(c) indicators_ammo.TextColor3 = c end})
    blabla:dropdown({
        name = "Font", 
        flag = "indicator_font", 
        items = {"ProggyClean", "SmallestPixel", "TahomaBold"}, 
        callback = function(val)
            if val == "SmallestPixel" then font_size_indicator = 9
            elseif val == "ProggyClean" then font_size_indicator = 12
            else font_size_indicator = 10 end

            if val == "ProggyClean" then
                indicators_ammo.FontFace = library.font
                indicators_ammo.TextSize = font_size_indicator
            elseif val == "SmallestPixel" then
                indicators_ammo.FontFace = Fonts["SmallestPixel"]
                indicators_ammo.TextSize = font_size_indicator
            else
                indicators_ammo.FontFace = Fonts["TahomaBold"]
                indicators_ammo.TextSize = font_size_indicator
            end
        end
    })
    local column = Character:column()
    local movement  = column:section({name = "Movement"})
    movement:toggle({name = "Walk Speed", flag = "walkspeed_enabled"})
    :keybind({
        name = "Walk Speed",
        flag = "walkspeed_bind",
        mode = "toggle",
        callback = function(a)
            if not flags["walkspeed_enabled"] then
                cache.walkspeed_active = false
                return
            end

            cache.walkspeed_active = a
        end
    })
    movement:toggle({name = "Jump Power", flag = "jumppower_enabled"})
    :keybind({
        name = "Jump Power",
        flag = "jumppower_bind",
        mode = "toggle",
        callback = function(a)
            if not flags["jumppower_enabled"] then
                cache.jumppower_active = false
                return
            end

            cache.jumppower_active = a
        end
    })
    movement:slider({name = "Walk Speed", min = 15, max = 300, default = 100, interval = 1, flag = "walkspeed_value"})
    movement:slider({name = "Jump Power", min = 15, max = 300, default = 100, interval = 1, flag = "jumppower_value"})

    local desync = column:section({name = "Desync", size = dim2(1, 0, 3.2, 0)})
    desync:toggle({name = "Enabled", flag = "desync_enabled"})
    :keybind({
        name = "Desync",
        flag = "desync_bind",
        mode = "toggle",
        callback = function(a)
            if not flags["desync_enabled"] then
                cache.desync_active = false
                return
            end

            cache.desync_active = a
        end
    })
    desync:toggle({name = "Visualize", flag = "desync_visualize"})
    :colorpicker({name = "Visualize Color", color = Color3.fromRGB(96, 120, 190), flag = "desync_visualize_color", callback = function(color)
        for i, v in pairs(r6_dummy:GetChildren()) do
            if v:IsA("BasePart") then
                v.Color = color
            end
        end
    end})
    desync:toggle({name = "Attach to Target", flag = "desync_attach_to_target"})
    :keybind({
        name = "Attach to Target",
        flag = "desync_attach_to_target_bind",
        mode = "toggle",
        callback = function(a)
            if not flags["desync_enabled"] or not flags["desync_attach_to_target"] then
                cache.desync_attach_to_target_active = false
                return
            end

            cache.desync_attach_to_target_active = a
        end
    })
    desync:dropdown({name = "Mode", flag = "desync_mode", items = {"Offset", "Random", "Orbit"}, default = "Offset"})
    desync:dropdown({name = "Rotation", flag = "desync_rotation", items = {"Manual", "Random"}, default = "Manual"})

    desync:separator({height = 4.7})
    desync:slider({name = "Offset X", min = -10, max = 10, default = 0, suffix = "st", flag = "desync_offset_x"})
    desync:slider({name = "Offset Y", min = -10, max = 10, default = 0, suffix = "st", flag = "desync_offset_y"})
    desync:slider({name = "Offset Z", min = -10, max = 10, default = 0, suffix = "st", flag = "desync_offset_z"})

    desync:separator({height = 4.7})
    desync:slider({name = "Random X", min = 0, max = 500, default = 0, suffix = "st", flag = "desync_random_x"})
    desync:slider({name = "Random Y", min = 0, max = 500, default = 0, suffix = "st", flag = "desync_random_y"})
    desync:slider({name = "Random Z", min = 0, max = 500, default = 0, suffix = "st", flag = "desync_random_z"})

    desync:separator({height = 4.7})
    desync:slider({name = "Orbit Radius", min = 1, max = 50, default = 15, suffix = "st", flag = "desync_orbit_radius"})
    desync:slider({name = "Orbit Height", min = 0, max = 50, default = 1, suffix = "st", flag = "desync_orbit_height"})
    desync:slider({name = "Orbit Speed", min = 0, max = 50, default = 1, suffix = "st", flag = "desync_orbit_speed"})

    desync:separator({height = 4.7})
    desync:slider({name = "Pitch", min = 0, max = 360, default = 0, suffix = "°", flag = "desync_manual_x"})
    desync:slider({name = "Yaw", min = 0, max = 360, default = 0, suffix = "°", flag = "desync_manual_y"})
    desync:slider({name = "Roll", min = 0, max = 360, default = 0, suffix = "°", flag = "desync_manual_z"})

    local column = Character:column()
    local characterr  = column:section({name = "Character", size = dim2(1, 0, 0.135, 0)})
    characterr:toggle({name = "Fly", flag = "fly_enabled"})
    :keybind({
        name = "Fly",
        flag = "fly_bind",
        mode = "toggle",
        callback = function(a)
            if not flags["fly_enabled"] then
                cache.fly_active = false
                return
            end

            cache.fly_active = a
        end
    })
    characterr:slider({name = "Fly Speed", min = 1, max = 20, default = 10, interval = 1, flag = "fly_speed"})

    local animation_player = column:section({name = "Animation Player", size = dim2(1, 0, 0.30, 0)})
    animation_player:toggle({name = "Enabled", flag = "animation_spoofer_enabled",callback = function(Value)
        if Value then
            funcs.play_dance()
        else
            if danceTrack and danceTrack.IsPlaying then
                danceTrack:Stop()
            end
        end
    end})
    animation_player:dropdown({
        name = "Animation",
        flag = "animationid",
        items = {
            "Yungblud Jump", "Rthro Run", "Punching", "Adidas Fall", "Adidas Run", "Godmode",
            "Old Town Road", "Floss", "TMNT", "Wake Up Call",
            "Fashion Roadkill", "Left N Right", "Side To Side", "It Ain't My Fault"
        },
        multi = false,
        callback = function(Value)
            animationid = animations[Value]
            funcs.load_animation(animationid)
        end
    })
    animation_player:textbox({name = "Custom Animation", flag = "animation_spoofer_custom", default = "id... (ex: 137581268977122)", callback = function(baa) 
        local id = tonumber(baa)
        if not id then return end
        animationid = "rbxassetid://" .. id
        funcs.load_animation("rbxassetid://" .. id)
    end})
    animation_player:slider({name = "FPS", min = 0, max = 240, default = 60, interval = 1, flag = "animation_spoofer_fps"})
    animation_player:slider({name = "Play-Back Speed", min = 0, max = 5, default = 1, interval = 0.1, flag = "animation_spoofer_speed", callback = function(Value)
        if danceTrack then
            danceTrack:AdjustSpeed(Value)
        end
    end})
    local void_section = column:section({name = "Void", size = dim2(1, 0, 0.5, 0)})
    void_section:toggle({name = "Enabled", flag = "void_enabled"})
    void_section:toggle({name = "Spam", flag = "void_spam"})
    void_section:slider({name = "In Void", min = 0, max = 1, compact = true, default = 0.1, interval = 0.01, flag = "void_spam_invoid"})
    void_section:slider({name = "Out of Void", min = 0, max = 1, compact = true, default = 0.2, interval = 0.01, flag = "void_spam_outofvoid"})

Aiming.open_tab() 
-- 

library:notification({text = "aether has loaded..", time = 3})
library:notification({text = "report bugs in the server", time = 3})
library:notification({text = "press INSERT to open/close interface", time = 3})

library:config_list_update()
for index, value in themes.preset do 
pcall(function()
    library:update_theme(index, value)
end)
end
task.wait()
library.old_config = library:get_config()
local indicator = library:indicator()

local fov_circle = Drawing.new("Circle")
fov_circle.Visible = false
fov_circle.ZIndex = 500

local fov_circleoutline = Drawing.new("Circle")
fov_circleoutline.Visible = false
fov_circleoutline.ZIndex = 499
fov_circleoutline.Color = Color3.fromRGB(1,1,1)

local fov_circle_fill = circle_drawing_lib.new("Circle")
fov_circle_fill.Filled = true
fov_circle_fill.Color = Color3.fromRGB(255, 255, 255)
fov_circle_fill.Transparency = 0 
fov_circle_fill.Gradient = {
    Color = ColorSequence.new(flags["silentaim_fov_gradient_color1"].Color, flags["silentaim_fov_gradient_color2"].Color, flags["silentaim_fov_gradient_color3"].Color),
    Rotation = 90
}

local box = Drawing.new("Square")
box.Color = Color3.fromRGB(255, 255, 255)
box.Thickness = 1
box.Filled = false
box.Visible = false
box.ZIndex = 500

local box_outline = Drawing.new("Square")
box_outline.Color = Color3.fromRGB(1, 1, 1)
box_outline.Thickness = 2.1
box_outline.Filled = false
box_outline.Visible = false
box_outline.ZIndex = 499

local target_line = Drawing.new("Line")
local target_line_outline = Drawing.new("Line")
target_line.Thickness = 1.3
target_line.Color = Color3.fromRGB(255, 255, 255)
target_line.Transparency = 1
target_line.Visible = false
target_line.ZIndex = 500
target_line_outline.Thickness = 1.3
target_line_outline.Color = Color3.fromRGB(0, 0, 0)
target_line_outline.Transparency = 1
target_line_outline.Visible = false
target_line_outline.ZIndex = 499

indicators_ammo.FontFace = library.font

funcs.get_closest_part = function(model_instance)
    local closest_part, closest_dis = nil, math.huge

    for _, part_name in ipairs(hitpoints) do
        local part = model_instance:FindFirstChild(part_name)
        if part then
            local pos, onscreen = funcs.world_to_view_port_point(part.Position)
            local dis = (funcs.get_mouse_location() - vec2(pos.X, pos.Y)).Magnitude

            if onscreen and dis < closest_dis then
                closest_part = part
                closest_dis = dis
            end
        end
    end

    return closest_part
end

funcs.get_closest_point = function(Part)
    local hitPos = cache.mouse_hit.Position

    local RaycastParamsClosestPoint = RaycastParams.new()
    RaycastParamsClosestPoint.FilterType = Enum.RaycastFilterType.Whitelist
    RaycastParamsClosestPoint.FilterDescendantsInstances = {Part}

    local MouseRay = mouse.UnitRay
    MouseRay = MouseRay.Origin + (MouseRay.Direction * (Part.Position - MouseRay.Origin).Magnitude)
    local Origin = (MouseRay.Y >= (Part.Position - Part.Size / 2).Y and MouseRay.Y <= (Part.Position + Part.Size / 2).Y) and (Part.Position + vec3(0, -Part.Position.Y + MouseRay.Y, 0)) or Part.Position

    local Raycast = workspace:Raycast(MouseRay, (Origin - MouseRay), RaycastParamsClosestPoint)
    return Raycast and Raycast.Position or hitPos
end

funcs.get_prediction = function(entity, arg)
    local prediction

    if entity then
        if entity.Character:FindFirstChildOfClass('Humanoid'):GetState() == Enum.HumanoidStateType.Freefall then
            prediction = getgenv().aether[arg].prediction.y
        else
            prediction = getgenv().aether[arg].prediction.x
        end
    end

    return prediction
end

funcs.get_smoothing = function(entity)
    local smoothness

    if entity then
        if entity.Character:FindFirstChildOfClass('Humanoid'):GetState() == Enum.HumanoidStateType.Freefall then
            smoothness = getgenv().aether.aim_assist.smoothness.y
        else
            smoothness = getgenv().aether.aim_assist.smoothness.x
        end
    end

    return smoothness
end

funcs.get_cframe = function(entity)
    if not entity or not entity.Character then
        return nil
    end

    local character = entity.Character
    local hit_point
    local end_point

    if getgenv().aether.silent_aim.part.type == "Closest Part" then
        hit_point = funcs.get_closest_part(character)

    elseif getgenv().aether.silent_aim.part.type == "Closest Point" then
        local part = funcs.get_closest_part(character)
        hit_point = part and funcs.get_closest_point(part)
    else 
        hit_point = character:FindFirstChild(getgenv().aether.silent_aim.part.value)
    end

    if not hit_point then
        return nil
    end

    end_point = (getgenv().aether.silent_aim.part.type == "Closest Point") and cframe(hit_point) or hit_point.CFrame

    if getgenv().aether.silent_aim.prediction.enabled then
        local humanoid_root_part = character:FindFirstChild("HumanoidRootPart")

        if humanoid_root_part then
            end_point = end_point + humanoid_root_part.Velocity * funcs.get_prediction(entity, "silent_aim")
        end
    end

    return end_point
end

funcs.get_position = function(entity)
    if not (entity and funcs.is_alive(entity)) then
        return nil
    end

    local character = entity.Character
    local part
    local position

    if getgenv().aether.aim_assist.part.type == "Closest Part" or getgenv().aether.aim_assist.part.type == "Closest Point" then
        part = funcs.get_closest_part(character)
    else
        part = character:FindFirstChild(getgenv().aether.aim_assist.part.value)
    end

    if not part then
        return nil
    end

    if getgenv().aether.aim_assist.part.type == "Closest Point" then
        position = funcs.get_closest_point(part)
    else
        position = part.Position
    end

    if getgenv().aether.aim_assist.method == "Camera" then
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not hrp then
            return position
        end

        if getgenv().aether.aim_assist.prediction.enabled then
            local prediction = funcs.get_prediction(entity, "aim_assist")
            position = position + hrp.Velocity * prediction
        end

        if getgenv().aether.aim_assist.shake.enabled then
            position = position + vec3(
                math.random(-getgenv().aether.aim_assist.shake.x, getgenv().aether.aim_assist.shake.x),
                math.random(-getgenv().aether.aim_assist.shake.y, getgenv().aether.aim_assist.shake.y),
                math.random(-getgenv().aether.aim_assist.shake.z, getgenv().aether.aim_assist.shake.z)
            ) * 0.1
        end

        return CFrame.new(camera.CFrame.Position, position)
    end

    return position
end

funcs.update_box = function(entity)
    if not entity or not entity.Character then
        box.Visible = false
        box_outline.Visible = false
        return false
    end

    if getgenv().aether.trigger_bot.whitelist.enabled then
        for _, name in ipairs(getgenv().aether.trigger_bot.whitelist.player_list) do
            if entity.Name == name then
                box.Visible = false
                box_outline.Visible = false
                return false 
            end
        end
    end

    local humanoid_root_part = entity.Character:FindFirstChild("HumanoidRootPart") 
    if not humanoid_root_part then
        box.Visible = false
        box_outline.Visible = false
        return false
    end

    local screen_pos, on_screen = camera:WorldToViewportPoint(humanoid_root_part.Position)
    if not on_screen then
        box.Visible = false
        box_outline.Visible = false
        return false
    end

    local size = (camera:WorldToViewportPoint(humanoid_root_part.Position - Vector3.new(0, 3, 0)).Y - camera:WorldToViewportPoint(humanoid_root_part.Position + Vector3.new(0, 2.6, 0)).Y) / 2
    local box_size = Vector2.new(math.round(size * getgenv().aether.trigger_bot.hitbox.size_x) + 2, math.round(size * getgenv().aether.trigger_bot.hitbox.size_y) + 2)

    local box_pos = Vector2.new(math.round(screen_pos.X - box_size.X / 2) - 2, math.round(screen_pos.Y - box_size.Y / 2) - 2)

    local minX = box_pos.X
    local minY = box_pos.Y
    local maxX = box_pos.X + box_size.X
    local maxY = box_pos.Y + box_size.Y

    box.Position = box_pos
    box.Size = box_size
    box.Visible = getgenv().aether.trigger_bot.hitbox.visualise.enabled

    box_outline.Position = box_pos
    box_outline.Size = box_size
    box_outline.Visible = getgenv().aether.trigger_bot.hitbox.visualise.enabled

    local mouse_pos = funcs.get_mouse_location()
    local mouse_inside =
        mouse_pos.X >= minX and mouse_pos.X <= maxX and
        mouse_pos.Y >= minY and mouse_pos.Y <= maxY

    if mouse_inside then
        box.Color = getgenv().aether.trigger_bot.hitbox.visualise.locked_on_color

        local character = local_entity.Character
        if character then
            if cache.equipped_tool then
                local ammo, max_ammo = funcs.get_weapon_ammo()

                if ammo ~= 0 then
                    funcs.shoot(tool)
                end
            end
        end
    else
        box.Color = getgenv().aether.trigger_bot.hitbox.visualise.not_locked_on_color
    end

    return mouse_inside
end

funcs.hit_overlay = function()
    local gui = Instance.new("ScreenGui")
    gui.Name = "SG"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder = 9999
    gui.Parent = core_gui

    local img = Instance.new("ImageLabel")
    img.Parent = gui
    img.Size = UDim2.new(1, 0, 1, 0)
    img.BackgroundTransparency = 1
    img.Image = cache.assetpath
    img.ImageColor3 = flags["hitscreen_color"].Color
    img.ImageTransparency = 0.9

    local tween = tween_service:Create(
        img,
        TweenInfo.new(0.5, Enum.EasingStyle.Linear),
        { ImageTransparency = 1 }
    )

    tween:Play()
    tween.Completed:Once(function()
        gui:Destroy()
    end)
end

funcs.hit_indicator_pf = function(part, text)
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "HitIndicator"
    billboardGui.Size = UDim2.new(0, 160, 0, 90)
    billboardGui.Adornee = part
    billboardGui.AlwaysOnTop = true

    local fontFace = Font.new(
        "rbxasset://fonts/families/Zekton.json",
        Enum.FontWeight.Regular,
        Enum.FontStyle.Italic
    )

    local frontText = Instance.new("TextLabel")
    frontText.Text = tostring(math.round(text))
    frontText.FontFace = fontFace
    frontText.Size = UDim2.new(1, 0, 1, 0)
    frontText.BackgroundTransparency = 1
    frontText.TextSize = 36
    frontText.TextColor3 = flags["indicator_color"].Color
    frontText.ZIndex = 2

    local shadowText = Instance.new("TextLabel")
    shadowText.Text = frontText.Text
    shadowText.FontFace = fontFace
    shadowText.Size = UDim2.new(1, 0, 1, 0)
    shadowText.BackgroundTransparency = 1
    shadowText.TextSize = 36
    shadowText.TextColor3 = Color3.fromRGB(67, 67, 67)
    shadowText.ZIndex = 1

    local offsetX = math.random(-50, 50)
    local offsetY = math.random(-35, 20)

    local startPos = UDim2.new(0, offsetX, 0, offsetY)
    local endPos   = UDim2.new(0, offsetX, 0, offsetY - 55)

    frontText.Position = startPos
    shadowText.Position = UDim2.new(0, offsetX + 1, 0, offsetY + 1)

    frontText.Parent = billboardGui
    shadowText.Parent = billboardGui
    billboardGui.Parent = part

    local popTweenInfo = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local popGoal = { TextSize = 40 }

    tween_service:Create(frontText, popTweenInfo, popGoal):Play()
    tween_service:Create(shadowText, popTweenInfo, popGoal):Play()

    local floatTweenInfo = TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    local frontFloatGoal = {
        Position = endPos
    }

    local shadowFloatGoal = {
        Position = UDim2.new(0, offsetX + 4, 0, offsetY - 55 + 4)
    }

    local frontFloat = tween_service:Create(frontText, floatTweenInfo, frontFloatGoal)
    local shadowFloat = tween_service:Create(shadowText, floatTweenInfo, shadowFloatGoal)

    frontFloat.Completed:Connect(function()
        local fadeTweenInfo = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

        local fadeGoal = {
            TextTransparency = 1
        }

        local frontFade = tween_service:Create(frontText, fadeTweenInfo, fadeGoal)
        local shadowFade = tween_service:Create(shadowText, fadeTweenInfo, fadeGoal)

        frontFade.Completed:Connect(function()
            billboardGui:Destroy()
        end)

        frontFade:Play()
        shadowFade:Play()
    end)

    frontFloat:Play()
    shadowFloat:Play()
end

funcs.hit_indicator = function(part, text)
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "HitIndicator"
    billboardGui.Size = UDim2.new(0, 140, 0, 80) 
    billboardGui.Adornee = part
    billboardGui.AlwaysOnTop = true

    local textLabel = Instance.new("TextLabel")
    textLabel.Text = tostring(math.round(text))
    textLabel.FontFace = Fonts.Fortnite
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.TextSize = 42
    textLabel.BackgroundTransparency = 1
    textLabel.TextScaled = false
    textLabel.TextColor3 = flags["indicator_color"].Color

    local textStroke = Instance.new("UIStroke")
    textStroke.Thickness = 1.2
    textStroke.Color = Color3.new(0, 0, 0)
    textStroke.Parent = textLabel

    local offsetX = math.random(-40, 41) 
    local offsetY = math.random(-37, 37) 
    local rotation = 1

    textLabel.Position = UDim2.new(0, offsetX, 0, offsetY)
    textLabel.Rotation = rotation
    textLabel.Parent = billboardGui
    billboardGui.Parent = part

    local tweenInfoSize = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local goalSize = { TextSize = 49 }
    local tweenSize = tween_service:Create(textLabel, tweenInfoSize, goalSize)

    tweenSize.Completed:Connect(function()
        local tweenInfoFade = TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

        local goalFade = {
            TextTransparency = 1, 
            Rotation = 55
        }

        local goalStroke = { Transparency = 1 }

        local tweenFade = tween_service:Create(textLabel, tweenInfoFade, goalFade)
        local tweenStroke = tween_service:Create(textStroke, tweenInfoFade, goalStroke)

        tweenFade.Completed:Connect(function()
            billboardGui:Destroy()
        end)

        tweenFade:Play()
        tweenStroke:Play()
    end)

    tweenSize:Play()
end

funcs.fly = function()
    local hrp = local_entity.Character and local_entity.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local camCF = camera.CFrame
    local moveDir = Vector3.zero

    if uis:IsKeyDown(Enum.KeyCode.W) then moveDir += camCF.LookVector end
    if uis:IsKeyDown(Enum.KeyCode.S) then moveDir -= camCF.LookVector end
    if uis:IsKeyDown(Enum.KeyCode.A) then moveDir -= camCF.RightVector end
    if uis:IsKeyDown(Enum.KeyCode.D) then moveDir += camCF.RightVector end
    if uis:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.yAxis end
    if uis:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir -= Vector3.yAxis end

    if moveDir.Magnitude > 0 then
        moveDir = moveDir.Unit
        local newPos = hrp.Position + (moveDir * (flags.fly_speed * 0.1))

        hrp.CFrame = CFrame.lookAt(newPos, newPos + camCF.LookVector)
    else
        local look = Vector3.new(camCF.LookVector.X, 0, camCF.LookVector.Z)
        if look.Magnitude > 0 then
            hrp.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + look)
        end
    end

    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero
end

library:connection(run.Heartbeat, LPH_NO_VIRTUALIZE(function(dt)
    local mouse_pos = funcs.get_mouse_location()

    fov_circle.Visible = getgenv().aether.field_of_view.silent_aim.visible
    fov_circle.Color = getgenv().aether.field_of_view.silent_aim.color
    fov_circle.Radius = getgenv().aether.field_of_view.silent_aim.radius
    fov_circle.Thickness = getgenv().aether.field_of_view.silent_aim.thickness
    fov_circle.NumSides = getgenv().aether.field_of_view.silent_aim.sides

    if getgenv().aether.field_of_view.silent_aim.visible and getgenv().aether.field_of_view.silent_aim.outline then
        fov_circleoutline.Visible = true
        fov_circleoutline.Radius = getgenv().aether.field_of_view.silent_aim.radius
        fov_circleoutline.Thickness = getgenv().aether.field_of_view.silent_aim.thickness + 2
        fov_circleoutline.NumSides = getgenv().aether.field_of_view.silent_aim.sides
    else
        fov_circleoutline.Visible = false
    end

    if getgenv().aether.field_of_view.silent_aim.visible and flags["silentaim_fov_gradient"] then
        fov_circle_fill.Radius = fov_circle.Radius
        fov_circle_fill.Visible = true
        fov_circle_fill.Gradient.Color = ColorSequence.new(flags["silentaim_fov_gradient_color1"].Color, flags["silentaim_fov_gradient_color2"].Color, flags["silentaim_fov_gradient_color3"].Color)
        fov_circle_fill.FilledTransparency = flags["silentaim_fov_fill_transparency"]
    else
        fov_circle_fill.Visible = false
    end

    if getgenv().aether.field_of_view.silent_aim.visible and flags["fovsticktobarrel"] then
        if cache.equipped_tool then
            local gun_position = (cache.equipped_tool.Handle.CFrame * cframe(cache.equipped_tool.Handle.ShootBBGUI.StudsOffsetWorldSpace)).Position
            local position = camera:WorldToViewportPoint(gun_position)

            local target = vec2(position.x, position.y)

            fov_circle.Position = fov_circle.Position:Lerp(target, flags["fovsticktobarrel_lerp"])
            fov_circleoutline.Position = fov_circleoutline.Position:Lerp(target, flags["fovsticktobarrel_lerp"])
            fov_circle_fill.Position = fov_circle_fill.Position:Lerp(target, flags["fovsticktobarrel_lerp"])
        else
            fov_circle.Position = mouse_pos
            fov_circleoutline.Position = mouse_pos
            fov_circle_fill.Position = mouse_pos
        end
    else
        fov_circle.Position = mouse_pos
        fov_circleoutline.Position = mouse_pos
        fov_circle_fill.Position = mouse_pos
    end

    if getgenv().aether.silent_aim.visualisation.tracer.visible and cache.closest_entity and cache.silentaim_targetting then
        local part = cache.closest_entity.Character:FindFirstChild(getgenv().aether.silent_aim.part.value)

        if part then
            local position = funcs.world_to_view_port_point(part.Position)

            if flags["tracer_position"] == "Barrel" then
                if cache.equipped_tool then
                    local gun_position = (cache.equipped_tool.Handle.CFrame * cframe(cache.equipped_tool.Handle.ShootBBGUI.StudsOffsetWorldSpace)).Position
                    local position, on_screen = camera:WorldToViewportPoint(gun_position)

                    if on_screen then
                        target_line.From = vec2(position.x, position.y)
                        target_line_outline.From = vec2(position.x, position.y)
                    else
                        target_line.From = mouse_pos
                        target_line_outline.From = mouse_pos
                    end
                else
                    target_line.From = mouse_pos
                    target_line_outline.From = mouse_pos
                end
            else
                target_line.From = mouse_pos
                target_line_outline.From = mouse_pos
            end

            target_line.Visible = true
            target_line.Color = getgenv().aether.silent_aim.visualisation.tracer.color
            target_line.Thickness = getgenv().aether.silent_aim.visualisation.tracer.thickness
            target_line.To = vec2(position.x, position.y)

            if getgenv().aether.silent_aim.visualisation.tracer.outline then
                target_line_outline.Visible = true
                target_line_outline.Thickness = getgenv().aether.silent_aim.visualisation.tracer.thickness + 2
                target_line_outline.To = vec2(position.x, position.y)
            else
                target_line_outline.Visible = false
            end
        else
            target_line.Visible = false
            target_line_outline.Visible = false
        end
    else
        target_line.Visible = false
        target_line_outline.Visible = false
    end

    if not getgenv().aether.silent_aim.visualisation.circle.visible or not cache.closest_entity or not cache.silentaim_targetting then
        if cache.lines and cache.lines_visible then
            for _, l in ipairs(cache.lines) do
                l.Visible = false
            end
            cache.lines_visible = false
        end
    end

    if getgenv().aether.silent_aim.visualisation.circle.visible then
        if cache.closest_entity and cache.silentaim_targetting then
            cache.root = cache.closest_entity.Character and cache.closest_entity.Character:FindFirstChild("HumanoidRootPart")

            if not cache.lines then
                cache.lines = {}
                for i = 1, 60 do
                    local line = Drawing.new("Line")
                    line.Thickness = 2
                    line.Color = getgenv().aether.silent_aim.visualisation.circle.color
                    line.Visible = false
                    table.insert(cache.lines, line)
                end
            end

            if not cache.root then
                for _, l in ipairs(cache.lines) do
                    l.Visible = false
                end
                return
            end

            cache.spin = (cache.spin or 0) + math.rad(360) * dt
            cache.spin = cache.spin % (2 * math.pi)

            cache.circle = cache.circle or {}
            cache.circle.rad = 2
            cache.circle.seg = 60
            cache.circle.deg = 270
            cache.circle.step = math.rad(cache.circle.deg / cache.circle.seg)
            cache.circle.pts = {}

            if funcs.is_knocked(cache.closest_entity) then
                local sum = Vector3.zero
                local n = 0
                for _, p in ipairs(cache.closest_entity.Character:GetChildren()) do
                    if p:IsA("BasePart") then
                        sum += p.Position
                        n += 1
                    end
                end
                if n > 0 then
                    cache.circle.mid = (sum / n) + Vector3.new(0, 1.2, 0)
                else
                    cache.circle.mid = cache.root.Position
                end
            else
                cache.circle.mid = cache.root.Position + Vector3.new(0, 0.1, 0)
            end

            for i = 1, cache.circle.seg + 1 do
                local a = cache.spin + (i - 1) * cache.circle.step
                local off = Vector3.new(math.cos(a), 0, math.sin(a)) * cache.circle.rad
                local w = cache.circle.mid + off

                local s, ok = camera:WorldToViewportPoint(w)
                if not ok then
                    for _, l in ipairs(cache.lines) do
                        l.Visible = false
                    end
                    return
                end

                cache.circle.pts[i] = Vector2.new(s.X, s.Y)
            end

            if funcs.is_knocked(cache.closest_entity) then
                cache.circle.mid += Vector3.new(0, -2.4, 0)
            else
                cache.circle.mid += Vector3.new(0, 1.2, 0)
            end

            for i = 1, cache.circle.seg do
                local l = cache.lines[i]
                l.From = cache.circle.pts[i]
                l.To = cache.circle.pts[i + 1]
                l.Transparency = i / cache.circle.seg
                l.Thickness = 5 - (2.5 * (i / cache.circle.seg))
                l.Color = getgenv().aether.silent_aim.visualisation.circle.color
                l.Visible = true
            end

            cache.lines_visible = true
        end
    end

    if getgenv().aether.silent_aim.enabled and getgenv().aether.silent_aim.target_hud then
        if cache.closest_entity and cache.silentaim_targetting then
            indicator.set_visible(true)

            if cache.closest_entity ~= cache.last_target then
                cache.last_target = cache.closest_entity
                indicator.change_profile(cache.closest_entity)
            end

            local humanoid = cache.closest_entity.Character and cache.closest_entity.Character:FindFirstChildWhichIsA("Humanoid")
            if humanoid then
                indicator.change_health(math.clamp(humanoid.Health, 0, humanoid.MaxHealth))
            end

            if flags["targethud_followtarget"] then
                local humanoid_root_part = cache.closest_entity.Character and cache.closest_entity.Character:FindFirstChild("HumanoidRootPart")

                if humanoid_root_part then
                    local position, on_screen = camera:WorldToViewportPoint(humanoid_root_part.Position)

                    if on_screen then
                        local offset_x = 50 
                        local offset_y = 30  

                        local target_position = UDim2.new(0, position.X + offset_x, 0, position.Y + offset_y)
                        indicator.set_position(target_position) 
                    end
                end
            else
                if not cache.indicator_reset then
                    indicator.set_position(UDim2.new(0.5, 0, 0.5, math.floor(camera.ViewportSize.Y * 0.3)))
                    cache.indicator_reset = true
                end
            end
        else
            cache.last_target = nil
            indicator.set_visible(false)
            cache.indicator_reset = false 
        end
    else
        cache.last_target = nil
        indicator.set_visible(false)
        cache.indicator_reset = false 
    end

    if flags["ammo_indicator"] and cache.equipped_tool then
        local ammo, max_ammo = funcs.get_weapon_ammo()

        indicators_ammo.Visible = true
        indicators_ammo.Position = UDim2.fromOffset(uis:GetMouseLocation().x, uis:GetMouseLocation().y + 25)

        if flags["silentaim_pathfinding"] and flags["manipulated_indicator"] and is_manipulated then
            indicators_ammo.Text = "manipulated" .. "\n" .. ammo .. "/" .. max_ammo
        else
            indicators_ammo.Text = ammo .. "/" .. max_ammo
        end
    else
        indicators_ammo.Visible = false
    end
end))

library:connection(run.RenderStepped, LPH_NO_VIRTUALIZE(function(dt)
    cache.mouse_position = funcs.get_mouse_location()
    cache.mouse_hit = mouse.Hit

    if flags["silentaim_enabled"] and getgenv().aether.silent_aim.manipulation and cache.closest_entity and cache.silentaim_targetting and (game.PlaceId == 9825515356 or game.PlaceId == 138995385694035) then
        cache.workspace_time = workspace:GetServerTimeNow()
    end

    if funcs.has_weapon(local_entity) then
        cache.equipped_tool = local_entity.Character:FindFirstChildWhichIsA("Tool")
    else
        cache.equipped_tool = nil
    end
    
    if getgenv().aether.silent_aim.enabled then
        if getgenv().aether.silent_aim.auto_select then
            local delay_ms = flags["target_selector_refresh_time"]
            local delay_s = delay_ms / 1000

            if os.clock() - cache.last_refresh >= delay_s then
                cache.last_refresh = os.clock()
                if flags["use_fov"] then
                    cache.closest_entity = funcs.find_nearest_entity(getgenv().aether.field_of_view.silent_aim.radius)
                else
                    cache.closest_entity = funcs.find_nearest_entity(math.huge)
                end
                cache.silentaim_targetting = true
            end
        end

        if getgenv().aether.silent_aim.auto_shoot and cache.closest_entity and cache.silentaim_targetting then
            if cache.equipped_tool then
                cache.equipped_tool:Activate()
            end
        end
    end

    if getgenv().aether.aim_assist.enabled then
        if cache.closest_entity_aimassist and cache.aimassist_targetting then
            local smoothness = getgenv().aether.aim_assist.smoothness.enabled and funcs.get_smoothing(cache.closest_entity_aimassist) or 1

            if getgenv().aether.aim_assist.method == "Camera" then
                local position = funcs.get_position(cache.closest_entity_aimassist)

                camera.CFrame = camera.CFrame:Lerp(position, smoothness, Enum.EasingStyle[getgenv().aether.aim_assist.smoothness.easing_style], Enum.EasingDirection[getgenv().aether.aim_assist.smoothness.easing_direction])
            else
                local position = funcs.get_position(cache.closest_entity_aimassist)
                local pos = funcs.world_to_view_port_point(position)

                local x = (pos.x - uis:GetMouseLocation().x) * smoothness
                local y = (pos.y - uis:GetMouseLocation().y) * smoothness

                mousemoverel(x, y)
            end
        end
    end

    if flags["walkspeed_enabled"] and cache.walkspeed_active then
        local_entity.Character.Humanoid.WalkSpeed = flags["walkspeed_value"]
    end

    if flags["jumppower_enabled"] and cache.jumppower_active then
        local_entity.Character.Humanoid.JumpPower = flags["jumppower_value"]
    end

    if flags["fly_enabled"] and cache.fly_active then	
        funcs.fly()
    end

    if flags["animation_spoofer_enabled"] then
        funcs.update_animation()
    end
    
    if getgenv().aether.trigger_bot.enabled and cache.triggerbot_active then
        cache.triggerbot_target = funcs.find_nearest_entity(200)

        if cache.triggerbot_target then
            funcs.update_box(cache.triggerbot_target)
        else
            box.Visible = false
            box_outline.Visible = false
        end
    else
        box.Visible = false
        box_outline.Visible = false
    end

    if flags["overrideshootsound_enabled"] and cache.equipped_tool then
        local handle = cache.equipped_tool:FindFirstChild("Handle")
        if handle then
            local shoot_sound = handle:FindFirstChild("ShootSound")
            if shoot_sound then
                if not original_shoot_sounds[shoot_sound] then
                    original_shoot_sounds[shoot_sound] = shoot_sound.SoundId
                end

                if not original_shoot_volume[shoot_sound] then
                    original_shoot_volume[shoot_sound] = shoot_sound.Volume
                end

                shoot_sound.Volume = flags["overrideshootsound_volume"]

                local id = hit_sounds[flags["overrideshootsound_id"]]
                if id then
                    shoot_sound.SoundId = "rbxassetid://" .. id
                end
            end
        end
    end
end))
                            
local gun_is_firing = false
local gun_conn = nil
local previousammo = 0
local max_distance = 10 

local active_bullets = {}
library:connection(run.RenderStepped, LPH_NO_VIRTUALIZE(function()
    local current_time = tick()
    for i = #active_bullets, 1, -1 do
        local bullet = active_bullets[i]
        local elapsed = current_time - bullet.birth_time
        local fade_time = flags["bullettracers_fade"] and flags["bullettracers_fadetime"] or 0

        local progress = bullet.lerp_enabled and math.clamp(elapsed / bullet.lerp_value, 0, 1) or 1
        local current_lerped_pos = bullet.start_position:Lerp(bullet.end_position, progress)

        local transparency = bullet.original_transparency
        if elapsed > bullet.lifetime then
            local fade_elapsed = elapsed - bullet.lifetime
            transparency = bullet.original_transparency * math.clamp(1 - (fade_elapsed / fade_time), 0, 1)
        end

        local start_screen_pos = camera:WorldToViewportPoint(bullet.start_position)
        local end_screen_pos = camera:WorldToViewportPoint(current_lerped_pos)

        if funcs.check_cam_view(bullet.start_position) and funcs.check_cam_view(current_lerped_pos) then
            bullet.line.Visible = true
            bullet.line.From = Vector2.new(start_screen_pos.X, start_screen_pos.Y)
            bullet.line.To = Vector2.new(end_screen_pos.X, end_screen_pos.Y)
            bullet.line.Transparency = transparency

            bullet.outline.Visible = bullet.outline_enabled
            bullet.outline.From = bullet.line.From
            bullet.outline.To = bullet.line.To
            bullet.outline.Transparency = transparency
        else
            bullet.line.Visible = false
            bullet.outline.Visible = false
        end

        if elapsed >= bullet.lifetime + fade_time then
            bullet.line:Remove()
            bullet.outline:Remove()
            table.remove(active_bullets, i)
        end
    end
end))

library:connection(run.Heartbeat, LPH_NO_VIRTUALIZE(function()
    if not flags["bullettracers_enabled"] then return end
    if gun_conn or not cache.equipped_tool then return end

    local radius = workspace:FindFirstChild("Ignored") 
        and workspace.Ignored:FindFirstChild("Siren") 
        and workspace.Ignored.Siren:FindFirstChild("Radius")

    if not radius then
        return
    end

    gun_conn = radius.ChildAdded:Connect(function(object)
        if object.Name ~= "BULLET_RAYS" then return end

        local beam_conn
        beam_conn = object.DescendantAdded:Connect(function(desc)
            if not desc:IsA("Beam") then return end
            beam_conn:Disconnect()

            local start_attachment = desc.Attachment0
            local end_attachment = desc.Attachment1
            if not start_attachment or not end_attachment then return end

            local start_position = start_attachment.WorldPosition
            local end_position = end_attachment.WorldPosition

            local character = local_entity.Character
            local root = character and character:FindFirstChild("HumanoidRootPart")
            if not root then return end

            if (root.Position - start_position).Magnitude > max_distance then return end

            local params = RaycastParams.new()
            params.FilterDescendantsInstances = {character, cache.equipped_tool.Handle}
            params.FilterType = Enum.RaycastFilterType.Exclude
            params.IgnoreWater = true
            workspace:Raycast(start_position, end_position, params)

            if flags["bullettracers_enabled"] then
                local bullet_line = Drawing.new("Line")
                bullet_line.Color = flags["bullettracers_color"].Color
                bullet_line.Visible = false
                bullet_line.Transparency = flags["bulletracers_transparency"]
                bullet_line.Thickness = 1.3
                bullet_line.ZIndex = 3

                local bullet_line_outline = Drawing.new("Line")
                bullet_line_outline.Color = Color3.fromRGB(0, 0, 0)
                bullet_line_outline.Visible = false
                bullet_line_outline.Transparency = flags["bulletracers_transparency"]
                bullet_line_outline.Thickness = 3
                bullet_line_outline.ZIndex = 2

                table.insert(active_bullets, {
                    start_position = start_position,
                    end_position = end_position,
                    birth_time = tick(),
                    lifetime = flags["bullettracers_lfetime"],
                    lerp_enabled = flags["bullettracers_lerp"],
                    lerp_value = flags["bullettracers_lerpvalue"],
                    line = bullet_line,
                    outline = bullet_line_outline,
                    outline_enabled = flags["bullettracers_outline"],
                    original_transparency = flags["bulletracers_transparency"] 
                })

                task.defer(function()
                    if desc.Parent then
                        desc:Destroy()
                    end
                end)
            end
        end)
    end)
end))

function RandomNumberRange(a)
    return math.random(-a * 100, a * 100) / 100
end

function RandomVectorRange(a, b, c)
    return Vector3.new(RandomNumberRange(a), RandomNumberRange(b), RandomNumberRange(c))
end

local verycoolpart = Instance.new("Part")
verycoolpart.Size = vec3(0.1, 0.1, 0.1)
verycoolpart.Anchored = true
verycoolpart.CanCollide = false
verycoolpart.Transparency = 1
verycoolpart.Parent = workspace

local desync_stuff = {}
local desync_position = nil
local desync_origin = nil
library:connection(run.Heartbeat, LPH_NO_VIRTUALIZE(function()
    if flags["desync_enabled"] and funcs.is_alive(local_entity) then
        desync_stuff[1] = local_entity.Character.HumanoidRootPart.CFrame
        desync_origin = (cache.desync_attach_to_target_active and cache.closest_entity and cache.closest_entity.Character and cache.closest_entity.Character.HumanoidRootPart.CFrame) or local_entity.Character.HumanoidRootPart.CFrame

        if cache.desync_active then
            desync_position = desync_origin

            if flags["desync_mode"] == "Offset" then
                desync_position = desync_position * cframe(vec3(flags["desync_offset_x"], flags["desync_offset_y"], flags["desync_offset_z"]))
            elseif flags["desync_mode"] == "Random" then
                desync_position = desync_position * CFrame.new(RandomVectorRange(flags["desync_random_x"], flags["desync_random_y"], flags["desync_random_z"]))
            elseif flags["desync_mode"] == "Void" then
                desync_position = cframe(vec3(math.random(-1e6, 1e6), math.random(100, 1e4), math.random(-1e6, 1e6)))
            elseif flags["desync_mode"] == "Orbit" then
                local radius = flags["desync_orbit_radius"]
                local speed = flags["desync_orbit_speed"]
                local height = flags["desync_orbit_height"]

                local angle = os.clock() * speed

                local offset = Vector3.new(
                    math.cos(angle) * radius,
                    height,
                    math.sin(angle) * radius
                )

                desync_position = CFrame.new(
                    desync_position.Position + offset,
                    desync_position.Position
                )
            end

            if flags["desync_rotation"] == "Manual" then
                desync_position = desync_position * CFrame.Angles(math.rad(flags["desync_manual_x"]), math.rad(flags["desync_manual_y"]), math.rad(flags["desync_manual_z"]))
            elseif flags["desync_rotation"] == "Random" then
                desync_position = desync_position * CFrame.Angles(math.rad(RandomNumberRange(flags["desync_manual_x"])), math.rad(RandomNumberRange(flags["desync_manual_y"])), math.rad(RandomNumberRange(flags["desync_manual_z"])))
            end

            local_entity.Character.HumanoidRootPart.CFrame = desync_position

            verycoolpart.CFrame = desync_stuff[1] * CFrame.new(0, 2, 0)
            camera.CameraSubject = verycoolpart
        else
            if camera.CameraSubject ~= local_entity.Character.Humanoid then
                camera.CameraSubject = local_entity.Character.Humanoid
            end
        end

        if flags["desync_visualize"] then
            r6_dummy.Parent = workspace
            r6_dummy.HumanoidRootPart.Velocity = vec3()
            r6_dummy:SetPrimaryPartCFrame(local_entity.Character.HumanoidRootPart.CFrame)
        else
            r6_dummy.Parent = nil
        end

        run.RenderStepped:Wait()

        local_entity.Character.HumanoidRootPart.CFrame = desync_stuff[1]
    else
        if r6_dummy.Parent ~= nil then
            r6_dummy.Parent = nil
        end

        if local_entity then
            local humanoid = local_entity.Character and local_entity.Character:FindFirstChild("Humanoid")

            if humanoid then
                if camera.CameraSubject ~= humanoid then
                    camera.CameraSubject = humanoid
                end
            end
        end
    end
end))

local old_health, old_ammo = nil, nil
library:connection(run.RenderStepped, LPH_NO_VIRTUALIZE(function(delta)
    if flags["hitdetection_enabled"] then
        if cache.equipped_tool and cache.closest_entity and cache.silentaim_targetting then
            local new_health = cache.closest_entity.Character.Humanoid.Health
            local new_ammo, max_ammo = funcs.get_weapon_ammo()

            if old_health == nil then
                old_health, old_ammo = new_health, new_ammo
                return
            end

            if new_ammo < old_ammo and new_health < old_health and old_ammo ~= 0 then
                local part_hit = cache.closest_entity.Character:FindFirstChild(getgenv().aether.silent_aim.part.value)
                local damage = old_health - new_health

                if flags["hitscreen_enabled"] then
                    funcs.hit_overlay()
                end

                if flags["indicator_enabled"] then
                    local tool_name = cache.equipped_tool.Name

                    if tool_name == "[Double-Barrel SG]" or tool_name == "[TacticalShotgun]" or tool_name == "[Shotgun]" then
                        local split_damage = damage / 5

                        for i = 1, 5 do
                            if flags["indicator_type"] == "Fortnite" then
                                funcs.hit_indicator(part_hit, split_damage)
                            else
                                funcs.hit_indicator_pf(part_hit, split_damage)
                            end
                        end
                    else
                        if flags["indicator_type"] == "Fortnite" then
                            funcs.hit_indicator(part_hit, damage)
                        else
                            funcs.hit_indicator_pf(part_hit, damage)
                        end
                    end
                end

                if flags["hit_effects"] then
                    hit_effect_module:Play(cache.closest_entity.Character)
                end

                if flags["hitlogs_enabled"] then
                    local distance = funcs.get_distance(part_hit)

                    local default_template = '<font color="%s">[Aether]</font> Hit %s for %d damage at %s (%.2f studs) with %s Ammo remaining: [%d/%d]'

                    local template = default_template

                    if flags["customhitlog_enabled"] and flags["hitlog_format"] and flags["hitlog_format"] ~= "" then
                        template = flags["hitlog_format"]
                    end

                    local message = template
                        :gsub("{player}", cache.closest_entity.Name)
                        :gsub("{damage}", tostring(math.round(damage)))
                        :gsub("{hitpart}", part_hit and part_hit.Name or "Unknown")
                        :gsub("{distance}", string.format("%.2f", distance))
                        :gsub("{weapon}", cache.equipped_tool.Name)
                        :gsub("{ammo}", tostring(new_ammo))
                        :gsub("{maxammo}", tostring(max_ammo))
                        :format(
                            accent_color,
                            cache.closest_entity.Name,
                            damage,
                            part_hit and part_hit.Name or "Unknown",
                            distance,
                            cache.equipped_tool.Name,
                            new_ammo,
                            max_ammo
                        )

                    library:notification({
                        text = message,
                        time = flags["notification_duration"]
                    })
                end
            end

            old_health, old_ammo = new_health, new_ammo
        end
    end
end))

local mt = getrawmetatable(game)
setreadonly(mt, false)

local oldNamecall = mt.__namecall

if game.PlaceId == 2788229376 then
    mt.__namecall = LPH_NO_VIRTUALIZE(function(self, ...)
        local args = {...}
        local method = getnamecallmethod()

        if method == "FireServer" and tostring(self) == "MainEvent" and getgenv().aether.silent_aim.enabled and getgenv().aether.silent_aim.manipulation and cache.closest_entity and cache.silentaim_targetting and cache.closest_entity.Character then
            if args[1] == "ShootGun" then
                local target = cache.closest_entity
                local head = target.Character.Head

                if flags["desync_enabled"] and cache.desync_active then
                    args[3] = desync_position.Position
                    args[4] = head.Position
                    args[5] = head
                    args[6] = (head.Position - desync_position.Position).Unit
                else
                    args[4] = cache.closest_entity.Character.Head.Position
                    args[5] = cache.closest_entity.Character.Head
                end

                return oldNamecall(self, unpack(args))
            end
        end

        return oldNamecall(self, ...)
    end)
elseif game.PlaceId == 9825515356 or game.PlaceId == 138995385694035 then
    mt.__namecall = LPH_NO_VIRTUALIZE(function(self, ...)
        local args = {...}
        local method = getnamecallmethod()

        if method == "FireServer" and tostring(self) == "MainEvent" and getgenv().aether.silent_aim.enabled and getgenv().aether.silent_aim.manipulation and cache.closest_entity and cache.silentaim_targetting and cache.closest_entity.Character then
            if args[1] == "Shoot" then
                local targetHead = cache.closest_entity.Character.Head
                local myHRP = local_entity.Character.HumanoidRootPart
                local pos = targetHead.Position
                local normal = Vector3.new(0, 0, 1)

                local hitData = {}
                for i = 1, 5 do
                    hitData[i] = {
                        Normal = normal,
                        Instance = targetHead,
                        Position = pos
                    }
                end

                local offsetData = {}
                for i = 1, 5 do
                    offsetData[i] = {
                        thePart = targetHead,
                        theOffset = Vector3.new(0, 0, 0)
                    }
                end

                if flags["desync_enabled"] and cache.desync_active then
                    args[2] = {
                        hitData,
                        offsetData,
                        desync_position.Position, 
                        desync_position.Position, 
                        cache.workspace_time
                    }
                else
                    args[2] = {
                        hitData,
                        offsetData,
                        myHRP.Position, 
                        myHRP.Position, 
                        cache.workspace_time
                    }
                end
                
                return oldNamecall(self, unpack(args))
            end
        end

        return oldNamecall(self, ...)
    end)
elseif game.PlaceId == 80642675525385 or game.PlaceId == 134615159971944 or game.PlaceId == 102607333382652 or game.PlaceId == 71413224132533 or game.PlaceId == 104092029456473 or game.PlaceId == 85375174665869 then
    mt.__namecall = LPH_NO_VIRTUALIZE(function(self, ...)
        local args = {...}
        local method = getnamecallmethod()

        if method == "FireServer" and tostring(self) == "MainRemoteEvent" and getgenv().aether.silent_aim.enabled then
            if getgenv().aether.silent_aim.manipulation and cache.closest_entity and cache.silentaim_targetting and cache.closest_entity.Character and args[1] == "ShootGun" then
                if type(args[4]) == "table" then
                    for i, boolets in ipairs(args[4]) do
                        boolets.AimPosition = cache.closest_entity.Character.Head.Position
                        boolets.Result1 = cache.closest_entity.Character.Head.Position
                        boolets.Result2 = cache.closest_entity.Character.Head 
                        boolets.Result3 = Vector3.new(0,0,1) 
                    end
                else
                    args[5] = cache.closest_entity.Character.Head.Position
                    args[6] = cache.closest_entity.Character.Head
                end

                args[8] = math.huge

                return oldNamecall(self, unpack(args))
            end

            if args[1] == "Z3eHooDMSOUEPoS233^+" then
                args[2] = cache.mouse_hit.Position
                return oldNamecall(self, unpack(args))
            end
        end

        return oldNamecall(self, ...)
    end)
elseif game.PlaceId == 75159825516372 or game.PlaceId == 90724401598574 then
    mt.__namecall = LPH_NO_VIRTUALIZE(function(self, ...)
        local args = {...}
        local method = getnamecallmethod()

        if method == "FireServer" and tostring(self) == "Shoot" and getgenv().aether.silent_aim.enabled and getgenv().aether.silent_aim.manipulation and cache.closest_entity and cache.silentaim_targetting and cache.closest_entity.Character then
            if type(args[1]) == "table" then
                if type(args[1][1]) == "table" and type(args[1][1][5]) == "table" then
                    for _, pellet in ipairs(args[1][1][5]) do
                        if type(pellet) ~= "table" then continue end
                        if pellet[1] and type(pellet[1]) == "table" then
                            pellet[1] = {cache.closest_entity.Character.Head.Position.X, cache.closest_entity.Character.Head.Position.Y, cache.closest_entity.Character.Head.Position.Z}
                        elseif pellet[2] and type(pellet[2]) == "table" then
                            pellet[2] = {cache.closest_entity.Character.Head.Position.X, cache.closest_entity.Character.Head.Position.Y, cache.closest_entity.Character.Head.Position.Z}
                        end
                        pellet[3] = cache.closest_entity.Character.Head
                        pellet[4] = cache.closest_entity
                    end
                elseif type(args[1][5]) == "table" then
                    for _, pellet in ipairs(args[1][5]) do
                        if type(pellet) ~= "table" then continue end
                        if pellet[1] and type(pellet[1]) == "table" then
                            pellet[1] = {cache.closest_entity.Character.Head.Position.X, cache.closest_entity.Character.Head.Position.Y, cache.closest_entity.Character.Head.Position.Z}
                        elseif pellet[2] and type(pellet[2]) == "table" then
                            pellet[2] = {cache.closest_entity.Character.Head.Position.X, cache.closest_entity.Character.Head.Position.Y, cache.closest_entity.Character.Head.Position.Z}
                        end
                        pellet[3] = cache.closest_entity.Character.Head
                        pellet[4] = cache.closest_entity
                    end
                elseif type(args[1][5]) == "table" then
                    if type(args[1][5][3]) == "table" or args[1][5][3] == nil then
                        args[1][5][3] = cache.closest_entity.Character.Head
                        args[1][5][4] = cache.closest_entity
                    end
                end
            end

            return oldNamecall(self, unpack(args))
        end

        return oldNamecall(self, ...)
    end)
end

local nettspend_ud_nigga = nil
nettspend_ud_nigga = hookmetamethod(game, "__index", LPH_NO_VIRTUALIZE(function(self, index)
    if not checkcaller() and self == mouse and getgenv().aether.silent_aim.enabled and cache.closest_entity and cache.silentaim_targetting and cache.equipped_tool then
        if index == ("Hit") then
            local end_point = funcs.get_cframe(cache.closest_entity)
            if end_point then
                return end_point
            end
        elseif index == ("Target") and cache.closest_entity.Character:FindFirstChild(getgenv().aether.silent_aim.part.value) and cache.silentaim_targetting then 
            return cache.closest_entity.Character[getgenv().aether.silent_aim.part.value] 
        end
    end
    return nettspend_ud_nigga(self, index)
end))

create_esp = function()
    local G2L = {}

    G2L["2"] = Instance.new("Frame", screen_gui)
    G2L["2"].BorderSizePixel = 0
    G2L["2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    G2L["2"].Size = UDim2.new(0, 218, 0, 356)
    G2L["2"].Position = UDim2.new(0.41515, 0, 0.19849, 0)
    G2L["2"].BackgroundTransparency = 1
    G2L["2"].Name = tostring(funcs.generate_string(12)) 
    G2L["2"].ZIndex = 3
    G2L["2"].Visible = false
    G2L["2"].BorderMode = Enum.BorderMode.Middle

    G2L["b"] = Instance.new("Frame", screen_gui)
    G2L["b"].BorderSizePixel = 0
    G2L["b"].BackgroundColor3 = Color3.fromRGB(115, 255, 72)
    G2L["b"].Size = UDim2.new(0, 220, 0, 358)
    G2L["b"].Position = UDim2.new(0, 2, 0, 2)
    G2L["b"].BackgroundTransparency = 1
    G2L["b"].Name = tostring(funcs.generate_string(12)) -- outline
    G2L["b"].Visible = false

    G2L["Glow"] = Instance.new("ImageLabel", G2L["b"])
    G2L["Glow"].Parent = G2L["b"]
    G2L["Glow"].Name = tostring(funcs.generate_string(12))
    G2L["Glow"].BackgroundTransparency = 1
    G2L["Glow"].Image = "http://www.roblox.com/asset/?id=18245826428"
    G2L["Glow"].ImageColor3 = Color3.fromRGB(255, 255, 255) 
    G2L["Glow"].ImageTransparency = flags["boxglow_opacity"]
    G2L["Glow"].ScaleType = Enum.ScaleType.Slice
    G2L["Glow"].SliceCenter = Rect.new(21, 21, 79, 79)
    G2L["Glow"].Position = UDim2.new(0.5, 0, 0.5, 0)
    G2L["Glow"].Size = UDim2.new(1, 40, 1, 40)
    G2L["Glow"].ZIndex = 2
    G2L["Glow"].Visible = false
    G2L["Glow"].AnchorPoint = Vector2.new(0.5, 0.5)

    G2L["GlowGradient"] = Instance.new("UIGradient", G2L["Glow"])
    G2L["GlowGradient"].Rotation = 90
    G2L["GlowGradient"].Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.000, Color3.fromRGB(0, 255, 128)),
        ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 128, 255))
    }

    G2L["FilledBox"] = Instance.new("Frame", G2L["b"])
    G2L["FilledBox"].Parent = G2L["b"]
    G2L["FilledBox"].BorderSizePixel = 0
    G2L["FilledBox"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    -- Use Scale 1,1 and a slight offset to "overfill" by 1 pixel if needed
    G2L["FilledBox"].Size = UDim2.new(1, 0, 1, 0) 
    G2L["FilledBox"].Position = UDim2.new(0, 0, 0, 0)
    G2L["FilledBox"].Name = "Fill"
    G2L["FilledBox"].Visible = false
    G2L["FilledBox"].BackgroundTransparency = 0.6

    G2L["FilledGradient"] = Instance.new("UIGradient", G2L["FilledBox"])
    G2L["FilledGradient"].Rotation = 90
    G2L["FilledGradient"].Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.000, Color3.fromRGB(0, 255, 128)),
        ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 128, 255))
    }

    G2L["5"] = Instance.new("Frame", G2L["2"])
    G2L["5"].BorderSizePixel = 0
    G2L["5"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    G2L["5"].Size = UDim2.new(0, 2, 0, 357)
    G2L["5"].Position = UDim2.new(-0.03604, 0, 0, 0)
    G2L["5"].Name = tostring(funcs.generate_string(12)) -- health bar
    G2L["5"].Visible = false
    
    G2L["6"] = Instance.new("UIGradient", G2L["5"])
    G2L["6"]["Rotation"] = 90;
    G2L["6"].Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0.000, 0.2),
        NumberSequenceKeypoint.new(1.000, 0.2)
    }
    G2L["6"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(88, 255, 58)),ColorSequenceKeypoint.new(0.509, Color3.fromRGB(255, 184, 0)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(255, 0, 0))};

    G2L["7"] = Instance.new("UIStroke", G2L["5"])

    G2L["c"] = Instance.new("UIStroke", G2L["b"])
    G2L["c"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    G2L["c"].Color = Color3.fromRGB(255, 255, 255)

    G2L["d"] = Instance.new("Frame", G2L["b"])
    G2L["d"].BorderSizePixel = 0
    G2L["d"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    G2L["d"].Size = UDim2.new(0, 218, 0, 356)
    G2L["d"].Position = UDim2.new(0, 1, 0, 1)
    G2L["d"].BackgroundTransparency = 1
    G2L["d"].Name = tostring(funcs.generate_string(12)) -- inline
    G2L["d"].Visible = false

    G2L["e"] = Instance.new("UIStroke", G2L["d"])
    G2L["e"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    G2L["e"].Color = Color3.fromRGB(0, 0, 0)

    G2L["ABC"] = Instance.new("Frame", G2L["b"])
    G2L["ABC"].BorderSizePixel = 0
    G2L["ABC"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    G2L["ABC"].Size = UDim2.new(0, 218, 0, 356)
    G2L["ABC"].Position = UDim2.new(0, 1, 0, 1)
    G2L["ABC"].BackgroundTransparency = 1
    G2L["ABC"].Name = tostring(funcs.generate_string(12)) -- inline
    G2L["ABC"].Visible = false

    G2L["ABC2"] = Instance.new("UIStroke", G2L["ABC"])
    G2L["ABC2"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    G2L["ABC2"].Color = Color3.fromRGB(0, 0, 0)

    G2L["DisplayName"] = Instance.new("TextLabel", screen_gui)
    G2L["DisplayName"].Size = UDim2.new(0, 100, 0, 20)
    G2L["DisplayName"].BackgroundTransparency = 1
    G2L["DisplayName"].TextColor3 = Color3.fromRGB(255, 255, 255)
    G2L["DisplayName"].Text = ""
    G2L["DisplayName"].Name = tostring(funcs.generate_string(12)) 
    G2L["DisplayName"].FontFace = library.font
    G2L["DisplayName"].TextSize = 12
    G2L["DisplayName"].TextScaled = false

    G2L["DisplayName_Outline"] = Instance.new("UIStroke", G2L["DisplayName"])
    G2L["DisplayName_Outline"].Color = Color3.fromRGB(0, 0, 0)
    G2L["DisplayName_Outline"].Thickness = 1

    G2L["State"] = Instance.new("TextLabel", screen_gui)
    G2L["State"].Size = UDim2.new(0, 100, 0, 20)
    G2L["State"].BackgroundTransparency = 1
    G2L["State"].TextColor3 = Color3.fromRGB(255, 255, 255)
    G2L["State"].Text = ""
    G2L["State"].Name = tostring(funcs.generate_string(12)) 
    G2L["State"].FontFace = library.font
    G2L["State"].TextSize = 12
    G2L["State"].TextScaled = false
    G2L["State"].TextXAlignment = Enum.TextXAlignment.Left
    G2L["State"].TextYAlignment = Enum.TextYAlignment.Top
    G2L["State"].AnchorPoint = Vector2.new(0, 0.2)

    G2L["State_Outline"] = Instance.new("UIStroke", G2L["State"])
    G2L["State_Outline"].Color = Color3.fromRGB(0, 0, 0)
    G2L["State_Outline"].Thickness = 1

    G2L["Team"] = Instance.new("TextLabel", screen_gui)
    G2L["Team"].Size = UDim2.new(0, 100, 0, 20)
    G2L["Team"].BackgroundTransparency = 1
    G2L["Team"].TextColor3 = Color3.fromRGB(255, 255, 255)
    G2L["Team"].Text = ""
    G2L["Team"].Name = tostring(funcs.generate_string(12)) 
    G2L["Team"].FontFace = library.font
    G2L["Team"].TextSize = 12
    G2L["Team"].TextScaled = false
    G2L["Team"].TextXAlignment = Enum.TextXAlignment.Left
    G2L["Team"].TextYAlignment = Enum.TextYAlignment.Top
    G2L["Team"].AnchorPoint = Vector2.new(0, 0.2)

    G2L["Team_Outline"] = Instance.new("UIStroke", G2L["Team"])
    G2L["Team_Outline"].Color = Color3.fromRGB(0, 0, 0)
    G2L["Team_Outline"].Thickness = 1

    G2L["Tool"] = Instance.new("TextLabel", screen_gui)
    G2L["Tool"].AnchorPoint = Vector2.new(0.5, 0)
    G2L["Tool"].Size = UDim2.new(0, 100, 0, 20)
    G2L["Tool"].BackgroundTransparency = 1
    G2L["Tool"].TextColor3 = Color3.fromRGB(255, 255, 255)
    G2L["Tool"].TextScaled = false 
    G2L["Tool"].Text = "" 
    G2L["Tool"].Name = tostring(funcs.generate_string(12)) 
    G2L["Tool"].FontFace = library.font
    G2L["Tool"].TextSize = 12

    G2L["Tool_Outline"] = Instance.new("UIStroke", G2L["Tool"])
    G2L["Tool_Outline"].Color = Color3.fromRGB(0, 0, 0)
    G2L["Tool_Outline"].Thickness = 1

    G2L["Studs"] = Instance.new("TextLabel", screen_gui)
    G2L["Studs"].Size = UDim2.new(0, 100, 0, 20)
    G2L["Studs"].BackgroundTransparency = 1
    G2L["Studs"].TextColor3 = Color3.fromRGB(255, 255, 255)
    G2L["Studs"].TextScaled = false
    G2L["Studs"].Text = ""
    G2L["Studs"].TextSize = 12
    G2L["Studs"].Name = tostring(funcs.generate_string(12)) 
    G2L["Studs"].FontFace = library.font

    G2L["Studs_Outline"] = Instance.new("UIStroke", G2L["Studs"])
    G2L["Studs_Outline"].Color = Color3.fromRGB(0, 0, 0)
    G2L["Studs_Outline"].Thickness = 1

    G2L["Armorbar"] = Instance.new("Frame", G2L["2"])
    G2L["Armorbar"].BorderSizePixel = 0
    G2L["Armorbar"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    G2L["Armorbar"].Size = UDim2.new(0, 2, 0, 357)
    G2L["Armorbar"].Position = UDim2.new(-0.03604, 0, 0, 0)
    G2L["Armorbar"].Name = tostring(funcs.generate_string(12)) -- Armor bar
    G2L["Armorbar"].Visible = false
    
    G2L["ArmorGradient"] = Instance.new("UIGradient", G2L["Armorbar"])
    G2L["ArmorGradient"]["Rotation"] = 90;
    G2L["ArmorGradient"].Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0.000, 0.2),
        NumberSequenceKeypoint.new(1.000, 0.2)
    }
    G2L["ArmorGradient"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(88, 255, 58)),ColorSequenceKeypoint.new(0.509, Color3.fromRGB(255, 184, 0)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(255, 0, 0))};
    G2L["UIStrokeArmor"] = Instance.new("UIStroke", G2L["Armorbar"])

    G2L["f"] = Instance.new("ImageLabel", G2L["2"])
    G2L["f"]["Size"] = UDim2.new(0, 50, 0, 50)
    G2L["f"]["Position"] = UDim2.new(0.5, -25, 1, 45)
   -- G2L["f"]["Image"] = GetImageFromIndex(1)
    G2L["f"]["BackgroundTransparency"] = 1
    G2L["f"]["Name"] = tostring(funcs.generate_string(12)) 
    G2L["f"]["ImageTransparency"] = 0
    G2L["f"]["ImageColor3"] = Color3.new(255, 255, 255)
    G2L["f"]["ScaleType"] = Enum.ScaleType.Fit

    G2L["Highlight"] = Instance.new("Highlight")

    return G2L
end
    
funcs.initialize_esp = function()
    if not flags["esp_enabled"] then return end

    for _, player in ipairs(entities:GetPlayers()) do
        if player ~= local_entity then
            local hrp = player.Character and player.Character:FindFirstChild('HumanoidRootPart')
            local UpperTorso = player.Character and player.Character:FindFirstChild('UpperTorso')
            local humanoid = player.Character and player.Character:FindFirstChild('Humanoid')
            local BodyEffects = player.Character and player.Character:FindFirstChild('BodyEffects')
            local gui = esp_cache[player.UserId]

            if hrp and gui and humanoid then
                local ScreenPos, onScreen = camera:WorldToScreenPoint(hrp.Position)
                local isKO = BodyEffects and BodyEffects:FindFirstChild("K.O") and BodyEffects["K.O"].Value

                if onScreen then
                    gui["2"].Visible = flags["box_enabled"]
                    gui["b"].Visible = flags["box_enabled"]
                    gui["ABC"].Visible = flags["box_enabled"]
                    gui["d"].Visible = flags["box_enabled"]
                    gui["DisplayName"].Visible = flags["name_enabled"]
                    gui["Tool"].Visible = flags["tool_enabled"]
                    gui["State"].Visible = flags["state_enabled"]
                    gui["Team"].Visible = flags["team_enabled"]
                    gui["Studs"].Visible = flags["distance_enabled"]
                    gui["5"].Visible = flags["healthbar_enabled"]
                    gui["f"].Visible = true
                    gui["Glow"].Visible = flags["box_enabled"] and flags["boxglow_enabled"]
                    gui["FilledBox"].Visible = flags["boxfill_enabled"]

                    if flags["box_enabled"] and flags["boxglow_enabled"] then
                        gui["Glow"].ImageTransparency = flags["boxglow_opacity"]
                        gui["GlowGradient"].Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0.000, flags["boxglow_color1"].Color),
                            ColorSequenceKeypoint.new(0.499, flags["boxglow_color2"].Color),
                            ColorSequenceKeypoint.new(1.000, flags["boxglow_color3"].Color)
                        }
                        gui["GlowGradient"].Rotation = flags["boxglow_rotate"] and (gui["GlowGradient"].Rotation + 0.65) or 90
                    end

                    if flags["chams_enabled"] then
                        gui["Highlight"].Parent = player.Character
                        gui["Highlight"].FillColor = flags["fill_color"].Color
                        gui["Highlight"].OutlineColor = flags["outline_color"].Color
                        gui["Highlight"].FillTransparency = flags["chams_fill_transparency"]
                        gui["Highlight"].OutlineTransparency = flags["chams_outline_transparency"]

                        if flags["chams_visiblecheck"] then
                            gui["Highlight"].DepthMode = Enum.HighlightDepthMode.Occluded
                        else
                            gui["Highlight"].DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        end
                    else
                        if gui["Highlight"].Parent then
                            gui["Highlight"].Parent = nil
                        end
                    end

                    local health = humanoid.Health / humanoid.MaxHealth
                    local size = (camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3.2, 0)).Y - camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 2.3, 0)).Y) / 2
                    local box_size = Vector2.new(math.round(size * 1.11), math.round(size * 1.9))
                    
                    local box_pos
                    if isKO and UpperTorso then
                        local utpos, OnScreen = camera:WorldToScreenPoint(UpperTorso.Position)
                        if OnScreen then
                            box_pos = Vector2.new(math.round(utpos.X - box_size.X / 2), math.round(utpos.Y - box_size.Y / 2))
                        else
                            box_pos = Vector2.new(math.round(ScreenPos.X - box_size.X / 2), math.round(ScreenPos.Y - box_size.Y / 2))
                        end
                    else
                        box_pos = Vector2.new(math.round(ScreenPos.X - box_size.X / 2), math.round(ScreenPos.Y - box_size.Y / 2 + box_size.Y * 0.067))
                    end

                    if flags["box_enabled"] then
                        gui["2"].Size = UDim2.new(0, box_size.X, 0, box_size.Y)
                        gui["2"].Position = UDim2.new(0, box_pos.X, 0, box_pos.Y)

                        gui["b"].Size = UDim2.new(0, box_size.X + 2, 0, box_size.Y + 2)
                        gui["b"].Position = UDim2.new(0, box_pos.X - 2, 0, box_pos.Y - 2)
                        gui["d"].Size = UDim2.new(0, gui["b"].Size.X.Offset - 2, 0, gui["b"].Size.Y.Offset - 2)
                        gui["d"].Position = UDim2.new(0, 1, 0, 1)
                        gui["ABC"].Size = UDim2.new(0, gui["b"].Size.X.Offset + 2, 0, gui["b"].Size.Y.Offset + 2)
                        gui["ABC"].Position = UDim2.new(0, -1, 0, -1)
                    end

                    if flags["state_enabled"] then
                        gui["State"].TextColor3 = flags["state_color"].Color
                        if gui["State"].Text ~= funcs.get_flag(player) then
                            gui["State"].Text = funcs.get_flag(player)
                        end

                        gui["Team"].Position = UDim2.new(
                            0,
                            box_pos.X + box_size.X + 4,
                            0,
                            box_pos.Y + gui["State"].TextSize + 1.5
                        )

                        gui["State"].Position = UDim2.new(
                            0, 
                            box_pos.X + box_size.X + 4, 
                            0, 
                            box_pos.Y
                        )
                    else
                        gui["Team"].Position = UDim2.new(
                            0, 
                            box_pos.X + box_size.X + 4, 
                            0, 
                            box_pos.Y
                        )
                    end

                    if flags["team_enabled"] then
                        local team_name = player.Team and player.Team.Name or "No Team"

                        if gui["Team"].Text ~= team_name then
                            gui["Team"].Text = team_name
                        end

                        if flags["useteamcolor_enabled"] then
                            if player.Team and player.TeamColor then
                                gui["Team"].TextColor3 = player.TeamColor.Color
                            else
                                gui["Team"].TextColor3 = Color3.fromRGB(255,255,255)
                            end
                        else
                            gui["Team"].TextColor3 = Color3.fromRGB(255,255,255)
                        end
                    end

                    local HBH = box_size.Y * health
                    if BodyEffects and BodyEffects:FindFirstChild("Armor") then
                        local armor = BodyEffects.Armor.Value / 200
                        local positionshi = box_size.Y * armor

                        gui["Armorbar"].Size = UDim2.new(0, 1.9, 0, positionshi)
                        gui["Armorbar"].Position = UDim2.new(0, -9, 0, box_size.Y - positionshi)
                        gui["Armorbar"].Visible = flags["armorbar_enabled"]
                    else
                        gui["Armorbar"].Visible = false
                    end

                    gui["5"].AnchorPoint = Vector2.new(0, 1)
                    gui["5"].Size = UDim2.new(0, 1.9, health, 2.5)
                    gui["5"].Position = UDim2.new(0, -7.6, 1, 0)
                    
                    local healthgradient = ColorSequence.new{
                        ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255 * (1 - health), 255 * health, 0)),
                        ColorSequenceKeypoint.new(0.509, Color3.fromRGB(255, 184 * health, 0)), 
                        ColorSequenceKeypoint.new(1.000, Color3.fromRGB(255, 0, 0))
                    }
                    local armorgradient = ColorSequence.new{
                        ColorSequenceKeypoint.new(0.000, flags["armorbar_color1"].Color),
                        ColorSequenceKeypoint.new(0.509, flags["armorbar_color2"].Color), 
                        ColorSequenceKeypoint.new(1.000, flags["armorbar_color3"].Color)
                    }

                    gui["6"].Color = healthgradient
                    gui["ArmorGradient"].Color = armorgradient

                    if flags["name_enabled"] then
                        gui["DisplayName"].Position = UDim2.new(0, box_pos.X + box_size.X / 2 - 50, 0, box_pos.Y - (gui["DisplayName"].TextSize + 11))
                        gui["DisplayName"].TextColor3 = flags["name_color"].Color

                        if flags["name_type"] == "Name (DisplayName)" then
                            gui["DisplayName"].Text = string.format("%s", player.Name .. " ("..player.DisplayName..")")
                        elseif flags["name_type"] == "DisplayName (Name)" then
                            gui["DisplayName"].Text = string.format("%s", player.DisplayName .. " ("..player.Name..")")
                        elseif flags["name_type"] == "Name" then
                            gui["DisplayName"].Text = string.format("%s", player.Name)
                        elseif flags["name_type"] == "DisplayName" then
                            gui["DisplayName"].Text = string.format("%s", player.DisplayName)
                        end
                    end

                    if flags["tool_enabled"] then
                        local tool = player.Character:FindFirstChildOfClass("Tool")

                        gui["Tool"].TextColor3 = flags["tool_color"].Color
                        gui["Tool"].Position = UDim2.new(
                            0,
                            box_pos.X + box_size.X / 2,
                            0,
                            box_pos.Y + box_size.Y - offset
                        )
                        if gui["Tool"].Text ~= (tool and tool.Name or "[None]") then
                            gui["Tool"].Text = (tool and tool.Name or "[None]")
                        end
                    end

                    if flags["tool_enabled"] == false and flags["distance_enabled"] == true then
                        gui["Studs"].Position = UDim2.new(0, box_pos.X + box_size.X / 2 - 50, 0, box_pos.Y + box_size.Y)
                    else
                        gui["Studs"].Position = UDim2.new(0, box_pos.X + box_size.X / 2 - 50, 0, box_pos.Y + box_size.Y + font_size - offset)
                    end

                    if flags["distance_enabled"] then
                        local dist = (hrp.Position - local_entity.Character.HumanoidRootPart.Position).magnitude
                        local studs = math.round(dist)

                        gui["Studs"].TextColor3 = flags["distance_color"].Color
                        gui["Studs"].Text = "[".. studs.."m]"
                    end
                    
                    gui["f"].Size = UDim2.new(0, box_size.X * 0.3, 0, box_size.Y * 0.3) 
                    gui["f"].Position = UDim2.new(0.5, -gui["f"].Size.X.Offset / 2, 1, 5)
                
                    gui["FilledBox"].Size = UDim2.new(1, 0, 1, 0)
                    gui["FilledBox"].Position = UDim2.new(0, 0, 0, 0)

                    gui["c"].Color = flags["box_color"].Color
                    gui["FilledGradient"].Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0.000, flags["boxfill_color1"].Color),
                        ColorSequenceKeypoint.new(0.499, flags["boxfill_color2"].Color),
                        ColorSequenceKeypoint.new(1.000, flags["boxfill_color3"].Color)
                    }

                    gui["FilledGradient"].Rotation = flags["boxfill_animate"] and (gui["FilledGradient"].Rotation + 1) or 90
                else
                    gui["2"].Visible = false
                    gui["b"].Visible = false
                    gui["d"].Visible = false
                    gui["ABC"].Visible = false
                    gui["f"].Visible = false
                   -- gui["8"].Visible = false
                    gui["DisplayName"].Visible = false
                    gui["Tool"].Visible = false
                    gui["Studs"].Visible = false
                    gui["Glow"].Visible = false
                    gui["State"].Visible = false
                    gui["Team"].Visible = false
                    gui["Highlight"].Parent = nil
                end
            else
                if gui then
                    gui["2"].Visible = false
                    gui["b"].Visible = false
                    gui["d"].Visible = false
                    gui["f"].Visible = false
                   -- gui["8"].Visible = false
                    gui["DisplayName"].Visible = false
                    gui["Tool"].Visible = false
                    gui["Studs"].Visible = false
                    gui["ABC"].Visible = false
                    gui["FilledBox"].Visible = false
                    gui["Glow"].Visible = false
                    gui["State"].Visible = false
                    gui["Team"].Visible = false
                    gui["Highlight"].Parent = nil
                end
            end
        end
    end
end

entities.PlayerAdded:Connect(LPH_NO_VIRTUALIZE(function(player)
    if flags["esp_enabled"] then
        esp_cache[player.UserId] = create_esp()
        funcs.apply_esp_style(esp_cache[player.UserId])
    end
end))

entities.PlayerRemoving:Connect(LPH_NO_VIRTUALIZE(function(player)
    if esp_cache[player.UserId] then
        for _, element in pairs(esp_cache[player.UserId]) do
            if element and element.Destroy then
                element:Destroy()
            end
        end
        esp_cache[player.UserId] = nil
    end
end))

library:connection(run.RenderStepped, LPH_NO_VIRTUALIZE(function()
    if flags["esp_enabled"] then
        funcs.initialize_esp()
    end
end))
