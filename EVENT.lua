-- ============================================
-- SUN VS MOON - BOSS RAID AUTO JOIN (FIXED DETECTION)
-- ============================================

-- ============================================
-- 1. SETTINGS
-- ============================================

local Settings = {
    AutoJoin = true,
    AutoLeave = true,
    RetryInterval = 5,
}

-- ============================================
-- 2. DUNGEON FUNCTIONS
-- ============================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Check if in dungeon (more accurate)
function IsInDungeon()
    -- Check if we're in the lobby
    local Lobby = workspace:FindFirstChild("Lobby")
    if Lobby then
        return false -- If Lobby exists, we're NOT in dungeon
    end
    
    -- Check if we're in a dungeon
    local MapContent = workspace:FindFirstChild("MapContent")
    if MapContent then
        for _, child in pairs(MapContent:GetChildren()) do
            if child.Name:find("SunVsMoon") or child.Name:find("Event") then
                -- Check if it has dungeon parts (floor, walls, etc.)
                if child:FindFirstChild("Base") or child:FindFirstChild("Floor") or child:FindFirstChild("Terrain") then
                    return true
                end
            end
        end
    end
    
    -- Check if there's a boss active
    local Mobs = workspace:FindFirstChild("Mobs")
    if Mobs then
        for _, Mob in pairs(Mobs:GetChildren()) do
            if Mob:IsA("Model") then
                local Name = Mob.Name:lower()
                if Name:find("boss") or Name:find("sun") or Name:find("moon") or Name:find("lunos") then
                    return true
                end
            end
        end
    end
    
    return false
end

-- Check if dungeon is available/portal exists
function IsDungeonAvailable()
    local MapContent = workspace:FindFirstChild("MapContent")
    if MapContent then
        for _, child in pairs(MapContent:GetChildren()) do
            if child.Name:find("SunVsMoon") or child.Name:find("Event") then
                -- Check for portal
                local Portal = child:FindFirstChild("Portal")
                if Portal then
                    return true
                end
                -- Check for interactable object
                local ClickDetector = child:FindFirstChild("ClickDetector")
                if ClickDetector then
                    return true
                end
                -- Check if it has a ProximityPrompt
                for _, obj in pairs(child:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") then
                        return true
                    end
                end
            end
        end
    end
    return false
end

-- Check if boss is alive
function IsBossAlive()
    local Mobs = workspace:FindFirstChild("Mobs")
    if Mobs then
        for _, Mob in pairs(Mobs:GetChildren()) do
            if Mob:IsA("Model") then
                local Name = Mob.Name:lower()
                if Name:find("boss") or Name:find("sun") or Name:find("moon") or Name:find("lunos") then
                    local Humanoid = Mob:FindFirstChild("Humanoid")
                    if Humanoid and Humanoid.Health > 0 then
                        return true
                    end
                end
            end
        end
    end
    return false
end

-- Find the portal/start object
function FindDungeonPortal()
    local MapContent = workspace:FindFirstChild("MapContent")
    if MapContent then
        for _, child in pairs(MapContent:GetChildren()) do
            if child.Name:find("SunVsMoon") or child.Name:find("Event") then
                -- Look for portal or clickable object
                for _, obj in pairs(child:GetDescendants()) do
                    if obj:IsA("ClickDetector") or obj:IsA("ProximityPrompt") then
                        return child, obj
                    end
                end
                -- Check if the child itself has click detector
                local ClickDetector = child:FindFirstChild("ClickDetector")
                if ClickDetector then
                    return child, ClickDetector
                end
                local Portal = child:FindFirstChild("Portal")
                if Portal then
                    return child, Portal
                end
            end
        end
    end
    return nil, nil
end

-- Start/Create the dungeon
function StartDungeon()
    print("🔄 Attempting to create/join SunVsMoon boss raid...")
    Status.Text = "🌙 Starting..."
    Status.TextColor3 = Color3.fromRGB(255, 200, 100)
    
    if not IsDungeonAvailable() then
        print("❌ Dungeon not available!")
        Status.Text = "🌙 Not available"
        Status.TextColor3 = Color3.fromRGB(255, 100, 100)
        return false
    end
    
    local success = false
    
    -- Method 1: Find and click the portal/start object
    local dungeon, portal = FindDungeonPortal()
    if dungeon and portal then
        print("🔍 Found dungeon: " .. dungeon.Name)
        
        if portal:IsA("ClickDetector") then
            portal:Click()
            print("✅ Clicked portal!")
            Status.Text = "✅ Started!"
            Status.TextColor3 = Color3.fromRGB(100, 255, 100)
            success = true
        elseif portal:IsA("ProximityPrompt") then
            fireproximityprompt(portal)
            print("✅ Fired proximity prompt!")
            Status.Text = "✅ Started!"
            Status.TextColor3 = Color3.fromRGB(100, 255, 100)
            success = true
        elseif portal:IsA("BasePart") then
            -- If it's a part, try to find click detector on it
            local ClickDetector = portal:FindFirstChild("ClickDetector")
            if ClickDetector then
                ClickDetector:Click()
                print("✅ Clicked portal part!")
                Status.Text = "✅ Started!"
                Status.TextColor3 = Color3.fromRGB(100, 255, 100)
                success = true
            end
        end
    end
    
    if success then return true end
    
    -- Method 2: Use ReplicatedStorage
    pcall(function()
        local Knit = ReplicatedStorage:FindFirstChild("Packages")
        if Knit then
            local KnitService = Knit:FindFirstChild("Knit")
            if KnitService then
                local Services = KnitService:FindFirstChild("Services")
                if Services then
                    local DungeonService = Services:FindFirstChild("DungeonService")
                    if DungeonService and DungeonService.RF then
                        local StartDungeon = DungeonService.RF:FindFirstChild("StartDungeon")
                        if StartDungeon then
                            StartDungeon:InvokeServer("SunVsMoonEvent")
                            print("✅ Started via service!")
                            Status.Text = "✅ Started!"
                            Status.TextColor3 = Color3.fromRGB(100, 255, 100)
                            success = true
                            return
                        end
                        local CreateDungeon = DungeonService.RF:FindFirstChild("CreateDungeon")
                        if CreateDungeon then
                            CreateDungeon:InvokeServer("SunVsMoonEvent")
                            print("✅ Created via service!")
                            Status.Text = "✅ Created!"
                            Status.TextColor3 = Color3.fromRGB(100, 255, 100)
                            success = true
                            return
                        end
                    end
                end
            end
        end
    end)
    
    if success then return true end
    
    -- Method 3: Try teleporting to the dungeon
    pcall(function()
        local MapContent = workspace:FindFirstChild("MapContent")
        if MapContent then
            for _, child in pairs(MapContent:GetChildren()) do
                if child.Name:find("SunVsMoon") or child.Name:find("Event") then
                    local Character = LocalPlayer.Character
                    if Character then
                        local HRP = Character:FindFirstChild("HumanoidRootPart")
                        if HRP then
                            HRP.CFrame = child:FindFirstChild("Base") and child.Base.CFrame or child.CFrame
                            print("✅ Teleported to dungeon!")
                            Status.Text = "✅ Joined!"
                            Status.TextColor3 = Color3.fromRGB(100, 255, 100)
                            success = true
                            return
                        end
                    end
                end
            end
        end
    end)
    
    if success then return true end
    
    print("⚠️ Could not start dungeon!")
    Status.Text = "❌ Failed to start"
    Status.TextColor3 = Color3.fromRGB(255, 100, 100)
    return false
end

-- Leave dungeon
function LeaveDungeon()
    print("🔄 Leaving boss raid...")
    
    pcall(function()
        local Knit = ReplicatedStorage:FindFirstChild("Packages")
        if Knit then
            local KnitService = Knit:FindFirstChild("Knit")
            if KnitService then
                local Services = KnitService:FindFirstChild("Services")
                if Services then
                    local DungeonService = Services:FindFirstChild("DungeonService")
                    if DungeonService and DungeonService.RF then
                        local TeleportToLobby = DungeonService.RF:FindFirstChild("TeleportToLobby")
                        if TeleportToLobby then
                            TeleportToLobby:InvokeServer()
                            print("✅ Left boss raid!")
                            return
                        end
                    end
                end
            end
        end
    end)
end

-- ============================================
-- 3. GUI
-- ============================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "SunVsMoonGUI"

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 110)
Frame.Position = UDim2.new(0.01, 0, 0.5, -55)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Frame.BackgroundTransparency = 0.2
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = Frame

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 25)
Status.Position = UDim2.new(0, 0, 0, 2)
Status.Text = "🌙 Sun Vs Moon Boss"
Status.TextScaled = true
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.fromRGB(255, 200, 100)
Status.Parent = Frame

local SubStatus = Instance.new("TextLabel")
SubStatus.Size = UDim2.new(1, 0, 0, 25)
SubStatus.Position = UDim2.new(0, 0, 0, 28)
SubStatus.Text = "Status: Waiting..."
SubStatus.TextScaled = true
SubStatus.BackgroundTransparency = 1
SubStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
SubStatus.Font = Enum.Font.SourceSans
SubStatus.Parent = Frame

local BossStatus = Instance.new("TextLabel")
BossStatus.Size = UDim2.new(1, 0, 0, 20)
BossStatus.Position = UDim2.new(0, 0, 0, 52)
BossStatus.Text = "Boss: ⏳ Waiting..."
BossStatus.TextScaled = true
BossStatus.BackgroundTransparency = 1
BossStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
BossStatus.Font = Enum.Font.SourceSans
BossStatus.Parent = Frame

-- JOIN BUTTON
local JoinButton = Instance.new("TextButton")
JoinButton.Size = UDim2.new(0, 80, 0, 28)
JoinButton.Position = UDim2.new(0.5, -40, 0, 78)
JoinButton.Text = "START"
JoinButton.TextScaled = true
JoinButton.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
JoinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
JoinButton.BorderSizePixel = 0
JoinButton.Parent = Frame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = JoinButton

-- Button click handler
JoinButton.MouseButton1Click:Connect(function()
    if IsInDungeon() then
        SubStatus.Text = "✅ Already in boss raid!"
        SubStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
        return
    end
    
    if not IsDungeonAvailable() then
        SubStatus.Text = "🌙 Boss raid not available!"
        SubStatus.TextColor3 = Color3.fromRGB(255, 200, 100)
        task.wait(1.5)
        SubStatus.Text = "🌙 Waiting..."
        SubStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
        return
    end
    
    StartDungeon()
end)

-- ============================================
-- 4. MAIN LOOP
-- ============================================

local isRunning = true
local HasLeft = false
local LastStatus = ""

task.spawn(function()
    while isRunning do
        local inDungeon = IsInDungeon()
        local available = IsDungeonAvailable()
        local bossAlive = IsBossAlive()
        
        if inDungeon then
            -- In dungeon
            SubStatus.Text = "⚔️ In boss raid"
            SubStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
            JoinButton.Text = "IN RAID"
            JoinButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
            
            if bossAlive then
                BossStatus.Text = "Boss: 🔴 ALIVE"
                BossStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
                HasLeft = false
            else
                BossStatus.Text = "✅ Boss: DEAD"
                BossStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
                
                if Settings.AutoLeave and not HasLeft then
                    SubStatus.Text = "🚪 Boss dead! Leaving..."
                    SubStatus.TextColor3 = Color3.fromRGB(255, 200, 100)
                    LeaveDungeon()
                    HasLeft = true
                    task.wait(2)
                end
            end
        else
            -- In lobby
            HasLeft = false
            JoinButton.Text = "START"
            JoinButton.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
            
            if available then
                SubStatus.Text = "🌙 Boss raid is AVAILABLE!"
                SubStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
                BossStatus.Text = "Boss: 🟢 READY"
                BossStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
                
                if Settings.AutoJoin then
                    StartDungeon()
                end
            else
                SubStatus.Text = "🌙 Boss raid closed. Waiting..."
                SubStatus.TextColor3 = Color3.fromRGB(255, 200, 100)
                BossStatus.Text = "Boss: ⏳ Waiting..."
                BossStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
            end
        end
        
        task.wait(Settings.RetryInterval)
    end
end)

-- ============================================
-- 5. KEYBIND - Press J to force join
-- ============================================

local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(Input, Processed)
    if not Processed and Input.KeyCode == Enum.KeyCode.J then
        if IsInDungeon() then
            SubStatus.Text = "✅ Already in boss raid!"
            SubStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
            return
        end
        
        if not IsDungeonAvailable() then
            SubStatus.Text = "🌙 Boss raid not available!"
            SubStatus.TextColor3 = Color3.fromRGB(255, 200, 100)
            task.wait(1.5)
            SubStatus.Text = "🌙 Waiting..."
            SubStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
            return
        end
        
        StartDungeon()
    end
end)

-- ============================================
-- 6. DRAG GUI
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
-- 7. AUTO START
-- ============================================

task.wait(2)
print("🌙 Sun Vs Moon Boss Raid Script Loaded!")
print("📌 Press 'J' or click 'START' to create/join the boss raid")
print("📌 Auto-leaves after boss is killed")
