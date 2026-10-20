local Night = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("RemoteFunction")

Night.Requirements = {
    Easy = {"Freezer", "Crook Boss", "DJ Booth", "Commander", "Trapper"},
    Hard = {"Freezer", "Crook Boss", "DJ Booth", "Commander", "Trapper"}
}

local function EquipNight2EasyLobbyLoadout()
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
    for _, tower in ipairs({"Freezer", "Crook Boss", "DJ Booth", "Commander", "Trapper"}) do
        remoteEvent:FireServer("Inventory", "Equip", "Tower", tower)
        task.wait(0.3)
    end

    return true
end

function Night.PrepareLobby(mode)
    if mode == "Easy" then return EquipNight2EasyLobbyLoadout() end
    return mode == "Hard"
end

function Night.Queue(mode)
    if mode ~= "Easy" and mode ~= "Hard" then return false end
    local ok, result = pcall(function()
        return Remote:InvokeServer("Multiplayer", "v2:start", {
            difficulty = mode == "Easy" and "Act2Easy" or "Act2",
            night = 2,
            count = 1,
            mode = "halloween2026"
        })
    end)
    return ok and result ~= false
end

local function RunNight2Easy(TDS)
    TDS:Loadout("Freezer", "Crook Boss", "DJ Booth", "Commander", "Trapper")
    local manager = ReplicatedStorage:WaitForChild("Network"):WaitForChild("PlayerManager")
    manager["RE:SelectLoadout"]:FireServer()
    task.wait(0.2)
    manager["RE:UserLoadout"]:FireServer()
    TDS:VoteSkip(1,17)
    TDS:Place("Trapper", 10.050795555114746, 47.70799255371094, 1.0367521047592163)
    TDS:Place("Trapper", 9.647570610046387, 47.68596649169922, -2.012082576751709)
    TDS:Upgrade(2)
    TDS:Ready()

    TDS:Upgrade(1)

    TDS:Upgrade(2)

    TDS:Upgrade(1)
    TDS:Place("DJ Booth", 7.05073356628418, 47.83967590332031, -5.06990909576416)

    TDS:SetOption(3, "Track", "Green")

    TDS:Place("Crook Boss", 2.878124713897705, 47.65865707397461, -10.927541732788086)
    TDS:Upgrade(4)

    TDS:Place("Commander", 3.1028892993927, 47.862220764160156, -5.8558454513549805)
    TDS:Place("Freezer", 0.2942955493927002, 47.73551940917969, -4.692487716674805)

    TDS:Place("Crook Boss", 5.918124675750732, 47.69390869140625, -10.927541732788086)
    TDS:Upgrade(7)
    TDS:Upgrade(5)
    TDS:Upgrade(6)
    TDS:Upgrade(6)
    TDS:Upgrade(6)

    TDS:Place("Trapper", 8.817151069641113, 47.69758224487305, 3.8590240478515625)
    TDS:Upgrade(8)
    TDS:Upgrade(8)
    TDS:SetOption(8, "Trap", "Landmine")

    TDS:Place("Trapper", 6.399267196655273, 47.73211669921875, 5.6743669509887695)
    TDS:Upgrade(9)
    TDS:Upgrade(9)
    TDS:SetOption(9, "Trap", "Landmine")
    TDS:Place("Trapper", 3.241562843322754, 47.665672302246094, 6.187073230743408)
    TDS:Upgrade(10)
    TDS:Upgrade(10)
    TDS:SetOption(10, "Trap", "Landmine")

    TDS:Upgrade(4)
    TDS:Upgrade(7)

    TDS:Place("Crook Boss", 0.06953096389770508, 47.62562561035156, -12.090899467468262)
    TDS:Upgrade(11)
    TDS:Upgrade(11)

    TDS:Place("Crook Boss", 8.765157699584961, 47.692771911621094, -9.942680358886719)
    TDS:Upgrade(12)
    TDS:Upgrade(12)

    TDS:Place("Crook Boss", 2.56889271736145, 47.85989761352539, -13.951774597167969)
    TDS:Upgrade(13)
    TDS:Upgrade(13)
    TDS:Upgrade(5)
    TDS:Upgrade(3)
    TDS:Upgrade(3)
    TDS:Upgrade(3)
    TDS:SetOption(3, "Track", "Purple")

    TDS:Place("Trapper", 0.43323469161987305, 47.626766204833984, 5.0234456062316895)
    TDS:Upgrade(14)
    TDS:Upgrade(14)
    TDS:SetOption(14, "Trap", "Landmine")
    TDS:Place("Trapper", -1.5239448547363281, 47.68352508544922, 2.575798511505127)
    TDS:Upgrade(15)
    TDS:Upgrade(15)
    TDS:SetOption(15, "Trap", "Landmine")
    TDS:SetOption(3, "Track", "Green")
    TDS:Upgrade(2)

    TDS:Upgrade(2)
    TDS:Place("Commander", -3.536414623260498, 47.610565185546875, -7.936890602111816)
    TDS:Upgrade(16)
    TDS:Upgrade(16)
    TDS:Place("Commander", 11.438133239746094, 47.64118957519531, -8.053886413574219)
    TDS:Upgrade(17)
    TDS:Upgrade(17)

    TDS:Upgrade(6)
    TDS:Upgrade(4)

    TDS:Upgrade(7)
    TDS:Upgrade(12)

    TDS:SetOption(3, "Track", "Purple")
    TDS:Upgrade(3)
    TDS:Upgrade(3)
    TDS:SetOption(3, "Track", "Red")
    TDS:SetOption(2, "Trap", "Bear Traps")
    TDS:Upgrade(1)
    TDS:Upgrade(1)
    TDS:SetOption(1, "Trap", "Bear Traps")
    TDS:Upgrade(8)
    TDS:Upgrade(8)
    TDS:SetOption(8, "Trap", "Bear Traps")
    TDS:Upgrade(9)
    TDS:Upgrade(9)
    TDS:SetOption(9, "Trap", "Bear Traps")
    TDS:Upgrade(10)
    TDS:Upgrade(10)
    TDS:SetOption(10, "Trap", "Bear Traps")
    TDS:Upgrade(14)
    TDS:Upgrade(14)
    TDS:SetOption(14, "Trap", "Bear Traps")
    TDS:Upgrade(15)
    TDS:Upgrade(15)
    TDS:SetOption(15, "Trap", "Bear Traps")
    TDS:Upgrade(11)
    TDS:Upgrade(13)
    TDS:Upgrade(11)
    TDS:Upgrade(4)
    TDS:Upgrade(7)
    TDS:Upgrade(13)
    TDS:Upgrade(12)
    TDS:Upgrade(17)
    TDS:Upgrade(17)
    TDS:Upgrade(16)
    TDS:Upgrade(16)
    TDS:Upgrade(5)
    TDS:Upgrade(5)

    return true
end

function Night.Run(mode, TDS)
    if mode == "Easy" then return RunNight2Easy(TDS) end
    if mode ~= "Hard" then return false end
    TDS:Loadout("Freezer", "Crook Boss", "DJ Booth", "Commander", "Trapper")
    TDS:VoteSkip(21)
    TDS:Place("Trapper", 10.050795555114746, 47.70799255371094, 1.0367521047592163)
    TDS:Place("Trapper", 9.647570610046387, 47.68596649169922, -2.012082576751709)
    TDS:Upgrade(2)
    TDS:Ready()

    TDS:Upgrade(1)

    TDS:Upgrade(2)

    TDS:Upgrade(1)
    TDS:Place("DJ Booth", 7.05073356628418, 47.83967590332031, -5.06990909576416)

    TDS:SetOption(3, "Track", "Green")

    TDS:Place("Crook Boss", 2.878124713897705, 47.65865707397461, -10.927541732788086)
    TDS:Upgrade(4)

    TDS:Place("Commander", 3.1028892993927, 47.862220764160156, -5.8558454513549805)
    TDS:Place("Freezer", 0.2942955493927002, 47.73551940917969, -4.692487716674805)

    TDS:Place("Crook Boss", 5.918124675750732, 47.69390869140625, -10.927541732788086)
    TDS:Upgrade(7)
    TDS:Upgrade(5)
    TDS:Upgrade(6)
    TDS:Upgrade(6)
    TDS:Upgrade(6)

    TDS:Place("Trapper", 8.817151069641113, 47.69758224487305, 3.8590240478515625)
    TDS:Upgrade(8)
    TDS:Upgrade(8)
    TDS:SetOption(8, "Trap", "Landmine")

    TDS:Place("Trapper", 6.399267196655273, 47.73211669921875, 5.6743669509887695)
    TDS:Upgrade(9)
    TDS:Upgrade(9)
    TDS:SetOption(9, "Trap", "Landmine")
    TDS:Place("Trapper", 3.241562843322754, 47.665672302246094, 6.187073230743408)
    TDS:Upgrade(10)
    TDS:Upgrade(10)
    TDS:SetOption(10, "Trap", "Landmine")

    TDS:Upgrade(4)
    TDS:Upgrade(7)

    TDS:Place("Crook Boss", 0.06953096389770508, 47.62562561035156, -12.090899467468262)
    TDS:Upgrade(11)
    TDS:Upgrade(11)

    TDS:Place("Crook Boss", 8.765157699584961, 47.692771911621094, -9.942680358886719)
    TDS:Upgrade(12)
    TDS:Upgrade(12)

    TDS:Place("Crook Boss", 2.56889271736145, 47.85989761352539, -13.951774597167969)
    TDS:Upgrade(13)
    TDS:Upgrade(13)
    TDS:Upgrade(5)
    TDS:Upgrade(3)
    TDS:Upgrade(3)
    TDS:Upgrade(3)
    TDS:SetOption(3, "Track", "Purple")

    TDS:Place("Trapper", 0.43323469161987305, 47.626766204833984, 5.0234456062316895)
    TDS:Upgrade(14)
    TDS:Upgrade(14)
    TDS:SetOption(14, "Trap", "Landmine")
    TDS:Place("Trapper", -1.5239448547363281, 47.68352508544922, 2.575798511505127)
    TDS:Upgrade(15)
    TDS:Upgrade(15)
    TDS:SetOption(15, "Trap", "Landmine")
    TDS:SetOption(3, "Track", "Green")
    TDS:Upgrade(2)

    TDS:Upgrade(2)
    TDS:Place("Commander", -3.536414623260498, 47.610565185546875, -7.936890602111816)
    TDS:Upgrade(16)
    TDS:Upgrade(16)
    TDS:Place("Commander", 11.438133239746094, 47.64118957519531, -8.053886413574219)
    TDS:Upgrade(17)
    TDS:Upgrade(17)

    TDS:Upgrade(6)
    TDS:Upgrade(4)

    TDS:Upgrade(7)
    TDS:Upgrade(12)

    TDS:SetOption(3, "Track", "Purple")
    TDS:Upgrade(3)
    TDS:Upgrade(3)
    TDS:SetOption(3, "Track", "Red")
    TDS:SetOption(2, "Trap", "Bear Traps")
    TDS:Upgrade(1)
    TDS:Upgrade(1)
    TDS:SetOption(1, "Trap", "Bear Traps")
    TDS:Upgrade(8)
    TDS:Upgrade(8)
    TDS:SetOption(8, "Trap", "Bear Traps")
    TDS:Upgrade(9)
    TDS:Upgrade(9)
    TDS:SetOption(9, "Trap", "Bear Traps")
    TDS:Upgrade(10)
    TDS:Upgrade(10)
    TDS:SetOption(10, "Trap", "Bear Traps")
    TDS:Upgrade(14)
    TDS:Upgrade(14)
    TDS:SetOption(14, "Trap", "Bear Traps")
    TDS:Upgrade(15)
    TDS:Upgrade(15)
    TDS:SetOption(15, "Trap", "Bear Traps")
    TDS:Upgrade(11)
    TDS:Upgrade(13)
    TDS:Upgrade(11)
    TDS:Upgrade(4)
    TDS:Upgrade(7)
    TDS:Upgrade(13)
    TDS:Upgrade(12)
    TDS:Upgrade(17)
    TDS:Upgrade(17)
    TDS:Upgrade(16)
    TDS:Upgrade(16)
    TDS:Upgrade(5)
    TDS:Upgrade(5)

    return true
end

return Night
