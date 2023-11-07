---
sidebar_position: 3
sidebar_label: "🤖🔄 State Machine"
---

# 🤖🔄 State Machine

Now that we have 1 state we can already make our state machine! Don't worry, we will be covering transitions and making our red state next! Now in a server or local script create a state machine with the following code...

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RobloxStateMachine = require(ReplicatedStorage.RobloxStateMachine)

local states = ReplicatedStorage.States -- Reference to our states folder

local stateMachine = RobloxStateMachine.new("Blue", -- This is the initial state of our machine
	{
		require(states.Blue) -- This is an array of our states
	},
	{
		part = workspace.myPart -- This is the data that our transitions and states will have access to
	}
)
```
Running the game will now turn out part blue as it will be entering the blue state! If you see we are giving the StateMachine the information about what "part" is. It allows us to access the workspace part from our states and transitions!
![](https://cdn.discordapp.com/attachments/670023265455964198/1105806395330269287/Screenshot_2023-05-10_at_11.39.31.png)