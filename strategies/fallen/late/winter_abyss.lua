local loadAutoGatling =
    getgenv().__RyaLoadAutoGatling

if type(loadAutoGatling) == "function" then
    task.spawn(
        loadAutoGatling
    )
end

TDS:Loadout("Hacker", "Gatling Gun", "Mercenary Base", "Trapper", "DJ Booth")

TDS:Mode("Fallen")

TDS:GameInfo("Winter Abyss", {
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

TDS:Place("Trapper", -10.301908493041992, 0.989994883537292, 39.803794860839844, true)

TDS:Ready()

TDS:Place("Trapper", -10.301908493041992, 0.989994883537292, 39.803794860839844, true)
TDS:Place("Trapper", -10.301908493041992, 0.989994883537292, 39.803794860839844, true)

TDS:Place("Trapper", -4.663175582885742, 2.013756275177002, 19.514411926269531, true)
TDS:Place("Trapper", -4.663175582885742, 2.013756275177002, 19.514411926269531, true)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Landmine")
TDS:SetTarget(5, "Strongest")

TDS:UpgradeTimes(1, 2)
TDS:SetOption(1, "Trap", "Landmine")

TDS:Upgrade(4)
TDS:Upgrade(2)
TDS:Upgrade(3)

TDS:Place("Gatling Gun", 3.702454805374146, 4.970402240753174, -43.507446289062500, true)

TDS:UpgradeTimes(6, 2)

TDS:Place("Hacker", -10.168857574462891, 0.995293498039246, 48.028793334960938, true)

TDS:UpgradeTimes(7, 3)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", 3.702454805374146, 4.970402240753174, -43.507446289062500, true)

TDS:UpgradeTimes(8, 6)

TDS:Upgrade(7)
TDS:Upgrade(7, 2)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", 3.702454805374146, 4.970402240753174, -43.507446289062500, true)
TDS:UpgradeTimes(9, 6)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Bear Traps")

TDS:UpgradeTimes(4, 3)
TDS:SetOption(4, "Trap", "Bear Traps")

TDS:UpgradeTimes(3, 3)
TDS:SetOption(3, "Trap", "Bear Traps")

TDS:UpgradeTimes(2, 3)
TDS:SetOption(2, "Trap", "Bear Traps")

TDS:Place("Mercenary Base", 3.702454805374146, 4.970402240753174, -43.507446289062500, true)
TDS:UpgradeTimes(10, 6)

TDS:Place("DJ Booth", 3.702454805374146, 4.970402240753174, -43.507446289062500, true)

TDS:UpgradeTimes(11, 2)
TDS:SetOption(11, "Track", "Red")
TDS:UpgradeTimes(11, 3)

TDS:LoopAbility(7, "Hologram Tower", {
    towerPosition = Vector3.new(3.702454805374146, 4.970402240753174, -43.507446289062500),
    towerToClone = 6
})
