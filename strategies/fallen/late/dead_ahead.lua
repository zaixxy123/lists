local loadAutoGatling =
    getgenv().LoadAutoGatling

if type(loadAutoGatling) == "function" then
    task.spawn(
        loadAutoGatling
    )
end

TDS:Loadout("Hacker", "Gatling Gun", "Mercenary Base", "Trapper", "DJ Booth")

TDS:Mode("Fallen")

TDS:GameInfo("Dead Ahead", {
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
TDS:Mercenary(80, 1)

TDS:Place("Trapper", 1.2970037460327148, 1.0000042915344238, -26.240280151367188, true)

TDS:Ready()

TDS:Place("Trapper", 1.2970037460327148, 1.0000042915344238, -26.240280151367188, true)
TDS:Place("Trapper", 1.2970037460327148, 1.0000042915344238, -26.240280151367188, true)

TDS:Place("Trapper", -0.35642445087433, 1.0199962854385, -7.7312870025635, true)
TDS:Place("Trapper", -0.35642445087433, 1.0199962854385, -7.7312870025635, true)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Landmine")
TDS:SetTarget(5, "Strongest")

TDS:UpgradeTimes(1, 2)
TDS:SetOption(1, "Trap", "Landmine")

TDS:Upgrade(4)
TDS:Upgrade(2)
TDS:Upgrade(3)

TDS:Place("Gatling Gun", -12.744829177856445, 0.999992847442627, 43.93040084838867, true)

TDS:UpgradeTimes(6, 2)

TDS:Place("Hacker", 1.739725112915039, 0.9999992847442627, -34.2012939453125, true)

TDS:UpgradeTimes(7, 3)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", -12.744829177856445, 0.999992847442627, 43.93040084838867, true)

TDS:UpgradeTimes(8, 6)

TDS:Upgrade(7)
TDS:Upgrade(7, 2)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", -12.744829177856445, 0.999992847442627, 43.93040084838867, true)
TDS:UpgradeTimes(9, 6)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Bear Traps")

TDS:UpgradeTimes(4, 3)
TDS:SetOption(4, "Trap", "Bear Traps")

TDS:UpgradeTimes(3, 3)
TDS:SetOption(3, "Trap", "Bear Traps")

TDS:UpgradeTimes(2, 3)
TDS:SetOption(2, "Trap", "Bear Traps")

TDS:Place("Mercenary Base", -12.744829177856445, 0.999992847442627, 43.93040084838867, true)
TDS:UpgradeTimes(10, 6)

TDS:Place("DJ Booth", -12.744829177856445, 0.999992847442627, 43.93040084838867, true)

TDS:UpgradeTimes(11, 2)
TDS:SetOption(11, "Track", "Red")
TDS:UpgradeTimes(11, 3)

TDS:LoopAbility(7, "Hologram Tower", {
    towerPosition = Vector3.new(-12.744829177856445, 25.999992847442627, 43.93040084838867),
    towerToClone = 6
})
