local Night = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("RemoteFunction")

Night.Requirements = {
    Easy = {"Electroshocker", "Crook Boss", "DJ Booth", "Commander", "Turret"},
    Hard = {"Trapper", "Pyromancer", "Gatling Gun", "Mercenary Base", "Turret"}
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
    if mode == "Hard" then return true end
    if mode == "Easy" then return EquipNight3LobbyLoadout(mode) end
    return false
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

    TDS:Place("Crook Boss", 0.27981853485107422, 102.91901397705078125, 102.70320892333984375, true)
    TDS:UpgradeTimes(3, 2)

    TDS:Place("Commander", 0.62547540664672852, 102.99093627929687500, 108.43725585937500000)
    TDS:Upgrade(4)

    TDS:Place("DJ Booth", 1.45543432235717773, 103.16221618652343750, 114.72503662109375000)

    TDS:Place("Turret", 0.27981853485107422, 102.91901397705078125, 102.70320892333984375, true)
    TDS:Upgrade(6)

    TDS:Upgrade(5)
    TDS:Upgrade(5)
    TDS:Upgrade(5)
    TDS:SetOption(5, "Track", "Green")
    TDS:Upgrade(6)

    TDS:Place("Crook Boss", 0.27981853485107422, 102.91901397705078125, 102.70320892333984375, true)
    TDS:UpgradeTimes(7, 2)

    TDS:Place("Turret", 0.27981853485107422, 102.91901397705078125, 102.70320892333984375, true)
    TDS:UpgradeTimes(8, 2)

    TDS:Place("Turret", 0.27981853485107422, 102.91901397705078125, 102.70320892333984375, true)
    TDS:UpgradeTimes(9, 2)

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
    TDS:UpgradeTimes(5, 2)
    TDS:Upgrade(4)
    TDS:Upgrade(10)
    TDS:SetOption(5, "Track", "Red")
    TDS:Upgrade(11)

    TDS:Place("Crook Boss", 0.27981853485107422, 102.91901397705078125, 102.70320892333984375, true)
    TDS:Place("Crook Boss", 0.27981853485107422, 102.91901397705078125, 102.70320892333984375, true)
    TDS:Place("Crook Boss", 0.27981853485107422, 102.91901397705078125, 102.70320892333984375, true)

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
    TDS:Loadout("Trapper", "Pyromancer", "Gatling Gun", "Mercenary Base", "Turret")

    TDS:VoteSkip(22)
    TDS:Place("Trapper", -2.40394973754882812, 103.01572418212890625, 109.27811431884765625)
    TDS:Place("Pyromancer", 1.19423961639404297, 104.12820434570312500, 126.08316040039062500)
    TDS:Ready()

    TDS:Upgrade(2)
    TDS:Upgrade(1)
    TDS:Upgrade(1)
    TDS:SetOption(1, "Trap", "Landmine")

    TDS:WaitForWave(6)
    TDS:Sell(1)
    TDS:Sell(2)

    TDS:Place("Gatling Gun", 2.37738370895385742, 101.01309204101562500, 77.17347717285156250)
    TDS:UpgradeTimes(3, 2)

    TDS:Place("Trapper", 1.26585769653320312, 104.27545166015625000, 127.63191223144531250)
    TDS:UpgradeTimes(4, 2)
    TDS:SetOption(4, "Trap", "Landmine")

    TDS:Place("Trapper", 1.40450382232666016, 103.94007873535156250, 124.23064422607421875)
    TDS:UpgradeTimes(5, 2)
    TDS:SetOption(5, "Trap", "Landmine")

    TDS:Place("Trapper", 2.07725620269775391, 103.55162048339843750, 120.50111389160156250)
    TDS:UpgradeTimes(6, 2)
    TDS:SetOption(6, "Trap", "Landmine")

    TDS:Place("Trapper", 3.93767929077148438, 103.32637786865234375, 117.61939239501953125)
    TDS:UpgradeTimes(7, 2)
    TDS:SetOption(7, "Trap", "Landmine")

    TDS:Place("Trapper", 5.18074178695678711, 103.19294738769531250, 114.53848266601562500)
    TDS:UpgradeTimes(8, 2)
    TDS:SetOption(8, "Trap", "Landmine")

    TDS:Place("Trapper", -1.84202671051025391, 104.36697387695312500, 127.93176269531250000)
    TDS:UpgradeTimes(9, 2)
    TDS:SetOption(9, "Trap", "Landmine")

    TDS:Place("Trapper", -1.62232685089111328, 104.02701568603515625, 124.17565155029296875)
    TDS:UpgradeTimes(10, 2)
    TDS:SetOption(10, "Trap", "Landmine")

    TDS:Upgrade(3)
    TDS:Upgrade(4)
    TDS:Upgrade(5)

    TDS:Upgrade(3)
    TDS:Upgrade(6)
    TDS:Upgrade(7)
    TDS:Upgrade(8)
    TDS:Upgrade(9)
    TDS:Upgrade(10)

    TDS:UpgradeTimes(3, 2)
    TDS:Upgrade(4)
    TDS:Upgrade(5)
    TDS:Upgrade(6)
    TDS:Upgrade(7)
    TDS:Upgrade(8)
    TDS:Upgrade(9)
    TDS:Upgrade(10)

    TDS:Place("Mercenary Base", -1.47949504852294922, 101.05632781982421875, 74.16135406494140625)
    TDS:UpgradeTimes(11, 4)
    TDS:SetOption(11, "Unit 1", "Riot Guard")
    TDS:SetOption(11, "Unit 2", "Riot Guard")
    TDS:SetOption(11, "Unit 3", "Riot Guard")

    TDS:Place("Mercenary Base", -1.99385452270507812, 103.67328643798828125, 120.39415740966796875)
    TDS:UpgradeTimes(12, 4)
    TDS:SetOption(12, "Unit 1", "Riot Guard")
    TDS:SetOption(12, "Unit 2", "Riot Guard")
    TDS:SetOption(12, "Unit 3", "Riot Guard")

    TDS:UpgradeTimes(11, 2)
    TDS:UpgradeTimes(12, 2)

    TDS:Place("Turret", -6.24925994873046875, 104.16424560546875000, 124.37631988525390625)
    TDS:UpgradeTimes(13, 5)

    TDS:Place("Turret", -6.35426855087280273, 103.72157287597656250, 120.05467224121093750)
    TDS:UpgradeTimes(14, 5)

    TDS:Place("Turret", -0.23385143280029297, 103.21198272705078125, 116.25121307373046875)
    TDS:UpgradeTimes(15, 5)

    return true
end

function Night.Run(mode, TDS)
    if mode == "Easy" then return RunNight3Easy(TDS) end
    if mode == "Hard" then return RunNight3Hard(TDS) end
    return false
end

return Night
