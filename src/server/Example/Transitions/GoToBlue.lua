local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StateMachine = require(ReplicatedStorage.RobloxStateMachine)
local Transition = StateMachine.Transition

local GoToBlue = Transition.new("Blue")
GoToBlue.Name = "GoToBlue"

function GoToBlue:OnEnter()
    print("Enter")
end

function GoToBlue:OnDataChanged(data)
    print(self:GetState(), self:GetPreviousState())
    self:ChangeState("Blue")
    return false
end

function GoToBlue:OnLeave()
    print("Leave", self.Data)
end

return GoToBlue