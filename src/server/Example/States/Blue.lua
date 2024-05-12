local GoToRed = require(script.Parent.Parent.Transitions.GoToRed)
local ChangeColorState = require(script.Parent.ChangeColorState)

local Blue = ChangeColorState:Extend("Blue")
Blue.Transitions = {GoToRed}

function Blue:OnInit()
    self.Color = Color3.fromRGB(0, 0, 255)
end

function Blue:CanChangeState(newState: string)
    return newState == "Red"
end

function Blue:OnDestroy()
    self.Data
    print("Destroy Blue State!")
end

return Blue