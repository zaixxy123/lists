TDS:Loadout("Soldier", "None", "None", "None", "None")

TDS:Mode("Easy")
TDS:GameInfo("Forgetten Docks")

TDS:VoteSkip()

TDS:Place("Soldier", -22.275243759155, 1.0249885320663, -17.608728408813, true) --1
TDS:Ready()

TDS:Place("Soldier", -22.275243759155, 1.0249885320663, -17.608728408813, true) --2
TDS:Place("Soldier", -22.275243759155, 1.0249885320663, -17.608728408813, true) --3
TDS:Place("Soldier", -22.275243759155, 1.0249885320663, -17.608728408813, true) --4
TDS:Place("Soldier", -22.275243759155, 1.0249885320663, -17.608728408813, true) --5
TDS:Place("Soldier", -22.275243759155, 1.0249885320663, -17.608728408813, true) --6

for _ = 1, 3 do
    for index = 1, 6 do
        TDS:Upgrade(index)
    end
end

TDS:Place("Soldier", -22.275243759155, 1.0249885320663, -17.608728408813, true) --7
TDS:Place("Soldier", -22.275243759155, 1.0249885320663, -17.608728408813, true) --8
TDS:Place("Soldier", -22.275243759155, 1.0249885320663, -17.608728408813, true) --9
TDS:Place("Soldier", -22.275243759155, 1.0249885320663, -17.608728408813, true) --10
TDS:Place("Soldier", -22.275243759155, 1.0249885320663, -17.608728408813, true) --11
TDS:Place("Soldier", -22.275243759155, 1.0249885320663, -17.608728408813, true) --12

for _ = 1, 3 do
    for index = 7, 12 do
        TDS:Upgrade(index)
    end
end

for index = 1, 12 do
    TDS:Upgrade(index)
end
