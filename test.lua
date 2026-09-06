-- ============================================
-- FIND THE REAL MOB ID - DEEP SEARCH
-- ============================================

function FindRealMobId(mob)
    if not mob then 
        print("❌ No mob provided")
        return nil 
    end
    
    print("🔍 Searching for REAL ID in: " .. mob.Name)
    print("📋 All children and their values:")
    
    -- Check ALL children
    for _, child in pairs(mob:GetChildren()) do
        print("  - " .. child.Name .. " (" .. child.ClassName .. ")")
        
        -- Check if it has a Value
        if child:IsA("StringValue") or child:IsA("NumberValue") or child:IsA("ObjectValue") then
            print("    Value: " .. tostring(child.Value))
            -- If it looks like an ID (UUID format or number), flag it
            local val = tostring(child.Value)
            if #val > 5 then
                print("    ⚠️ POTENTIAL ID: " .. child.Name .. " = " .. val)
            end
        end
        
        -- Check for any child with "Id" in name
        if child.Name:lower():find("id") or child.Name:lower():find("uuid") or child.Name:lower():find("unique") then
            print("    ⚠️ ID-RELATED: " .. child.Name)
            if child:IsA("StringValue") or child:IsA("NumberValue") then
                print("      Value: " .. tostring(child.Value))
            end
        end
        
        -- Check inside this child too
        if #child:GetChildren() > 0 then
            for _, subChild in pairs(child:GetChildren()) do
                if subChild.Name:lower():find("id") or subChild.Name:lower():find("uuid") then
                    print("      🔹 " .. subChild.Name .. " (" .. subChild.ClassName .. ")")
                    if subChild:IsA("StringValue") or subChild:IsA("NumberValue") then
                        print("        Value: " .. tostring(subChild.Value))
                    end
                end
            end
        end
    end
    
    -- Check Attributes
    local attrs = mob:GetAttributes()
    if next(attrs) then
        print("📋 Attributes:")
        for k, v in pairs(attrs) do
            print("  - " .. k .. " = " .. tostring(v))
            if k:lower():find("id") or k:lower():find("uuid") then
                print("    ⚠️ ID ATTRIBUTE: " .. k .. " = " .. tostring(v))
            end
        end
    end
    
    -- Check Humanoid for IDs
    local humanoid = mob:FindFirstChild("Humanoid")
    if humanoid then
        print("📋 Humanoid children:")
        for _, child in pairs(humanoid:GetChildren()) do
            print("  - " .. child.Name .. " (" .. child.ClassName .. ")")
            if child.Name:lower():find("id") then
                print("    Value: " .. tostring(child.Value))
            end
        end
    end
    
    -- Check HumanoidRootPart for IDs
    local hrp = mob:FindFirstChild("HumanoidRootPart")
    if hrp then
        print("📋 HumanoidRootPart children:")
        for _, child in pairs(hrp:GetChildren()) do
            print("  - " .. child.Name .. " (" .. child.ClassName .. ")")
            if child.Name:lower():find("id") then
                print("    Value: " .. tostring(child.Value))
            end
        end
    end
end

-- Run on nearest mob
local mob = GetNearestMob()
if mob then
    FindRealMobId(mob)
else
    print("❌ No mob nearby")
end
