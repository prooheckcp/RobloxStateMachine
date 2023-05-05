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

--[=[
    [Virtual method]

    Called whenever a state machine is created with this state
]=]
function State:OnInit(data: {[string]: any}): ()
    assert(data)
end

--[=[
    [Virtual method]

    Called whenever you enter this state
]=]
function State:OnEnter(data: {[string]: any}): ()
    assert(data)
end

--[=[
    [Virtual method]

    Called every frame after the physics simulation while in this state
]=]
function State:OnHearBeat(data: {[string]: any}, deltaTime: number): ()
    assert(data)
end

--[=[
    [Virtual method]

    Called whenever you leave this state
]=]
function State:OnLeave(data: {[string]: any}): ()
    assert(data)
end

export type State = typeof(State)

return State