# BNDDO_Mining
A mining script for VORP.

### This has not been tested on large servers


# Features
- Polyzone and Node based mining.
- Pickaxe durablity with chance to break
- Client side cooldowns per Node
- Max Node limit (hasn't been testing on large server) allows a node to be mined up to max limit for the entire server
- VORP Integrated with notifications (no additional libraries needed)
- Animations for mining
- VORP Progress bar CSS
- NO MINIGAME (if you want one you can add one)
- No need to equip pickaxe, just have in your inventory. This eliminates the walking animation (I hope)

# Dependencies
- VORP
- VORP Progressbar (you can use any progress bar, just need to modify client at line 166)
- **Polyzone** - I used Outsider's Polyzone, but you can test with other versions: [Outsider Polyzone](https://github.com/outsider31000/PolyZone)

# Installation
- Copy files to resources folder
- Define mine zones using Polyzone (gaptooth included and rathskeller *requires spooni MLO*)
-   Make sure that your polyzones extend to the farthest flooring of the mine and does not extend above ground
- Create nodes using Vector4. You can add as many as you like. Haven't tested on very large mines though
- Make sure all resources and items are in your DB



# Credits
- BGS Mining for the Node based mining concepts. Also, reowrked a bit of the code to work here: https://github.com/Kianimal/BGS_Mining
- JC Mining for the Polyzone based mining concepts: https://github.com/Jewsie/jc-mining-revamped
- VORP Mining for much of the logic behind durablity, randomization etc: https://github.com/VORPCORE/vorp_mining
