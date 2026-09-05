-- ============================================
-- KILL ALL MOBS - WITH DAMAGE DEBUG
-- ============================================

local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Find UseWeapon
local WS = RS:FindFirstChild("ReplicatedStorage"):FindFirstChild("Packages"):FindFirstChild("Knit"):FindFirstChild("Services"):FindFirstChild("WeaponService")
local RF = WS:FindFirstChild("RF")
local UW = RF:FindFirstChild("UseWeapon")

print("✅ UseWeapon found!")

-- ============================================
-- GET WEAPON DATA
-- ============================================

function GetWeaponData()
    local c = LocalPlayer.Character
    if not c then return nil end
    
    for _, t in pairs(c:GetChildren()) do
        if t:IsA("Tool") then
            local data = {
                name = t.Name,
                id = nil,
                damage = nil,
                type = nil
            }
            
            -- Try to find weapon ID
            local id = t:FindFirstChild("WeaponId")
            if id then data.id = id.Value end
            
            -- Try to find damage value
            local dmg = t:FindFirstChild("Damage")
            if dmg then data.damage = dmg.Value end
            
            -- Check for weapon type
            local typ = t:FindFirstChild("WeaponType")
            if typ then data.type = typ.Value end
            
            return data
        end
    end
    return nil
end

-- ============================================
-- GET MOB DATA (Including ID)
-- ============================================

function GetMobData(mob)
    if not mob then return nil end
    
    local data = {
        name = mob.Name,
        id = nil,
        health = 0,
        maxHealth = 0,
        humanoid = mob:FindFirstChild("Humanoid")
    }
    
    if data.humanoid then
        data.health = data.humanoid.Health
        data.maxHealth = data.humanoid.MaxHealth
    end
    
    -- Find mob ID (important!)
    local id = mob:FindFirstChild("Id")
    if id then
        data.id = id.Value
    else
        -- Try to find ID in children
        for _, child in pairs(mob:GetChildren()) do
            if child.Name == "Id" or child.Name == "MobId" then
                data.id = child.Value
                break
            end
        end
    end
    
    -- If no ID, use the mob's name
    if not data.id then
        data.id = mob.Name
    end
    
    return data
end

-- ============================================
-- ATTACK MOB WITH DIFFERENT ARGS
-- ============================================

function AttackMob(mob)
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
    
    local mobData = GetMobData(mob)
    if not mobData then
        print("❌ Could not get mob data")
        return false
    end
    
    if not mobData.humanoid or mobData.health <= 0 then
        print("❌ Mob already dead")
        return false
    end
    
    local weaponData = GetWeaponData()
    if not weaponData then
        print("❌ No weapon found!")
        return false
    end
    
    local mobHrp = mob:FindFirstChild("HumanoidRootPart")
    if not mobHrp then
        print("❌ Mob has no HumanoidRootPart")
        return false
    end
    
    print("🔧 Weapon: " .. weaponData.name .. " (ID: " .. (weaponData.id or "unknown") .. ")")
    print("🎯 Mob: " .. mobData.name .. " (ID: " .. mobData.id .. ", HP: " .. mobData.health .. ")")
    
    -- Face the mob
    hrp.CFrame = CFrame.lookAt(hrp.Position, mobHrp.Position)
    
    local success = false
    
    -- ============================================
    -- TRY ALL ARGUMENT FORMATS WITH DIFFERENT DAMAGE
    -- ============================================
    
    local formats = {
        -- Format 1: Original with damage value
        function(dmg)
            return {
                [1] = 0,
                [2] = {},
                [3] = dmg or 999999,
                [4] = nil,
                [5] = weaponData.id or "HFA27LM88128",
                [6] = {
                    CharacterPosition = hrp.Position,
                    Direction = (mobHrp.Position - hrp.Position).Unit,
                    Origin = hrp.Position + Vector3.new(0, 4, 0),
                    Position = mobHrp.Position
                }
            }
        end,
        -- Format 2: With mob ID
        function(dmg)
            return {
                [1] = 0,
                [2] = {},
                [3] = dmg or 999999,
                [4] = mobData.id,
                [5] = weaponData.id or "HFA27LM88128",
                [6] = {
                    CharacterPosition = hrp.Position,
                    Direction = (mobHrp.Position - hrp.Position).Unit,
                    Origin = hrp.Position + Vector3.new(0, 4, 0),
                    Position = mobHrp.Position
                }
            }
        end,
        -- Format 3: Mob first
        function(dmg)
            return {
                [1] = mob,
                [2] = dmg or 999999,
                [3] = weaponData.id or "HFA27LM88128",
                [4] = {
                    CharacterPosition = hrp.Position,
                    Direction = (mobHrp.Position - hrp.Position).Unit,
                    Origin = hrp.Position + Vector3.new(0, 4, 0),
                    Position = mobHrp.Position
                }
            }
        end,
        -- Format 4: With damage type
        function(dmg)
            return {
                [1] = 0,
                [2] = mob,
                [3] = dmg or 999999,
                [4] = "Normal",
                [5] = weaponData.id or "HFA27LM88128",
                [6] = {
                    CharacterPosition = hrp.Position,
                    Direction = (mobHrp.Position - hrp.Position).Unit,
                    Origin = hrp.Position + Vector3.new(0, 4, 0),
                    Position = mobHrp.Position
                }
            }
        end,
        -- Format 5: Simple damage
        function(dmg)
            return {
                [1] = mob,
                [2] = dmg or 999999,
                [3] = weaponData.id or "HFA27LM88128"
            }
        end
    }
    
    local damages = {999999, 99999, 9999, 999, 99, 9}
    local worked = false
    
    for dmgIndex, dmg in ipairs(damages) do
        if not worked then
            for fmtIndex, formatFunc in ipairs(formats) do
                if not worked then
                    local args = formatFunc(dmg)
                    local result = pcall(function()
                        UW:InvokeServer(unpack(args, 1, args.n or #args))
                    end)
                    if result then
                        print("  ✅ Format " .. fmtIndex .. " with damage " .. dmg .. " sent")
                        worked = true
                    end
                    task.wait(0.05)
                end
            end
        end
    end
    
    -- Check if mob died
    task.wait(0.3)
    local newHealth = mobData.humanoid.Health
    if newHealth <= 0 then
        print("  💀 Mob DIED!")
        return true
    else
        print("  ❌ Mob still alive (HP: " .. newHealth .. ", Damage dealt: " .. (mobData.health - newHealth) .. ")")
        if mobData.health == newHealth then
            print("  ⚠️ No damage applied! The remote might need a different parameter")
        end
        return false
    end
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
-- KILL ALL
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
                local mhrp = mob:FindFirstChild("HumanoidRootPart")
                if mhrp then
                    table.insert(Alive, mob)
                else
                    print("⚠️ Skipping " .. mob.Name .. " (no HumanoidRootPart)")
                end
            end
        end
    end
    
    if #Alive == 0 then
        print("✅ No alive mobs with HumanoidRootPart!")
        return
    end
    
    print("🔍 Found " .. #Alive .. " attackable mobs")
    
    local killed = 0
    for _, mob in pairs(Alive) do
        if AttackMob(mob) then
            killed = killed + 1
        end
        task.wait(0.2)
    end
    
    print("💀 Killed " .. killed .. " / " .. #Alive .. " mobs")
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
-- START
-- ============================================

print("💀 Kill All Mobs - Debug Version Loaded!")
print("📌 Press 'J' to test attack on nearest mob")
print("📌 Press 'K' to kill all mobs")
print("📌 Check the console for damage results")

-- Auto-test
task.wait(2)
local testMob = GetNearestMob()
if testMob then
    print("🧪 Auto-testing on: " .. testMob.Name)
    AttackMob(testMob)
end
