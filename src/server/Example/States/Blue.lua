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
    print("UwU")
end

function Default:OnEnter(data)
    data.part.Color = Color3.fromRGB(0, 166, 255)

    self.Data.dummyData = "Goodbye World"

   -- print(data)
end

function Default:OnLeave()
    print("Left state!")
end

return Default