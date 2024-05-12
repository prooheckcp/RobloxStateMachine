---
sidebar_position: 2
sidebar_label: "🚀 Extend States/Transitions"
---

# 🚀 Extend States/Transitions

We can extend classes that share behavior with one another. In fact we do this in one of our examples!

Let's see how this works in practice. First you start by creating a Parent State. This is the state from which other states will be created.


```lua
--ChangeColorState.lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RobloxStateMachine = require(ReplicatedStorage.RobloxStateMachine)

local State = RobloxStateMachine.State

local ChangeColorState = State "ChangeColorState"

function ChangeColorState:OnInit()
    self.Color = Color3.fromRGB(255, 255, 255)
end

function ChangeColorState:OnEnter(data)
    data.part.Color = self.Color
end

function ChangeColorState:OnDestroy()
    print("Destroy Instance")
end

return ChangeColorState
```

Now that we have our parent class that defines are behavior on which we will be changing the part color to what has been defined in the 
init function we can now make new states! Let's create a blue and red state

```lua
--Red.lua
local GoToBlue = require(script.Parent.Parent.Transitions.GoToBlue)
local ChangeColorState = require(script.Parent.ChangeColorState)

local Red = ChangeColorState:Extend("Red")
Red.Transitions = {GoToBlue}

function Red:OnInit()
    self.Color = Color3.fromRGB(255, 0, 0)
end

return Red
```

```lua
--Blue.lua
local GoToRed = require(script.Parent.Parent.Transitions.GoToRed)
local ChangeColorState = require(script.Parent.ChangeColorState)

local Blue = ChangeColorState:Extend("Blue")
Blue.Transitions = {GoToRed}

function Blue:OnInit()
    self.Color = Color3.fromRGB(0, 0, 255)
end

return Blue
```

By doing this we didn't have to define the changing color behavior on both blue and red!