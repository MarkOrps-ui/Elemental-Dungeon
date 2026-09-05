-- ============================================
-- KILL ALL MOBS - KNIT DEEP SEARCH
-- ============================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ============================================
-- FIND DAMAGE FUNCTION IN KNIT
-- ============================================

function FindDamageFunction()
    local Knit = ReplicatedStorage:FindFirstChild("Packages")
    if not Knit then return nil end
    
    local KnitService = Knit:FindFirstChild("Knit")
    if not KnitService then return nil end
    
    local Services = KnitService:FindFirstChild("Services")
    if not Services then return nil end
    
    -- List of possible damage service names
    local ServiceNames = {
        "CombatService", "DamageService", "MobService", 
        "BattleService", "FightingService", "PlayerService",
        "WeaponService", "AttackService"
    }
    
    for _, serviceName in pairs(ServiceNames) do
        local Service = Services:FindFirstChild(serviceName)
        if Service then
            local RF = Service:FindFirstChild("RF")
            if RF then
                -- Look for damage functions
                for _, func in pairs(RF:GetChildren()) do
                    local name = func.Name:lower()
                    if name:find("damage") or name:find("hit") or name:find("attack") or 
                       name:find("deal") or name:find("kill") or name:find("hurt") then
                        print("✅ Found: " .. serviceName .. "." .. func.Name)
                        return func, Service
                    end
                end
            end
        end
    end
    
    -- If not found by name, check all services
    for _, Service in pairs(Services:GetChildren()) do
        local RF = Service:FindFirstChild("RF")
        if RF then
            for _, func in pairs(RF:GetChildren()) do
                local name = func.Name:lower()
                if name:find("damage") or name:find("hit") or name:find("attack") or 
                   name:find("deal") or name:find("kill") or name:find("hurt") then
                    print("✅ Found: " .. Service.Name .. "." .. func.Name)
                    return func, Service
                end
            end
        end
    end
    
    return nil, nil
end

-- ============================================
-- KILL ALL MOBS
-- ============================================

function KillAllMobs()
    local Mobs = workspace:FindFirstChild("Mobs")
    if not Mobs then 
        print("❌ No Mobs found!")
        return 
    end
    
    -- Get the damage function
    local DamageFunc, Service = FindDamageFunction()
    
    if DamageFunc then
        print("🔧 Using: " .. Service.Name .. "." .. DamageFunc.Name)
        local KillCount = 0
        
        for _, Mob in pairs(Mobs:GetChildren()) do
            if Mob:IsA("Model") then
                local Humanoid = Mob:FindFirstChild("Humanoid")
                if Humanoid and Humanoid.Health > 0 then
                    pcall(function()
                        -- Try different invocation methods
                        if DamageFunc:IsA("RemoteFunction") then
                            DamageFunc:InvokeServer(Mob, 99999)
                        elseif DamageFunc:IsA("RemoteEvent") then
                            DamageFunc:FireServer(Mob, 99999)
                        elseif DamageFunc:IsA("BindableEvent") then
                            DamageFunc:Fire(Mob, 99999)
                        end
                        KillCount = KillCount + 1
                    end)
                end
            end
        end
        
        print("✅ Attempted to kill " .. KillCount .. " mobs!")
        Status.Text = "💀 Killed " .. KillCount .. " mobs"
        Status.TextColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(1)
        Status.Text = "⏹️ Ready"
        Status.TextColor3 = Color3.fromRGB(255, 255, 255)
        
    else
        print("❌ No damage function found!")
        print("📋 Available services:")
        local Knit = ReplicatedStorage:FindFirstChild("Packages")
        if Knit then
            local KnitService = Knit:FindFirstChild("Knit")
            if KnitService then
                local Services = KnitService:FindFirstChild("Services")
                if Services then
                    for _, service in pairs(Services:GetChildren()) do
                        print("  📁 " .. service.Name)
                    end
                end
            end
        end
        Status.Text = "❌ No damage function found"
        Status.TextColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(2)
        Status.Text = "⏹️ Ready"
        Status.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

-- ============================================
-- GUI
-- ============================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "KillAuraGUI"

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 120)
Frame.Position = UDim2.new(0.01, 0, 0.5, -60)
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
Title.Text = "💀 Kill All Mobs"
Title.TextScaled = true
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 100, 100)
Title.Parent = Frame

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 25)
Status.Position = UDim2.new(0, 0, 0, 28)
Status.Text = "⏹️ Ready"
Status.TextScaled = true
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.fromRGB(255, 255, 255)
Status.Font = Enum.Font.SourceSans
Status.Parent = Frame

local KillBtn = Instance.new("TextButton")
KillBtn.Size = UDim2.new(0, 100, 0, 28)
KillBtn.Position = UDim2.new(0.5, -50, 0, 58)
KillBtn.Text = "💀 KILL ALL"
KillBtn.TextScaled = true
KillBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
KillBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KillBtn.BorderSizePixel = 0
KillBtn.Parent = Frame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = KillBtn

-- Debug Button
local DebugBtn = Instance.new("TextButton")
DebugBtn.Size = UDim2.new(0, 100, 0, 25)
DebugBtn.Position = UDim2.new(0.5, -50, 0, 90)
DebugBtn.Text = "🔍 DEBUG"
DebugBtn.TextScaled = true
DebugBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
DebugBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DebugBtn.BorderSizePixel = 0
DebugBtn.Parent = Frame

local DebugCorner = Instance.new("UICorner")
DebugCorner.CornerRadius = UDim.new(0, 6)
DebugCorner.Parent = DebugBtn

-- ============================================
-- BUTTONS
-- ============================================

KillBtn.MouseButton1Click:Connect(function()
    KillAllMobs()
end)

DebugBtn.MouseButton1Click:Connect(function()
    print("🔍 Deep searching for damage functions...")
    local func, service = FindDamageFunction()
    if func then
        print("✅ Found: " .. service.Name .. "." .. func.Name)
        print("   Type: " .. func.ClassName)
        Status.Text = "✅ Found: " .. func.Name
        Status.TextColor3 = Color3.fromRGB(100, 255, 100)
        task.wait(2)
        Status.Text = "⏹️ Ready"
        Status.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        print("❌ No damage function found!")
        Status.Text = "❌ No damage function"
        Status.TextColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(2)
        Status.Text = "⏹️ Ready"
        Status.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end)

-- ============================================
-- KEYBIND: Press K to kill all
-- ============================================

local UserInputService = game:GetService("UserInputService")
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

print("💀 Kill All Mobs (Knit Deep Search) Loaded!")
print("📌 Press 'K' or click 'KILL ALL' button")
print("📌 Click 'DEBUG' to find the damage function")
print("📌 Check the console for results")
