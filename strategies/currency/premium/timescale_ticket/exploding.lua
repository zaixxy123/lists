
TDS:Loadout("Hacker", "Gatling Gun", "Militant", "Mercenary Base", "DJ Booth")
TDS:Mode("Trial")

TDS:Place("Militant", -28.784940719604492, 1.316602110862732, 3.101461410522461)
TDS:Ready()

-- [ Wave 1 ] --
TDS:Upgrade(1)

-- [ Wave 2 ] --
TDS:Place("Militant", -26.141258239746094, 0.3087610602378845, 4.9499921798706055)

-- [ Wave 3 ] --
TDS:Upgrade(2)

-- [ Wave 4 ] --
TDS:Place("Militant", -25.113365173339844, 1.3115326166152954, 2.2666711807250977)
TDS:Upgrade(3)
TDS:Place("Militant", -22.594030380249023, 1.0001664161682129, 4.4240283966064453)
TDS:Upgrade(4)
-- [ Wave 7 ] --
TDS:VoteSkip(7)
TDS:WaitForWave(8)
TDS:Sell(4)
TDS:Sell(3)
TDS:Sell(2)
TDS:Sell(1)
-- [ Wave 8 ] --
TDS:VoteSkip(8)
TDS:Place("Gatling Gun", 7.659170627593994, 6.188790321350098, 4.290397644042969)

-- [ Wave 10 ] --
TDS:Upgrade(5)

-- [ Wave 12 ] --
TDS:Upgrade(5)
TDS:Place("Hacker", -29.40633201599121, 1.7333836555480957, 1.0365748405456543)

-- [ Wave 13 ] --
TDS:Upgrade(6)
TDS:Upgrade(6)

-- [ Wave 15 ] --
TDS:Upgrade(5)

-- [ Wave 16 ] --
TDS:Place("DJ Booth", 15.963162422180176, 0.19374820590019226, -2.297060012817383)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:SetOption(7, "Track", "Green")
TDS:Upgrade(7)

-- [ Wave 19 ] --
TDS:Upgrade(5)

-- [ Wave 22 ] --
TDS:Upgrade(5)

-- [ Wave 26 ] --
TDS:Upgrade(5)
TDS:Place("Mercenary Base", 7.183804512023926, -0.38346612453460693, 4.455516815185547)
TDS:Upgrade(8)
TDS:Upgrade(8)

-- [ Wave 27 ] --
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:SetOption(8, "Unit 1", "Riot Guard")
TDS:SetOption(8, "Unit 2", "Riot Guard")
TDS:SetOption(8, "Unit 3", "Riot Guard")

-- [ Wave 28 ] --
TDS:Upgrade(8)

-- [ Wave 29 ] --
TDS:Upgrade(8)
TDS:Upgrade(7)
TDS:Upgrade(7)

-- [ Wave 30 ] --
TDS:Place("Mercenary Base", 28.863632202148438, 0.337412029504776, -0.062221527099609375)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:SetOption(9, "Unit 1", "Riot Guard")
TDS:SetOption(9, "Unit 2", "Riot Guard")
TDS:SetOption(9, "Unit 3", "Riot Guard")
TDS:Upgrade(9)

-- [ Wave 31 ] --
TDS:Upgrade(9)
TDS:Place("Mercenary Base", 29.54591941833496, 0.5725586414337158, -5.457556247711182)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:Upgrade(10)

-- [ Wave 32 ] --
TDS:Upgrade(10)
TDS:SetOption(10, "Unit 1", "Riot Guard")
TDS:SetOption(10, "Unit 2", "Riot Guard")
TDS:SetOption(10, "Unit 3", "Riot Guard")
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:SetOption(7, "Track", "Red")
TDS:Upgrade(6)

TDS:Upgrade(6)
TDS:Upgrade(6, 2)

TDS:Ability(6, "Hologram Tower", {towerPosition = Vector3.new(14.319024085998535, 5.6378211975097656, 5.2474241256713867), towerToClone = 5}, true)

