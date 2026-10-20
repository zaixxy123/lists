local loadAutoGatling =
    getgenv().__RyaLoadAutoGatling

if type(loadAutoGatling) == "function" then
    task.spawn(
        loadAutoGatling
    )
end

TDS:Loadout("Hacker", "Gatling Gun", "Mercenary Base", "Trapper", "DJ Booth")

TDS:Mode("Fallen")

TDS:GameInfo("Forgetten Docks", {
    "HiddenEnemies",
    "ExplodingEnemies",
    "Limitation",
    "Committed",
    "Quarantine",
    "Fog"
})

TDS:VoteSkip(1,10)
TDS:VoteSkip(13,30)
TDS:VoteSkip(32,34)
TDS:VoteSkip(37,38)
TDS:Mercenary(140, 1)

TDS:Place("Trapper", -22.387372970581055, 1.024996638298035, -18.186660766601562, true)

TDS:Ready()

TDS:Place("Trapper", -22.387372970581055, 1.024996638298035, -18.186660766601562, true)
TDS:Place("Trapper", -22.387372970581055, 1.024996638298035, -18.186660766601562, true)

TDS:Place("Trapper", -22.135795593262, 1.0249862670898, -0.81161975860596, true)
TDS:Place("Trapper", -22.135795593262, 1.0249862670898, -0.81161975860596, true)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Landmine")
TDS:SetTarget(5, "Strongest")

TDS:UpgradeTimes(1, 2)
TDS:SetOption(1, "Trap", "Landmine")

TDS:Upgrade(4)
TDS:Upgrade(2)
TDS:Upgrade(3)

TDS:Place("Gatling Gun", 22.113616943359375, 1.025004267692566, -1.426929473876953, true)

TDS:UpgradeTimes(6, 2)

TDS:Place("Hacker", -26.938291549682617, 1.024994730949402, -24.882318496704102, true)

TDS:UpgradeTimes(7, 3)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", 22.113616943359375, 1.025004267692566, -1.426929473876953, true)

TDS:UpgradeTimes(8, 6)

TDS:Upgrade(7)
TDS:Upgrade(7, 2)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", 22.113616943359375, 1.025004267692566, -1.426929473876953, true)
TDS:UpgradeTimes(9, 6)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Bear Traps")

TDS:UpgradeTimes(4, 3)
TDS:SetOption(4, "Trap", "Bear Traps")

TDS:UpgradeTimes(3, 3)
TDS:SetOption(3, "Trap", "Bear Traps")

TDS:UpgradeTimes(2, 3)
TDS:SetOption(2, "Trap", "Bear Traps")

TDS:Place("Mercenary Base", 22.113616943359375, 1.025004267692566, -1.426929473876953, true)
TDS:UpgradeTimes(10, 6)

TDS:Place("DJ Booth", 22.113616943359375, 1.025004267692566, -1.426929473876953, true)

TDS:UpgradeTimes(11, 2)
TDS:SetOption(11, "Track", "Red")
TDS:UpgradeTimes(11, 3)

TDS:LoopAbility(7, "Hologram Tower", {
    towerPosition = Vector3.new(22.113616943359375, 1.025004267692566, -1.426929473876953),
    towerToClone = 6
})
