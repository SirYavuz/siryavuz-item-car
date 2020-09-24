
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('item_car_neon', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    local aracadi = 'neon'
    local model = 1
    TriggerClientEvent('yavuz:arac:getir', source, aracadi, model)
    xPlayer.removeInventoryItem('item_car_neon', 1)  
end)

ESX.RegisterUsableItem('item_car_baller2', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    local aracadi = 'baller2'
    local model = 2
    TriggerClientEvent('yavuz:arac:getir', source, aracadi, model)
    xPlayer.removeInventoryItem('item_car_baller2', 1)  
end)

ESX.RegisterUsableItem('item_car_banshee', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    local aracadi = 'banshee'
    local model = 3
    TriggerClientEvent('yavuz:arac:getir', source, aracadi, model)
    xPlayer.removeInventoryItem('item_car_banshee', 1)  
end)

RegisterNetEvent('arac:ver')
AddEventHandler('arac:ver', function(aracmodeli)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(aracmodeli, 1)  
end)


