-- ============================================
-- CLAW SPIN - SIMPLE WORKING VERSION
-- ============================================

-- ============================================
-- SETTINGS (Change these)
-- ============================================

local HoldDuration = 10      -- How long to hold R (seconds)
local Cooldown = 6          -- Wait between holds (seconds)

-- ============================================
-- KEY FUNCTIONS
-- ============================================

local VirtualInput = game:GetService("VirtualInputManager")
local IsPressed = false

function PressR()
    if IsPressed then return end
    VirtualInput:SendKeyEvent(true, Enum.KeyCode.R, false, game)
    IsPressed = true
end

function ReleaseR()
    if not IsPressed then return end
    VirtualInput:SendKeyEvent(false, Enum.KeyCode.R, false, game)
    IsPressed = false
end

function ForceReleaseR()
    IsPressed = false
    pcall(function()
        VirtualInput:SendKeyEvent(false, Enum.KeyCode.R, false, game)
        task.wait(0.05)
        VirtualInput:SendKeyEvent(false, Enum.KeyCode.R, false, game)
    end)
end

-- ============================================
-- GUI (Simple status only)
-- ============================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "ClawSpinGUI"

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 160, 0, 60)
Frame.Position = UDim2.new(0.01, 0, 0.5, -30)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Frame.BackgroundTransparency = 0.2
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = Frame

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 1, 0)
Status.Text = "🌀 OFF"
Status.TextScaled = true
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.fromRGB(255, 255, 255)
Status.Parent = Frame

-- Toggle click on the frame
Frame.MouseButton1Click:Connect(function()
    if isRunning then
        StopLoop()
    else
        StartLoop()
    end
end)

-- ============================================
-- MAIN LOOP
-- ============================================

local isRunning = false
local LoopTask = nil
local IsHolding = false

function HoldR()
    if IsHolding then return end
    IsHolding = true
    
    task.spawn(function()
        PressR()
        Status.Text = "🌀 HOLDING"
        Status.TextColor3 = Color3.fromRGB(100, 255, 100)
        
        local StartTime = tick()
        while tick() - StartTime < HoldDuration do
            if not isRunning then
                ReleaseR()
                IsHolding = false
                Status.Text = "🌀 OFF"
                Status.TextColor3 = Color3.fromRGB(255, 255, 255)
                return
            end
            task.wait(0.05)
            if IsPressed then
                pcall(function()
                    VirtualInput:SendKeyEvent(true, Enum.KeyCode.R, false, game)
                end)
            end
        end
        
        ReleaseR()
        IsHolding = false
        Status.Text = "🌀 COOLDOWN"
        Status.TextColor3 = Color3.fromRGB(255, 200, 100)
        
        -- Wait for cooldown
        local CooldownStart = tick()
        while tick() - CooldownStart < Cooldown and isRunning do
            task.wait(0.1)
            local Remaining = math.ceil(Cooldown - (tick() - CooldownStart))
            Status.Text = "🌀 " .. Remaining .. "s"
            Status.TextColor3 = Color3.fromRGB(255, 200, 100)
        end
        
        if isRunning then
            Status.Text = "🌀 READY"
            Status.TextColor3 = Color3.fromRGB(100, 255, 100)
        end
    end)
end

function StartLoop()
    if LoopTask then
        task.cancel(LoopTask)
        LoopTask = nil
    end
    
    ForceReleaseR()
    IsHolding = false
    isRunning = true
    Status.Text = "🌀 ON"
    Status.TextColor3 = Color3.fromRGB(100, 255, 100)
    
    LoopTask = task.spawn(function()
        while isRunning do
            -- Check if alive and in game
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
            
            if HasTarget and isRunning then
                HoldR()
                -- Wait for hold to finish
                while IsHolding and isRunning do
                    task.wait(0.1)
                end
            else
                Status.Text = "🌀 WAITING"
                Status.TextColor3 = Color3.fromRGB(255, 255, 100)
                task.wait(1)
            end
        end
        
        ForceReleaseR()
        IsHolding = false
        Status.Text = "🌀 OFF"
        Status.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
end

function StopLoop()
    isRunning = false
    if LoopTask then
        task.cancel(LoopTask)
        LoopTask = nil
    end
    ForceReleaseR()
    IsHolding = false
    Status.Text = "🌀 OFF"
    Status.TextColor3 = Color3.fromRGB(255, 255, 255)
end

-- ============================================
-- KEYBINDS
-- ============================================

local UserInputService = game:GetService("UserInputService")

-- H to toggle
UserInputService.InputBegan:Connect(function(Input, Processed)
    if not Processed and Input.KeyCode == Enum.KeyCode.H then
        if isRunning then
            StopLoop()
        else
            StartLoop()
        end
    end
end)

-- K to emergency release
UserInputService.InputBegan:Connect(function(Input, Processed)
    if not Processed and Input.KeyCode == Enum.KeyCode.K then
        ForceReleaseR()
        IsHolding = false
        if isRunning then
            Status.Text = "🌀 RELEASED"
            Status.TextColor3 = Color3.fromRGB(255, 100, 100)
            task.wait(0.5)
            Status.Text = "🌀 ON"
            Status.TextColor3 = Color3.fromRGB(100, 255, 100)
        end
    end
end)

-- ============================================
-- AUTO START
-- ============================================

task.wait(2)
StartLoop()

-- ============================================
-- DRAG GUI
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

print("🌀 Claw Spin Script Loaded!")
print("📌 Click the GUI box to toggle ON/OFF")
print("📌 Press 'H' to toggle")
print("📌 Press 'K' to emergency release R")
print("📌 Hold: " .. HoldDuration .. "s | Cooldown: " .. Cooldown .. "s")
