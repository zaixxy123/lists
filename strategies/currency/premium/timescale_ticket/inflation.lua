TDS:SetAutoMercenary(false)
TDS:Loadout("Gatling Gun", "Military Base", "Mercenary Base", "DJ Booth", "Hacker")
TDS:Mode("Trial")

TDS:Place("Military Base", 0.04381561279296875, 1.0063872337341309, 38.672733306884766, true)
TDS:Ready()

TDS:Place("Military Base", 0.04381561279296875, 1.0063872337341309, 38.672733306884766, true)
TDS:Place("Military Base", 0.04381561279296875, 1.0063872337341309, 38.672733306884766, true)
TDS:Place("Military Base", 0.04381561279296875, 1.0063872337341309, 38.672733306884766, true)
TDS:Place("Military Base", 0.04381561279296875, 1.0063872337341309, 38.672733306884766, true)

TDS:VoteSkip(8,10)
TDS:WaitForWave(10)

TDS:Sell(1)
TDS:Sell(2)
TDS:Sell(3)
TDS:Sell(4)
TDS:Sell(5)

TDS:Place("Gatling Gun", 0.04381561279296875, 1.0063872337341309, 38.672733306884766, true)
TDS:Upgrade(6)
TDS:Upgrade(6)

TDS:Place("Hacker", 10.484554290771484, 1.0449919700622559, -23.70001220703125, true)
TDS:Upgrade(7)
TDS:Upgrade(7)

TDS:Place("DJ Booth", 0.04381561279296875, 1.0063872337341309, 38.672733306884766, true)
TDS:SetOption(8, "Track", "Green")
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(8)

TDS:Upgrade(6)

TDS:Upgrade(8)
TDS:Upgrade(8)

TDS:Place("Mercenary Base", 0.04381561279296875, 1.0063872337341309, 38.672733306884766, true)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:SetOption(9, "Unit 1", "Riot Guard")
TDS:SetOption(9, "Unit 2", "Riot Guard")
TDS:SetOption(9, "Unit 3", "Riot Guard")

TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(6)

TDS:Upgrade(9)
TDS:Upgrade(9)

TDS:Place("Mercenary Base", 0.04381561279296875, 1.0063872337341309, 38.672733306884766, true)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:SetOption(10, "Unit 1", "Riot Guard")
TDS:SetOption(10, "Unit 2", "Riot Guard")
TDS:SetOption(10, "Unit 3", "Riot Guard")
TDS:Upgrade(10)
TDS:Upgrade(10)

TDS:Place("Mercenary Base", 0.04381561279296875, 1.0063872337341309, 38.672733306884766, true)
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:SetOption(11, "Unit 1", "Riot Guard")
TDS:SetOption(11, "Unit 2", "Riot Guard")
TDS:SetOption(11, "Unit 3", "Riot Guard")
TDS:Upgrade(11)
TDS:Upgrade(11)

TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(7, 2)

TDS:Ability(7, "Hologram Tower", {towerPosition = Vector3.new(0.04381561279296875, 26.0063872337341309, 38.672733306884766), towerToClone = 6}, true)
