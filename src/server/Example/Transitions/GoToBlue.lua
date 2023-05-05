local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StateMachine = require(ReplicatedStorage.StateMachine)
local Transition = StateMachine.Transition

local GoToBlue = Transition.new("Blue")
GoToBlue.OnHearbeat = false

function GoToBlue:OnDataChanged(data)
    return tick() - data.time > 10 -- Will change to blue after 10 seconds 
end

return GoToBlue