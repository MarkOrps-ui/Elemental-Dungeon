-- ============================================
-- AUTO CLAW SPIN - SIMPLIFIED
-- ============================================

-- ============================================
-- 1. SETTINGS
-- ============================================

local Settings = {
    SkillKey = "R",
    HoldDuration = 10,
    Cooldown = 6,
    AutoStart = true,
    HotbarSlot = 1,          -- Kitsune is in slot 2
}

-- ============================================
-- 2. KEY FUNCTIONS
-- ============================================

local VirtualInput = game:GetService("VirtualInputManager")
local KeyCode = Enum.KeyCode.R
local IsKeyPressed = false

function PressKey()
    if IsKeyPressed then return end
    VirtualInput:SendKeyEvent(true, KeyCode, false, game)
    IsKeyPressed = true
end

function ReleaseKey()
    if not IsKeyPressed then return end
    VirtualInput:SendKeyEvent(false, KeyCode, false, game)
    IsKeyPressed = false
end

function ForceReleaseKey()
    IsKeyPressed = false
    pcall(function()
        VirtualInput:SendKeyEvent(false, KeyCode, false, game)
        task.wait(0.05)
        VirtualInput:SendKeyEvent(false, KeyCode, false, game)
    end)
end

-- ============================================
-- 3. EQUIP KITSUNE (Press hotbar key)
-- ============================================

function EquipKitsune()
    print("🔄 Equipping Kitsune (Slot " .. Settings.HotbarSlot .. ")...")
    Status.Text = "🔄 Equipping Kitsune..."
    
    -- Press the hotbar key (2)
    local Key = Enum.KeyCode["Key" .. Settings.HotbarSlot]
    if Key then
        VirtualInput:SendKeyEvent(true, Key, false, game)
        task.wait(0.05)
        VirtualInput:SendKeyEvent(false, Key, false, game)
        task.wait(0.1)
        print("✅ Pressed key " .. Settings.HotbarSlot)
    end
    
    Status.Text = "✅ Equip attempted!"
end

-- ============================================
-- 4. GUI (Always visible, compact)
-- ============================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "ClawSpinGUI"

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 180, 0, 110)
Frame.Position = UDim2.new(0.01, 0, 0.5, -55)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Frame.BackgroundTransparency = 0.1
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = Frame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 22)
Title.Position = UDim2.new(0, 0, 0, 2)
Title.Text = "🌀 Claw Spin"
Title.TextScaled = true
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 200, 100)
Title.Parent = Frame

-- Status
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Position = UDim2.new(0, 0, 0, 26)
Status.Text = "Status: OFF"
Status.TextScaled = true
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.fromRGB(200, 200, 200)
Status.Font = Enum.Font.SourceSans
Status.Parent = Frame

-- Start/Stop Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 60, 0, 28)
ToggleBtn.Position = UDim2.new(0.05, 0, 0, 50)
ToggleBtn.Text = "START"
ToggleBtn.TextScaled = true
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Parent = Frame

local TogCorner = Instance.new("UICorner")
TogCorner.CornerRadius = UDim.new(0, 6)
TogCorner.Parent = ToggleBtn

-- Equip Button (Slot 2)
local EquipBtn = Instance.new("TextButton")
EquipBtn.Size = UDim2.new(0, 50, 0, 28)
EquipBtn.Position = UDim2.new(0.55, 0, 0, 50)
EquipBtn.Text = "⚔️2"
EquipBtn.TextScaled = true
EquipBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
EquipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EquipBtn.BorderSizePixel = 0
EquipBtn.Parent = Frame

local EquipCorner = Instance.new("UICorner")
EquipCorner.CornerRadius = UDim.new(0, 6)
EquipCorner.Parent = EquipBtn

-- Release Button
local ReleaseBtn = Instance.new("TextButton")
ReleaseBtn.Size = UDim2.new(0, 50, 0, 28)
ReleaseBtn.Position = UDim2.new(0.55, 0, 0, 80)
ReleaseBtn.Text = "🔄R"
ReleaseBtn.TextScaled = true
ReleaseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ReleaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ReleaseBtn.BorderSizePixel = 0
ReleaseBtn.Parent = Frame

local RelCorner = Instance.new("UICorner")
RelCorner.CornerRadius = UDim.new(0, 6)
RelCorner.Parent = ReleaseBtn

-- Duration display
local DurDisplay = Instance.new("TextLabel")
DurDisplay.Size = UDim2.new(0, 70, 0, 20)
DurDisplay.Position = UDim2.new(0.05, 0, 0, 82)
DurDisplay.Text = "Hold: " .. Settings.HoldDuration .. "s"
DurDisplay.TextScaled = true
DurDisplay.BackgroundTransparency = 1
DurDisplay.TextColor3 = Color3.fromRGB(150, 150, 150)
DurDisplay.Font = Enum.Font.SourceSans
DurDisplay.Parent = Frame

-- ============================================
-- 5. BUTTON FUNCTIONS
-- ============================================

ToggleBtn.MouseButton1Click:Connect(function()
    if isRunning then
        StopLoop()
    else
        StartLoop()
    end
end)

EquipBtn.MouseButton1Click:Connect(function()
    EquipKitsune()
end)

ReleaseBtn.MouseButton1Click:Connect(function()
    print("🔄 Release R!")
    ForceReleaseKey()
    IsHolding = false
    Status.Text = "🔄 Released!"
    task.wait(0.5)
    if isRunning then
        Status.Text = "Status: ON"
    else
        Status.Text = "Status: OFF"
    end
end)

-- ============================================
-- 6. MAIN LOOP
-- ============================================

local isRunning = false
local LoopTask = nil
local IsHolding = false

function PerformHold(Duration)
    if IsHolding then return end
    IsHolding = true
    
    task.spawn(function()
        PressKey()
        Status.Text = "🌀 Holding... " .. Duration .. "s"
        
        local StartTime = tick()
        while tick() - StartTime < Duration do
            if not isRunning then
                ReleaseKey()
                IsHolding = false
                Status.Text = "Stopped"
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
        Status.Text = "✅ Cooldown " .. Settings.Cooldown .. "s"
    end)
end

function StartLoop()
    if LoopTask then
        task.cancel(LoopTask)
        LoopTask = nil
    end
    
    ForceReleaseKey()
    IsHolding = false
    
    isRunning = true
    Status.Text = "Status: ON"
    ToggleBtn.Text = "STOP"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    
    -- Auto equip on start
    EquipKitsune()
    task.wait(0.5)
    
    LoopTask = task.spawn(function()
        while isRunning do
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
                PerformHold(Settings.HoldDuration)
                
                while IsHolding and isRunning do
                    task.wait(0.1)
                end
                
                if isRunning then
                    local CooldownStart = tick()
                    while tick() - CooldownStart < Settings.Cooldown and isRunning do
                        task.wait(0.1)
                        local Remaining = math.ceil(Settings.Cooldown - (tick() - CooldownStart))
                        Status.Text = "⏳ " .. Remaining .. "s"
                    end
                end
            else
                Status.Text = "⏳ Waiting..."
                task.wait(1)
            end
        end
        
        ForceReleaseKey()
        IsHolding = false
        Status.Text = "OFF"
        ToggleBtn.Text = "START"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
    end)
end

function StopLoop()
    isRunning = false
    if LoopTask then
        task.cancel(LoopTask)
        LoopTask = nil
    end
    ForceReleaseKey()
    IsHolding = false
    Status.Text = "OFF"
    ToggleBtn.Text = "START"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
end

-- ============================================
-- 7. KEYBINDS
-- ============================================

local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(Input, Processed)
    if not Processed and Input.KeyCode == Enum.KeyCode.H then
        if isRunning then
            StopLoop()
        else
            StartLoop()
        end
    end
end)

UserInputService.InputBegan:Connect(function(Input, Processed)
    if not Processed and Input.KeyCode == Enum.KeyCode.K then
        ForceReleaseKey()
        IsHolding = false
        Status.Text = "Released!"
        task.wait(0.5)
        if isRunning then
            Status.Text = "ON"
        else
            Status.Text = "OFF"
        end
    end
end)

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
-- 9. AUTO START
-- ============================================

if Settings.AutoStart then
    task.wait(2)
    StartLoop()
end

-- ============================================
-- 10. CLEANUP
-- ============================================

game:GetService("RunService").Heartbeat:Connect(function()
    if not isRunning and IsKeyPressed then
        ForceReleaseKey()
    end
end)

print("🌀 Claw Spin Script Loaded!")
print("📌 Press 'H' to toggle ON/OFF")
print("📌 Press 'K' to release R")
print("📌 Click '⚔️2' to equip Kitsune (Slot 2)")
print("📌 Click '🔄R' to release R manually")
