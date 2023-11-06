local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RobloxStateMachine = require(ReplicatedStorage.RobloxStateMachine)

local exampleStateMachine: RobloxStateMachine.RobloxStateMachine = RobloxStateMachine.new(
    "Default",
    RobloxStateMachine:LoadDirectory(script.Example.States, {"Blue", "Default"}), 
    {
        part = workspace.Example,
        time = tick(),
        dummyData = "Hello World",
    }
)

task.wait(2)

exampleStateMachine:ChangeState("Blue")

task.wait(2)

exampleStateMachine:Destroy()