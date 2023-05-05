local State = require(script.State)

local StateMachine = {}
StateMachine.__index = StateMachine

function StateMachine.new(initialState: string, states: {State.State}, initialData: {[string]: any}?): StateMachine
    local self = setmetatable({}, StateMachine)
    
    self._CurrentState = initialState
    self._CustomData = initialData or {} :: {[string]: any}
    self._States = {} :: {[string]: State.State}

    for _, state: State.State in states do -- Load the states
        self._States[state.Name] = state
    end

    return self
end

--[=[
    Returns the current state of the State Machine

    @return string
]=]
function StateMachine:GetCurrentState(): string
    return self._CurrentState
end

--[=[
    Changing data request

    @param index string
    @param newValue any

    @return ()
]=]
function StateMachine:ChangeData(index: string, newValue: any): ()
    if self._CustomData[index] == newValue then
        return
    end

    self._CustomData[index] = newValue
end

export type StateMachine = typeof(StateMachine.new(...))

return StateMachine