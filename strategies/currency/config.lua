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
                "Midnight Issue",
                "Farm Lands",
                "Lighthaos",
                "Nether"
            },

            Maps = {
                ["Farm Lands"] =
                    "strategies/molten/farm_lands.lua",

                ["Lighthaos"] =
                    "strategies/molten/lighthaos.lua",

                ["Midnight Issue"] =
                    "strategies/molten/midnight_issue.lua",

                ["Nether"] =
                    "strategies/molten/nether.lua"
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
