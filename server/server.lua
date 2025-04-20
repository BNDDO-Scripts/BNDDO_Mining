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
    elseif durability <= 2 then
        exports.vorp_inventory:subItem(src, Config.Pickaxe, 1, meta)
        Core.NotifyTip(src, "Your Pickaxe is Broken", 4000)
    end

    -- Apply updated metadata
    exports.vorp_inventory:setItemMetadata(src, pickaxe.id, metadata, 1)
end

local function registerItems()
    CreateThread(function()
        for oreName, allowed in pairs(Config.SpecialOre) do
            exports.vorp_inventory:registerUsableItem(oreName, function(data)
                if allowed then
                    TriggerClientEvent("bnddo_mining:client:startWashing", data.source, data.item.name, data.item.label)
                else
                    Core.NotifyTip(data.source, "Not a washable Item", 3000)
                end
            end, GetCurrentResourceName())
        end
    end)
end

local function generateItem(src, itemTable)
    local rewards = {}

    for k, v in pairs(itemTable) do
        local chance = math.random(1, 10)
        Debug("Chance Roll: " .. chance)
        if chance <= v.chance then
            table.insert(rewards, v)
        end
    end

    if #rewards == 0 then
        return nil, nil
    end

    local randomtotal = keysx(rewards)
    local itemChance = math.random(1, randomtotal)
    local selectedReward = rewards[itemChance]
    local itemCount = math.random(1, selectedReward.amount)

    return selectedReward, itemCount
end

local function handleItemReward(src, itemTable, options)
    local selectedReward, itemCount = generateItem(src, itemTable)

    if not selectedReward then
        if options.notifyOnFail then
            Core.NotifyAvanced(src, "Nothing found", "mp_lobby_textures", "cross", "COLOR_RED", 5000)
        end
        if options.onFail then options.onFail() end
        return
    end

    if not exports.vorp_inventory:canCarryItem(src, selectedReward.name, itemCount) then
        Core.NotifyTip(src, "Can't carry anymore " .. selectedReward.label, 3000)
        if options.onFail then options.onFail() end
        return
    end

    exports.vorp_inventory:addItem(src, selectedReward.name, itemCount)

    if options.notifyOnSuccess then
        Core.NotifyAvanced(src, string.format("%s x %s", selectedReward.label, itemCount), "pm_awards_mp",
            "awards_set_g_009", "COLOR_WHITE", 4000)
    end

    if options.onSuccess then options.onSuccess(selectedReward.name, itemCount) end
end


-- -------------------------------------------------------------------------- --
--                                  CALLBACKS                                 --
-- -------------------------------------------------------------------------- --

Core.Callback.Register('bnddo:server:checkMiningStatus', function(source, cb, mine)
    local src = source
    local pickaxeCount = getPickaxeStatus(src)
    local nodeStatus = getMineNodeStatus(mine)

    cb({
        hasPickaxe = pickaxeCount,
        nodeLimits = nodeStatus,

    })
end)

Core.Callback.Register('bnddo:server:checkWashable', function(source, cb, item)
    local src = source
    local itemCount = exports.vorp_inventory:getItemCount(src, nil, item)

    if itemCount > 0 then
        cb(true)
    else
        cb(false)
    end
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

RegisterNetEvent('bnddo_mining:server:giveWashedItem', function(item)
    local src = source
    if src == 0 then return end -- protecting from non client calls

    Debug("Giving washed items for " .. item)

    local itemTable = shuffle(Config.SpecialOre[item].items)
    handleItemReward(src, itemTable, {
        notifyOnFail = true,
        notifyOnSuccess = true,
        onSuccess = function(itemGive, count)
            Debug("Item: " .. itemGive .. ", Count: " .. count)
            exports.vorp_inventory:subItem(src, item, 1)
        end,
        onFail = function()
            Debug("Failed to generate item")
            exports.vorp_inventory:subItem(src, item, 1)
        end
    })
end)


-- ------------------------------- give Items ------------------------------- --
RegisterNetEvent('bnddo_mining:server:giveItems', function(mine, node)
    local src = source
    if src == 0 then return end
    local found = false
    local itemTable = shuffle(Config.MiningLocations[mine].nodes[node].items)
    local nodeKey = NodeKey(mine, Config.MiningLocations[mine].nodes[node].coords)


    if NodeLimits[mine][nodeKey].currentCount >= NodeLimits[mine][nodeKey].maxCount then
        Core.NotifyAvanced(src, "Node is depleted", "mp_lobby_textures", "cross", "COLOR_RED", 5000)
        TriggerClientEvent("bnddo_mining:client:endMining", src, mine, node, found)
        return
    end


    handleItemReward(src, itemTable, {
        notifyOnFail = true,
        notifyOnSuccess = true,
        onFail = function()
            TriggerClientEvent("bnddo_mining:client:endMining", src, mine, node, found)
        end,
        onSuccess = function(selectedReward, itemCount)
            found = true
            NodeLimits[mine][nodeKey].currentCount = NodeLimits[mine][nodeKey].currentCount + 1

            pickaxeDurability(src)

            TriggerClientEvent("bnddo_mining:client:endMining", src, mine, node, found, selectedReward.label, itemCount)
            TriggerClientEvent('bnddo_mining:client:updateMiningNode', -1, {
                [nodeKey] = {
                    currentCount = NodeLimits[mine][nodeKey].currentCount
                }
            }, mine)
        end
    })
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
        Wait(50)
        print("Creating Usables")
        registerItems()
    end
end)

-- -------------------------------------------------------------------------- --
--                                   EXPORTS                                  --
-- -------------------------------------------------------------------------- --


-- -------------------------------------------------------------------------- --
--                                   THREADS                                  --
-- -------------------------------------------------------------------------- --



-- -------------------------------------------------------------------------- --
--                                  COMMANDS                                  --
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
end, true)
