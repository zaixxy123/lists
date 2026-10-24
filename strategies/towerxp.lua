local ROOT = "https://raw.githubusercontent.com/zaixxy123/lists/refs/heads/main/strategies/towerxp/"

return function(TDS, selectedTower)
    selectedTower = tostring(selectedTower or "")

    if selectedTower == "" or selectedTower == "None" then
        return false
    end

    local filename = selectedTower == "All Normal Tower"
        and "normal.lua"
        or "evolved.lua"

    local source = game:HttpGet(ROOT .. filename .. "?cache=" .. tostring(os.clock()))
    local chunk, compileError = loadstring(source)

    if not chunk then
        error("[TOWER XP] " .. filename .. " compile failed: " .. tostring(compileError))
    end

    local strategy = chunk()

    if type(strategy) ~= "function" then
        error("[TOWER XP] " .. filename .. " must return a function")
    end

    return strategy(TDS, selectedTower)
end
