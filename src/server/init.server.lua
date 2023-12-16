local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RobloxStateMachine = require(ReplicatedStorage.RobloxStateMachine)


local exampleStateMachine: RobloxStateMachine.RobloxStateMachine = RobloxStateMachine.new(
    "Red",
    RobloxStateMachine:LoadDirectory(script.Example.States, nil), 
    {
        part = workspace.Example,
        time = tick(),
        dummyData = "Hello World",
    }
)

exampleStateMachine.StateChanged:Connect(function(newState: string, previousState: string)
    print("Our previous state was: " .. previousState .. " now our state is: " .. newState)
end)

task.wait(2)

exampleStateMachine:ChangeState("Blue")

task.wait(2)

exampleStateMachine:ChangeData("dummyData", "Goodbye world")