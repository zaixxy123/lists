-- Tower ownership / prices / per-tower GrindRules. 
-- FarmBehavior can live inside each GrindRules entry. 
 
return { 
    FarmRoutes = { 
        Gems = {Route = "Hardcore", FarmBehavior = "RepeatUntilAffordable"}, 
        Coins = {Route = "Fallen.Late", FarmBehavior = "RepeatUntilAffordable"} 
    }, 
 
    Automation = { 
        AutoChain = { 
            Tower = "Commander", 
            MinUpgrade = 2, 
            Ability = "Call Of Arms", 
            Interval = 10.5, 
            Cooldown = 30 
        }, 
        AutoDJ = { 
            Tower = "DJ Booth", 
            MinUpgrade = 3, 
            Ability = "Drop The Beat", 
            Interval = 1 
        }, 
        Mercenary = { 
            Tower = "Mercenary Base", 
            MinUpgrade = 5, 
            Ability = "Air-Drop", 
            Interval = 0.5 
        } 
    }, 
 
    DisplayPriority = { 
        "Engineer", 
        "Brawler", 
        "Accelerator", 
        "Hacker", 
        "Necromancer", 
        "Turret", 
        "Mercenary Base", 
        "DJ Booth", 
        "Commander", 
        "Tesla", 
        "Mortar", 
        "Minigunner", 
        "Ranger", 
        "Hunter", 
        "Rocketeer", 
        "Crook Boss", 
        "Trapper", 
        "Shotgunner", 
        "Electroshocker", 
        "Pyromancer", 
        "Medic", 
        "Assassin", 
        "Farm", 
        "Ace Pilot", 
        "Freezer", 
        "Military Base", 
        "Militant", 
        "Paintballer", 
        "Slime Trooper",
        "Pulse Trooper",
        "Scout", 
        "Soldier", 
        "Boomerang", 
        "Sniper", 
        "Demoman", 
        "Pursuit",                 
        "Gatling Gun" 
    }, 
 
    Priority = { 
        "Engineer", 
        "Brawler", 
        "Accelerator", 
        "Hacker", 
        "Necromancer", 
        "DJ Booth", 
        "Commander", 
        "Tesla", 
        "Minigunner", 
        "Ranger", 
        "Hunter", 
        "Rocketeer", 
        "Trapper", 
        "Shotgunner", 
        "Electroshocker", 
        "Pyromancer", 
        "Medic", 
        "Assassin", 
        "Farm", 
        "Ace Pilot", 
        "Freezer", 
        "Military Base", 
        "Militant", 
        "Paintballer", 
        "Slime Trooper",
        "Pulse Trooper",
        "Scout", 
        "Soldier", 
        "Boomerang", 
        "Sniper", 
        "Demoman", 
        "Pursuit", 
        "Gatling Gun" 
    }, 
 
    GoldenTowers = { 
        "Soldier", 
        "Demoman", 
        "Scout", 
        "Crook Boss", 
        "Pyromancer", 
        "Minigunner"
    }, 
 
    Info = { 
        ["Engineer"] = {Type = "Currency", Currency = "Gems", Price = 4500, Level = 50}, 
        ["Brawler"] = {Type = "Currency", Currency = "Gems", Price = 1250, Level = 50}, 
        ["Accelerator"] = {Type = "Currency", Currency = "Gems", Price = 2500, Level = 50}, 
        ["Hacker"] = { 
            Type = "Currency", 
            Currency = "Gems", 
            Price = 5500, 
            Level = 50, 
            GrindRules = { 
                {MinLevel = 175, Route = "Hardcore", FarmBehavior = "RepeatUntilAffordable"} 
            } 
        }, 
        ["Necromancer"] = {Type = "Currency", Currency = "Gems", Price = 2250, Level = 50}, 
        ["Turret"] = {Type = "Level", Level = 50}, 
        ["Mercenary Base"] = {Type = "Level", Level = 150}, 
        ["Pursuit"] = {Type = "Currency", Currency = "Coins", Price = 15000, Level = 100}, 
        ["DJ Booth"] = { 
            Type = "Currency", 
            Currency = "Coins", 
            Price = 5000, 
            GrindRules = { 
                {ProgressionMode = "AutoMax", MinLevel = 175, Route = "Fallen.Starter", FarmBehavior = "RepeatUntilAffordable"}, 
            } 
        }, 
        ["Commander"] = { 
            Type = "Currency", 
            Currency = "Coins", 
            Price = 4000, 
            GrindRules = { 
                {ProgressionMode = "Win", Route = "Easy.Win", FarmBehavior = "RepeatUntilAffordable"}, 
            } 
        }, 
        ["Tesla"] = {Type = "Currency", Currency = "Coins", Price = 6000}, 
        ["Mortar"] = {Type = "Level", Level = 75}, 
        ["Minigunner"] = {Type = "Currency", Currency = "Coins", Price = 8000}, 
        ["Ranger"] = {Type = "Currency", Currency = "Coins", Price = 12000}, 
        ["Gatling Gun"] = { 
            Type = "Currency", 
            Currency = "Coins", 
            Price = 35000, 
            Level = 175, 
            GrindRules = { 
                {MinLevel = 175, Route = "Molten", FarmBehavior = "RepeatUntilAffordable"} 
            } 
        }, 
        ["Hunter"] = { 
            Type = "Currency", 
            Currency = "Coins", 
            Price = 1000, 
            GrindRules = { 
                {MinLevel = 50, MaxLevel = 174, Route = "Molten", FarmBehavior = "RepeatUntilAffordable"} 
            } 
        }, 
        ["Rocketeer"] = {Type = "Currency", Currency = "Coins", Price = 2500}, 
        ["Crook Boss"] = {Type = "Level", Level = 30}, 
        ["Trapper"] = { 
            Type = "Currency", 
            Currency = "Coins", 
            Price = 3000, 
            GrindRules = { 
                {ProgressionMode = "Win", Route = "Easy.Win", FarmBehavior = "RepeatUntilAffordable"}, 
                {ProgressionMode = "AutoMax", MinLevel = 175, Route = "Fallen.Starter", FarmBehavior = "RepeatUntilAffordable"}, 
            } 
        }, 
        ["Shotgunner"] = {Type = "Currency", Currency = "Coins", Price = 850}, 
        ["Electroshocker"] = {Type = "Currency", Currency = "Coins", Price = 2500}, 
        ["Pyromancer"] = { 
            Type = "Currency", 
            Currency = "Coins", 
            Price = 1250, 
            GrindRules = { 
                {MinLevel = 50, MaxLevel = 174, Route = "Molten", FarmBehavior = "RepeatUntilAffordable"} 
            } 
        }, 
        ["Medic"] = {Type = "Currency", Currency = "Coins", Price = 2000}, 
        ["Assassin"] = { 
            Type = "Currency", 
            Currency = "Coins", 
            Price = 800, 
            GrindRules = { 
                {ProgressionMode = "Win", Route = "Easy.Win", FarmBehavior = "RepeatUntilAffordable"}, 
            } 
        }, 
        ["Farm"] = {Type = "Currency", Currency = "Coins", Price = 2000}, 
        ["Ace Pilot"] = {Type = "Currency", Currency = "Coins", Price = 1500}, 
        ["Freezer"] = {Type = "Currency", Currency = "Coins", Price = 650}, 
        ["Military Base"] = {Type = "Currency", Currency = "Coins", Price = 4000}, 
        ["Militant"] = { 
            Type = "Currency", 
            Currency = "Coins", 
            Price = 800, 
            GrindRules = { 
                {ProgressionMode = "Win", Route = "Easy.Win", FarmBehavior = "RepeatUntilAffordable"}, 
            } 
        }, 
        ["Paintballer"] = {Type = "Currency", Currency = "Coins", Price = 100},
        ["Slime Trooper"] = {Type = "Currency", Currency = "Coins", Price = 300},
        ["Pulse Trooper"] = {Type = "Currency", Currency = "Coins", Price = 3250}, 
        ["Scout"] = {Type = "Free"}, 
        ["Soldier"] = { 
            Type = "Currency", 
            Currency = "Coins", 
            Price = 350, 
            GrindRules = { 
                {ProgressionMode = "Win", MaxLevel = 49, Route = "Easy.Starter", FarmBehavior = "RepeatUntilAffordable"}, 
                {ProgressionMode = "Lose", MaxLevel = 49, Route = "Easy.Lose", FarmBehavior = "RepeatUntilAffordable"}, 
                {ProgressionMode = "AutoMax", MaxLevel = 49, Route = "Easy.Lose", FarmBehavior = "RepeatUntilAffordable"}, 
                {ProgressionMode = "Win", MinLevel = 50, Route = "Easy.Starter", FarmBehavior = "RepeatUntilAffordable"}, 
                {ProgressionMode = "Lose", MinLevel = 50, Route = "Easy.Lose", FarmBehavior = "RepeatUntilAffordable"}, 
                {ProgressionMode = "AutoMax", MinLevel = 50, Route = "Easy.Lose", FarmBehavior = "RepeatUntilAffordable"} 
            } 
        }, 
        ["Boomerang"] = {Type = "Currency", Currency = "Coins", Price = 300}, 
        ["Sniper"] = {Type = "Free"}, 
        ["Demoman"] = {Type = "Currency", Currency = "Coins", Price = 200} 
    } 
}
