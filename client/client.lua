local QBCore = exports[Config.CoreName]:GetCoreObject()
local AliveAnimals = {}
local Killing = false
local Cooking = false

Citizen.CreateThread(function()
    for k,v in pairs(Config.AnimalSpawns) do
        local Blip = AddBlipForCoord(v.Blip.Coords)
        SetBlipSprite(Blip, v.Blip.Sprite)
        SetBlipDisplay(Blip, 4)
        SetBlipScale(Blip, v.Blip.Scale)
        SetBlipColour(Blip, v.Blip.Color)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(v.Blip.Name)
        EndTextCommandSetBlipName(Blip)
    end
    local Blip = AddBlipForCoord(Config.SellFood.Blip.Coords)
    SetBlipSprite(Blip, Config.SellFood.Blip.Sprite)
    SetBlipDisplay(Blip, 4)
    SetBlipScale(Blip, Config.SellFood.Blip.Scale)
    SetBlipColour(Blip, Config.SellFood.Blip.Color)
    SetBlipAsShortRange(Blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.SellFood.Blip.Name)
    EndTextCommandSetBlipName(Blip)

    local Blip = AddBlipForCoord(Config.Cooker.Blip.Coords)
    SetBlipSprite(Blip, Config.Cooker.Blip.Sprite)
    SetBlipDisplay(Blip, 4)
    SetBlipScale(Blip, Config.Cooker.Blip.Scale)
    SetBlipColour(Blip, Config.Cooker.Blip.Color)
    SetBlipAsShortRange(Blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Cooker.Blip.Name)
    EndTextCommandSetBlipName(Blip)
    
    RequestModel(GetHashKey(Config.SellFood.Ped.Model))
    while not HasModelLoaded(GetHashKey(Config.SellFood.Ped.Model)) do
        Wait(1)
    end
    local ped = CreatePed(5, GetHashKey(Config.SellFood.Ped.Model), Config.SellFood.Ped.Coords, false, false)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    exports[Config.TargetName]:AddBoxZone('sell-food', Config.SellFood.Target.Coords, 1.5, 1.6, {
        name = "sell-food",
        heading = Config.SellFood.Target.Heading,
        debugPoly = false
    }, {
        options = {
            {
                type = "client",
                event = "rv_slaughterhouse:client:SellFood",
                icon = "fas fa-money-bill",
                label = Locale.Info.sell_meat
            }
        }
    })

    exports[Config.TargetName]:AddBoxZone('meat-cooker', Config.Cooker.Target.Coords, 1.5, 1.6, {
        name = "meat-coooker",
        heading = Config.Cooker.Target.Heading,
        debugPoly = false
    }, {
        options = {
            {
                type = "client",
                event = "rv_slaughterhouse:client:CookMeat",
                icon = "fas fa-water",
                label = Locale.Info.cook_meat
            }
        }
    })
end)

Citizen.CreateThread(function()
    while true do
        local Animals = {}
        for k,v in pairs(AliveAnimals) do
            if v ~= nil and not IsPedDeadOrDying(v) then
                table.insert(Animals, v)
            end
        end
        if #Animals < 30 then
            for k,v in pairs(Config.AnimalSpawns) do
                RequestModel(GetHashKey(v.EntityModel))
                while not HasModelLoaded(GetHashKey(v.EntityModel)) do
                    Wait(1)
                end
                local ped = CreatePed(5, GetHashKey(v.EntityModel), v.SpawnLocation, false, false)
                SetEntityAsMissionEntity(ped, true, true)
                TaskWanderStandard(ped, 10.0, 10)
                table.insert(Animals, ped)
                exports[Config.TargetName]:AddTargetEntity(ped, {
                    options = {
                        {
                            type = "client",
                            action = function()
                                if GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey("weapon_knife") then
                                    QBCore.Functions.Notify(Locale.Error.need_knife, 'error', 5000)
                                    return
                                end
                                if IsPedDeadOrDying(ped) then
                                    QBCore.Functions.Notify(Locale.Error.already_dead, 'error', 5000)
                                    return
                                end
                                if Killing then
                                    QBCore.Functions.Notify(Locale.Error.already_killing, 'error', 5000)
                                    return
                                end
                                FreezeEntityPosition(ped, true)
                                LoadAnimDict("missheistdocks2a")
                                LoadAnimDict("amb@prop_human_bum_bin@idle_b")
                                TaskPlayAnim(PlayerPedId(), "missheistdocks2a", "stabbing_guard_michael", 4.0, 4.0, -1, 1, 0, false, false, false)
                                Killing = true
                                QBCore.Functions.Progressbar("killing", Locale.Info.killing_animal, math.random(5000, 10000), false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true
                                }, {
                                }, {}, {}, function() -- Done
                                    exports[Config.TargetName]:RemoveTargetEntity(ped)
                                    TriggerServerEvent('rv_slaughterhouse:server:KillAnimal', v)
                                    FreezeEntityPosition(ped, false)
                                    SetEntityHealth(ped, 0)
                                    Killing = false
                                    TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "exit", 4.0, 4.0, -1, 50, 0, false, false, false)
                                    Wait(10000)
                                    DeleteEntity(ped)
                                end, function() -- Cancel
                                    TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "exit", 4.0, 4.0, -1, 50, 0, false, false, false)
                                end)
                            end,
                            icon = "fas fa-utensils",
                            label = Locale.Info.kill_animal
                        }
                    }
                })
            end
        end
        AliveAnimals = Animals
        Citizen.Wait(30000)
    end
end)

RegisterNetEvent('rv_slaughterhouse:client:CookMeat', function()
    local options = {}
    for k,v in pairs(Config.Cooker.Items) do
        options[#options+1] = {
            title = v.MenuText,
            onSelect = function()
                local p = promise.new()
                local amount
                QBCore.Functions.TriggerCallback('rv_slaughterhouse:server:GetItemAmount', function(result)
                    p:resolve(result)
                end, v.Raw)
                amount = Citizen.Await(p)
                if amount <= 0 then
                    QBCore.Functions.Notify(Locale.Error.dont_have, 'error', 5000)
                    return
                end
                if Cooking then 
                    return
                end
                Cooking = true
                LoadAnimDict("amb@prop_human_bum_bin@idle_b")
                TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 4.0, 4.0, -1, 50, 0, false, false, false)
                QBCore.Functions.Progressbar("cooking", Locale.Info.cooking_meat, amount * 3500, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true
                }, {
                }, {}, {}, function() -- Done
                    TriggerServerEvent('rv_slaughterhouse:server:CookMeat', v, amount)
                    Cooking = false
                    TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "exit", 4.0, 4.0, -1, 50, 0, false, false, false)
                end, function() -- Cancel
                    TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "exit", 4.0, 4.0, -1, 50, 0, false, false, false)
                end)
            end
        }
    end
    lib.registerContext({
        id = 'rinse',
        title = Locale.Info.cook_meat,
        options = options,
        onExit = function()
        end
    })
    lib.showContext('rinse')
end)

RegisterNetEvent('rv_slaughterhouse:client:SellFood', function()
    local options = {}
    for k,v in pairs(Config.SellFood.Items) do
        options[#options+1] = {
            title = v.MenuText,
            onSelect = function()
                local p = promise.new()
                local amount
                QBCore.Functions.TriggerCallback('rv_slaughterhouse:server:GetItemAmount', function(result)
                    p:resolve(result)
                end, v.Item)
                amount = Citizen.Await(p)
                if amount <= 0 then
                    QBCore.Functions.Notify(Locale.Error.dont_have, 'error', 5000)
                    return
                end
                TriggerServerEvent('rv_slaughterhouse:server:SellFood', v, amount)
            end
        }
    end
    lib.registerContext({
        id = 'sell',
        title = Locale.Info.sell_meat,
        options = options,
        onExit = function()
        end
    })
    lib.showContext('sell')
end)

function LoadAnimDict(dict)
    if HasAnimDictLoaded(dict) then return end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end