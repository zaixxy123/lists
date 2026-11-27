local loadAutoGatling = getgenv().LoadAutoGatling

if type(loadAutoGatling) == "function" then
    task.spawn(loadAutoGatling)
end

TDS:Loadout("Hacker", "Gatling Gun", "Mercenary Base", "Turret", "Soldier")

TDS:Mode("Fallen")
TDS:GameInfo("Retro The Heights")

TDS:Mercenary(170, 1)
TDS:VoteSkip(1,35)

TDS:Place("Soldier", -4.836522579193115, 1.0625, 21.939407348632812)
TDS:Ready()

TDS:Place("Soldier", -5.317983150482178, 1.0625, 18.86607551574707)
TDS:Place("Soldier", -7.853852272033691, 1.0625, 22.145492553710938)
TDS:Place("Soldier", -8.482381820678711, 1.0625, 19.16222381591797)
TDS:Place("Soldier", -11.180962562561035, 1.0625, 20.678234100341797)

for _ = 1, 2 do
    for _, index in ipairs({1, 2, 3, 4, 5}) do
        TDS:Upgrade(index)
    end
end

TDS:Place("Gatling Gun", 5.669826507568359, 13.0625, -2.3221545219421387)
TDS:UpgradeTimes(6, 2)

TDS:Place("Hacker", -11.041790008544922, 1.0625, 17.547027587890625)
TDS:Place("Hacker", -1.2339503765106201, 0.5625, 6.440350532531738)

TDS:UpgradeTimes(8, 2)
TDS:UpgradeTimes(7, 2)

TDS:Place("Mercenary Base", 1.8904731273651123, 1.0625, -1.8880605697631836)
TDS:UpgradeTimes(9, 4)
TDS:SetOption(9, "Unit 1", "Riot Guard")
TDS:SetOption(9, "Unit 2", "Riot Guard")
TDS:SetOption(9, "Unit 3", "Riot Guard")

TDS:Place("Mercenary Base", -12.862737655639648, 1.5625, -29.083538055419922)
TDS:UpgradeTimes(10, 4)
TDS:SetOption(10, "Unit 1", "Riot Guard")
TDS:SetOption(10, "Unit 2", "Riot Guard")
TDS:SetOption(10, "Unit 3", "Riot Guard")

TDS:Place("Mercenary Base", -8.21942138671875, 1.5625, -29.443496704101562)
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

TDS:Place("Turret", -2.6902427673339844, 1.0625, -1.590471863746643)
TDS:Place("Turret", 1.0805344581604004, 4.1875, -4.935225009918213)
TDS:Place("Turret", -3.0669479370117188, 4.9375, -5.590219020843506)

for _ = 1, 5 do
    for _, index in ipairs({12, 13, 14}) do
        TDS:Upgrade(index)
    end
end

TDS:Ability(8, "Hologram Tower", {
    towerPosition = Vector3.new(7.185040473937988, 13.0625, 2.788970470428467),
    towerToClone = 6
}, true)
