TDS:Loadout("Assassin", "Commander", "Militant", "None", "None")

TDS:Mode("Casual")

TDS:GameInfo("Black Spot Exchange", {})

TDS:VoteSkip()

TDS:Place("Assassin", -21.712268829345703, 1.9999988079071045, 5.916264533996582, true)
TDS:Ready()
TDS:Place("Assassin", 21.728347778320312, 1.9999988079071045, 5.744903564453125, true)


TDS:Place("Assassin", 21.12923240661621, 1.9999988079071045, 5.619165897369385, true)
TDS:Place("Assassin", -21.455028533935547, 1.9999988079071045, 5.9863386154174805, true)

TDS:Upgrade(3)
TDS:Upgrade(2)
TDS:Upgrade(4)
TDS:Upgrade(1)
TDS:Upgrade(4)
TDS:Upgrade(3)

TDS:Upgrade(1)
TDS:Upgrade(2)
TDS:Upgrade(3)

TDS:Upgrade(4)

TDS:Upgrade(1)

TDS:Upgrade(2)

TDS:Place("Commander", -12.246332168579102, 1.9991202354431152, 5.417953014373779, true)
TDS:Place("Commander", 12.106220245361328, 1.9991164207458496, 5.493164539337158, true)

TDS:Upgrade(6)
TDS:Upgrade(5)

TDS:Upgrade(1)

TDS:Upgrade(3)
TDS:Upgrade(2)

TDS:Upgrade(4)

TDS:Upgrade(6)
TDS:Upgrade(5)

TDS:Place("Commander", 0.024897336959838867, 1.9991356134414673, 1.0336670875549316, true)
TDS:UpgradeTimes(7, 3)

for i = 1, 33 do
    local index = 7 + i

    TDS:Place("Militant", -0.1802051067352295, 1.9991350173950195, 4.5959038734436035, true)
    TDS:UpgradeTimes(index, 4)
end
