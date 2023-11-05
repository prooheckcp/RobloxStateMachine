--[[
    Creates a proxy metatable that can automatically detect changes that are done
    to the code
]]
function createProxyMetatable(baseTable: {[string]: any}?): ProxyMetatable
	local data = baseTable or {}
    local callbacks = {} -- will get cleared when the proxy is destroyed

	local proxy = setmetatable({}, {
		__index = function(_, key)
			return data[key]
		end,
		__newindex = function(_, key, value)
            if data[key] == value then
                return
            end
            
			local oldValue = data[key]
			data[key] = value

            task.spawn(function()
                for callback in callbacks do
                    callback(key, value, oldValue)
                end
            end)
		end,
		__tostring = function()
			print(data)
			return ""
		end,
	})

    function proxy:ListenToDataChange(callback: (key: any, newValue: any, oldValue: any) -> ()): (() -> ())
        callbacks[callback] = true

        return function()
            callbacks[callback] = nil
        end
    end

	return proxy
end

export type ProxyMetatable = typeof(createProxyMetatable({}))

return createProxyMetatable