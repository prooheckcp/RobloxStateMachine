local RunService = game:GetService("RunService")

local State = require(script.State)
local Transition = require(script.Transition)
local Signal = require(script.Signal)
local Copy = require(script.Copy)

local DUPLICATE_ERROR: string = "There cannot be more than 1 state by the same name"

--[=[
    @class StateMachine

    State Machines consist of state managers that dictate at which state does an object currently meet at.
    It allows us to easily manage what should an object do at each given state and when/how it should change
    between them
]=]
local StateMachine = {}
StateMachine.__index = StateMachine
StateMachine.StateChanged = nil :: Signal.Signal<string>?
StateMachine.State = State
StateMachine.Transition = Transition

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
function StateMachine.new(initialState: string, states: {State.State}, initialData: {[string]: any}?): RobloxStateMachine
    local self = setmetatable({}, StateMachine)
    
    self._CustomData = initialData or {} :: {[string]: any}
    self._States = {} :: {[string]: State.State}
    self.StateChanged = Signal.new() :: Signal.Signal<string>

    for _, state: State.State in states do -- Load the states
        if self._States[state.Name] then
            error(DUPLICATE_ERROR.." ,"..state.Name, 2)
        end

        local stateClone: State.State = Copy(state)
        
        stateClone:OnInit(self._CustomData)
        self._States[state.Name] = stateClone
    end

    self.heartBeat = RunService.Heartbeat:Connect(function(deltaTime: number)
        self:_CheckTransitions(true)
        
        local state: State.State? = self:_GetCurrentStateObject()
        
        if not state or getmetatable(state).OnHearBeat == state.OnHearBeat then
            return
        end

        state:OnHearBeat(self._CustomData, deltaTime)
    end)

    self:_ChangeState(initialState)

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
    if self._CustomData[index] == newValue then
        return
    end

    self._CustomData[index] = newValue

    self:_CheckTransitions(false)
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
    return self._CustomData
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

    @param directory Instance

    @return {any}
]=]
function StateMachine:LoadDirectory(directory: Instance): {any}
    local loadedFiles = {}

    for _, child: Instance in directory:GetChildren() do
        if not child:IsA("ModuleScript") then
            continue
        end
        
        local success: boolean, result: any = pcall(function()
            return require(child)
        end)

        if success then
            table.insert(loadedFiles, result)
        end
    end

    return loadedFiles
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
    local state: State.State? = self:_GetCurrentStateObject()

    if state then
        state:OnLeave(self._CustomData)
    end

    if self.heartBeat then
        self.heartBeat:Disconnect()
        self.heartBeat = nil
    end
end

--[=[
    Forcelly changes the current state of our state machine to a new one

    @param newState string -- The name of the new state

    @return ()
]=]
function StateMachine:ChangeState(newState: string): ()
    self:_ChangeState(newState)
end

--[=[
    Called to change the current state of the state machine

    @private

    @param newState string

    @return ()
]=]
function StateMachine:_ChangeState(newState: string): ()
    local previousState: State.State? = self:_GetCurrentStateObject()
    local state: State.State? = self._States[newState]

    if not state then
        return
    end

    if previousState then
        previousState:OnLeave(self._CustomData)
    end

    state:OnEnter(self._CustomData)
    self._CurrentState = newState
    self.StateChanged:Fire(newState)
end

--[=[
    Gets the current state object of the state machine

    @private

    @return State
]=]
function StateMachine:_GetCurrentStateObject(): State.State?
    return self._States[self:GetCurrentState()]
end

--[=[
    Checks if we meet any condition to change the current state.
    If any of the transitions returns true then we should change the current state

    @private

    @param fromHeartbeat boolean

    @return ()
]=]
function StateMachine:_CheckTransitions(fromHeartbeat: boolean): ()
    for _, transition: Transition.Transition in self:_GetCurrentStateObject().Transitions do
        if fromHeartbeat and not transition.OnHearbeat then
            continue
        end

        if transition:CanChangeState(self._CustomData) and transition:OnDataChanged(self._CustomData) then
            self:_ChangeState(transition.TargetState)
            break
        end
    end    
end

export type RobloxStateMachine = typeof(StateMachine)

return StateMachine