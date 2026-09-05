-- ============================================
-- KILL ALL MOBS - COMPLETE SCRIPT
-- ============================================

-- ============================================
-- GUI
-- ============================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "KillAuraGUI"

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0.01, 0, 0.5, -50)
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
Title.Text = "💀 Kill Aura"
Title.TextScaled = true
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 100, 100)
Title.Parent = Frame

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 25)
Status.Position = UDim2.new(0, 0, 0, 28)
Status.Text = "⏹️ Off"
Status.TextScaled = true
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.fromRGB(255, 255, 255)
Status.Font = Enum.Font.SourceSans
Status.Parent = Frame

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 80, 0, 28)
ToggleBtn.Position = UDim2.new(0.5, -40, 0, 58)
ToggleBtn.Text = "START"
ToggleBtn.TextScaled = true
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Parent = Frame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = ToggleBtn

-- ============================================
-- KILL FUNCTIONS
-- ============================================

local KillAuraActive = false
local KillAuraTask = nil

function KillAllMobs()
    local Mobs = workspace:FindFirstChild("Mobs")
    if not Mobs then 
        print("❌ No Mobs found!")
        return 
    end
    
    local KillCount = 0
    
    for _, Mob in pairs(Mobs:GetChildren()) do
        if Mob:IsA("Model") then
            local Humanoid = Mob:FindFirstChild("Humanoid")
            if Humanoid and Humanoid.Health > 0 then
                -- DIRECT KILL
                Humanoid.Health = 0
                KillCount = KillCount + 1
            end
        end
    end
    
    print("✅ Killed " .. KillCount .. " mobs!")
    Status.Text = "💀 Killed " .. KillCount .. " mobs"
    Status.TextColor3 = Color3.fromRGB(255, 100, 100)
    task.wait(1)
    if KillAuraActive then
        Status.Text = "💀 Kill Aura ON"
    else
        Status.Text = "⏹️ Off"
    end
end

function StartKillAura()
    if KillAuraActive then return end
    KillAuraActive = true
    
    print("💀 Kill Aura ACTIVATED")
    Status.Text = "💀 Kill Aura ON"
    Status.TextColor3 = Color3.fromRGB(255, 50, 50)
    ToggleBtn.Text = "STOP"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    
    KillAuraTask = task.spawn(function()
        while KillAuraActive do
            KillAllMobs()
            task.wait(0.5) -- Check every 0.5 seconds
        end
    end)
end

function StopKillAura()
    KillAuraActive = false
    if KillAuraTask then
        task.cancel(KillAuraTask)
        KillAuraTask = nil
    end
    print("⏹️ Kill Aura DEACTIVATED")
    Status.Text = "⏹️ Off"
    Status.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.Text = "START"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
end

-- ============================================
-- BUTTONS
-- ============================================

ToggleBtn.MouseButton1Click:Connect(function()
    if KillAuraActive then
        StopKillAura()
    else
        StartKillAura()
    end
end)

-- ============================================
-- KEYBIND: Press 'L' to toggle Kill Aura
-- ============================================

local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(Input, Processed)
    if not Processed and Input.KeyCode == Enum.KeyCode.L then
        if KillAuraActive then
            StopKillAura()
        else
            StartKillAura()
        end
    end
end)

-- Press 'K' for one-time kill all
UserInputService.InputBegan:Connect(function(Input, Processed)
    if not Processed and Input.KeyCode == Enum.KeyCode.K then
        KillAllMobs()
    end
end)

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

-- ============================================
-- START
-- ============================================

print("💀 Kill Aura Script Loaded!")
print("📌 Press 'L' to toggle Kill Aura")
print("📌 Press 'K' for one-time kill all")
print("📌 Click START/STOP in GUI")
