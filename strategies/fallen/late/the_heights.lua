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


TDS:Place("Trapper", -0.75, 0.9999810457229614, 9.510580062866211)

TDS:Ready()

TDS:Place("Trapper", -0.9388079643249512, 0.4999828040599823, 6.074640274047852)
TDS:Place("Trapper", -3.9929847717285156, 0.49998143315315247, 6.1860833168029785)
TDS:Place("Trapper", -11.977949142456055, 1.024410367012024, 1.005326509475708)
TDS:Place("Trapper", -11.962791442871094, 0.999987781047821, -2.0623104572296143)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Landmine")
TDS:SetTarget(5, "Strongest")

TDS:UpgradeTimes(1, 2)
TDS:SetOption(1, "Trap", "Landmine")

TDS:Upgrade(4)
TDS:Upgrade(2)
TDS:Upgrade(3)

TDS:Place("Gatling Gun", -14.76087474822998, 1.8618512153625488, -30.933513641357422)

TDS:UpgradeTimes(6, 2)

TDS:Place("Hacker", -9.737586975097656, 1.4870851039886475, 20.492137908935547)

TDS:UpgradeTimes(7, 3)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", -16.980690002441406, 1.8618417978286743, -27.28498649597168)

TDS:UpgradeTimes(8, 6)

TDS:Upgrade(7)
TDS:Upgrade(7, 2)

TDS:UpgradeTimes(6, 2)


TDS:Place("Mercenary Base", -12.452524185180664, 1.8618416786193848, -27.22565269470215)
TDS:UpgradeTimes(9, 6)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Bear Traps")

TDS:UpgradeTimes(4, 3)
TDS:SetOption(4, "Trap", "Bear Traps")

TDS:UpgradeTimes(3, 3)
TDS:SetOption(3, "Trap", "Bear Traps")

TDS:UpgradeTimes(2, 3)
TDS:SetOption(2, "Trap", "Bear Traps")

TDS:Place("Mercenary Base", -7.9490065574646, 1.8618409633636475, -27.262943267822266)
TDS:UpgradeTimes(10, 6)

TDS:Place("DJ Booth", -12.423547744750977, 1.8618603944778442, -34.83363342285156)

TDS:UpgradeTimes(11, 2)
TDS:SetOption(11, "Track", "Red")
TDS:UpgradeTimes(11, 3)

TDS:Ability(7, "Hologram Tower", {towerPosition = Vector3.new(-10.226112365722656, 1.8618485927581787, -30.88914680480957), towerToClone = 6}, true)
