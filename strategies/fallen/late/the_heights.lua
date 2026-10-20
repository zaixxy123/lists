local loadAutoGatling =
    getgenv().LoadAutoGatling

if type(loadAutoGatling) == "function" then
    task.spawn(
        loadAutoGatling
    )
end

TDS:Loadout("Hacker", "Gatling Gun", "Mercenary Base", "Trapper", "DJ Booth")

TDS:Mode("Fallen")

TDS:GameInfo("The Heights", {
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

TDS:Place("Trapper", -3.240005016326904, 0.499997019767761, 5.410642623901367, true)

TDS:Ready()

TDS:Place("Trapper", -3.240005016326904, 0.499997019767761, 5.410642623901367, true)
TDS:Place("Trapper", -3.240005016326904, 0.499997019767761, 5.410642623901367, true)

TDS:Place("Trapper", -11.324243545532227, 0.999988675117493, -0.496937751770020, true)
TDS:Place("Trapper", -11.324243545532227, 0.999988675117493, -0.496937751770020, true)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Landmine")
TDS:SetTarget(5, "Strongest")

TDS:UpgradeTimes(1, 2)
TDS:SetOption(1, "Trap", "Landmine")

TDS:Upgrade(4)
TDS:Upgrade(2)
TDS:Upgrade(3)

TDS:Place("Gatling Gun", -13.681732177734375, 1.861852765083313, -29.149671554565430, true)

TDS:UpgradeTimes(6, 2)

TDS:Place("Hacker", -8.954051017761230, 1.487091183662415, 20.952529907226562, true)

TDS:UpgradeTimes(7, 3)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", -13.681732177734375, 1.861852765083313, -29.149671554565430, true)

TDS:UpgradeTimes(8, 6)

TDS:Upgrade(7)
TDS:Upgrade(7, 2)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", -13.681732177734375, 1.861852765083313, -29.149671554565430, true)
TDS:UpgradeTimes(9, 6)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Bear Traps")

TDS:UpgradeTimes(4, 3)
TDS:SetOption(4, "Trap", "Bear Traps")

TDS:UpgradeTimes(3, 3)
TDS:SetOption(3, "Trap", "Bear Traps")

TDS:UpgradeTimes(2, 3)
TDS:SetOption(2, "Trap", "Bear Traps")

TDS:Place("Mercenary Base", -13.681732177734375, 1.861852765083313, -29.149671554565430, true)
TDS:UpgradeTimes(10, 6)

TDS:Place("DJ Booth", -13.681732177734375, 1.861852765083313, -29.149671554565430, true)

TDS:UpgradeTimes(11, 2)
TDS:SetOption(11, "Track", "Red")
TDS:UpgradeTimes(11, 3)

TDS:LoopAbility(7, "Hologram Tower", {
    towerPosition = Vector3.new(-13.681732177734375, 1.861852765083313, -29.149671554565430),
    towerToClone = 6
})
