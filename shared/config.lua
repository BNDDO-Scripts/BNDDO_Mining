Config = {}
Config.Debug = false

Config.Pickaxe = "provision_pickaxe"            -- Item from your database that you want to use for a pickaxe
Config.HeavyPickaxe = "provision_heavy_pickaxe" -- Heavy Pickaxe reduces less durability
Config.MineKey = 0x760A9C6F                     -- Key to Mine node (Left Click)
Config.UseCinematic = false

Config.PickaxeDamage = 5          -- Amount of damage done to pickaxe durability per mining nod
Config.PickaxeBreakThreshold = 45 -- Anything lower than 30 druablity and pickaxe can possibly break based in breakchance
Config.PickaxeBreakChance = 8     -- Rolls between 1,20 if lower than this number, pickaxe breaks (8 = 40% chance)



-- mining locations
Config.MiningLocations = {

    ['Gaptooth'] = {
        Name = "Gaptooth Mine",
        coords = vector3(-5964.49, -3207.09, -21.48),
        joblocked = false,
        bliphash = "blip_ambient_hitching_post",
        showblip = true,
        zonesEnabled = true,
        zone = {
            coords = {
                vector2(-5965.5336914062, -3200.8444824219),
                vector2(-5967.1508789062, -3198.7951660156),
                vector2(-5966.61328125, -3187.181640625),
                vector2(-5970.4750976562, -3173.8093261719),
                vector2(-5983.4301757812, -3171.0830078125),
                vector2(-5989.8525390625, -3161.4001464844),
                vector2(-5976.7827148438, -3157.6118164062),
                vector2(-5968.9345703125, -3164.6516113281),
                vector2(-5959.6586914062, -3171.7863769531),
                vector2(-5952.4609375, -3182.990234375),
                vector2(-5958.791015625, -3203.9233398438)
            },
            name = "gaptooth",
            minZ = -27.150501251221,
            maxZ = -18.110506057739,
            debugPoly = false
        },

        nodes = {
            -- Node 1
            {
                coords = vector4(-5960.1, -3180.38, -22.51, 102.14),
                showmarker = true,
                promptDistance = 1.0,
                timeout = 120000,
                mineLimit = 6,
                items = {
                    { label = "Coal",      name = "resource_coal",     chance = 2, amount = 4 },
                    { label = "Copper",    name = "resource_copper",   chance = 2, amount = 4 },
                    { label = "Iron",      name = "resource_iron",     chance = 2, amount = 4 },
                    { label = "Shiny Ore", name = "resource_shinyore", chance = 1, amount = 4 },

                }
            },
            -- Node 2
            {
                coords = vector4(-5961.27, -3174.19, -22.97, 312.94),
                showmarker = true,
                promptDistance = 1.0,
                timeout = 150000,
                mineLimit = 6,
                items = {
                    { label = "Coal",      name = "resource_coal",     chance = 3, amount = 4 },
                    { label = "Copper",    name = "resource_copper",   chance = 3, amount = 4 },
                    { label = "Iron",      name = "resource_iron",     chance = 3, amount = 4 },
                    { label = "Shiny Ore", name = "resource_shinyore", chance = 1, amount = 4 },
                },
            },
            -- Node 3
            {
                coords = vector4(-5966.17, -3172.71, -23.84, 134.06),

                showmarker = true,
                promptDistance = 1.0,
                timeout = 180000,
                mineLimit = 6,
                items = {
                    { label = "Coal",      name = "resource_coal",     chance = 4, amount = 4 },
                    { label = "Copper",    name = "resource_copper",   chance = 4, amount = 4 },
                    { label = "Iron",      name = "resource_iron",     chance = 4, amount = 4 },
                    { label = "Shiny Ore", name = "resource_shinyore", chance = 1, amount = 4 },
                }
            },
            -- Node 4
            {
                coords = vector4(-5972.02, -3166.94, -25.42, 343.46),

                showmarker = true,
                promptDistance = 1.0,
                timeout = 210000,
                mineLimit = 6,
                items = {
                    { label = "Coal",      name = "resource_coal",     chance = 5, amount = 4 },
                    { label = "Copper",    name = "resource_copper",   chance = 5, amount = 4 },
                    { label = "Iron",      name = "resource_iron",     chance = 5, amount = 4 },
                    { label = "Shiny Ore", name = "resource_shinyore", chance = 1, amount = 4 },
                }
            },
            -- Node 5
            {
                coords = vector4(-5976.26, -3167.27, -25.54, 154.8),

                showmarker = true,
                promptDistance = 1.0,
                timeout = 240000,
                mineLimit = 6,
                items = {
                    { label = "Coal",      name = "resource_coal",     chance = 6, amount = 4 },
                    { label = "Copper",    name = "resource_copper",   chance = 6, amount = 4 },
                    { label = "Iron",      name = "resource_iron",     chance = 6, amount = 4 },
                    { label = "Shiny Ore", name = "resource_shinyore", chance = 1, amount = 4 },
                }
            },
            -- Node 6
            {
                coords = vector4(-5978.94, -3165.36, -26.33, 145.88),

                showmarker = true,
                promptDistance = 1.0,
                timeout = 270000,
                mineLimit = 6,
                items = {
                    { label = "Coal",      name = "resource_coal",     chance = 7, amount = 4 },
                    { label = "Copper",    name = "resource_copper",   chance = 7, amount = 4 },
                    { label = "Iron",      name = "resource_iron",     chance = 7, amount = 4 },
                    { label = "Shiny Ore", name = "resource_shinyore", chance = 1, amount = 4 },
                }
            },
            -- Node 7
            {
                coords = vector4(-5980.96, -3161.58, -26.55, 28.37),

                showmarker = true,
                promptDistance = 1.0,
                timeout = 300000,
                mineLimit = 6,
                items = {
                    { label = "Coal",      name = "resource_coal",     chance = 8, amount = 4 },
                    { label = "Copper",    name = "resource_copper",   chance = 8, amount = 4 },
                    { label = "Iron",      name = "resource_iron",     chance = 8, amount = 4 },
                    { label = "Shiny Ore", name = "resource_shinyore", chance = 1, amount = 4 },
                }
            },
            -- Node 8
            {
                coords = vector4(-5985.74, -3164.79, -26.51, 17.38),
                showmarker = false,
                promptDistance = 0.75,
                timeout = 300000,
                mineLimit = 1,
                items = {
                    { name = "special_item", label = "Clay", chance = 8, amount = 4 },

                }
            },
        }
    },
    -- ['Rathskeller'] = {
    --     Name = "Rathskeller Mine",
    --     coords = vector3(-5436.93, -2318.54, -3.27),
    --     joblocked = false,
    --     bliphash = "blip_ambient_hitching_post",
    --     showblip = true,
    --     zonesEnabled = true,
    --     zone = {
    --         coords = {
    --             vector2(-5439.07421875, -2316.9138183594),
    --             vector2(-5440.1630859375, -2316.0493164062),
    --             vector2(-5440.607421875, -2320.4113769531),
    --             vector2(-5461.33203125, -2317.8940429688),
    --             vector2(-5474.0903320312, -2341.4440917969),
    --             vector2(-5490.8774414062, -2346.3317871094),
    --             vector2(-5494.9501953125, -2356.3742675781),
    --             vector2(-5511.0830078125, -2342.6420898438),
    --             vector2(-5493.7954101562, -2332.9929199219),
    --             vector2(-5492.5317382812, -2327.3540039062),
    --             vector2(-5500.8779296875, -2324.041015625),
    --             vector2(-5509.2788085938, -2324.3940429688),
    --             vector2(-5505.5620117188, -2316.39453125),
    --             vector2(-5492.3959960938, -2317.7006835938),
    --             vector2(-5467.2705078125, -2311.3874511719),
    --             vector2(-5458.8706054688, -2309.1696777344)
    --         },
    --         name = "rathskeller",
    --         minZ = -12.8630514144897,
    --         maxZ = 1.19273853302,
    --         debugPoly = false
    --     },

    --     nodes = {
    --         {
    --             coords = vector3(-5452.27, -2313.52, -2.83),
    --             showmarker = true,
    --             timeout = 120000,
    --             mineLimit = 6,
    --             items = {
    --                 { name = "clay",       label = "Clay",         chance = 8,  amount = 4 },
    --                 { name = "coal",       label = "Coal",         chance = 8,  amount = 4 },
    --                 { name = "copper",     label = "Copper",       chance = 6,  amount = 8 },
    --                 { name = "iron",       label = "Iron",         chance = 6,  amount = 12 },
    --                 { name = "nitrite",    label = "Nitrite",      chance = 8,  amount = 4 },
    --                 { name = "Shiny Ore",       label = "Shiny Ores",        chance = 10, amount = 4 },
    --                 { name = "salt",       label = "Salt",         chance = 10, amount = 4 },
    --                 { name = "goldnugget", label = "Gold Nuggets", chance = 3,  amount = 2 },
    --             }
    --         },
    --         {
    --             coords = vector3(-5461.49, -2310.28, -3.55),
    --             showmarker = true,
    --             timeout = 120000,
    --             mineLimit = 6,
    --             items = {
    --                 { name = "clay",       label = "Clay",         chance = 8,  amount = 4 },
    --                 { name = "coal",       label = "Coal",         chance = 8,  amount = 4 },
    --                 { name = "copper",     label = "Copper",       chance = 6,  amount = 8 },
    --                 { name = "iron",       label = "Iron",         chance = 6,  amount = 12 },
    --                 { name = "nitrite",    label = "Nitrite",      chance = 8,  amount = 4 },
    --                 { name = "Shiny Ore",       label = "Shiny Ores",        chance = 10, amount = 4 },
    --                 { name = "salt",       label = "Salt",         chance = 10, amount = 4 },
    --                 { name = "goldnugget", label = "Gold Nuggets", chance = 3,  amount = 2 },
    --             }
    --         },
    --         {
    --             coords = vector3(-5467.6, -2317.97, -4.31),
    --             showmarker = true,
    --             timeout = 120000,
    --             mineLimit = 6,
    --             items = {
    --                 { name = "clay",       label = "Clay",         chance = 8,  amount = 4 },
    --                 { name = "coal",       label = "Coal",         chance = 8,  amount = 4 },
    --                 { name = "copper",     label = "Copper",       chance = 6,  amount = 8 },
    --                 { name = "iron",       label = "Iron",         chance = 6,  amount = 12 },
    --                 { name = "nitrite",    label = "Nitrite",      chance = 8,  amount = 4 },
    --                 { name = "Shiny Ore",       label = "Shiny Ores",        chance = 10, amount = 4 },
    --                 { name = "salt",       label = "Salt",         chance = 10, amount = 4 },
    --                 { name = "goldnugget", label = "Gold Nuggets", chance = 3,  amount = 2 },
    --             }
    --         },
    --         {
    --             coords = vector3(-5474.88, -2331.38, -6.82),
    --             showmarker = true,
    --             timeout = 120000,
    --             mineLimit = 6,
    --             items = {
    --                 { name = "clay",       label = "Clay",         chance = 8,  amount = 4 },
    --                 { name = "coal",       label = "Coal",         chance = 8,  amount = 4 },
    --                 { name = "copper",     label = "Copper",       chance = 6,  amount = 8 },
    --                 { name = "iron",       label = "Iron",         chance = 6,  amount = 12 },
    --                 { name = "nitrite",    label = "Nitrite",      chance = 8,  amount = 4 },
    --                 { name = "Shiny Ore",       label = "Shiny Ores",        chance = 10, amount = 4 },
    --                 { name = "salt",       label = "Salt",         chance = 10, amount = 4 },
    --                 { name = "goldnugget", label = "Gold Nuggets", chance = 3,  amount = 2 },
    --             }
    --         },
    --         {
    --             coords = vector3(-5495.06, -2347.38, -8.79),
    --             showmarker = true,
    --             timeout = 120000,
    --             mineLimit = 6,
    --             items = {
    --                 { name = "clay",       label = "Clay",         chance = 8,  amount = 4 },
    --                 { name = "coal",       label = "Coal",         chance = 8,  amount = 4 },
    --                 { name = "copper",     label = "Copper",       chance = 6,  amount = 8 },
    --                 { name = "iron",       label = "Iron",         chance = 6,  amount = 12 },
    --                 { name = "nitrite",    label = "Nitrite",      chance = 8,  amount = 4 },
    --                 { name = "Shiny Ore",       label = "Shiny Ores",        chance = 10, amount = 4 },
    --                 { name = "salt",       label = "Salt",         chance = 10, amount = 4 },
    --                 { name = "goldnugget", label = "Gold Nuggets", chance = 3,  amount = 2 },
    --             }
    --         },
    --         {
    --             coords = vector3(-5506.53, -2341.01, -7.82),
    --             showmarker = true,
    --             timeout = 120000,
    --             mineLimit = 6,
    --             items = {
    --                 { name = "clay",       label = "Clay",         chance = 8,  amount = 4 },
    --                 { name = "coal",       label = "Coal",         chance = 8,  amount = 4 },
    --                 { name = "copper",     label = "Copper",       chance = 6,  amount = 8 },
    --                 { name = "iron",       label = "Iron",         chance = 6,  amount = 12 },
    --                 { name = "nitrite",    label = "Nitrite",      chance = 8,  amount = 4 },
    --                 { name = "Shiny Ore",       label = "Shiny Ores",        chance = 10, amount = 4 },
    --                 { name = "salt",       label = "Salt",         chance = 10, amount = 4 },
    --                 { name = "goldnugget", label = "Gold Nuggets", chance = 3,  amount = 2 },
    --             }
    --         },
    --         {
    --             coords = vector3(-5494.26, -2322.53, -9.89),
    --             showmarker = true,
    --             timeout = 120000,
    --             mineLimit = 6,
    --             items = {
    --                 { name = "clay",       label = "Clay",         chance = 8,  amount = 4 },
    --                 { name = "coal",       label = "Coal",         chance = 8,  amount = 4 },
    --                 { name = "copper",     label = "Copper",       chance = 6,  amount = 8 },
    --                 { name = "iron",       label = "Iron",         chance = 6,  amount = 12 },
    --                 { name = "nitrite",    label = "Nitrite",      chance = 8,  amount = 4 },
    --                 { name = "Shiny Ore",       label = "Shiny Ores",        chance = 10, amount = 4 },
    --                 { name = "salt",       label = "Salt",         chance = 10, amount = 4 },
    --                 { name = "goldnugget", label = "Gold Nuggets", chance = 3,  amount = 2 },
    --             }
    --         },
    --         {
    --             coords = vector3(-5504.75, -2319.54, -10.95),
    --             showmarker = true,
    --             timeout = 120000,
    --             mineLimit = 6,
    --             items = {
    --                 { name = "clay",       label = "Clay",         chance = 8,  amount = 4 },
    --                 { name = "coal",       label = "Coal",         chance = 8,  amount = 4 },
    --                 { name = "copper",     label = "Copper",       chance = 6,  amount = 8 },
    --                 { name = "iron",       label = "Iron",         chance = 6,  amount = 12 },
    --                 { name = "nitrite",    label = "Nitrite",      chance = 8,  amount = 4 },
    --                 { name = "Shiny Ore",       label = "Shiny Ores",        chance = 10, amount = 4 },
    --                 { name = "salt",       label = "Salt",         chance = 10, amount = 4 },
    --                 { name = "goldnugget", label = "Gold Nuggets", chance = 3,  amount = 2 },
    --             }
    --         },
    --     }
    -- },

}
