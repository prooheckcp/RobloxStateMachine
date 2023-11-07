---
sidebar_position: 1
sidebar_label: "📂 Load Directories"
---

# 📂 Load Directories

There's a helpful method that allows us to easily load states and transitions called :LoadDirectories.

```lua
--[[
    - src
        - server
            - Example
                - States
                    - Blue.lua
                    - Default.lua
]]
local exampleStateMachine = RobloxStateMachine.new(
    "Default",
    RobloxStateMachine:LoadDirectory(script.Example.States), {}
)
```

This code will load all the states from the Example folder into the state machine.

And if we want to be more specific we can send the files names as the third argument!

```lua
local exampleStateMachine = RobloxStateMachine.new(
    "Default",
    RobloxStateMachine:LoadDirectory(script.Example.States, {"Default"}), -- This will only load the Default state!
)
```
