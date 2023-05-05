local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local StateMachine = require(ReplicatedStorage.StateMachine)

local exampleStateMachine: StateMachine.StateMachine = StateMachine.new(
    "Default",
    StateMachine:LoadDirectory(script.Example.States), 
    {
        part = workspace.Example,
        time = 0,
    }
)

exampleStateMachine.StateChanged:Connect(function(newState: string)
    print("Changed the State to: ", newState)
end)

RunService.Heartbeat:Connect(function(deltaTime)
    exampleStateMachine:ChangeData("time", exampleStateMachine:GetData().time + deltaTime)
end)