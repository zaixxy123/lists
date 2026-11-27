local loadAutoGatling = getgenv().LoadAutoGatling

if type(loadAutoGatling) == "function" then
    task.spawn(loadAutoGatling)
end

TDS:Loadout("Hacker", "Gatling Gun", "Mercenary Base", "Turret", "Soldier")

TDS:Mode("Fallen")
TDS:GameInfo("Winter Abyss")

TDS:Mercenary(170, 1)
TDS:VoteSkip()

TDS:Place("Soldier", -2.6834464073181152, 0.9620877504348755, 45.84326171875)
TDS:Ready()

TDS:Place("Soldier", -5.68263578414917, 0.977523148059845, 45.655418395996094)
TDS:Place("Soldier", -8.69968318939209, 0.9930088520050049, 45.54209518432617)
TDS:Place("Soldier", -3.7527549266815186, 0.9621309638023376, 42.90186309814453)
TDS:Place("Soldier", -6.954357147216797, 0.9810183644294739, 42.896759033203125)

for _ = 1, 2 do
    for _, index in ipairs({1, 2, 3, 4, 5}) do
        TDS:Upgrade(index)
    end
end

TDS:Place("Gatling Gun", 0.3163628578186035, 5.061888694763184, -60.456993103027344)
TDS:UpgradeTimes(6, 2)

TDS:Place("Hacker", -5.304250717163086, 0.9744618535041809, 48.792991638183594)
TDS:Place("Hacker", -5.76008939743042, 0.9562901854515076, 40.08504104614258)

TDS:UpgradeTimes(8, 2)
TDS:UpgradeTimes(7, 2)

TDS:Place("Mercenary Base", 6.294883728027344, 4.929332256317139, -60.52960205078125)
TDS:UpgradeTimes(9, 4)
TDS:SetOption(9, "Unit 1", "Riot Guard")
TDS:SetOption(9, "Unit 2", "Riot Guard")
TDS:SetOption(9, "Unit 3", "Riot Guard")

TDS:Place("Mercenary Base", -10.27208423614502, 0.9786126613616943, 34.0124626159668)
TDS:UpgradeTimes(10, 4)
TDS:SetOption(10, "Unit 1", "Riot Guard")
TDS:SetOption(10, "Unit 2", "Riot Guard")
TDS:SetOption(10, "Unit 3", "Riot Guard")

TDS:Place("Mercenary Base", 6.9172163009643555, 4.923496246337891, -55.83564376831055)
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

TDS:Place("Turret", -10.826740264892578, 0.9946615695953369, 39.546382904052734)
TDS:Place("Turret", -14.627656936645508, 1.0145859718322754, 34.53520202636719)
TDS:Place("Turret", -16.601787567138672, 0.9641362428665161, 38.37455368041992)

for _ = 1, 5 do
    for _, index in ipairs({12, 13, 14}) do
        TDS:Upgrade(index)
    end
end

TDS:Ability(8, "Hologram Tower", {
    towerPosition = Vector3.new(0.06365537643432617, 5.061888694763184, -55.975379943847656),
    towerToClone = 6
}, true)
