--[[
    Deep copy of the object
]]
local function Copy<T>(object)
    local newObject = {}

    for index: string, value: any in object do
        if typeof(value) == "table" then
            newObject[index] = Copy(value)
            setmetatable(newObject[index], getmetatable(value)) -- Clone metaData
            continue
        end

        newObject[index] = value
    end

    return newObject
end

return Copy