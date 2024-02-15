local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StateMachine = require(ReplicatedStorage.RobloxStateMachine)
local GoToBlue = require(script.Parent.Parent.Transitions.GoToBlue)

local State = StateMachine.State

local Red = State.new("Red")
Red.Transitions = {GoToBlue}

function Red:OnHeartbeat(data, deltatime)
    local newData = data.timer + deltatime
    self:ChangeData("timer", newData)
end

function Red:OnEnter(data)
    print("red enter")

    self:ChangeData("timer", 0)
    self:ChangeData("color", Color3.fromRGB(255, 0, 0))


    data.part.Color = Color3.fromRGB(255, 0, 0)
end

function Red:OnLeave()
    print("Left state!")
end

return Red