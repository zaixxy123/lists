local Night = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("RemoteFunction")

Night.Requirements = {
    Easy = {"Electroshocker", "Crook Boss", "DJ Booth", "Commander", "Turret"},
    Hard = {"Trapper", "Gatling Gun", "Turret", "Mercenary Base"}
}

local function EquipNight3LobbyLoadout(mode)
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
    for _, tower in ipairs(Night.Requirements[mode]) do
        remoteEvent:FireServer("Inventory", "Equip", "Tower", tower)
        task.wait(0.3)
    end

    return true
end

function Night.PrepareLobby(mode)
    if not Night.Requirements[mode] then return false end
    return EquipNight3LobbyLoadout(mode)
end

function Night.Queue(mode)
    if mode ~= "Easy" and mode ~= "Hard" then return false end
    local ok, result = pcall(function()
        return Remote:InvokeServer("Multiplayer", "v2:start", {
            difficulty = mode == "Easy" and "Act3Easy" or "Act3",
            night = 3,
            count = 1,
            mode = "halloween2026"
        })
    end)
    return ok and result ~= false
end

local function RunNight3Easy(TDS)
    TDS:Loadout("Electroshocker", "Crook Boss", "DJ Booth", "Commander", "Turret")
    local manager = ReplicatedStorage:WaitForChild("Network"):WaitForChild("PlayerManager")
    manager["RE:SelectLoadout"]:FireServer()
    task.wait(0.2)
    manager["RE:UserLoadout"]:FireServer()

    TDS:VoteSkip(1,4)
    TDS:VoteSkip(7)

    TDS:Place("Electroshocker", 2.09563922882080078, 103.75581359863281250, 122.58135986328125000)
    TDS:Upgrade(1)
    TDS:Ready()
    TDS:Upgrade(1)

    TDS:Place("Electroshocker", -1.01019191741943359, 103.80556488037109375, 122.06566619873046875)
    TDS:UpgradeTimes(2, 3)

    TDS:Place("Crook Boss", 3.68038606643676758, 102.96115112304687500, 107.84565734863281250)
    TDS:UpgradeTimes(3, 2)

    TDS:Place("Commander", 0.62547540664672852, 102.99093627929687500, 108.43725585937500000)
    TDS:Upgrade(4)

    TDS:Place("DJ Booth", 1.45543432235717773, 103.16221618652343750, 114.72503662109375000)

    TDS:Place("Turret", -2.73847389221191406, 103.32418823242187500, 116.54706573486328125)
    TDS:Upgrade(6)

    TDS:UpgradeTimes(5, 3)
    TDS:SetOption(5, "Track", "Green")

    TDS:Upgrade(6)

    TDS:Place("Crook Boss", 2.69680929183959961, 102.90212249755859375, 104.91789245605468750)
    TDS:UpgradeTimes(7, 2)

    TDS:Place("Turret", -6.50570631027221680, 103.21847534179687500, 115.11198425292968750)
    TDS:UpgradeTimes(8, 2)

    TDS:Place("Turret", -9.85848999023437500, 103.31646728515625000, 112.79949951171875000)
    TDS:UpgradeTimes(9, 2)

    TDS:UpgradeTimes(5, 2)

    TDS:Upgrade(4)

    TDS:Place("Commander", -2.44934034347534180, 102.99324035644531250, 108.44250488281250000)
    TDS:UpgradeTimes(10, 2)

    TDS:Place("Commander", -4.62926530838012695, 102.97267913818359375, 106.16424560546875000)
    TDS:UpgradeTimes(11, 2)

    TDS:Upgrade(6)
    TDS:Upgrade(8)
    TDS:Upgrade(9)

    TDS:Upgrade(6)
    TDS:Upgrade(8)
    TDS:Upgrade(9)

    TDS:Upgrade(6)
    TDS:Upgrade(8)
    TDS:Upgrade(9)

    TDS:Upgrade(4)
    TDS:Upgrade(10)
    TDS:SetOption(5, "Track", "Red")
    TDS:Upgrade(11)

    TDS:Place("Crook Boss", -0.51934969425201416, 103.07928466796875000, 105.28556823730468750)
    TDS:Place("Crook Boss", 0.88974905014038086, 102.90845489501953125, 102.44064331054687500)
    TDS:Place("Crook Boss", -2.71102905273437500, 103.00782012939453125, 103.10567474365234375)

    TDS:UpgradeTimes(12, 2)
    TDS:UpgradeTimes(13, 2)
    TDS:UpgradeTimes(14, 2)

    TDS:Upgrade(3)
    TDS:Upgrade(7)
    TDS:Upgrade(12)
    TDS:Upgrade(13)
    TDS:Upgrade(14)

    TDS:Upgrade(3)
    TDS:Upgrade(7)
    TDS:Upgrade(12)
    TDS:Upgrade(13)
    TDS:Upgrade(14)

    return true
end

local function RunNight3Hard(TDS)
    TDS:Loadout("Trapper", "Gatling Gun", "Turret", "Mercenary Base")
    local manager = ReplicatedStorage:WaitForChild("Network"):WaitForChild("PlayerManager")
    manager["RE:SelectLoadout"]:FireServer()
    task.wait(0.2)
    manager["RE:UserLoadout"]:FireServer()

    TDS:Place("Trapper", -1.69024848937988281, 103.02556610107421875, 109.64415740966796875)
    TDS:Place("Trapper", -4.03205108642578125, 102.99209594726562500, 107.58445739746093750)
    TDS:Upgrade(1)
    TDS:Ready()

    TDS:Upgrade(2)
    TDS:Upgrade(1)
    TDS:SetOption(1, "Trap", "Landmine")

    TDS:VoteSkip(5)
    TDS:WaitForWave(6)

    TDS:Sell(1)
    TDS:Sell(2)

    TDS:Place("Gatling Gun", 4.19032096862792969, 101.01975250244140625, 78.41510009765625000)
    TDS:UpgradeTimes(3, 2)

    TDS:Place("Turret", -5.52445650100708008, 103.01557159423828125, 107.20062255859375000)
    TDS:UpgradeTimes(4, 2)

    TDS:Place("Turret", 6.10501670837402344, 102.89367675781250000, 106.11018371582031250)
    TDS:UpgradeTimes(5, 2)

    TDS:Place("Turret", -7.21452140808105469, 103.22519683837890625, 114.48966979980468750)
    TDS:UpgradeTimes(6, 2)

    TDS:Upgrade(3)

    TDS:Place("Mercenary Base", -0.18347468972206116, 100.99746704101562500, 78.94009399414062500)
    TDS:UpgradeTimes(7, 3)

    TDS:Upgrade(4)
    TDS:Upgrade(5)
    TDS:Upgrade(6)

    TDS:Upgrade(3)

    TDS:Upgrade(7)
    TDS:SetOption(7, "Unit 1", "Riot Guard")
    TDS:SetOption(7, "Unit 2", "Riot Guard")
    TDS:SetOption(7, "Unit 3", "Riot Guard")

    TDS:Place("Mercenary Base", -0.60532903671264648, 102.99864196777343750, 108.64323425292968750)
    TDS:UpgradeTimes(8, 4)
    TDS:SetOption(8, "Unit 1", "Riot Guard")
    TDS:SetOption(8, "Unit 2", "Riot Guard")
    TDS:SetOption(8, "Unit 3", "Riot Guard")

    TDS:Upgrade(4)
    TDS:UpgradeTimes(3, 2)
    TDS:UpgradeTimes(7, 2)

    TDS:Upgrade(5)

    TDS:Upgrade(4)
    TDS:Upgrade(5)
    TDS:Upgrade(6)

    TDS:UpgradeTimes(8, 2)

    return true
end

function Night.Run(mode, TDS)
    if mode == "Easy" then return RunNight3Easy(TDS) end
    if mode == "Hard" then return RunNight3Hard(TDS) end
    return false
end

return Night
