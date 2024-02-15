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

exampleStateMachine.DataChanged:Connect(function(...)
    print(...)
end)

task.delay(2, function()
    exampleStateMachine:ChangeData("dummyData", "Goodbye World!")
    print(exampleStateMachine.Data)
end)

--[[
exampleStateMachine.StateChanged:Connect(function(newState: string, previousState: string)
    print("Our previous state was: " .. previousState .. " now our state is: " .. newState)
end)

task.wait(2)

exampleStateMachine:ChangeState("Blue")

task.wait(2)

exampleStateMachine:ChangeData("dummyData", "Goodbye world")
]]