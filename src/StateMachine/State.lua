local Transition = require(script.Parent.Transition)

local State = {}
State.__index = State

function State.new(stateName: string?): State
    local self = setmetatable({}, State)
    
    self.Name = stateName or "" :: string
    self.Transitions = {} :: {Transition.Transition}

    return self
end

export type State = typeof(State.new(...))

return State