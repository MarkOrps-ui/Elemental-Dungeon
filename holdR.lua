-- ============================================
-- STANDALONE AUTO HOLD R SCRIPT
-- Works alongside any other script
-- ============================================

-- ============================================
-- 1. SETTINGS (You can change these)
-- ============================================

local Settings = {
    HoldDuration = 5,      -- How long to hold R (seconds)
    Cooldown = 8,          -- Wait time between holds (seconds)
    AutoStart = true,      -- Auto start when script runs
    OnlyInDungeon = true,  -- Only work in dungeon (not lobby)
}

-- ============================================
-- 2. SIMPLE GUI (Optional - shows status)
-- ============================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "AutoHoldRGUI"

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0.01, 0, 0.5, -50)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Frame.BackgroundTransparency = 0.1
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 30)
Status.Position = UDim2.new(0, 0, 0, 5)
Status.Text = "✈️ Auto Hold R: OFF"
Status.TextScaled = true
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.fromRGB(255, 200, 100)
Status.Parent = Frame

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 80, 0, 30)
ToggleBtn.Position = UDim2.new(0.5, -40, 0, 40)
ToggleBtn.Text = "START"
ToggleBtn.TextScaled = true
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Parent = Frame

local isRunning = false
local HoldingR = false

-- ============================================
-- 3. HOLD R FUNCTION
-- ============================================

function HoldKeyR(Duration)
    local VirtualInput = game:GetService("VirtualInputManager")
    local KeyCode = Enum.KeyCode.R
    
    -- Press R down
    VirtualInput:SendKeyEvent(true, KeyCode, false, game)
    
    -- Hold for duration
    local StartTime = tick()
    while tick() - StartTime < Duration do
        task.wait(0.05)
        VirtualInput:SendKeyEvent(true, KeyCode, false, game)
    end
    
    -- Release R
    VirtualInput:SendKeyEvent(false, KeyCode, false, game)
end

-- ============================================
-- 4. AUTO HOLD LOOP
-- ============================================

function StartHoldLoop()
    if HoldingR then return end
    HoldingR = true
    
    task.spawn(function()
        while HoldingR and isRunning do
            task.wait(0.5)
            
            -- Check if in dungeon (not lobby)
            if Settings.OnlyInDungeon and game.PlaceId == 10515146389 then
                task.wait(1)
                continue
            end
            
            -- Check if character exists and is alive
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
                -- Hold R
                Status.Text = "✈️ Holding R... (" .. Settings.HoldDuration .. "s)"
                HoldKeyR(Settings.HoldDuration)
                
                -- Wait for cooldown
                Status.Text = "✈️ Cooldown... (" .. Settings.Cooldown .. "s)"
                task.wait(Settings.Cooldown)
            else
                Status.Text = "✈️ Waiting for mobs..."
                task.wait(1)
            end
        end
        
        Status.Text = "✈️ Auto Hold R: OFF"
        HoldingR = false
    end)
end

function StopHoldLoop()
    isRunning = false
    HoldingR = false
    Status.Text = "✈️ Auto Hold R: OFF"
    ToggleBtn.Text = "START"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
end

-- ============================================
-- 5. TOGGLE BUTTON
-- ============================================

ToggleBtn.MouseButton1Click:Connect(function()
    isRunning = not isRunning
    
    if isRunning then
        ToggleBtn.Text = "STOP"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
        Status.Text = "✈️ Auto Hold R: ON"
        StartHoldLoop()
    else
        StopHoldLoop()
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
            Status.Text = "✈️ Auto Hold R: ON"
            StartHoldLoop()
        else
            StopHoldLoop()
        end
    end
end)

-- ============================================
-- 7. AUTO START (If enabled)
-- ============================================

if Settings.AutoStart then
    task.wait(2) -- Wait for other scripts to load
    isRunning = true
    ToggleBtn.Text = "STOP"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    Status.Text = "✈️ Auto Hold R: ON"
    StartHoldLoop()
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

print("✈️ Auto Hold R Script Loaded!")
print("📌 Press 'H' to toggle Auto Hold R")
print("📌 Click START/STOP button in the GUI")
print("📌 Hold Duration: " .. Settings.HoldDuration .. "s")
print("📌 Cooldown: " .. Settings.Cooldown .. "s")