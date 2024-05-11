local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RobloxStateMachine = require(ReplicatedStorage.RobloxStateMachine)

local exampleStateMachine = RobloxStateMachine.new(
    "Red",
    RobloxStateMachine:LoadDirectory(script.Example.States, nil), 
    {
        color = Color3.fromRGB(255, 255, 255),
        part = workspace.Example,
        time = tick(),
        dummyData = "Hello World",
    }
)

task.delay(20, function()
    exampleStateMachine:Destroy()
end)