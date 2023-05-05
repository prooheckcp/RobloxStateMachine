local Transition = {}
Transition.__index = Transition

function Transition.new(): Transition
    local self = setmetatable({}, Transition)

    return self
end

export type Transition = typeof(Transition.new(...))

return Transition