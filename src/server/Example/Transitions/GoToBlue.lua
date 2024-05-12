local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local StateMachine = require(ReplicatedStorage.RobloxStateMachine)
local Transition = StateMachine.Transition

local GoToBlue = Transition "Blue"
GoToBlue.Name = "GoToBlue"

function GoToBlue:OnInit()
   -- print("Init our transition!")
end

function GoToBlue:OnEnter()
    --print("Enter")
end

function GoToBlue:OnDataChanged(data)
    for _, player: Player in Players:GetPlayers() do
        if not player.Character or not player.Character.PrimaryPart then
            continue
        end

        local partPosition: Vector3 = data.part.Position
        local playerPosition: Vector3 = player.Character.PrimaryPart.Position     
        local distance: number = (partPosition - playerPosition).Magnitude

        if distance < 10 then
            return true
        end
    end

    return false
end

function GoToBlue:OnLeave()
    --print("Leave", self.Data)
end

function GoToBlue:OnDestroy()
    --print("Destroy our transition")
end

return GoToBlue