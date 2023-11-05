--[[
    Creates a proxy metatable that can automatically detect changes that are done
    to the code
]]
function createProxyMetatable(baseTable: {[string]: any}?): ProxyMetatable
	local data = baseTable or {}

	local proxy = setmetatable({
        _callbacks = {},
    }, {
		__index = function(_, key)
			return data[key]
		end,
		__newindex = function(tab, key, value)
			local oldValue = data[key]
			data[key] = value
            print("Got this far?", tab._callbacks)
            task.spawn(function()
                for callback in tab._callbacks do
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
        self._callbacks[callback] = true
        
        return function()
            self._callbacks[callback] = nil
        end
    end

	return proxy
end

export type ProxyMetatable = typeof(createProxyMetatable({}))

return createProxyMetatable