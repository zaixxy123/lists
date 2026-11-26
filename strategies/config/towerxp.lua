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
                "Pyromancer"
            },
            RequireSelectedTower = true,
            Towers = {
                {Name = "Operator", GameName = "Operator"},
                {Name = "Juggernaut", GameName = "Juggernaut"},
                {Name = "Kingpin", GameName = "Kingpin"},
                {Name = "Enforcer", GameName = "Enforcer"},
                {Name = "Mecha Base", GameName = "MechaBase"}                
            }
        }
    },

    Strategy = "strategies/towerxp.lua",

    Matchmaking = {
        Difficulty = "Easy",
        Type = "hardcore"
    }
}
