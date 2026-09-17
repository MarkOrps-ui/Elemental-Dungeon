-- ============================================
-- SMOOTH FLOATING TWEEN FARM
-- Anti-Gravity + Fixed Speed Movement
-- ============================================

-- ============================================
-- 1. SETTINGS
-- ============================================

local Settings = {
    FarmDistance = 5,
    FarmPosition = "Above",
    SearchRange = 500,
    MoveSpeed = 30,          -- Studs per second (higher = faster)
    FloatForce = 0.05,       -- Anti-gravity force (0.05 = very floaty)
    AutoFarm = false,
}

-- ============================================
-- 2. CREATE GUI
-- ============================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "FloatFarmGUI"

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 230, 0, 210)
Frame.Position = UDim2.new(0.01, 0, 0.5, -105)
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
Title.Text = "🌙 Float Auto Farm"
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
PosBtn.Text = "Above"
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
DistMinus.Position = UDim2.new(0.55, 0, 0, 136)
DistMinus.Text = "-"
DistMinus.TextScaled = true
DistMinus.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
DistMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
DistMinus.BorderSizePixel = 0
DistMinus.Parent = Frame

local DistPlus = Instance.new("TextButton")
DistPlus.Size = UDim2.new(0, 25, 0, 20)
DistPlus.Position = UDim2.new(0.75, 0, 0, 136)
DistPlus.Text = "+"
DistPlus.TextScaled = true
DistPlus.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
DistPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
DistPlus.BorderSizePixel = 0
DistPlus.Parent = Frame

-- Speed controls
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0, 100, 0, 20)
SpeedLabel.Position = UDim2.new(0.05, 0, 0, 160)
SpeedLabel.Text = "Speed: " .. Settings.MoveSpeed
SpeedLabel.TextScaled = true
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.Parent = Frame

local SpeedMinus = Instance.new("TextButton")
SpeedMinus.Size = UDim2.new(0, 25, 0, 20)
SpeedMinus.Position = UDim2.new(0.05, 0, 0, 180)
SpeedMinus.Text = "-"
SpeedMinus.TextScaled = true
SpeedMinus.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
SpeedMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedMinus.BorderSizePixel = 0
SpeedMinus.Parent = Frame

local SpeedPlus = Instance.new("TextButton")
SpeedPlus.Size = UDim2.new(0, 25, 0, 20)
SpeedPlus.Position = UDim2.new(0.25, 0, 0, 180)
SpeedPlus.Text = "+"
SpeedPlus.TextScaled = true
SpeedPlus.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
SpeedPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedPlus.BorderSizePixel = 0
SpeedPlus.Parent = Frame

-- Float controls
local FloatLabel = Instance.new("TextLabel")
FloatLabel.Size = UDim2.new(0, 100, 0, 20)
FloatLabel.Position = UDim2.new(0.5, 0, 0, 160)
FloatLabel.Text = "Float: " .. Settings.FloatForce
FloatLabel.TextScaled = true
FloatLabel.BackgroundTransparency = 1
FloatLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
FloatLabel.Font = Enum.Font.SourceSans
FloatLabel.Parent = Frame

local FloatMinus = Instance.new("TextButton")
FloatMinus.Size = UDim2.new(0, 25, 0, 20)
FloatMinus.Position = UDim2.new(0.5, 0, 0, 180)
FloatMinus.Text = "-"
FloatMinus.TextScaled = true
FloatMinus.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
FloatMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatMinus.BorderSizePixel = 0
FloatMinus.Parent = Frame

local FloatPlus = Instance.new("TextButton")
FloatPlus.Size = UDim2.new(0, 25, 0, 20)
FloatPlus.Position = UDim2.new(0.7, 0, 0, 180)
FloatPlus.Text = "+"
FloatPlus.TextScaled = true
FloatPlus.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
FloatPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatPlus.BorderSizePixel = 0
FloatPlus.Parent = Frame

-- ============================================
-- 3. FUNCTIONS
-- ============================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CurrentTarget = nil
local isFarming = false
local FarmTask = nil
local FloatConnection = nil
local OriginalGravity = workspace.Gravity

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
                    if Dist < NearestDist and Dist < Settings.SearchRange then
                        NearestDist = Dist
                        Nearest = Mob
                    end
                end
            end
        end
    end
    
    return Nearest
end

function IsTargetAlive(Mob)
    if not Mob then return false end
    local Humanoid = Mob:FindFirstChild("Humanoid")
    if Humanoid and Humanoid.Health > 0 then
        return true
    end
    return false
end

-- ============================================
-- FIXED SPEED MOVEMENT (Not Duration-Based)
-- ============================================

function MoveToMobFixedSpeed(Mob)
    if not Mob then return end
    
    local Character = LocalPlayer.Character
    if not Character then return end
    
    local PlayerHRP = Character:FindFirstChild("HumanoidRootPart")
    if not PlayerHRP then return end
    
    local MobHRP = Mob:FindFirstChild("HumanoidRootPart")
    if not MobHRP then return end
    
    -- Calculate target position
    local Offsets = {
        Behind = CFrame.new(0, 0, Settings.FarmDistance),
        Above = CFrame.new(0, Settings.FarmDistance, 0),
        Under = CFrame.new(0, -Settings.FarmDistance, 0)
    }
    
    local Offset = Offsets[Settings.FarmPosition] or Offsets.Above
    local TargetCFrame = MobHRP.CFrame * Offset
    
    -- ============================================
    -- FIXED SPEED: Use BodyVelocity or LinearVelocity
    -- This makes movement speed consistent regardless of distance
    -- ============================================
    
    -- Create BodyVelocity
    local BV = Instance.new("BodyVelocity")
    BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    BV.Velocity = Vector3.new(0, 0, 0)
    BV.Parent = PlayerHRP
    
    -- Calculate direction and speed
    local Direction = (TargetCFrame.Position - PlayerHRP.Position)
    local Distance = Direction.Magnitude
    
    if Distance > 0 then
        BV.Velocity = Direction.Unit * Settings.MoveSpeed
        
        -- Wait until close enough
        local StartTime = tick()
        while tick() - StartTime < 5 do -- Max 5 seconds
            if not isFarming then break end
            
            local CurrentDist = (TargetCFrame.Position - PlayerHRP.Position).Magnitude
            if CurrentDist < 2 then break end
            
            -- Update direction if needed
            if CurrentDist > 0 then
                BV.Velocity = (TargetCFrame.Position - PlayerHRP.Position).Unit * Settings.MoveSpeed
            end
            
            task.wait(0.05)
        end
    end
    
    -- Cleanup
    BV:Destroy()
end

-- ============================================
-- ANTI-GRAVITY (Float when idle)
-- ============================================

function StartFloating()
    if FloatConnection then
        FloatConnection:Disconnect()
    end
    
    FloatConnection = RunService.Heartbeat:Connect(function()
        if not isFarming then return end
        
        local Character = LocalPlayer.Character
        if not Character then return end
        
        local HRP = Character:FindFirstChild("HumanoidRootPart")
        local Humanoid = Character:FindFirstChild("Humanoid")
        
        if HRP and Humanoid then
            -- Check if we have a target
            if not IsTargetAlive(CurrentTarget) then
                -- No target - apply anti-gravity
                -- Reduce gravity effect
                workspace.Gravity = OriginalGravity * Settings.FloatForce
                
                -- Also apply upward force to counter gravity
                local BV = HRP:FindFirstChild("FloatVelocity") or Instance.new("BodyVelocity")
                BV.Name = "FloatVelocity"
                BV.MaxForce = Vector3.new(0, math.huge, 0)
                BV.Velocity = Vector3.new(0, 0, 0)
                BV.Parent = HRP
            else
                -- Has target - normal gravity
                workspace.Gravity = OriginalGravity
                
                local BV = HRP:FindFirstChild("FloatVelocity")
                if BV then BV:Destroy() end
            end
        end
    end)
end

function StopFloating()
    if FloatConnection then
        FloatConnection:Disconnect()
        FloatConnection = nil
    end
    
    -- Restore gravity
    workspace.Gravity = OriginalGravity
    
    -- Remove float velocity
    local Character = LocalPlayer.Character
    if Character then
        local HRP = Character:FindFirstChild("HumanoidRootPart")
        if HRP then
            local BV = HRP:FindFirstChild("FloatVelocity")
            if BV then BV:Destroy() end
        end
    end
end

-- ============================================
-- 4. FARM LOOP
-- ============================================

function StartFarm()
    if isFarming then return end
    isFarming = true
    CurrentTarget = nil
    
    -- Save original gravity
    OriginalGravity = workspace.Gravity
    
    Status.Text = "⚔️ FARMING"
    Status.TextColor3 = Color3.fromRGB(100, 255, 100)
    ToggleBtn.Text = "STOP"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    
    -- Start floating
    StartFloating()
    
    FarmTask = task.spawn(function()
        while isFarming do
            if not IsTargetAlive(CurrentTarget) then
                CurrentTarget = GetNearestMob()
                if CurrentTarget then
                    TargetStatus.Text = "Target: " .. CurrentTarget.Name
                    TargetStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
                    
                    -- Move with fixed speed
                    MoveToMobFixedSpeed(CurrentTarget)
                else
                    TargetStatus.Text = "Target: None (Floating)"
                    TargetStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
                    Status.Text = "🌙 Floating..."
                    Status.TextColor3 = Color3.fromRGB(200, 150, 255)
                    task.wait(0.5)
                    continue
                end
            end
            
            -- Follow target if it moves
            if CurrentTarget and IsTargetAlive(CurrentTarget) then
                local Character = LocalPlayer.Character
                if Character then
                    local HRP = Character:FindFirstChild("HumanoidRootPart")
                    local MobHRP = CurrentTarget:FindFirstChild("HumanoidRootPart")
                    
                    if HRP and MobHRP then
                        local Offsets = {
                            Behind = CFrame.new(0, 0, Settings.FarmDistance),
                            Above = CFrame.new(0, Settings.FarmDistance, 0),
                            Under = CFrame.new(0, -Settings.FarmDistance, 0)
                        }
                        local Offset = Offsets[Settings.FarmPosition] or Offsets.Above
                        local TargetPos = (MobHRP.CFrame * Offset).Position
                        
                        local Distance = (HRP.Position - TargetPos).Magnitude
                        
                        if Distance > 3 then
                            MoveToMobFixedSpeed(CurrentTarget)
                        end
                    end
                end
            end
            
            task.wait(0.1)
        end
        
        StopFloating()
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
    
    StopFloating()
    
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
local PosIndex = 2

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

SpeedMinus.MouseButton1Click:Connect(function()
    if Settings.MoveSpeed > 5 then
        Settings.MoveSpeed = Settings.MoveSpeed - 5
        SpeedLabel.Text = "Speed: " .. Settings.MoveSpeed
    end
end)

SpeedPlus.MouseButton1Click:Connect(function()
    if Settings.MoveSpeed < 100 then
        Settings.MoveSpeed = Settings.MoveSpeed + 5
        SpeedLabel.Text = "Speed: " .. Settings.MoveSpeed
    end
end)

FloatMinus.MouseButton1Click:Connect(function()
    if Settings.FloatForce > 0.01 then
        Settings.FloatForce = Settings.FloatForce - 0.01
        FloatLabel.Text = "Float: " .. string.format("%.2f", Settings.FloatForce)
    end
end)

FloatPlus.MouseButton1Click:Connect(function()
    if Settings.FloatForce < 0.5 then
        Settings.FloatForce = Settings.FloatForce + 0.01
        FloatLabel.Text = "Float: " .. string.format("%.2f", Settings.FloatForce)
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

print("🌙 Float Auto Farm Loaded!")
print("📌 Press 'F' to toggle ON/OFF")
print("📌 Speed: " .. Settings.MoveSpeed .. " studs/sec")
print("📌 Float Force: " .. Settings.FloatForce .. " (lower = more floaty)")
print("📌 When no mobs, you'll float slowly down like on the moon")
