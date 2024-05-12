local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local State = require(script.Classes.State)
local Transition = require(script.Classes.Transition)
local Signal = require(script.Vendor.Signal)
local Trove = require(script.Vendor.Trove)
local Copy = require(script.Functions.deepCopy)

type Trove = Trove.Trove

local DUPLICATE_ERROR: string = "There cannot be more than 1 state by the same name"
local DATA_WARNING: string = "[Warning]: The data of this state machine is not a table. It will be converted to a table. Please do not set data to a non table object"
local STATE_NOT_FOUND: string = "Attempt to %s, but there is no state by the name of %s"
local WRONG_TRANSITION: string = "Attempt to add a transition that is not a transition"

-- Used for quicker access to the directories
local cacheDirectories = {} :: {[Instance]: {any}}

--[=[
    @class StateMachine

    State Machines consist of state managers that dictate at which state does an object currently meet at.
    It allows us to easily manage what should an object do at each given state and when/how it should change
    between them
]=]
local StateMachine = {}
StateMachine.__index = StateMachine
--[=[
    @prop Data {[string]: any}
    @within StateMachine

    Contains the data that is shared accross all states and transitions of this state machine. Should be accessed with :GetData

    E.g
    ```lua
    local stateMachine = RobloxStateMachine.new("state", states, {health = 0})
    stateMachine:GetData().health = 50
    ```

    The data is shared accross all states and transitions. It can be access in 2 different ways

    ```lua
    --transition.lua
    local GoToBlue = Transition.new("Blue")

    function GoToBlue:OnDataChanged(data)
        print(self.Data, data) -- 2 ways to access the data
        return false
    end

    --state.lua
    local Default: State = State.new("Blue")

    function Default:OnInit(data)
        print(self.Data, data)
    end
    ```
]=]
StateMachine.Data = {} :: {[string]: any}
--[=[
    @prop StateChanged⚡ Signal<(string, string)>?
    @within StateMachine

    Called whenever the state of this state machinse changes. The first argument
    is the new state and the second one is the previous state. If there was no previous state
    then it will be an empty string

    e.g
    ```lua
    exampleStateMachine.StateChanged:Connect(function(newState: string, previousState: string)
        print("Our previous state was: " .. previousState .. " now our state is: " .. newState)
    end)
    ```
]=]
StateMachine.StateChanged = nil :: Signal.Signal<(string, string)>?
--[=[
    @prop DataChanged⚡ Signal<({[string]: any}, any, any, any)>?
    @within StateMachine

    Called whenever the data from the state machine gets changed. 

    :::warning
    **DataChanged** only gets called when the data is changed by a **ChangeData** call
    :::

    e.g
    ```lua
    exampleStateMachine.StateChanged:Connect(function(newState: string, previousState: string)
        print("Our previous state was: " .. previousState .. " now our state is: " .. newState)
    end)
    ```
]=]
StateMachine.DataChanged = nil :: Signal.Signal<({[string]: any}, any, any, any)>?
--[=[
    @prop State State
    @within StateMachine

    A reference to the State class
]=]
StateMachine.State = State
--[=[
    @prop Transition Transition
    @within StateMachine

    A reference to the Transition class
]=]
StateMachine.Transition = Transition
--[=[
    @prop _States {[string]: State}
    @within StateMachine
    @private

    Caches the states of this state machine. It's used to change states and check transitions
]=]
StateMachine._States = {} :: {[string]: State}
--[=[
    @prop _trove Trove
    @within StateMachine
    @private

    A trove object to store and clear up connections
]=]
StateMachine._trove = newproxy() :: Trove
--[=[
    @prop _stateTrove Trove
    @within StateMachine
    @private

    A trove object to clear state threads and connections
]=]
StateMachine._stateTrove = newproxy() :: Trove
--[=[
    @prop _CurrentState string
    @within StateMachine
    @private

    Caches the current state in a string format. It's used to fire the StateChanged signal
]=]
StateMachine._CurrentState = "" :: string
--[=[
    @prop _PreviousState string
    @within StateMachine
    @private

    Caches the previous state in a string format. It's used to fire the StateChanged signal
]=]
StateMachine._PreviousState = "" :: string
--[=[
    @prop _Destroyed boolean
    @within StateMachine
    @private

    Checks if the object has already been destroyed or not
]=]
StateMachine._Destroyed = false :: boolean
--[=[
    Used to create a new State Machine. It expects 3 arguments being the third one an optional one

    ```lua
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local RobloxStateMachine = require(ReplicatedStorage.RobloxStateMachine)

    local exampleStateMachine: RobloxStateMachine.RobloxStateMachine = RobloxStateMachine.new(
        "Default",
        RobloxStateMachine:LoadDirectory(script.Example.States), 
        {
            part = workspace.Example,
            time = tick(),
        }
    )
    ```

    @param initialState string -- The name of the state at which it should start
    @param states {State.State} -- An array of the states this state machine should have
    @param initialData {[string]: any}? -- The starting data to be used by the states

    @return RobloxStateMachine
]=]
function StateMachine.new(initialState: string, states: {State}, initialData: {[string]: any}?): RobloxStateMachine
    local self = setmetatable({}, StateMachine)

    self._States = {} :: {[string]: State}
    self._trove = Trove.new()
    self._stateTrove = Trove.new()

    self._Destroyed = false
    
    self.Data = initialData or {} :: {[string]: any}
    self.StateChanged = Signal.new() :: Signal.Signal<(string, string)>
    self.DataChanged = Signal.new() :: Signal.Signal<({[string]: any}, any, any, any)>?

    for _, state: State.State in states do -- Load the states
        if self._States[state.Name] then
            error(DUPLICATE_ERROR.." \""..state.Name.."\"", 2)
        end

        local stateClone: State.State = Copy(state)
        stateClone.Data = self.Data
        stateClone._changeState = function(newState: string)
            self:ChangeState(newState)
        end
        stateClone._changeData = function(index: string, newValue: any)
            self:ChangeData(index, newValue)
        end
        stateClone._getState = function()
            return self:GetCurrentState()
        end
        stateClone._getPreviousState = function()
            return self:GetPreviousState()
        end

        stateClone._transitions = {}

        for _, transition: Transition in stateClone.Transitions do
            if #transition.Name == 0 then
                transition.Name = HttpService:GenerateGUID(false)
            end

            local transitionClone: Transition = Copy(transition)
            transitionClone._changeData = function(index: string, newValue: any)
                self:ChangeData(index, newValue)
            end
            transitionClone._getState = function()
                return self:GetCurrentState()
            end
            transitionClone._getPreviousState = function()
                return self:GetPreviousState()
            end

            if transitionClone.Type ~= Transition.Type then
                error(WRONG_TRANSITION, 2)
            end
 
            transitionClone.Data = stateClone.Data
            transitionClone._changeState = function(newState: string)
                self:ChangeState(newState)
            end

            stateClone._transitions[transitionClone.Name] = transitionClone
            task.spawn(transitionClone.OnInit, transitionClone, self.Data)
            self._trove:Add(transitionClone, "OnDestroy")
        end

        self._States[state.Name] = stateClone
        task.spawn(stateClone.OnInit, stateClone, self.Data)
        self._trove:Add(stateClone, "OnDestroy")
    end

    if not self._States[initialState] then
        error(STATE_NOT_FOUND:format("create a state machine", initialState), 2)
    end

    local previousState: State = nil
    self._trove:Add(RunService.Heartbeat:Connect(function(deltaTime: number)
        if self._Destroyed then
            return
        end

        self:_CheckTransitions()
        
        local state = self:_GetCurrentStateObject()
        local firstFrame: boolean = state ~= previousState
        previousState = state
        if firstFrame then
            return
        end

        if not state or getmetatable(state).OnHeartbeat == state.OnHeartbeat then
            return
        end

        task.spawn(state.OnHeartbeat, state, self:GetData(), deltaTime)
    end))

    self._trove:Add(self.StateChanged)
    self._trove:Add(self.DataChanged)

    self:_ChangeState(initialState)

    return self
end

--[=[
    Returns the current state of the State Machine

    ```lua
    local exampleStateMachine = RobloxStateMachine.new("Default", {}, {})
    print(exampleStateMachine:GetCurrentState()) -- Default
    ```

    @return string
]=]
function StateMachine:GetCurrentState(): string
    return self._CurrentState
end

--[=[
    Returns the previous state of the State Machine

    ```lua
    local exampleStateMachine = RobloxStateMachine.new("Default", {...BlueStateHere}, {})
    exampleStateMachine:ChangeState("Blue")
    print(exampleStateMachine:GetPreviousState()) -- "Default"
    ```

    @return string
]=]
function StateMachine:GetPreviousState(): string
    return self._PreviousState
end

--[=[
    Changing data request. You can also just Get the data and change the data at run time.

    ```lua
    local stateMachine = RobloxStateMachine.new("state", states, {health = 0})

    stateMachine:GetData().health = 50 -- This is the same as
    stateMachine:ChangeData("Health", 50) -- this
    ```

    @param index string
    @param newValue any

    @return ()
]=]
function StateMachine:ChangeData(index: string, newValue: any): ()
    if self._Destroyed or self.Data[index] == newValue then
        return
    end
    
    local oldValue: any = self.Data[index]
    self.Data[index] = newValue

    local state: State = self._States[self:GetCurrentState()]
    task.spawn(state.OnDataChanged, state, self.Data, index, newValue, oldValue)
    self.DataChanged:Fire(self.Data, index, newValue, oldValue)
end

--[=[
    Gets the custom data of this state machine object.

    ```lua
    local stateMachine = RobloxStateMachine.new("Start", {state1, state2}, {health = 20})

    print(stateMachine:GetData().health) -- 20
    ```

    @return {[string]: any}
]=]
function StateMachine:GetData(): {[string]: any}
    if typeof(self.Data) ~= "table" then
        warn(DATA_WARNING)
        self.Data = {}
    end

    return self.Data
end

--[=[
    Used to load thru a directory. It's specially useful to load states and or transitions!

    ```lua
    local exampleStateMachine: RobloxStateMachine.RobloxStateMachine = RobloxStateMachine.new(
        "Default",
        RobloxStateMachine:LoadDirectory(script.Example.States), 
        {
            part = workspace.Example,
            time = tick(),
        }
    )
    ```

    You can also use it to load specific files by feeding the names you wish to load


    @param directory Instance
    @param names {string}? -- If you wish to only load specific states you can pass an array of names

    @return {any}
]=]
function StateMachine:LoadDirectory(directory: Instance, names: {string}?): {any}
    if not cacheDirectories[directory] then
        cacheDirectories[directory] = {}

        for _, child: Instance in directory:GetDescendants() do
            if not child:IsA("ModuleScript") then
                continue
            end
            
            local success: boolean, result: any = pcall(function()
                return require(child)
            end)

            if 
                not success or
                typeof(result) ~= "table"
            then
                continue
            end

            if result.Type ~= State.Type and result.Type ~= Transition.Type then
                continue
            end

            if not result.Name or result.Name == "" then
                result.Name = child.Name
            end
            
            table.insert(cacheDirectories[directory], result)
        end
    end

    if not names then
        return cacheDirectories[directory]
    end

    local filteredFiles = {}

    for _, file in cacheDirectories[directory] do
        if table.find(names, file.Name) then
            table.insert(filteredFiles, file)
        end
    end

    return filteredFiles
end

--[=[
    If you wish to stop using the state machine at any point you should then clear
    it from the memory. Call Destroy whenever you are done with the state machine.

    ```lua
    local stateMachine = RobloxStateMachine.new(...)

    task.wait(5)

    stateMachine:Destroy()
    ```

    @return ()
]=]
function StateMachine:Destroy(): ()
    if self._Destroyed then
        return
    end
    
    self._Destroyed = true
    
    local state: State? = self:_GetCurrentStateObject()

    if state then
        task.spawn(state.OnLeave, state, self:GetData())
    end

    self._trove:Destroy()
    self._stateTrove:Destroy()
end

--[=[
    Forcelly changes the current state of our state machine to a new one

    @param newState string -- The name of the new state

    @return ()
]=]
function StateMachine:ChangeState(newState: string): ()
    local currentState: State? = self:_GetCurrentStateObject()

    if currentState and not currentState:CanChangeState(newState) then
        return
    end

    self:_ChangeState(newState)
end

--[=[
    Checks if the state exists

    @private

    @param stateName string

    @return boolean
]=]
function StateMachine:_StateExists(stateName: string): boolean
    return self._States[stateName] ~= nil
end

--[=[
    Called to change the current state of the state machine

    @private

    @param newState string

    @return ()
]=]
function StateMachine:_ChangeState(newState: string): ()
    if self._Destroyed then
        return
    end
    
    assert(self:_StateExists(newState), STATE_NOT_FOUND:format(`change to {newState}`, newState))

    if self._CurrentState == newState then
        return
    end

    local previousState: State? = self:_GetCurrentStateObject()
    local state: State? = self._States[newState]

    if not state then
        return
    end

    self._stateTrove:Clean()
    if previousState then
        task.spawn(previousState.OnLeave, previousState, self:GetData())
        self:_CallTransitions(previousState, "OnLeave", self:GetData())
    end

    task.defer(function()
        self:_CallTransitions(state, "OnEnter", self:GetData())
    end)
    self._stateTrove:Add(task.defer(state.OnEnter, state, self:GetData()))
    
    self._CurrentState = newState

    if previousState then
        self._PreviousState = previousState.Name
        self.StateChanged:Fire(newState, previousState.Name or "")
    end
end

--[=[
    Gets the current state object of the state machine

    @private

    @return State
]=]
function StateMachine:_GetCurrentStateObject(): State?
    return self._States[self:GetCurrentState()]
end

--[=[
    Checks if we meet any condition to change the current state.
    If any of the transitions returns true then we should change the current state

    @private

    @return ()
]=]
function StateMachine:_CheckTransitions(): ()
    for _, transition: Transition in self:_GetCurrentStateObject()._transitions do
        if transition:CanChangeState(self:GetData()) and transition:OnDataChanged(self:GetData()) then
            self:ChangeState(transition.TargetState)
            break
        end
    end
end

--[=[
    Calls the transition method of the given state

    @param state State
    @param methodName string
    @param ... any

    @private

    @return ()
]=]
function StateMachine:_CallTransitions(state: State, methodName: string, ...: any): ()
    for _, transition: Transition in state._transitions do
        task.spawn(transition[methodName], transition, ...)
    end
end

export type RobloxStateMachine = typeof(StateMachine)
export type State = State.State
export type Transition = Transition.Transition

return setmetatable(StateMachine, {
    __call = function(_, initialState: string, states: {State}, initialData: {[string]: any}?): RobloxStateMachine
        return StateMachine.new(initialState, states, initialData)
    end
})