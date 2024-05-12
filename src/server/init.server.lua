local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RobloxStateMachine = require(ReplicatedStorage.RobloxStateMachine)

print(RobloxStateMachine)

local exampleStateMachine = RobloxStateMachine.new(
    "Red",
    RobloxStateMachine:LoadDirectory(script.Example.States, {
        "Blue",
        "Red"
    }), 
    {
        color = Color3.fromRGB(255, 255, 255),
        part = workspace.Example,
        time = tick(),
        dummyData = "Hello World",
    }
)