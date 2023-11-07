"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[384],{3905:(e,t,n)=>{n.d(t,{Zo:()=>s,kt:()=>h});var a=n(67294);function r(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function o(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);t&&(a=a.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,a)}return n}function i(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?o(Object(n),!0).forEach((function(t){r(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):o(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function l(e,t){if(null==e)return{};var n,a,r=function(e,t){if(null==e)return{};var n,a,r={},o=Object.keys(e);for(a=0;a<o.length;a++)n=o[a],t.indexOf(n)>=0||(r[n]=e[n]);return r}(e,t);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(a=0;a<o.length;a++)n=o[a],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(r[n]=e[n])}return r}var c=a.createContext({}),u=function(e){var t=a.useContext(c),n=t;return e&&(n="function"==typeof e?e(t):i(i({},t),e)),n},s=function(e){var t=u(e.components);return a.createElement(c.Provider,{value:t},e.children)},d="mdxType",p={inlineCode:"code",wrapper:function(e){var t=e.children;return a.createElement(a.Fragment,{},t)}},m=a.forwardRef((function(e,t){var n=e.components,r=e.mdxType,o=e.originalType,c=e.parentName,s=l(e,["components","mdxType","originalType","parentName"]),d=u(n),m=r,h=d["".concat(c,".").concat(m)]||d[m]||p[m]||o;return n?a.createElement(h,i(i({ref:t},s),{},{components:n})):a.createElement(h,i({ref:t},s))}));function h(e,t){var n=arguments,r=t&&t.mdxType;if("string"==typeof e||r){var o=n.length,i=new Array(o);i[0]=m;var l={};for(var c in t)hasOwnProperty.call(t,c)&&(l[c]=t[c]);l.originalType=e,l[d]="string"==typeof e?e:r,i[1]=l;for(var u=2;u<o;u++)i[u]=n[u];return a.createElement.apply(null,i)}return a.createElement.apply(null,n)}m.displayName="MDXCreateElement"},55627:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>c,contentTitle:()=>i,default:()=>p,frontMatter:()=>o,metadata:()=>l,toc:()=>u});var a=n(87462),r=(n(67294),n(3905));const o={sidebar_position:4,sidebar_label:"\ud83d\udcc2 Sending Data"},i="\ud83d\udcc2 Sending Data",l={unversionedId:"tutorial/ChangeData",id:"tutorial/ChangeData",title:"\ud83d\udcc2 Sending Data",description:"Something that is very important is to change our State Machine data from within the state. Let's go into the blue state and add a timer, this will tell us how long since we have entered the blue state. It will later help us to transition between the 2 states after X amount of seconds!",source:"@site/docs/tutorial/ChangeData.md",sourceDirName:"tutorial",slug:"/tutorial/ChangeData",permalink:"/RobloxStateMachine/docs/tutorial/ChangeData",draft:!1,editUrl:"https://github.com/prooheckcp/RobloxStateMachine/edit/master/docs/tutorial/ChangeData.md",tags:[],version:"current",sidebarPosition:4,frontMatter:{sidebar_position:4,sidebar_label:"\ud83d\udcc2 Sending Data"},sidebar:"defaultSidebar",previous:{title:"\ud83e\udd16\ud83d\udd04 State Machine",permalink:"/RobloxStateMachine/docs/tutorial/StateMachine"},next:{title:"\ud83d\udd00 Transitions",permalink:"/RobloxStateMachine/docs/tutorial/Transitions"}},c={},u=[],s={toc:u},d="wrapper";function p(e){let{components:t,...n}=e;return(0,r.kt)(d,(0,a.Z)({},s,n,{components:t,mdxType:"MDXLayout"}),(0,r.kt)("h1",{id:"-sending-data"},"\ud83d\udcc2 Sending Data"),(0,r.kt)("p",null,"Something that is very important is to change our State Machine data from within the state. Let's go into the blue state and add a timer, this will tell us how long since we have entered the blue state. It will later help us to transition between the 2 states after X amount of seconds!"),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-lua"},'local ReplicatedStorage = game:GetService("ReplicatedStorage")\n\nlocal RobloxStateMachine = require(ReplicatedStorage.RobloxStateMachine)\n\nlocal Blue = RobloxStateMachine.State.new("Blue") -- The name of our state\n\nfunction Blue:OnInit()\n    print("Blue Init!")\nend\n\nfunction Blue:OnEnter(data)\n    print("Blue Enter!")\n    data.timer = 0 -- Create timer in data\n    data.part.Color = Color3.fromRGB(0, 0, 255) -- Change color to blue!\nend\n\nfunction Blue:OnHearBeat(data, deltatime) -- All functions receive data as the first parameter\n    data.timer += deltatime\nend\n\nfunction Blue:OnLeave()\n    print("Blue Leave!")\nend\n\nreturn Blue\n')),(0,r.kt)("p",null,'Great now we completely finished our blue state! Now let\'s just copy paste the blue state into the red state and change the colour to Red and the name of the state from Blue to "Red".'),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-lua"},'local ReplicatedStorage = game:GetService("ReplicatedStorage")\n\nlocal RobloxStateMachine = require(ReplicatedStorage.RobloxStateMachine)\n\nlocal Red = RobloxStateMachine.State.new("Red") -- The name of our state\n\nfunction Red:OnInit()\n    print("Red Init!")\nend\n\nfunction Red:OnEnter(data)\n    print("Red Enter!")\n    data.timer = 0 -- Create timer in data\n    data.part.Color = Color3.fromRGB(255, 0, 0) -- Change color to red!\nend\n\nfunction Red:OnHearBeat(data, deltatime) -- All functions receive data as the first parameter\n    data.timer += deltatime\nend\n\nfunction Red:OnLeave()\n    print("Red Leave!")\nend\n\nreturn Red\n')),(0,r.kt)("p",null,"Don't forget to add the red state to our state machine!"),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-lua"},'RobloxStateMachine.new("Blue",\n{\nrequire(states.Blue),\nrequire(states.Red)\n},\n{\npart = workspace.myPart\n}\n)\n')))}p.isMDXComponent=!0}}]);