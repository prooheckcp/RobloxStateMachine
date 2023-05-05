local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StateMachine = require(ReplicatedStorage.StateMachine)
local State = StateMachine.State

local Default = State.new("Blue")

function Default:OnEnter(data)
    data.part.Color = Color3.fromRGB(0, 166, 255)
end

return Default