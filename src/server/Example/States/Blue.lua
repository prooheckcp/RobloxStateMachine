local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StateMachine = require(ReplicatedStorage.RobloxStateMachine)

local State = StateMachine.State

local Blue = State.new("Blue")
Blue.Transitions = {}

function Blue:OnHeartbeat(data, deltatime)

end

function Blue:OnEnter(data)
    self:ChangeData("timer", 0)
    self:ChangeData("color", Color3.fromRGB(0, 0, 255))


    data.part.Color = data.color
end

function Blue:OnLeave()

end

return Blue