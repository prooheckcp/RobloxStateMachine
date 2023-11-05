local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StateMachine = require(ReplicatedStorage.RobloxStateMachine)
local State = StateMachine.State

local Default = State.new("Blue")

function Default:OnInit(data)
    
end

function Default:OnHeartbeat(data)

end

function Default:OnEnter(data)
    data.part.Color = Color3.fromRGB(0, 166, 255)

    task.wait(1)

    self.Data = "Goodbye World"
end

return Default