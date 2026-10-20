local loadAutoGatling =
    getgenv().LoadAutoGatling

if type(loadAutoGatling) == "function" then
    task.spawn(
        loadAutoGatling
    )
end

TDS:Loadout("Hacker", "Gatling Gun", "Mercenary Base", "Trapper", "DJ Booth")

TDS:Mode("Fallen")

TDS:GameInfo("Lay By", {
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

TDS:Place("Trapper", -3.336249351501465, 242.999984741210938, 267.680694580078125, true)

TDS:Ready()

TDS:Place("Trapper", -3.336249351501465, 242.999984741210938, 267.680694580078125, true)
TDS:Place("Trapper", -3.336249351501465, 242.999984741210938, 267.680694580078125, true)

TDS:Place("Trapper", -2.942691802978516, 242.999969482421875, 234.732269287109375, true)
TDS:Place("Trapper", -2.942691802978516, 242.999969482421875, 234.732269287109375, true)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Landmine")
TDS:SetTarget(5, "Strongest")

TDS:UpgradeTimes(1, 2)
TDS:SetOption(1, "Trap", "Landmine")

TDS:Upgrade(4)
TDS:Upgrade(2)
TDS:Upgrade(3)

TDS:Place("Gatling Gun", -0.015020549297332764, 243, 150.77565002441406)

TDS:UpgradeTimes(6, 2)

TDS:Place("Hacker", -3.519666671752930, 242.999984741210938, 278.660736083984375, true)

TDS:UpgradeTimes(7, 3)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", 4.1555619239807129, 243, 147.58470153808594)

TDS:UpgradeTimes(8, 6)

TDS:Upgrade(7)
TDS:Upgrade(7, 2)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", -4.031796932220459, 243, 146.84439086914062)
TDS:UpgradeTimes(9, 6)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Bear Traps")

TDS:UpgradeTimes(4, 3)
TDS:SetOption(4, "Trap", "Bear Traps")

TDS:UpgradeTimes(3, 3)
TDS:SetOption(3, "Trap", "Bear Traps")

TDS:UpgradeTimes(2, 3)
TDS:SetOption(2, "Trap", "Bear Traps")

TDS:Place("Mercenary Base", 4.991236209869385, 243.000000000000000, 156.658065795898438, true)
TDS:UpgradeTimes(10, 6)

TDS:Place("DJ Booth", 4.991236209869385, 243.000000000000000, 156.658065795898438, true)

TDS:UpgradeTimes(11, 2)
TDS:SetOption(11, "Track", "Red")
TDS:UpgradeTimes(11, 3)

TDS:LoopAbility(7, "Hologram Tower", {
    towerPosition = Vector3.new(0.47156378626823425, 243, 143.558837890625),
    towerToClone = 6
})
