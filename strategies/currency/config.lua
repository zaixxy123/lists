-- Currency farm configuration.
-- Coins Win uses Casual strategies.
-- Coins Lose uses Molten strategies.
-- Gems Lose uses Hardcore strategies.

return {
    Coins = {
        Win = {
            RouteKey = "Currency.Coins.Win",
            MinimumLevel = 0,
            MatchTimeoutMinutes = 15,
            GameOverAction = "Rematch",
            Matchmaking = {
                Difficulty = "Casual",
                Type = "survival"
            },
            RequiredTowers = {
                "Militant",
                "Commander",
                "Assassin"
            },
            Priority = {
                "Lay By",
                "Dead Ahead",
                "ason Arch",
                "Black Spot Exchange",
                "Construction Crazy",
                "Forgetten Docks"
            },
            Maps = {
                ["ason Arch"] =
                    "strategies/currency/coins/win/mason_arch.lua",

                ["Dead Ahead"] =
                    "strategies/currency/coins/win/dead_ahead.lua",

                ["Lay By"] =
                    "strategies/currency/coins/win/lay_by.lua",

                ["Black Spot Exchange"] =
                    "strategies/currency/coins/win/black_spot_exchange.lua",

                ["Construction Crazy"] =
                    "strategies/currency/coins/win/construction_crazy.lua",

                ["Forgetten Docks"] =
                    "strategies/currency/coins/win/forgetten_docks.lua"
            }
        },

        Lose = {
            RouteKey = "Currency.Coins.Lose",
            MinimumLevel = 0,
            MatchTimeoutMinutes = 15,
            CountLoseGameOver = true,
            GameOverAction = "Restart",

            Matchmaking = {
                Difficulty = "Molten",
                Type = "survival"
            },

            RequiredTowers = {
                "Soldier"
            },

            Priority = {
                "Wrecked Battlefield II",
                "Lighthaos",
                "Midnight Issue",
                "Nether"
            },

            Maps = {
                ["Wrecked Battlefield II"] =
                    "strategies/currency/coins/lose/wrecked_battlefield_ii.lua",

                ["Lighthaos"] =
                    "strategies/currency/coins/lose/lighthaos.lua",

                ["Midnight Issue"] =
                    "strategies/currency/coins/lose/midnight_issue.lua",

                ["Nether"] =
                    "strategies/currency/coins/lose/nether.lua"
            }
        }
    },

    Gems = {
        Lose = {
            RouteKey = "Currency.Gems.Lose",
            MinimumLevel = 50,
            MatchTimeoutMinutes = 10,
            CountLoseGameOver = true,
            GameOverAction = "Restart",

            Matchmaking = {
                Difficulty = "Easy",
                Type = "hardcore",
                ExpectedDifficulty = "Hardcore"
            },

            RequiredTowers = {
                "Boomerang",
                "Farm",
                "Shotgunner"
            },

            Priority = {
                "Wretched Front"
            },

            Maps = {
                ["Wretched Front"] =
                    "strategies/currency/gems/lose/wretched_front.lua"
            }
        }
    }
}
