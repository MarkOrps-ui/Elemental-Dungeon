-- ============================================
-- AUTO CLAW SPIN - SIMPLE FIXED VERSION
-- ============================================

-- ============================================
-- 1. SETTINGS
-- ============================================

local Settings = {
    SkillKey = "R",
    HoldDuration = 8,
    Cooldown = 2,
    AutoStart = true,
}

-- ============================================
-- 2. SIMPLE KEY FUNCTIONS
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
-- 3. SIMPLE EQUIP FUNCTION (FIXED)
-- ============================================

function EquipKitsune()
    print("🔄 Trying to equip Kitsune...")
    Status.Text = "🔄 Equipping Kitsune..."
    
    -- Method 1: Use the hotbar keys (1-8)
    pcall(function()
        print("🔧 Trying hotbar keys (1-8)...")
        for i = 1, 8 do
            local Key = Enum.KeyCode["Key" .. i]
            if Key then
                VirtualInput:SendKeyEvent(true, Key, false, game)
                task.wait(0.05)
                VirtualInput:SendKeyEvent(false, Key, false, game)
                task.wait(0.1)
            end
        end
    end)
    
    -- Method 2: Try to click the inventory item
    task.wait(0.5)
    pcall(function()
        local Player = game.Players.LocalPlayer
        local PlayerGui = Player:FindFirstChild("PlayerGui")
        if PlayerGui then
            local Inventory = PlayerGui:FindFirstChild("Inventory")
            if Inventory then
                local Main = Inventory:FindFirstChild("Main")
                if Main then
                    local InventoryFrame = Main:FindFirstChild("InventoryFrame")
                    if InventoryFrame then
                        local Items = InventoryFrame:FindFirstChild("Items")
                        if Items then
                            for _, Item in pairs(Items:GetChildren()) do
                                if Item:IsA("TextButton") then
                                    local ItemName = Item.Name or ""
                                    if ItemName:find("Kitsune") or ItemName:find("Infernal") then
                                        print("🔧 Clicking on: " .. ItemName)
                                        pcall(function()
                                            Item:Activate()
                                            task.wait(0.3)
                                        end)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
    
    Status.Text = "✅ Equip attempted!"
    print("✅ Equip sequence complete!")
end

-- ============================================
-- 4. CREATE SIMPLE BUTTON (Floating)
-- ============================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "ClawSpinGUI"

-- Main Frame - Always visible (small)
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 130)
Frame.Position = UDim2.new(0.01, 0, 0.5, -65)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Frame.BackgroundTransparency = 0.1
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = Frame

-- Title (clickable to toggle open/close)
local Title = Instance.new("TextButton")
Title.Size = UDim2.new(1, 0, 0, 25)
Title.Position = UDim2.new(0, 0, 0, 2)
Title.Text = "🌀 Claw Spin [Click to toggle]"
Title.TextScaled = true
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 200, 100)
Title.Parent = Frame

-- Status
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 25)
Status.Position = UDim2.new(0, 0, 0, 30)
Status.Text = "Status: OFF"
Status.TextScaled = true
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.fromRGB(200, 200, 200)
Status.Parent = Frame

-- Start/Stop Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 70, 0, 30)
ToggleBtn.Position = UDim2.new(0.05, 0, 0, 60)
ToggleBtn.Text = "START"
ToggleBtn.TextScaled = true
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Parent = Frame

local TogCorner = Instance.new("UICorner")
TogCorner.CornerRadius = UDim.new(0, 6)
TogCorner.Parent = ToggleBtn

-- Equip Button
local EquipBtn = Instance.new("TextButton")
EquipBtn.Size = UDim2.new(0, 70, 0, 30)
EquipBtn.Position = UDim2.new(0.55, 0, 0, 60)
EquipBtn.Text = "⚔️ Equip"
EquipBtn.TextScaled = true
EquipBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
EquipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EquipBtn.BorderSizePixel = 0
EquipBtn.Parent = Frame

local EquipCorner = Instance.new("UICorner")
EquipCorner.CornerRadius = UDim.new(0, 6)
EquipCorner.Parent = EquipBtn

-- Duration Display
local DurDisplay = Instance.new("TextLabel")
DurDisplay.Size = UDim2.new(1, 0, 0, 20)
DurDisplay.Position = UDim2.new(0, 0, 0, 95)
DurDisplay.Text = "Hold: " .. Settings.HoldDuration .. "s | CD: " .. Settings.Cooldown .. "s"
DurDisplay.TextScaled = true
DurDisplay.BackgroundTransparency = 1
DurDisplay.TextColor3 = Color3.fromRGB(150, 150, 150)
DurDisplay.Font = Enum.Font.SourceSans
DurDisplay.Parent = Frame

-- ============================================
-- 5. EXPANDED GUI (Hidden by default)
-- ============================================

local ExpandedFrame = Instance.new("Frame")
ExpandedFrame.Size = UDim2.new(0, 200, 0, 90)
ExpandedFrame.Position = UDim2.new(0, 0, 1, 5)
ExpandedFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
ExpandedFrame.BackgroundTransparency = 0.1
ExpandedFrame.BorderSizePixel = 0
ExpandedFrame.Visible = false
ExpandedFrame.Parent = Frame

local ExpCorner = Instance.new("UICorner")
ExpCorner.CornerRadius = UDim.new(0, 10)
ExpCorner.Parent = ExpandedFrame

-- Duration buttons
local DurPlus = Instance.new("TextButton")
DurPlus.Size = UDim2.new(0, 60, 0, 25)
DurPlus.Position = UDim2.new(0.05, 0, 0, 5)
DurPlus.Text = "+1s"
DurPlus.TextScaled = true
DurPlus.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
DurPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
DurPlus.BorderSizePixel = 0
DurPlus.Parent = ExpandedFrame

local DurMinus = Instance.new("TextButton")
DurMinus.Size = UDim2.new(0, 60, 0, 25)
DurMinus.Position = UDim2.new(0.35, 0, 0, 5)
DurMinus.Text = "-1s"
DurMinus.TextScaled = true
DurMinus.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
DurMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
DurMinus.BorderSizePixel = 0
DurMinus.Parent = ExpandedFrame

local CDPlus = Instance.new("TextButton")
CDPlus.Size = UDim2.new(0, 60, 0, 25)
CDPlus.Position = UDim2.new(0.05, 0, 0, 35)
CDPlus.Text = "+1s CD"
CDPlus.TextScaled = true
CDPlus.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
CDPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
CDPlus.BorderSizePixel = 0
CDPlus.Parent = ExpandedFrame

local CDMinus = Instance.new("TextButton")
CDMinus.Size = UDim2.new(0, 60, 0, 25)
CDMinus.Position = UDim2.new(0.35, 0, 0, 35)
CDMinus.Text = "-1s CD"
CDMinus.TextScaled = true
CDMinus.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
CDMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
CDMinus.BorderSizePixel = 0
CDMinus.Parent = ExpandedFrame

-- Release button
local RelBtn = Instance.new("TextButton")
RelBtn.Size = UDim2.new(0, 120, 0, 25)
RelBtn.Position = UDim2.new(0.5, -60, 0, 60)
RelBtn.Text = "🔄 Release R"
RelBtn.TextScaled = true
RelBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
RelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RelBtn.BorderSizePixel = 0
RelBtn.Parent = ExpandedFrame

-- ============================================
-- 6. TOGGLE EXPAND
-- ============================================

local isExpanded = false

Title.MouseButton1Click:Connect(function()
    isExpanded = not isExpanded
    ExpandedFrame.Visible = isExpanded
    if isExpanded then
        Frame.Size = UDim2.new(0, 200, 0, 230)
    else
        Frame.Size = UDim2.new(0, 200, 0, 130)
    end
end)

-- ============================================
-- 7. BUTTON FUNCTIONS
-- ============================================

-- Toggle Start/Stop
ToggleBtn.MouseButton1Click:Connect(function()
    if isRunning then
        StopLoop()
    else
        StartLoop()
    end
end)

-- Equip Button
EquipBtn.MouseButton1Click:Connect(function()
    EquipKitsune()
end)

-- Release Button
RelBtn.MouseButton1Click:Connect(function()
    print("🔄 Release R!")
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

-- Duration buttons
DurPlus.MouseButton1Click:Connect(function()
    Settings.HoldDuration = Settings.HoldDuration + 1
    DurDisplay.Text = "Hold: " .. Settings.HoldDuration .. "s | CD: " .. Settings.Cooldown .. "s"
end)

DurMinus.MouseButton1Click:Connect(function()
    if Settings.HoldDuration > 1 then
        Settings.HoldDuration = Settings.HoldDuration - 1
        DurDisplay.Text = "Hold: " .. Settings.HoldDuration .. "s | CD: " .. Settings.Cooldown .. "s"
    end
end)

CDPlus.MouseButton1Click:Connect(function()
    Settings.Cooldown = Settings.Cooldown + 1
    DurDisplay.Text = "Hold: " .. Settings.HoldDuration .. "s | CD: " .. Settings.Cooldown .. "s"
end)

CDMinus.MouseButton1Click:Connect(function()
    if Settings.Cooldown > 0 then
        Settings.Cooldown = Settings.Cooldown - 1
        DurDisplay.Text = "Hold: " .. Settings.HoldDuration .. "s | CD: " .. Settings.Cooldown .. "s"
    end
end)

-- ============================================
-- 8. MAIN LOOP
-- ============================================

local isRunning = false
local LoopTask = nil
local IsHolding = false

function PerformHold(Duration)
    if IsHolding then return end
    IsHolding = true
    
    task.spawn(function()
        PressKey()
        Status.Text = "🌀 Holding R... " .. Duration .. "s"
        
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
    Status.Text = "Status: ON - Searching..."
    ToggleBtn.Text = "STOP"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    
    LoopTask = task.spawn(function()
        while isRunning do
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
                Status.Text = "🎯 Target found!"
                PerformHold(Settings.HoldDuration)
                
                while IsHolding and isRunning do
                    task.wait(0.1)
                end
                
                if isRunning then
                    Status.Text = "⏳ Cooldown... (" .. Settings.Cooldown .. "s)"
                    local CooldownStart = tick()
                    while tick() - CooldownStart < Settings.Cooldown and isRunning do
                        task.wait(0.1)
                        local Remaining = math.ceil(Settings.Cooldown - (tick() - CooldownStart))
                        Status.Text = "⏳ Cooldown... " .. Remaining .. "s"
                    end
                end
            else
                Status.Text = "⏳ Waiting for mobs..."
                task.wait(1)
            end
        end
        
        ForceReleaseKey()
        IsHolding = false
        Status.Text = "Status: OFF"
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
    Status.Text = "Status: OFF"
    ToggleBtn.Text = "START"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
end

-- ============================================
-- 9. KEYBINDS
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
-- 10. DRAG GUI
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
-- 11. AUTO START
-- ============================================

if Settings.AutoStart then
    task.wait(2)
    StartLoop()
end

-- ============================================
-- 12. CLEANUP
-- ============================================

game:GetService("RunService").Heartbeat:Connect(function()
    if not isRunning and IsKeyPressed then
        ForceReleaseKey()
    end
end)

print("🌀 Auto Claw Spin Script Loaded!")
print("📌 Click title to expand/collapse GUI")
print("📌 Press 'H' to toggle")
print("📌 Press 'K' to release R")
