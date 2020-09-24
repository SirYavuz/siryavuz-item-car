ESX                           = nil
local sonkullanilan = nil
local aracismi = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
  end
end)

RegisterNetEvent('yavuz:arac:getir')
AddEventHandler('yavuz:arac:getir', function(aracadi, model)
    modelhesapla(model)
    arac_cikart(aracadi)
end)

function modelhesapla(model)
    if model == 1 then
        aracmodeli = 'item_car_neon'
    end
    if model == 2 then
        aracmodeli = 'item_car_baller2'
    end
    if model == 3 then
        aracmodeli = 'item_car_banshee'
    end
end

function arac_cikart(aracadi)
    if not durum then
        animasyon()
	Citizen.Wait(3000)

	local myPed = GetPlayerPed(-1)
	local player = PlayerId()
    local vehicle = GetHashKey(aracadi)
    local playerloc = GetEntityCoords(myPed, 0)
    ESX.ShowNotification('Çıkartılan araç modeli : '..aracadi..' ')
    sonkullanilan = (aracadi)

	RequestModel(vehicle)

	while not HasModelLoaded(vehicle) do
		Wait(1)
	end

	local plate = math.random(100, 900)
	local spawned_car = CreateVehicle(vehicle, playerloc['x'], playerloc['y'], playerloc['z'], 431.436, - 996.786, 25.1887, true, false)

	local plate = "SYZ"..math.random(100, 300)
    SetVehicleNumberPlateText(spawned_car, plate)
	SetVehicleOnGroundProperly(spawned_car)
	SetVehicleLivery(spawned_car, 2)
	SetPedIntoVehicle(myPed, spawned_car, - 1)
	SetModelAsNoLongerNeeded(vehicle)
	Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
    durum = true
else
    ESX.ShowNotification('Şuan zaten dışarıda bir aracın mevcut')
end
end

RegisterCommand('aracitemyap', function()
    TriggerEvent('yoket', source)
end)

RegisterNetEvent('yoket')
AddEventHandler('yoket', function()
    if durum then
       ESX.ShowNotification('Araç çekiliyor : ' ..sonkullanilan)
	local vehicle, attempt = ESX.Game.GetVehicleInDirection(), 0


	while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
		Citizen.Wait(100)
		NetworkRequestControlOfEntity(vehicle)
		attempt = attempt + 1
	end

    if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
        animasyon()
        Citizen.Wait(2000)
		TriggerEvent("mythic_progressbar:client:progress", {
        name = "cekiliyor",
        duration = 1500,
        label = "Araç Alınıyor",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = false,
        },
		}, function(status)
			if not status then
				
			end
	end)
		Citizen.Wait(1500)
        ESX.Game.DeleteVehicle(vehicle)
        TriggerServerEvent('arac:ver', aracmodeli)
        durum = false
    end
else
    ESX.ShowNotification('Herhangi bir araç çıkartmamışsın!')
end
end)

function animasyon()
    local playerPed = GetPlayerPed(-1)
    if not IsEntityPlayingAnim(playerPed, 'random@domestic', 'pickup_low', 3) then
        ESX.Streaming.RequestAnimDict('random@domestic', function()
            TaskPlayAnim(playerPed, 'random@domestic', 'pickup_low', 8.0, -8, -1, 48, 0, 0, 0, 0)
        end)
    end
end


