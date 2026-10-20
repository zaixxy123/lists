TDS:Loadout("Assassin", "Commander", "Militant", "None", "None")

TDS:Mode("Casual")

TDS:GameInfo("Forgetten Docks", {})

TDS:VoteSkip()

TDS:Place("Assassin", -21.944828033447, 1.0249927043915, -26.497314453125, true)
TDS:Ready()
TDS:Place("Assassin", -21.944828033447, 1.0249927043915, -26.497314453125, true)


TDS:Place("Assassin", -21.944828033447, 1.0249927043915, -26.497314453125, true)
TDS:Place("Assassin", -21.944828033447, 1.0249927043915, -26.497314453125, true)

TDS:Upgrade(2)
TDS:Upgrade(1)

TDS:Upgrade(4)

TDS:Upgrade(3)
TDS:Upgrade(1)
TDS:Upgrade(2)
TDS:Upgrade(3)

TDS:Upgrade(4)

TDS:Upgrade(2)
TDS:Upgrade(1)
TDS:Upgrade(3)

TDS:Upgrade(4)

TDS:Place("Commander", -21.944828033447, 1.0249927043915, -26.497314453125, true)
TDS:UpgradeTimes(5, 2)

TDS:Upgrade(2)

TDS:Upgrade(3)
TDS:Upgrade(1)

TDS:Upgrade(4)

TDS:Place("Commander", -21.944828033447, 1.0249927043915, -26.497314453125, true)
TDS:Upgrade(5)
TDS:Upgrade(6)

TDS:Place("Commander", -21.944828033447, 1.0249927043915, -26.497314453125, true)
TDS:UpgradeTimes(7, 2)

TDS:Upgrade(6)

for i = 1, 33 do
    local index = 7 + i

    TDS:Place("Militant", -21.944828033447, 1.0249927043915, -26.497314453125, true)
    TDS:UpgradeTimes(index, 4)
end
