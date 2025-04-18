-- -------------------------------------------------------------------------- --
--                           VARIABLES/DEPENDENCIES                           --
-- -------------------------------------------------------------------------- --
local Core             = exports.vorp_core:GetCore()
local PromptGroup      = GetRandomIntInRange(0, 0xffffff)
local progressbar      = exports.vorp_progressbar:initiate()
local MinedData        = {}
local playerHasPickaxe = false
local isInMineZone     = nil
local isPlayerMining   = false
local isPromptPressed  = false

-- -------------------------------------------------------------------------- --
--                                  FUNCTIONS                                 --
-- -------------------------------------------------------------------------- --
-- ---------------------------- add mining blips ---------------------------- --
local function addBlips(mine, bliphash, coords)
    local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, coords.x, coords.y, coords.z, 0)
    Debug("creating blip for " ..
        mine ..
        " with hash " ..
        tostring(GetHashKey(bliphash)) .. " at coords " .. coords.x .. ", " .. coords.y .. ", " .. coords.z)
    SetBlipSprite(blip, GetHashKey(bliphash), true)
    SetBlipScale(blip, 0.2)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, mine)
end
-- ------------------------------ setup prompts ----------------------------- --
local function promptSetup()
    if PromptGroup ~= nil then
        UiPromptDelete(StartMining)
        PromptGroup = GetRandomIntInRange(0, 0xffffff)
    end
    -- Register new prompt
    StartMining = UiPromptRegisterBegin()
    UiPromptSetControlAction(StartMining, Config.MineKey) -- Example: 'X' button
    local label = VarString(10, 'LITERAL_STRING', "Mine")
    UiPromptSetText(StartMining, label)
    UiPromptSetEnabled(StartMining, true)
    UiPromptSetVisible(StartMining, true)
    UiPromptSetHoldMode(StartMining, true)
    UiPromptSetGroup(StartMining, PromptGroup)
    UiPromptRegisterEnd(StartMining)
end

-- ---------------- checking distance between player and node --------------- --
local function checkDistance(player, coords)
    local dist = Vdist(player.x, player.y, player.z, coords.x, coords.y, coords.z)
    return dist
end

local function addMiningPrompt(node)
    local MiningGroupName = CreateVarString(10, 'LITERAL_STRING', "Node " .. node)
    UiPromptSetActiveGroupThisFrame(PromptGroup, MiningGroupName)
    UiPromptSetEnabled(StartMining, true)
end

local function waitForResourceLoaded(requestFunc, checkFunc, resourceName, timeout)
    local startTime = GetGameTimer()
    requestFunc(resourceName)

    while not checkFunc(resourceName) do
        Wait(50)
        if GetGameTimer() - startTime > timeout then
            Debug("Resource load timed out: " .. resourceName)
            return false
        end
    end

    Debug("Resource loaded: " .. resourceName)
    return true
end

local function isAnimationLoaded(animDict, timeout)
    return waitForResourceLoaded(RequestAnimDict, HasAnimDictLoaded, animDict, timeout)
end

local function isObjectLoaded(model, timeout)
    return waitForResourceLoaded(RequestModel, HasModelLoaded, model, timeout)
end

local function isNodeUnlocked(nodeKey)
    local nodeData = MinedData[nodeKey]
    if not nodeData then return true end

    if not nodeData.isLocked then return true end
    if not nodeData.startedAt or not nodeData.timeout then return false end

    local currentTime = GetGameTimer()
    local hasTimedOut = (currentTime - nodeData.startedAt) >= nodeData.timeout

    return hasTimedOut
end


-- -------------------------------------------------------------------------- --
--                                  CALLBACKS                                 --
-- -------------------------------------------------------------------------- --


-- -------------------------------------------------------------------------- --
--                                   EXPORTS                                  --
-- -------------------------------------------------------------------------- --


-- -------------------------------------------------------------------------- --
--                                   EVENTS                                   --
-- -------------------------------------------------------------------------- --

-- -------------------------- update pickaxe status ------------------------- --
RegisterNetEvent('bnddo_mining:client:pickaxeStatus', function(status)
    playerHasPickaxe = status
    Debug("Player has pickaxe: " .. tostring(playerHasPickaxe))
end)

-- ------------------- Mining animations and player states ------------------ --
RegisterNetEvent('bnddo_mining:client:startMining', function(mine, node, coords)
    local nodeKey = NodeKey(mine, coords)
    local player = PlayerPedId()
    local animDict = "script_common@shared_scenarios@event_area@world_human_pickaxe@male_a@idle_a"
    local pickaxe = "p_pickaxe01x"

    if not isPromptPressed then return end
    isPlayerMining = true

    ClearPedTasksImmediately(player)

    CreateThread(function()
        if Config.DevMode then
            Debug("Starting mining animation")
            TriggerServerEvent('bnddo_mining:server:giveItems', mine, node)
            return
        end

        while isPlayerMining do
            Wait(1)
            local playerCoords = GetEntityCoords(player)

            DisableControlAction(0, 0x07CE1E61, false)
            DisableControlAction(0, 0xB2F377E8, false)
            DisableControlAction(0, 0xADEAF48C, false)
            Citizen.InvokeNative(0xFCCC886EDE3C63EC, player, 2, true)  -- HidePedWeapons
            Citizen.InvokeNative(0xAE6004120C18DF97, player, 0, false) -- Can't be lassod
            SetEnableHandcuffs(player, false, false)
            local timeout = 3000

            if isAnimationLoaded(animDict, timeout) and isObjectLoaded(pickaxe, timeout) then
                TaskGoStraightToCoord(player, coords.x, coords.y, coords.z, 1.0, -1, 0.0, 0.0)
                local playerInMiningPosition = false
                local arrivalTimeout = GetGameTimer() + timeout
                while not playerInMiningPosition and GetGameTimer() < arrivalTimeout do
                    Wait(1000)
                    local dist = checkDistance(playerCoords, coords)
                    if dist <= 1.5 then
                        playerInMiningPosition = true
                    end
                    if playerInMiningPosition then
                        SetEntityHeading(player, coords.w + -45)
                        ClearPedTasksImmediately(player)
                        local pickaxeModel = CreateObject(GetHashKey(pickaxe), playerCoords, true, true, true)
                        AttachEntityToEntity(pickaxeModel, player, GetEntityBoneIndexByName(player, "PH_L_Hand"), 0.000,
                            0.000, 0.000,
                            0.000,
                            0.000, 0.000, true, true, false, false, 0, true)
                        TaskPlayAnim(player, animDict, "idle_c", 8.0, -15.0, -1, 1, 0, false, false, false, false)
                        -- ------------------------------ progress bar ------------------------------ --
                        progressbar.start("Mining", 25000, function()
                            local entity = GetEntityAttachedTo(pickaxeModel)
                            if DoesEntityExist(entity) then
                                DetachEntity(pickaxeModel, true, true)
                                DeleteEntity(pickaxeModel)
                                DeleteObject(pickaxeModel)
                            end
                            ClearPedTasks(ped)
                            Citizen.InvokeNative(0xAE6004120C18DF97, ped, 0, true) -- turn able to be lassoed back on
                            SetEnableHandcuffs(player, false, true)                -- turn handcuffs back on
                            ClearPedTasksImmediately(player)
                            isPromptPressed = false
                            -- !Call server to give items and stuff
                            Debug("Mining complete, asking server for items, update pickaxe and mining nodes")
                            TriggerServerEvent('bnddo_mining:server:giveItems', mine, node)
                        end, 'linear', '#ff0000', '30vw')

                        Wait(9570)
                        TaskPlayAnim(player, animDict, "idle_a", 8.0, -8.0, -1, 1, 0, false, false, false, false)
                    end
                end
            else
                Debug("Failed to load resources, check debugs")
            end
            break
        end
    end)
end)

RegisterNetEvent('bnddo_mining:client:startWashing', function(ore, oreLabel)
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)
    local animDict = "script_re@gold_panner@gold_success"
    local animName = "pile_of_nothing"
    local minePanObj = "p_cs_miningpan01x"

    -- Check if a washing item is required
    if Config.WashingItem then
        local hasItem = Core.Callback.TriggerAwait('bnddo:server:checkWashable', Config.WashingItem)
        if not hasItem then
            Core.NotifyTip("You don't have a washing item", 4000)
            Debug("Player doesn't have the required washing item.")
            return
        end
    end

    -- Check if player is in water and in an allowed zone
    if not IsEntityInWater(player) then
        Core.NotifyTip("You must be in water to wash ores", 4000)
        Debug("Player is not in water.")
        return
    end

    -- check if player is in a washing area
    local inWashableZone = false
    for zoneTypeId, isAllowed in pairs(Config.AllowWashLocations) do
        if isAllowed then
            local zoneHash = Citizen.InvokeNative(0x43AD8FC02B429D33, coords, zoneTypeId)
            if zoneHash and zoneHash ~= 0 then
                inWashableZone = true
                break
            end
        end
    end

    if not inWashableZone then
        Core.NotifyTip("You're not in a valid washing location", 4000)
        Debug("Not in an allowed washing zone.")
        return
    end

    Debug("Starting washing: " .. ore)
    Core.NotifyTip("Washing " .. oreLabel .. "...", 4000)

    Wait(100)
    if Config.DevMode then
        TriggerServerEvent('bnddo_mining:server:giveWashedItem', ore)
        return
    end

    if isAnimationLoaded(animDict, 5000) and isObjectLoaded(minePanObj, 5000) then
        ClearPedTasksImmediately(player)
        exports.vorp_inventory:closeInventory(player)
        TriggerEvent("vorp_inventory:Client:DisableInventory", true)
        local panModel = CreateObject(GetHashKey(minePanObj), coords, true, true, true)
        AttachEntityToEntity(panModel, player, GetEntityBoneIndexByName(player, "PH_L_Hand"), 0.000, 0.000, 0.000, 0.000,
            0.000, 0.000, true, true, false, false, 0, true)
        TaskPlayAnim(player, animDict, animName, 8.0, -15.0, -1, 1, 0, false, false, false, false)

        progressbar.start("Washing", 18000,
            function()
                ClearPedTasksImmediately(player)
                DeleteObject(panModel)
                TriggerServerEvent('bnddo_mining:server:giveWashedItem', ore)
                TriggerEvent("vorp_inventory:Client:DisableInventory", false)
            end,
            'linear', '#ff0000', '30vw')
    else
        Debug("Failed to load resources for washing.")
    end
end)

RegisterNetEvent('bnddo_mining:client:endMining', function(mine, node, found, itemFound)
    local node = Config.MiningLocations[mine].nodes[node]
    local nodeKey = NodeKey(mine, node.coords)
    Debug("Ending mining for node: " .. nodeKey)

    MinedData[nodeKey] = MinedData[nodeKey] or {} -- Ensure it's initialized

    MinedData[nodeKey].timeout = (found and node.timeout) or 6000
    MinedData[nodeKey].startedAt = GetGameTimer()
    MinedData[nodeKey].isLocked = true



    -- clear all the mining states

    isPlayerMining = false
    isPromptPressed = false
end)


RegisterNetEvent('bnddo_mining:client:updateMiningNode', function(mineStatus, mine)
    if isInMineZone ~= mine then return end

    MinedData = MinedData or {}

    local allowedFields = {
        maxCount = true,
        currentCount = true,
    }

    for nodeKey, nodeData in pairs(mineStatus) do
        MinedData[nodeKey] = MinedData[nodeKey] or {}

        for field, value in pairs(nodeData) do
            if allowedFields[field] then
                MinedData[nodeKey][field] = value
            end
        end
    end
end)





-- -------------------------------------------------------------------------- --
--                                   THREADS                                  --
-- -------------------------------------------------------------------------- --

-- ----------------------------- PolyZone Thread ---------------------------- --
CreateThread(function()
    -- repeat Wait(1000) until LocalPlayer.state.IsInSession
    local isInside = false
    for mineName, mineData in pairs(Config.MiningLocations) do
        if mineData.bliphash and mineData.bliphash ~= "" then
            addBlips(mineData.Name, mineData.bliphash, mineData.coords)
        end



        if mineData.zone and mineData.zonesEnabled then
            local mineZone = PolyZone:Create(mineData.zone.coords, {
                name = mineName,
                minZ = mineData.zone.minZ,
                maxZ = mineData.zone.maxZ,
                debugPoly = mineData.zone.debugPoly,
            })

            if isInside == nil or mineZone == nil then
                return
            end
            mineZone:onPlayerInOut(function(isInside)
                if isInside then
                    Debug("Player is inside " .. mineName .. " zone")
                    -- Get node information from server
                    isInMineZone = mineName
                    local mineStatus = Core.Callback.TriggerAwait('bnddo:server:checkMiningStatus', isInMineZone)
                    if mineStatus.hasPickaxe > 0 then
                        playerHasPickaxe = true
                    else
                        playerHasPickaxe = false
                    end
                    TriggerEvent('bnddo_mining:client:updateMiningNode', mineStatus.nodeLimits, mineName)
                else
                    Debug("Player is outside " .. mineName .. " zone")
                    isInMineZone = nil
                    MinedData = {}
                end
            end)
        end
    end
end)

-- ------------------------------- Main Thread ------------------------------ --
CreateThread(function()
    repeat Wait(1000) until LocalPlayer.state.IsInSession
    promptSetup()
    -- if mineStatus.hasPickaxe > 0 then
    --     TriggerEvent('bnddo_mining:client:pickaxeStatus', true)
    -- end
    while true do
        local timeout = 500
        local player = PlayerPedId()

        local playerNearNode = false

        if isInMineZone and playerHasPickaxe and not isPlayerMining and not IsEntityDead(player) then -- player states
            local playerCoords = GetEntityCoords(player)
            -- callback to check tool (equipment state
            for node, nodeData in pairs(Config.MiningLocations[isInMineZone].nodes) do
                local playerDistance = checkDistance(playerCoords, nodeData.coords)
                local nodeKey = NodeKey(isInMineZone, nodeData.coords)
                local isNodeLocked = isNodeUnlocked(nodeKey)
                local nodeInfo = MinedData[nodeKey]
                local nodeAvailable = nodeInfo and nodeInfo.currentCount < nodeInfo.maxCount
                local canUsePrompt = playerDistance <= nodeData.promptDistance
                    and not isPromptPressed
                    and isNodeLocked
                    and nodeAvailable


                if canUsePrompt then
                    playerNearNode = true
                    addMiningPrompt(node)


                    if UiPromptHasHoldModeCompleted(StartMining) then
                        isPromptPressed = true
                        Debug("pressed the mining prompt")
                        TriggerEvent('bnddo_mining:client:startMining', isInMineZone, node, nodeData.coords)
                    end
                end
            end
        end
        timeout = playerNearNode and 5 or 500
        Wait(timeout)
    end
end)


RegisterCommand("checkNodeStatus", function()
    print("Node Status: " .. json.encode(MinedData))
end, false)
