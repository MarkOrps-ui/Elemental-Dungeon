-- ============================================
-- KILL ALL MOBS - USING UNIQUEID
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
-- GET WEAPON ID
-- ============================================

function GetWeaponId()
    local c = LocalPlayer.Character
    if not c then return "Doombringer" end
    
    for _, t in pairs(c:GetChildren()) do
        if t:IsA("Tool") then
            local id = t:FindFirstChild("WeaponId")
            if id then return id.Value end
            return t.Name
        end
    end
    return "Doombringer"
end

-- ============================================
-- GET MOB UNIQUE ID (From the property we found)
-- ============================================

function GetMobUniqueId(mob)
    if not mob then return nil end
    
    -- Method 1: Direct UniqueId property
    local success, uniqueId = pcall(function()
        return mob.UniqueId
    end)
    if success and uniqueId and uniqueId ~= "00000000-0000-0000-0000-000000000000" then
        print("  ✅ Found UniqueId: " .. tostring(uniqueId))
        return tostring(uniqueId)
    end
    
    -- Method 2: Check for child with UniqueId
    for _, child in pairs(mob:GetChildren()) do
        if child.Name == "UniqueId" then
            if child:IsA("StringValue") or child:IsA("ObjectValue") then
                local val = child.Value
                if val and val ~= "" then
                    print("  ✅ Found UniqueId child: " .. tostring(val))
                    return tostring(val)
                end
            end
        end
    end
    
    -- Method 3: Get from attributes
    local attrs = mob:GetAttributes()
    for k, v in pairs(attrs) do
        if k:lower():find("unique") or k:lower():find("id") then
            print("  ✅ Found attribute: " .. k .. " = " .. tostring(v))
            return tostring(v)
        end
    end
    
    -- Method 4: Check HumanoidRootPart
    local hrp = mob:FindFirstChild("HumanoidRootPart")
    if hrp then
        local success2, id2 = pcall(function()
            return hrp.UniqueId
        end)
        if success2 and id2 and id2 ~= "00000000-0000-0000-0000-000000000000" then
            print("  ✅ Found UniqueId in HumanoidRootPart: " .. tostring(id2))
            return tostring(id2)
        end
    end
    
    print("  ⚠️ No UniqueId found, using mob name")
    return mob.Name
end

-- ============================================
-- GET MOB HEALTH
-- ============================================

function GetMobHealth(mob)
    if not mob then return 0 end
    local h = mob:FindFirstChild("Humanoid")
    if h then return h.Health end
    return 0
end

-- ============================================
-- ATTACK WITH UNIQUE ID
-- ============================================

function AttackMob(mob)
    if not mob then return false end
    
    local c = LocalPlayer.Character
    if not c then return false end
    
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    local mobHrp = mob:FindFirstChild("HumanoidRootPart")
    if not mobHrp then
        print("❌ " .. mob.Name .. " has no HumanoidRootPart - skipping")
        return false
    end
    
    local health = GetMobHealth(mob)
    if health <= 0 then
        print("❌ " .. mob.Name .. " is already dead")
        return false
    end
    
    local weaponId = GetWeaponId()
    local uniqueId = GetMobUniqueId(mob)
    
    print("🎯 Attacking: " .. mob.Name)
    print("  🔧 Weapon: " .. weaponId)
    print("  🆔 UniqueId: " .. uniqueId)
    print("  ❤️ Health: " .. health)
    
    -- Face the mob
    hrp.CFrame = CFrame.lookAt(hrp.Position, mobHrp.Position)
    
    local success = false
    local damageDealt = 0
    
    -- ============================================
    -- TRY WITH UNIQUE ID IN DIFFERENT POSITIONS
    -- ============================================
    
    local formats = {
        -- Format: uniqueId as 4th parameter
        function()
            return {
                [1] = 0,
                [2] = {},
                [3] = 999999,
                [4] = uniqueId,
                [5] = weaponId,
                [6] = {
                    CharacterPosition = hrp.Position,
                    Direction = (mobHrp.Position - hrp.Position).Unit,
                    Origin = hrp.Position + Vector3.new(0, 4, 0),
                    Position = mobHrp.Position
                }
            }
        end,
        -- Format: uniqueId as 1st parameter
        function()
            return {
                [1] = uniqueId,
                [2] = 0,
                [3] = {},
                [4] = 999999,
                [5] = weaponId,
                [6] = {
                    CharacterPosition = hrp.Position,
                    Direction = (mobHrp.Position - hrp.Position).Unit,
                    Origin = hrp.Position + Vector3.new(0, 4, 0),
                    Position = mobHrp.Position
                }
            }
        end,
        -- Format: mob as 1st, uniqueId as 4th
        function()
            return {
                [1] = mob,
                [2] = 0,
                [3] = {},
                [4] = uniqueId,
                [5] = 999999,
                [6] = weaponId,
                [7] = {
                    CharacterPosition = hrp.Position,
                    Direction = (mobHrp.Position - hrp.Position).Unit,
                    Origin = hrp.Position + Vector3.new(0, 4, 0),
                    Position = mobHrp.Position
                }
            }
        end,
        -- Format: simple with uniqueId
        function()
            return {
                [1] = uniqueId,
                [2] = 999999,
                [3] = weaponId
            }
        end,
        -- Format: uniqueId in position data
        function()
            return {
                [1] = 0,
                [2] = {},
                [3] = 999999,
                [4] = nil,
                [5] = weaponId,
                [6] = {
                    CharacterPosition = hrp.Position,
                    Direction = (mobHrp.Position - hrp.Position).Unit,
                    Origin = hrp.Position + Vector3.new(0, 4, 0),
                    Position = mobHrp.Position,
                    TargetId = uniqueId
                }
            }
        end
    }
    
    for i, formatFunc in ipairs(formats) do
        if not success then
            local args = formatFunc()
            local result = pcall(function()
                UW:InvokeServer(unpack(args, 1, args.n or #args))
            end)
            if result then
                print("  ✅ Format " .. i .. " sent")
                success = true
            end
            task.wait(0.1)
        end
    end
    
    -- Check if mob died
    task.wait(0.3)
    local newHealth = GetMobHealth(mob)
    if newHealth <= 0 then
        print("  💀 Mob DIED!")
        return true
    else
        damageDealt = health - newHealth
        print("  ❌ Still alive (HP: " .. newHealth .. ", Damage: " .. damageDealt .. ")")
        if damageDealt == 0 then
            print("  ⚠️ No damage! The remote might need a different format")
        end
        return false
    end
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
        task.wait(0.2)
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
-- START
-- ============================================

print("💀 Kill All Mobs - UniqueID Version Loaded!")
print("📌 Press 'J' to test attack on nearest mob")
print("📌 Press 'K' to kill all mobs")
print("📌 Using UniqueId from mob properties")

-- Auto-test
task.wait(2)
local testMob = GetNearestMob()
if testMob then
    print("🧪 Auto-testing on: " .. testMob.Name)
    AttackMob(testMob)
end
