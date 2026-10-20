-- Halloween 2026: Night 1 strategy and matchmaking.
-- To add another night, create events/nights/night2.lua with the same interface.
local Night = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("RemoteFunction")

Night.Requirements = {
    Easy = {"Sniper"},
    Hard = {"Sniper"},
}

local function EquipNight1EasyLobbyLoadout()
    local stateReplicators = ReplicatedStorage:WaitForChild("StateReplicators", 10)
    if not stateReplicators then return false end

    local playerReplicator
    local deadline = os.clock() + 10
    repeat
        for _, rep in ipairs(stateReplicators:GetChildren()) do
            if rep.Name == "PlayerReplicator"
                and tonumber(rep:GetAttribute("UserId")) == Players.LocalPlayer.UserId then
                playerReplicator = rep
                break
            end
        end
        if not playerReplicator then task.wait(0.2) end
    until playerReplicator or os.clock() >= deadline
    if not playerReplicator then return false end

    local equipped = {}
    local raw = playerReplicator:GetAttribute("EquippedTowers")
    if type(raw) == "string" then
        local json = raw:match("%[.*%]")
        if json then
            pcall(function()
                equipped = game:GetService("HttpService"):JSONDecode(json)
            end)
        end
    end

    local remoteEvent = ReplicatedStorage:WaitForChild("RemoteEvent")
    for _, tower in ipairs(equipped) do
        if tower and tower ~= "" and tower ~= "None" then
            remoteEvent:FireServer("Inventory", "Unequip", "Tower", tower)
            task.wait(0.3)
        end
    end

    task.wait(0.2)
    for _, tower in ipairs({"Sniper"}) do
        remoteEvent:FireServer("Inventory", "Equip", "Tower", tower)
        task.wait(0.3)
    end

    return true
end

local function QueueNight1(mode)
    return pcall(function()
        return Remote:InvokeServer("Multiplayer", "v2:start", {
            difficulty = mode == "Easy" and "Act1Easy" or "Act1",
            night = 1,
            count = 1,
            mode = "halloween2026",
        })
    end)
end

local function RunNight1Easy(TDS)
    TDS:Loadout("Sniper", "None", "None", "None", "None")
    local playerManager = ReplicatedStorage:WaitForChild("Network"):WaitForChild("PlayerManager")
    playerManager["RE:SelectLoadout"]:FireServer()
    task.wait(0.2)
    playerManager["RE:UserLoadout"]:FireServer()
    TDS:Place("Sniper", 9.266754150390625, 6.802427291870117, 203.55477905273438)
    TDS:Place("Sniper", 10.11859130859375, 6.741560459136963, 205.9476776123047)
    TDS:Upgrade(2)
    TDS:Upgrade(1)
    TDS:Ready()
    TDS:Place("Sniper", 7.6457014083862305, 8.861952781677246, 209.50477600097656)
    TDS:Upgrade(3)
    local function PlaceSniper()
        TDS:Place("Sniper", -7.591506004333496, 8.861952781677246, 197.08810424804688, true)
    end
    for i = 4, 10 do
        PlaceSniper()
        TDS:Upgrade(i)
    end
    for i = 4, 10 do
        for j = 1, 2 do
            TDS:Upgrade(i)
        end
    end
    for i = 1, 3 do
        for j = 1, 2 do
            TDS:Upgrade(i)
        end
    end
    for i = 11, 20 do
        PlaceSniper()
        for j = 1, 3 do
            TDS:Upgrade(i)
        end
    end
    for i = 4, 20 do
        TDS:Upgrade(i)
    end
    for i = 1, 3 do
        TDS:Upgrade(i)
    end
end

local function RunNight1Hard(TDS)
    TDS:Loadout("Sniper", "None", "None", "None", "None")
    TDS:Place("Sniper", 9.266754150390625, 6.802427291870117, 203.55477905273438)
    TDS:Place("Sniper", 10.11859130859375, 6.741560459136963, 205.9476776123047)
    TDS:Upgrade(2)
    TDS:Upgrade(1)
    TDS:Ready()
    TDS:Place("Sniper", 7.6457014083862305, 8.861952781677246, 209.50477600097656)
    TDS:Upgrade(3)
    local function PlaceSniper()
        TDS:Place("Sniper", -7.591506004333496, 8.861952781677246, 197.08810424804688, true)
    end
    for i = 4, 14 do
        PlaceSniper()
        TDS:Upgrade(i)
    end
    for i = 4, 14 do
        for j = 1, 2 do
            TDS:Upgrade(i)
        end
    end
    for i = 1, 3 do
        for j = 1, 2 do
            TDS:Upgrade(i)
        end
    end
    for i = 15, 20 do
        PlaceSniper()
        for j = 1, 3 do
            TDS:Upgrade(i)
        end
    end
    for i = 4, 20 do
        TDS:Upgrade(i)
    end
    for i = 1, 3 do
        TDS:Upgrade(i)
    end
end

function Night.PrepareLobby(mode)
    if mode == "Easy" then
        return EquipNight1EasyLobbyLoadout()
    end
    return mode == "Hard"
end

function Night.Queue(mode)
    if mode ~= "Easy" and mode ~= "Hard" then return false end
    local ok, result = QueueNight1(mode)
    return ok and result ~= false
end

function Night.Run(mode, TDS)
    if mode == "Easy" then return RunNight1Easy(TDS) end
    if mode == "Hard" then return RunNight1Hard(TDS) end
    error("Unsupported Night 1 mode: " .. tostring(mode))
end

return Night
