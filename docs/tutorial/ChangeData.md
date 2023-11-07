---
sidebar_position: 4
sidebar_label: "📂 Sending Data"
---

# 📂 Sending Data

Something that is very important is to change our State Machine data from within the state. Let's go into the blue state and add a timer, this will tell us how long since we have entered the blue state. It will later help us to transition between the 2 states after X amount of seconds!
```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RobloxStateMachine = require(ReplicatedStorage.RobloxStateMachine)

local Blue = RobloxStateMachine.State.new("Blue") -- The name of our state

function Blue:OnInit()
	print("Blue Init!")
end

function Blue:OnEnter(data)
	print("Blue Enter!")
	data.timer = 0 -- Create timer in data
	data.part.Color = Color3.fromRGB(0, 0, 255) -- Change color to blue!
end

function Blue:OnHearBeat(data, deltatime) -- All functions receive data as the first parameter
	data.timer += deltatime
end

function Blue:OnLeave()
	print("Blue Leave!")
end

return Blue
```
Great now we completely finished our blue state! Now let's just copy paste the blue state into the red state and change the colour to Red and the name of the state from Blue to "Red".

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RobloxStateMachine = require(ReplicatedStorage.RobloxStateMachine)

local Red = RobloxStateMachine.State.new("Red") -- The name of our state

function Red:OnInit()
	print("Red Init!")
end

function Red:OnEnter(data)
	print("Red Enter!")
	data.timer = 0 -- Create timer in data
	data.part.Color = Color3.fromRGB(255, 0, 0) -- Change color to red!
end

function Red:OnHearBeat(data, deltatime) -- All functions receive data as the first parameter
	data.timer += deltatime
end

function Red:OnLeave()
	print("Red Leave!")
end

return Red
```
Don't forget to add the red state to our state machine!
```lua
RobloxStateMachine.new("Blue",
{
require(states.Blue),
require(states.Red)
},
{
part = workspace.myPart
}
)
```