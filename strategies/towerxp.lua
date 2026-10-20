return function(TDS, selectedTower)
    selectedTower = tostring(selectedTower or "")

    if selectedTower == "" or selectedTower == "None" then
        return false
    end

    if selectedTower == "All Normal Tower" then
        TDS:Loadout("Pyromancer", "Scout", "Shotgunner", "Crook Boss", "Minigunner")

        TDS:Mode("Hardcore")
        TDS:GameInfo("Wretched Front")

        TDS:VoteSkip()

        TDS:Place("Pyromancer", -5.936307430267334, 0.9551397562026978, -31.831748962402344, true)
        TDS:Ready()
        TDS:UpgradeTimes(1, 3)

        TDS:Place("Crook Boss", -3.6180145740509033, 0.025390289723873138, -9.7833690643310547, true)
        TDS:UpgradeTimes(2, 2)

        TDS:Place("Crook Boss", -3.6180145740509033, 0.025390289723873138, -9.7833690643310547, true)
        TDS:UpgradeTimes(3, 2)

        TDS:Place("Crook Boss", -3.6180145740509033, 0.025390289723873138, -9.7833690643310547, true)
        TDS:UpgradeTimes(4, 2)

        TDS:Place("Scout", -3.6180145740509033, 0.025390289723873138, -9.7833690643310547, true)
        TDS:Place("Shotgunner", -3.6180145740509033, 0.025390289723873138, -9.7833690643310547, true)
        TDS:WaitForWave(22)
        TDS:Sell(1)
        TDS:Place("Minigunner", -3.6180145740509033, 0.025390289723873138, -9.7833690643310547, true)

        return true
    end

    local EvolvedLoadoutNames = {
        Operator = "EvolvedOperator",
        Juggernaut = "EvolvedJuggernaut",
        Kingpin = "EvolvedKingpin",
        Enforcer = "EvolvedEnforcer"
    }

    local loadoutTower =
        EvolvedLoadoutNames[selectedTower]
        or selectedTower

    TDS:Loadout("Pyromancer", loadoutTower, "Crook Boss", "None", "None")

    TDS:Mode("Hardcore")
    TDS:GameInfo("Wretched Front")

    TDS:VoteSkip()

    TDS:Place("Pyromancer", -5.936307430267334, 0.9551397562026978, -31.831748962402344, true)
    TDS:Ready()
    TDS:UpgradeTimes(1, 3)

    TDS:Place("Crook Boss", -3.6180145740509033, 0.025390289723873138, -9.7833690643310547, true)
    TDS:UpgradeTimes(2, 2)

    TDS:Place("Crook Boss", -3.6180145740509033, 0.025390289723873138, -9.7833690643310547, true)
    TDS:UpgradeTimes(3, 2)

    TDS:WaitForWave(20)
    TDS:Sell(1)

    TDS:Place(loadoutTower, -3.6180145740509033, 0.025390289723873138, -9.7833690643310547, true)

    return true
end
