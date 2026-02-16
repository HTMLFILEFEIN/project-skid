-- Project Skid Script
-- Made by yuhzz

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera


local Window = Library:CreateWindow({
    Title = "Project Skid",
    Footer = "Made by yuhzz",
    NotifySide = "Right",
    ShowCustomCursor = true,
})


local Tabs = {
    Combat = Window:AddTab("Combat", "crosshair"),
    Visuals = Window:AddTab("Visuals", "eye"),
    Misc = Window:AddTab("Misc", "settings"),
    ["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}


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

AimbotGroup:AddSlider("AimbotSmoothness", {
    Text = "Smoothness",
    Default = 5,
    Min = 1,
    Max = 20,
    Rounding = 1,
    Tooltip = "Higher = smoother but slower",
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

InfoESPGroup:AddToggle("ToolEnabled", {
    Text = "Tool Name",
    Default = false,
    Tooltip = "Show equipped tool name",
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
    Default = Color3.fromRGB(0, 255, 0),
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
    Default = 1000,
    Min = 100,
    Max = 10000,
    Rounding = 0,
    Tooltip = "Maximum distance to render ESP (10000 = whole map)",
})


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


local function GetClosestPlayerInFOV()
    local closestPlayer = nil
    local shortestDistance = math.huge
    local mousePos = UserInputService:GetMouseLocation()
    local fovRadius = Options.FOVSize.Value
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
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
    
    return closestPlayer
end

RunService.RenderStepped:Connect(function()
    if Toggles.AimbotEnabled and Toggles.AimbotEnabled.Value then
        local aimbotKeyState = Options.AimbotKey:GetState()
        
        if aimbotKeyState then
            local target = GetClosestPlayerInFOV()
            
            if target and target.Character and target.Character:FindFirstChild("Head") then
                local targetPos = target.Character.Head.Position
                local cameraPos = Camera.CFrame.Position
                local targetCFrame = CFrame.new(cameraPos, targetPos)
                
                local smoothness = Options.AimbotSmoothness.Value
                Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, 1 / smoothness)
            end
        end
    end
end)


local ESPObjects = {}


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
    
    ESPObjects[player] = espData
end


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
        ESPObjects[player] = nil
    end
end


RunService.RenderStepped:Connect(function()
    local maxDistance = Options.MaxESPDistance.Value
    local visibleOnly = Toggles.VisibleOnly and Toggles.VisibleOnly.Value or false
    
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
                            
                            
                            if Toggles.BoxEnabled and Toggles.BoxEnabled.Value then
                                local box = espData.Drawings.Box
                                local color = Options.BoxColor.Value
                                
                                
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
                                table.insert(textParts, player.DisplayName)
                            end
                            if Toggles.UsernameEnabled and Toggles.UsernameEnabled.Value then
                                table.insert(textParts, "@" .. player.Name)
                            end
                            if Toggles.DistanceEnabled and Toggles.DistanceEnabled.Value then
                                table.insert(textParts, string.format("[%.0fm]", distance))
                            end
                            if Toggles.ToolEnabled and Toggles.ToolEnabled.Value then
                                local tool = character:FindFirstChildOfClass("Tool")
                                if tool then
                                    table.insert(textParts, "[" .. tool.Name .. "]")
                                end
                            end
                            
                            if #textParts > 0 then
                                local text = espData.Drawings.Text
                                text.Text = table.concat(textParts, " ")
                                text.Position = Vector2.new(screenPos.X, screenPos.Y - 40)
                                text.Color = Options.TextColor.Value
                                text.Visible = true
                            else
                                espData.Drawings.Text.Visible = false
                            end
                            
                            -- Chams
                            if Toggles.ChamsEnabled and Toggles.ChamsEnabled.Value then
                                for _, part in pairs(character:GetDescendants()) do
                                    if part:IsA("BasePart") and not part:FindFirstChild("ChamHighlight") then
                                        local highlight = Instance.new("Highlight")
                                        highlight.Name = "ChamHighlight"
                                        highlight.Adornee = part
                                        highlight.FillColor = Options.ChamsColor.Value
                                        highlight.FillTransparency = Options.ChamsColor.Transparency
                                        highlight.OutlineTransparency = 1
                                        highlight.Parent = part
                                    end
                                end
                            else
                                for _, part in pairs(character:GetDescendants()) do
                                    if part:IsA("BasePart") then
                                        local highlight = part:FindFirstChild("ChamHighlight")
                                        if highlight then
                                            highlight:Destroy()
                                        end
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
                        
                        
                        for _, part in pairs(character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                local highlight = part:FindFirstChild("ChamHighlight")
                                if highlight then
                                    highlight:Destroy()
                                end
                            end
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
            end
        end
    end
end)

Players.PlayerRemoving:Connect(function(player)
    RemoveESP(player)
end)

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

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })

ThemeManager:SetFolder("ProjectSkid")
SaveManager:SetFolder("ProjectSkid/configs")

SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])

Library:Notify({
    Title = "Project Skid",
    Description = "Script loaded successfully!\nMade by yuhzz",
    Time = 3,
})

Library:OnUnload(function()
    FOVCircle:Remove()
    FOVFill:Remove()
    
    for player, _ in pairs(ESPObjects) do
        RemoveESP(player)
    end
    
    print("Project Skid script unloaded!")
end)
