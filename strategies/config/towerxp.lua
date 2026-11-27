return {
    MinimumLevel = 50,

    Modes = {
        {
            Name = "All Normal Tower",
            GameName = "All Normal Tower",
            RequiredTowers = {
                "Pyromancer",
                "Shotgunner",
                "Minigunner",
                "Military Base"
            },
            LevelTowers = {
                "Military Base",
                "Scout",
                "Shotgunner",
                "Crook Boss",
                "Minigunner"
            },
            FarmTowers = {
                "Pyromancer",
                "Scout",
                "Shotgunner",
                "Crook Boss",
                "Minigunner",
                "Military Base"
            }
        },
        {
            Name = "Evolved Towers",
            RequiredTowers = {
                "Farm",
                "Crook Boss",
                "Boomerang"
            },
            RequireSelectedTower = true,
            Towers = {
                {Name = "Operator", GameName = "Operator", OwnedName = "EvolvedOperator"},
                {Name = "Juggernaut", GameName = "Juggernaut", OwnedName = "EvolvedJuggernaut"},
                {Name = "Kingpin", GameName = "Kingpin", OwnedName = "EvolvedKingpin"},
                {Name = "Enforcer", GameName = "Enforcer", OwnedName = "EvolvedEnforcer"},
                {Name = "Mecha Base", GameName = "MechaBase", OwnedName = "EvolvedMechaBase"}                
            }
        }
    },

    Strategy = "strategies/towerxp.lua",

    Matchmaking = {
        Difficulty = "Easy",
        Type = "hardcore"
    }
}
