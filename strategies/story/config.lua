-- Story route configuration.
-- Edit matchmaking, required towers, map priority, and map strategy paths here.

return {
        AutoDialog = {
            Character = "Commander",
            MarkerPath = {"Outfit", "CommanderCap1"},
            HoldExact = {
                "start by placing a scout.",
                "select the sniper tower."
            },
            HoldContainsAll = {
                {"demoman is built for crowds", "place him near the bend"}
            }
        },

        Order = {
            "Chapter0Mission1",
            "Chapter0Mission2",
            "Chapter0Mission3",
            "Chapter0Mission4"
        },

        Missions = {
            ["Chapter0Mission1"] = {
                Name = "Boot Camp",
                Strategy = "strategies/story/boot_camp.lua"
            },
            ["Chapter0Mission2"] = {
                Name = "Live Fire",
                Strategy = "strategies/story/live_fire.lua"
            },
            ["Chapter0Mission3"] = {
                Name = "Breach Protocol",
                Strategy = "strategies/story/breach_protocol.lua"
            },
            ["Chapter0Mission4"] = {
                Name = "Brute Force",
                Strategy = "strategies/story/brute_force.lua"
            }
        }
    }
