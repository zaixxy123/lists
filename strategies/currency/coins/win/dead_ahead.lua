TDS:Loadout("Assassin", "Commander", "Militant", "None", "None")

TDS:Mode("Casual")

TDS:GameInfo("Dead Ahead", {})

TDS:VoteSkip()

TDS:Place("Assassin", -3.1667275428771973, 0.949934184551239, -37.087467193603516, true)
TDS:Ready()
TDS:Place("Assassin", -2.214543104171753, 0.9499425888061523, -37.248191833496094, true)


TDS:Place("Assassin", -1.1661293506622314, 0.9499517679214478, -37.392147064208984, true)
TDS:Place("Assassin", -4.288345813751221, 0.9499242901802063, -36.90526580810547, true)

TDS:Upgrade(3)

TDS:Upgrade(2)
TDS:Upgrade(4)
TDS:Upgrade(1)

TDS:Upgrade(4)
TDS:Upgrade(1)

TDS:Upgrade(2)
TDS:Upgrade(3)

TDS:Upgrade(1)

TDS:Upgrade(2)

TDS:Upgrade(3)
TDS:Upgrade(4)

TDS:Place("Commander", -0.010107040405273438, 1.0200042724609375, -30.603683471679688, true)
TDS:Upgrade(5)

TDS:Upgrade(1)

TDS:Upgrade(3)

TDS:Upgrade(4)

TDS:Upgrade(2)

TDS:Upgrade(5)

TDS:Place("Commander", -5.073753356933594, 1.0000050067901611, -30.602031707763672, true)
TDS:UpgradeTimes(6, 2)

TDS:Place("Commander", 1.1544551849365234, 1.0000044107437134, -27.19182014465332, true)
TDS:UpgradeTimes(7, 3)

for i = 1, 33 do
    local index = 7 + i

    TDS:Place("Militant", 1.2172317504882812, 1.0000039339065552, -23.948528289794922, true)
    TDS:UpgradeTimes(index, 4)
end
