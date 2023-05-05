local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StateMachine = require(ReplicatedStorage.StateMachine)

local exampleStateMachine: StateMachine.StateMachine = StateMachine.new(
    "Default",
    StateMachine:LoadDirectory(script.Example.States), 
    {
        part = workspace.Example
    }
)