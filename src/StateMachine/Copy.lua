--[[
    Deep copy of the object
]]
local function Copy<T>(object)
    local newObject = setmetatable({}, getmetatable(object)) -- Clone metaData

    for index: string, value: any in object do
        if typeof(value) == "table" then
            newObject[index] = Copy(value)
            continue
        end

        newObject[index] = value
    end

    return newObject
end

return Copy