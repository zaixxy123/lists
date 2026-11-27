local loadAutoGatling = getgenv().LoadAutoGatling

if type(loadAutoGatling) == "function" then
    task.spawn(loadAutoGatling)
end

TDS:Loadout("Hacker", "Gatling Gun", "Mercenary Base", "Turret", "Soldier")

TDS:Mode("Fallen")
TDS:GameInfo("Construction Crazy")

TDS:Mercenary(170, 1)
TDS:VoteSkip()

TDS:Place("Soldier", 1.8921220302581787, 0.5050032734870911, -26.247621536254883)
TDS:Ready()

TDS:Place("Soldier", 2.9030356407165527, 0.5050032734870911, -23.388399124145508)
TDS:Place("Soldier", 4.9339518547058105, 0.5050032734870911, -26.463869094848633)
TDS:Place("Soldier", 5.984193801879883, 0.5050032734870911, -23.56161880493164)
TDS:Place("Soldier", 4.284724235534668, 0.5050032734870911, -13.993949890136719)

for _ = 1, 2 do
    for _, index in ipairs({1, 2, 3, 4, 5}) do
        TDS:Upgrade(index)
    end
end

TDS:Place("Gatling Gun", 21.504150390625, 0.2550067901611328, 9.44355583190918)
TDS:UpgradeTimes(6, 2)

TDS:Place("Hacker", 7.8840179443359375, 0.5050032734870911, -25.909290313720703)
TDS:Place("Hacker", 7.096816062927246, 0.5050032734870911, -12.862586975097656)

TDS:UpgradeTimes(8, 2)
TDS:UpgradeTimes(7, 2)

TDS:Place("Mercenary Base", 22.172449111938477, 0.2550067901611328, 5.049260139465332)
TDS:UpgradeTimes(9, 4)
TDS:SetOption(9, "Unit 1", "Riot Guard")
TDS:SetOption(9, "Unit 2", "Riot Guard")
TDS:SetOption(9, "Unit 3", "Riot Guard")

TDS:Place("Mercenary Base", 2.31325626373291, 1.7500076293945312, 0.9954299926757812)
TDS:UpgradeTimes(10, 4)
TDS:SetOption(10, "Unit 1", "Riot Guard")
TDS:SetOption(10, "Unit 2", "Riot Guard")
TDS:SetOption(10, "Unit 3", "Riot Guard")

TDS:Place("Mercenary Base", -42.154869079589844, 0.2550067901611328, 9.76688003540039)
TDS:UpgradeTimes(11, 4)
TDS:SetOption(11, "Unit 1", "Riot Guard")
TDS:SetOption(11, "Unit 2", "Riot Guard")
TDS:SetOption(11, "Unit 3", "Riot Guard")

TDS:Upgrade(9)
TDS:Upgrade(10)
TDS:Upgrade(11)

TDS:UpgradeTimes(6, 2)

TDS:UpgradeTimes(8, 2)
TDS:Upgrade(8, 2)

TDS:UpgradeTimes(7, 2)
TDS:Upgrade(7, 2)

TDS:Upgrade(9)
TDS:Upgrade(10)
TDS:Upgrade(11)

TDS:UpgradeTimes(6, 2)

TDS:Place("Turret", 5.346144676208496, 1.7500076293945312, -2.467935085296631)
TDS:Place("Turret", 1.3894648551940918, 1.7500076293945312, -3.29046630859375)
TDS:Place("Turret", -2.671998977661133, 1.7500076293945312, -2.8053698539733887)

for _ = 1, 5 do
    for _, index in ipairs({12, 13, 14}) do
        TDS:Upgrade(index)
    end
end

TDS:Ability(8, "Hologram Tower", {
    towerPosition = Vector3.new(25.668869018554688, 0.2550067901611328, 8.022377014160156),
    towerToClone = 6
}, true)
