local State = {}
State.__index = State

function State.new(): State
    local self = setmetatable({}, State)

    return self
end

export type State = typeof(State.new(...))

return State