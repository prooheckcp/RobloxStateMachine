## 6. Connecting Transitions
Now that we have both our States and Transitions we should connect our transitions to the states! You can do this by going into the Red and Blue state and add a Transitions array with every transition you want. See the following examples
```lua
--blue.lua
local Blue = RobloxStateMachine.State.new("Blue") -- The name of our state
Blue.Transitions = {
	require(ReplicatedStorage.Transitions.ToRed)
}
```
```lua
--red.lua
local Red = RobloxStateMachine.State.new("Red") -- The name of our state
Red.Transitions = {
	require(ReplicatedStorage.Transitions.ToBlue)
}
```

## 7. Watch and enjoy!
Now that we have finally done all of this you can see it in action! Just press play and enjoy seeing the State Machine Working!

Had problems during the tutorial? Check the copy unlocked place here:
https://www.roblox.com/games/13401789032/RobloxStateMachine-Copy-Unlocked