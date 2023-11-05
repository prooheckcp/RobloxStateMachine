--[=[
    @class Transition

    Dictates how and when should you move between different states
]=]
local Transition = {}
Transition.Type = "Transition"
Transition.Name = "" :: string
Transition.__index = Transition
Transition.TargetState = "" :: string
Transition._changeState = nil :: (newState: string)->()?

--[=[
    Creates a new transition. Transitions are used to tell our state
    when and how should it move from the current state to a different one.
    They are meant to be reusable and allow us to easily add and reuse transitions
    between states and objects

    ```lua
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local StateMachine = require(ReplicatedStorage.RobloxStateMachine)
    local Transition = StateMachine.Transition

    local GoToBlue = Transition.new("Blue")
    GoToBlue.OnHearbeat = false

    function GoToBlue:OnDataChanged(data)
        return tick() - data.time > 10 -- Will change to blue after 10 seconds 
    end

    return GoToBlue
    ```

    @param targetState string? -- The state the transition will change to when it meets the requirements

    @return Transition
]=]
function Transition.new(targetState: string?): Transition
    local self = setmetatable({}, Transition)
    self.TargetState = targetState or ""

    return self
end

--[=[
    :::info
    This is a **Virtual Method**. Virtual Methods are meant to be overwritten
    :::

    Whether it can change to this state or not. It's a good way to lock the current state

    @param data {[string]: any}

    @return boolean -- By default it returns true
]=]
function Transition:CanChangeState(data: {[string]: any}): boolean
    assert(data)
    return true
end

--[=[
    Forcelly changes the current state of our state machine to a new one

    @param newState string -- The name of the new state

    @return ()
]=]
function Transition:ChangeState(newState: string): ()
    if not self._changeState then
        return
    end

    self._changeState(newState)
end

--[=[
    :::info
    This is a **Virtual Method**. Virtual Methods are meant to be overwritten
    :::
    
    Should return true if it should change to the target state
    and false if it shouldn't

    @param data {[string]: any}

    @return boolean -- By default it returns false
]=]
function Transition:OnDataChanged(data: {[string]: any}): boolean
    assert(data)
    return false
end

export type Transition = typeof(Transition.new(...))

return Transition