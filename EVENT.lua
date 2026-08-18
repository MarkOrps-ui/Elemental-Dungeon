-- ============================================
-- SUN VS MOON - BOSS RAID AUTO JOIN
-- ============================================

-- ============================================
-- 1. SETTINGS
-- ============================================

local Settings = {
    DungeonName = "SunVsMoonEvent",
    AutoJoin = true,
    AutoLeave = true,          -- Leave after boss is dead
    RetryInterval = 5,         -- Check every 5 seconds
}

-- ============================================
-- 2. DUNGEON FUNCTIONS
-- ============================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Check if in dungeon
function IsInDungeon()
    local MapContent = workspace:FindFirstChild("MapContent")
    if MapContent then
        return MapContent:FindFirstChild("SunVsMoonEvent") ~= nil
    end
    return false
end

-- Check if dungeon is available (portal exists)
function IsDungeonAvailable()
    local MapContent = workspace:FindFirstChild("MapContent")
    if MapContent then
        local SunVsMoon = MapContent:FindFirstChild("SunVsMoonEvent")
        if SunVsMoon then
            local Portal = SunVsMoon:FindFirstChild("Portal")
            if Portal then
                return true
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
                -- Check if it's a boss (has boss in name or is large)
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

-- Check if dungeon is complete (boss is dead)
function IsDungeonComplete()
    if IsInDungeon() then
        return not IsBossAlive()
    end
    return false
end

-- Start the dungeon
function StartDungeon()
    print("🔄 Attempting to join SunVsMoon boss raid...")
    Status.Text = "🌙 Joining..."
    Status.TextColor3 = Color3.fromRGB(255, 200, 100)
    
    if not IsDungeonAvailable() then
        print("❌ Dungeon not open yet!")
        Status.Text = "🌙 Not open yet..."
        Status.TextColor3 = Color3.fromRGB(255, 100, 100)
        return false
    end
    
    local success = false
    
    -- Method 1: Use ReplicatedStorage
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
                            print("✅ Joined boss raid!")
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
    
    -- Method 2: Click the portal
    pcall(function()
        local MapContent = workspace:FindFirstChild("MapContent")
        if MapContent then
            local SunVsMoon = MapContent:FindFirstChild("SunVsMoonEvent")
            if SunVsMoon then
                local Portal = SunVsMoon:FindFirstChild("Portal")
                if Portal then
                    local ClickDetector = Portal:FindFirstChild("ClickDetector")
                    if ClickDetector then
                        ClickDetector:Click()
                        print("✅ Clicked portal!")
                        Status.Text = "✅ Joined!"
                        Status.TextColor3 = Color3.fromRGB(100, 255, 100)
                        success = true
                        return
                    end
                    
                    local Prompt = Portal:FindFirstChild("ProximityPrompt")
                    if Prompt then
                        fireproximityprompt(Prompt)
                        print("✅ Fired proximity prompt!")
                        Status.Text = "✅ Joined!"
                        Status.TextColor3 = Color3.fromRGB(100, 255, 100)
                        success = true
                        return
                    end
                end
            end
        end
    end)
    
    if success then return true end
    
    print("⚠️ Could not join dungeon!")
    Status.Text = "❌ Failed to join"
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
Frame.Size = UDim2.new(0, 200, 0, 70)
Frame.Position = UDim2.new(0.01, 0, 0.5, -35)
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
BossStatus.Size = UDim2.new(1, 0, 0, 15)
BossStatus.Position = UDim2.new(0, 0, 0, 52)
BossStatus.Text = "Boss: Unknown"
BossStatus.TextScaled = true
BossStatus.BackgroundTransparency = 1
BossStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
BossStatus.Font = Enum.Font.SourceSans
BossStatus.Parent = Frame

-- Click to force join
Frame.MouseButton1Click:Connect(function()
    if not IsInDungeon() then
        StartDungeon()
    else
        SubStatus.Text = "✅ Already in boss raid!"
        SubStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
        task.wait(1)
    end
end)

-- ============================================
-- 4. MAIN LOOP
-- ============================================

local isRunning = true
local HasLeft = false

task.spawn(function()
    while isRunning do
        if IsInDungeon() then
            -- In dungeon - check boss status
            SubStatus.Text = "⚔️ In boss raid"
            SubStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
            
            if IsBossAlive() then
                BossStatus.Text = "Boss: 🔴 ALIVE"
                BossStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
                HasLeft = false
            else
                BossStatus.Text = "✅ Boss: DEAD"
                BossStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
                
                -- Auto leave after boss is dead
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
            
            if IsDungeonAvailable() then
                SubStatus.Text = "🌙 Boss raid is OPEN! Joining..."
                SubStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
                
                if StartDungeon() then
                    BossStatus.Text = "Boss: 🔴 ALIVE"
                    BossStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
                else
                    SubStatus.Text = "❌ Join failed, retrying..."
                    SubStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
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
        if not IsInDungeon() then
            if IsDungeonAvailable() then
                StartDungeon()
            else
                SubStatus.Text = "🌙 Boss raid not open yet!"
                SubStatus.TextColor3 = Color3.fromRGB(255, 200, 100)
                task.wait(1.5)
            end
        else
            SubStatus.Text = "✅ Already in boss raid!"
            SubStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
            task.wait(1)
        end
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
if Settings.AutoJoin then
    print("🌙 Sun Vs Moon Boss Raid - Auto Join Script Loaded!")
    print("📌 Boss raid opens for 5 minutes every hour")
    print("📌 Auto-leaves after boss is killed")
end

print("📌 Click the GUI box or press 'J' to force join")
