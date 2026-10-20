-- Molten route configuration.
-- Edit matchmaking, required towers, map priority, and map strategy paths here.

return {
    MatchTimeoutMinutes = 15,
    MilestoneBehavior = "ReturnToLobby",

    CountLoseGameOver = true,

        Matchmaking = {Difficulty = "Molten", Type = "survival"},
        RequiredTowers = {"Soldier"},
        Priority = {
            "Midnight Issue",
            "Lighthaos",
            "Wrecked Battlefield II",
            "Nether"
        },
        Maps = {
            ["Wrecked Battlefield II"] = "strategies/molten/wrecked_battlefield_ii.lua",
            ["Lighthaos"] = "strategies/molten/lighthaos.lua",
            ["Midnight Issue"] = "strategies/molten/midnight_issue.lua",
            ["Nether"] = "strategies/molten/nether.lua"
        }
    }
