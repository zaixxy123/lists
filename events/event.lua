local Event = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("RemoteFunction")
local LOBBY_PLACE_ID = 3260590327

-- Each night lives in events/nights/nightN.lua and exports
-- Requirements, PrepareLobby, Queue and Run.
local NightCache = {}
local function GetNightModule(night)
    local number = type(night) == "string" and night:match("^Night ([1-9]%d*)$")
    if not number then return nil end
    if NightCache[number] then return NightCache[number] end
    local url = "https://raw.githubusercontent.com/RyaaV2/lists/refs/heads/main/events/nights/night" .. number .. ".lua"
    local ok, module = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if not ok or type(module) ~= "table"
        or type(module.Queue) ~= "function"
        or type(module.Run) ~= "function" then
        return nil
    end
    NightCache[number] = module
    return module
end

local Running = false
local SkipGeneration = 0
local StrategyStarted = false
local MatchQueued = false
local ModuleSession = 0
local ActiveNight = nil
local ActiveMode = nil

local function IsGameOver()
    local rs = ReplicatedStorage:FindFirstChild("StateReplicators")
    local rep = rs and rs:FindFirstChild("GameStateReplicator")
    return rep and rep:GetAttribute("GameOver") == true or false
end

local function ReturnToLobby()
    local network = ReplicatedStorage:FindFirstChild("Network")
    local teleport = network and network:FindFirstChild("Teleport")
    local back = teleport and teleport:FindFirstChild("RE:backToLobby")

    if back then
        pcall(function()
            back:FireServer()
        end)
    end

    -- The back-to-lobby remote can be absent or fail to teleport.
    task.wait(5)
    if game.PlaceId ~= LOBBY_PLACE_ID then
        pcall(function()
            game:GetService("TeleportService"):Teleport(
                LOBBY_PLACE_ID,
                Players.LocalPlayer
            )
        end)
    end
end

local function EndMatchWatch(session)
    task.spawn(function()
        while Running and ModuleSession == session do
            if IsGameOver() then
                -- Give the match-complete webhook time to record rewards.
                task.wait(3.5)
                if not Running or ModuleSession ~= session then
                    break
                end

                local globals = getgenv()
                local pending = tostring(
                    globals.__RyaAutoFarmTransitionTarget
                    or globals.PendingAutoFarmTarget
                    or ""
                )

                if pending ~= "" and pending ~= "Event" then
                    if globals.__RyaApplyAutoFarmTransition then
                        globals.__RyaApplyAutoFarmTransition()
                    end
                    Running = false
                    SkipGeneration += 1
                    ReturnToLobby()
                    break
                end

                -- Matchmaking is attempted immediately after game over.
                -- If the server does not accept it, lobby startup retries.
                if globals.AutoEventEnabled == true
                    and tostring(globals.EventNight or "Night 1") == ActiveNight
                    and tostring(globals.EventMode or "Easy") == ActiveMode then
                    local nightModule = GetNightModule(ActiveNight)
                    local ok, result = false, false
                    if nightModule then
                        ok, result = pcall(nightModule.Queue, ActiveMode)
                        if ok and result == true then result = true end
                    end
                    if ok and result ~= false then
                        MatchQueued = true
                        -- An InvokeServer call may return without actually
                        -- starting matchmaking. Verify the match transitions.
                        local originalJob = game.JobId
                        local deadline = os.clock() + 8
                        repeat
                            task.wait(0.5)
                            if not IsGameOver()
                                or game.JobId ~= originalJob
                                or game.PlaceId == LOBBY_PLACE_ID then
                                Running = false
                                SkipGeneration += 1
                                return
                            end
                        until os.clock() >= deadline
                        MatchQueued = false
                    end
                end

                Running = false
                SkipGeneration += 1
                ReturnToLobby()
                break
            end
            task.wait(0.25)
        end
    end)
end

function Event.GetRequirements(night, mode)
    local module = GetNightModule(night)
    if not module then return "Coming soon" end
    local towers = module.Requirements and module.Requirements[mode]
    if type(towers) ~= "table" or #towers == 0 then
        return "Not configured yet"
    end
    return towers
end

function Event.GetRequiredLevel(night, mode)
    return nil
end

local function StartSkipWatcher()
    SkipGeneration += 1
    local generation = SkipGeneration
    task.spawn(function()
        local gui = Players.LocalPlayer:WaitForChild("PlayerGui")
        local lastVote = 0
        while Running and SkipGeneration == generation do
            local voteGui = gui:FindFirstChild("ReactOverridesVote")
            local frame = voteGui and voteGui:FindFirstChild("Frame")
            local votes = frame and frame:FindFirstChild("votes")
            local button = votes and votes:FindFirstChild("button")
            local label = button and button:FindFirstChild("text")
            local visible = voteGui and voteGui.Enabled
                and frame and frame.Visible
                and votes and votes.Visible
                and button and button.Visible
            local isSkip = label and label:IsA("TextLabel")
                and label.Text:lower():find("hold to skip", 1, true)
            if visible and isSkip and os.clock() - lastVote >= 3 then
                lastVote = os.clock()
                task.spawn(function()
                    pcall(function()
                        Remote:InvokeServer("Voting", "Skip")
                    end)
                end)
            end
            task.wait(0.1)
        end
    end)
end

function Event.Start(night, mode, TDS)
    if mode ~= "Hard" and mode ~= "Easy" then return false end
    if Running or MatchQueued then return false end

    local nightModule = GetNightModule(night)
    if not nightModule then return false end
    if type(nightModule.Requirements) ~= "table"
        or type(nightModule.Requirements[mode]) ~= "table" then
        return false
    end

    if game.PlaceId == LOBBY_PLACE_ID then
        if type(nightModule.PrepareLobby) == "function" then
            local ok, result = pcall(nightModule.PrepareLobby, mode)
            if not ok or result ~= true then
                warn("[Auto Event] Failed to prepare " .. night .. " " .. mode .. " lobby loadout")
                return false
            end
        end
        local ok, result = pcall(nightModule.Queue, mode)
        if ok and result == true then
            MatchQueued = true
            return true
        end
        return false
    end

    -- Use the API instance installed by the main Auto Progress backend.
    TDS = TDS or shared.TDSTable or shared["TDS_Table"]
    if type(TDS) ~= "table" or StrategyStarted then return false end

    ActiveNight = night
    ActiveMode = mode
    Running = true
    StrategyStarted = true
    ModuleSession += 1
    StartSkipWatcher()
    EndMatchWatch(ModuleSession)
    task.spawn(function()
        local ok, err = pcall(nightModule.Run, mode, TDS)
        if not ok then
            warn("[Auto Event] " .. night .. " " .. mode .. " strategy error:", err)
        end
    end)
    return true
end

function Event.Stop()
    Running = false
    SkipGeneration += 1
    ModuleSession += 1
    MatchQueued = false
    ActiveNight = nil
    ActiveMode = nil
    return true
end

return Event
