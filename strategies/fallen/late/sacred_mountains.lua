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


TDS:Place("Trapper", -13.969482421875, 0.40000805258750916, -14.28499984741211)

TDS:Ready()

TDS:Place("Trapper", -13.061497688293457, 0.39999741315841675, -17.193204879760742)
TDS:Place("Trapper", -10.702640533447266, 0.40001070499420166, -19.139310836791992)
TDS:Place("Trapper", -2.7961275577545166, 0.40000635385513306, -19.561872482299805)
TDS:Place("Trapper", 0.1728684902191162, 0.400005042552948, -18.769813537597656)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Landmine")
TDS:SetTarget(5, "Strongest")

TDS:UpgradeTimes(1, 2)
TDS:SetOption(1, "Trap", "Landmine")

TDS:Upgrade(4)
TDS:Upgrade(2)
TDS:Upgrade(3)

TDS:Place("Gatling Gun", 27.282669067382812, 0.399997353553772, 14.071317672729492)

TDS:UpgradeTimes(6, 2)

TDS:Place("Hacker", -21.08564567565918, -0.6000101566314697, -11.48350715637207)

TDS:UpgradeTimes(7, 3)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", 27.284149169921875, 0.40000343322753906, 9.72829532623291)

TDS:UpgradeTimes(8, 6)

TDS:Upgrade(7)
TDS:Upgrade(7, 2)

TDS:UpgradeTimes(6, 2)


TDS:Place("Mercenary Base", 32.92920684814453, 0.40000221133232117, 10.463072776794434)

TDS:UpgradeTimes(9, 6)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Bear Traps")

TDS:UpgradeTimes(4, 3)
TDS:SetOption(4, "Trap", "Bear Traps")

TDS:UpgradeTimes(3, 3)
TDS:SetOption(3, "Trap", "Bear Traps")

TDS:UpgradeTimes(2, 3)
TDS:SetOption(2, "Trap", "Bear Traps")


TDS:Place("Mercenary Base", 32.81060791015625, 0.3999941647052765, 15.090617179870605)
TDS:UpgradeTimes(10, 6)

TDS:Place("DJ Booth", 23.00454330444336, 0.40000343322753906, 12.60733699798584)

TDS:UpgradeTimes(11, 2)
TDS:SetOption(11, "Track", "Red")
TDS:UpgradeTimes(11, 3)

TDS:Ability(7, "Hologram Tower", {towerPosition = Vector3.new(25.748668670654297, 0.39999303221702576, 17.891677856445312), towerToClone = 6}, true)
