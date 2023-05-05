local Transition = {}
Transition.__index = Transition
Transition.TargetState = "" :: string
Transition.OnHearbeat = true :: boolean -- If it should be checked every frame

function Transition.new(targetState: string?)
    local self = setmetatable({}, Transition)
    self.TargetState = targetState or ""

    return self
end

--[=[
    [Virtual Method]

    Whether it can change to this state or not

    True -- Can change
    False -- Cannot

    @param data {[string]: any}

    @return boolean
]=]
function Transition:CanChangeState(data: {[string]: any}): boolean
    assert(data)
    return true
end

--[=[
    [Virtual method]
    
    Should return true if it should change to this state
    and false if it shouldn't

    @param data {[string]: any}

    @return boolean
]=]
function Transition:OnDataChanged(data: {[string]: any}): boolean
    assert(data)
    return false
end

export type Transition = typeof(Transition)

return Transition