local Solar = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Remote = ReplicatedStorage:WaitForChild("RemoteFunction")
local Globals = getgenv()

local LOBBY_PLACE_ID = 3260590327
local ROOT_URL = "https://raw.githubusercontent.com/zaixxy123/Try/refs/heads/main/hard-nights/"
local PUZZLE_URL = "https://raw.githubusercontent.com/zaixxy123/lists/refs/heads/main/puzzle.lua"

local RequiredTowers = {
    "DJ Booth",
    "Gatling Gun",
    "Mercenary Base",
    "Hacker",
    "Assassin"
}

local Session = 0
local Running = false
local LobbyQueued = false
local ActiveContext = nil

function Solar.GetRequirements()
    return table.clone(RequiredTowers)
end

local function Status(message)
    Globals.SolarRequiemStatus = "Auto Solar Requiem - " .. message
end

local function IsActive(session)
    return Session == session and Globals.AutoSolarRequiemEnabled == true
end

local function GetState()
    local folder = ReplicatedStorage:FindFirstChild("StateReplicators")
    return folder and folder:FindFirstChild("GameStateReplicator")
end

local function GetNight(state)
    local difficulty = tostring(state:GetAttribute("Difficulty") or "")
    local night = difficulty:match("^Act([1-4])$")
    return tonumber(night)
end

local function IsCutsceneVote()
    local folder = ReplicatedStorage:FindFirstChild("StateReplicators")
    local rep = folder and folder:FindFirstChild("VoteReplicator")
    if rep and rep:GetAttribute("Enabled") == true
        and tostring(rep:GetAttribute("Title") or ""):lower():find("skip cutscene", 1, true) then
        return true
    end

    local voteGui = PlayerGui:FindFirstChild("ReactOverridesVote")
    local frame = voteGui and voteGui:FindFirstChild("Frame")
    local votes = frame and frame:FindFirstChild("votes")
    local vote = votes and votes:FindFirstChild("vote")
    local prompt = vote and vote:FindFirstChild("prompt")
    return voteGui ~= nil
        and voteGui.Enabled == true
        and frame ~= nil
        and frame.Visible == true
        and votes ~= nil
        and votes.Visible == true
        and vote ~= nil
        and vote.Visible == true
        and prompt ~= nil
        and prompt:IsA("TextLabel")
        and tostring(prompt.Text):lower():find("skip cutscene", 1, true) ~= nil
end

local function StartCutsceneSkip(session)
    task.spawn(function()
        local lastVote = 0
        while IsActive(session) and game.PlaceId ~= LOBBY_PLACE_ID do
            if IsCutsceneVote() and os.clock() - lastVote >= 2 then
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

local function StartPuzzle(state, session)
    task.spawn(function()
        while IsActive(session) and state.Parent
            and state:GetAttribute("GameStarted") ~= true
            and state:GetAttribute("GameOver") ~= true do
            task.wait(0.2)
        end
        if not IsActive(session) or not state.Parent
            or state:GetAttribute("GameOver") == true then
            return
        end
        local ok, err = pcall(function()
            local source = game:HttpGet(PUZZLE_URL)
            local chunk, compileError = loadstring(source)
            if not chunk then error(compileError) end
            chunk()
        end)
        if not ok then warn("[Solar Requiem] Moon Puzzle:", err) end
    end)
end

local function StartNight4TimeScale(tds, state, session)
    Globals.Night4HardTimeScaleOverride = nil
    task.spawn(function()
        if not IsActive(session) or not tds:WaitForWave(30) then return end
        if not IsActive(session) or not state.Parent
            or state:GetAttribute("GameOver") == true then return end

        local hotbar = PlayerGui:FindFirstChild("ReactUniversalHotbar")
        local frame = hotbar and hotbar:FindFirstChild("Frame")
        local timescale = frame and frame:FindFirstChild("timescale")
        local label = timescale and timescale:FindFirstChild("Speed")
        local speed = label and tonumber(tostring(label.Text or ""):match("x([%d%.]+)"))

        if speed ~= 2 then return end
        Globals.Night4HardTimeScaleOverride = 1
        if type(Globals.ApplyTimeScaleOnce) == "function" then
            pcall(Globals.ApplyTimeScaleOnce)
        end

        while IsActive(session) and state.Parent
            and state:GetAttribute("GameOver") ~= true do
            task.wait(0.25)
        end
        Globals.Night4HardTimeScaleOverride = nil
    end)
end

local function StartAutoGatling(state, session)
    task.spawn(function()
        while IsActive(session) and state.Parent
            and state:GetAttribute("GameStarted") ~= true
            and state:GetAttribute("GameOver") ~= true do
            task.wait(0.1)
        end
        if not IsActive(session) or not state.Parent
            or state:GetAttribute("GameOver") == true then return end
        if type(Globals.LoadAutoGatling) == "function" then
            pcall(Globals.LoadAutoGatling)
        end
    end)
end

local function RunNight(tds, state, night, session)
    if type(tds.ResetIndex) == "function" then
        local ok, err = pcall(function() tds:ResetIndex() end)
        if not ok then warn("[Solar Requiem] Tower reset:", err) end
    else
        tds.PlacedTowers = {}
        tds.placed_towers = tds.PlacedTowers
        tds.StackCounts = {}
    end

    Status("Running Night " .. night .. " Hard")
    Globals.SolarRequiemCurrentNight = night
    StartAutoGatling(state, session)

    if night == 4 then
        StartPuzzle(state, session)
        StartNight4TimeScale(tds, state, session)
    end

    task.spawn(function()
        local ok, err = pcall(function()
            local source = game:HttpGet(ROOT_URL .. "night" .. night .. ".lua")
            local chunk, compileError = loadstring(source)
            if not chunk then error(compileError) end
            local strategy = chunk()
            if type(strategy) ~= "function" then
                error("Night " .. night .. " did not return a strategy function")
            end
            if IsActive(session) and state.Parent
                and state:GetAttribute("GameOver") ~= true then
                strategy(tds)
            end
        end)
        if not ok then
            warn("[Solar Requiem] Night " .. night .. " strategy:", err)
            Status("Night " .. night .. " Strategy Error")
        end
    end)
end

local function NextNight()
    local network = ReplicatedStorage:WaitForChild("Network", 10)
    local halloween = network and network:WaitForChild("Halloween2026", 10)
    local remote = halloween and halloween:WaitForChild("RF:NextNight", 10)
    if not remote then return false end
    local ok, result = pcall(function() return remote:InvokeServer() end)
    return ok and result ~= false
end

local function BackToLobby(context)
    if context and type(context.BackToLobby) == "function" then
        local ok, result = pcall(context.BackToLobby)
        if ok and result ~= false then return true end
    end

    local network = ReplicatedStorage:FindFirstChild("Network")
    local teleport = network and network:FindFirstChild("Teleport")
    local remote = teleport and teleport:FindFirstChild("RE:backToLobby")
    if remote then
        pcall(function() remote:FireServer() end)
        task.wait(2)
    end
    if game.PlaceId ~= LOBBY_PLACE_ID then
        pcall(function()
            TeleportService:Teleport(LOBBY_PLACE_ID, LocalPlayer)
        end)
    end
    return true
end

local function Watch(tds, session, context)
    local started = {}
    local completed = {}

    StartCutsceneSkip(session)

    while IsActive(session) and game.PlaceId ~= LOBBY_PLACE_ID do
        local state = GetState()
        local night = state and GetNight(state)
        if state and night then
            local gameOver = state:GetAttribute("GameOver") == true

            if not gameOver and not started[night] then
                started[night] = true
                RunNight(tds, state, night, session)
            end

            if gameOver and started[night] and not completed[night] then
                completed[night] = true
                task.wait(3.5)
                if not IsActive(session) then break end

                local pending = tostring(
                    Globals.AutoFarmTransitionTarget
                    or Globals.PendingAutoFarmTarget or ""
                )
                if pending ~= "" then
                    if type(Globals.ApplyAutoFarmTransition) == "function" then
                        pcall(Globals.ApplyAutoFarmTransition)
                    end
                    Status("Returning to Lobby")
                    BackToLobby(context)
                    break
                end

                local health = tonumber(state:GetAttribute("Health")) or 0
                if health <= 0 then
                    Status("Night " .. night .. " Lost - Returning to Lobby")
                    BackToLobby(context)
                    break
                end

                if night == 4 then
                    Status("Completed Night 4 Hard")
                    break
                end

                Status("Night " .. night .. " Won - Advancing")
                if not NextNight() then
                    Status("NextNight Failed")
                    warn("[Solar Requiem] NextNight failed after Night " .. night)
                    break
                end
            end
        end
        task.wait(0.25)
    end

    if Session == session then
        Running = false
        Globals.SolarRequiemCurrentNight = nil
        Globals.Night4HardTimeScaleOverride = nil
    end
end

function Solar.Start(tds, context)
    if Globals.AutoSolarRequiemEnabled ~= true then return false end
    if type(tds) ~= "table" then
        tds = shared.TDSTable or shared["TDS_Table"]
    end
    if type(tds) ~= "table"
        or type(tds.Loadout) ~= "function"
        or type(tds.Place) ~= "function" then
        Status("TDS API Unavailable")
        return false
    end

    ActiveContext = type(context) == "table" and context or ActiveContext

    if game.PlaceId == LOBBY_PLACE_ID then
        Globals.SolarRequiemCurrentNight = nil
        if LobbyQueued then return true end
        if ActiveContext and type(ActiveContext.GetMissingTowers) == "function" then
            local ok, missing = pcall(ActiveContext.GetMissingTowers, RequiredTowers)
            if ok and type(missing) == "table" and #missing > 0 then
                Status("Missing Towers: " .. table.concat(missing, ", "))
                return false
            end
        end

        LobbyQueued = true
        local session = Session
        Status("Preparing Lobby Loadout")

        task.spawn(function()
            local ok, err = pcall(function()
                local equipped = tds:Loadout(
                    "DJ Booth", "Gatling Gun", "Mercenary Base", "Hacker", "Assassin"
                )
                if equipped ~= true then error("Lobby loadout failed") end
                if not IsActive(session) then return end

                Status("Starting Night 1 Hard")
                local result = Remote:InvokeServer(
                    "Multiplayer", "v2:start", {
                        difficulty = "Act1",
                        night = 1,
                        count = 1,
                        mode = "halloween2026"
                    }
                )
                if result == false then error("Night 1 start rejected") end
            end)

            if not ok then
                warn("[Solar Requiem] Lobby:", err)
                Status("Lobby Setup Failed")
                LobbyQueued = false
            end
        end)
        return true
    end

    if Running then return true end
    Session += 1
    Running = true
    LobbyQueued = false
    local session = Session
    task.spawn(Watch, tds, session, ActiveContext)
    return true
end

function Solar.Stop()
    Session += 1
    Running = false
    LobbyQueued = false
    ActiveContext = nil
    Globals.SolarRequiemCurrentNight = nil
    Globals.Night4HardTimeScaleOverride = nil
    return true
end

return Solar
