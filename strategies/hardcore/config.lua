-- Hardcore route configuration.
-- Edit matchmaking, required towers, map priority, and map strategy paths here.

return {
    MatchTimeoutMinutes = 10,

    CountLoseGameOver = true,
    MilestoneBehavior = "ReturnToLobby",

        Matchmaking = {Difficulty = "Easy", Type = "hardcore", ExpectedDifficulty = "Hardcore"},
        RequiredTowers = {"Pyromancer"},
        Priority = {
            "Wretched Front"
        },
        Maps = {
            ["Wretched Front"] = "strategies/hardcore/wretched_front.lua"
        }
    }
