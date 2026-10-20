-- Timescale Ticket fallback route.
-- Reuses the shared Fallen Late config for one match,
-- then returns to the lobby so the current Trial can be checked again.

local ROOT =
    "https://raw.githubusercontent.com/RyaaV2/lists/refs/heads/main/strategies/"

local ok, sharedConfig = pcall(function()
    return loadstring(
        game:HttpGet(
            ROOT .. "fallen/late/config.lua"
        )
    )()
end)

if not ok or type(sharedConfig) ~= "table" then
    warn(
        "[RYA TIMESCALE FALLBACK] Failed to load shared Fallen Late config:",
        sharedConfig
    )

    return {}
end

local config = {}

for key, value in pairs(sharedConfig) do
    config[key] = value
end

config.RouteKey =
    "PremiumCurrency.TimescaleTicketFallbackCoins"

config.GameOverAction =
    "BackToLobby"

return config
