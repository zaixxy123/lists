local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer

local genv = getgenv()
if genv._MoonPuzzleCleanup then
    genv._MoonPuzzleCleanup()
    genv._MoonPuzzleCleanup = nil
end

local connections = {}
local loopThread = nil
local isSolving = false
local isEnabled = true

local function createIndicator()
    local parent = if gethui then gethui() else game:GetService("CoreGui")

    local existing = parent:FindFirstChild("MoonPuzzleIndicator")
    if existing then
        existing:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MoonPuzzleIndicator"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 100

    local pill = Instance.new("Frame")
    pill.Name = "IndicatorPill"
    pill.AnchorPoint = Vector2.new(0.5, 0)
    pill.Position = UDim2.new(0.5, 0, 0, 48)
    pill.Size = UDim2.new(0, 145, 0, 22)
    pill.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    pill.BackgroundTransparency = 0.2
    pill.BorderSizePixel = 0
    pill.Parent = screenGui

    local pillCorner = Instance.new("UICorner")
    pillCorner.CornerRadius = UDim.new(0, 4)
    pillCorner.Parent = pill

    local pillStroke = Instance.new("UIStroke")
    pillStroke.Color = Color3.fromRGB(50, 50, 60)
    pillStroke.Thickness = 1
    pillStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    pillStroke.Parent = pill

    local statusDot = Instance.new("Frame")
    statusDot.Name = "StatusDot"
    statusDot.AnchorPoint = Vector2.new(0, 0.5)
    statusDot.Position = UDim2.new(0, 8, 0.5, 0)
    statusDot.Size = UDim2.new(0, 6, 0, 6)
    statusDot.BackgroundColor3 = Color3.fromRGB(80, 220, 120)
    statusDot.BorderSizePixel = 0
    statusDot.Parent = pill

    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = statusDot

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "StatusLabel"
    statusLabel.AnchorPoint = Vector2.new(0, 0.5)
    statusLabel.Position = UDim2.new(0, 20, 0.5, 0)
    statusLabel.Size = UDim2.new(1, -26, 1, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.GothamMedium
    statusLabel.Text = "moon puzzle: ready"
    statusLabel.TextColor3 = Color3.fromRGB(220, 220, 230)
    statusLabel.TextSize = 11
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = pill

    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.fromScale(1, 1)
    toggleButton.BackgroundTransparency = 1
    toggleButton.Text = ""
    toggleButton.Parent = pill

    screenGui.Parent = parent

    local function updateStatus(text: string, color: Color3)
        statusLabel.Text = text
        statusDot.BackgroundColor3 = color
    end

    local function destroyGui()
        screenGui:Destroy()
    end

    return updateStatus, destroyGui, toggleButton
end

local updateIndicator, destroyIndicator, toggleButton = createIndicator()

local function getRootPart()
    local character = localPlayer.Character
    if not character then
        return nil
    end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or humanoid.Health <= 0 or not rootPart then
        return nil
    end

    return rootPart
end

local function getPuzzleInstances()
    local map = Workspace:FindFirstChild("Map")
    if not map then
        return nil, nil, nil
    end

    local mapItems = map:FindFirstChild("MapItems")
    if not mapItems then
        return nil, nil, nil
    end

    local puzzle = mapItems:FindFirstChild("Puzzle")
    if not puzzle then
        return nil, nil, nil
    end

    local moons = puzzle:FindFirstChild("Moons")
    local replicator = puzzle:FindFirstChild("Replicator")
    if not moons or not replicator then
        return nil, nil, nil
    end

    return puzzle, moons, replicator
end

local function isPuzzleActive(moons)
    for _, moon in moons:GetChildren() do
        local prompt = moon:FindFirstChildOfClass("ProximityPrompt")
        if prompt and prompt.Enabled then
            return true
        end
    end

    return false
end

local function solvePuzzle()
    if not isEnabled or isSolving then
        return
    end

    local rootPart = getRootPart()
    if not rootPart then
        return
    end

    local _, moons, replicator = getPuzzleInstances()
    if not moons or not replicator then
        return
    end

    if not isPuzzleActive(moons) then
        return
    end

    isSolving = true
    updateIndicator("moon puzzle: solving", Color3.fromRGB(255, 200, 60))

    local savedCFrame = rootPart.CFrame

    local maxPasses = 3
    local pass = 0

    while pass < maxPasses and isPuzzleActive(moons) and isEnabled do
        pass += 1

        local currentPhases = replicator:GetAttribute("Phases")
        if currentPhases == "12345" then
            break
        end

        for moonIndex = 1, 5 do
            if not isPuzzleActive(moons) or not isEnabled then
                break
            end

            currentPhases = replicator:GetAttribute("Phases")
            local currentPhase = if type(currentPhases) == "string" and #currentPhases >= moonIndex
                then tonumber(string.sub(currentPhases, moonIndex, moonIndex))
                else nil

            if currentPhase == moonIndex then
                continue
            end

            local moonName = tostring(moonIndex)
            local moon = moons:FindFirstChild(moonName)
            if not moon or not moon:IsA("BasePart") then
                continue
            end

            local prompt = moon:FindFirstChildOfClass("ProximityPrompt")
            if not prompt or not prompt.Enabled then
                continue
            end

            rootPart.CFrame = CFrame.new(moon.Position + Vector3.new(0, 3, 0))
            rootPart.AssemblyLinearVelocity = Vector3.zero
            task.wait(0.08)

            local attempts = 0
            while attempts < 6 and prompt.Enabled and isPuzzleActive(moons) and isEnabled do
                currentPhases = replicator:GetAttribute("Phases")
                currentPhase = if type(currentPhases) == "string" and #currentPhases >= moonIndex
                    then tonumber(string.sub(currentPhases, moonIndex, moonIndex))
                    else nil

                if currentPhase == moonIndex then
                    break
                end

                attempts += 1
                local phaseBefore = currentPhases

                fireproximityprompt(prompt)

                local waitStart = os.clock()
                while os.clock() - waitStart < 0.6 do
                    task.wait(0.05)

                    local phaseAfter = replicator:GetAttribute("Phases")
                    if phaseAfter ~= phaseBefore then
                        break
                    end
                end

                task.wait(0.12)
            end
        end
    end

    local restoredRoot = getRootPart()
    if restoredRoot then
        restoredRoot.CFrame = savedCFrame
        restoredRoot.AssemblyLinearVelocity = Vector3.zero
    end

    isSolving = false

    if isEnabled then
        updateIndicator("moon puzzle: ready", Color3.fromRGB(80, 220, 120))
    else
        updateIndicator("moon puzzle: disabled", Color3.fromRGB(140, 60, 60))
    end
end

local function setFeatureEnabled(targetState: boolean)
    isEnabled = targetState

    if isEnabled then
        updateIndicator("moon puzzle: ready", Color3.fromRGB(80, 220, 120))
        task.spawn(solvePuzzle)
    else
        updateIndicator("moon puzzle: disabled", Color3.fromRGB(140, 60, 60))
    end
end

local buttonClickConnection = toggleButton.Activated:Connect(function()
    setFeatureEnabled(not isEnabled)
end)
table.insert(connections, buttonClickConnection)

local keybindConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end

    if input.KeyCode == Enum.KeyCode.P then
        setFeatureEnabled(not isEnabled)
    end
end)
table.insert(connections, keybindConnection)

local function bindPuzzleListeners()
    local _, moons, replicator = getPuzzleInstances()
    if not moons or not replicator then
        return
    end

    for _, moon in moons:GetChildren() do
        local prompt = moon:FindFirstChildOfClass("ProximityPrompt")
        if not prompt then
            continue
        end

        local promptConnection = prompt:GetPropertyChangedSignal("Enabled"):Connect(function()
            if isEnabled and prompt.Enabled then
                task.spawn(solvePuzzle)
            end
        end)
        table.insert(connections, promptConnection)
    end

    local phasesConnection = replicator:GetAttributeChangedSignal("Phases"):Connect(function()
        local phases = replicator:GetAttribute("Phases")
        if isEnabled and phases ~= "12345" and isPuzzleActive(moons) then
            task.spawn(solvePuzzle)
        end
    end)
    table.insert(connections, phasesConnection)

    local alertConnection = replicator:GetAttributeChangedSignal("AlertCount"):Connect(function()
        if isEnabled then
            task.spawn(solvePuzzle)
        end
    end)
    table.insert(connections, alertConnection)
end

bindPuzzleListeners()

loopThread = task.spawn(function()
    while true do
        task.wait(0.5)

        if not isEnabled then
            continue
        end

        local _, moons, replicator = getPuzzleInstances()
        if moons and replicator and isPuzzleActive(moons) then
            local phases = replicator:GetAttribute("Phases")
            if phases ~= "12345" then
                solvePuzzle()
            end
        end
    end
end)

local function cleanup()
    for _, connection in connections do
        connection:Disconnect()
    end

    table.clear(connections)

    if loopThread and coroutine.status(loopThread) == "suspended" then
        pcall(task.cancel, loopThread)
    end

    destroyIndicator()
end

genv._MoonPuzzleCleanup = cleanup
