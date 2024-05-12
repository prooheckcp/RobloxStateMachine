---
sidebar_position: 3
sidebar_label: "🛑 Stop State Transition"
---

# 🛑 Stop State Transition

There's specific situations where we might want to "stuck" a state machine on a specific state.
For this purpose there's a virtual method specifically for this!

```lua
--Blue.lua
local GoToRed = require(script.Parent.Parent.Transitions.GoToRed)
local ChangeColorState = require(script.Parent.ChangeColorState)

local Blue = ChangeColorState:Extend("Blue")
Blue.Transitions = {GoToRed}

function Blue:OnInit()
    self.Color = Color3.fromRGB(0, 0, 255)
end

function Blue:CanChangeState(newState: string)
    return newState == "Red"
end

return Blue
```

By doing this we ensure that the state blue can only be changed to the new state **IF** the new state is equal to "Red".

We could also block the player into this state entirely by simply returning false.

```lua
function Blue:CanChangeState(newState: string)
    return false
end
```

This can be specially useful to per e.g to stuck an NPC into the dead state since we don't want him to magically revive!

In case you're wondering what would happen if didn't declare this method. :CanChangeState returns **true** by default