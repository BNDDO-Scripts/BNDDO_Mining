-- server loads node data on resource local character = LocalPlayer.state.Character
-- keey node state in memor on server
-- updates mined state when a client mines
-- tell all clients to update their node state

local Core = exports.vorp_core:GetCore()
local NodeLimits = {}


-- -------------------------------------------------------------------------- --
--                                  FUNCTIONS                                 --
-- -------------------------------------------------------------------------- --

local function shuffle(tbl)
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
end

local keysx = function(table)
    local keys = 0
    for k, v in pairs(table) do
        keys = keys + 1
    end
    return keys
end

local function getPickaxeStatus(src)
    local pickaxeCount = exports.vorp_inventory:getItemCount(src, nil, Config.Pickaxe)
    return pickaxeCount
end

local function getMineNodeStatus(mine, node)
    if NodeLimits == nil or NodeLimits == {} then return false end
    if not NodeLimits[mine] then return false end
    return NodeLimits[mine] or false
end

local function pickaxeDurability(player)
    local src = player
    local pickaxe = exports.vorp_inventory:getItem(src, Config.Pickaxe)
    if not pickaxe then return end

    local meta = pickaxe.metadata or {}
    local durability = tonumber(meta.durability) or 100

    -- Reduce durability
    durability = durability - Config.PickaxeDamage
    local metadata = {
        description = "Pickaxe Durability: " .. durability,
        durability = durability
    }

    if durability < Config.PickaxeBreakThreshold then
        local chance = math.random(1, 20)
        if chance < Config.PickaxeBreakChance then
            exports.vorp_inventory:subItem(src, Config.Pickaxe, 1, meta)
            Core.NotifyTip(src, "Your Pickaxe is Broken", 4000)
            -- TriggerClientEvent("bnddo_mining:client:pickaxeStatus", src, false)
            return
        end
    end

    -- Apply updated metadata
    exports.vorp_inventory:setItemMetadata(src, pickaxe.id, metadata, 1)
end


-- -------------------------------------------------------------------------- --
--                                  CALLBACKS                                 --
-- -------------------------------------------------------------------------- --

Core.Callback.Register('bnddo:server:checkMiningStatus', function(source, cb, mine)
    local src = source
    local pickaxeCount = getPickaxeStatus(src)
    local nodeStatus = getMineNodeStatus(mine)

    -- Return both statuses to the callback
    cb({
        hasPickaxe = pickaxeCount,
        nodeLimits = nodeStatus
    })
end)






-- -------------------------------------------------------------------------- --
--                                   EVENTS                                   --
-- -------------------------------------------------------------------------- --

RegisterNetEvent('bnddo:server:getNodeStatus', function(source, cb, mine, node)
    local status = getMineNodeStatus(mine, node)
    cb(status)
end)

RegisterNetEvent('bnddo:server:pickaxeStatus', function(source, cb)
    local count = getPickaxeStatus(source)
    cb(count)
end)

-- ------------------------------- give Items ------------------------------- --

RegisterNetEvent('bnddo_mining:server:giveItems', function(mine, node)
    local src = source
    local found
    local itemTable = shuffle(Config.MiningLocations[mine].nodes[node].items)
    local rewards = {}


    for k, v in pairs(itemTable) do
        local chance = math.random(1, 10)
        Debug(chance)
        if chance <= v.chance then
            table.insert(rewards, v)
        end
    end

    if rewards == nil or #rewards == 0 then
        found = false
        Core.NotifyAvanced(src, "Nothing found", "mp_lobby_textures", "cross", "COLOR_RED", 5000)
        TriggerClientEvent("bnddo_mining:client:endMining", src, mine, node, found)
        return
    end


    local randomtotal = keysx(rewards)
    local itemChance = math.random(1, randomtotal)
    local selectedReward = rewards[itemChance] -- cache it here
    local itemCount = math.random(1, selectedReward.amount)
    local canCarryItem = exports.vorp_inventory:canCarryItem(src, selectedReward.name, itemCount)

    if not canCarryItem then
        found = false
        Core.NotifyTip(src, "Can't carry anymore " .. selectedReward.label, 3000)
        TriggerClientEvent("bnddo_mining:client:endMining", src, mine, node, found)
        return
    end
    found = true
    -- TriggerEvent('bnddo_mining:server:checkPickaxe', src)
    local nodeKey = NodeKey(mine, Config.MiningLocations[mine].nodes[node].coords)
    NodeLimits[mine][nodeKey].currentCount = NodeLimits[mine][nodeKey].currentCount + 1
    exports.vorp_inventory:addItem(src, selectedReward.name, itemCount)

    Core.NotifyAvanced(src, string.format("%s x %s", selectedReward.label, itemCount), "pm_awards_mp",
        "awards_set_g_009", "COLOR_WHITE", 4000)
    pickaxeDurability(src)
    TriggerClientEvent("bnddo_mining:client:endMining", src, mine, node, found, selectedReward.label, itemCount)
    TriggerClientEvent('bnddo_mining:client:updateMiningNode', -1, {
        [nodeKey] = {
            currentCount = NodeLimits[mine][nodeKey].currentCount
        }
    }, mine)
end)


-- ------------ when player receives a pickaxe ------------ --
AddEventHandler("vorp_inventory:Server:OnItemCreated", function(data, source)
    Debug(json.encode(data))
    if data.name == Config.Pickaxe then
        Debug("Acquired pickaxe")
        TriggerClientEvent("bnddo_mining:client:pickaxeStatus", source, true)
    end
    -- data.count, data.name, data.metadata
end)

-- --------------- when player removes pickaxe from inventory --------------- --
AddEventHandler("vorp_inventory:Server:OnItemRemoved", function(data, source)
    if data.name == Config.Pickaxe then
        Debug("Dropped pickaxe")
        local src = source
        local count = exports.vorp_inventory:getItemCount(src, nil, Config.Pickaxe)
        if count == 0 or count == nil then
            Debug("No pickaxe")
            TriggerClientEvent("bnddo_mining:client:pickaxeStatus", source, false)
        else
            Debug("Still has pickaxe " .. count)
            TriggerClientEvent("bnddo_mining:client:pickaxeStatus", source, true)
        end
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    NodeLimits = {}

    for k, v in pairs(Config.MiningLocations) do
        NodeLimits[k] = {}

        for i, node in ipairs(v.nodes) do
            local coord = node.coords
            local nodeKey = NodeKey(k, coord)

            NodeLimits[k][nodeKey] = {
                maxCount = node.mineLimit,
                currentCount = 0,
            }
        end
        print("Creating NodeLimits for " .. k)
    end
end)

-- -------------------------------------------------------------------------- --
--                                   EXPORTS                                  --
-- -------------------------------------------------------------------------- --


-- -------------------------------------------------------------------------- --
--                                   THREADS                                  --
-- -------------------------------------------------------------------------- --

RegisterCommand('serverMineStatus', function(source, args, rawCommand)
    local src = source
    local mine = args[1]


    if not mine then
        print("Usage: /serverMineStatus <mine>")
        return
    end

    if NodeLimits[mine] then
        print(string.format("Mine: %s, Node: %s", mine, json.encode(NodeLimits[mine])))
    else
        print("Invalid mine or node.")
    end
end)
