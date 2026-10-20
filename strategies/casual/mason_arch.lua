TDS:Loadout("Assassin", "Commander", "Militant", "None", "None")

TDS:Mode("Casual")

TDS:GameInfo("Mason Arch", {})

TDS:VoteSkip()

TDS:Place("Assassin", 6.0104241371155, 1.3999872207642, 53.039863586426, true)
TDS:Ready()
TDS:Place("Assassin", -6.0682649612427, 1.3999874591827, 52.996772766113, true)


TDS:Place("Assassin", 6.128547668457031, 1.3999871015548706, 53.052330017089844, true)
TDS:Place("Assassin", -6.0682649612427, 1.3999874591827, 52.996772766113, true)

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

TDS:Place("Commander", 6.0104241371155, 1.3999872207642, 53.039863586426, true)
TDS:UpgradeTimes(5, 2)

TDS:Upgrade(2)

TDS:Upgrade(3)
TDS:Upgrade(1)

TDS:Upgrade(4)

TDS:Place("Commander", 6.0104241371155, 1.3999872207642, 53.039863586426, true)
TDS:Upgrade(5)
TDS:Upgrade(6)

TDS:Place("Commander", 6.0104241371155, 1.3999872207642, 53.039863586426, true)
TDS:UpgradeTimes(7, 2)

TDS:Upgrade(6)

for i = 1, 33 do
    local index = 7 + i

    TDS:Place("Militant", 3.0453760623931885, 1.3999929428100586, 43.584354400634766, true)
    TDS:UpgradeTimes(index, 4)
end
