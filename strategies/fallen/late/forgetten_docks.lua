local loadAutoGatling =
    getgenv().LoadAutoGatling

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


TDS:Place("Trapper", -21.55740737915039, 1.0249866247177124, -17.385400772094727)

TDS:Ready()

TDS:Place("Trapper", -21.720619201660156, 1.0249873399734497, -20.504436492919922)
TDS:Place("Trapper", -24.615785598754883, 1.024986982345581, -17.420223236083984)
TDS:Place("Trapper", -23.102962493896484, 1.0249830484390259, -1.1405830383300781)
TDS:Place("Trapper", -23.036544799804688, 1.0249706506729126, 1.8839902877807617)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Landmine")
TDS:SetTarget(5, "Strongest")

TDS:UpgradeTimes(1, 2)
TDS:SetOption(1, "Trap", "Landmine")

TDS:Upgrade(4)
TDS:Upgrade(2)
TDS:Upgrade(3)

TDS:Place("Gatling Gun", 20.40777587890625, 1.0249981880187988, -3.7374629974365234)

TDS:UpgradeTimes(6, 2)

TDS:Place("Hacker", -27.97771453857422, 1.0249890089035034, -24.579654693603516)

TDS:UpgradeTimes(7, 3)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", 29.222963333129883, 1.0249968767166138, -3.6656570434570312)

TDS:UpgradeTimes(8, 6)

TDS:Upgrade(7)
TDS:Upgrade(7, 2)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", 24.71601104736328, 1.0249983072280884, -3.814361572265625)

TDS:UpgradeTimes(9, 6)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Bear Traps")

TDS:UpgradeTimes(4, 3)
TDS:SetOption(4, "Trap", "Bear Traps")

TDS:UpgradeTimes(3, 3)
TDS:SetOption(3, "Trap", "Bear Traps")

TDS:UpgradeTimes(2, 3)
TDS:SetOption(2, "Trap", "Bear Traps")

TDS:Place("Mercenary Base", 20.144515991210938, 1.024988055229187, 0.5051889419555664)
TDS:UpgradeTimes(10, 6)

TDS:Place("DJ Booth", 23.26963996887207, 1.0249851942062378, 5.808272361755371)

TDS:UpgradeTimes(11, 2)
TDS:SetOption(11, "Track", "Red")
TDS:UpgradeTimes(11, 3)

TDS:Ability(7, "Hologram Tower", {towerPosition = Vector3.new(14.417430877685547, 1.0249861478805542, -0.33910560607910156), towerToClone = 2}, true)
