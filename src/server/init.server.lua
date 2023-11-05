local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RobloxStateMachine = require(ReplicatedStorage.RobloxStateMachine)

local exampleStateMachine: RobloxStateMachine.RobloxStateMachine = RobloxStateMachine.new(
    "Default",
    RobloxStateMachine:LoadDirectory(script.Example.States), 
    {
        part = workspace.Example,
        time = tick(),
        dummyData = "Hello World",
    }
)

--[[
exampleStateMachine.StateChanged:Connect(function(newState: string)
    print("Changed the State to: ", newState)
end)

task.wait(3)

exampleStateMachine:ChangeState("Blue")    
]]
