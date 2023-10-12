local QBCore = exports[Config.CoreName]:GetCoreObject()

QBCore.Functions.CreateCallback('rv_slaughterhouse:server:GetItemAmount', function(source, cb, name)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Player.Functions.GetItemByName(name)
    if item == nil then
        cb(0)
        return
    end
    cb(item.amount)
end)

RegisterNetEvent('rv_slaughterhouse:server:KillAnimal', function(info)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(info.Item.Name, math.random(info.Item.AmountMin, info.Item.AmountMax))
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[info.Item.Name], 'add')
end)

RegisterNetEvent('rv_slaughterhouse:server:CookMeat', function(info, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Player.Functions.GetItemByName(info.Raw)
    if item.amount < amount then
        TriggerClientEvent('QBCore:Notify', src, Locale.Error.dont_have, 'error')
        return
    end
    Player.Functions.RemoveItem(info.Raw, amount)
    Player.Functions.AddItem(info.Cooked, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[info.Cooked], 'add')
end)

RegisterNetEvent('rv_slaughterhouse:server:SellFood', function(info, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Player.Functions.GetItemByName(info.Item)
    if item.amount < amount then
        TriggerClientEvent('QBCore:Notify', src, Locale.Error.dont_have, 'error')
        return
    end
    Player.Functions.RemoveItem(info.Item, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[info.Item], 'remove')
    Player.Functions.AddMoney('cash', amount * info.SellPrice)
end)