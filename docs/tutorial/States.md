---
sidebar_position: 2
sidebar_label: "🔵  States"
---

# 🔵 States
Now that we organized our files let's setup the states first! We will start by making a simple state template inside of the Blue file!

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RobloxStateMachine = require(ReplicatedStorage.RobloxStateMachine)

local Blue = RobloxStateMachine.State.new("Blue") -- The name of our state

return Blue
```
This creates and returns a state called Blue. Now let's make it change the color of our part to blue when it enters this state. Let's also print all life-cycles to have an idea of what is going on!

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RobloxStateMachine = require(ReplicatedStorage.RobloxStateMachine)

local Blue = RobloxStateMachine.State.new("Blue") -- The name of our state

function Blue:OnInit() -- This gets called as soon as the state machine is created
	print("Blue Init!")
end

function Blue:OnEnter(data) -- Called whenever the state changes into "Blue"
	print("Blue Enter!")
	-- Could also write: self.Data.part.Color
	data.part.Color = Color3.fromRGB(0, 0, 255) -- Change color to blue!
end

function Blue:OnHeartBeat() -- Called every heartbeat

end

function Blue:OnLeave() -- Called whenever the state is left even if target gets destroyed
	print("Blue Leave!")
end

return Blue
```
This will turn our part blue when it enters the blue state! Are you confused about where the "data.part" comes from? Don't worry, we're getting right into that next!
