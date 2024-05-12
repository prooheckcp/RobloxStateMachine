---
sidebar_position: 4
sidebar_label: "🔍 Access internals"
---

# 🔍 Access internals

While inside a state or transition you can actually access to a lot of information about our state machine!
To do this all you have to do is call **self** from within any of the virtual methods.

Here's an example of what you can access from within the state
```lua
-- Blue.Lua
local GoToRed = require(script.Parent.Parent.Transitions.GoToRed)
local ChangeColorState = require(script.Parent.ChangeColorState)

local Blue = ChangeColorState:Extend("Blue")
Blue.Transitions = {GoToRed}

function Blue:OnEnter()
    print(self.Data) -- Get state machine data
    self:ChangeState("Red") -- Changes the current state to Red
    self:GetState() -- "Blue"
    self:GetPreviousState() -- Gets the previous state this state machine was in before Blue
    self:ChangeData() -- Changes data from the state machine
end


return Blue
```