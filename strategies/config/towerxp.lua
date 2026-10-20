return {
    MinimumLevel = 50,

    Modes = {
        {
            Name = "All Normal Tower",
            GameName = "All Normal Tower",
            RequiredTowers = {
                "Pyromancer",
                "Shotgunner",
                "Minigunner"
            },
            FarmTowers = {
                "Pyromancer",
                "Scout",
                "Shotgunner",
                "Crook Boss",
                "Minigunner"
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
                {Name = "Enforcer", GameName = "Enforcer"}
            }
        }
    },

    Strategy = "strategies/towerxp.lua",

    Matchmaking = {
        Difficulty = "Easy",
        Type = "hardcore"
    }
}
