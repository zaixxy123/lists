TDS:Loadout("Assassin", "Commander", "Militant", "None", "None")

TDS:Mode("Casual")

TDS:GameInfo("Lay By", {})

TDS:VoteSkip()

TDS:Place("Assassin", -2.5642409324645996, 242.99998474121094, 275.3299560546875, true)
TDS:Ready()
TDS:Place("Assassin", 2.6457643508911133, 242.99998474121094, 275.5246276855469, true)

TDS:Place("Assassin", 3.0177059173583984, 242.99998474121094, 276.8733215332031, true)
TDS:Place("Assassin", -2.9678006172180176, 242.99998474121094, 277.3135070800781, true)

TDS:Upgrade(4)
TDS:Upgrade(2)

TDS:Upgrade(2)
TDS:Upgrade(1)

TDS:Upgrade(4)
TDS:UpgradeTimes(3, 2)

TDS:Upgrade(1)

TDS:Upgrade(3)

TDS:Upgrade(4)

TDS:Upgrade(1)
TDS:Upgrade(2)

TDS:Place("Commander", -3.45857572555542, 242.99998474121094, 272.7825622558594, true)
TDS:Upgrade(5)

TDS:Upgrade(4)

TDS:Upgrade(3)

TDS:Upgrade(2)

TDS:Upgrade(1)

TDS:Upgrade(5)

TDS:Place("Commander", -2.720187187194824, 242.99998474121094, 271.6778564453125, true)

TDS:UpgradeTimes(6, 2)

TDS:Place("Commander", -4.476716995239258, 242.99998474121094, 271.7225036621094, true)
TDS:UpgradeTimes(7, 3)

for i = 1, 33 do
    local index = 7 + i

    TDS:Place("Militant", 2.976705551147461, 242.99998474121094, 271.5433654785156, true)
    TDS:UpgradeTimes(index, 4)
end
