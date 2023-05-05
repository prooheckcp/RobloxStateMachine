local Transition = require(script.Parent.Transition)

local State = {}
State.__index = State
State.Name = "" :: string
State.Transitions = {} :: {Transition.Transition}

function State.new(stateName: string?)
    local self = setmetatable({}, State)
    
    self.Name = stateName or ""
    self.Transitions = {}

    return self
end

export type State = typeof(State)

return State