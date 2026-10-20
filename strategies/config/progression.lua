return {
    MatchTimeoutMinutes = 15,
    GameOverStuckMinutes = 5,

    AutoFarmUntilGatling = {
        TargetTower = "Gatling Gun",

        Win = {
            RoutePriority = {
                "Casual",
                "Easy.Win",
                "Easy.Starter"
            }
        },

        Lose = {
            GrindRules = {
                {
                    MaxLevel = 14,
                    Route = "Easy.Lose",
                    TargetLevel = 15
                },
                {
                    MinLevel = 15,
                    MaxLevel = 49,
                    Route = "Molten",
                    TargetLevel = 50
                },
                {
                    MinLevel = 50,
                    MaxLevel = 174,
                    Route = "Hardcore",
                    TargetLevel = 175,
                    RequiredCoins = 35000,
                    CoinFarmRoute = "Molten"
                },
                {
                    MinLevel = 175,
                    Route = "Molten"
                }
            }
        }
    },

    AutoBuyAllTowers = {
        Win = {
            UseWinRoutePriority = true,
            GemRoute = "Hardcore"
        },

        Lose = {
            CoinRoute = "Molten",
            GemRoute = "Hardcore"
        }
    },

    AutoMaxAccount = {
        TowerCoinStep = 10000,

        Trial = {
            Enabled = true,
            TrialCurrency = "Timescale Ticket",

            RequiredTowers = {
                "Gatling Gun",
                "Militant"
            },

            SupportedTrials = {
                Explodin = "ExplodingEnemie",
                Fo = "Fo",
                Hidde = "HiddenEnemie",
                Limitatio = "Limitatio",
                Quarantin = "Quarantin"
            },

            Strategies = {
                Exploding = "strategies/currency/premium/timescale_ticket/exploding.lua",
                Hidden = "strategies/currency/premium/timescale_ticket/hidden.lua",
                Quarantine = "strategies/currency/premium/timescale_ticket/quarantine.lua",
                Fog = "strategies/currency/premium/timescale_ticket/fog.lua",
                Limitation = "strategies/currency/premium/timescale_ticket/limitation.lua"
            },

            Rotation = {
                Duration = 3 * 60 * 60,
                AnchorTime = DateTime.fromUniversalTime(
                    2026,
                    9,
                    29,
                    12,
                    0,
                    0
                ).UnixTimestamp,

                Trials = {
                    "Exploding",
                    "Inflation",
                    "Committed",
                    "Hidden",
                    "Broken",
                    "Healthy",
                    "Speedies",
                    "Glass",
                    "Quarantine",
                    "Fog",
                    "Limitation",
                    "Flying",
                    "Jailed"
                }
            },

            FallbackRoute = "LateGrind"
        },

        GrindRules = {
            {
                MaxLevel = 14,
                Route = "Easy.Lose",
                TargetLevel = 15
            },
            {
                MinLevel = 15,
                MaxLevel = 49,
                Route = "Molten",
                TargetLevel = 50
            },
            {
                MinLevel = 50,
                MaxLevel = 174,
                Route = "Hardcore",
                TargetLevel = 175,
                RequiredCoins = 35000,
                CoinFarmRoute = "Molten"
            },
            {
                MinLevel = 175,
                Route = "LateGrind"
            }
        }
    }
}
