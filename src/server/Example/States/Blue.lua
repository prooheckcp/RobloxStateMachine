local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StateMachine = require(ReplicatedStorage.RobloxStateMachine)

type State = StateMachine.State

local State = StateMachine.State

local Default: State = State.new("Blue")

function Default:OnInit(data)
    print(self.Data)
end

function Default:OnDataChanged(...)
    print("Data Changed!", ...)
end

function Default:OnHeartbeat(data)
end

function Default:OnEnter(data)
    self:ChangeData("color", Color3.fromRGB(255, 0, 0)) -- Change to red :D

    data.part.Color = data.color
end

function Default:OnLeave()
    print("Left state!")
end

return Default