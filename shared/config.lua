Config = {}
Config.Debug = false   -- Will print debug messages to the console
Config.DevMode = false -- Will skip animations to help with testing

-- -------------------------------------------------------------------------- --
--                                MINING CONFIG                               --
-- -------------------------------------------------------------------------- --
Config.Pickaxe = "provision_pickaxe" -- Item from your database that you want to use for a pickaxe
Config.MineKey = 0x760A9C6F          -- Key to Mine node (G key)

Config.PickaxeDamage = 2             -- Amount of damage done to pickaxe durability per mining nod
Config.PickaxeBreakThreshold = 30    -- Anything lower than 30 druablity and pickaxe can possibly break based in breakchance
Config.PickaxeBreakChance = 4        -- Rolls between 1,20 if lower than this number, pickaxe breaks (8 = 40% chance)

-- -------------------------------------------------------------------------- --
--                               WASHING CONFIGS                              --
-- -------------------------------------------------------------------------- --
Config.WashingItem = "provision_miner_pan" -- If you want to require a washin item, otherwise set to false

Config.SpecialOre = {
    ["resource_shinyore"] = {
        allowed = true,
        items = {
            { name = "resource_emerald_uncut", label = "Uncut Emerald", chance = 2, amount = 1 },
            { name = "resource_ruby_uncut",    label = "Uncut Ruby",    chance = 2, amount = 1 },
            { name = "resource_diamond_uncut", label = "Uncut Diamond", chance = 1, amount = 1 },
        }
    }
    -- you can add more and they will be registered as usable

}
-- Config.UseSkills = true --
-- Config.SkillChance = {

-- }
Config.AllowWashLocations = {
    [2] = true, -- Lakes
    [3] = true, -- Rivers
    [5] = true, -- Swamps
    [6] = true, -- Ocean
    [7] = true, -- Creek
    [8] = true, -- Pond
}


-- -------------------------------------------------------------------------- --
--                          MINING AND NODE LOCATIONS                         --
-- -------------------------------------------------------------------------- --
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
    --[[ ['Grizzlies'] = { -- just configure nodes
        Name = "Grizzlies Mine",
        coords = vector3(-1408.13, 1159.7, 226.82),
        joblocked = false,
        bliphash = "blip_ambient_hitching_post",
        showblip = true,
        zonesEnabled = true,
        zone = {
            coords = {
                vector2(-1403.6580810547, 1161.162109375),
                vector2(-1403.6580810547, 1161.162109375),
                vector2(-1410.2136230469, 1157.8979492188),
                vector2(-1427.0336914062, 1171.7775878906),
                vector2(-1436.2889404297, 1174.6408691406),
                vector2(-1447.5557861328, 1187.5775146484),
                vector2(-1446.5275878906, 1190.3626708984),
                vector2(-1450.2456054688, 1197.4976806641),
                vector2(-1449.5972900391, 1206.8088378906),
                vector2(-1441.9477539062, 1213.0260009766),
                vector2(-1423.7954101562, 1220.9499511719),
                vector2(-1403.1546630859, 1210.8597412109),
                vector2(-1400.3980712891, 1192.0815429688),
                vector2(-1382.0128173828, 1192.4700927734),
                vector2(-1385.7451171875, 1179.8165283203),
                vector2(-1388.9776611328, 1173.2745361328),
                vector2(-1392.9338378906, 1166.17578125)
            },
            name = "grizzlies",
            minZ = 221,
            maxZ = 231,
            debugPoly = true
        },

        nodes = {
            -- Node 1
            {
                coords = vector4(-1418.19, 1192.96, 225.29, 264.82),
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
        }
    }, ]]

    --[[ ['Rathskeller'] = { -- requires spooni MLO
    Name = "Rathskeller Mine",
    coords = vector3(-5436.93, -2318.54, -3.27),
    joblocked = false,
    bliphash = "blip_ambient_hitching_post",
    showblip = true,
    zonesEnabled = true,
    zone = {
        coords = {
            vector2(-1401.7211914062, 1159.59375),
            vector2(-1411.4188232422, 1169.8903808594),
            vector2(-1440.127319336, 1194.4460449218),
            vector2(-1459.654663086, 1213.9061279296),
            vector2(-1451.7838134766, 1186.5112304688),
            vector2(-1409.1928710938, 1148.5270996094)
        },
        name = "rathskeller",
        minZ = 226.53,
        maxZ = 235.15,
        debugPoly = true
    },

    nodes = {
        {
            coords = vector3(-5452.27, -2313.52, -2.83),
            showmarker = true,
            timeout = 120000,
            mineLimit = 6,
            items = {
                { name = "clay",       label = "Clay",         chance = 8,  amount = 4 },
                { name = "coal",       label = "Coal",         chance = 8,  amount = 4 },
                { name = "copper",     label = "Copper",       chance = 6,  amount = 8 },
                { name = "iron",       label = "Iron",         chance = 6,  amount = 12 },
                { name = "nitrite",    label = "Nitrite",      chance = 8,  amount = 4 },
                { name = "Shiny Ore",  label = "Shiny Ores",   chance = 10, amount = 4 },
                { name = "salt",       label = "Salt",         chance = 10, amount = 4 },
                { name = "goldnugget", label = "Gold Nuggets", chance = 3,  amount = 2 },
            }
        },
        {
            coords = vector3(-5461.49, -2310.28, -3.55),
            showmarker = true,
            timeout = 120000,
            mineLimit = 6,
            items = {
                { name = "clay",       label = "Clay",         chance = 8,  amount = 4 },
                { name = "coal",       label = "Coal",         chance = 8,  amount = 4 },
                { name = "copper",     label = "Copper",       chance = 6,  amount = 8 },
                { name = "iron",       label = "Iron",         chance = 6,  amount = 12 },
                { name = "nitrite",    label = "Nitrite",      chance = 8,  amount = 4 },
                { name = "Shiny Ore",  label = "Shiny Ores",   chance = 10, amount = 4 },
                { name = "salt",       label = "Salt",         chance = 10, amount = 4 },
                { name = "goldnugget", label = "Gold Nuggets", chance = 3,  amount = 2 },
            }
        },
        {
            coords = vector3(-5467.6, -2317.97, -4.31),
            showmarker = true,
            timeout = 120000,
            mineLimit = 6,
            items = {
                { name = "clay",       label = "Clay",         chance = 8,  amount = 4 },
                { name = "coal",       label = "Coal",         chance = 8,  amount = 4 },
                { name = "copper",     label = "Copper",       chance = 6,  amount = 8 },
                { name = "iron",       label = "Iron",         chance = 6,  amount = 12 },
                { name = "nitrite",    label = "Nitrite",      chance = 8,  amount = 4 },
                { name = "Shiny Ore",  label = "Shiny Ores",   chance = 10, amount = 4 },
                { name = "salt",       label = "Salt",         chance = 10, amount = 4 },
                { name = "goldnugget", label = "Gold Nuggets", chance = 3,  amount = 2 },
            }
        },
        {
            coords = vector3(-5474.88, -2331.38, -6.82),
            showmarker = true,
            timeout = 120000,
            mineLimit = 6,
            items = {
                { name = "clay",       label = "Clay",         chance = 8,  amount = 4 },
                { name = "coal",       label = "Coal",         chance = 8,  amount = 4 },
                { name = "copper",     label = "Copper",       chance = 6,  amount = 8 },
                { name = "iron",       label = "Iron",         chance = 6,  amount = 12 },
                { name = "nitrite",    label = "Nitrite",      chance = 8,  amount = 4 },
                { name = "Shiny Ore",  label = "Shiny Ores",   chance = 10, amount = 4 },
                { name = "salt",       label = "Salt",         chance = 10, amount = 4 },
                { name = "goldnugget", label = "Gold Nuggets", chance = 3,  amount = 2 },
            }
        },
        {
            coords = vector3(-5495.06, -2347.38, -8.79),
            showmarker = true,
            timeout = 120000,
            mineLimit = 6,
            items = {
                { name = "clay",       label = "Clay",         chance = 8,  amount = 4 },
                { name = "coal",       label = "Coal",         chance = 8,  amount = 4 },
                { name = "copper",     label = "Copper",       chance = 6,  amount = 8 },
                { name = "iron",       label = "Iron",         chance = 6,  amount = 12 },
                { name = "nitrite",    label = "Nitrite",      chance = 8,  amount = 4 },
                { name = "Shiny Ore",  label = "Shiny Ores",   chance = 10, amount = 4 },
                { name = "salt",       label = "Salt",         chance = 10, amount = 4 },
                { name = "goldnugget", label = "Gold Nuggets", chance = 3,  amount = 2 },
            }
        },
        {
            coords = vector3(-5506.53, -2341.01, -7.82),
            showmarker = true,
            timeout = 120000,
            mineLimit = 6,
            items = {
                { name = "clay",       label = "Clay",         chance = 8,  amount = 4 },
                { name = "coal",       label = "Coal",         chance = 8,  amount = 4 },
                { name = "copper",     label = "Copper",       chance = 6,  amount = 8 },
                { name = "iron",       label = "Iron",         chance = 6,  amount = 12 },
                { name = "nitrite",    label = "Nitrite",      chance = 8,  amount = 4 },
                { name = "Shiny Ore",  label = "Shiny Ores",   chance = 10, amount = 4 },
                { name = "salt",       label = "Salt",         chance = 10, amount = 4 },
                { name = "goldnugget", label = "Gold Nuggets", chance = 3,  amount = 2 },
            }
        },
        {
            coords = vector3(-5494.26, -2322.53, -9.89),
            showmarker = true,
            timeout = 120000,
            mineLimit = 6,
            items = {
                { name = "clay",       label = "Clay",         chance = 8,  amount = 4 },
                { name = "coal",       label = "Coal",         chance = 8,  amount = 4 },
                { name = "copper",     label = "Copper",       chance = 6,  amount = 8 },
                { name = "iron",       label = "Iron",         chance = 6,  amount = 12 },
                { name = "nitrite",    label = "Nitrite",      chance = 8,  amount = 4 },
                { name = "Shiny Ore",  label = "Shiny Ores",   chance = 10, amount = 4 },
                { name = "salt",       label = "Salt",         chance = 10, amount = 4 },
                { name = "goldnugget", label = "Gold Nuggets", chance = 3,  amount = 2 },
            }
        },
        {
            coords = vector3(-5504.75, -2319.54, -10.95),
            showmarker = true,
            timeout = 120000,
            mineLimit = 6,
            items = {
                { name = "clay",       label = "Clay",         chance = 8,  amount = 4 },
                { name = "coal",       label = "Coal",         chance = 8,  amount = 4 },
                { name = "copper",     label = "Copper",       chance = 6,  amount = 8 },
                { name = "iron",       label = "Iron",         chance = 6,  amount = 12 },
                { name = "nitrite",    label = "Nitrite",      chance = 8,  amount = 4 },
                { name = "Shiny Ore",  label = "Shiny Ores",   chance = 10, amount = 4 },
                { name = "salt",       label = "Salt",         chance = 10, amount = 4 },
                { name = "goldnugget", label = "Gold Nuggets", chance = 3,  amount = 2 },
            }
        },
    }
}, ]]

    -- add as many as you want. (I wouldn't add every mine though, just the ones you want to use)
}
