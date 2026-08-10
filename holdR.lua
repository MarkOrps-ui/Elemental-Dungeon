-- ============================================
-- AUTO CLAW SPIN - WITH ICON & AUTO-EQUIP
-- ============================================

-- ============================================
-- 1. SETTINGS
-- ============================================

local Settings = {
    SkillKey = "R",
    HoldDuration = 8,
    Cooldown = 2,
    AutoStart = true,
    AutoEquip = true,        -- Auto equip Kitsune on start
    KitsuneName = "Infernal Kitsune",  -- Change if different
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
-- 3. AUTO-EQUIP KITSUNE
-- ============================================

function EquipKitsune()
    if not Settings.AutoEquip then return end
    
    print("🔄 Equipping " .. Settings.KitsuneName .. "...")
    Status.Text = "🔄 Equipping " .. Settings.KitsuneName .. "..."
    
    -- Try to find and equip Kitsune
    local Player = game.Players.LocalPlayer
    local Character = Player.Character
    
    if not Character then
        print("❌ No character found")
        return
    end
    
    -- Method 1: Check if already equipped
    local HasKitsune = false
    for _, Child in pairs(Character:GetChildren()) do
        if Child:IsA("Tool") and Child.Name:find(Settings.KitsuneName) then
            HasKitsune = true
            print("✅ " .. Settings.KitsuneName .. " already equipped!")
            Status.Text = "✅ " .. Settings.KitsuneName .. " equipped!"
            return
        end
    end
    
    -- Method 2: Use ReplicatedStorage to equip
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Knit = ReplicatedStorage:FindFirstChild("Packages")
    
    if Knit then
        local KnitService = Knit:FindFirstChild("Knit")
        if KnitService then
            local Services = KnitService:FindFirstChild("Services")
            if Services then
                local InventoryService = Services:FindFirstChild("InventoryService")
                if InventoryService and InventoryService.RF then
                    local Equip = InventoryService.RF:FindFirstChild("EquipItem")
                    if Equip then
                        print("🔧 Trying to equip via InventoryService...")
                        pcall(function()
                            Equip:InvokeServer(Settings.KitsuneName)
                            print("✅ Equip command sent!")
                            Status.Text = "✅ Equip command sent!"
                            task.wait(1)
                        end)
                    end
                end
            end
        end
    end
    
    -- Method 3: Click on the item in inventory (if visible)
    pcall(function()
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
                                if Item:IsA("TextButton") and Item.Name:find(Settings.KitsuneName) then
                                    print("🔧 Clicking on " .. Settings.KitsuneName .. " in inventory...")
                                    pcall(function()
                                        Item:Activate()
                                        task.wait(0.5)
                                    end)
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
    
    -- Method 4: Press number key (if Kitsune is in hotbar)
    pcall(function()
        print("🔧 Trying hotbar keys...")
        local VirtualInput = game:GetService("VirtualInputManager")
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
    
    Status.Text = "✅ Equip attempted!"
    print("✅ Equip sequence complete!")
end

-- ============================================
-- 4. OPEN/CLOSE ICON
-- ============================================

-- Create the toggle icon (floating button)
local ToggleIcon = Instance.new("ImageButton")
ToggleIcon.Size = UDim2.new(0, 50, 0, 50)
ToggleIcon.Position = UDim2.new(0.01, 0, 0.5, -25)
ToggleIcon.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
ToggleIcon.BackgroundTransparency = 0.2
ToggleIcon.BorderSizePixel = 0
ToggleIcon.Image = "rbxassetid://6031094410" -- Gear icon
ToggleIcon.ImageColor3 = Color3.fromRGB(255, 200, 100)
ToggleIcon.Parent = game:GetService("CoreGui")
ToggleIcon.Name = "ClawSpinToggle"

-- Corner for icon
local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(0, 12)
IconCorner.Parent = ToggleIcon

-- Hover effect
ToggleIcon.MouseEnter:Connect(function()
    ToggleIcon.BackgroundTransparency = 0
    ToggleIcon.Size = UDim2.new(0, 55, 0, 55)
end)

ToggleIcon.MouseLeave:Connect(function()
    ToggleIcon.BackgroundTransparency = 0.2
    ToggleIcon.Size = UDim2.new(0, 50, 0, 50)
end)

-- ============================================
-- 5. MAIN GUI (Hidden initially)
-- ============================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "AutoClawSpinGUI"
ScreenGui.Enabled = false  -- Hidden by default

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 260, 0, 230)
Frame.Position = UDim2.new(0.5, -130, 0.5, -115)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Frame.BackgroundTransparency = 0.1
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

-- Corner
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Frame

-- Title Bar (draggable)
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TitleBar.BackgroundTransparency = 0.5
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Frame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -30, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "🌀 Claw Spin"
Title.TextScaled = true
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 200, 100)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Close button on GUI
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0.5, -12.5)
CloseBtn.Text = "✕"
CloseBtn.TextScaled = true
CloseBtn.BackgroundTransparency = 1
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TitleBar

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
    ToggleIcon.Visible = true
end)

-- Status
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 25)
Status.Position = UDim2.new(0, 0, 0, 35)
Status.Text = "Status: OFF"
Status.TextScaled = true
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.fromRGB(200, 200, 200)
Status.Parent = Frame

-- Duration Display
local DurationDisplay = Instance.new("TextLabel")
DurationDisplay.Size = UDim2.new(1, 0, 0, 25)
DurationDisplay.Position = UDim2.new(0, 0, 0, 60)
DurationDisplay.Text = "Hold: " .. Settings.HoldDuration .. "s  |  CD: " .. Settings.Cooldown .. "s"
DurationDisplay.TextScaled = true
DurationDisplay.BackgroundTransparency = 1
DurationDisplay.TextColor3 = Color3.fromRGB(200, 200, 100)
DurationDisplay.Parent = Frame

-- Toggle Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 80, 0, 30)
ToggleBtn.Position = UDim2.new(0.5, -40, 0, 90)
ToggleBtn.Text = "START"
ToggleBtn.TextScaled = true
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Parent = Frame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleBtn

-- Release Button
local ReleaseBtn = Instance.new("TextButton")
ReleaseBtn.Size = UDim2.new(0, 120, 0, 25)
ReleaseBtn.Position = UDim2.new(0.5, -60, 0, 125)
ReleaseBtn.Text = "🔄 RELEASE R"
ReleaseBtn.TextScaled = true
ReleaseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ReleaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ReleaseBtn.BorderSizePixel = 0
ReleaseBtn.Parent = Frame

local ReleaseCorner = Instance.new("UICorner")
ReleaseCorner.CornerRadius = UDim.new(0, 6)
ReleaseCorner.Parent = ReleaseBtn

-- Equip Button
local EquipBtn = Instance.new("TextButton")
EquipBtn.Size = UDim2.new(0, 120, 0, 25)
EquipBtn.Position = UDim2.new(0.5, -60, 0, 155)
EquipBtn.Text = "🔧 Equip Kitsune"
EquipBtn.TextScaled = true
EquipBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
EquipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EquipBtn.BorderSizePixel = 0
EquipBtn.Parent = Frame

local EquipCorner = Instance.new("UICorner")
EquipCorner.CornerRadius = UDim.new(0, 6)
EquipCorner.Parent = EquipBtn

-- Duration Buttons
local DurationBtn = Instance.new("TextButton")
DurationBtn.Size = UDim2.new(0, 55, 0, 25)
DurationBtn.Position = UDim2.new(0.05, 0, 0, 190)
DurationBtn.Text = "+1s"
DurationBtn.TextScaled = true
DurationBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
DurationBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DurationBtn.BorderSizePixel = 0
DurationBtn.Parent = Frame

local DurCorner = Instance.new("UICorner")
DurCorner.CornerRadius = UDim.new(0, 6)
DurCorner.Parent = DurationBtn

local DurationMinusBtn = Instance.new("TextButton")
DurationMinusBtn.Size = UDim2.new(0, 55, 0, 25)
DurationMinusBtn.Position = UDim2.new(0.35, 0, 0, 190)
DurationMinusBtn.Text = "-1s"
DurationMinusBtn.TextScaled = true
DurationMinusBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
DurationMinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DurationMinusBtn.BorderSizePixel = 0
DurationMinusBtn.Parent = Frame

local DurMinCorner = Instance.new("UICorner")
DurMinCorner.CornerRadius = UDim.new(0, 6)
DurMinCorner.Parent = DurationMinusBtn

local CooldownBtn = Instance.new("TextButton")
CooldownBtn.Size = UDim2.new(0, 55, 0, 25)
CooldownBtn.Position = UDim2.new(0.6, 0, 0, 190)
CooldownBtn.Text = "+1s CD"
CooldownBtn.TextScaled = true
CooldownBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
CooldownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CooldownBtn.BorderSizePixel = 0
CooldownBtn.Parent = Frame

local CDCorner = Instance.new("UICorner")
CDCorner.CornerRadius = UDim.new(0, 6)
CDCorner.Parent = CooldownBtn

local CooldownMinusBtn = Instance.new("TextButton")
CooldownMinusBtn.Size = UDim2.new(0, 55, 0, 25)
CooldownMinusBtn.Position = UDim2.new(0.9, -55, 0, 190)
CooldownMinusBtn.Text = "-1s CD"
CooldownMinusBtn.TextScaled = true
CooldownMinusBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
CooldownMinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CooldownMinusBtn.BorderSizePixel = 0
CooldownMinusBtn.Parent = Frame

local CDMinCorner = Instance.new("UICorner")
CDMinCorner.CornerRadius = UDim.new(0, 6)
CDMinCorner.Parent = CooldownMinusBtn

-- ============================================
-- 6. OPEN/CLOSE FUNCTIONALITY
-- ============================================

local isGuiOpen = false

-- Toggle icon click
ToggleIcon.MouseButton1Click:Connect(function()
    isGuiOpen = not isGuiOpen
    ScreenGui.Enabled = isGuiOpen
    ToggleIcon.Visible = not isGuiOpen
    
    -- If opening and auto-equip is on, equip Kitsune
    if isGuiOpen and Settings.AutoEquip then
        task.wait(0.5)
        EquipKitsune()
    end
end)

-- ============================================
-- 7. MAIN LOOP (FIXED - CONTINUOUS)
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
    if LoopTask then
        task.cancel(LoopTask)
        LoopTask = nil
    end
    
    ForceReleaseKey()
    IsHolding = false
    
    isRunning = true
    Status.Text = "Status: ON - Searching for mobs..."
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
                Status.Text = "🎯 Target found! Holding R..."
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
                        Status.Text = "⏳ Cooldown... " .. Remaining .. "s remaining"
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
        print("🛑 Loop stopped")
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
    print("🛑 Stopped")
end

-- ============================================
-- 8. GUI BUTTONS
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

EquipBtn.MouseButton1Click:Connect(function()
    EquipKitsune()
end)

DurationBtn.MouseButton1Click:Connect(function()
    Settings.HoldDuration = Settings.HoldDuration + 1
    DurationDisplay.Text = "Hold: " .. Settings.HoldDuration .. "s  |  CD: " .. Settings.Cooldown .. "s"
    print("⏱️ Hold duration: " .. Settings.HoldDuration .. "s")
end)

DurationMinusBtn.MouseButton1Click:Connect(function()
    if Settings.HoldDuration > 1 then
        Settings.HoldDuration = Settings.HoldDuration - 1
        DurationDisplay.Text = "Hold: " .. Settings.HoldDuration .. "s  |  CD: " .. Settings.Cooldown .. "s"
        print("⏱️ Hold duration: " .. Settings.HoldDuration .. "s")
    end
end)

CooldownBtn.MouseButton1Click:Connect(function()
    Settings.Cooldown = Settings.Cooldown + 1
    DurationDisplay.Text = "Hold: " .. Settings.HoldDuration .. "s  |  CD: " .. Settings.Cooldown .. "s"
    print("⏱️ Cooldown: " .. Settings.Cooldown .. "s")
end)

CooldownMinusBtn.MouseButton1Click:Connect(function()
    if Settings.Cooldown > 0 then
        Settings.Cooldown = Settings.Cooldown - 1
        DurationDisplay.Text = "Hold: " .. Settings.HoldDuration .. "s  |  CD: " .. Settings.Cooldown .. "s"
        print("⏱️ Cooldown: " .. Settings.Cooldown .. "s")
    end
end)

-- ============================================
-- 9. KEYBINDS
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
-- 10. DRAG GUI
-- ============================================

local Dragging = false
local DragStart
local StartPos

TitleBar.InputBegan:Connect(function(Input)
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

TitleBar.InputChanged:Connect(function(Input)
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
    
    -- Auto equip Kitsune
    if Settings.AutoEquip then
        EquipKitsune()
        task.wait(1)
    end
    
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

-- ============================================
-- 13. PRINT STATUS
-- ============================================

print("🌀 Auto Claw Spin Script Loaded!")
print("📌 Hold: " .. Settings.HoldDuration .. "s | Cooldown: " .. Settings.Cooldown .. "s")
print("📌 Click the GEAR ICON to open/close GUI")
print("📌 Press 'H' to toggle ON/OFF")
print("📌 Press 'K' for EMERGENCY RELEASE")
print("📌 Auto-equip Kitsune: " .. tostring(Settings.AutoEquip))
