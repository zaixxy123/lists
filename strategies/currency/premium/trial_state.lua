-- Shared Trial state helper for premium currency routes.
-- Keeps Trial state lookup outside the main script.

local ReplicatedStorage =
    game:GetService("ReplicatedStorage")

local LOBBY_PLACE_ID = 3260590327

local TrialState = {}

local function NormalizeTrial(value)
    if value == nil then
        return nil
    end

    value = tostring(value)

    if value == ""
        or value == "None"
        or value == "nil" then

        return nil
    end

    return value
end

local function ReadTrialFromAttributes(rep)
    if not rep then
        return nil
    end

    local attributes =
        rep:GetAttributes()

    local direct =
        NormalizeTrial(
            attributes.GlobalTrial
        )

    if direct then
        return direct
    end

    local matches = {}

    for attributeName, value in pairs(
        attributes
    ) do
        if type(value) == "string"
            and string.find(
                string.lower(
                    tostring(attributeName)
                ),
                "trial",
                1,
                true
            ) then

            local normalized =
                NormalizeTrial(value)

            if normalized then
                matches[#matches + 1] = {
                    Name = tostring(attributeName),
                    Value = normalized
                }
            end
        end
    end

    if #matches == 1 then
        return matches[1].Value
    end

    table.sort(
        matches,
        function(a, b)
            return a.Name < b.Name
        end
    )

    return matches[1]
        and matches[1].Value
        or nil
end

function TrialState.GetCurrentTrial()
    local stateReplicators =
        ReplicatedStorage:FindFirstChild(
            "StateReplicators"
        )

    if not stateReplicators then
        return "Unknown"
    end

    if game.PlaceId ~= LOBBY_PLACE_ID then
        local gameStateReplicator =
            stateReplicators:FindFirstChild(
                "GameStateReplicator"
            )

        local currentTrial =
            gameStateReplicator
            and NormalizeTrial(
                gameStateReplicator:GetAttribute(
                    "GlobalTrial"
                )
            )
            or nil

        if currentTrial then
            return currentTrial
        end
    end

    local trialsStateReplicator =
        stateReplicators:FindFirstChild(
            "TrialsStateReplicator"
        )

    local lobbyTrial =
        ReadTrialFromAttributes(
            trialsStateReplicator
        )

    return lobbyTrial
        or "Unknown"
end

return TrialState
