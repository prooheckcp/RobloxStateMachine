local Transition = {}
Transition.__index = Transition

function Transition.new(): Transition
    local self = setmetatable({}, Transition)
    self.TargetState = "" :: string

    return self
end

--[=[
    Virtual method, should return true if it should change to this state
    and false if it shouldn't
]=]
function Transition:OnDataChanged(): boolean
    return false
end

export type Transition = typeof(Transition.new(...))

return Transition