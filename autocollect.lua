local Globals = getgenv()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer or Players.PlayerAdded:Wait()
local PlayerGui = Player:WaitForChild("PlayerGui")

local AutoCollect = {}
local running = false

local function IsLobby()
    return game.PlaceId == 3260590327
end

function AutoCollect.IsRunning()
    return running
end

function AutoCollect.Start()
    if running or not Globals.ClaimRewards or not IsLobby() then
        return false
    end

    running = true
    task.spawn(function()
        pcall(function()
            local network = ReplicatedStorage:WaitForChild("Network")
            local spinTickets = Player:WaitForChild("SpinTickets", 15)
            if spinTickets and spinTickets.Value > 0 then
                local dailySpin = network:WaitForChild("DailySpin", 5)
                local redeemSpin = dailySpin and dailySpin:WaitForChild("RF:RedeemSpin", 5)
                if redeemSpin then
                    local maxAttempts = math.max(0, math.floor(tonumber(spinTickets.Value) or 0))
                    for _ = 1, maxAttempts do
                        if not Globals.ClaimRewards or not IsLobby() or spinTickets.Value <= 0 then
                            break
                        end
                        local before = spinTickets.Value
                        local ok = pcall(function()
                            redeemSpin:InvokeServer()
                        end)
                        if not ok then
                            break
                        end
                        task.wait(0.2)
                        if spinTickets.Value >= before then
                            break
                        end
                    end
                end
            end

            if Globals.ClaimRewards then
                local playtimeRewards = network:WaitForChild("PlaytimeRewards")
                local claimReward = playtimeRewards:WaitForChild("RF:ClaimReward")
                for i = 1, 6 do
                    if not Globals.ClaimRewards then
                        break
                    end
                    claimReward:InvokeServer(i)
                    task.wait(0.2)
                end
            end

            if Globals.ClaimRewards then
                local dailySpin = network:FindFirstChild("DailySpin")
                local redeemReward = dailySpin and dailySpin:FindFirstChild("RF:RedeemReward")
                if redeemReward then
                    redeemReward:InvokeServer()
                end
            end
        end)
        running = false
    end)
    return true
end

local PathfindingService = game:GetService("PathfindingService")
local pickupsRunning = false

local PathfindingService = game:GetService("PathfindingService")
local pickupsRunning = false

local function IsVoidCharm(obj)
    return math.abs(obj.Position.Y) > 999999
end

local function GetRoot()
    local char = Player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

function AutoCollect.IsPickupsRunning()
    return pickupsRunning
end

function AutoCollect.StartPickups()
    if pickupsRunning or not Globals.AutoPickups then return end
    pickupsRunning = true

    task.spawn(function()
        while Globals.AutoPickups do
            local folder = workspace:FindFirstChild("Pickups")
            local hrp = GetRoot()

            if folder and hrp then
                local char = hrp.Parent
                local humanoid = char and char:FindFirstChildOfClass("Humanoid")
                local function MoveToPos(TargetPos)
                    if not humanoid then
                        return false
                    end
                    local function MoveDirect(pos)
                        humanoid:MoveTo(pos)
                        local StartT = os.clock()
                        while os.clock() - StartT < 2 do
                            if not Globals.AutoPickups then
                                return false
                            end
                            if (hrp.Position - pos).Magnitude < 4 then
                                return true
                            end
                            task.wait(0.1)
                        end
                        return (hrp.Position - pos).Magnitude < 4
                    end
                    local path = PathfindingService:CreatePath({
                        AgentRadius = 2,
                        AgentHeight = 6,
                        AgentCanJump = true,
                        AgentJumpHeight = 7,
                        AgentMaxSlope = 45
                    })
                    local ok = pcall(function()
                        path:ComputeAsync(hrp.Position, TargetPos)
                    end)
                    if ok and path.Status == Enum.PathStatus.Success then
                        local waypoints = path:GetWaypoints()
                        local BlockedConn = nil
                        BlockedConn = path.Blocked:Connect(function()
                            if BlockedConn then
                                BlockedConn:Disconnect()
                            end
                            if Globals.AutoPickups then
                                task.spawn(function()
                                    MoveToPos(TargetPos)
                                end)
                            end
                        end)
                        for _, wp in ipairs(waypoints) do
                            if not Globals.AutoPickups then
                                if BlockedConn then
                                    BlockedConn:Disconnect()
                                end
                                return false
                            end
                            if wp.Action == Enum.PathWaypointAction.Jump then
                                humanoid.Jump = true
                            end
                            if not MoveDirect(wp.Position) then
                                if BlockedConn then
                                    BlockedConn:Disconnect()
                                end
                                return false
                            end
                        end
                        if BlockedConn then
                            BlockedConn:Disconnect()
                        end
                        return true
                    end
                    return MoveDirect(TargetPos)
                end

                for _, item in ipairs(folder:GetChildren()) do
                    if not Globals.AutoPickups then break end

                    if item:IsA("MeshPart") and (item.Name == "Bunz" or item.Name == "Lorebook" or item.Name == "SnowCharm" or item.Name == "Fragment") then
                        if not IsVoidCharm(item) then
                            if Globals.PickupMethod == "Instant" then
                                hrp.CFrame = item.CFrame * CFrame.new(0, 3, 0)
                                task.wait(0.2)
                                task.wait(0.3)
                            else
                                local TargetPos = item.Position + Vector3.new(0, 3, 0)
                                MoveToPos(TargetPos)
                                task.wait(0.2)
                                task.wait(0.3)
                            end
                        end
                    end
                end
            end

            task.wait(1)
        end

        pickupsRunning = false
    end)
    return true
end


return AutoCollect
