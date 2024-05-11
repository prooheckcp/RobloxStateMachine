--[[
    Deep copy of the object
]]
local function deepCopy<T>(object)
    local newObject = setmetatable({}, getmetatable(object)) -- Clone metaData

    for index: string, value: any in object do
        if typeof(value) == "table" then
            newObject[index] = deepCopy(value)
            continue
        end

        newObject[index] = value
    end

    return newObject
end

return deepCopy