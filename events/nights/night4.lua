local Night = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("RemoteFunction")

Night.Requirements = {
    Easy = {"Trapper", "Hacker", "Gatling Gun", "Turret", "Mercenary Base"},
    Hard = {"DJ Booth", "Hacker", "Gatling Gun", "Golden Scout", "Ranger", "Mercenary Base"}
}

local function EquipNight4LobbyLoadout(mode)
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
    for _, tower in ipairs(mode == "Hard" and {"DJ Booth", "Hacker", "Gatling Gun", "Scout", "Ranger"} or Night.Requirements.Easy) do
        remoteEvent:FireServer("Inventory", "Equip", "Tower", tower)
        task.wait(0.3)
    end

    return true
end

local function HasGoldenScoutSkin()
    local client = ReplicatedStorage:FindFirstChild("Client")
    local modules = client and client:FindFirstChild("Modules")
    local cacheModule = modules and modules:FindFirstChild("Cache")
    if not cacheModule then return false end

    local ok, skins = pcall(function()
        local Cache = require(cacheModule)
        return Cache("Inventory.Skins"):GetValue() or {}
    end)
    if not ok or type(skins) ~= "table" then return false end

    local scoutSkins = skins.Scout
    if type(scoutSkins) ~= "table" then return false end

    for _, skin in ipairs(scoutSkins) do
        if type(skin) == "table" and skin.Name == "Golden" then
            return true
        end
    end

    return false
end

function Night.PrepareLobby(mode)
    if mode == "Hard" then
        if not HasGoldenScoutSkin() then
            warn("[Night 4 Hard] Required skin not owned: Golden Scout")
            return false
        end
        return true
    end
    if mode == "Easy" then return EquipNight4LobbyLoadout(mode) end
    return false
end

function Night.Queue(mode)
    if mode ~= "Easy" and mode ~= "Hard" then return false end
    local ok, result = pcall(function()
        return Remote:InvokeServer("Multiplayer", "v2:start", {
            difficulty = mode == "Easy" and "Act4Easy" or "Act4",
            night = 4,
            count = 1,
            mode = "halloween2026"
        })
    end)
    return ok and result ~= false
end

local function RunNight4Easy(TDS)

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
    TDS:Ability(10, "Hologram Tower", {towerPosition = Vector3.new(1.70491170883178711, 5.92126464843750000, -3.417245626449584964), towerToClone = 3}, true)

    return true
end

local function RunNight4Hard(TDS)
    TDS:Loadout("DJ Booth", "Hacker", "Gatling Gun", "Scout", "Ranger")

    TDS:Place("Scout", 3.4058122634887695, 0.9999849200248718, -25.256784439086914)
    TDS:Upgrade(1)
    TDS:Upgrade(1)
    TDS:Place("Scout", 6.430719375610352, 0.999983012676239, -24.958011627197266)
    TDS:Upgrade(2)
    TDS:Upgrade(2)
    TDS:Place("Scout", 3.4058122634887695, 0.9999809861183167, -22.216785430908203)
    TDS:Upgrade(3)
    TDS:Upgrade(3)

    task.wait(3)
    TDS:Loadout("DJ Booth", "Hacker", "Gatling Gun", "Mercenary Base", "Ranger")

    TDS:Ready()
    TDS:Upgrade(3)
    TDS:Upgrade(1)
    TDS:Upgrade(2)

    TDS:Place("Gatling Gun", -0.714411199092865, 1.060223937034607, -9.163329124450684)
    TDS:Upgrade(4)
    TDS:Upgrade(4)
    TDS:Upgrade(4)
    TDS:Upgrade(1)
    TDS:Upgrade(3)
    TDS:Upgrade(2)

    TDS:Place("DJ Booth", -3.650881290435791, 1.0386496782302856, -13.166467666625977)
    TDS:Upgrade(5)
    TDS:Upgrade(5)
    TDS:Upgrade(5)
    TDS:SetOption(5, "Track", "Green")

    TDS:Upgrade(4)
    TDS:Place("Mercenary Base", -3.6786561012268066, 0.9999942779541016, 22.554428100585938)

    TDS:Upgrade(6)
    TDS:Upgrade(6)
    TDS:Upgrade(6)
    TDS:Upgrade(6)
    TDS:SetOption(6, "Unit 1", "Riot Guard")
    TDS:SetOption(6, "Unit 3", "Riot Guard")
    TDS:SetOption(6, "Unit 2", "Riot Guard")

    TDS:Upgrade(4)

    TDS:Place("Mercenary Base", 3.4325942993164062, 0.9999982714653015, 22.87681770324707)

    TDS:Upgrade(7)
    TDS:Upgrade(7)
    TDS:Upgrade(7)
    TDS:Upgrade(7)
    TDS:SetOption(7, "Unit 1", "Riot Guard")
    TDS:SetOption(7, "Unit 2", "Riot Guard")
    TDS:SetOption(7, "Unit 3", "Riot Guard")
    TDS:Place("Mercenary Base", -8.193872451782227, 1.0609875917434692, -8.874517440795898)
    TDS:Upgrade(8)
    TDS:Upgrade(8)
    TDS:Upgrade(8)
    TDS:Upgrade(8)
    TDS:SetOption(8, "Unit 1", "Riot Guard")
    TDS:SetOption(8, "Unit 2", "Riot Guard")
    TDS:SetOption(8, "Unit 3", "Riot Guard")
    TDS:Upgrade(6)
    TDS:Upgrade(7)

    TDS:Upgrade(8)
    TDS:Upgrade(4)

    TDS:Upgrade(6)
    TDS:Upgrade(7)
    TDS:Upgrade(8)
    TDS:Upgrade(5)
    TDS:Upgrade(5)

    TDS:SetOption(5, "Track", "Red")

    TDS:Place("Ranger", -1.6879738569259644, 5.9212646484375, -1.9258742332458496)
    TDS:Upgrade(9)
    TDS:Upgrade(9)
    TDS:Upgrade(9)
    TDS:Upgrade(9)
    TDS:Place("Ranger", -0.06645750999450684, 5.9212646484375, -4.484714508056641)
    TDS:Upgrade(10)
    TDS:Upgrade(10)
    TDS:Upgrade(10)
    TDS:Upgrade(10)

    TDS:Place("Ranger", 1.860655665397644, 5.897640228271484, -2.0559463500976562)
    TDS:Upgrade(11)
    TDS:Upgrade(11)
    TDS:Upgrade(11)
    TDS:Upgrade(11)
    TDS:Place("Ranger", 3.759669780731201, 5.9212646484375, -4.506083011627197)
    TDS:Upgrade(12)
    TDS:Upgrade(12)
    TDS:Upgrade(12)
    TDS:Upgrade(12)

    TDS:Place("Ranger", -2.216064453125, 7.976963996887207, -6.634318828582764)
    TDS:Upgrade(13)
    TDS:Upgrade(13)
    TDS:Upgrade(13)
    TDS:Upgrade(13)
    TDS:Place("Ranger", 0.3058032989501953, 7.976963996887207, -8.331900596618652)
    TDS:Upgrade(14)
    TDS:Upgrade(14)
    TDS:Upgrade(14)
    TDS:Upgrade(14)

    TDS:Place("Ranger", 2.6439948081970215, 7.976964473724365, -6.389101982116699)
    TDS:Upgrade(15)
    TDS:Upgrade(15)
    TDS:Upgrade(15)
    TDS:Upgrade(15)
    TDS:Place("Ranger", -19.006290435791016, 5.921395301818848, -12.544219970703125)
    TDS:Upgrade(16)
    TDS:Upgrade(16)
    TDS:Upgrade(16)
    TDS:Upgrade(16)

    TDS:Place("Hacker", -3.7762348651885986, 0.9999892711639404, -25.750398635864258)
    TDS:Upgrade(17)
    TDS:Upgrade(17)
    TDS:Upgrade(17)
    TDS:Upgrade(17)
    TDS:Upgrade(17, 2)

    TDS:Place("Hacker", -9.145805358886719, 1.0000019073486328, -25.974485397338867)
    TDS:Upgrade(18)
    TDS:Upgrade(18)
    TDS:Upgrade(18)
    TDS:Upgrade(18)
    TDS:Upgrade(18, 2)
    TDS:Ability(18, "Hologram Tower", {towerPosition = Vector3.new(-3.7215161323547363, 1.0463122129440308, -5.009292125701904), towerToClone = 4}, true)
    TDS:Ability(17, "Hologram Tower", {towerPosition = Vector3.new(-4.2561936378479, 1.0377670526504517, 17.729827880859375), towerToClone = 6}, true)
    TDS:Ability(17, "Hologram Tower", {towerPosition = Vector3.new(5.1540374755859375, 1.0377665758132935, 16.96487808227539), towerToClone = 7}, true)

    return true
end

local Night4HardTimeScaleScheduled = false

local function StartNight4HardTimeScale(TDS)
    if Night4HardTimeScaleScheduled then return end
    Night4HardTimeScaleScheduled = true

    local globals = getgenv()
    globals.Night4HardTimeScaleOverride = nil

    task.spawn(function()
        if not TDS:WaitForWave(30) then return end

        local replicators = ReplicatedStorage:FindFirstChild("StateReplicators")
        local state = replicators and replicators:FindFirstChild("GameStateReplicator")
        if not state or state:GetAttribute("GameOver") == true then return end

        globals.Night4HardTimeScaleOverride = 1

        if type(globals.ApplyTimeScaleOnce) == "function" then
            pcall(globals.ApplyTimeScaleOnce)
        end

        while state.Parent and state:GetAttribute("GameOver") ~= true do
            task.wait(0.25)
        end

        globals.Night4HardTimeScaleOverride = nil
    end)
end

local Night4PuzzleScheduled = false

local function StartNight4Puzzle()
    if Night4PuzzleScheduled then return end
    Night4PuzzleScheduled = true

    task.spawn(function()
        local replicators = ReplicatedStorage:WaitForChild("StateReplicators", 30)
        local state = replicators and replicators:WaitForChild("GameStateReplicator", 30)

        if not state then
            warn("[Night 4] Puzzle loader: GameStateReplicator not found")
            return
        end

        while state.Parent and state:GetAttribute("GameStarted") ~= true do
            if state:GetAttribute("GameOver") == true then return end
            task.wait(0.2)
        end

        if not state.Parent or state:GetAttribute("GameOver") == true then return end

        local ok, err = pcall(function()
            local source = game:HttpGet("https://raw.githubusercontent.com/zaixxy123/lists/refs/heads/main/puzzle.lua")
            local chunk, compileError = loadstring(source)
            if not chunk then error(compileError) end
            chunk()
        end)

        if not ok then
            warn("[Night 4] Failed to load Moon Puzzle:", err)
        end
    end)
end

function Night.Run(mode, TDS)
    if mode == "Hard" then
        StartNight4Puzzle()
        StartNight4HardTimeScale(TDS)
    end
    if mode == "Easy" then return RunNight4Easy(TDS) end
    if mode == "Hard" then return RunNight4Hard(TDS) end
    return false
end

return Night
