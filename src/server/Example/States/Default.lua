local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StateMachine = require(ReplicatedStorage.RobloxStateMachine)
local GoToBlue = require(script.Parent.Parent.Transitions.GoToBlue)

local State = StateMachine.State

local Default = State.new("Default")
Default.Transitions = {GoToBlue}

function Default:OnEnter(data)
    data.part.Color = Color3.fromRGB(255, 0, 0)
end

return Default