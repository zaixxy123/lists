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

TDS:Place("Trapper", 0.027876853942871, 0.562506079673767, 6.239594459533691, true)

TDS:Ready()

TDS:Place("Trapper", 0.027876853942871, 0.562506079673767, 6.239594459533691, true)
TDS:Place("Trapper", 0.027876853942871, 0.562506079673767, 6.239594459533691, true)

TDS:Place("Trapper", -8.283555984497070, 1.062506079673767, -0.079804897308350, true)
TDS:Place("Trapper", -8.283555984497070, 1.062506079673767, -0.079804897308350, true)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Landmine")
TDS:SetTarget(5, "Strongest")

TDS:UpgradeTimes(1, 2)
TDS:SetOption(1, "Trap", "Landmine")

TDS:Upgrade(4)
TDS:Upgrade(2)
TDS:Upgrade(3)

TDS:Place("Gatling Gun", -12.654920578002930, 1.562506079673767, -29.426273345947266, true)

TDS:UpgradeTimes(6, 2)

TDS:Place("Hacker", -5.715780735015869, 1.062506079673767, 21.403209686279297, true)

TDS:UpgradeTimes(7, 3)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", -12.654920578002930, 1.562506079673767, -29.426273345947266, true)

TDS:UpgradeTimes(8, 6)

TDS:Upgrade(7)
TDS:Upgrade(7, 2)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", -12.654920578002930, 1.562506079673767, -29.426273345947266, true)
TDS:UpgradeTimes(9, 6)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Bear Traps")

TDS:UpgradeTimes(4, 3)
TDS:SetOption(4, "Trap", "Bear Traps")

TDS:UpgradeTimes(3, 3)
TDS:SetOption(3, "Trap", "Bear Traps")

TDS:UpgradeTimes(2, 3)
TDS:SetOption(2, "Trap", "Bear Traps")

TDS:Place("Mercenary Base", -12.654920578002930, 1.562506079673767, -29.426273345947266, true)
TDS:UpgradeTimes(10, 6)

TDS:Place("DJ Booth", -12.654920578002930, 1.562506079673767, -29.426273345947266, true)

TDS:UpgradeTimes(11, 2)
TDS:SetOption(11, "Track", "Red")
TDS:UpgradeTimes(11, 3)

TDS:LoopAbility(7, "Hologram Tower", {
    towerPosition = Vector3.new(-12.654920578002930, 1.562506079673767, -29.426273345947266),
    towerToClone = 6
})
