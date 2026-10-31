local Night = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("RemoteFunction")

Night.Requirements = {
    Easy = {"Trapper", "Hacker", "Gatling Gun", "Turret", "Mercenary Base"}
}

local function EquipNight4EasyLobbyLoadout()
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
    for _, tower in ipairs(Night.Requirements.Easy) do
        remoteEvent:FireServer("Inventory", "Equip", "Tower", tower)
        task.wait(0.3)
    end

    return true
end

function Night.PrepareLobby(mode)
    if mode == "Easy" then return EquipNight4EasyLobbyLoadout() end
    return false
end

function Night.Queue(mode)
    if mode ~= "Easy" then return false end
    local ok, result = pcall(function()
        return Remote:InvokeServer("Multiplayer", "v2:start", {
            difficulty = "Act4Easy",
            night = 4,
            count = 1,
            mode = "halloween2026"
        })
    end)
    return ok and result ~= false
end

function Night.Run(mode, TDS)
    if mode ~= "Easy" then return false end

    TDS:Loadout("Trapper", "Hacker", "Gatling Gun", "Turret", "Mercenary Base")
    local manager = ReplicatedStorage:WaitForChild("Network"):WaitForChild("PlayerManager")
    manager["RE:SelectLoadout"]:FireServer()
    task.wait(0.2)
    manager["RE:UserLoadout"]:FireServer()

    TDS:VoteSkip(6)
    TDS:Place("Trapper", 3.58335781097412109, 0.99998474121093750, -25.16512680053710938)
    TDS:UpgradeTimes(1, 2)
    TDS:SetOption(1, "Trap", "Landmine")
    TDS:Ready()

    TDS:Place("Trapper", 3.87603139877319336, 1.00524067878723145, -32.69576644897460938)
    TDS:UpgradeTimes(2, 2)
    TDS:SetOption(2, "Trap", "Landmine")

    TDS:Place("Gatling Gun", 0.15780796110630035, 1.04101276397705078, -8.31826019287109375)
    TDS:UpgradeTimes(3, 3)

    TDS:Place("Turret", -4.49165439605712891, 1.00000190734863281, -24.98381805419921875)
    TDS:UpgradeTimes(4, 2)

    TDS:Upgrade(3)

    TDS:Place("Turret", -8.55829334259033203, 1.00000190734863281, -24.86193275451660156)
    TDS:UpgradeTimes(5, 2)

    TDS:Place("Turret", -6.32897853851318359, 1.00000166893005371, -21.37284660339355469)
    TDS:UpgradeTimes(6, 2)

    TDS:Upgrade(4)
    TDS:Upgrade(5)
    TDS:Upgrade(6)

    TDS:UpgradeTimes(3, 2)

    TDS:Place("Mercenary Base", -3.45385122299194336, 1.04684305191040039, -5.69078779220581055)
    TDS:UpgradeTimes(7, 4)
    TDS:SetOption(7, "Unit 1", "Riot Guard")
    TDS:SetOption(7, "Unit 2", "Riot Guard")
    TDS:SetOption(7, "Unit 3", "Riot Guard")
    TDS:UpgradeTimes(7, 2)

    TDS:UpgradeTimes(4, 2)
    TDS:UpgradeTimes(5, 2)
    TDS:UpgradeTimes(6, 2)

    TDS:Place("Mercenary Base", -0.06729221343994141, 1.01885282993316650, 7.95063781738281250)
    TDS:UpgradeTimes(8, 4)
    TDS:SetOption(8, "Unit 1", "Riot Guard")
    TDS:SetOption(8, "Unit 2", "Riot Guard")
    TDS:SetOption(8, "Unit 3", "Riot Guard")
    TDS:UpgradeTimes(8, 2)

    TDS:Place("Mercenary Base", -4.65507268905639648, 0.99999952316284180, 6.65539550781250000)
    TDS:UpgradeTimes(9, 4)
    TDS:SetOption(9, "Unit 1", "Riot Guard")
    TDS:SetOption(9, "Unit 2", "Riot Guard")
    TDS:SetOption(9, "Unit 3", "Riot Guard")
    TDS:UpgradeTimes(9, 2)

    TDS:Place("Hacker", 6.55522060394287109, 0.99998205900192261, -24.29458618164062500)
    TDS:UpgradeTimes(10, 4)
    TDS:Upgrade(10, 2)

    TDS:Ability(10, "Hologram", {
        towerToClone = 3,
        towerPosition = Vector3.new(1.70491170883178711, 5.92126464843750000, -3.417245626449584964)
    })

    return true
end

return Night
