"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[57],{69621:e=>{e.exports=JSON.parse('{"functions":[{"name":"new","desc":"Used to create a new State Machine. It expects 3 arguments being the third one an optional one\\n\\n```lua\\nlocal ReplicatedStorage = game:GetService(\\"ReplicatedStorage\\")\\n\\nlocal RobloxStateMachine = require(ReplicatedStorage.RobloxStateMachine)\\n\\nlocal exampleStateMachine: RobloxStateMachine.RobloxStateMachine = RobloxStateMachine.new(\\n    \\"Default\\",\\n    RobloxStateMachine:LoadDirectory(script.Example.States), \\n    {\\n        part = workspace.Example,\\n        time = tick(),\\n    }\\n)\\n```","params":[{"name":"initialState","desc":"The name of the state at which it should start","lua_type":"string"},{"name":"states","desc":"An array of the states this state machine should have","lua_type":"{State.State}"},{"name":"initialData","desc":"The starting data to be used by the states","lua_type":"{[string]: any}?"}],"returns":[{"desc":"","lua_type":"RobloxStateMachine"}],"function_type":"static","source":{"line":47,"path":"src/StateMachine/init.lua"}},{"name":"GetCurrentState","desc":"Returns the current state of the State Machine","params":[],"returns":[{"desc":"","lua_type":"string"}],"function_type":"method","source":{"line":90,"path":"src/StateMachine/init.lua"}},{"name":"ChangeData","desc":"Changing data request. You can also just Get the data and change the data at run time.\\n\\n```lua\\nlocal stateMachine = RobloxStateMachine.new(\\"state\\", states, {health = 0})\\n\\nstateMachine:GetData().health = 50 -- This is the same as\\nstateMachine:ChangeData(\\"Health\\", 50) -- this\\n```","params":[{"name":"index","desc":"","lua_type":"string"},{"name":"newValue","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"()"}],"function_type":"method","source":{"line":109,"path":"src/StateMachine/init.lua"}},{"name":"GetData","desc":"Gets the custom data of this state machine object.\\n\\n```lua\\nlocal stateMachine = RobloxStateMachine.new(\\"Start\\", {state1, state2}, {health = 20})\\n\\nprint(stateMachine:GetData().health) -- 20\\n```","params":[],"returns":[{"desc":"","lua_type":"{[string]: any}"}],"function_type":"method","source":{"line":130,"path":"src/StateMachine/init.lua"}},{"name":"LoadDirectory","desc":"Used to load thru a directory. It\'s specially useful to load states and or transitions!\\n\\n```lua\\nlocal exampleStateMachine: RobloxStateMachine.RobloxStateMachine = RobloxStateMachine.new(\\n    \\"Default\\",\\n    RobloxStateMachine:LoadDirectory(script.Example.States), \\n    {\\n        part = workspace.Example,\\n        time = tick(),\\n    }\\n)\\n```","params":[{"name":"directory","desc":"","lua_type":"Instance"}],"returns":[{"desc":"","lua_type":"{any}"}],"function_type":"method","source":{"line":152,"path":"src/StateMachine/init.lua"}},{"name":"Destroy","desc":"If you wish to stop using the state machine at any point you should then clear\\nit from the memory. Call Destroy whenever you are done with the state machine.\\n\\n```lua\\nlocal stateMachine = RobloxStateMachine.new(...)\\n\\ntask.wait(5)\\n\\nstateMachine:Destroy()\\n```","params":[],"returns":[{"desc":"","lua_type":"()"}],"function_type":"method","source":{"line":186,"path":"src/StateMachine/init.lua"}},{"name":"ChangeState","desc":"Forcelly changes the current state of our state machine to a new one","params":[{"name":"newState","desc":"The name of the new state","lua_type":"string"}],"returns":[{"desc":"","lua_type":"()"}],"function_type":"method","source":{"line":206,"path":"src/StateMachine/init.lua"}},{"name":"_ChangeState","desc":"Called to change the current state of the state machine","params":[{"name":"newState","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"()"}],"function_type":"method","private":true,"source":{"line":219,"path":"src/StateMachine/init.lua"}},{"name":"_GetCurrentStateObject","desc":"Gets the current state object of the state machine","params":[],"returns":[{"desc":"","lua_type":"State"}],"function_type":"method","private":true,"source":{"line":243,"path":"src/StateMachine/init.lua"}},{"name":"_CheckTransitions","desc":"Checks if we meet any condition to change the current state.\\nIf any of the transitions returns true then we should change the current state","params":[{"name":"fromHeartbeat","desc":"","lua_type":"boolean"}],"returns":[{"desc":"","lua_type":"()"}],"function_type":"method","private":true,"source":{"line":257,"path":"src/StateMachine/init.lua"}}],"properties":[],"types":[],"name":"StateMachine","desc":"State Machines consist of state managers that dictate at which state does an object currently meet at.\\nIt allows us to easily manage what should an object do at each given state and when/how it should change\\nbetween them","source":{"line":17,"path":"src/StateMachine/init.lua"}}')}}]);