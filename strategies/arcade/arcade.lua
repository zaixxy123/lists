-- Arcade controller. Called by the main Auto Progress UI; strategies remain separate files.
local Arcade = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Remote = ReplicatedStorage:WaitForChild("RemoteFunction")
local LOBBY_PLACE_ID = 3260590327
local ROOT = "https://raw.githubusercontent.com/zaixxy123/lists/refs/heads/main/strategies/arcade/"

local Modes = {
    ["Pizza Party"] = {
        MatchmakingMode = "halloween",
        Strategy = "pizza_party.lua",
        -- The special lobby loadout is intentionally different from the match strategy.
        LobbyLoadout = {"Scout", "Commander", "Shotgunner", "Minigunner"},
        Requirements = {"Scout", "Commander", "Shotgunner", "Minigunner", "Trapper", "Tesla", "Gatling Gun", "Turret", "Mercenary Base"},
    },
    ["Badlands"] = {
        MatchmakingMode = "badlands",
        Strategy = "badlands.lua",
        Requirements = {"Trapper", "Gatling Gun", "Mercenary Base", "Medic", "Hacker"},
    },
}

local Running = false
local MatchQueued = false
local Session = 0
local ActiveMode = nil

function Arcade.GetRequirements(mode)
    local config = Modes[mode]
    return config and config.Requirements or nil
end

function Arcade.GetLobbyLoadout(mode)
    local config = Modes[mode]
    return config and config.LobbyLoadout or nil
end

local function GameOver()
    local folder = ReplicatedStorage:FindFirstChild("StateReplicators")
    local state = folder and folder:FindFirstChild("GameStateReplicator")
    return state ~= nil and state:GetAttribute("GameOver") == true
end

local function ReturnToLobby()
    local network = ReplicatedStorage:FindFirstChild("Network")
    local teleportFolder = network and network:FindFirstChild("Teleport")
    local back = teleportFolder and teleportFolder:FindFirstChild("RE:backToLobby")
    if back then
        pcall(function() back:FireServer() end)
    end
    task.wait(5)
    if game.PlaceId ~= LOBBY_PLACE_ID then
        pcall(function()
            TeleportService:Teleport(LOBBY_PLACE_ID, Players.LocalPlayer)
        end)
    end
end

local function FindPlayerReplicator()
    local stateReplicators = ReplicatedStorage:WaitForChild("StateReplicators", 10)
    if not stateReplicators then return nil end

    local deadline = os.clock() + 10
    repeat
        for _, rep in ipairs(stateReplicators:GetChildren()) do
            if rep.Name == "PlayerReplicator"
                and tonumber(rep:GetAttribute("UserId")) == Players.LocalPlayer.UserId then
                return rep
            end
        end
        task.wait(0.2)
    until os.clock() >= deadline
    return nil
end

local function PrepareLobby(mode)
    if game.PlaceId ~= LOBBY_PLACE_ID then return false end
    local config = Modes[mode]
    if not config then return false end

    -- Badlands has no requested lobby loadout; queue it without touching equipped towers.
    if type(config.LobbyLoadout) ~= "table" or #config.LobbyLoadout == 0 then
        return true
    end

    local playerReplicator = FindPlayerReplicator()
    if not playerReplicator then
        warn("[AUTO ARCADE] PlayerReplicator not found; cannot equip lobby towers.")
        return false
    end

    local equipped = {}
    local raw = playerReplicator:GetAttribute("EquippedTowers")
    if type(raw) == "string" then
        local json = raw:match("%[.*%]")
        if json then
            pcall(function() equipped = HttpService:JSONDecode(json) end)
        end
    elseif type(raw) == "table" then
        equipped = raw
    end

    local remoteEvent = ReplicatedStorage:WaitForChild("RemoteEvent", 10)
    if not remoteEvent then return false end

    for _, tower in ipairs(equipped) do
        if type(tower) == "string" and tower ~= "" and tower ~= "None" then
            remoteEvent:FireServer("Inventory", "Unequip", "Tower", tower)
            task.wait(0.3)
        end
    end

    task.wait(0.2)
    for _, tower in ipairs(config.LobbyLoadout) do
        remoteEvent:FireServer("Inventory", "Equip", "Tower", tower)
        task.wait(0.3)
    end

    return true
end

local function Queue(mode)
    local config = Modes[mode]
    if not config then return false end

    local ok, result = pcall(function()
        return Remote:InvokeServer(
            "Multiplayer",
            "v2:start",
            {count = 1, mode = config.MatchmakingMode}
        )
    end)
    if not ok then
        warn("[AUTO ARCADE] Matchmaking failed:", result)
    end
    -- Some versions of this remote return nil on a successful invoke.
    return ok and result ~= false
end

local function RunStrategy(mode, TDS)
    local config = Modes[mode]
    if not config or type(TDS) ~= "table" then return false end

    local ok, source = pcall(function()
        return game:HttpGet(ROOT .. config.Strategy .. "?cache=" .. tostring(os.time()))
    end)
    if not ok or type(source) ~= "string" or source == "" then
        warn("[AUTO ARCADE] Strategy download failed:", source)
        return false
    end

    -- Wrap the existing bare TDS commands so TDS is local to this run.
    local chunk, compileError = loadstring("return function(TDS)\n" .. source .. "\nend")
    if not chunk then
        warn("[AUTO ARCADE] Strategy compile failed:", compileError)
        return false
    end

    local built, runner = pcall(chunk)
    if not built or type(runner) ~= "function" then
        warn("[AUTO ARCADE] Invalid strategy:", runner)
        return false
    end

    local worked, err = pcall(runner, TDS)
    if not worked then
        warn("[AUTO ARCADE] Strategy failed:", err)
    end
    return worked
end

local function WatchMatch(session)
    task.spawn(function()
        while Running and Session == session do
            if GameOver() then
                -- Leave enough time for the match-complete webhook.
                task.wait(3.5)
                if not Running or Session ~= session then return end

                local globals = getgenv()
                local pending = tostring(
                    globals.AutoFarmTransitionTarget
                    or globals.PendingAutoFarmTarget
                    or ""
                )
                if pending ~= "" and pending ~= "Arcade" then
                    if type(globals.ApplyAutoFarmTransition) == "function" then
                        globals.ApplyAutoFarmTransition()
                    end
                    Running = false
                    ReturnToLobby()
                    return
                end

                if globals.AutoArcadeEnabled == true
                    and tostring(globals.ArcadeMode or "Pizza Party") == ActiveMode then
                    if Queue(ActiveMode) then
                        MatchQueued = true
                        local originalJob = game.JobId
                        local deadline = os.clock() + 8
                        repeat
                            task.wait(0.5)
                            if not GameOver()
                                or game.JobId ~= originalJob
                                or game.PlaceId == LOBBY_PLACE_ID then
                                Running = false
                                return
                            end
                        until os.clock() >= deadline
                        MatchQueued = false
                    end
                end

                Running = false
                ReturnToLobby()
                return
            end
            task.wait(0.25)
        end
    end)
end

function Arcade.Start(mode, TDS)
    local config = Modes[mode]
    if not config or Running or MatchQueued then return false end

    if game.PlaceId == LOBBY_PLACE_ID then
        if not PrepareLobby(mode) then return false end
        local queued = Queue(mode)
        if queued then MatchQueued = true end
        return queued
    end

    TDS = TDS or shared.TDSTable or shared["TDS_Table"]
    if type(TDS) ~= "table" then return false end

    Running = true
    ActiveMode = mode
    Session += 1
    WatchMatch(Session)
    task.spawn(function() RunStrategy(mode, TDS) end)
    return true
end

function Arcade.Stop()
    Running = false
    MatchQueued = false
    ActiveMode = nil
    Session += 1
    return true
end

return Arcade
