-- Master config assembler.
-- Route-specific settings live inside each route folder.
-- Shared registries live inside strategies/config/.

local ROOT =
    "https://raw.githubusercontent.com/RyaaV2/lists/refs/heads/main/strategies/"

local function LoadConfig(path)
    local url = ROOT .. path
    local lastError

    for attempt = 1, 3 do
        local ok, result = pcall(function()
            local source = game:HttpGet(
                url
                .. "?cache="
                .. tostring(os.time())
                .. "_"
                .. tostring(attempt)
            )

            if type(source) ~= "string" or #source == 0 then
                error("empty HTTP response")
            end

            local chunk, compileError = loadstring(source)

            if not chunk then
                error(
                    "compile error: "
                    .. tostring(compileError)
                )
            end

            local loaded = chunk()

            if type(loaded) ~= "table" then
                error(
                    "config returned "
                    .. type(loaded)
                    .. " instead of table"
                )
            end

            return loaded
        end)

        if ok then
            return result
        end

        lastError = result
        task.wait(0.5)
    end

    warn(
        "[RYA CONFIG] Failed to load:",
        path,
        lastError
    )

    return {}
end

local progression =
    LoadConfig("config/progression.lua")

return {
    Routes =
        LoadConfig("config/routes.lua"),

    Towers =
        LoadConfig("config/towers.lua"),
    
    TowerXP =
        LoadConfig("config/towerxp.lua"),

    SkillTree =
        LoadConfig("config/skilltree1.lua"),

    AutoFarmUntilGatling =
        progression.AutoFarmUntilGatling or {},

    AutoBuyAllTowers =
        progression.AutoBuyAllTowers or {},

    AutoMaxAccount =
        progression.AutoMaxAccount or {},

    LateGrind =
        LoadConfig("lategrind.lua"),

    CurrencyFarm =
        LoadConfig("currency/config.lua"),

    PremiumCurrencyFarm =
        LoadConfig("currency/premium/config.lua"),

    Easy =
        LoadConfig("easy/config.lua"),

    Casual =
        LoadConfig("casual/config.lua"),

    Molten =
        LoadConfig("molten/config.lua"),

    Hardcore =
        LoadConfig("hardcore/config.lua"),

    Fallen =
        LoadConfig("fallen/config.lua"),

    Frost =
        LoadConfig("frost/config.lua"),

    Story =
        LoadConfig("story/config.lua")
}
