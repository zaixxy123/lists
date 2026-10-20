local loadAutoGatling =
    getgenv().LoadAutoGatling

if type(loadAutoGatling) == "function" then
    task.spawn(
        loadAutoGatling
    )
end

TDS:Loadout("Hacker", "Gatling Gun", "Mercenary Base", "Trapper", "DJ Booth")

TDS:Mode("Fallen")

TDS:GameInfo("Sacred Mountains", {
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

TDS:Place("Trapper", -13.292556762695312, 0.400015711784363, -14.377884864807129, true)

TDS:Ready()

TDS:Place("Trapper", -13.292556762695312, 0.400015711784363, -14.377884864807129, true)
TDS:Place("Trapper", -13.292556762695312, 0.400015711784363, -14.377884864807129, true)

TDS:Place("Trapper", 0.179722547531128, 0.400010228157043, -16.863555908203125, true)
TDS:Place("Trapper", 0.179722547531128, 0.400010228157043, -16.863555908203125, true)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Landmine")
TDS:SetTarget(5, "Strongest")

TDS:UpgradeTimes(1, 2)
TDS:SetOption(1, "Trap", "Landmine")

TDS:Upgrade(4)
TDS:Upgrade(2)
TDS:Upgrade(3)

TDS:Place("Gatling Gun", 25.640258789062500, 0.400001645088196, 14.360178947448730, true)

TDS:UpgradeTimes(6, 2)

TDS:Place("Hacker", -21.649829864501953, -0.600004076957703, -16.095018386840820, true)

TDS:UpgradeTimes(7, 3)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", 25.640258789062500, 0.400001645088196, 14.360178947448730, true)

TDS:UpgradeTimes(8, 6)

TDS:Upgrade(7)
TDS:Upgrade(7, 2)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", 25.640258789062500, 0.400001645088196, 14.360178947448730, true)
TDS:UpgradeTimes(9, 6)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Bear Traps")

TDS:UpgradeTimes(4, 3)
TDS:SetOption(4, "Trap", "Bear Traps")

TDS:UpgradeTimes(3, 3)
TDS:SetOption(3, "Trap", "Bear Traps")

TDS:UpgradeTimes(2, 3)
TDS:SetOption(2, "Trap", "Bear Traps")

TDS:Place("Mercenary Base", 25.640258789062500, 0.400001645088196, 14.360178947448730, true)
TDS:UpgradeTimes(10, 6)

TDS:Place("DJ Booth", 25.640258789062500, 0.400001645088196, 14.360178947448730, true)

TDS:UpgradeTimes(11, 2)
TDS:SetOption(11, "Track", "Red")
TDS:UpgradeTimes(11, 3)

TDS:LoopAbility(7, "Hologram Tower", {
    towerPosition = Vector3.new(25.640258789062500, 25.400001645088196, 14.360178947448730),
    towerToClone = 6
})
