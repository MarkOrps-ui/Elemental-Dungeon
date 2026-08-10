-- ============================================
-- AUTO CLAW SPIN - CONTINUOUS LOOP FIX
-- ============================================

-- ============================================
-- 1. SETTINGS
-- ============================================

local Settings = {
    SkillKey = "R",
    HoldDuration = 10,
    Cooldown = 6,
    AutoStart = true,
}

-- ============================================
-- 2. KEY FUNCTIONS
-- ============================================

local VirtualInput = game:GetService("VirtualInputManager")
local KeyCode = Enum.KeyCode.R
local IsKeyPressed = false
-- ============================================
-- KITSUNE EQUIP FUNCTIONS
-- ============================================

local function IsKitsuneEquipped()
    local Character = game.Players.LocalPlayer.Character
    return Character and Character:FindFirstChild("Kitsune") ~= nil
end

local function EquipSlot2()
    local VIM = game:GetService("VirtualInputManager")

    for i = 1, 2 do
        VIM:SendKeyEvent(true, Enum.KeyCode.Two, false, game)
        task.wait(0.03)
        VIM:SendKeyEvent(false, Enum.KeyCode.Two, false, game)

        if i == 1 then
            task.wait(0.15)
        end
    end

    print("🦊 Pressed Slot 2 twice")
end

function PressKey()
    if IsKeyPressed then return end
    VirtualInput:SendKeyEvent(true, KeyCode, false, game)
    IsKeyPressed = true
    print("🔽 R Pressed")
end

function ReleaseKey()
    if not IsKeyPressed then return end
    VirtualInput:SendKeyEvent(false, KeyCode, false, game)
    IsKeyPressed = false
    print("🔼 R Released")
end

function ForceReleaseKey()
    IsKeyPressed = false
    pcall(function()
        VirtualInput:SendKeyEvent(false, KeyCode, false, game)
        task.wait(0.05)
        VirtualInput:SendKeyEvent(false, KeyCode, false, game)
    end)
    print("🔄 Force released R")
end

-- ============================================
-- 3. GUI
-- ============================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "AutoClawSpinGUI"

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 240, 0, 210)
Frame.Position = UDim2.new(0.01, 0, 0.5, -105)
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
DurationDisplay.Text = "Hold: " .. Settings.HoldDuration .. "s  |  Cooldown: " .. Settings.Cooldown .. "s"
DurationDisplay.TextScaled = true
DurationDisplay.BackgroundTransparency = 1
DurationDisplay.TextColor3 = Color3.fromRGB(200, 200, 100)
DurationDisplay.Parent = Frame

-- Toggle Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 80, 0, 30)
ToggleBtn.Position = UDim2.new(0.5, -40, 0, 85)
ToggleBtn.Text = "START"
ToggleBtn.TextScaled = true
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Parent = Frame

-- Emergency Release Button
local ReleaseBtn = Instance.new("TextButton")
ReleaseBtn.Size = UDim2.new(0, 120, 0, 25)
ReleaseBtn.Position = UDim2.new(0.5, -60, 0, 120)
ReleaseBtn.Text = "🔄 RELEASE R"
ReleaseBtn.TextScaled = true
ReleaseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ReleaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ReleaseBtn.BorderSizePixel = 0
ReleaseBtn.Parent = Frame

-- Duration Buttons
local DurationBtn = Instance.new("TextButton")
DurationBtn.Size = UDim2.new(0, 60, 0, 25)
DurationBtn.Position = UDim2.new(0.1, 0, 0, 150)
DurationBtn.Text = "+1s"
DurationBtn.TextScaled = true
DurationBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
DurationBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DurationBtn.BorderSizePixel = 0
DurationBtn.Parent = Frame

local DurationMinusBtn = Instance.new("TextButton")
DurationMinusBtn.Size = UDim2.new(0, 60, 0, 25)
DurationMinusBtn.Position = UDim2.new(0.6, 0, 0, 150)
DurationMinusBtn.Text = "-1s"
DurationMinusBtn.TextScaled = true
DurationMinusBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
DurationMinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DurationMinusBtn.BorderSizePixel = 0
DurationMinusBtn.Parent = Frame

-- Cooldown Buttons
local CooldownBtn = Instance.new("TextButton")
CooldownBtn.Size = UDim2.new(0, 50, 0, 25)
CooldownBtn.Position = UDim2.new(0.35, 0, 0, 180)
CooldownBtn.Text = "+1s CD"
CooldownBtn.TextScaled = true
CooldownBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
CooldownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CooldownBtn.BorderSizePixel = 0
CooldownBtn.Parent = Frame

local CooldownMinusBtn = Instance.new("TextButton")
CooldownMinusBtn.Size = UDim2.new(0, 50, 0, 25)
CooldownMinusBtn.Position = UDim2.new(0.6, 0, 0, 180)
CooldownMinusBtn.Text = "-1s CD"
CooldownMinusBtn.TextScaled = true
CooldownMinusBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
CooldownMinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CooldownMinusBtn.BorderSizePixel = 0
CooldownMinusBtn.Parent = Frame

-- ============================================
-- 4. MAIN LOOP (FIXED - CONTINUOUS)
-- ============================================

local isRunning = false
local LoopTask = nil
local HoldTask = nil
local IsHolding = false

function PerformHold(Duration)
    if IsHolding then return end
    IsHolding = true
    
    task.spawn(function()
        PressKey()
        Status.Text = "🌀 Holding R... " .. Duration .. "s"
        print("🌀 Holding R for " .. Duration .. "s")
        
        local StartTime = tick()
        while tick() - StartTime < Duration do
            if not isRunning then
                ReleaseKey()
                IsHolding = false
                Status.Text = "Status: Stopped"
                return
            end
            task.wait(0.05)
            if IsKeyPressed then
                pcall(function()
                    VirtualInput:SendKeyEvent(true, KeyCode, false, game)
                end)
            end
        end
        
        ReleaseKey()
        IsHolding = false
        Status.Text = "✅ Hold complete - " .. Settings.Cooldown .. "s cooldown"
        print("✅ Hold complete, cooldown " .. Settings.Cooldown .. "s")
    end)
end

function StartLoop()
    -- Stop any existing loop
    if LoopTask then
        task.cancel(LoopTask)
        LoopTask = nil
    end
    
    -- Ensure key is released
    ForceReleaseKey()
    IsHolding = false
    
    isRunning = true
    Status.Text = "Status: ON - Searching for mobs..."
    ToggleBtn.Text = "STOP"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    
    LoopTask = task.spawn(function()
        while isRunning do
            -- Check character
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
            
            if HasTarget and isRunning then

                -- Equip Kitsune if not already equipped
                if not IsKitsuneEquipped() then
                    Status.Text = "🦊 Equipping Kitsune..."
                    EquipSlot2()
                    task.wait(0.25)
                end
            
                -- Perform the hold
                Status.Text = "🎯 Target found! Holding R..."
                PerformHold(Settings.HoldDuration)
                
                -- Wait for hold to complete (track it)
                while IsHolding and isRunning do
                    task.wait(0.1)
                end
                
                -- Cooldown after hold completes
                if isRunning then
                    Status.Text = "⏳ Cooldown... (" .. Settings.Cooldown .. "s)"
                    print("⏳ Cooldown " .. Settings.Cooldown .. "s")
                    
                    local CooldownStart = tick()
                    while tick() - CooldownStart < Settings.Cooldown and isRunning do
                        task.wait(0.1)
                        local Remaining = math.ceil(Settings.Cooldown - (tick() - CooldownStart))
                        Status.Text = "⏳ Cooldown... " .. Remaining .. "s remaining"
                    end
                end
            else
                Status.Text = "⏳ Waiting for mobs..."
                task.wait(1)
            end
        end
        
        -- Loop ended - ensure key is released
        ForceReleaseKey()
        IsHolding = false
        Status.Text = "Status: OFF"
        ToggleBtn.Text = "START"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
        print("🛑 Loop stopped")
    end)
end

function StopLoop()
    isRunning = false
    
    -- Cancel loop task
    if LoopTask then
        task.cancel(LoopTask)
        LoopTask = nil
    end
    
    -- Release key
    ForceReleaseKey()
    IsHolding = false
    
    Status.Text = "Status: OFF"
    ToggleBtn.Text = "START"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
    print("🛑 Stopped")
end

-- ============================================
-- 5. GUI BUTTONS
-- ============================================

ToggleBtn.MouseButton1Click:Connect(function()
    if isRunning then
        StopLoop()
    else
        StartLoop()
    end
end)

ReleaseBtn.MouseButton1Click:Connect(function()
    print("🔄 Emergency Release!")
    ForceReleaseKey()
    IsHolding = false
    Status.Text = "🔄 Key Released!"
    task.wait(0.5)
    if isRunning then
        Status.Text = "Status: ON - Ready"
    else
        Status.Text = "Status: OFF"
    end
end)

DurationBtn.MouseButton1Click:Connect(function()
    Settings.HoldDuration = Settings.HoldDuration + 1
    DurationDisplay.Text = "Hold: " .. Settings.HoldDuration .. "s  |  Cooldown: " .. Settings.Cooldown .. "s"
    print("⏱️ Hold duration: " .. Settings.HoldDuration .. "s")
end)

DurationMinusBtn.MouseButton1Click:Connect(function()
    if Settings.HoldDuration > 1 then
        Settings.HoldDuration = Settings.HoldDuration - 1
        DurationDisplay.Text = "Hold: " .. Settings.HoldDuration .. "s  |  Cooldown: " .. Settings.Cooldown .. "s"
        print("⏱️ Hold duration: " .. Settings.HoldDuration .. "s")
    end
end)

CooldownBtn.MouseButton1Click:Connect(function()
    Settings.Cooldown = Settings.Cooldown + 1
    DurationDisplay.Text = "Hold: " .. Settings.HoldDuration .. "s  |  Cooldown: " .. Settings.Cooldown .. "s"
    print("⏱️ Cooldown: " .. Settings.Cooldown .. "s")
end)

CooldownMinusBtn.MouseButton1Click:Connect(function()
    if Settings.Cooldown > 0 then
        Settings.Cooldown = Settings.Cooldown - 1
        DurationDisplay.Text = "Hold: " .. Settings.HoldDuration .. "s  |  Cooldown: " .. Settings.Cooldown .. "s"
        print("⏱️ Cooldown: " .. Settings.Cooldown .. "s")
    end
end)

-- ============================================
-- 6. KEYBINDS
-- ============================================

local UserInputService = game:GetService("UserInputService")

-- 'H' to toggle
UserInputService.InputBegan:Connect(function(Input, Processed)
    if not Processed and Input.KeyCode == Enum.KeyCode.H then
        if isRunning then
            StopLoop()
        else
            StartLoop()
        end
    end
end)

-- 'K' to emergency release
UserInputService.InputBegan:Connect(function(Input, Processed)
    if not Processed and Input.KeyCode == Enum.KeyCode.K then
        print("🔄 Emergency Release (K pressed)!")
        ForceReleaseKey()
        IsHolding = false
        Status.Text = "🔄 Key Released!"
        task.wait(0.5)
        if isRunning then
            Status.Text = "Status: ON - Ready"
        else
            Status.Text = "Status: OFF"
        end
    end
end)

-- ============================================
-- 7. AUTO START
-- ============================================

if Settings.AutoStart then
    task.wait(2)
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
-- 9. CLEANUP
-- ============================================

game:GetService("RunService").Heartbeat:Connect(function()
    if not isRunning and IsKeyPressed then
        ForceReleaseKey()
    end
end)

print("🌀 Auto Claw Spin Script Loaded!")
print("📌 Hold: " .. Settings.HoldDuration .. "s | Cooldown: " .. Settings.Cooldown .. "s")
print("📌 Press 'H' to toggle ON/OFF")
print("📌 Press 'K' for EMERGENCY RELEASE")
print("📌 Use +/- buttons to adjust times")
