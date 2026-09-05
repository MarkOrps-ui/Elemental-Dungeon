-- ============================================
-- KILL ALL MOBS - USING WEAPONSERVICE
-- ============================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ============================================
-- FIND WEAPONSERVICE
-- ============================================

function GetWeaponService()
    local Knit = ReplicatedStorage:FindFirstChild("Packages")
    if Knit then
        local KnitService = Knit:FindFirstChild("Knit")
        if KnitService then
            local Services = KnitService:FindFirstChild("Services")
            if Services then
                return Services:FindFirstChild("WeaponService")
            end
        end
    end
    return nil
end

-- ============================================
-- GET WEAPON ID
-- ============================================

function GetWeaponId()
    local Character = LocalPlayer.Character
    if not Character then return nil end
    
    for _, child in pairs(Character:GetChildren()) do
        if child:IsA("Tool") then
            -- Check for weapon ID
            local WeaponId = child:FindFirstChild("WeaponId")
            if WeaponId then
                return WeaponId.Value
            end
            -- Check for Serial/ID attribute
            local Serial = child:FindFirstChild("Serial")
            if Serial then
                return Serial.Value
            end
            -- Use tool name as fallback
            return child.Name
        end
    end
    return nil
end

-- ============================================
-- GET MOB DATA
-- ============================================

function GetMobData(Mob)
    if not Mob then return nil end
    
    local MobId = Mob:FindFirstChild("Id")
    if MobId then
        return MobId.Value
    end
    
    -- Check for other identifiers
    local Humanoid = Mob:FindFirstChild("Humanoid")
    if Humanoid then
        return tostring(Humanoid)
    end
    
    return Mob.Name
end

-- ============================================
-- ATTACK A SINGLE MOB (Using WeaponService)
-- ============================================

function AttackMob(Mob)
    if not Mob then return false end
    
    local WeaponService = GetWeaponService()
    if not WeaponService then
        print("❌ WeaponService not found!")
        return false
    end
    
    local RF = WeaponService:FindFirstChild("RF")
    if not RF then
        print("❌ RF not found in WeaponService!")
        return false
    end
    
    local UseWeapon = RF:FindFirstChild("UseWeapon")
    if not UseWeapon then
        print("❌ UseWeapon not found!")
        return false
    end
    
    local Character = LocalPlayer.Character
    if not Character then return false end
    
    local HRP = Character:FindFirstChild("HumanoidRootPart")
    if not HRP then return false end
    
    local MobHRP = Mob:FindFirstChild("HumanoidRootPart")
    if not MobHRP then return false end
    
    -- Get weapon ID
    local WeaponId = GetWeaponId()
    if not WeaponId then
        print("⚠️ No weapon ID found, using default")
        WeaponId = "HFA27LM88128" -- Default from your log
    end
    
    -- Get mob ID
    local MobId = GetMobData(Mob)
    
    -- Build the args (based on your log)
    local args = {
        [1] = 0,                    -- Weapon slot or type
        [2] = {},                   -- Empty table (maybe modifiers)
        [3] = 0,                    -- Damage multiplier or hit type
        [4] = nil,                  -- Not used
        [5] = WeaponId,             -- Weapon identifier
        [6] = {                     -- Position data
            CharacterPosition = HRP.Position,
            Direction = (MobHRP.Position - HRP.Position).Unit,
            Origin = HRP.Position + Vector3.new(0, 4, 0),
            Position = MobHRP.Position
        }
    }
    
    -- Fire the remote
    local success = pcall(function()
        UseWeapon:InvokeServer(unpack(args, 1, args.n or #args))
    end)
    
    if success then
        print("✅ Attacked: " .. Mob.Name)
        return true
    else
        print("❌ Failed to attack: " .. Mob.Name)
        return false
    end
end

-- ============================================
-- KILL ALL MOBS
-- ============================================

function KillAllMobs()
    local Mobs = workspace:FindFirstChild("Mobs")
    if not Mobs then 
        print("❌ No Mobs found!")
        Status.Text = "❌ No Mobs"
        Status.TextColor3 = Color3.fromRGB(255, 100, 100)
        return 
    end
    
    -- Count alive mobs
    local AliveMobs = {}
    for _, Mob in pairs(Mobs:GetChildren()) do
        if Mob:IsA("Model") then
            local Humanoid = Mob:FindFirstChild("Humanoid")
            if Humanoid and Humanoid.Health > 0 then
                table.insert(AliveMobs, Mob)
            end
        end
    end
    
    if #AliveMobs == 0 then
        print("✅ No alive mobs found!")
        Status.Text = "✅ No mobs to kill"
        Status.TextColor3 = Color3.fromRGB(100, 255, 100)
        return
    end
    
    print("🔍 Found " .. #AliveMobs .. " alive mobs")
    Status.Text = "💀 Killing " .. #AliveMobs .. " mobs..."
    Status.TextColor3 = Color3.fromRGB(255, 200, 100)
    
    local KillCount = 0
    for _, Mob in pairs(AliveMobs) do
        if AttackMob(Mob) then
            KillCount = KillCount + 1
        end
        task.wait(0.1) -- Small delay between attacks
    end
    
    print("✅ Attacked " .. KillCount .. " mobs!")
    Status.Text = "💀 Attacked " .. KillCount .. " mobs"
    Status.TextColor3 = Color3.fromRGB(100, 255, 100)
    task.wait(1.5)
    Status.Text = "⏹️ Ready"
    Status.TextColor3 = Color3.fromRGB(255, 255, 255)
end

-- ============================================
-- GET NEAREST MOB (For testing)
-- ============================================

function GetNearestMob()
    local Character = LocalPlayer.Character
    if not Character then return nil end
    
    local HRP = Character:FindFirstChild("HumanoidRootPart")
    if not HRP then return nil end
    
    local Mobs = workspace:FindFirstChild("Mobs")
    if not Mobs then return nil end
    
    local Nearest = nil
    local NearestDist = math.huge
    
    for _, Mob in pairs(Mobs:GetChildren()) do
        if Mob:IsA("Model") then
            local Humanoid = Mob:FindFirstChild("Humanoid")
            if Humanoid and Humanoid.Health > 0 then
                local MobHRP = Mob:FindFirstChild("HumanoidRootPart")
                if MobHRP then
                    local Dist = (HRP.Position - MobHRP.Position).Magnitude
                    if Dist < NearestDist then
                        NearestDist = Dist
                        Nearest = Mob
                    end
                end
            end
        end
    end
    
    return Nearest
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

-- ============================================
-- BUTTONS & KEYBINDS
-- ============================================

KillBtn.MouseButton1Click:Connect(function()
    KillAllMobs()
end)

local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(Input, Processed)
    if not Processed and Input.KeyCode == Enum.KeyCode.K then
        KillAllMobs()
    end
end)

-- Test attack on nearest mob (Press J)
UserInputService.InputBegan:Connect(function(Input, Processed)
    if not Processed and Input.KeyCode == Enum.KeyCode.J then
        local Mob = GetNearestMob()
        if Mob then
            print("🎯 Testing attack on: " .. Mob.Name)
            AttackMob(Mob)
        else
            print("❌ No mob nearby")
        end
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

print("💀 Kill All Mobs (WeaponService) Loaded!")
print("📌 Press 'K' to kill all mobs")
print("📌 Press 'J' to test attack on nearest mob")
print("📌 Using WeaponService.RF.UseWeapon")
