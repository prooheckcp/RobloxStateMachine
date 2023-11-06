## 5. Transitions
Now that we finished our states we want to add the transitions to tell our state machine when should it change the state. Let's open the "ToRed" Lua file that we created early and write the following code:
```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RobloxStateMachine = require(ReplicatedStorage.RobloxStateMachine)

local ToRed = RobloxStateMachine.Transition.new("Red") -- This means we want to change to the red state

-- This will change the part state from blue to red after 5 seconds
function ToRed:OnDataChanged(data)
	if data.timer < 5 then
		return false -- This means we dont want to change the state
	else
		return true -- Return true after 5 seconds
	end
end

return ToRed
```
And that's it! This will make our state move from Blue to Red after 5 seconds! Now let's make the code to change our state from Red to blue also after another 5 seconds...
```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RobloxStateMachine = require(ReplicatedStorage.RobloxStateMachine)

local ToBlue = RobloxStateMachine.Transition.new("Blue") -- This means we want to change to the blue state

-- This will change the part state from red to blue after 5 seconds
function ToBlue:OnDataChanged(data)
	if data.timer < 5 then
		return false -- This means we dont want to change the state
	else
		return true -- Return true after 5 seconds
	end
end

return ToBlue
```