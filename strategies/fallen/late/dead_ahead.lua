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

TDS:Place("Trapper", -0.9617843627929688, 0.9999929666519165, -7.3185577392578125)

TDS:Ready()

TDS:Place("Trapper", 0.410444974899292, 1.0199941396713257, -4.605886459350586)
TDS:Place("Trapper", -6.372126579284668, 1.0000011920928955, -7.059728622436523)

TDS:Place("Trapper", -6.372126579284668, 1.0000005960464478, -4.019728660583496)
TDS:Place("Trapper", -5.695156097412109, 1.0000016689300537, -10.023393630981445)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Landmine")
TDS:SetTarget(5, "Strongest")

TDS:UpgradeTimes(1, 2)
TDS:SetOption(1, "Trap", "Landmine")

TDS:Upgrade(4)
TDS:Upgrade(2)
TDS:Upgrade(3)

TDS:Place("Gatling Gun", -3.464784860610962, 0.9999924302101135, 46.32647705078125)

TDS:UpgradeTimes(6, 2)

TDS:Place("Hacker", -0.07314634323120117, 1.01999831199646, -10.391958236694336)

TDS:UpgradeTimes(7, 3)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", -7.17461633682251, 0.9999920725822449, 48.461421966552734)

TDS:UpgradeTimes(8, 6)

TDS:Upgrade(7)
TDS:Upgrade(7, 2)

TDS:UpgradeTimes(6, 2)

TDS:Place("Mercenary Base", -11.699275016784668, 0.9999920129776001, 48.83433151245117)
TDS:UpgradeTimes(9, 6)

TDS:UpgradeTimes(5, 2)
TDS:SetOption(5, "Trap", "Bear Traps")

TDS:UpgradeTimes(4, 3)
TDS:SetOption(4, "Trap", "Bear Traps")

TDS:UpgradeTimes(3, 3)
TDS:SetOption(3, "Trap", "Bear Traps")

TDS:UpgradeTimes(2, 3)
TDS:SetOption(2, "Trap", "Bear Traps")

TDS:Place("Mercenary Base", -10.152831077575684, 0.9999927282333374, 44.528263092041016)
TDS:UpgradeTimes(10, 6)

TDS:Place("DJ Booth", -5.144731521606445, 0.9999931454658508, 42.10873031616211)

TDS:UpgradeTimes(11, 2)
TDS:SetOption(11, "Track", "Red")
TDS:UpgradeTimes(11, 3)

TDS:Ability(7, "Hologram Tower", {
    towerPosition = Vector3.new(-0.26017284393310547, 1.019989013671875, 43.180267333984375),
    towerToClone = 6
}, true)
