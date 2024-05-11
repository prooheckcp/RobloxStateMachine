local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StateMachine = require(ReplicatedStorage.RobloxStateMachine)

local State = StateMachine.State

local Blue = State.new("Blue")
Blue.Transitions = {}

function Blue:OnInit()
    print("Init Blue State!")
end

function Blue:OnEnter(data)
    self:ChangeData("timer", 0)
    self:ChangeData("color", Color3.fromRGB(0, 0, 255))

    --print(self:GetState(), self:GetPreviousState())

    data.part.Color = data.color
end

function Blue:OnLeave()

end

function Blue:OnDestroy()
    print("Destroy Blue State!")
end

return Blue