-- Old Fallen strategy route, kept as the Starter variant.

return {
    MatchTimeoutMinutes = 20,
    DisableMatchTimeout = true,

    Matchmaking = {Difficulty = "Fallen", Type = "survival"},
    RequiredTowers = {
        "Hacker",
        "Gatling Gun",
        "Mercenary Base",
        "Turret",
        "Soldier"
    },
    Priority = {
        "Construction Crazy",
        "The Heights",
        "Retro The Heights",
        "Forgetten Docks"
    },
    Maps = {
        ["Construction Crazy"] = "strategies/fallen/starter/construction_crazy.lua",
        ["The Heights"] = "strategies/fallen/starter/the_heights.lua",
        ["Retro The Heights"] = "strategies/fallen/starter/retro_the_heights.lua",
        ["Forgetten Docks"] = "strategies/fallen/starter/forgetten_docks.lua"
    }
}
