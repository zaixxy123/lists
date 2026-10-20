-- Premium Currency Farm configuration.
-- Coins reuses the shared Fallen Late route.

return {
    Coins = {
        ComingSoon = false,
        Description = "Better rewards if modifiers owned",
        RouteKey = "PremiumCurrency.Coins",
        RouteConfigPath = "strategies/fallen/late/config.lua",
        GameOverAction = "Rematch",

        SupportedModifiersTrials = {
            "HiddenEnemies",
            "ExplodingEnemies",
            "Limitation",
            "Committed",
            "Quarantine",
            "Fog"
        },

        Requirements = {
            MinimumLevel = 175,
            RequiredTowers = {
                "Hacker",
                "Gatling Gun",
                "Mercenary Base",
                "Trapper",
                "DJ Booth"
            }
        }
    },

    ComingSoon = {
        ComingSoon = true
    }
}
