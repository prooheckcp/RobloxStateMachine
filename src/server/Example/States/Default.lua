local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StateMachine = require(ReplicatedStorage.StateMachine)
local State = StateMachine.State

local Default = State.new("Default")

function Default:OnEnter(data)
    data.part.Color = Color3.fromRGB(255, 0, 0)
end

return Default