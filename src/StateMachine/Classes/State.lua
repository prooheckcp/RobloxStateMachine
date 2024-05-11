local Transition = require(script.Parent.Transition)
local mergeTables = require(script.Parent.Parent.Functions.mergeTables)

--[=[
    @class State

    Describes one of the many states an object can have. It also declares
    how it should behave when it enters, is and leaves the given state
]=]
local State = {}
State.__index = State
State.Type = "State"
--[=[
    @prop Name string
    @within State

    The name of the state. This is used to identify the state. Usually set while creating the state

    ```lua
    local Blue: State = State.new("Blue")
    ```
]=]
State.Name = "" :: string
--[=[
    @prop Transitions string
    @within State

    A reference for the transitions of this state. This is usually set while creating the state

    ```lua
    local GoToBlue = require(script.Parent.Parent.Transitions.GoToBlue)

    local State = StateMachine.State

    local Default = State.new("Default")
    Default.Transitions = {GoToBlue}
    ```
]=]
State.Transitions = {} :: {Transition.Transition}
--[=[
    @prop Data {[string]: any}
    @within State

    Contains the state machine data, it can be accessed from within the class
]=]
State.Data = {} :: {[string]: any}
--[=[
    @prop _transitions {[string]: Transition.Transition}
    @within State
    @private

    Used to cache the transitions objects
]=]
State._transitions = {} :: {[string]: Transition.Transition}
--[=[
    @prop _changeState (newState: string)->()?
    @within State
    @private

    This is used to change the state of the state machine. This is set by the state machine itself
]=]
State._changeState = nil :: (newState: string)->()?
--[=[
    @prop _changeData (index: string, newValue: any)->()?
    @within State
    @private

    This is used to change the data of the state machine. This is set by the state machine itself
]=]
State._changeData = nil :: (index: string, newValue: any)-> ()?
--[=[
    @prop _getState (index: string, newValue: any)-> string
    @within State
    @private

    Gets the current state of our state machine
]=]
State._getState = nil :: (index: string, newValue: any)-> string
--[=[
    @prop _getPreviousState ()-> string?
    @within State
    @private

    Gets the previous state of our state machine
]=]
State._getPreviousState = nil :: ()-> string?
--[=[
    Used to create a new State. The state should manage how the object should behave during
    that given state. I personally recommend having your states in their own files for organizational
    purposes

    ```lua
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local StateMachine = require(ReplicatedStorage.RobloxStateMachine)
    local State = StateMachine.State

    local Default = State.new("Blue") -- The name of this state is "Blue"
    Default.Transitions = { -- The transitions that will be listened to while in the blue state
        transition1,
        transition2
    }
    function Default:OnEnter(data)
        data.part.Color = Color3.fromRGB(0, 166, 255) --This will turn the part Blue when it enters the state blue
    end

    return Default
    ```

    @param stateName string?

    @return State
]=]
function State.new(stateName: string?): State
    local self = setmetatable({}, State)
    
    self.Name = stateName or ""
    self.Transitions = {}

    return self
end

--[=[
    Extends a state inheriting the behavior from the parent state

    ```lua
    local state = State.new("Blue")
    
    function state:Print()
        print("Hello World!")
    end

    local extendedState = state:Extend("Red")

    function extendedState:OnInit()
        self:Print() -- Will print "Hello World!"
    end
    ```

    @param stateName string

    @return State
]=]
function State:Extend(stateName: string): State
    return mergeTables(State.new(stateName), self)
end

--[=[
    Forcelly changes the current state of our state machine to a new one

    @param newState string -- The name of the new state

    @return ()
]=]
function State:ChangeState(newState: string): ()
    if not self._changeState then
        return
    end

    self._changeState(newState)
end

--[=[
    Gets the current state of our state machine

    @return string
]=]
function State:GetState(): string
    if not self._getState then
        return ""
    end

    return self._getState()
end

--[=[
    Gets the previous state of our state machine

    @return string
]=]
function State:GetPreviousState(): string
    if not self._getPreviousState then
        return ""
    end

    return self._getPreviousState()
end

--[=[
    Changing data request. You can also just Get the data and change the data at run time.

    ```lua
    local example: State = State.new("Blue")

    function example:OnEnter(data)
        self:ChangeData("color", Color3.fromRGB(255, 0, 0)) -- Change to red :D

        data.part.Color = data.color
    end
    ```

    @param index string
    @param newValue any

    @return ()
]=]
function State:ChangeData(index: string, newValue: any): ()
    if not self._changeData then
        return
    end

    self._changeData(index, newValue)
end

--[=[
    :::info
    This is a **Virtual Method**. Virtual Methods are meant to be overwritten
    :::

    Called whenever a state machine is created with this state.

    ```lua
    function State:OnInit(data)
        print("I was init!")
        self.SomeStartingData = tick()
    end
    ```

    @param _data {[string]: any} -- This is the data from the StateMachine itself!

    @return ()
]=]
function State:OnInit(_data: {[string]: any}): ()

end

--[=[
    :::info
    This is a **Virtual Method**. Virtual Methods are meant to be overwritten
    :::

    ```lua
    function State:CanChangeState(targetState: string)
        return targetState == "Blue" -- If the target state is blue, we can change to it
    end
    ```

    @param _targetState string -- The state we are trying to change to

    @return boolean -- Whether or not we can change to the given state
]=]
function State:CanChangeState(_targetState: string): boolean
    return true
end

--[=[
    :::info
    This is a **Virtual Method**. Virtual Methods are meant to be overwritten
    :::

    :::warning
    **OnDataChanged** only gets called when the data is changed by a **ChangeData** call
    :::

    Called whenever the data of the state machine changes.

    ```lua
    function State:OnDataChanged(data, index, newValue, oldValue)
        if index == "SomeStartingData" then
            self.SomeStartingData = value
        end
    end
    ```

    @param _data {[string]: any} -- This is the data from the StateMachine itself!
    @param _index any -- The index of the data that changed
    @param _value any -- The new value of the data
    @param _oldValue any -- The old value of the data

    @return ()
]=]
function State:OnDataChanged(_data: {[string]: any}, _index: any, _value: any, _oldValue: any): ()

end

--[=[
    :::info
    This is a **Virtual Method**. Virtual Methods are meant to be overwritten
    :::

    Called whenever you enter this state

    ```lua
    function State:OnEnter(data)
        data.part.Color = Color3.fromRGB(0, 166, 255)
    end
    ```

    @param _data {[string]: any} -- This is the data from the StateMachine itself!

    @return ()
]=]
function State:OnEnter(_data: {[string]: any}): ()

end

--[=[
    :::info
    This is a **Virtual Method**. Virtual Methods are meant to be overwritten
    :::

    Called every frame after the physics simulation while in this state

    ```lua
    function Default:OnHeartbeat(data, deltaTime: number)
        self.timePassed += deltaTime
    end
    ```

    @param _data {[string]: any} -- This is the data from the StateMachine itself!
    @param _deltaTime number

    @return ()
]=]
function State:OnHeartbeat(_data: {[string]: any}, _deltaTime: number): ()

end

--[=[
    :::info
    This is a **Virtual Method**. Virtual Methods are meant to be overwritten
    :::

    Called whenever you leave this state

    ```lua
    function State:OnLeave(data)
        data.stuff:Clean()
    end
    ```

    @param _data {[string]: any} -- This is the data from the StateMachine itself!

    @return ()
]=]
function State:OnLeave(_data: {[string]: any}): ()

end

--[=[
    :::info
    This is a **Virtual Method**. Virtual Methods are meant to be overwritten
    :::

    Called whenever the state machine is destroyed

    ```lua
    function State:OnDestroy()
        print("I was destroyed!")
    end
    ```

    @return ()
]=]
function State:OnDestroy(): ()
    
end

export type State = typeof(State)

return setmetatable(State, {
    __call = function(_, properties): State
        return State.new(properties)
    end
})