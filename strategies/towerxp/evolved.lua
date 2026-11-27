return function(TDS, selectedTower)
    local EvolvedLoadoutNames = {
        Operator = "EvolvedOperator",
        Juggernaut = "EvolvedJuggernaut",
        Kingpin = "EvolvedKingpin",
        Enforcer = "EvolvedEnforcer"
        Mecha Base = "EvolvedMechaBase"
    }

    local loadoutTower =
        EvolvedLoadoutNames[selectedTower]
        or selectedTower
TDS:Loadout("Farm", "Crook Boss", "Boomerang", "None", "None")
TDS:Mode("Hardcore")
TDS:GameInfo("Wretched Front")
TDS:VoteSkip()
TDS:Place("Farm", -22.772180557250977, 1.2029237747192383, 38.20994186401367)
TDS:Place("Farm", -19.241132736206055, 1.2686461210250854, 37.958343505859375)
TDS:Place("Farm", -15.702499389648438, 1.3142043352127075, 37.8599853515625)
TDS:Ready()
TDS:Upgrade(3)

-- [ Wave 1 ] --
TDS:Upgrade(2)
TDS:Upgrade(1)

-- [ Wave 2 ] --
TDS:Place("Farm", -15.347397804260254, 1.143251895904541, 41.38209915161133)
TDS:Upgrade(4)
TDS:Place("Farm", -18.886030197143555, 1.0711784362792969, 41.48048782348633)
TDS:Upgrade(5)

-- [ Wave 3 ] --
TDS:Place("Boomerang", 8.523313522338867, 1.198412299156189, 21.33551025390625)
TDS:Upgrade(6)

-- [ Wave 4 ] --
TDS:Upgrade(6)
TDS:Place("Farm", -22.843412399291992, 1.3251686096191406, 34.670658111572266)

-- [ Wave 5 ] --
TDS:Place("Farm", -19.3388614654541, 1.438270092010498, 34.35319519042969)
TDS:Place("Farm", -15.798861503601074, 1.4888696670532227, 34.35319519042969)
TDS:Upgrade(9)
TDS:Upgrade(8)
TDS:Upgrade(7)

-- [ Wave 6 ] --
TDS:Place("Farm", -23.128725051879883, 1.3766053915023804, 31.142173767089844)
TDS:Place("Farm", -19.60313606262207, 1.420602798461914, 30.823074340820312)
TDS:Upgrade(11)
TDS:Upgrade(10)

-- [ Wave 7 ] --
TDS:Upgrade(4)
TDS:Upgrade(5)
TDS:Upgrade(3)
TDS:Upgrade(2)

-- [ Wave 8 ] --
TDS:Upgrade(1)
TDS:Upgrade(9)
TDS:Upgrade(8)
TDS:Upgrade(7)

-- [ Wave 9 ] --
TDS:Upgrade(10)
TDS:Upgrade(11)

-- [ Wave 10 ] --
TDS:Upgrade(6)
TDS:Upgrade(5)
TDS:Upgrade(4)

-- [ Wave 11 ] --
TDS:Upgrade(3)
TDS:Upgrade(2)
TDS:Upgrade(1)

-- [ Wave 12 ] --
TDS:Place("Crook Boss", 6.4031877517700195, 1.3892862796783447, 27.751800537109375)
TDS:Upgrade(12)

-- [ Wave 13 ] --
TDS:Upgrade(12)
TDS:Upgrade(9)
TDS:Upgrade(8)

-- [ Wave 14 ] --
TDS:Upgrade(7)
TDS:Upgrade(11)
TDS:Upgrade(10)

-- [ Wave 15 ] --
TDS:Place("Crook Boss", 3.3631725311279297, 1.4182806015014648, 27.75180435180664)
TDS:Upgrade(13)
TDS:Upgrade(13)

-- [ Wave 16 ] --
TDS:Upgrade(6)
TDS:Place("Boomerang", 5.489218711853027, 1.2484045028686523, 21.524932861328125)
TDS:Upgrade(14)
TDS:Upgrade(14)

-- [ Wave 17 ] --
TDS:Upgrade(14)

-- [ Wave 18 ] --
TDS:Upgrade(14)
TDS:Place("Crook Boss", 6.4031877517700195, 1.3774346113204956, 30.79180145263672)
TDS:Upgrade(15)

-- [ Wave 19 ] --
TDS:Upgrade(15)
TDS:Place("Crook Boss", 11.63474178314209, 1.3015732765197754, 23.539325714111328)
TDS:Upgrade(16)
TDS:Upgrade(16)

-- [ Wave 20 ] --
TDS:Place("Crook Boss", 11.63474178314209, 1.2636150121688843, 26.579326629638672)
TDS:Upgrade(17)
TDS:Upgrade(17)

-- [ Wave 22 ] --
TDS:Upgrade(12)
TDS:Place(loadoutTower, -4.1622934341430664, 1.492003321647644, 29.184486389160156)

    return true
end
