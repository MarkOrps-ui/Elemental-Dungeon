-- ============================================
-- AUTO CLAW SPIN (R Key) - FIXED
-- ============================================

-- ============================================
-- 1. SETTINGS
-- ============================================

local Settings = {
    SkillKey = "R",
    Method = "Tap",          -- "Hold", "Tap", "Spam", "ClickAndHold"
    HoldDuration = 0.5,      -- For Hold method
    TapCount = 3,            -- For Spam method (number of taps)
    Cooldown = 5,            -- Wait between activations (seconds)
    AutoStart = true,
}

-- ============================================
-- 2. GUI
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

local MethodDisplay = Instance.new("TextLabel")
MethodDisplay.Size = UDim2.new(1, 0, 0, 25)
MethodDisplay.Position = UDim2.new(0, 0, 0, 55)
MethodDisplay.Text = "Method: " .. Settings.Method
MethodDisplay.TextScaled = true
MethodDisplay.BackgroundTransparency = 1
MethodDisplay.TextColor3 = Color3.fromRGB(200, 200, 100)
MethodDisplay.Parent = Frame

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 80, 0, 30)
ToggleBtn.Position = UDim2.new(0.5, -40, 0, 85)
ToggleBtn.Text = "START"
ToggleBtn.TextScaled = true
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Parent = Frame

-- Method Switch Button
local MethodBtn = Instance.new("TextButton")
MethodBtn.Size = UDim2.new(0, 120, 0, 25)
MethodBtn.Position = UDim2.new(0.5, -60, 0, 120)
MethodBtn.Text = "Switch Method"
MethodBtn.TextScaled = true
MethodBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
MethodBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MethodBtn.BorderSizePixel = 0
MethodBtn.Parent = Frame

-- ============================================
-- 3. KEY FUNCTIONS
-- ============================================

local VirtualInput = game:GetService("VirtualInputManager")

function PressKey(Key)
    local KeyCode = Enum.KeyCode[Key]
    if not KeyCode then return end
    VirtualInput:SendKeyEvent(true, KeyCode, false, game)
end

function ReleaseKey(Key)
    local KeyCode = Enum.KeyCode[Key]
    if not KeyCode then return end
    VirtualInput:SendKeyEvent(false, KeyCode, false, game)
end

function TapKey(Key)
    local KeyCode = Enum.KeyCode[Key]
    if not KeyCode then return end
    VirtualInput:SendKeyEvent(true, KeyCode, false, game)
    task.wait(0.05)
    VirtualInput:SendKeyEvent(false, KeyCode, false, game)
end

-- ============================================
-- 4. ACTIVATION METHODS
-- ============================================

local Methods = {"Hold", "Tap", "Spam", "ClickAndHold"}
local MethodIndex = 1

function ActivateSkill(Key)
    local method = Settings.Method
    
    if method == "Hold" then
        -- Hold R for duration
        PressKey(Key)
        task.wait(Settings.HoldDuration)
        ReleaseKey(Key)
        
    elseif method == "Tap" then
        -- Quick tap
        TapKey(Key)
        
    elseif method == "Spam" then
        -- Rapid taps
        for i = 1, Settings.TapCount do
            TapKey(Key)
            task.wait(0.1)
        end
        
    elseif method == "ClickAndHold" then
        -- Press R, then click, then release
        PressKey(Key)
        task.wait(0.1)
        -- Simulate click
        local VirtualUser = game:GetService("VirtualUser")
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton1(Vector2.new(0, 0))
        end)
        task.wait(0.3)
        ReleaseKey(Key)
    end
end

-- ============================================
-- 5. AUTO LOOP
-- ============================================

local isRunning = false
local Holding = false

function StartLoop()
    if Holding then return end
    Holding = true
    
    task.spawn(function()
        while Holding and isRunning do
            task.wait(0.3)
            
            local Character = game.Players.LocalPlayer.Character
            if not Character then
                task.wait(1)
                continue
            end
            
            local Humanoid = Character:FindFirstChild("Humanoid")
            if not Humanoid or Humanoid.Health <= 0 then
                task.wait(2)
                continue
            end
            
            -- Check for mobs
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
                Status.Text = "🌀 Using Claw Spin..."
                ActivateSkill(Settings.SkillKey)
                
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
-- 6. GUI BUTTONS
-- ============================================

ToggleBtn.MouseButton1Click:Connect(function()
    isRunning = not isRunning
    
    if isRunning then
        ToggleBtn.Text = "STOP"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
        Status.Text = "Status: ON - " .. Settings.Method
        StartLoop()
    else
        StopLoop()
    end
end)

MethodBtn.MouseButton1Click:Connect(function()
    MethodIndex = MethodIndex + 1
    if MethodIndex > #Methods then MethodIndex = 1 end
    Settings.Method = Methods[MethodIndex]
    MethodDisplay.Text = "Method: " .. Settings.Method
    
    print("🔄 Changed to method: " .. Settings.Method)
    
    -- If running, restart
    if isRunning then
        Holding = false
        task.wait(0.5)
        StartLoop()
    end
end)

-- ============================================
-- 7. KEYBIND (Press 'H' to toggle)
-- ============================================

local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(Input, Processed)
    if not Processed and Input.KeyCode == Enum.KeyCode.H then
        isRunning = not isRunning
        
        if isRunning then
            ToggleBtn.Text = "STOP"
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
            Status.Text = "Status: ON - " .. Settings.Method
            StartLoop()
        else
            StopLoop()
        end
    end
end)

-- ============================================
-- 8. AUTO START
-- ============================================

if Settings.AutoStart then
    task.wait(2)
    isRunning = true
    ToggleBtn.Text = "STOP"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    Status.Text = "Status: ON - " .. Settings.Method
    StartLoop()
end

-- ============================================
-- 9. DRAG GUI
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
-- 10. PRINT STATUS
-- ============================================

print("🌀 Auto Claw Spin Script Loaded!")
print("📌 Key: R")
print("📌 Methods available: Hold, Tap, Spam, ClickAndHold")
print("📌 Click 'Switch Method' to try different activation methods")
print("📌 Press 'H' to toggle")
