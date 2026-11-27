local loadAutoGatling =
    getgenv().LoadAutoGatling

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

TDS:Place("Trapper", -10.662050247192383, 0.993530809879303, 39.83293914794922)

TDS:Ready()

TDS:Place("Trapper", -7.646100997924805, 0.9651154279708862, 39.60285949707031)
TDS:Place("Trapper", -9.805362701416016, 0.9970284104347229, 42.71205520629883)
TDS:Place("Trapper", -16.314990997314453, 0.9451814293861389, 41.95391082763672)
TDS:Place("Trapper", -17.063072204589844, 0.9542127251625061, 38.978492736816406)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Landmine")
TDS:SetTarget(5, "Strongest")

TDS:UpgradeTimes(1, 2)
TDS:SetOption(1, "Trap", "Landmine")

TDS:Upgrade(4)
TDS:Upgrade(2)
TDS:Upgrade(3)

TDS:Place("Gatling Gun", 3.8544936180114746, 4.946666240692139, -49.769493103027344)

TDS:UpgradeTimes(6, 2)

TDS:Place("Hacker", -6.755461692810059, 0.9780670404434204, 42.52408981323242)

TDS:UpgradeTimes(7, 3)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", -0.38462692499160767, 4.958554267883301, -49.11765670776367)

TDS:UpgradeTimes(8, 6)

TDS:Upgrade(7)
TDS:Upgrade(7, 2)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", 2.371502637863159, 4.9730119705200195, -45.474342346191406)
TDS:UpgradeTimes(9, 6)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Bear Traps")

TDS:UpgradeTimes(4, 3)
TDS:SetOption(4, "Trap", "Bear Traps")

TDS:UpgradeTimes(3, 3)
TDS:SetOption(3, "Trap", "Bear Traps")

TDS:UpgradeTimes(2, 3)
TDS:SetOption(2, "Trap", "Bear Traps")

TDS:Place("Mercenary Base", 5.156423568725586, 4.965843200683594, -41.51609802246094)
TDS:UpgradeTimes(10, 6)

TDS:Place("DJ Booth", -5.023190498352051, 4.975996971130371, -47.5915641784668)

TDS:UpgradeTimes(11, 2)
TDS:SetOption(11, "Track", "Red")
TDS:UpgradeTimes(11, 3)

TDS:Ability(7, "Hologram Tower", {towerPosition = Vector3.new(9.061939239501953, 4.9528303146362305, -40.38243103027344), towerToClone = 6}, true)
