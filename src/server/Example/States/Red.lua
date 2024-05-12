local GoToBlue = require(script.Parent.Parent.Transitions.GoToBlue)
local ChangeColorState = require(script.Parent.ChangeColorState)

local Red = ChangeColorState:Extend("Red")
Red.Transitions = {GoToBlue}

function Red:OnInit()
    self.Color = Color3.fromRGB(255, 0, 0)
end

return Red