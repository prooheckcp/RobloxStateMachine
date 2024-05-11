local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StateMachine = require(ReplicatedStorage.RobloxStateMachine)
local GoToRed = require(script.Parent.Parent.Transitions.GoToRed)

local State = StateMachine.State

local ChangeColorState = State "ChangeColorState"
ChangeColorState.Transitions = {GoToRed}

function ChangeColorState:OnInit()
    self.Color = Color3.fromRGB(255, 255, 255)
end

function ChangeColorState:OnEnter(data)
    data.part.Color = self.Color
end

function ChangeColorState:OnDestroy()
    print("Destroy Instance")
end

return ChangeColorState