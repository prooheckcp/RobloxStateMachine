
![](https://cdn.discordapp.com/attachments/670023265455964198/1104171789069860864/BeautifulLogo.png)

  

[Documentation](https://prooheckcp.github.io//RobloxStateMachine) | [Source](https://github.com/prooheckcp/RobloxStateMachine)

  
# 🏫 Introduction
This is a Roblox implementation of a simple State Machine! I personally hate the concept of over engineering things so instead I kept it simple and easy to use as all things should be! But in case you are wondering.. what is a State Machine?

A state machine is a way of organizing and controlling the behavior of objects in a program. It's like a flowchart that defines the different states an object can be in and the transitions between those states.
![](https://cdn.discordapp.com/attachments/670023265455964198/1105648392874512394/fsm_enemy_brain.png)
In game development, state machines are often used to manage the behavior of characters, enemies, and other objects in the game world. For example, a state machine might define the states "idle," "walking," "running," and "attacking" for a player character. When the player presses a button to move, the state machine would transition the character from the "idle" state to the "walking" state, and then to the "running" state if the player holds down the movement button for a longer period of time.

State machines can help make game development more efficient and easier to manage by providing a clear structure for controlling the behavior of objects. They also make it easier to add new states and transitions as the game evolves and new features are added.
# 📁 Installation
There are 3 different ways of installing this package into your project! You can either download it from the releases page, download the Roblox model or install it via Wally!

Wally: https://wally.run/package/prooheckcp/robloxstatemachine
Roblox Model: https://www.roblox.com/library/13401856320/RobloxStateMachine
Releases: https://github.com/prooheckcp/RobloxStateMachine/releases

# 📙 Tutorial
Please make sure you've installed the RobloxStateMachine before you decide to jump into the tutorial!

In this tutorial we will be going step by step on how to setup a very simple state machine. We will see how to create states, transitions and then a state machine!

## 1. Organization
Remember, the main purpose we use State Machines to begin with is so we can break down a complex system into smaller and simpler systems! So organisation is key. I Will be showing how I personally like to organise my State Machines. Obviously you can do it however you please yet I'd still highly recommend you to do it this way!

### A. First Create 2 folders
![](https://cdn.discordapp.com/attachments/670023265455964198/1105650053118431342/Screenshot_2023-05-10_at_01.18.06.png)
We will be using 1 folder to group the states and the second one to group the transitions! Now let's start by making 2 states and 2 transitions.

### B. Create 2 ModuleScripts in each folder as the following example
![](https://cdn.discordapp.com/attachments/670023265455964198/1105650694846947459/Screenshot_2023-05-10_at_01.20.53.png)
In this example we will be creating a state machine that manages the color of a part! it will have 2 states: a red and a blue colour.
So we want two states: Blue and Red. We also want to make 2 transitions that will allow us to go from blue to red and from red to blue!

### C. Create a Part and call it "myPart"
We will be creating a part in the workspace and use it as an example to how we can make/use the StateMachine
![](https://cdn.discordapp.com/attachments/670023265455964198/1105654243802755132/Screenshot_2023-05-10_at_01.34.58.png)

## 2. States
Now that we organised our files let's setup the states first! We will start by making a simple state template inside of the Blue file!

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RobloxStateMachine = require(ReplicatedStorage.RobloxStateMachine)

local Blue = RobloxStateMachine.State.new("Blue") -- The name of our state

return Blue
```
This creates and returns a state called Blue. Now let's make it change the colour of our part to blue when it enters this state. Let's also print all lifecycles to have an idea of what is going on!

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RobloxStateMachine = require(ReplicatedStorage.RobloxStateMachine)

local Blue = RobloxStateMachine.State.new("Blue") -- The name of our state

function Blue:OnInit()
	print("Blue Init!")
end

function Blue:OnEnter(data)
	print("Blue Enter!")
	data.part.Color = Color3.fromRGB(0, 0, 255) -- Change color to blue!
end

function Blue:OnHearBeat()

end

function Blue:OnLeave()
	print("Blue Leave!")
end

return Blue
```
This will turn our part blue when it enters the blue state! Are you confused about where the "data.part" comes from? Don't worry, we're getting right into that next!

## 3. Create State Machine
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
## 4. Change Data from State
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

# ⭐ Contributing
Please leave a star on [GitHub](https://github.com/prooheckcp/RobloxStateMachines), it helps a lot!

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

# 📄 License
[MIT](https://choosealicense.com/licenses/mit/)