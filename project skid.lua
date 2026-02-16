-- Project Skid Script
-- Made by yuhzz

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Create Window
local Window = Library:CreateWindow({
    Title = "Project Skid",
    Footer = "Made by yuhzz",
    NotifySide = "Right",
    ShowCustomCursor = true,
})

-- Create Tabs
local Tabs = {
    Combat = Window:AddTab("Combat", "crosshair"),
    Visuals = Window:AddTab("Visuals", "eye"),
    Misc = Window:AddTab("Misc", "settings"),
    ["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}

-- Combat Tab
local AimbotGroup = Tabs.Combat:AddLeftGroupbox("Aimbot", "target")

AimbotGroup:AddToggle("AimbotEnabled", {
    Text = "Enable Aimbot",
    Default = false,
    Tooltip = "Toggle aimbot on/off",
})

AimbotGroup:AddToggle("VisibleCheck", {
    Text = "Visible Check",
    Default = false,
    Tooltip = "Only aim at visible targets",
})

AimbotGroup:AddToggle("StickyAim", {
    Text = "Sticky Aim",
    Default = false,
    Tooltip = "Locks onto a target until they die or go out of range. More legit than snap aiming.",
})

AimbotGroup:AddToggle("ShowSnapLines", {
    Text = "Show Snap Lines",
    Default = false,
    Tooltip = "Shows a line from FOV center to the target you're about to lock onto",
})

AimbotGroup:AddLabel("Snap Line Color"):AddColorPicker("SnapLineColor", {
    Default = Color3.fromRGB(255, 0, 0),
    Title = "Snap Line Color",
})

AimbotGroup:AddSlider("AimbotSmoothness", {
    Text = "Smoothness",
    Default = 5,
    Min = 1,
    Max = 20,
    Rounding = 1,
    Tooltip = "Higher = smoother but slower",
})

AimbotGroup:AddSlider("AimbotDistance", {
    Text = "Max Distance",
    Default = 500,
    Min = 10,
    Max = 1000,
    Rounding = 0,
    Tooltip = "Maximum distance aimbot will lock onto targets",
})

AimbotGroup:AddLabel("Aimbot Key"):AddKeyPicker("AimbotKey", {
    Default = "MB2",
    Mode = "Hold",
    Text = "Aimbot Hold Key",
    Tooltip = "Hold this key to activate aimbot",
})

local FOVGroup = Tabs.Combat:AddRightGroupbox("FOV Circle")

FOVGroup:AddToggle("ShowFOV", {
    Text = "Show FOV Circle",
    Default = true,
    Tooltip = "Display the FOV circle",
})

FOVGroup:AddSlider("FOVSize", {
    Text = "FOV Size",
    Default = 100,
    Min = 50,
    Max = 500,
    Rounding = 0,
})

FOVGroup:AddLabel("FOV Color"):AddColorPicker("FOVColor", {
    Default = Color3.fromRGB(255, 255, 255),
    Title = "FOV Circle Color",
    Transparency = 0.5,
})

FOVGroup:AddLabel("FOV Fill Color"):AddColorPicker("FOVFillColor", {
    Default = Color3.fromRGB(255, 255, 255),
    Title = "FOV Fill Color",
    Transparency = 0.1,
})

-- Visuals Tab - ESP
local PlayerESPGroup = Tabs.Visuals:AddLeftGroupbox("Player ESP")

PlayerESPGroup:AddToggle("ChamsEnabled", {
    Text = "Chams",
    Default = false,
    Tooltip = "Highlight players through walls",
})

PlayerESPGroup:AddLabel("Chams Color"):AddColorPicker("ChamsColor", {
    Default = Color3.fromRGB(255, 0, 0),
    Title = "Chams Color",
    Transparency = 0.5,
})

PlayerESPGroup:AddToggle("TracersEnabled", {
    Text = "Tracers",
    Default = false,
    Tooltip = "Draw lines to players",
})

PlayerESPGroup:AddLabel("Tracer Color"):AddColorPicker("TracerColor", {
    Default = Color3.fromRGB(255, 255, 255),
    Title = "Tracer Color",
})

PlayerESPGroup:AddToggle("BoxEnabled", {
    Text = "Box ESP",
    Default = false,
    Tooltip = "Draw boxes around players",
})

PlayerESPGroup:AddLabel("Box Color"):AddColorPicker("BoxColor", {
    Default = Color3.fromRGB(255, 0, 0),
    Title = "Box Color",
})

PlayerESPGroup:AddToggle("HealthBarEnabled", {
    Text = "Health Bar",
    Default = false,
    Tooltip = "Show health bar with gradient colors",
})

PlayerESPGroup:AddToggle("HealthTextEnabled", {
    Text = "Health Text",
    Default = false,
    Tooltip = "Show health number next to bar",
})

PlayerESPGroup:AddToggle("HeadDotEnabled", {
    Text = "Head Dot",
    Default = false,
    Tooltip = "Show dot on player head",
})

PlayerESPGroup:AddSlider("HeadDotSize", {
    Text = "Head Dot Size",
    Default = 5,
    Min = 3,
    Max = 15,
    Rounding = 0,
    Tooltip = "Size of the head dot",
})

PlayerESPGroup:AddLabel("Head Dot Color"):AddColorPicker("HeadDotColor", {
    Default = Color3.fromRGB(255, 255, 255),
    Title = "Head Dot Color",
})

local InfoESPGroup = Tabs.Visuals:AddRightGroupbox("Info ESP")

InfoESPGroup:AddToggle("DisplayNameEnabled", {
    Text = "Display Name",
    Default = false,
    Tooltip = "Show player display names",
})

InfoESPGroup:AddToggle("UsernameEnabled", {
    Text = "Username",
    Default = false,
    Tooltip = "Show player usernames",
})

InfoESPGroup:AddToggle("DistanceEnabled", {
    Text = "Distance",
    Default = false,
    Tooltip = "Show distance to players",
})

InfoESPGroup:AddToggle("FriendCheck", {
    Text = "Friend Detector",
    Default = false,
    Tooltip = "Highlights friends in green",
})

InfoESPGroup:AddToggle("StaffCheck", {
    Text = "Staff Detector",
    Default = false,
    Tooltip = "Highlights staff/admins in red (checks for badges)",
})

InfoESPGroup:AddLabel("Text Color"):AddColorPicker("TextColor", {
    Default = Color3.fromRGB(255, 255, 255),
    Title = "Text Color",
})

local OtherESPGroup = Tabs.Visuals:AddLeftGroupbox("Other ESP")

OtherESPGroup:AddToggle("ExtractionEnabled", {
    Text = "Extraction Points",
    Default = false,
    Tooltip = "Show extraction points",
})

OtherESPGroup:AddLabel("Extraction Color"):AddColorPicker("ExtractionColor", {
    Default = Color3.fromRGB(255, 255, 0),
    Title = "Extraction Color",
})

OtherESPGroup:AddToggle("NPCEnabled", {
    Text = "NPC ESP",
    Default = false,
    Tooltip = "Show NPCs",
})

OtherESPGroup:AddLabel("NPC Color"):AddColorPicker("NPCColor", {
    Default = Color3.fromRGB(255, 165, 0),
    Title = "NPC Color",
})

local ESPSettingsGroup = Tabs.Visuals:AddRightGroupbox("ESP Settings")

ESPSettingsGroup:AddToggle("VisibleOnly", {
    Text = "Visible Only",
    Default = false,
    Tooltip = "Only show ESP for visible players",
})

ESPSettingsGroup:AddSlider("MaxESPDistance", {
    Text = "Max Render Distance",
    Default = 5000,
    Min = 100,
    Max = 50000,
    Rounding = 0,
    Tooltip = "Maximum distance to render ESP (50000 = whole map)",
})

-- Misc Tab
local CameraGroup = Tabs.Misc:AddLeftGroupbox("Camera Settings")

CameraGroup:AddSlider("FOVChanger", {
    Text = "Field of View",
    Default = 70,
    Min = 70,
    Max = 120,
    Rounding = 0,
    Callback = function(Value)
        if Camera then
            Camera.FieldOfView = Value
        end
    end,
})

local VisualsGroup = Tabs.Misc:AddRightGroupbox("World Visuals")

VisualsGroup:AddToggle("FullBrightEnabled", {
    Text = "Full Bright",
    Default = false,
    Tooltip = "Light up the entire map",
    Callback = function(Value)
        if Value then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        else
            Lighting.Brightness = 1
            Lighting.ClockTime = 12
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = true
            Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
        end
    end,
})

-- UI Settings Tab
local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu")

MenuGroup:AddToggle("KeybindMenuOpen", {
    Default = Library.KeybindFrame.Visible,
    Text = "Open Keybind Menu",
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end,
})

MenuGroup:AddToggle("ShowCustomCursor", {
    Text = "Custom Cursor",
    Default = true,
    Callback = function(Value)
        Library.ShowCustomCursor = Value
    end,
})

MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {
    Default = "RightShift",
    NoUI = true,
    Text = "Menu keybind"
})

MenuGroup:AddButton("Unload", function()
    Library:Unload()
end)

Library.ToggleKeybind = Options.MenuKeybind

-- Setup Theme and Save Managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })

ThemeManager:SetFolder("ProjectSkid")
SaveManager:SetFolder("ProjectSkid/configs")

SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])

-- FOV Circle Drawing
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.NumSides = 64
FOVCircle.Radius = 100
FOVCircle.Filled = false
FOVCircle.Visible = false
FOVCircle.ZIndex = 999
FOVCircle.Transparency = 1
FOVCircle.Color = Color3.new(1, 1, 1)

local FOVFill = Drawing.new("Circle")
FOVFill.Thickness = 1
FOVFill.NumSides = 64
FOVFill.Radius = 100
FOVFill.Filled = true
FOVFill.Visible = false
FOVFill.ZIndex = 998
FOVFill.Transparency = 0.1
FOVFill.Color = Color3.new(1, 1, 1)

-- Snap Line Drawing
local SnapLine = Drawing.new("Line")
SnapLine.Thickness = 2
SnapLine.Color = Color3.new(1, 0, 0)
SnapLine.Visible = false
SnapLine.ZIndex = 1000

-- Update FOV Circle
RunService.RenderStepped:Connect(function()
    if Toggles.ShowFOV and Toggles.ShowFOV.Value then
        local mousePos = UserInputService:GetMouseLocation()
        FOVCircle.Position = mousePos
        FOVCircle.Radius = Options.FOVSize.Value
        FOVCircle.Color = Options.FOVColor.Value
        FOVCircle.Transparency = Options.FOVColor.Transparency
        FOVCircle.Visible = true
        
        FOVFill.Position = mousePos
        FOVFill.Radius = Options.FOVSize.Value
        FOVFill.Color = Options.FOVFillColor.Value
        FOVFill.Transparency = Options.FOVFillColor.Transparency
        FOVFill.Visible = true
    else
        FOVCircle.Visible = false
        FOVFill.Visible = false
    end
end)

-- Visibility Check Function
local function IsVisible(targetPart)
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Head") then
        return false
    end
    
    local origin = LocalPlayer.Character.Head.Position
    local direction = (targetPart.Position - origin).Unit * (targetPart.Position - origin).Magnitude
    
    local ray = Ray.new(origin, direction)
    local hit, position = Workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, targetPart.Parent})
    
    if hit then
        return false
    end
    
    return true
end

-- Health Color Function (Gradient: Green -> Yellow -> Red)
local function GetHealthColor(healthPercent)
    if healthPercent > 0.5 then
        local t = (healthPercent - 0.5) * 2
        return Color3.new(1 - t, 1, 0)
    else
        local t = healthPercent * 2
        return Color3.new(1, t, 0)
    end
end

-- Check if player is staff/admin
local function IsStaff(player)
    local success, result = pcall(function()
        return player:GetRankInGroup(0) >= 254 or player:IsInGroup(0)
    end)
    
    if player.Name:lower():find("admin") or player.Name:lower():find("mod") or player.Name:lower():find("staff") then
        return true
    end
    
    return false
end

-- Sticky Aim System
local stickyTarget = nil
local currentAimbotTarget = nil

-- Aimbot System
local function GetClosestPlayerInFOV()
    if Toggles.StickyAim and Toggles.StickyAim.Value and stickyTarget then
        if stickyTarget.Character and stickyTarget.Character:FindFirstChild("Head") and stickyTarget.Character:FindFirstChild("Humanoid") then
            if stickyTarget.Character.Humanoid.Health > 0 then
                local head = stickyTarget.Character.Head
                local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                
                if onScreen then
                    local mousePos = UserInputService:GetMouseLocation()
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    
                    if distance < Options.FOVSize.Value * 1.5 then
                        return stickyTarget
                    end
                end
            end
        end
        
        stickyTarget = nil
    end
    
    local closestPlayer = nil
    local shortestDistance = math.huge
    local mousePos = UserInputService:GetMouseLocation()
    local fovRadius = Options.FOVSize.Value
    local maxDistance = Options.AimbotDistance.Value
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local worldDistance = (LocalPlayer.Character.HumanoidRootPart.Position - head.Position).Magnitude
                
                if worldDistance <= maxDistance then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                    
                    if onScreen then
                        local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                        
                        if distance < fovRadius and distance < shortestDistance then
                            if Toggles.VisibleCheck and Toggles.VisibleCheck.Value then
                                if IsVisible(head) then
                                    closestPlayer = player
                                    shortestDistance = distance
                                end
                            else
                                closestPlayer = player
                                shortestDistance = distance
                            end
                        end
                    end
                end
            end
        end
    end
    
    if Toggles.StickyAim and Toggles.StickyAim.Value and closestPlayer then
        stickyTarget = closestPlayer
    end
    
    return closestPlayer
end

RunService.RenderStepped:Connect(function()
    local mousePos = UserInputService:GetMouseLocation()
    
    if Toggles.ShowSnapLines and Toggles.ShowSnapLines.Value then
        local target = GetClosestPlayerInFOV()
        
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local head = target.Character.Head
            local headScreenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
            
            if onScreen then
                SnapLine.From = mousePos
                SnapLine.To = Vector2.new(headScreenPos.X, headScreenPos.Y)
                SnapLine.Color = Options.SnapLineColor.Value
                SnapLine.Visible = true
            else
                SnapLine.Visible = false
            end
        else
            SnapLine.Visible = false
        end
    else
        SnapLine.Visible = false
    end
    
    if Toggles.AimbotEnabled and Toggles.AimbotEnabled.Value then
        local aimbotKeyState = Options.AimbotKey:GetState()
        
        if aimbotKeyState then
            local target = GetClosestPlayerInFOV()
            currentAimbotTarget = target
            
            if target and target.Character and target.Character:FindFirstChild("Head") then
                local targetPos = target.Character.Head.Position
                local cameraPos = Camera.CFrame.Position
                local targetCFrame = CFrame.new(cameraPos, targetPos)
                
                local smoothness = Options.AimbotSmoothness.Value
                Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, 1 / smoothness)
            end
        else
            currentAimbotTarget = nil
            if Toggles.StickyAim and Toggles.StickyAim.Value then
                stickyTarget = nil
            end
        end
    else
        currentAimbotTarget = nil
    end
end)

-- ESP Storage
local ESPObjects = {}
local NPCESPObjects = {}
local ExtractionESPObjects = {}

-- Function to create ESP for a player
local function CreateESP(player)
    if ESPObjects[player] then return end
    
    local espData = {
        Player = player,
        Drawings = {},
        Connections = {}
    }
    
    local box = {
        TopLeft = Drawing.new("Line"),
        TopRight = Drawing.new("Line"),
        BottomLeft = Drawing.new("Line"),
        BottomRight = Drawing.new("Line")
    }
    
    for _, line in pairs(box) do
        line.Thickness = 2
        line.Color = Color3.new(1, 0, 0)
        line.Visible = false
    end
    
    espData.Drawings.Box = box
    
    local healthBarBg = Drawing.new("Square")
    healthBarBg.Thickness = 1
    healthBarBg.Filled = true
    healthBarBg.Color = Color3.new(0, 0, 0)
    healthBarBg.Transparency = 0.5
    healthBarBg.Visible = false
    espData.Drawings.HealthBarBg = healthBarBg
    
    local healthBar = Drawing.new("Square")
    healthBar.Thickness = 1
    healthBar.Filled = true
    healthBar.Color = Color3.new(0, 1, 0)
    healthBar.Transparency = 1
    healthBar.Visible = false
    espData.Drawings.HealthBar = healthBar
    
    local healthBarOutline = Drawing.new("Square")
    healthBarOutline.Thickness = 1
    healthBarOutline.Filled = false
    healthBarOutline.Color = Color3.new(0, 0, 0)
    healthBarOutline.Transparency = 1
    healthBarOutline.Visible = false
    espData.Drawings.HealthBarOutline = healthBarOutline
    
    local healthText = Drawing.new("Text")
    healthText.Size = 14
    healthText.Center = false
    healthText.Outline = true
    healthText.Color = Color3.new(1, 1, 1)
    healthText.Visible = false
    espData.Drawings.HealthText = healthText
    
    local tracer = Drawing.new("Line")
    tracer.Thickness = 2
    tracer.Color = Color3.new(1, 1, 1)
    tracer.Visible = false
    espData.Drawings.Tracer = tracer
    
    local text = Drawing.new("Text")
    text.Size = 16
    text.Center = true
    text.Outline = true
    text.Color = Color3.new(1, 1, 1)
    text.Visible = false
    espData.Drawings.Text = text
    
    local headDot = Drawing.new("Circle")
    headDot.Thickness = 1
    headDot.NumSides = 12
    headDot.Radius = 5
    headDot.Filled = true
    headDot.Color = Color3.new(1, 1, 1)
    headDot.Visible = false
    espData.Drawings.HeadDot = headDot
    
    ESPObjects[player] = espData
end

-- Function to remove ESP
local function RemoveESP(player)
    if ESPObjects[player] then
        for _, drawing in pairs(ESPObjects[player].Drawings.Box or {}) do
            drawing:Remove()
        end
        if ESPObjects[player].Drawings.Tracer then
            ESPObjects[player].Drawings.Tracer:Remove()
        end
        if ESPObjects[player].Drawings.Text then
            ESPObjects[player].Drawings.Text:Remove()
        end
        if ESPObjects[player].Drawings.HealthBar then
            ESPObjects[player].Drawings.HealthBar:Remove()
        end
        if ESPObjects[player].Drawings.HealthBarBg then
            ESPObjects[player].Drawings.HealthBarBg:Remove()
        end
        if ESPObjects[player].Drawings.HealthBarOutline then
            ESPObjects[player].Drawings.HealthBarOutline:Remove()
        end
        if ESPObjects[player].Drawings.HealthText then
            ESPObjects[player].Drawings.HealthText:Remove()
        end
        if ESPObjects[player].Drawings.HeadDot then
            ESPObjects[player].Drawings.HeadDot:Remove()
        end
        ESPObjects[player] = nil
    end
end

-- NPC ESP Functions
local function CreateNPCESP(npc)
    if NPCESPObjects[npc] then return end
    
    local espData = {
        NPC = npc,
        Drawings = {}
    }
    
    local box = {
        TopLeft = Drawing.new("Line"),
        TopRight = Drawing.new("Line"),
        BottomLeft = Drawing.new("Line"),
        BottomRight = Drawing.new("Line")
    }
    
    for _, line in pairs(box) do
        line.Thickness = 2
        line.Color = Color3.new(1, 0.647, 0)
        line.Visible = false
    end
    
    espData.Drawings.Box = box
    
    local text = Drawing.new("Text")
    text.Size = 16
    text.Center = true
    text.Outline = true
    text.Color = Color3.new(1, 0.647, 0)
    text.Visible = false
    espData.Drawings.Text = text
    
    NPCESPObjects[npc] = espData
end

local function RemoveNPCESP(npc)
    if NPCESPObjects[npc] then
        for _, drawing in pairs(NPCESPObjects[npc].Drawings.Box or {}) do
            drawing:Remove()
        end
        if NPCESPObjects[npc].Drawings.Text then
            NPCESPObjects[npc].Drawings.Text:Remove()
        end
        NPCESPObjects[npc] = nil
    end
end

-- Extraction Point ESP Functions
local function CreateExtractionESP(extraction)
    if ExtractionESPObjects[extraction] then return end
    
    local espData = {
        Extraction = extraction,
        Drawings = {}
    }
    
    local dot = Drawing.new("Circle")
    dot.Thickness = 1
    dot.NumSides = 12
    dot.Radius = 8
    dot.Filled = true
    dot.Color = Color3.new(1, 1, 0)
    dot.Visible = false
    espData.Drawings.Dot = dot
    
    local text = Drawing.new("Text")
    text.Size = 16
    text.Center = true
    text.Outline = true
    text.Color = Color3.new(1, 1, 0)
    text.Text = "Extraction Point"
    text.Visible = false
    espData.Drawings.Text = text
    
    ExtractionESPObjects[extraction] = espData
end

local function RemoveExtractionESP(extraction)
    if ExtractionESPObjects[extraction] then
        if ExtractionESPObjects[extraction].Drawings.Dot then
            ExtractionESPObjects[extraction].Drawings.Dot:Remove()
        end
        if ExtractionESPObjects[extraction].Drawings.Text then
            ExtractionESPObjects[extraction].Drawings.Text:Remove()
        end
        ExtractionESPObjects[extraction] = nil
    end
end

-- Find NPCs in workspace
local function FindNPCs()
    local npcs = {}
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(obj) then
            table.insert(npcs, obj)
        end
    end
    return npcs
end

-- Find Extraction Points
local function FindExtractionPoints()
    local extractions = {}
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name:lower():find("extract") or obj.Name:lower():find("exit") or obj.Name:lower():find("evac") then
            if obj:IsA("BasePart") or obj:IsA("Model") then
                table.insert(extractions, obj)
            end
        end
    end
    return extractions
end

-- Player Added Event for Chams
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        character:WaitForChild("HumanoidRootPart")
        if Toggles.ChamsEnabled and Toggles.ChamsEnabled.Value then
            if not character:FindFirstChild("ChamHighlight") then
                local highlight = Instance.new("Highlight")
                highlight.Name = "ChamHighlight"
                highlight.Adornee = character
                highlight.FillColor = Options.ChamsColor.Value
                highlight.FillTransparency = Options.ChamsColor.Transparency
                highlight.OutlineTransparency = 1
                highlight.Parent = character
            end
        end
    end)
end)

-- Update ESP
RunService.RenderStepped:Connect(function()
    local maxDistance = Options.MaxESPDistance.Value
    local visibleOnly = Toggles.VisibleOnly and Toggles.VisibleOnly.Value or false
    
    -- Player ESP
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if not ESPObjects[player] then
                CreateESP(player)
            end
            
            local espData = ESPObjects[player]
            local character = player.Character
            
            if character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
                local hrp = character.HumanoidRootPart
                local head = character:FindFirstChild("Head")
                local humanoid = character.Humanoid
                
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                    
                    local isVisible = true
                    if visibleOnly and head then
                        isVisible = IsVisible(head)
                    end
                    
                    if distance <= maxDistance and isVisible then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                        
                        if onScreen then
                            local topPos = (hrp.CFrame * CFrame.new(0, 3, 0)).Position
                            local bottomPos = (hrp.CFrame * CFrame.new(0, -3, 0)).Position
                            
                            local topScreenPos = Camera:WorldToViewportPoint(topPos)
                            local bottomScreenPos = Camera:WorldToViewportPoint(bottomPos)
                            
                            local height = (Vector2.new(topScreenPos.X, topScreenPos.Y) - Vector2.new(bottomScreenPos.X, bottomScreenPos.Y)).Magnitude
                            local width = height / 2
                            
                            local boxColor = Options.BoxColor.Value
                            local isFriend = false
                            local isStaff = false
                            
                            if Toggles.FriendCheck and Toggles.FriendCheck.Value then
                                if LocalPlayer:IsFriendsWith(player.UserId) then
                                    boxColor = Color3.fromRGB(0, 255, 0)
                                    isFriend = true
                                end
                            end
                            
                            if Toggles.StaffCheck and Toggles.StaffCheck.Value then
                                if IsStaff(player) then
                                    boxColor = Color3.fromRGB(255, 0, 0)
                                    isStaff = true
                                end
                            end
                            
                            if Toggles.BoxEnabled and Toggles.BoxEnabled.Value then
                                local box = espData.Drawings.Box
                                
                                box.TopLeft.From = Vector2.new(topScreenPos.X - width/2, topScreenPos.Y)
                                box.TopLeft.To = Vector2.new(topScreenPos.X - width/2, topScreenPos.Y + height)
                                box.TopLeft.Color = boxColor
                                box.TopLeft.Visible = true
                                
                                box.TopRight.From = Vector2.new(topScreenPos.X + width/2, topScreenPos.Y)
                                box.TopRight.To = Vector2.new(topScreenPos.X + width/2, topScreenPos.Y + height)
                                box.TopRight.Color = boxColor
                                box.TopRight.Visible = true
                                
                                box.BottomLeft.From = Vector2.new(topScreenPos.X - width/2, topScreenPos.Y)
                                box.BottomLeft.To = Vector2.new(topScreenPos.X + width/2, topScreenPos.Y)
                                box.BottomLeft.Color = boxColor
                                box.BottomLeft.Visible = true
                                
                                box.BottomRight.From = Vector2.new(topScreenPos.X - width/2, topScreenPos.Y + height)
                                box.BottomRight.To = Vector2.new(topScreenPos.X + width/2, topScreenPos.Y + height)
                                box.BottomRight.Color = boxColor
                                box.BottomRight.Visible = true
                            else
                                for _, line in pairs(espData.Drawings.Box) do
                                    line.Visible = false
                                end
                            end
                            
                            if Toggles.HealthBarEnabled and Toggles.HealthBarEnabled.Value then
                                local healthPercent = humanoid.Health / humanoid.MaxHealth
                                local barHeight = height
                                local barWidth = 4
                                local barX = topScreenPos.X - width/2 - 8
                                local barY = topScreenPos.Y
                                
                                espData.Drawings.HealthBarBg.Size = Vector2.new(barWidth, barHeight)
                                espData.Drawings.HealthBarBg.Position = Vector2.new(barX, barY)
                                espData.Drawings.HealthBarBg.Visible = true
                                
                                local healthColor = GetHealthColor(healthPercent)
                                espData.Drawings.HealthBar.Size = Vector2.new(barWidth, barHeight * healthPercent)
                                espData.Drawings.HealthBar.Position = Vector2.new(barX, barY + barHeight * (1 - healthPercent))
                                espData.Drawings.HealthBar.Color = healthColor
                                espData.Drawings.HealthBar.Visible = true
                                
                                espData.Drawings.HealthBarOutline.Size = Vector2.new(barWidth, barHeight)
                                espData.Drawings.HealthBarOutline.Position = Vector2.new(barX, barY)
                                espData.Drawings.HealthBarOutline.Visible = true
                                
                                if Toggles.HealthTextEnabled and Toggles.HealthTextEnabled.Value then
                                    espData.Drawings.HealthText.Text = tostring(math.floor(humanoid.Health))
                                    espData.Drawings.HealthText.Position = Vector2.new(barX + barWidth + 3, barY + barHeight * (1 - healthPercent) - 7)
                                    espData.Drawings.HealthText.Color = healthColor
                                    espData.Drawings.HealthText.Visible = true
                                else
                                    espData.Drawings.HealthText.Visible = false
                                end
                            else
                                espData.Drawings.HealthBar.Visible = false
                                espData.Drawings.HealthBarBg.Visible = false
                                espData.Drawings.HealthBarOutline.Visible = false
                                espData.Drawings.HealthText.Visible = false
                            end
                            
                            if Toggles.HeadDotEnabled and Toggles.HeadDotEnabled.Value and head then
                                local headScreenPos, headOnScreen = Camera:WorldToViewportPoint(head.Position)
                                if headOnScreen then
                                    espData.Drawings.HeadDot.Position = Vector2.new(headScreenPos.X, headScreenPos.Y)
                                    espData.Drawings.HeadDot.Color = Options.HeadDotColor.Value
                                    espData.Drawings.HeadDot.Radius = Options.HeadDotSize.Value
                                    espData.Drawings.HeadDot.Visible = true
                                else
                                    espData.Drawings.HeadDot.Visible = false
                                end
                            else
                                espData.Drawings.HeadDot.Visible = false
                            end
                            
                            if Toggles.TracersEnabled and Toggles.TracersEnabled.Value then
                                local tracer = espData.Drawings.Tracer
                                tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                                tracer.To = Vector2.new(screenPos.X, screenPos.Y)
                                tracer.Color = Options.TracerColor.Value
                                tracer.Visible = true
                            else
                                espData.Drawings.Tracer.Visible = false
                            end
                            
                            local textParts = {}
                            if Toggles.DisplayNameEnabled and Toggles.DisplayNameEnabled.Value then
                                local displayText = player.DisplayName
                                if isFriend then
                                    displayText = displayText .. " [FRIEND]"
                                elseif isStaff then
                                    displayText = displayText .. " [STAFF]"
                                end
                                table.insert(textParts, displayText)
                            end
                            if Toggles.UsernameEnabled and Toggles.UsernameEnabled.Value then
                                table.insert(textParts, "@" .. player.Name)
                            end
                            if Toggles.DistanceEnabled and Toggles.DistanceEnabled.Value then
                                table.insert(textParts, string.format("[%.0fm]", distance))
                            end
                            
                            if #textParts > 0 then
                                local text = espData.Drawings.Text
                                text.Text = table.concat(textParts, " ")
                                text.Position = Vector2.new(screenPos.X, screenPos.Y - 40)
                                text.Color = isFriend and Color3.fromRGB(0, 255, 0) or (isStaff and Color3.fromRGB(255, 0, 0) or Options.TextColor.Value)
                                text.Visible = true
                            else
                                espData.Drawings.Text.Visible = false
                            end
                            
                            if Toggles.ChamsEnabled and Toggles.ChamsEnabled.Value then
                                if not character:FindFirstChild("ChamHighlight") then
                                    local highlight = Instance.new("Highlight")
                                    highlight.Name = "ChamHighlight"
                                    highlight.Adornee = character
                                    highlight.FillColor = Options.ChamsColor.Value
                                    highlight.FillTransparency = Options.ChamsColor.Transparency
                                    highlight.OutlineTransparency = 1
                                    highlight.Parent = character
                                else
                                    local highlight = character:FindFirstChild("ChamHighlight")
                                    highlight.FillColor = Options.ChamsColor.Value
                                    highlight.FillTransparency = Options.ChamsColor.Transparency
                                end
                            else
                                local highlight = character:FindFirstChild("ChamHighlight")
                                if highlight then
                                    highlight:Destroy()
                                end
                            end
                        else
                            for _, line in pairs(espData.Drawings.Box) do
                                line.Visible = false
                            end
                            espData.Drawings.Tracer.Visible = false
                            espData.Drawings.Text.Visible = false
                            espData.Drawings.HealthBar.Visible = false
                            espData.Drawings.HealthBarBg.Visible = false
                            espData.Drawings.HealthBarOutline.Visible = false
                            espData.Drawings.HealthText.Visible = false
                            espData.Drawings.HeadDot.Visible = false
                        end
                    else
                        for _, line in pairs(espData.Drawings.Box) do
                            line.Visible = false
                        end
                        espData.Drawings.Tracer.Visible = false
                        espData.Drawings.Text.Visible = false
                        espData.Drawings.HealthBar.Visible = false
                        espData.Drawings.HealthBarBg.Visible = false
                        espData.Drawings.HealthBarOutline.Visible = false
                        espData.Drawings.HealthText.Visible = false
                        espData.Drawings.HeadDot.Visible = false
                        
                        local highlight = character:FindFirstChild("ChamHighlight")
                        if highlight then
                            highlight:Destroy()
                        end
                    end
                end
            else
                for _, line in pairs(espData.Drawings.Box) do
                    line.Visible = false
                end
                espData.Drawings.Tracer.Visible = false
                espData.Drawings.Text.Visible = false
                espData.Drawings.HealthBar.Visible = false
                espData.Drawings.HealthBarBg.Visible = false
                espData.Drawings.HealthBarOutline.Visible = false
                espData.Drawings.HealthText.Visible = false
                espData.Drawings.HeadDot.Visible = false
            end
        end
    end
    
    -- NPC ESP
    if Toggles.NPCEnabled and Toggles.NPCEnabled.Value then
        for _, npc in pairs(FindNPCs()) do
            if not NPCESPObjects[npc] then
                CreateNPCESP(npc)
            end
            
            local espData = NPCESPObjects[npc]
            local hrp = npc:FindFirstChild("HumanoidRootPart")
            
            if hrp and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                
                if distance <= maxDistance then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                    
                    if onScreen then
                        local topPos = (hrp.CFrame * CFrame.new(0, 3, 0)).Position
                        local bottomPos = (hrp.CFrame * CFrame.new(0, -3, 0)).Position
                        
                        local topScreenPos = Camera:WorldToViewportPoint(topPos)
                        local bottomScreenPos = Camera:WorldToViewportPoint(bottomPos)
                        
                        local height = (Vector2.new(topScreenPos.X, topScreenPos.Y) - Vector2.new(bottomScreenPos.X, bottomScreenPos.Y)).Magnitude
                        local width = height / 2
                        
                        local box = espData.Drawings.Box
                        local color = Options.NPCColor.Value
                        
                        box.TopLeft.From = Vector2.new(topScreenPos.X - width/2, topScreenPos.Y)
                        box.TopLeft.To = Vector2.new(topScreenPos.X - width/2, topScreenPos.Y + height)
                        box.TopLeft.Color = color
                        box.TopLeft.Visible = true
                        
                        box.TopRight.From = Vector2.new(topScreenPos.X + width/2, topScreenPos.Y)
                        box.TopRight.To = Vector2.new(topScreenPos.X + width/2, topScreenPos.Y + height)
                        box.TopRight.Color = color
                        box.TopRight.Visible = true
                        
                        box.BottomLeft.From = Vector2.new(topScreenPos.X - width/2, topScreenPos.Y)
                        box.BottomLeft.To = Vector2.new(topScreenPos.X + width/2, topScreenPos.Y)
                        box.BottomLeft.Color = color
                        box.BottomLeft.Visible = true
                        
                        box.BottomRight.From = Vector2.new(topScreenPos.X - width/2, topScreenPos.Y + height)
                        box.BottomRight.To = Vector2.new(topScreenPos.X + width/2, topScreenPos.Y + height)
                        box.BottomRight.Color = color
                        box.BottomRight.Visible = true
                        
                        espData.Drawings.Text.Text = npc.Name .. " [NPC]"
                        espData.Drawings.Text.Position = Vector2.new(screenPos.X, screenPos.Y - 40)
                        espData.Drawings.Text.Color = color
                        espData.Drawings.Text.Visible = true
                    else
                        for _, line in pairs(espData.Drawings.Box) do
                            line.Visible = false
                        end
                        espData.Drawings.Text.Visible = false
                    end
                else
                    for _, line in pairs(espData.Drawings.Box) do
                        line.Visible = false
                    end
                    espData.Drawings.Text.Visible = false
                end
            end
        end
    else
        for npc, espData in pairs(NPCESPObjects) do
            for _, line in pairs(espData.Drawings.Box) do
                line.Visible = false
            end
            espData.Drawings.Text.Visible = false
        end
    end
    
    -- Extraction Point ESP
    if Toggles.ExtractionEnabled and Toggles.ExtractionEnabled.Value then
        for _, extraction in pairs(FindExtractionPoints()) do
            if not ExtractionESPObjects[extraction] then
                CreateExtractionESP(extraction)
            end
            
            local espData = ExtractionESPObjects[extraction]
            local position
            
            if extraction:IsA("BasePart") then
                position = extraction.Position
            elseif extraction:IsA("Model") and extraction.PrimaryPart then
                position = extraction.PrimaryPart.Position
            elseif extraction:IsA("Model") then
                local hrp = extraction:FindFirstChild("HumanoidRootPart")
                if hrp then
                    position = hrp.Position
                end
            end
            
            if position and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (LocalPlayer.Character.HumanoidRootPart.Position - position).Magnitude
                
                if distance <= maxDistance then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(position)
                    
                    if onScreen then
                        espData.Drawings.Dot.Position = Vector2.new(screenPos.X, screenPos.Y)
                        espData.Drawings.Dot.Color = Options.ExtractionColor.Value
                        espData.Drawings.Dot.Visible = true
                        
                        espData.Drawings.Text.Position = Vector2.new(screenPos.X, screenPos.Y - 20)
                        espData.Drawings.Text.Color = Options.ExtractionColor.Value
                        espData.Drawings.Text.Visible = true
                    else
                        espData.Drawings.Dot.Visible = false
                        espData.Drawings.Text.Visible = false
                    end
                else
                    espData.Drawings.Dot.Visible = false
                    espData.Drawings.Text.Visible = false
                end
            end
        end
    else
        for extraction, espData in pairs(ExtractionESPObjects) do
            espData.Drawings.Dot.Visible = false
            espData.Drawings.Text.Visible = false
        end
    end
end)

-- Handle player removing
Players.PlayerRemoving:Connect(function(player)
    RemoveESP(player)
end)

-- Load notification
Library:Notify({
    Title = "Project Skid",
    Description = "Script loaded successfully!\nMade by yuhzz",
    Time = 3,
})

-- Cleanup on unload
Library:OnUnload(function()
    FOVCircle:Remove()
    FOVFill:Remove()
    SnapLine:Remove()
    
    for player, _ in pairs(ESPObjects) do
        RemoveESP(player)
    end
    
    for npc, _ in pairs(NPCESPObjects) do
        RemoveNPCESP(npc)
    end
    
    for extraction, _ in pairs(ExtractionESPObjects) do
        RemoveExtractionESP(extraction)
    end
    
    print("Project Skid script unloaded!")
end)
