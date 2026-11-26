local loadAutoGatling =
    getgenv().LoadAutoGatling

if type(loadAutoGatling) == "function" then
    task.spawn(
        loadAutoGatling
    )
end

TDS:Loadout("Hacker", "Gatling Gun", "Mercenary Base", "Trapper", "DJ Booth")

TDS:Mode("Fallen")

TDS:GameInfo("Retro The Heights", {
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


TDS:Place("Trapper", 2.415404796600342, 1.0625, 10.37039852142334)

TDS:Ready()

TDS:Place("Trapper", 2.1595797538757324, 0.5625, 6.466505527496338)
TDS:Place("Trapper", -1.7303870916366577, 0.5625, 6.434186935424805)
TDS:Place("Trapper", -8.723848342895508, 1.0625, 0.41706693172454834)
TDS:Place("Trapper", -8.646279335021973, 1.0625, -2.730023145675659)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Landmine")
TDS:SetTarget(5, "Strongest")

TDS:UpgradeTimes(1, 2)
TDS:SetOption(1, "Trap", "Landmine")

TDS:Upgrade(4)
TDS:Upgrade(2)
TDS:Upgrade(3)

TDS:Place("Gatling Gun", -12.486294746398926, 1.5625, -31.313247680664062)

TDS:UpgradeTimes(6, 2)

TDS:Place("Hacker", -6.53311014175415, 1.0625, 20.389999389648438)

TDS:UpgradeTimes(7, 3)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", -14.657852172851562, 1.5625, -27.587200164794922)

TDS:UpgradeTimes(8, 6)

TDS:Upgrade(7)
TDS:Upgrade(7, 2)

TDS:UpgradeTimes(6, 2)


TDS:Place("Mercenary Base", -10.11735725402832, 1.5625, -27.57114601135254)
TDS:UpgradeTimes(9, 6)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Bear Traps")

TDS:UpgradeTimes(4, 3)
TDS:SetOption(4, "Trap", "Bear Traps")

TDS:UpgradeTimes(3, 3)
TDS:SetOption(3, "Trap", "Bear Traps")

TDS:UpgradeTimes(2, 3)
TDS:SetOption(2, "Trap", "Bear Traps")


TDS:Place("Mercenary Base", -5.605866432189941, 1.5625, -27.562698364257812)
TDS:UpgradeTimes(10, 6)

TDS:Place("DJ Booth", -10.137481689453125, 1.5625, -35.229957580566406)

TDS:UpgradeTimes(11, 2)
TDS:SetOption(11, "Track", "Red")
TDS:UpgradeTimes(11, 3)

TDS:Ability(7, "Hologram Tower", {towerPosition = Vector3.new(-7.935660362243652, 1.5625004768371582, -31.30259132385254), towerToClone = 6}, true)
