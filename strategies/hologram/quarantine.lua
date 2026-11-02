
TDS:Loadout("Trapper", "Gatling Gun", "DJ Booth", "Hacker", "Mercenary Base")
TDS:VoteSkip(6,7)

TDS:Place("Trapper", 25.22615623474121094, 28.32441902160644531, -161.05668640136718750)
TDS:Ready()
TDS:Upgrade(1)

TDS:Place("Trapper", 31.89083099365234375, 27.62836837768554688, -149.83682250976562500)
TDS:Upgrade(2)

TDS:WaitForWave(7)
TDS:Sell(1)
TDS:Sell(2)

TDS:Place("Gatling Gun", 58.70062255859375, 31.89063262939453, -144.58897399902344)
TDS:Upgrade(3)
TDS:Upgrade(3)
TDS:Upgrade(3)

TDS:Place("DJ Booth", 53.41585922241211, 29.401355743408203, -147.61941528320312)
TDS:Upgrade(4)
TDS:Upgrade(4)
TDS:SetOption(4, "Track", "Green")
TDS:Upgrade(4)

TDS:Place("Hacker", 4.5379180908203125, 28.295516967773438, -153.99826049804688)
TDS:Upgrade(5)
TDS:Upgrade(5)

TDS:Upgrade(3)
TDS:Upgrade(3)
TDS:Upgrade(3)

TDS:Place("Mercenary Base", 56.57052230834961, 29.26028060913086, -141.11080932617188)
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:SetOption(6, "Unit 1", "Riot Guard")
TDS:SetOption(6, "Unit 2", "Riot Guard")
TDS:SetOption(6, "Unit 3", "Riot Guard")
TDS:Upgrade(6)
TDS:Upgrade(6)

TDS:Upgrade(4)
TDS:SetOption(4, "Track", "Red")
TDS:Upgrade(4)

TDS:Place("Mercenary Base", 82.37223815917969, 28.348222732543945, -166.8600616455078)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:SetOption(7, "Unit 1", "Riot Guard")
TDS:SetOption(7, "Unit 2", "Riot Guard")
TDS:SetOption(7, "Unit 3", "Riot Guard")
TDS:Upgrade(7)
TDS:Upgrade(7)

TDS:Place("Mercenary Base", 88.57913970947266, 28.331993103027344, -153.52879333496094)
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:SetOption(8, "Unit 1", "Riot Guard")
TDS:SetOption(8, "Unit 2", "Riot Guard")
TDS:SetOption(8, "Unit 3", "Riot Guard")
TDS:Upgrade(8)
TDS:Upgrade(8)

TDS:Upgrade(5)
TDS:Upgrade(5)
TDS:Upgrade(5, 2)

TDS:Place("Hacker", 32.42845916748047, 28.520427703857422, -161.66073608398438)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9, 2)

TDS:Ability(5, "Hologram Tower", {
    towerPosition = Vector3.new(20.053861618041992, 31.19621467590332, -166.93580627441406),
    towerToClone = 3
}, true)
