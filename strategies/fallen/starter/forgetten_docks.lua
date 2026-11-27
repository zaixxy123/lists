local loadAutoGatling = getgenv().LoadAutoGatling

if type(loadAutoGatling) == "function" then
    task.spawn(loadAutoGatling)
end

TDS:Loadout("Hacker", "Gatling Gun", "Mercenary Base", "Turret", "Soldier")

TDS:Mode("Fallen")
TDS:GameInfo("Forgetten Docks")

TDS:Mercenary(170, 1)
TDS:VoteSkip()

TDS:Place("Soldier", -22.6214542388916, 1.0249868631362915, -11.238807678222656)
TDS:Ready()

TDS:Place("Soldier", -21.908052444458008, 1.0249882936477661, -17.566150665283203)
TDS:Place("Soldier", -28.90676498413086, 1.0249918699264526, -14.654558181762695)
TDS:Place("Soldier", -29.48623275756836, 1.024991512298584, -11.543462753295898)
TDS:Place("Soldier", -21.83450698852539, 1.02498459815979, -8.1468505859375)

for _ = 1, 2 do
    for _, index in ipairs({1, 2, 3, 4, 5}) do
        TDS:Upgrade(index)
    end
end

TDS:Place("Gatling Gun", 5.32695198059082, 1.024984359741211, 9.891860961914062)
TDS:UpgradeTimes(6, 2)

TDS:Place("Hacker", -25.136260986328125, 1.0249913930892944, -18.755111694335938)
TDS:Place("Hacker", -32.001121520996094, 1.0249954462051392, -15.768638610839844)

TDS:UpgradeTimes(8, 2)
TDS:UpgradeTimes(7, 2)

TDS:Place("Mercenary Base", 1.401519775390625, 1.0249879360198975, 11.799297332763672)
TDS:UpgradeTimes(9, 4)
TDS:SetOption(9, "Unit 1", "Riot Guard")
TDS:SetOption(9, "Unit 2", "Riot Guard")
TDS:SetOption(9, "Unit 3", "Riot Guard")

TDS:Place("Mercenary Base", -23.013612747192383, 1.024983286857605, 0.8023672103881836)
TDS:UpgradeTimes(10, 4)
TDS:SetOption(10, "Unit 1", "Riot Guard")
TDS:SetOption(10, "Unit 2", "Riot Guard")
TDS:SetOption(10, "Unit 3", "Riot Guard")

TDS:Place("Mercenary Base", 24.044401168823242, 1.024993658065796, -2.844511032104492)
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

TDS:Place("Turret", -21.289127349853516, 1.0249897241592407, -3.2179365158081055)
TDS:Place("Turret", -18.51834487915039, 1.0249830484390259, -0.07593631744384766)
TDS:Place("Turret", -17.31069564819336, 1.0249865055084229, -4.103425979614258)

for _ = 1, 5 do
    for _, index in ipairs({12, 13, 14}) do
        TDS:Upgrade(index)
    end
end

TDS:Ability(8, "Hologram Tower", {
    towerPosition = Vector3.new(-3.699148178100586, 1.0249841213226318, 12.924443244934082),
    towerToClone = 6
}, true)
