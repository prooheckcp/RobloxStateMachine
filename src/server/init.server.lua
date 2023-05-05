local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StateMachine = require(ReplicatedStorage.StateMachine)

local exampleStateMachine: StateMachine.StateMachine = StateMachine.new(
    "Default",
    StateMachine:LoadDirectory(script.Example.States), 
    {
        part = workspace.Example,
        time = tick(),
    }
)

exampleStateMachine.StateChanged:Connect(function(newState: string)
    print("Changed the State to: ", newState)
end)