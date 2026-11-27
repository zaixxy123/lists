local loadAutoGatling = getgenv().LoadAutoGatling

if type(loadAutoGatling) == "function" then
    task.spawn(loadAutoGatling)
end

TDS:Loadout("Hacker", "Gatling Gun", "Mercenary Base", "Turret", "Soldier")

TDS:Mode("Fallen")
TDS:GameInfo("Cataclysm")

TDS:Mercenary(170, 1)
TDS:VoteSkip()

TDS:Place("Soldier", -3.703249454498291, 1.0000081062316895, 28.699129104614258)
TDS:Ready()

TDS:Place("Soldier", -6.759115219116211, 1.0000081062316895, 28.56633758544922)
TDS:Place("Soldier", -0.6467587947845459, 1.0000081062316895, 28.549053192138672)
TDS:Place("Soldier", -1.9404160976409912, 1.0000081062316895, 25.729171752929688)
TDS:Place("Soldier", -5.175713539123535, 1.0000081062316895, 25.834121704101562)

for _ = 1, 2 do
    for _, index in ipairs({1, 2, 3, 4, 5}) do
        TDS:Upgrade(index)
    end
end

TDS:Place("Gatling Gun", 7.605749130249023, 1.0000081062316895, -41.18436050415039)
TDS:UpgradeTimes(6, 2)

TDS:Place("Hacker", -3.670766830444336, 1.0000081062316895, 23.02606201171875)
TDS:Place("Hacker", -0.06444388628005981, 1.0000081062316895, 23.287553787231445)

TDS:UpgradeTimes(8, 2)
TDS:UpgradeTimes(7, 2)

TDS:Place("Mercenary Base", 1.0368907451629639, 1.0000081062316895, -41.243865966796875)
TDS:UpgradeTimes(9, 4)
TDS:SetOption(9, "Unit 1", "Riot Guard")
TDS:SetOption(9, "Unit 2", "Riot Guard")
TDS:SetOption(9, "Unit 3", "Riot Guard")

TDS:Place("Mercenary Base", -5.864011764526367, 1.0749932527542114, 11.213031768798828)
TDS:UpgradeTimes(10, 4)
TDS:SetOption(10, "Unit 1", "Riot Guard")
TDS:SetOption(10, "Unit 2", "Riot Guard")
TDS:SetOption(10, "Unit 3", "Riot Guard")

TDS:Place("Mercenary Base", -0.2638082504272461, 1.0000081062316895, -36.60939025878906)
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

TDS:Place("Turret", 0.5275440216064453, 1.0749932527542114, 7.259222030639648)
TDS:Place("Turret", -3.907642364501953, 1.0749932527542114, 7.21022891998291)
TDS:Place("Turret", -8.216619491577148, 1.0749932527542114, 7.421511650085449)

for _ = 1, 5 do
    for _, index in ipairs({12, 13, 14}) do
        TDS:Upgrade(index)
    end
end

TDS:Ability(8, "Hologram Tower", {
    towerPosition = Vector3.new(-3.382718086242676, 1.0000081062316895, -39.57087707519531),
    towerToClone = 6
}, true)
