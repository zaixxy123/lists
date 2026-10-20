-- Fallen route variants.
-- Starter = existing/old Fallen strategies.
-- Late = separate late-game Fallen strategy slot.

local ROOT =
    "https://raw.githubusercontent.com/RyaaV2/lists/refs/heads/main/strategies/"

local function LoadConfig(path)
    local ok, result = pcall(function()
        return loadstring(game:HttpGet(ROOT .. path))()
    end)

    if ok and type(result) == "table" then
        return result
    end

    warn("[RYA FALLEN CONFIG] Failed to load:", path, result)
    return {}
end

return {
    Starter = LoadConfig("fallen/starter/config.lua"),
    Late = LoadConfig("fallen/late/config.lua")
}
