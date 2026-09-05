-- ============================================
-- KILL ALL MOBS - FIXED ARGS
-- ============================================

local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Find WeaponService (Path 2 worked)
local WS = RS:FindFirstChild("ReplicatedStorage"):FindFirstChild("Packages"):FindFirstChild("Knit"):FindFirstChild("Services"):FindFirstChild("WeaponService")
local RF = WS:FindFirstChild("RF")
local UW = RF:FindFirstChild("UseWeapon")

print("✅ WeaponService found!")

-- ============================================
-- GET WEAPON ID
-- ============================================

function GetWeaponId()
    local c = LocalPlayer.Character
    if not c then return "HFA27LM88128" end
    for _, t in pairs(c:GetChildren()) do
        if t:IsA("Tool") then
            local id = t:FindFirstChild("WeaponId")
            if id then return id.Value end
            local serial = t:FindFirstChild("Serial")
            if serial then return serial.Value end
            return t.Name
        end
    end
    return "HFA27LM88128"
end

-- ============================================
-- GET MOB DATA
-- ============================================

function GetMobId(mob)
    if not mob then return nil end
    local id = mob:FindFirstChild("Id")
    if id then return id.Value end
    local humanoid = mob:FindFirstChild("Humanoid")
    if humanoid then return tostring(humanoid) end
    return mob.Name
end

-- ============================================
-- ATTACK MOB - TRY DIFFERENT ARGS
-- ============================================

function AttackMob(mob)
    if not mob then return false end
    
    local c = LocalPlayer.Character
    if not c then return false end
    
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    local mobHrp = mob:FindFirstChild("HumanoidRootPart")
    if not mobHrp then return false end
    
    local weaponId = GetWeaponId()
    local mobId = GetMobId(mob)
    
    -- Get the mob's Humanoid for health check
    local humanoid = mob:FindFirstChild("Humanoid")
    if not humanoid then return false end
    
    print("🎯 Attacking: " .. mob.Name .. " (HP: " .. humanoid.Health .. ")")
    
    -- ============================================
    -- TRY DIFFERENT ARGUMENT FORMATS
    -- ============================================
    
    local success = false
    
    -- FORMAT 1: Original format (from your log)
    local args1 = {
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
    
    pcall(function()
        UW:InvokeServer(unpack(args1, 1, args1.n or #args1))
        success = true
    end)
    
    if success then
        print("  ✅ Format 1 sent")
        task.wait(0.1)
    end
    
    -- FORMAT 2: With mob ID
    if not success or humanoid.Health > 0 then
        local args2 = {
            [1] = 0,
            [2] = {},
            [3] = 0,
            [4] = mobId,
            [5] = weaponId,
            [6] = {
                CharacterPosition = hrp.Position,
                Direction = (mobHrp.Position - hrp.Position).Unit,
                Origin = hrp.Position + Vector3.new(0, 4, 0),
                Position = mobHrp.Position
            }
        }
        
        pcall(function()
            UW:InvokeServer(unpack(args2, 1, args2.n or #args2))
            success = true
        end)
        
        if success then
            print("  ✅ Format 2 sent")
            task.wait(0.1)
        end
    end
    
    -- FORMAT 3: With damage value
    if not success or humanoid.Health > 0 then
        local args3 = {
            [1] = 0,
            [2] = {},
            [3] = 99999,  -- High damage
            [4] = nil,
            [5] = weaponId,
            [6] = {
                CharacterPosition = hrp.Position,
                Direction = (mobHrp.Position - hrp.Position).Unit,
                Origin = hrp.Position + Vector3.new(0, 4, 0),
                Position = mobHrp.Position
            }
        }
        
        pcall(function()
            UW:InvokeServer(unpack(args3, 1, args3.n or #args3))
            success = true
        end
        
        if success then
            print("  ✅ Format 3 sent")
            task.wait(0.1)
        end
    end
    
    -- FORMAT 4: With mob as first arg
    if not success or humanoid.Health > 0 then
        local args4 = {
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
        
        pcall(function()
            UW:InvokeServer(unpack(args4, 1, args4.n or #args4))
            success = true
        end
        
        if success then
            print("  ✅ Format 4 sent")
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
        task.wait(0.2)
    end
    
    print("💀 Killed " .. killed .. " / " .. #Alive .. " mobs")
end

-- ============================================
-- TEST SINGLE MOB
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
-- AUTO TEST ON START
-- ============================================

print("💀 Kill All Mobs - Fixed Args Loaded!")
print("📌 Press 'J' to test attack on nearest mob")
print("📌 Press 'K' to kill all mobs")
print("📌 The script will try 4 different argument formats")

-- Test on nearest mob after 2 seconds
task.wait(2)
local testMob = GetNearestMob()
if testMob then
    print("🧪 Auto-testing on: " .. testMob.Name)
    AttackMob(testMob)
end
