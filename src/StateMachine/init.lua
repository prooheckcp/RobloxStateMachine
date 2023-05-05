local StateMachine = {}
StateMachine.__index = StateMachine

function StateMachine.new()
    local self = setmetatable({}, StateMachine)

    return self
end

export type StateMachine = typeof(StateMachine)

return StateMachine