local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StateMachine = require(ReplicatedStorage.StateMachine)
local Transition = StateMachine.Transition

local GoToBlue = Transition.new("Blue")
GoToBlue.OnHearbeat = true

function GoToBlue:OnDataChanged(data)
    print("Time:", data.time)
    return data.time > 10 -- Will change to blue after 10 seconds 
end

return GoToBlue