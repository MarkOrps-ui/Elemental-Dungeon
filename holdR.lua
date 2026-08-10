-- ============================================
-- AUTO CLAW SPIN - FORCE HOLD FIX
-- ============================================

-- ============================================
-- 1. SETTINGS
-- ============================================

local Settings = {
    SkillKey = "R",
    HoldDuration = 8,        -- Your desired hold time
    Cooldown = 2,            -- Short cooldown between holds
    AutoStart = true,
}

-- ============================================
-- 2. FORCE HOLD FUNCTION (FIXED)
-- ============================================

function ForceHoldKey(Key, Duration)
    local VirtualInput = game:GetService("VirtualInputManager")
    local KeyCode = Enum.KeyCode[Key]
    
    if not KeyCode then
        warn("Invalid key: " .. Key)
        return
    end
    
    print("🔽 Pressing " .. Key .. " for " .. Duration .. " seconds...")
    
    -- Press key down
    VirtualInput:SendKeyEvent(true, KeyCode, false, game)
    
    -- FORCE HOLD - Send repeated events to prevent release
    local StartTime = tick()
    local LastEvent = StartTime
    
    while tick() - StartTime < Duration do
        task.wait(0.05)
        
        -- Send keep-alive events every 50ms
        VirtualInput:SendKeyEvent(true, KeyCode, false, game)
        
        -- Also try alternative method
        pcall(function()
            VirtualInput:SendKeyEvent(true, KeyCode, false, game)
        end)
        
        -- Update status every second
        if tick() - LastEvent > 1 then
            LastEvent = tick()
            local Remaining = math.ceil(Duration - (tick() - StartTime))
            Status.Text = "🌀 Holding R... " .. Remaining .. "s remaining"
        end
    end
    
    -- Release key
    VirtualInput:SendKeyEvent(false, KeyCode, false, game)
    print("🔼 Released " .. Key)
end

-- ============================================
-- 3. GUI (Same as before)
-- ============================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "AutoClawSpinGUI"

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 240, 0, 180)
Frame.Position = UDim2.new(0.01, 0, 0.5, -90)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Frame.BackgroundTransparency = 0.1
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 25)
Title.Position = UDim2.new(0, 0, 0, 2)
Title.Text = "🌀 Auto Claw Spin"
Title.TextScaled = true
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 200, 100)
Title.Parent = Frame

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 25)
Status.Position = UDim2.new(0, 0, 0, 30)
Status.Text = "Status: OFF"
Status.TextScaled = true
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.fromRGB(200, 200, 200)
Status.Parent = Frame

local DurationDisplay = Instance.new("TextLabel")
DurationDisplay.Size = UDim2.new(1, 0, 0, 25)
DurationDisplay.Position = UDim2.new(0, 0, 0, 55)
DurationDisplay.Text = "Hold: " .. Settings.HoldDuration .. "s"
DurationDisplay.TextScaled = true
DurationDisplay.BackgroundTransparency = 1
DurationDisplay.TextColor3 = Color3.fromRGB(200, 200, 100)
DurationDisplay.Parent = Frame

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 80, 0, 30)
ToggleBtn.Position = UDim2.new(0.5, -40, 0, 85)
ToggleBtn.Text = "START"
ToggleBtn.TextScaled = true
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Parent = Frame

-- Duration + Button
local DurationBtn = Instance.new("TextButton")
DurationBtn.Size = UDim2.new(0, 60, 0, 25)
DurationBtn.Position = UDim2.new(0.1, 0, 0, 120)
DurationBtn.Text = "+1s"
DurationBtn.TextScaled = true
DurationBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
DurationBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DurationBtn.BorderSizePixel = 0
DurationBtn.Parent = Frame

local DurationMinusBtn = Instance.new("TextButton")
DurationMinusBtn.Size = UDim2.new(0, 60, 0, 25)
DurationMinusBtn.Position = UDim2.new(0.6, 0, 0, 120)
DurationMinusBtn.Text = "-1s"
DurationMinusBtn.TextScaled = true
DurationMinusBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
DurationMinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DurationMinusBtn.BorderSizePixel = 0
DurationMinusBtn.Parent = Frame

-- ============================================
-- 4. AUTO LOOP (FIXED)
-- ============================================

local isRunning = false
local Holding = false
local LastActivation = 0

function StartLoop()
    if Holding then return end
    Holding = true
    
    task.spawn(function()
        while Holding and isRunning do
            task.wait(0.3)
            
            -- Check if character exists and is alive
            local Character = game.Players.LocalPlayer.Character
            if not Character then
                Status.Text = "⏳ Waiting for character..."
                task.wait(1)
                continue
            end
            
            local Humanoid = Character:FindFirstChild("Humanoid")
            if not Humanoid or Humanoid.Health <= 0 then
                Status.Text = "💀 Dead - Waiting..."
                task.wait(2)
                continue
            end
            
            -- Check for nearby mobs
            local Mobs = workspace:FindFirstChild("Mobs")
            local HasTarget = false
            
            if Mobs then
                local PlayerHRP = Character:FindFirstChild("HumanoidRootPart")
                if PlayerHRP then
                    for _, Mob in pairs(Mobs:GetChildren()) do
                        if Mob:IsA("Model") and Mob:FindFirstChild("Humanoid") and Mob.Humanoid.Health > 0 then
                            local MobHRP = Mob:FindFirstChild("HumanoidRootPart")
                            if MobHRP then
                                local Distance = (PlayerHRP.Position - MobHRP.Position).Magnitude
                                if Distance < 150 then
                                    HasTarget = true
                                    break
                                end
                            end
                        end
                    end
                end
            end
            
            if HasTarget then
                -- Force hold for full duration
                Status.Text = "🌀 Holding R..."
                ForceHoldKey(Settings.SkillKey, Settings.HoldDuration)
                
                -- Wait for cooldown
                Status.Text = "⏳ Cooldown... (" .. Settings.Cooldown .. "s)"
                task.wait(Settings.Cooldown)
            else
                Status.Text = "⏳ Waiting for mobs..."
                task.wait(1)
            end
        end
        
        Status.Text = "Status: OFF"
        Holding = false
    end)
end

function StopLoop()
    isRunning = false
    Holding = false
    Status.Text = "Status: OFF"
    ToggleBtn.Text = "START"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
end

-- ============================================
-- 5. GUI BUTTONS
-- ============================================

ToggleBtn.MouseButton1Click:Connect(function()
    isRunning = not isRunning
    
    if isRunning then
        ToggleBtn.Text = "STOP"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
        Status.Text = "Status: ON"
        StartLoop()
    else
        StopLoop()
    end
end)

DurationBtn.MouseButton1Click:Connect(function()
    Settings.HoldDuration = Settings.HoldDuration + 1
    DurationDisplay.Text = "Hold: " .. Settings.HoldDuration .. "s"
    print("⏱️ Hold duration: " .. Settings.HoldDuration .. "s")
end)

DurationMinusBtn.MouseButton1Click:Connect(function()
    if Settings.HoldDuration > 1 then
        Settings.HoldDuration = Settings.HoldDuration - 1
        DurationDisplay.Text = "Hold: " .. Settings.HoldDuration .. "s"
        print("⏱️ Hold duration: " .. Settings.HoldDuration .. "s")
    end
end)

-- ============================================
-- 6. KEYBIND (Press 'H' to toggle)
-- ============================================

local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(Input, Processed)
    if not Processed and Input.KeyCode == Enum.KeyCode.H then
        isRunning = not isRunning
        
        if isRunning then
            ToggleBtn.Text = "STOP"
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
            Status.Text = "Status: ON"
            StartLoop()
        else
            StopLoop()
        end
    end
end)

-- ============================================
-- 7. AUTO START
-- ============================================

if Settings.AutoStart then
    task.wait(2)
    isRunning = true
    ToggleBtn.Text = "STOP"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    Status.Text = "Status: ON"
    StartLoop()
end

-- ============================================
-- 8. DRAG GUI
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
-- 9. PRINT STATUS
-- ============================================

print("🌀 Auto Claw Spin Script Loaded!")
print("📌 Hold Duration: " .. Settings.HoldDuration .. "s")
print("📌 Use +/- buttons to adjust hold time")
print("📌 Press 'H' to toggle")
