TDS:Loadout("Assassin", "Commander", "Militant", "None", "None")

TDS:Mode("Casual")

TDS:GameInfo("Construction Crazy", {})

TDS:VoteSkip()

TDS:Place("Assassin", 2.0906622409821, 0.50500327348709, -23.925266265869, true)
TDS:Ready()
TDS:Place("Assassin", 2.0906622409821, 0.50500327348709, -23.925266265869, true)


TDS:Place("Assassin", 2.0906622409821, 0.50500327348709, -23.925266265869, true)
TDS:Place("Assassin", 2.0906622409821, 0.50500327348709, -23.925266265869, true)

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

TDS:Place("Commander", 2.0906622409821, 0.50500327348709, -23.925266265869, true)
TDS:UpgradeTimes(5, 2)

TDS:Upgrade(2)

TDS:Upgrade(3)
TDS:Upgrade(1)

TDS:Upgrade(4)

TDS:Place("Commander", 2.0906622409821, 0.50500327348709, -23.925266265869, true)
TDS:Upgrade(5)
TDS:Upgrade(6)

TDS:Place("Commander", 2.0906622409821, 0.50500327348709, -23.925266265869, true)
TDS:UpgradeTimes(7, 2)

TDS:Upgrade(6)

for i = 1, 33 do
    local index = 7 + i

    TDS:Place("Militant", 2.0906622409821, 0.50500327348709, -23.925266265869, true)
    TDS:UpgradeTimes(index, 4)
end
