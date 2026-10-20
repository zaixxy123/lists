-- Frost route configuration.
-- Edit matchmaking, required towers, map priority, and map strategy paths here.

return {
    MatchTimeoutMinutes = 20,

        Matchmaking = {Difficulty = "Frost", Type = "survival"},
        RequiredTowers = {
            "Trapper",
            "Hacker",
            "Gatling Gun",
            "Mercenary Base",
            "DJ Booth"
        },
        Priority = {
            "Lay By",
            "Dead Ahead",
            "Retro The Heights",
            "Construction Crazy",
            "Forgetten Docks",
            "Winter Abyss",
            "The Heights"
        },
        Maps = {
            ["Lay By"] = "strategies/frost/lay_by.lua",
            ["Dead Ahead"] = "strategies/frost/dead_ahead.lua",
            ["Retro The Heights"] = "strategies/frost/retro_the_heights.lua",
            ["Construction Crazy"] = "strategies/frost/construction_crazy.lua",
            ["Forgetten Docks"] = "strategies/frost/forgetten_docks.lua",
            ["Winter Abyss"] = "strategies/frost/winter_abyss.lua",
            ["The Heights"] = "strategies/frost/the_heights.lua"
        }
    }
