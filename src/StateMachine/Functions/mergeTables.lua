--[[
    Merges two tables together
]]
local function mergeTables(baseTable, targetTable)
    for index: string, value in targetTable do
        if type(value) == "table" then
            baseTable[index] = table.clone(value)
        else
            baseTable[index] = value
        end
    end

    return baseTable
end

return mergeTables