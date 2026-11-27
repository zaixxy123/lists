-- Currency farm configuration.
-- Coins Lose uses Molten strategies.
-- Gems Lose uses Hardcore strategies.

return {
    Coins = {
        Lose = {
            RouteKey = "Currency.Coins.Lose",
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
                "Crook Boss"
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
