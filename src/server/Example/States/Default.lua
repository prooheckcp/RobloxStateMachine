local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StateMachine = require(ReplicatedStorage.RobloxStateMachine)
local GoToBlue = require(script.Parent.Parent.Transitions.GoToBlue)

local State = StateMachine.State

local Red = State.new("Red")
Red.Transitions = {GoToBlue}

function Red:OnHeartbeat(data, deltatime)
    print(">2")
end

function Red:OnEnter(data)
    print(">1")
    self:ChangeData("color", Color3.fromRGB(255, 0, 0))
    task.delay(1, function()
        self:ChangeState("Blue")
    end)

    print(self:GetState(), self:GetPreviousState())
    data.part.Color = Color3.fromRGB(255, 0, 0)
end

function Red:OnLeave()
    print(">3")
    print("Left state!")
end

return Red