return {
    MatchTimeoutMinutes = 10,

    Starter = {
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
            ["Meltdown"] = "strategies/easy/starter/meltdown.lua",
            ["Simplicity"] = "strategies/easy/starter/simplicity.lua",
            ["Stained Temple"] = "strategies/easy/starter/stained_temple.lua",
            ["Midnight Issue"] = "strategies/easy/starter/midnight_issue.lua",
            ["Spring Fever"] = "strategies/easy/starter/spring_fever.lua"
        }
    },

    Win = {
        Matchmaking = {Difficulty = "Easy", Type = "survival"},
        RequiredTowers = {"Soldier"},
        Priority = {
            "Black Spot Exchange",
            "Dead Ahea",
            "Lay By",
            "Construction Crazy",
            "The Heights",
            "Retro The Heights",
            "Forgetten Docks",
            "Winter Abyss"
        },
        Maps = {
            ["Black Spot Exchange"] = "strategies/easy/win/black_spot_exchange.lua",
            ["Dead Ahea"] = "strategies/easy/win/dead_ahead.lua",
            ["Lay By"] = "strategies/easy/win/lay_by.lua",
            ["Construction Crazy"] = "strategies/easy/win/construction_crazy.lua",
            ["The Heights"] = "strategies/easy/win/the_heights.lua",
            ["Retro The Heights"] = "strategies/easy/win/retro_the_heights.lua",
            ["Forgetten Docks"] = "strategies/easy/win/forgetten_docks.lua",
            ["Winter Abyss"] = "strategies/easy/win/winter_abyss.lua"
        }
    },

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
