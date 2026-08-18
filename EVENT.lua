-- ============================================
-- SUN VS MOON - SPAM START (Keep trying)
-- ============================================

-- ============================================
-- 1. SETTINGS
-- ============================================

local SpamInterval = 2  -- Try every 2 seconds

-- ============================================
-- 2. START DUNGEON FUNCTION
-- ============================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

function StartDungeon()
    print("🔄 Attempting to start SunVsMoon...")
    Status.Text = "🌙 Trying..."
    Status.TextColor3 = Color3.fromRGB(255, 200, 100)
    
    -- Method 1: Click the portal (if exists)
    pcall(function()
        local MapContent = workspace:FindFirstChild("MapContent")
        if MapContent then
            for _, child in pairs(MapContent:GetChildren()) do
                if child.Name:find("SunVsMoon") or child.Name:find("Event") then
                    -- Try to click any clickable object
                    for _, obj in pairs(child:GetDescendants()) do
                        if obj:IsA("ClickDetector") then
                            obj:Click()
                            print("✅ Clicked portal!")
                            Status.Text = "✅ Clicked!"
                            Status.TextColor3 = Color3.fromRGB(100, 255, 100)
                            return
                        end
                        if obj:IsA("ProximityPrompt") then
                            fireproximityprompt(obj)
                            print("✅ Fired prompt!")
                            Status.Text = "✅ Fired!"
                            Status.TextColor3 = Color3.fromRGB(100, 255, 100)
                            return
                        end
                    end
                end
            end
        end
    end)
    
    -- Method 2: Use ReplicatedStorage (spam this!)
    pcall(function()
        local Knit = ReplicatedStorage:FindFirstChild("Packages")
        if Knit then
            local KnitService = Knit:FindFirstChild("Knit")
            if KnitService then
                local Services = KnitService:FindFirstChild("Services")
                if Services then
                    local DungeonService = Services:FindFirstChild("DungeonService")
                    if DungeonService and DungeonService.RF then
                        -- Try StartDungeon
                        local StartDungeon = DungeonService.RF:FindFirstChild("StartDungeon")
                        if StartDungeon then
                            StartDungeon:InvokeServer("SunVsMoonEvent")
                            print("✅ StartDungeon sent!")
                            Status.Text = "✅ Sent!"
                            Status.TextColor3 = Color3.fromRGB(100, 255, 100)
                            return
                        end
                        -- Try CreateDungeon
                        local CreateDungeon = DungeonService.RF:FindFirstChild("CreateDungeon")
                        if CreateDungeon then
                            CreateDungeon:InvokeServer("SunVsMoonEvent")
                            print("✅ CreateDungeon sent!")
                            Status.Text = "✅ Sent!"
                            Status.TextColor3 = Color3.fromRGB(100, 255, 100)
                            return
                        end
                        -- Try any InvokeServer with "Dungeon" in name
                        for _, rf in pairs(DungeonService.RF:GetChildren()) do
                            local name = rf.Name:lower()
                            if name:find("dungeon") or name:find("start") or name:find("create") then
                                pcall(function()
                                    rf:InvokeServer("SunVsMoonEvent")
                                    print("✅ " .. rf.Name .. " sent!")
                                    Status.Text = "✅ Sent!"
                                    Status.TextColor3 = Color3.fromRGB(100, 255, 100)
                                end)
                            end
                        end
                    end
                end
            end
        end
    end)
    
    -- Method 3: Teleport to the event
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
                            print("✅ Teleported to event!")
                            Status.Text = "✅ Teleported!"
                            Status.TextColor3 = Color3.fromRGB(100, 255, 100)
                            return
                        end
                    end
                end
            end
        end
    end)
end

-- Check if already in dungeon
function IsInDungeon()
    local Lobby = workspace:FindFirstChild("Lobby")
    if Lobby then
        return false
    end
    
    local MapContent = workspace:FindFirstChild("MapContent")
    if MapContent then
        for _, child in pairs(MapContent:GetChildren()) do
            if child.Name:find("SunVsMoon") or child.Name:find("Event") then
                return true
            end
        end
    end
    
    -- Check for mobs/boss
    local Mobs = workspace:FindFirstChild("Mobs")
    if Mobs then
        for _, mob in pairs(Mobs:GetChildren()) do
            if mob:IsA("Model") then
                local name = mob.Name:lower()
                if name:find("boss") or name:find("sun") or name:find("moon") or name:find("lunos") then
                    return true
                end
            end
        end
    end
    
    return false
end

-- Leave dungeon
function LeaveDungeon()
    print("🔄 Leaving...")
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
                            print("✅ Left!")
                        end
                    end
                end
            end
        end
    end)
end

-- Check if boss is alive
function IsBossAlive()
    local Mobs = workspace:FindFirstChild("Mobs")
    if Mobs then
        for _, mob in pairs(Mobs:GetChildren()) do
            if mob:IsA("Model") then
                local name = mob.Name:lower()
                if name:find("boss") or name:find("sun") or name:find("moon") or name:find("lunos") then
                    local Humanoid = mob:FindFirstChild("Humanoid")
                    if Humanoid and Humanoid.Health > 0 then
                        return true
                    end
                end
            end
        end
    end
    return false
end

-- ============================================
-- 3. GUI
-- ============================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "SunVsMoonGUI"

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 85)
Frame.Position = UDim2.new(0.01, 0, 0.5, -42)
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
Status.Text = "🌙 Sun Vs Moon"
Status.TextScaled = true
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.fromRGB(255, 200, 100)
Status.Parent = Frame

local SubStatus = Instance.new("TextLabel")
SubStatus.Size = UDim2.new(1, 0, 0, 25)
SubStatus.Position = UDim2.new(0, 0, 0, 28)
SubStatus.Text = "Status: Spamming..."
SubStatus.TextScaled = true
SubStatus.BackgroundTransparency = 1
SubStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
SubStatus.Font = Enum.Font.SourceSans
SubStatus.Parent = Frame

local StartButton = Instance.new("TextButton")
StartButton.Size = UDim2.new(0, 80, 0, 28)
StartButton.Position = UDim2.new(0.5, -40, 0, 58)
StartButton.Text = "START"
StartButton.TextScaled = true
StartButton.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.BorderSizePixel = 0
StartButton.Parent = Frame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = StartButton

StartButton.MouseButton1Click:Connect(function()
    if IsInDungeon() then
        SubStatus.Text = "✅ Already in dungeon!"
        SubStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        StartDungeon()
    end
end)

-- ============================================
-- 4. MAIN LOOP - KEEP SPAMMING
-- ============================================

local isRunning = true
local HasLeft = false

task.spawn(function()
    while isRunning do
        if IsInDungeon() then
            SubStatus.Text = "⚔️ In dungeon"
            SubStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
            StartButton.Text = "IN RAID"
            StartButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
            
            if IsBossAlive() then
                Status.Text = "Boss: 🔴 ALIVE"
                Status.TextColor3 = Color3.fromRGB(255, 100, 100)
                HasLeft = false
            else
                Status.Text = "✅ Boss: DEAD"
                Status.TextColor3 = Color3.fromRGB(100, 255, 100)
                
                if not HasLeft then
                    SubStatus.Text = "🚪 Boss dead! Leaving..."
                    SubStatus.TextColor3 = Color3.fromRGB(255, 200, 100)
                    LeaveDungeon()
                    HasLeft = true
                    task.wait(2)
                end
            end
        else
            -- In lobby - KEEP SPAMMING START
            HasLeft = false
            SubStatus.Text = "🌙 Spamming start..."
            SubStatus.TextColor3 = Color3.fromRGB(255, 200, 100)
            StartButton.Text = "START"
            StartButton.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
            Status.Text = "🌙 Trying..."
            Status.TextColor3 = Color3.fromRGB(255, 200, 100)
            
            -- SPAM START!
            StartDungeon()
        end
        
        task.wait(SpamInterval)
    end
end)

-- ============================================
-- 5. KEYBIND - Press J to manually start
-- ============================================

local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(Input, Processed)
    if not Processed and Input.KeyCode == Enum.KeyCode.J then
        if IsInDungeon() then
            SubStatus.Text = "✅ Already in dungeon!"
            SubStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            StartDungeon()
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
-- 7. START
-- ============================================

print("🌙 Sun Vs Moon - SPAM START Script Loaded!")
print("📌 Will keep spamming start every " .. SpamInterval .. " seconds")
print("📌 Click 'START' or press 'J' to manually start")
print("📌 The game will show warning if not open yet")
