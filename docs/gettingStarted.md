---
sidebar_position: 2
sidebar_label: "🚀Getting Started"
---
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# 🚀Getting Started

## 📦 Installing

RobloxStateMachine can be installed in different ways, depending on your project's needs. Choose the method that suits you best:

<Tabs className="unique-tabs">
  <TabItem value="wally" label="🐶 Wally" default>
        <a href="https://wally.run/package/prooheckcp/robloxstatemachine">Watch wally's page</a>
        <pre><code className="language-bash">{`robloxstatemachine = "prooheckcp/robloxstatemachine@>0.0.0, <10.0.0"`}</code></pre>
  </TabItem>
  <TabItem value="studio" label="🔨Studio">
    <a href="https://www.roblox.com/library/13401856320/RobloxStateMachine">Get the Roblox Model</a>
  </TabItem>
  <TabItem value="github" label="🐙GitHub">
  <a href="https://github.com/prooheckcp/RobloxStateMachine/releases">Download from Github Releases</a>
  </TabItem>
</Tabs>


# 🚀 Basic Usage

Once you have RobloxStateMachine installed, you can start using it in your project. Here's a basic example of how to use it:

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RobloxStateMachine = require(ReplicatedStorage.RobloxStateMachine)
local exampleStateMachine = RobloxStateMachine.new(
    "InitialState", -- Sets our initial state to "InitialState"
    RobloxStateMachine:LoadDirectory(
        script.Example.States, 
        {"Blue", "Default"}), -- "Loads the states called "Blue" and "Default"
    {
        part = workspace.Example, -- Sends a reference to a part from workspace into the state machine
        time = tick(), -- Sends the current tick
        dummyData = "Hello World", -- Sends a string
    }
)
```

Looks a bit confusing at the first glance and for that reason we will be showing a very basic example of an implementation.