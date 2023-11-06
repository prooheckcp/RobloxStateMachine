---
sidebar_position: 1
sidebar_label: "🧹 Organization"
---

# 🧹 Organization

Remember, the main purpose we use State Machines to begin with is so we can break down a complex system into smaller and simpler systems! So organization is key. I will be showing how I personally like to organize my State Machines. Obviously you can do it however you please yet I'd still highly recommend you to do it this way!

### A. First Create 2 folders
![](https://cdn.discordapp.com/attachments/670023265455964198/1105650053118431342/Screenshot_2023-05-10_at_01.18.06.png)

We will be using 1 folder to group the states and the second one to group the transitions! Now let's start by making 2 states and 2 transitions.

### B. Create 2 ModuleScripts in each folder as the following example
![](https://cdn.discordapp.com/attachments/670023265455964198/1105650694846947459/Screenshot_2023-05-10_at_01.20.53.png)

In this example we will be creating a state machine that manages the color of a part! it will have 2 states: a red and a blue colour.
So we want two states: Blue and Red. We also want to make 2 transitions that will allow us to go from blue to red and from red to blue!

### C. Create a Part and call it "myPart"
We will be creating a part in the workspace and use it as an example to how we can make/use the StateMachine
![](https://cdn.discordapp.com/attachments/670023265455964198/1105654243802755132/Screenshot_2023-05-10_at_01.34.58.png)
 