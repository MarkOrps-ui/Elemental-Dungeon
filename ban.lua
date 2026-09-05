-- ============================================
-- KILL ALL MOBS - WORKING VERSION
-- ============================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ============================================
-- AUTO-DETECT WORKING METHOD
-- ============================================

function KillAllMobs()
    local Mobs = workspace:FindFirstChild("Mobs")
    if not Mobs then 
        print("❌ No Mobs found!")
        return 
    end
    
    print("🔍 Finding working damage method...")
    
    -- METHOD 1: Knit Services (Most common)
    local success = false
    pcall(function()
        local Knit = ReplicatedStorage:FindFirstChild("Packages")
        if Knit then
            local KnitService = Knit:FindFirstChild("Knit")
            if KnitService then
                local Services = KnitService:FindFirstChild("Services")
                if Services then
                    -- Try CombatService
                    local CombatService = Services:FindFirstChild("CombatService")
                    if CombatService then
                        local RF = CombatService:FindFirstChild("RF")
                        if RF then
                            local DealDamage = RF:FindFirstChild("DealDamage")
                            if DealDamage then
                                print("✅ Using CombatService.DealDamage")
                                for _, Mob in pairs(Mobs:GetChildren()) do
                                    if Mob:IsA("Model") then
                                        local Humanoid = Mob:FindFirstChild("Humanoid")
                                        if Humanoid and Humanoid.Health > 0 then
                                            DealDamage:InvokeServer(Mob, 99999)
                                        end
                                    end
                                end
                                success = true
                                return
                            end
                        end
                    end
                end
            end
        end
    end)
    
    if success then return end
    
    -- METHOD 2: Search ReplicatedStorage for damage remotes
    pcall(function()
        local function SearchDamageRemote(parent)
            for _, child in pairs(parent:GetChildren()) do
                if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
                    local name = child.Name:lower()
                    if name:find("damage") or name:find("hit") or name:find("attack") or name:find("deal") then
                        print("✅ Using: " .. child.Name)
                        for _, Mob in pairs(Mobs:GetChildren()) do
                            if Mob:IsA("Model") then
                                local Humanoid = Mob:FindFirstChild("Humanoid")
                                if Humanoid and Humanoid.Health > 0 then
                                    if child:IsA("RemoteEvent") then
                                        child:FireServer(Mob, 99999)
                                    else
                                        child:InvokeServer(Mob, 99999)
                                    end
                                end
                            end
                        end
                        success = true
                        return true
                    end
                end
                if child:IsA("Folder") or child:IsA("ModuleScript") then
                    if SearchDamageRemote(child) then
                        return true
                    end
                end
            end
            return false
        end
        
        SearchDamageRemote(ReplicatedStorage)
    end)
    
    if success then return end
    
    -- METHOD 3: Use weapon attack
    pcall(function()
        local Character = LocalPlayer.Character
        if Character then
            for _, child in pairs(Character:GetChildren()) do
                if child:IsA("Tool") then
                    local AttackRemote = nil
                    for _, obj in pairs(child:GetDescendants()) do
                        if obj:IsA("RemoteEvent") and obj.Name:lower():find("attack") then
                            AttackRemote = obj
                            break
                        end
                    end
                    if AttackRemote then
                        print("✅ Using weapon: " .. child.Name)
                        for _, Mob in pairs(Mobs:GetChildren()) do
                            if Mob:IsA("Model") then
                                local Humanoid = Mob:FindFirstChild("Humanoid")
                                if Humanoid and Humanoid.Health > 0 then
                                    AttackRemote:FireServer(Mob)
                                end
                            end
                        end
                        success = true
                        return
                    end
                end
            end
        end
    end)
    
    if success then return end
    
    -- METHOD 4: Debug - Print what's available
    print("❌ No working method found!")
    print("📋 Available in ReplicatedStorage:")
    for _, child in pairs(ReplicatedStorage:GetChildren()) do
        print("  - " .. child.Name .. " (" .. child.ClassName .. ")")
    end
end

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

-- ============================================
-- BUTTONS & KEYBINDS
-- ============================================

KillBtn.MouseButton1Click:Connect(function()
    Status.Text = "💀 Killing..."
    Status.TextColor3 = Color3.fromRGB(255, 200, 100)
    KillAllMobs()
    Status.Text = "✅ Done!"
    Status.TextColor3 = Color3.fromRGB(100, 255, 100)
    task.wait(1)
    Status.Text = "⏹️ Ready"
    Status.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

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

print("💀 Kill All Mobs Script Loaded!")
print("📌 Press 'K' or click 'KILL ALL' button")
print("📌 Script will auto-detect the working method")
