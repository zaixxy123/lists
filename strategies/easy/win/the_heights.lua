TDS:Loadout("Soldier", "None", "None", "None", "None")

TDS:Mode("Easy")
TDS:GameInfo("The Heights")

TDS:VoteSkip()

TDS:Place("Soldier", -11.751822471619, 1.4870854616165, 18.233583450317, true) --1
TDS:Ready()

TDS:Place("Soldier", -11.751822471619, 1.4870854616165, 18.233583450317, true) --2
TDS:Place("Soldier", -11.751822471619, 1.4870854616165, 18.233583450317, true) --3
TDS:Place("Soldier", -11.751822471619, 1.4870854616165, 18.233583450317, true) --4
TDS:Place("Soldier", -11.751822471619, 1.4870854616165, 18.233583450317, true) --5
TDS:Place("Soldier", -11.751822471619, 1.4870854616165, 18.233583450317, true) --6

for _ = 1, 3 do
    for index = 1, 6 do
        TDS:Upgrade(index)
    end
end

TDS:Place("Soldier", -11.751822471619, 1.4870854616165, 18.233583450317, true) --7
TDS:Place("Soldier", -11.751822471619, 1.4870854616165, 18.233583450317, true) --8
TDS:Place("Soldier", -11.751822471619, 1.4870854616165, 18.233583450317, true) --9
TDS:Place("Soldier", -11.751822471619, 1.4870854616165, 18.233583450317, true) --10
TDS:Place("Soldier", -11.751822471619, 1.4870854616165, 18.233583450317, true) --11
TDS:Place("Soldier", -11.751822471619, 1.4870854616165, 18.233583450317, true) --12

for _ = 1, 3 do
    for index = 7, 12 do
        TDS:Upgrade(index)
    end
end

for index = 1, 12 do
    TDS:Upgrade(index)
end
