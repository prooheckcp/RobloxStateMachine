local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StateMachine = require(ReplicatedStorage.RobloxStateMachine)
local Transition = StateMachine.Transition

local GoToBlue = Transition.new("Blue")
GoToBlue.OnHearbeat = false

function GoToBlue:OnDataChanged(data)
    return false
end

return GoToBlue