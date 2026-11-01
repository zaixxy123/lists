local Night = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("RemoteFunction")

Night.Requirements = {
    Easy = {"Trapper", "Hacker", "Gatling Gun", "Turret", "Mercenary Base"},
    Hard = {"DJ Booth", "Gatling Gun", "Mercenary Base", "Hacker", "Assassin"}
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
    for _, tower in ipairs(Night.Requirements.Easy) do
        remoteEvent:FireServer("Inventory", "Equip", "Tower", tower)
        task.wait(0.3)
    end

    return true
end

function Night.PrepareLobby(mode)
    if mode == "Hard" then return true end
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
    TDS:Loadout("DJ Booth", "Gatling Gun", "Mercenary Base", "Hacker", "Assassin")

    TDS:Place("Assassin", -9.171529769897461, 1.0000019073486328, -25.88697052001953)
    TDS:Upgrade(1)
    TDS:Upgrade(1)
    TDS:Place("Assassin", -16.253759384155273, 1.0000019073486328, -25.482765197753906)
    TDS:Upgrade(2)
    TDS:Upgrade(2)
    TDS:Place("Assassin", -16.514842987060547, 1.0562744140625, -32.553077697753906)
    TDS:Upgrade(3)
    TDS:Place("Assassin", -9.334545135498047, 0.9999831914901733, -33.0684928894043)
    TDS:Ready()
    TDS:Upgrade(4)
    TDS:Upgrade(4)
    TDS:Upgrade(3)
    TDS:Upgrade(1)
    TDS:Place("Gatling Gun", -7.41282844543457, 1.0399963855743408, -1.5982332229614258)
    TDS:Upgrade(5)
    TDS:Upgrade(4)
    TDS:Upgrade(2)
    TDS:Upgrade(3)
    TDS:Upgrade(5)
    TDS:Upgrade(5)
    TDS:Place("DJ Booth", -6.737171173095703, 1.060978889465332, -11.336831092834473)
    TDS:Upgrade(6)
    TDS:Upgrade(6)
    TDS:SetOption(6, "Track", "Red")
    TDS:Place("Mercenary Base", -5.277270317077637, 0.999999463558197, 7.099704742431641)
    TDS:Upgrade(7)
    TDS:Upgrade(7)
    TDS:SetOption(7, "Unit 1", "Grenadier")
    TDS:SetOption(7, "Unit 2", "Grenadier")
    TDS:Place("Mercenary Base", -9.787954330444336, 0.999999463558197, 7.614810943603516)
    TDS:Upgrade(8)
    TDS:Upgrade(8)
    TDS:SetOption(8, "Unit 1", "Grenadier")
    TDS:SetOption(8, "Unit 2", "Grenadier")
    TDS:Place("Mercenary Base", -14.269865036010742, 0.9999995231628418, 6.892122268676758)
    TDS:Upgrade(9)
    TDS:Upgrade(9)
    TDS:SetOption(9, "Unit 1", "Grenadier")
    TDS:SetOption(9, "Unit 2", "Grenadier")
    TDS:Place("Hacker", 7.603412628173828, 1.0377761125564575, -32.397621154785156)
    TDS:Upgrade(10)
    TDS:Upgrade(10)
    TDS:Place("Hacker", -6.03125, 1.0458101034164429, -17.534482955932617)
    TDS:Upgrade(11)
    TDS:Upgrade(11)
    TDS:Upgrade(5)
    TDS:Upgrade(1)
    TDS:Upgrade(4)
    TDS:Upgrade(2)
    TDS:Upgrade(3)
    TDS:Upgrade(7)
    TDS:Upgrade(8)
    TDS:Upgrade(9)
    TDS:Upgrade(5)
    TDS:Place("Assassin", -3.847836494445801, 1.0000019073486328, -25.5054988861084)
    TDS:Upgrade(12)
    TDS:Upgrade(12)
    TDS:Upgrade(12)
    TDS:Upgrade(12)
    TDS:Place("Assassin", 3.624307632446289, 0.9999839067459106, -24.526493072509766)
    TDS:Upgrade(13)
    TDS:Upgrade(13)
    TDS:Upgrade(13)
    TDS:Upgrade(13)
    TDS:Place("Assassin", 3.7621331214904785, 1.000002145767212, -32.2939338684082)
    TDS:Upgrade(14)
    TDS:Upgrade(14)
    TDS:Upgrade(14)
    TDS:Upgrade(14)
    TDS:Place("Assassin", -3.7384161949157715, 1.0293048620224, -32.805721282958984)
    TDS:Upgrade(15)
    TDS:Upgrade(15)
    TDS:Upgrade(15)
    TDS:Upgrade(15)
    TDS:Upgrade(6)
    TDS:Upgrade(6)
    TDS:Upgrade(6)
    TDS:Upgrade(5)
    TDS:Upgrade(7)
    TDS:Upgrade(7)
    TDS:Upgrade(7)
    TDS:SetOption(7, "Unit 1", "Riot Guard")
    TDS:SetOption(7, "Unit 2", "Riot Guard")
    TDS:SetOption(7, "Unit 3", "Riot Guard")
    TDS:Upgrade(8)
    TDS:Upgrade(8)
    TDS:Upgrade(8)
    TDS:SetOption(8, "Unit 1", "Riot Guard")
    TDS:SetOption(8, "Unit 2", "Riot Guard")
    TDS:SetOption(8, "Unit 3", "Riot Guard")
    TDS:Upgrade(9)
    TDS:Upgrade(9)
    TDS:Upgrade(9)
    TDS:SetOption(9, "Unit 1", "Riot Guard")
    TDS:SetOption(9, "Unit 2", "Riot Guard")
    TDS:SetOption(9, "Unit 3", "Riot Guard")
    TDS:Upgrade(11)
    TDS:Upgrade(11)
    TDS:Upgrade(11, 2)
    TDS:Upgrade(10)
    TDS:Upgrade(10)
    TDS:Upgrade(10, 2)
    TDS:Ability(11, "Hologram Tower")
    TDS:Ability(11, "Hologram Tower")
    TDS:Place("Assassin", 3.395956516265869, 0.9999809265136719, -22.172218322753906)
    TDS:Upgrade(16)
    TDS:Upgrade(16)
    TDS:Upgrade(16)
    TDS:Upgrade(16)
    TDS:Place("Assassin", 3.392974853515625, 1.0318564176559448, -19.553070068359375)
    TDS:Upgrade(17)
    TDS:Upgrade(17)
    TDS:Upgrade(17)
    TDS:Upgrade(17)
    TDS:Place("Assassin", 3.5518317222595215, 1.0468084812164307, -17.03923797607422)
    TDS:Upgrade(18)
    TDS:Upgrade(18)
    TDS:Upgrade(18)
    TDS:Upgrade(18)
    TDS:Place("Assassin", -3.6485376358032227, 0.9999860525131226, -23.34900665283203)
    TDS:Upgrade(19)
    TDS:Upgrade(19)
    TDS:Upgrade(19)
    TDS:Upgrade(19)
    TDS:Place("Assassin", -3.6485376358032227, 0.9999834299087524, -21.309005737304688)
    TDS:Upgrade(20)
    TDS:Upgrade(20)
    TDS:Upgrade(20)
    TDS:Upgrade(20)
    TDS:Place("Assassin", -3.684596061706543, 1.0400010347366333, -18.506498336791992)
    TDS:Upgrade(21)
    TDS:Upgrade(21)
    TDS:Upgrade(21)
    TDS:Upgrade(21)
    TDS:Place("Assassin", -5.846276760101318, 1.0000019073486328, -25.827150344848633)
    TDS:Upgrade(22)
    TDS:Upgrade(22)
    TDS:Upgrade(22)
    TDS:Upgrade(22)
    TDS:Place("Assassin", -7.530158042907715, 1.0000019073486328, -24.675567626953125)
    TDS:Upgrade(23)
    TDS:Upgrade(23)
    TDS:Upgrade(23)
    TDS:Upgrade(23)
    TDS:Ability(11, "Hologram Tower", {towerPosition = Vector3.new(-3.5859146118164062, 0.9999831914901733, 1.9490413665771484), towerToClone = 5}, true)
    TDS:Place("Assassin", 5.767512321472168, 0.9999834895133972, -25.088985443115234)
    TDS:Upgrade(24)
    TDS:Upgrade(24)
    TDS:Upgrade(24)
    TDS:Upgrade(24)
    TDS:Place("Assassin", 8.172419548034668, 0.9999818801879883, -24.756492614746094)
    TDS:Upgrade(25)
    TDS:Upgrade(25)
    TDS:Upgrade(25)
    TDS:Upgrade(25)
    TDS:Place("Assassin", -8.483437538146973, 1.0000017881393433, -22.871999740600586)
    TDS:Upgrade(26)
    TDS:Upgrade(26)
    TDS:Upgrade(26)
    TDS:Upgrade(26)
    TDS:Place("Assassin", -8.518035888671875, 1.0000015497207642, -20.588947296142578)
    TDS:Upgrade(27)
    TDS:Upgrade(27)
    TDS:Upgrade(27)
    TDS:Upgrade(27)
    TDS:Place("Assassin", -8.600214004516602, 1.0399993658065796, -18.335451126098633)
    TDS:Upgrade(28)
    TDS:Upgrade(28)
    TDS:Upgrade(28)
    TDS:Upgrade(28)
    TDS:Place("Assassin", -8.875572204589844, 1.0458989143371582, -15.903543472290039)
    TDS:Upgrade(29)
    TDS:Upgrade(29)
    TDS:Upgrade(29)
    TDS:Upgrade(29)
    TDS:Place("Assassin", -9.191256523132324, 1.0521260499954224, -13.888116836547852)
    TDS:Upgrade(30)
    TDS:Upgrade(30)
    TDS:Upgrade(30)
    TDS:Upgrade(30)
    TDS:Place("Assassin", -4.6470842361450195, 0.9999987483024597, 16.558916091918945)
    TDS:Upgrade(31)
    TDS:Upgrade(31)
    TDS:Upgrade(31)
    TDS:Upgrade(31)
    TDS:Sell(31)
    TDS:Place("Assassin", -4.086833477020264, 1.0410957336425781, -15.936409950256348)
    TDS:Upgrade(32)
    TDS:Upgrade(32)
    TDS:Upgrade(32)
    TDS:Upgrade(32)
    TDS:Place("Assassin", -5.6196112632751465, 1.0000016689300537, -21.855850219726562)
    TDS:Upgrade(33)
    TDS:Upgrade(33)
    TDS:Upgrade(33)
    TDS:Upgrade(33)
    TDS:Place("Assassin", 5.5386762619018555, 1.0609883069992065, -16.649612426757812)
    TDS:Upgrade(34)
    TDS:Upgrade(34)
    TDS:Upgrade(34)
    TDS:Upgrade(34)
    TDS:Place("Assassin", 7.501070022583008, 1.0532699823379517, -15.750651359558105)
    TDS:Upgrade(35)
    TDS:Upgrade(35)
    TDS:Upgrade(35)
    TDS:Upgrade(35)
    TDS:Place("Assassin", 10.481718063354492, 0.9999776482582092, -24.315284729003906)
    TDS:Upgrade(36)
    TDS:Upgrade(36)
    TDS:Upgrade(36)
    TDS:Upgrade(36)
    TDS:Place("Assassin", 11.39808177947998, 0.9999765753746033, -21.945682525634766)
    TDS:Upgrade(37)
    TDS:Upgrade(37)
    TDS:Upgrade(37)
    TDS:Upgrade(37)
    TDS:Place("Assassin", 11.465058326721191, 0.9999736547470093, -19.711578369140625)
    TDS:Upgrade(38)
    TDS:Upgrade(38)
    TDS:Upgrade(38)
    TDS:Upgrade(38)
    TDS:Place("Assassin", 11.31276798248291, 0.9999710917472839, -17.677270889282227)
    TDS:Upgrade(39)
    TDS:Upgrade(39)
    TDS:Upgrade(39)
    TDS:Upgrade(39)
    TDS:Place("Assassin", 9.902819633483887, 0.9999694228172302, -15.835609436035156)
    TDS:Upgrade(40)
    TDS:Upgrade(40)
    TDS:Upgrade(40)
    TDS:Upgrade(40)
    TDS:Place("Assassin", 5.380132675170898, 0.9999793171882629, -21.698251724243164)
    TDS:Upgrade(41)
    TDS:Upgrade(41)
    TDS:Upgrade(41)
    TDS:Upgrade(41)
    TDS:Ability(11, "Hologram Tower", {towerPosition = Vector3.new(-9.859330177307129, 0.9999997615814209, 2.994504928588867), towerToClone = 5}, true)
    TDS:Sell(3)
    TDS:Sell(4)
    TDS:Sell(2)
    TDS:Place("Assassin", -5.775125980377197, 1.0377761125564575, -32.95918655395508)
    TDS:Upgrade(42)
    TDS:Upgrade(42)
    TDS:Upgrade(42)
    TDS:Upgrade(42)
    TDS:Place("Assassin", -3.983456611633301, 1.04037606716156, -13.615789413452148)
    TDS:Upgrade(43)
    TDS:Upgrade(43)
    TDS:Upgrade(43)
    TDS:Upgrade(43)
    TDS:Place("Assassin", 7.377140998840332, 0.9999792575836182, -22.421178817749023)
    TDS:Upgrade(44)
    TDS:Upgrade(44)
    TDS:Upgrade(44)
    TDS:Upgrade(44)
    TDS:Ability(10, "Hologram Tower", {towerPosition = Vector3.new(-4.187923431396484, 0.9999815821647644, 2.602558135986328), towerToClone = 5}, true)
    TDS:Ability(11, "Hologram Tower", {towerPosition = Vector3.new(-3.491374969482422, 0.9999814629554749, 2.9926929473876953), towerToClone = 5}, true)

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

        local playerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
        local hotbar = playerGui and playerGui:FindFirstChild("ReactUniversalHotbar")
        local frame = hotbar and hotbar:FindFirstChild("Frame")
        local timescale = frame and frame:FindFirstChild("timescale")
        local speedLabel = timescale and timescale:FindFirstChild("Speed")
        local currentSpeed = speedLabel and tonumber(
            tostring(speedLabel.Text or ""):match("x([%d%.]+)")
        )

        if currentSpeed ~= 2 then return end

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
