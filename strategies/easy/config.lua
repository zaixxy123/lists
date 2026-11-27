return {
    MatchTimeoutMinutes = 10,

    Lose = {
        CountLoseGameOver = true,
        MilestoneBehavior = "ReturnToLobby",
        Matchmaking = {Difficulty = "Easy", Type = "survival"},
        RequiredTowers = {"Scout"},
        Priority = {
            "Meltdown",
            "Simplicity",
            "Stained Temple",
            "Midnight Issue",
            "Spring Fever"
        },
        Maps = {
            ["Meltdown"] = "strategies/easy/lose/meltdown.lua",
            ["Simplicity"] = "strategies/easy/lose/simplicity.lua",
            ["Stained Temple"] = "strategies/easy/lose/stained_temple.lua",
            ["Midnight Issue"] = "strategies/easy/lose/midnight_issue.lua",
            ["Spring Fever"] = "strategies/easy/lose/spring_fever.lua"
        }
    }
}
