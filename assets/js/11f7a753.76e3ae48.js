"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[984],{3905:(e,t,n)=>{n.d(t,{Zo:()=>u,kt:()=>f});var a=n(67294);function r(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function o(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);t&&(a=a.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,a)}return n}function i(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?o(Object(n),!0).forEach((function(t){r(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):o(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function l(e,t){if(null==e)return{};var n,a,r=function(e,t){if(null==e)return{};var n,a,r={},o=Object.keys(e);for(a=0;a<o.length;a++)n=o[a],t.indexOf(n)>=0||(r[n]=e[n]);return r}(e,t);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(a=0;a<o.length;a++)n=o[a],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(r[n]=e[n])}return r}var s=a.createContext({}),c=function(e){var t=a.useContext(s),n=t;return e&&(n="function"==typeof e?e(t):i(i({},t),e)),n},u=function(e){var t=c(e.components);return a.createElement(s.Provider,{value:t},e.children)},p="mdxType",d={inlineCode:"code",wrapper:function(e){var t=e.children;return a.createElement(a.Fragment,{},t)}},h=a.forwardRef((function(e,t){var n=e.components,r=e.mdxType,o=e.originalType,s=e.parentName,u=l(e,["components","mdxType","originalType","parentName"]),p=c(n),h=r,f=p["".concat(s,".").concat(h)]||p[h]||d[h]||o;return n?a.createElement(f,i(i({ref:t},u),{},{components:n})):a.createElement(f,i({ref:t},u))}));function f(e,t){var n=arguments,r=t&&t.mdxType;if("string"==typeof e||r){var o=n.length,i=new Array(o);i[0]=h;var l={};for(var s in t)hasOwnProperty.call(t,s)&&(l[s]=t[s]);l.originalType=e,l[p]="string"==typeof e?e:r,i[1]=l;for(var c=2;c<o;c++)i[c]=n[c];return a.createElement.apply(null,i)}return a.createElement.apply(null,n)}h.displayName="MDXCreateElement"},79724:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>s,contentTitle:()=>i,default:()=>d,frontMatter:()=>o,metadata:()=>l,toc:()=>c});var a=n(87462),r=(n(67294),n(3905));const o={sidebar_position:6,sidebar_label:"\ud83d\udd1a  Final Steps"},i="\ud83d\udd1a  Final Steps",l={unversionedId:"tutorial/Finish",id:"tutorial/Finish",title:"\ud83d\udd1a  Final Steps",description:"Now that we have both our States and Transitions we should connect our transitions to the states! You can do this by going into the Red and Blue state and add a Transitions array with every transition you want. See the following examples",source:"@site/docs/tutorial/Finish.md",sourceDirName:"tutorial",slug:"/tutorial/Finish",permalink:"/RobloxStateMachine/docs/tutorial/Finish",draft:!1,editUrl:"https://github.com/prooheckcp/RobloxStateMachine/edit/master/docs/tutorial/Finish.md",tags:[],version:"current",sidebarPosition:6,frontMatter:{sidebar_position:6,sidebar_label:"\ud83d\udd1a  Final Steps"},sidebar:"defaultSidebar",previous:{title:"\ud83d\udd00 Transitions",permalink:"/RobloxStateMachine/docs/tutorial/Transitions"},next:{title:"\ud83d\udcc2 Load Directories",permalink:"/RobloxStateMachine/docs/AdvancedConcepts/loadDirectories"}},s={},c=[{value:"7. Watch and enjoy!",id:"7-watch-and-enjoy",level:2}],u={toc:c},p="wrapper";function d(e){let{components:t,...n}=e;return(0,r.kt)(p,(0,a.Z)({},u,n,{components:t,mdxType:"MDXLayout"}),(0,r.kt)("h1",{id:"--final-steps"},"\ud83d\udd1a  Final Steps"),(0,r.kt)("p",null,"Now that we have both our States and Transitions we should connect our transitions to the states! You can do this by going into the Red and Blue state and add a Transitions array with every transition you want. See the following examples"),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-lua"},'--blue.lua\nlocal Blue = RobloxStateMachine.State.new("Blue") -- The name of our state\nBlue.Transitions = {\n    require(ReplicatedStorage.Transitions.ToRed)\n}\n')),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-lua"},'--red.lua\nlocal Red = RobloxStateMachine.State.new("Red") -- The name of our state\nRed.Transitions = {\n    require(ReplicatedStorage.Transitions.ToBlue)\n}\n')),(0,r.kt)("h2",{id:"7-watch-and-enjoy"},"7. Watch and enjoy!"),(0,r.kt)("p",null,"Now that we have finally done all of this you can see it in action! Just press play and enjoy seeing the State Machine Working!"),(0,r.kt)("p",null,"Had problems during the tutorial? Check the copy unlocked place here:\n",(0,r.kt)("a",{parentName:"p",href:"https://www.roblox.com/games/13401789032/RobloxStateMachine-Copy-Unlocked"},"https://www.roblox.com/games/13401789032/RobloxStateMachine-Copy-Unlocked")))}d.isMDXComponent=!0}}]);