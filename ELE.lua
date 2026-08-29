-- ============================================
-- STICKY AUTO FARM (Follows mob until dead)
-- ============================================

-- ============================================
-- 1. SETTINGS
-- ============================================

local Settings = {
    FarmDistance = 5,
    FarmPosition = "Behind", -- "Behind", "Above", "Under"
    AutoHit = true,
    AutoFarm = false,
}

-- ============================================
-- 2. CREATE GUI
-- ============================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "AutoFarmGUI"

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 160)
Frame.Position = UDim2.new(0.01, 0, 0.5, -80)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Frame.BackgroundTransparency = 0.2
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 25)
Title.Position = UDim2.new(0, 0, 0, 2)
Title.Text = "⚔️ Sticky Auto Farm"
Title.TextScaled = true
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 200, 100)
Title.Parent = Frame

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 25)
Status.Position = UDim2.new(0, 0, 0, 28)
Status.Text = "⏹️ Stopped"
Status.TextScaled = true
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.fromRGB(255, 255, 255)
Status.Font = Enum.Font.SourceSans
Status.Parent = Frame

local TargetStatus = Instance.new("TextLabel")
TargetStatus.Size = UDim2.new(1, 0, 0, 20)
TargetStatus.Position = UDim2.new(0, 0, 0, 50)
TargetStatus.Text = "Target: None"
TargetStatus.TextScaled = true
TargetStatus.BackgroundTransparency = 1
TargetStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
TargetStatus.Font = Enum.Font.SourceSans
TargetStatus.Parent = Frame

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 80, 0, 28)
ToggleBtn.Position = UDim2.new(0.5, -40, 0, 75)
ToggleBtn.Text = "START"
ToggleBtn.TextScaled = true
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Parent = Frame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = ToggleBtn

-- Position Button
local PosBtn = Instance.new("TextButton")
PosBtn.Size = UDim2.new(0, 60, 0, 25)
PosBtn.Position = UDim2.new(0.05, 0, 0, 110)
PosBtn.Text = "Behind"
PosBtn.TextScaled = true
PosBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
PosBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PosBtn.BorderSizePixel = 0
PosBtn.Parent = Frame

-- Distance controls
local DistLabel = Instance.new("TextLabel")
DistLabel.Size = UDim2.new(0, 80, 0, 20)
DistLabel.Position = UDim2.new(0.55, 0, 0, 110)
DistLabel.Text = "Dist: " .. Settings.FarmDistance
DistLabel.TextScaled = true
DistLabel.BackgroundTransparency = 1
DistLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
DistLabel.Font = Enum.Font.SourceSans
DistLabel.Parent = Frame

local DistMinus = Instance.new("TextButton")
DistMinus.Size = UDim2.new(0, 25, 0, 20)
DistMinus.Position = UDim2.new(0.55, 0, 0, 132)
DistMinus.Text = "-"
DistMinus.TextScaled = true
DistMinus.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
DistMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
DistMinus.BorderSizePixel = 0
DistMinus.Parent = Frame

local DistPlus = Instance.new("TextButton")
DistPlus.Size = UDim2.new(0, 25, 0, 20)
DistPlus.Position = UDim2.new(0.75, 0, 0, 132)
DistPlus.Text = "+"
DistPlus.TextScaled = true
DistPlus.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
DistPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
DistPlus.BorderSizePixel = 0
DistPlus.Parent = Frame

-- ============================================
-- 3. FUNCTIONS
-- ============================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CurrentTarget = nil
local isFarming = false
local FarmTask = nil

function GetNearestMob()
    local Character = LocalPlayer.Character
    if not Character then return nil end
    
    local HRP = Character:FindFirstChild("HumanoidRootPart")
    if not HRP then return nil end
    
    local Mobs = workspace:FindFirstChild("Mobs")
    if not Mobs then return nil end
    
    local Nearest = nil
    local NearestDist = math.huge
    
    for _, Mob in pairs(Mobs:GetChildren()) do
        if Mob:IsA("Model") then
            local Humanoid = Mob:FindFirstChild("Humanoid")
            if Humanoid and Humanoid.Health > 0 then
                local MobHRP = Mob:FindFirstChild("HumanoidRootPart")
                if MobHRP then
                    local Dist = (HRP.Position - MobHRP.Position).Magnitude
                    if Dist < NearestDist and Dist < 200 then
                        NearestDist = Dist
                        Nearest = Mob
                    end
                end
            end
        end
    end
    
    return Nearest
end

-- Check if target is still alive
function IsTargetAlive(Mob)
    if not Mob then return false end
    local Humanoid = Mob:FindFirstChild("Humanoid")
    if Humanoid and Humanoid.Health > 0 then
        return true
    end
    return false
end

-- STICKY MOVE - Follows mob continuously
function StickToMob(Mob)
    if not Mob then return end
    
    local Character = LocalPlayer.Character
    if not Character then return end
    
    local PlayerHRP = Character:FindFirstChild("HumanoidRootPart")
    if not PlayerHRP then return end
    
    local MobHRP = Mob:FindFirstChild("HumanoidRootPart")
    if not MobHRP then return end
    
    -- Calculate position offset (sticky)
    local Offsets = {
        Behind = CFrame.new(0, 0, Settings.FarmDistance),
        Above = CFrame.new(0, Settings.FarmDistance, 0),
        Under = CFrame.new(0, -Settings.FarmDistance, 0)
    }
    
    local Offset = Offsets[Settings.FarmPosition] or Offsets.Behind
    local TargetCFrame = MobHRP.CFrame * Offset
    
    -- STICKY: Teleport to position (instant, stays fixed)
    PlayerHRP.CFrame = TargetCFrame
end

function HitMob()
    pcall(function()
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new(0, 0))
    end)
end

-- ============================================
-- 4. FARM LOOP (STICKY)
-- ============================================

function StartFarm()
    if isFarming then return end
    isFarming = true
    CurrentTarget = nil
    
    Status.Text = "⚔️ FARMING"
    Status.TextColor3 = Color3.fromRGB(100, 255, 100)
    ToggleBtn.Text = "STOP"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    
    FarmTask = task.spawn(function()
        while isFarming do
            -- If no target or target is dead, find a new one
            if not IsTargetAlive(CurrentTarget) then
                CurrentTarget = GetNearestMob()
                if CurrentTarget then
                    TargetStatus.Text = "Target: " .. CurrentTarget.Name
                    TargetStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
                else
                    TargetStatus.Text = "Target: None"
                    TargetStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
                    Status.Text = "⏳ No mobs found"
                    Status.TextColor3 = Color3.fromRGB(255, 200, 100)
                    task.wait(1)
                    continue
                end
            end
            
            -- STICKY: Follow target continuously
            if CurrentTarget then
                StickToMob(CurrentTarget)
                
                if Settings.AutoHit then
                    HitMob()
                end
                
                Status.Text = "⚔️ " .. CurrentTarget.Name
                Status.TextColor3 = Color3.fromRGB(100, 255, 100)
                
                -- Check if target died
                if not IsTargetAlive(CurrentTarget) then
                    Status.Text = "💀 Target died!"
                    Status.TextColor3 = Color3.fromRGB(255, 200, 100)
                    CurrentTarget = nil
                    TargetStatus.Text = "Target: None"
                    TargetStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
                    task.wait(0.5)
                end
            end
            
            task.wait(0.05) -- Fast update for sticky follow
        end
        
        Status.Text = "⏹️ Stopped"
        Status.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleBtn.Text = "START"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
        CurrentTarget = nil
        TargetStatus.Text = "Target: None"
    end)
end

function StopFarm()
    isFarming = false
    if FarmTask then
        task.cancel(FarmTask)
        FarmTask = nil
    end
    CurrentTarget = nil
    Status.Text = "⏹️ Stopped"
    Status.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.Text = "START"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
    TargetStatus.Text = "Target: None"
end

-- ============================================
-- 5. GUI BUTTONS
-- ============================================

ToggleBtn.MouseButton1Click:Connect(function()
    if isFarming then
        StopFarm()
    else
        StartFarm()
    end
end)

local Positions = {"Behind", "Above", "Under"}
local PosIndex = 1

PosBtn.MouseButton1Click:Connect(function()
    PosIndex = PosIndex + 1
    if PosIndex > #Positions then PosIndex = 1 end
    Settings.FarmPosition = Positions[PosIndex]
    PosBtn.Text = Settings.FarmPosition
end)

DistMinus.MouseButton1Click:Connect(function()
    if Settings.FarmDistance > 1 then
        Settings.FarmDistance = Settings.FarmDistance - 1
        DistLabel.Text = "Dist: " .. Settings.FarmDistance
    end
end)

DistPlus.MouseButton1Click:Connect(function()
    if Settings.FarmDistance < 20 then
        Settings.FarmDistance = Settings.FarmDistance + 1
        DistLabel.Text = "Dist: " .. Settings.FarmDistance
    end
end)

-- ============================================
-- 6. KEYBIND - Press F to toggle
-- ============================================

local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(Input, Processed)
    if not Processed and Input.KeyCode == Enum.KeyCode.F then
        if isFarming then
            StopFarm()
        else
            StartFarm()
        end
    end
end)

-- ============================================
-- 7. DRAG GUI
-- ============================================

local Dragging = false
local DragStart
local StartPos

Frame.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = Input.Position
        StartPos = Frame.Position
        Input.Changed:Connect(function()
            if Input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseMovement and Dragging then
        local Delta = Input.Position - DragStart
        Frame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
    end
end)

-- ============================================
-- 8. START
-- ============================================

print("⚔️ Sticky Auto Farm Loaded!")
print("📌 Press 'F' to toggle ON/OFF")
print("📌 Sticks to one mob until it dies")
print("📌 Click 'Behind' to change position")
