-- Auto Progress TDS Strategy API
-- Upload this file to:
--   RyaaV2/lists/apis/tds.lua
--
-- Only the TDS: strategy methods live here.
-- Main-script helpers/state are passed in through Context.

return function(Context)
    if type(Context) ~= "table" then
        warn("[TDS API] Missing context")
        return nil
    end

    local TDS = Context.TDS

    if type(TDS) ~= "table" then
        warn("[TDS API] Missing TDS table")
        return nil
    end

    local plr = Context.plr
    local rf = Context.rf
    local ReplicatedStorage = Context.ReplicatedStorage
    local StrategyConfig = Context.StrategyConfig

    local ProtectedNoop = Context.ProtectedNoop
    local IsStrategyRuntimeEnabled = Context.IsStrategyRuntimeEnabled
    local GetDirectGameStateReplicator = Context.GetDirectGameStateReplicator
    local DirectResponseOK = Context.DirectResponseOK
    local DirectSetLoadout = Context.DirectSetLoadout
    local DirectSelectMap = Context.DirectSelectMap
    local StartDirectSelectiveSkip = Context.StartDirectSelectiveSkip
    local StartDirectAutoSkip = Context.StartDirectAutoSkip
    local DirectReady = Context.DirectReady
    local DirectUpgradeTower = Context.DirectUpgradeTower
    local DirectSellTower = Context.DirectSellTower
    local DirectWaitForWave = Context.DirectWaitForWave
    local DirectSetTarget = Context.DirectSetTarget

    local MarketplaceService = game:GetService("MarketplaceService")
    local VIP_GAMEPASS_ID = 10518590

    local RuntimeGlobals = getgenv()
    RuntimeGlobals.__RyaVIPVoteSkipVersion =
        (tonumber(RuntimeGlobals.__RyaVIPVoteSkipVersion) or 0) + 1

    local VIPVoteSkipVersion =
        RuntimeGlobals.__RyaVIPVoteSkipVersion

    local HasVIP = Context.HasVIP

    if HasVIP == nil then
        HasVIP = false

        pcall(function()
            HasVIP = MarketplaceService:UserOwnsGamePassAsync(
                plr.UserId,
                VIP_GAMEPASS_ID
            ) == true
        end)
    end

    TDS.HasVIP = HasVIP


    -- Tower support automation (per API instance).
    local TowerAutoFlags = {Commander=false, DJ=false, Necromancer=false}
    local TowerAutoRunning = {Commander=false, DJ=false, Necromancer=false}
    local function SupportTowers(name, minLevel)
        local found = {}
        local folder = workspace:FindFirstChild("Towers")
        if not folder then return found end
        for _, rep in ipairs(folder:GetDescendants()) do
            if rep:IsA("Folder") and rep.Name == "TowerReplicator"
                and rep:GetAttribute("Name") == name
                and tonumber(rep:GetAttribute("OwnerId")) == plr.UserId
                and (tonumber(rep:GetAttribute("Upgrade")) or 0) >= minLevel then
                table.insert(found, rep.Parent)
            end
        end
        return found
    end
    local function ActivateSupport(tower, ability)
        local ok, result = pcall(function()
            return rf:InvokeServer("Troops", "Abilities", "Activate",
                {Troop=tower, Name=ability, Data={}})
        end)
        return ok and result ~= false and result ~= nil
    end
    local function SupportDelay(seconds)
        local pg = plr:FindFirstChild("PlayerGui")
        local hotbar = pg and pg:FindFirstChild("ReactUniversalHotbar")
        local frame = hotbar and hotbar:FindFirstChild("Frame")
        local scale = frame and frame:FindFirstChild("timescale")
        if scale and scale.Visible then
            local lock = scale:FindFirstChild("Lock")
            if lock and not lock.Visible then return seconds / 2 end
        end
        return seconds
    end
    local function CountNecroGraves(rep)
        local store = rep and rep:FindFirstChild("GraveStone")
        if not store then return 0, 0 end
        local max = tonumber(store:GetAttribute("Max_Graves"))
            or tonumber(rep:GetAttribute("Max_Graves"))
        local level = tonumber(rep:GetAttribute("Upgrade")) or 0
        if not max or max < 2 then
            max = level >= 4 and 9 or (level >= 2 and 6 or 3)
        end
        local count = 0
        for key, value in pairs(store:GetAttributes()) do
            if type(key) == "string" and #key > 20 then
                if tostring(value):find("Destroy") then
                    store:SetAttribute(key, nil)
                else
                    count += 1
                end
            end
        end
        return count, max
    end
    local function StartSupportAuto(kind)
        if TowerAutoRunning[kind] or not TowerAutoFlags[kind] then return end
        TowerAutoRunning[kind] = true
        task.spawn(function()
            local index, lastUsed = 1, {}
            while TowerAutoFlags[kind] and IsStrategyRuntimeEnabled() do
                local name = kind == "DJ" and "DJ Booth" or kind
                local minLevel = kind == "Commander" and 2 or (kind == "DJ" and 3 or 0)
                local towers = SupportTowers(name, minLevel)
                if #towers == 0 then
                    index = 1
                    task.wait(0.3)
                else
                    if index > #towers then index = 1 end
                    local tower = towers[index]
                    index = index % #towers + 1
                    local now = os.clock()
                    if kind == "Commander" then
                        local last = lastUsed[tower]
                        if last == nil or now-last >= SupportDelay(30) then
                            local rep = tower:FindFirstChild("TowerReplicator")
                            if rep and (tonumber(rep:GetAttribute("Upgrade")) or 0) >= 4
                                and getgenv().SupportCaravan ~= false then
                                ActivateSupport(tower, "Support Caravan")
                            end
                            if ActivateSupport(tower, "Call Of Arms") then
                                lastUsed[tower] = os.clock()
                                task.wait(SupportDelay(10.5))
                            else
                                task.wait(0.25)
                            end
                        else
                            task.wait(0.1)
                        end
                    elseif kind == "DJ" then
                        ActivateSupport(tower, "Drop The Beat")
                        task.wait(1)
                    else
                        local rep = tower:FindFirstChild("TowerReplicator")
                        local count, max = CountNecroGraves(rep)
                        local cooldown = tonumber(rep and rep:GetAttribute("AbilityDebounce")) or 5
                        if max > 0 and count >= max
                            and (not lastUsed[tower] or now-lastUsed[tower] >= cooldown) then
                            if ActivateSupport(tower, "Raise The Dead") then
                                lastUsed[tower] = os.clock()
                                task.wait(1)
                            else
                                task.wait(0.5)
                            end
                        else
                            task.wait(0.1)
                        end
                    end
                end
            end
            TowerAutoRunning[kind] = false
        end)
    end
    function TDS:AutoChain()
        TowerAutoFlags.Commander = true
        StartSupportAuto("Commander")
        return true
    end
    function TDS:AutoDJ()
        TowerAutoFlags.DJ = true
        StartSupportAuto("DJ")
        return true
    end
    function TDS:AutoNecro()
        TowerAutoFlags.Necromancer = true
        StartSupportAuto("Necromancer")
        return true
    end

    local VoteSkipWaves = {}
    local VoteSkipAll = false
    local VoteSkipConfigured = false
    local VIPVoteSkipWorkerRunning = false
    local NormalVoteSkipWorkerRunning = false
    local SetAutoSkip
    local StartVIPVoteSkip

    function TDS:ResetIndex()
        self.PlacedTowers = {}
        self.placed_towers = self.PlacedTowers
        self.StackCounts = {}

        table.clear(VoteSkipWaves)
        VoteSkipAll = false
        VoteSkipConfigured = false

        if HasVIP
            and SetAutoSkip then

            SetAutoSkip(false)

            if StartVIPVoteSkip then
                StartVIPVoteSkip()
            end
        end
    end

    function TDS:Place(towerName, x, y, z, ...)
        local args = {...}
        local isStacking =
            args[#args] == true
            or args[#args] == "stack"
    
        local position = Vector3.new(x, y, z)
    
        if isStacking then
            local baseY = tonumber(y) or 0
    
            
            
            if math.abs(baseY) < 0.001 then
                local rayParams = RaycastParams.new()
                rayParams.FilterType = Enum.RaycastFilterType.Exclude
    
                local ignore = {}
                local towersFolder = workspace:FindFirstChild("Towers")
    
                if towersFolder then
                    table.insert(ignore, towersFolder)
                end
    
                if plr.Character then
                    table.insert(ignore, plr.Character)
                end
    
                rayParams.FilterDescendantsInstances = ignore
    
                local hit = workspace:Raycast(
                    Vector3.new(x, 250, z),
                    Vector3.new(0, -1000, 0),
                    rayParams
                )
    
                if not hit then
                    ProtectedNoop("[STACKER] No surface found:", towerName, x, y, z)
                    return false
                end
    
                baseY = hit.Position.Y
            end
    
            local stackKey = string.format("%.5f|%.5f", tonumber(x) or 0, tonumber(z) or 0)
            local stackNumber = (self.StackCounts[stackKey] or 0) + 1
            self.StackCounts[stackKey] = stackNumber
    
            position = Vector3.new(
                x,
                baseY + 25,
                z
            )
        end
    
        local towersFolder = workspace:WaitForChild("Towers")
    
        local existing = {}
    
        for _, tower in ipairs(towersFolder:GetChildren()) do
            local owner = tower:FindFirstChild("Owner")
    
            if owner and owner.Value == plr.UserId then
                existing[tower] = true
            end
        end
    
        
        while IsStrategyRuntimeEnabled() do
            local gameStateReplicator = GetDirectGameStateReplicator()
    
            if gameStateReplicator
                and gameStateReplicator:GetAttribute("GameOver") == true then
                return false
            end
    
            local ok, result = pcall(function()
                if isStacking then
                    return rf:InvokeServer(
                        "Troops",
                        "Place",
                        {
                            Rotation = CFrame.new(),
                            Position = position
                        },
                        towerName
                    )
                end
    
                return rf:InvokeServer(
                    "Troops",
                    "Place",
                    {
                        Rotation = CFrame.new(),
                        Position = position
                    },
                    towerName,
                    (table.unpack or unpack)(args)
                )
            end)
    
            if ok and DirectResponseOK(result) then
                break
            end
    
            task.wait(0.25)
        end
    
        if not IsStrategyRuntimeEnabled() then
            return false
        end
    
        local newTower
    
        repeat
            local gameStateReplicator = GetDirectGameStateReplicator()
    
            if gameStateReplicator
                and gameStateReplicator:GetAttribute("GameOver") == true then
                return false
            end
    
            for _, tower in ipairs(towersFolder:GetChildren()) do
                if not existing[tower] then
                    local owner = tower:FindFirstChild("Owner")
    
                    if owner and owner.Value == plr.UserId then
                        newTower = tower
                        break
                    end
                end
            end
    
            if not newTower then
                task.wait(0.05)
            end
        until newTower
    
        table.insert(TDS.PlacedTowers, newTower)
        return #TDS.PlacedTowers
    end
    
    if TDS.AutoMercenaryEnabled == nil then
        TDS.AutoMercenaryEnabled = true
    end

    function TDS:SetAutoMercenary(enabled)
        self.AutoMercenaryEnabled =
            enabled ~= false

        if self.AutoMercenaryEnabled
            and self.HasMercenaryBase == true then

            self:Mercenary()
        end

        return self.AutoMercenaryEnabled
    end

    function TDS:Loadout(...)
        local requested = {...}
        local hasMercenaryBase = false

        for _, towerName in ipairs(requested) do
            towerName = tostring(towerName)

            if towerName == "Gatling Gun" then
                local loadAutoGatling =
                    RuntimeGlobals.__RyaLoadAutoGatling

                if type(loadAutoGatling) == "function" then
                    task.spawn(function()
                        pcall(
                            loadAutoGatling
                        )
                    end)
                end
            elseif towerName == "Mercenary Base" then
                hasMercenaryBase = true
            elseif towerName == "Commander" then
                TowerAutoFlags.Commander = true
                StartSupportAuto("Commander")
            elseif towerName == "DJ Booth" then
                TowerAutoFlags.DJ = true
                StartSupportAuto("DJ")
            elseif towerName == "Necromancer" then
                TowerAutoFlags.Necromancer = true
                StartSupportAuto("Necromancer")
            end
        end

        self.HasMercenaryBase =
            hasMercenaryBase

        if self.AutoMercenaryEnabled ~= false
            and self.HasMercenaryBase then

            self:Mercenary()
        end

        return DirectSetLoadout(
            (table.unpack or unpack)(requested)
        )
    end

    local function BuildMatchmakingPayload(
        difficulty
    )
        difficulty =
            tostring(
                difficulty or ""
            )

        if difficulty == "Trial" then
            return {
                count = 1,
                mode = "Trials"
            }
        end

        return nil
    end

    function TDS:Mode(difficulty)
        difficulty =
            tostring(
                difficulty or ""
            )

        self.SavedDifficulty =
            difficulty

        self.SavedMatchmaking =
            BuildMatchmakingPayload(
                difficulty
            )

        if difficulty ~= "Trial" then
            return true
        end

        local playerGui =
            plr:FindFirstChild("PlayerGui")

        local lobbyHud =
            playerGui
            and playerGui:FindFirstChild(
                "ReactLobbyHud"
            )

        local hotbar =
            playerGui
            and playerGui:FindFirstChild(
                "ReactUniversalHotbar"
            )

        if not lobbyHud
            and hotbar then

            return false
        end

        local ok, result =
            pcall(function()
                return rf:InvokeServer(
                    "Multiplayer",
                    "v2:start",
                    table.clone(
                        self.SavedMatchmaking
                    )
                )
            end)

        return ok
            and result ~= false
    end

    function TDS:GameInfo(mapName, modifiers)
        if type(modifiers) == "table" then

            local votes = {}

            -- Supports both:
            -- {"HiddenEnemies", "Fog"}
            -- {HiddenEnemies = true, Fog = true, Glass = false}
            for key, value in pairs(modifiers) do
                if type(key) == "number" then
                    if value ~= nil and value ~= false then
                        votes[tostring(value)] = true
                    end
                elseif value == true then
                    votes[tostring(key)] = true
                end
            end

            pcall(function()
                ReplicatedStorage
                    :WaitForChild("Network")
                    :WaitForChild("Modifiers")
                    :WaitForChild(
                        "RF:BulkVoteModifiers"
                    )
                    :InvokeServer(votes)
            end)
        end

        return DirectSelectMap(
            tostring(mapName)
        )
    end

    local function GetAutoSkipButton()
        local playerGui = plr:FindFirstChild("PlayerGui")
        local settings = playerGui and playerGui:FindFirstChild("ReactUniversalSettings")
        local window = settings and settings:FindFirstChild("window")
        local scrollingFrame = window and window:FindFirstChild("scrollingFrame")
        local unknown = scrollingFrame and scrollingFrame:FindFirstChild("Unknown")
        local autoSkip = unknown and unknown:FindFirstChild("Auto Skip")
        local button = autoSkip and autoSkip:FindFirstChild("button")
        local toggle = button and button:FindFirstChild("toggle")

        return toggle and toggle:FindFirstChild("imageButton")
    end

    local function GetAutoSkipState()
        local button = GetAutoSkipButton()

        if not button then
            return nil
        end

        local contentText = button:FindFirstChild("contentText")

        if not contentText then
            return nil
        end

        local text = tostring(contentText.Text):lower()

        if text == "enabled" then
            return true
        end

        if text == "disabled" then
            return false
        end

        return nil
    end

    local AutoSkipPendingState = nil
    local AutoSkipLastClickAt = 0

    local function ToggleAutoSkip()
        local button =
            GetAutoSkipButton()

        if not button
            or type(getconnections) ~= "function" then

            return false
        end

        local downConnections =
            getconnections(
                button.MouseButton1Down
            )

        local upConnections =
            getconnections(
                button.MouseButton1Up
            )

        if #downConnections == 0
            or #upConnections == 0 then

            return false
        end

        for _, connection in ipairs(
            downConnections
        ) do
            pcall(function()
                connection.Function()
            end)
        end

        task.wait(0.05)

        for _, connection in ipairs(
            upConnections
        ) do
            pcall(function()
                connection.Function()
            end)
        end

        return true
    end

    SetAutoSkip = function(enabled)
        enabled = enabled == true

        local current = GetAutoSkipState()

        if current == nil then
            return false
        end

        if current == enabled then
            AutoSkipPendingState = nil
            return true
        end

        if AutoSkipPendingState == enabled
            and os.clock() - AutoSkipLastClickAt < 0.5 then

            return false
        end

        AutoSkipPendingState = enabled
        AutoSkipLastClickAt = os.clock()

        if not ToggleAutoSkip() then
            AutoSkipPendingState = nil
            return false
        end

        task.wait(0.15)

        current = GetAutoSkipState()

        if current == enabled then
            AutoSkipPendingState = nil
            return true
        end

        return false
    end

    local function GetCurrentWaveNoWait()
        local playerGui = plr:FindFirstChild("PlayerGui")
        local gui = playerGui and playerGui:FindFirstChild("ReactGameTopGameDisplay")
        local frame = gui and gui:FindFirstChild("Frame")
        local wave = frame and frame:FindFirstChild("wave")
        local container = wave and wave:FindFirstChild("container")
        local value = container and container:FindFirstChild("value")

        if not value then
            return nil
        end

        return tonumber(tostring(value.Text):match("(%d+)"))
    end

    local function GetNormalVoteButton()
        local playerGui = plr:FindFirstChild("PlayerGui")
        local voteGui = playerGui and playerGui:FindFirstChild("ReactOverridesVote")
        local frameObject = voteGui and voteGui:FindFirstChild("Frame")
        local votes = frameObject and frameObject:FindFirstChild("votes")

        return votes and votes:FindFirstChild("vote")
    end

    local function CanNormalVoteSkip()
        local stateReplicators =
            ReplicatedStorage:FindFirstChild("StateReplicators")

        local voteReplicator =
            stateReplicators
            and stateReplicators:FindFirstChild("VoteReplicator")

        if voteReplicator
            and voteReplicator:GetAttribute("Enabled") == true
            and voteReplicator:GetAttribute("Title") == "Skip?" then

            return true
        end

        local voteButton = GetNormalVoteButton()

        return voteButton ~= nil
            and voteButton.Position == UDim2.new(0.5, 0, 0.5, 0)
    end

    local function UpdateVIPAutoSkip()
        if not VoteSkipConfigured then
            SetAutoSkip(false)
            return
        end

        if VoteSkipAll then
            SetAutoSkip(true)
            return
        end

        local currentWave = GetCurrentWaveNoWait()

        if not currentWave or currentWave <= 0 then
            SetAutoSkip(VoteSkipWaves[1] == true)
            return
        end

        SetAutoSkip(VoteSkipWaves[currentWave] == true)
    end

    StartVIPVoteSkip = function()
        if VIPVoteSkipWorkerRunning then
            return
        end

        VIPVoteSkipWorkerRunning = true

        task.spawn(function()
            while IsStrategyRuntimeEnabled()
                and RuntimeGlobals.__RyaVIPVoteSkipVersion
                    == VIPVoteSkipVersion do

                UpdateVIPAutoSkip()
                task.wait(0.1)
            end

            VIPVoteSkipWorkerRunning = false
        end)
    end

    local function StartNormalVoteSkip()
        if NormalVoteSkipWorkerRunning then
            return
        end

        NormalVoteSkipWorkerRunning = true

        task.spawn(function()
            while IsStrategyRuntimeEnabled() do
                local gameStateReplicator = GetDirectGameStateReplicator()

                if not gameStateReplicator
                    or gameStateReplicator:GetAttribute("GameOver") == true then

                    task.wait(0.2)
                    continue
                end

                local currentWave = GetCurrentWaveNoWait()

                if currentWave and VoteSkipWaves[currentWave] then
                    if CanNormalVoteSkip() then
                        pcall(function()
                            rf:InvokeServer("Voting", "Skip")
                        end)

                        task.wait(0.2)
                    else
                        task.wait(0.1)
                    end
                else
                    task.wait(0.1)
                end
            end

            NormalVoteSkipWorkerRunning = false
        end)
    end

    function TDS:VoteSkip(startWave, endWave)
        VoteSkipConfigured = true

        if startWave == nil and endWave == nil then
            VoteSkipAll = true

            if HasVIP then
                UpdateVIPAutoSkip()
                StartVIPVoteSkip()
            else
                StartDirectAutoSkip()
            end

            return true
        end

        startWave = tonumber(startWave)

        if not startWave then
            return false
        end

        if endWave == nil then
            endWave = startWave
        else
            endWave = tonumber(endWave)

            if not endWave then
                return false
            end
        end

        startWave = math.floor(startWave)
        endWave = math.floor(endWave)

        if endWave < startWave then
            startWave, endWave = endWave, startWave
        end

        for wave = startWave, endWave do
            VoteSkipWaves[wave] = true
        end

        if HasVIP then
            UpdateVIPAutoSkip()
            StartVIPVoteSkip()
        else
            StartNormalVoteSkip()
        end

        return true
    end

    function TDS:Ready()
        return DirectReady()
    end

    function TDS:Upgrade(index, path)
        return DirectUpgradeTower(
            tonumber(index),
            tonumber(path) or 1
        )
    end

    function TDS:UpgradeTimes(index, count, path)
        index = tonumber(index)
        count =
            math.max(
                math.floor(
                    tonumber(count) or 0
                ),
                0
            )
        path = tonumber(path) or 1

        if not index then
            return false
        end

        for _ = 1, count do
            if not DirectUpgradeTower(
                index,
                path
            ) then
                return false
            end

            task.wait(0.15)
        end

        return true
    end

    function TDS:Sell(index)
        return DirectSellTower(
            tonumber(index)
        )
    end

    function TDS:WaitForWave(wave)
        return DirectWaitForWave(
            tonumber(wave) or 0
        )
    end

    function TDS:SetTarget(index, targetType)
        return DirectSetTarget(
            tonumber(index),
            targetType
        )
    end

    function TDS:SetOption(index, name, value)
        local tower =
            TDS.PlacedTowers[
                tonumber(index)
            ]

        if not tower
            or not tower.Parent then

            return false
        end

        while IsStrategyRuntimeEnabled() do
            local ok, result =
                pcall(function()
                    return rf:InvokeServer(
                        "Troops",
                        "Option",
                        "Set",
                        {
                            Troop = tower,
                            Name = name,
                            Value = value
                        }
                    )
                end)

            if ok
                and DirectResponseOK(
                    result
                ) then

                return true
            end

            local rep =
                GetDirectGameStateReplicator()

            if rep
                and rep:GetAttribute(
                    "GameOver"
                ) == true then

                return false
            end

            task.wait(0.25)
        end

        return false
    end

    function TDS:StackPosition(x, y, z, offset)
        return Vector3.new(
            tonumber(x) or 0,
            (tonumber(y) or 0)
                + (
                    tonumber(offset)
                    or 0
                ) * 3.5,
            tonumber(z) or 0
        )
    end

    local MercenaryAutomationRunning = false
    local MercenaryAutomationData = {
        Dist = 195,
        PathName = 1
    }

    function TDS:Mercenary(dist, pathName)
        MercenaryAutomationData.Dist =
            tonumber(dist)
            or MercenaryAutomationData.Dist

        MercenaryAutomationData.PathName =
            tonumber(pathName)
            or MercenaryAutomationData.PathName

        if MercenaryAutomationRunning then
            return true
        end

        local towerConfig =
            type(StrategyConfig) == "table"
            and type(StrategyConfig.Towers) == "table"
            and type(StrategyConfig.Towers.Automation) == "table"
            and StrategyConfig.Towers.Automation.Mercenary
            or nil
        local towerName = type(towerConfig) == "table" and tostring(towerConfig.Tower or "Mercenary Base") or "Mercenary Base"
        local abilityName = type(towerConfig) == "table" and tostring(towerConfig.Ability or "Air-Drop") or "Air-Drop"
        local minUpgrade = type(towerConfig) == "table" and tonumber(towerConfig.MinUpgrade) or 5
        local interval = type(towerConfig) == "table" and tonumber(towerConfig.Interval) or 0.5

        MercenaryAutomationRunning = true

        task.spawn(function()
            while IsStrategyRuntimeEnabled()
                and TDS.AutoMercenaryEnabled ~= false do

                local towersFolder =
                    workspace:FindFirstChild(
                        "Towers"
                    )

                if towersFolder then
                    for _, towerRep in ipairs(
                        towersFolder:GetDescendants()
                    ) do
                        if towerRep:IsA("Folder")
                            and towerRep.Name
                                == "TowerReplicator"
                            and towerRep:GetAttribute(
                                "Name"
                            ) == towerName
                            and towerRep:GetAttribute(
                                "OwnerId"
                            ) == plr.UserId
                            and (
                                tonumber(
                                    towerRep:GetAttribute(
                                        "Upgrade"
                                    )
                                )
                                or 0
                            ) >= minUpgrade then

                            pcall(function()
                                rf:InvokeServer(
                                    "Troops",
                                    "Abilities",
                                    "Activate",
                                    {
                                        Troop =
                                            towerRep.Parent,
                                        Name =
                                            abilityName,
                                        Data = {
                                            pathName =
                                                MercenaryAutomationData.PathName,
                                            directionCFrame =
                                                CFrame.new(),
                                            dist =
                                                MercenaryAutomationData.Dist
                                        }
                                    }
                                )
                            end)

                            task.wait(interval)
                        end
                    end
                end

                task.wait(interval)
            end

            MercenaryAutomationRunning = false
        end)

        return true
    end

    function TDS:Ability(index, abilityName, data, loop)
        index =
            tonumber(index)
    
        if type(data) == "boolean" then
            loop = data
            data = nil
        end
    
        data =
            type(data) == "table"
            and data
            or nil
    
        local function Activate()
            while IsStrategyRuntimeEnabled() do
                local tower =
                    TDS.PlacedTowers[
                        index
                    ]
    
                if not tower
                    or not tower.Parent then
    
                    return false
                end
    
                local payload =
                    data
                    and table.clone(data)
                    or nil
    
                if payload then
                    if type(
                        payload.towerToClone
                    ) == "number" then
    
                        payload.towerToClone =
                            TDS.PlacedTowers[
                                payload.towerToClone
                            ]
                    end
    
                    if type(
                        payload.towerTarget
                    ) == "number" then
    
                        payload.towerTarget =
                            TDS.PlacedTowers[
                                payload.towerTarget
                            ]
                    end
    
                    if type(
                        payload.towerPosition
                    ) == "table"
                        and #payload.towerPosition > 0 then
    
                        payload.towerPosition =
                            payload.towerPosition[
                                math.random(
                                    #payload.towerPosition
                                )
                            ]
                    end
                end
    
                local ok, result =
                    pcall(function()
                        return rf:InvokeServer(
                            "Troops",
                            "Abilities",
                            "Activate",
                            {
                                Troop = tower,
                                Name = abilityName,
                                Data = payload
                            }
                        )
                    end)
    
                if ok
                    and DirectResponseOK(result) then
    
                    return true
                end
    
                task.wait(0.25)
            end
    
            return false
        end
    
        if loop == true then
            local active = true
    
            task.spawn(function()
                while active
                    and IsStrategyRuntimeEnabled() do
    
                    Activate()
                    task.wait(1)
                end
            end)
    
            return function()
                active = false
            end
        end
    
        return Activate()
    end
    
    function TDS:LoopAbility(index, abilityName, data)
        return TDS:Ability(
            index,
            abilityName,
            data,
            true
        )
    end
    


    shared.TDSTable = TDS
    shared["TDS_Table"] = TDS

    local MedicChainAPI

    function TDS:MedicChain(...)
        if not MedicChainAPI then
            local loaded = loadstring(game:HttpGet(
                "https://raw.githubusercontent.com/Ceepizz/rya/refs/heads/main/api"
            ))()

            if type(loaded) == "table"
                and type(loaded.MedicChain) == "function" then

                MedicChainAPI = loaded.MedicChain

            elseif type(loaded) == "function" then
                MedicChainAPI = loaded

            else
                warn("[MedicChain] Failed to load API")
                return false
            end
        end

        return MedicChainAPI(self, ...)
    end

    return TDS
end
