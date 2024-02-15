local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StateMachine = require(ReplicatedStorage.RobloxStateMachine)

local State = StateMachine.State

local Blue = State.new("Blue")
Blue.Transitions = {}

function Blue:OnHeartbeat(data, deltatime)
    local newData = data.timer + deltatime
    self:ChangeData("timer", newData)
end

function Blue:OnEnter(data)
    print("blue enter")
    self:ChangeData("timer", 0)
    self:ChangeData("color", Color3.fromRGB(0, 0, 255))

    data.part.Color = data.color
end

function Blue:OnLeave()
    print("Left state!")
end

return Blue