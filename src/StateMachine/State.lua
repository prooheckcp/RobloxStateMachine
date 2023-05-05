local Transition = require(script.Parent.Transition)

local State = {}
State.__index = State

function State.new(): State
    local self = setmetatable({}, State)
    
    self.Name = "" :: string
    self.Transitions = {} :: {Transition.Transition}

    return self
end

export type State = typeof(State.new(...))

return State