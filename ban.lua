-- ============================================
-- KILL ALL MOBS - ROBUST FINDER
-- ============================================

local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ============================================
-- FIND USE WEAPON - MULTIPLE METHODS
-- ============================================

function FindUseWeapon()
    print("🔍 Searching for UseWeapon...")
    
    -- METHOD 1: Direct path
    local path1 = RS:FindFirstChild("ReplicatedStorage")
    if path1 then
        local Packages = path1:FindFirstChild("Packages")
        if Packages then
            local Knit = Packages:FindFirstChild("Knit")
            if Knit then
                local Services = Knit:FindFirstChild("Services")
                if Services then
                    local WeaponService = Services:FindFirstChild("WeaponService")
                    if WeaponService then
                        local RF = WeaponService:FindFirstChild("RF")
                        if RF then
                            local UW = RF:FindFirstChild("UseWeapon")
                            if UW then
                                print("✅ Found UseWeapon at path 1")
                                return UW
                            end
                        end
                    end
                end
            end
        end
    end
    
    -- METHOD 2: Direct from ReplicatedStorage
    local Packages = RS:FindFirstChild("Packages")
    if Packages then
        local Knit = Packages:FindFirstChild("Knit")
        if Knit then
            local Services = Knit:FindFirstChild("Services")
            if Services then
                local WeaponService = Services:FindFirstChild("WeaponService")
                if WeaponService then
                    local RF = WeaponService:FindFirstChild("RF")
                    if RF then
                        local UW = RF:FindFirstChild("UseWeapon")
                        if UW then
                            print("✅ Found UseWeapon at path 2")
                            return UW
                        end
                    end
                end
            end
        end
    end
    
    -- METHOD 3: Search everything
    local function Search(parent)
        for _, child in pairs(parent:GetChildren()) do
            if child.Name == "UseWeapon" then
                print("✅ Found UseWeapon at: " .. child:GetFullName())
                return child
            end
            if child:IsA("Folder") or child:IsA("ModuleScript") then
                local found = Search(child)
                if found then return found end
            end
        end
        return nil
    end
    
    local found = Search(RS)
    if found then
        return found
    end
    
    print("❌ UseWeapon not found!")
    return nil
end

-- ============================================
-- GET WEAPON ID
-- ============================================

function GetWeaponId()
    local c = LocalPlayer.Character
    if not c then return "HFA27LM88128" end
    
    for _, t in pairs(c:GetChildren()) do
        if t:IsA("Tool") then
            -- Try different ID locations
            local id = t:FindFirstChild("WeaponId")
            if id then return id.Value end
            local serial = t:FindFirstChild("Serial")
            if serial then return serial.Value end
            local handle = t:FindFirstChild("Handle")
            if handle then
                for _, child in pairs(handle:GetChildren()) do
                    if child.Name == "WeaponId" then
                        return child.Value
                    end
                end
            end
            -- Check attributes
            local success, result = pcall(function()
                return t:GetAttribute("WeaponId")
            end)
            if success and result then
                return result
            end
            return t.Name
        end
    end
    return "HFA27LM88128"
end

-- ============================================
-- ATTACK MOB
-- ============================================

local UseWeapon = FindUseWeapon()

function AttackMob(mob)
    if not UseWeapon then
        print("❌ UseWeapon not available!")
        return false
    end
    
    if not mob then
        print("❌ No mob provided")
        return false
    end
    
    local c = LocalPlayer.Character
    if not c then
        print("❌ No character")
        return false
    end
    
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not hrp then
        print("❌ No HumanoidRootPart")
        return false
    end
    
    local mobHrp = mob:FindFirstChild("HumanoidRootPart")
    if not mobHrp then
        print("❌ Mob has no HumanoidRootPart")
        return false
    end
    
    local humanoid = mob:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then
        print("❌ Mob already dead")
        return false
    end
    
    local weaponId = GetWeaponId()
    print("🔧 Weapon ID: " .. weaponId)
    
    -- Face the mob
    hrp.CFrame = CFrame.lookAt(hrp.Position, mobHrp.Position)
    
    -- ============================================
    -- TRY DIFFERENT ARGUMENT FORMATS
    -- ============================================
    
    local formats = {
        -- Format 1: From your log
        function()
            return {
                [1] = 0,
                [2] = {},
                [3] = 0,
                [4] = nil,
                [5] = weaponId,
                [6] = {
                    CharacterPosition = hrp.Position,
                    Direction = (mobHrp.Position - hrp.Position).Unit,
                    Origin = hrp.Position + Vector3.new(0, 4, 0),
                    Position = mobHrp.Position
                }
            }
        end,
        -- Format 2: With mob as first arg
        function()
            return {
                [1] = mob,
                [2] = 0,
                [3] = {},
                [4] = 0,
                [5] = nil,
                [6] = weaponId,
                [7] = {
                    CharacterPosition = hrp.Position,
                    Direction = (mobHrp.Position - hrp.Position).Unit,
                    Origin = hrp.Position + Vector3.new(0, 4, 0),
                    Position = mobHrp.Position
                }
            }
        end,
        -- Format 3: Simple
        function()
            return {
                [1] = mob,
                [2] = weaponId,
                [3] = hrp.Position,
                [4] = mobHrp.Position,
                [5] = 99999
            }
        end,
        -- Format 4: With damage
        function()
            return {
                [1] = 0,
                [2] = mob,
                [3] = 99999,
                [4] = weaponId,
                [5] = {
                    CharacterPosition = hrp.Position,
                    Direction = (mobHrp.Position - hrp.Position).Unit,
                    Origin = hrp.Position + Vector3.new(0, 4, 0),
                    Position = mobHrp.Position
                }
            }
        end
    }
    
    local success = false
    local lastError = ""
    
    for i, formatFunc in ipairs(formats) do
        if not success then
            local args = formatFunc()
            local result = pcall(function()
                UseWeapon:InvokeServer(unpack(args, 1, args.n or #args))
            end)
            if result then
                print("  ✅ Format " .. i .. " worked!")
                success = true
            else
                lastError = "Format " .. i .. " failed"
            end
            task.wait(0.1)
        end
    end
    
    -- Check if mob died
    task.wait(0.2)
    if humanoid.Health <= 0 then
        print("  💀 Mob DIED!")
        return true
    else
        print("  ❌ Mob still alive (HP: " .. humanoid.Health .. ")")
        if not success then
            print("  ⚠️ " .. lastError)
            print("  💡 Try holding your weapon while attacking")
        end
        return false
    end
end

-- ============================================
-- KILL ALL MOBS
-- ============================================

function KillAll()
    local Mobs = workspace:FindFirstChild("Mobs")
    if not Mobs then 
        print("❌ No Mobs found!")
        return 
    end
    
    local Alive = {}
    for _, mob in pairs(Mobs:GetChildren()) do
        if mob:IsA("Model") then
            local h = mob:FindFirstChild("Humanoid")
            if h and h.Health > 0 then
                table.insert(Alive, mob)
            end
        end
    end
    
    if #Alive == 0 then
        print("✅ No alive mobs!")
        return
    end
    
    print("🔍 Found " .. #Alive .. " alive mobs")
    
    local killed = 0
    for _, mob in pairs(Alive) do
        if AttackMob(mob) then
            killed = killed + 1
        end
        task.wait(0.3)
    end
    
    print("💀 Killed " .. killed .. " / " .. #Alive .. " mobs")
end

-- ============================================
-- GET NEAREST MOB
-- ============================================

function GetNearestMob()
    local c = LocalPlayer.Character
    if not c then return nil end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    
    local Mobs = workspace:FindFirstChild("Mobs")
    if not Mobs then return nil end
    
    local nearest = nil
    local nearestDist = math.huge
    
    for _, mob in pairs(Mobs:GetChildren()) do
        if mob:IsA("Model") then
            local h = mob:FindFirstChild("Humanoid")
            if h and h.Health > 0 then
                local mhrp = mob:FindFirstChild("HumanoidRootPart")
                if mhrp then
                    local dist = (hrp.Position - mhrp.Position).Magnitude
                    if dist < nearestDist then
                        nearestDist = dist
                        nearest = mob
                    end
                end
            end
        end
    end
    return nearest
end

-- ============================================
-- KEYBINDS
-- ============================================

local UIS = game:GetService("UserInputService")

UIS.InputBegan:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.K then
        print("💀 Killing all mobs...")
        KillAll()
    end
end)

UIS.InputBegan:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.J then
        local mob = GetNearestMob()
        if mob then
            print("🎯 Testing on: " .. mob.Name)
            AttackMob(mob)
        else
            print("❌ No mob nearby")
        end
    end
end)

-- ============================================
-- AUTO START
-- ============================================

print("💀 Kill All Mobs - Robust Loaded!")
print("📌 UseWeapon found: " .. tostring(UseWeapon ~= nil))
if UseWeapon then
    print("📌 Press 'J' to test attack")
    print("📌 Press 'K' to kill all mobs")
    print("📌 Make sure you're holding a weapon!")
end

-- Auto-test
task.wait(2)
local testMob = GetNearestMob()
if testMob and UseWeapon then
    print("🧪 Auto-testing on: " .. testMob.Name)
    AttackMob(testMob)
end
