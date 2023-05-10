"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[909],{62643:e=>{e.exports=JSON.parse('{"functions":[{"name":"new","desc":"Used to create a new State. The state should manage how the object should behave during\\nthat given state. I personally recommend having your states in their own files for organizational\\npurposes\\n\\n```lua\\nlocal ReplicatedStorage = game:GetService(\\"ReplicatedStorage\\")\\n\\nlocal StateMachine = require(ReplicatedStorage.RobloxStateMachine)\\nlocal State = StateMachine.State\\n\\nlocal Default = State.new(\\"Blue\\") -- The name of this state is \\"Blue\\"\\nDefault.Transitions = { -- The transitions that will be listened to while in the blue state\\n    transition1,\\n    transition2\\n}\\nfunction Default:OnEnter(data)\\n    data.part.Color = Color3.fromRGB(0, 166, 255) --This will turn the part Blue when it enters the state blue\\nend\\n\\nreturn Default\\n```","params":[{"name":"stateName","desc":"","lua_type":"string?"}],"returns":[{"desc":"","lua_type":"State"}],"function_type":"static","source":{"line":42,"path":"src/StateMachine/State.lua"}},{"name":"ChangeState","desc":"Forcelly changes the current state of our state machine to a new one","params":[{"name":"newState","desc":"The name of the new state","lua_type":"string"}],"returns":[{"desc":"","lua_type":"()"}],"function_type":"method","source":{"line":58,"path":"src/StateMachine/State.lua"}},{"name":"OnInit","desc":":::info\\nThis is a **Virtual Method**. Virtual Methods are meant to be overwritten\\n:::\\n\\nCalled whenever a state machine is created with this state.\\n\\n```lua\\nfunction State:OnInit(data)\\n    print(\\"I was init!\\")\\n    self.SomeStartingData = tick()\\nend\\n```","params":[{"name":"data","desc":"This is the data from the StateMachine itself!","lua_type":"{[string]: any}"}],"returns":[{"desc":"","lua_type":"()"}],"function_type":"method","source":{"line":84,"path":"src/StateMachine/State.lua"}},{"name":"OnEnter","desc":":::info\\nThis is a **Virtual Method**. Virtual Methods are meant to be overwritten\\n:::\\n\\nCalled whenever you enter this state\\n\\n```lua\\nfunction State:OnEnter(data)\\n    data.part.Color = Color3.fromRGB(0, 166, 255)\\nend\\n```","params":[{"name":"data","desc":"This is the data from the StateMachine itself!","lua_type":"{[string]: any}"}],"returns":[{"desc":"","lua_type":"()"}],"function_type":"method","source":{"line":105,"path":"src/StateMachine/State.lua"}},{"name":"OnHearBeat","desc":":::info\\nThis is a **Virtual Method**. Virtual Methods are meant to be overwritten\\n:::\\n\\nCalled every frame after the physics simulation while in this state\\n\\n```lua\\nfunction Default:OnHearBeat(data, deltaTime: number)\\n    self.timePassed += deltaTime\\nend\\n```","params":[{"name":"data","desc":"This is the data from the StateMachine itself!","lua_type":"{[string]: any}"},{"name":"deltaTime","desc":"","lua_type":"number"}],"returns":[{"desc":"","lua_type":"()"}],"function_type":"method","source":{"line":127,"path":"src/StateMachine/State.lua"}},{"name":"OnLeave","desc":":::info\\nThis is a **Virtual Method**. Virtual Methods are meant to be overwritten\\n:::\\n\\nCalled whenever you leave this state\\n\\n```lua\\nfunction State:OnLeave(data)\\n    data.stuff:Clean()\\nend\\n```","params":[{"name":"data","desc":"This is the data from the StateMachine itself!","lua_type":"{[string]: any}"}],"returns":[{"desc":"","lua_type":"()"}],"function_type":"method","source":{"line":148,"path":"src/StateMachine/State.lua"}}],"properties":[],"types":[],"name":"State","desc":"Describes one of the many states an object can have. It also declares\\nhow it should behave when it enters, is and leaves the given state","source":{"line":9,"path":"src/StateMachine/State.lua"}}')}}]);