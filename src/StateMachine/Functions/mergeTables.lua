--[[
    Merges two tables together
]]
local function mergeTables(baseTable, targetTable)
    for index: string, value in targetTable do
        if typeof(baseTable[index]) == typeof(value) then
            if baseTable[index] ~= (getmetatable(baseTable) or {})[index] then
                continue
            end
        end

        if type(value) == "table" then
            baseTable[index] = table.clone(value)
        else
            baseTable[index] = value
        end
    end

    return baseTable
end

return mergeTables