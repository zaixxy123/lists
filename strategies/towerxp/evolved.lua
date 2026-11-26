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

TDS:Mode("Hardcore")
TDS:GameInfo("Wretched Front")
TDS:Loadout("Pyromancer", loadoutTower, "Crook Boss", "None", "None")
TDS:Ready()
TDS:VoteSkip()
TDS:UpgradeTimes(1, 3)

TDS:Place("Crook Boss", -1.011622428894043, 0.864983081817627, -25.070846557617188)
TDS:UpgradeTimes(2, 2)

TDS:Place("Crook Boss", 0.8714807033538818, 0.6851585507392883, -22.64225959777832)
TDS:UpgradeTimes(3, 2)

TDS:Place("Crook Boss", -2.1430044174194336, 0.6582517027854919, -22.24921989440918)
TDS:UpgradeTimes(4, 1)

    TDS:WaitForWave(20)
    TDS:Sell(1)

    TDS:Place(loadoutTower, -5.1009721755981445, -0.080512046813964844, -9.5659475326538086)

    return true
end
