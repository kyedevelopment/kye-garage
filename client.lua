local blipx = {}
local NewGarage = {
    type = "No Value Entered",
    coords = vector3(0,0,0),
    spawn_coords = vector4(0,0,0,0)
}
local NewGarageLevel = 1
local typeNew = "No Value Entered"
local playercoordNew = "No Value Entered"
local Garages = {}
local GarageType = nil
SelectGarage = 0
Citizen.CreateThread(function()
	while true do
		local sleep = 500
		local playercoord = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Garages) do
            local dst = #(playercoord - vector3(v.coords.x,v.coords.y,v.coords.z))
                if dst < Config.Distance then
                    sleep = 1
                    DrawMarker(Config.Markers.Garages.Type, v.coords.x,v.coords.y,v.coords.z, 0.0, 0.0,
                    0.0, 0, 0.0, 0.0, Config.Markers.Garages.Size.x, Config.Markers.Garages.Size.y,
                    Config.Markers.Garages.Size.z, Config.Markers.Garages.Color.r,
                    Config.Markers.Garages.Color.g, Config.Markers.Garages.Color.b, 100, false, true, 2, false,
                    false, false, false)
                    if IsPedSittingInAnyVehicle(PlayerPedId()) then
					    DrawText3D(playercoord.x, playercoord.y, playercoord.z+0.0, Config.Langs.GarageText_park)
                    else 
					    DrawText3D(playercoord.x, playercoord.y, playercoord.z+0.0, Config.Langs.GarageText)
                    end
                    if IsControlJustReleased(0,38) then
                        if IsPedSittingInAnyVehicle(PlayerPedId()) then 
                            CarParking()
                        else
                            GarageType = "garage"
                            SelectGarage = k
                            TriggerServerEvent("kye:getCars", v.type)
                        end
                    end
                end
            end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	while true do
		local sleep = 500
		local playercoord = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Impounds) do
            local dst = #(playercoord - vector3(v.coords.x,v.coords.y,v.coords.z))
                if dst < Config.Distance then
                sleep = 1
                    DrawMarker(Config.Markers.Impounds.Type, v.coords.x,v.coords.y,v.coords.z, 0.0, 0.0,
                    0.0, 0, 0.0, 0.0, Config.Markers.Garages.Size.x, Config.Markers.Impounds.Size.y,
                    Config.Markers.Impounds.Size.z, Config.Markers.Impounds.Color.r,
                    Config.Markers.Impounds.Color.g, Config.Markers.Impounds.Color.b, 100, false, true, 2, false,
                    false, false, false)
					DrawText3D(playercoord.x, playercoord.y, playercoord.z+0.0, Config.Langs.ImpoundText)
                    if IsControlJustReleased(0,38) then
                        if IsPedSittingInAnyVehicle(PlayerPedId()) then
                            notify(Config.Langs.ispedveh)
                        else
                            GarageType = "import"
                            SelectGarage = k
                            TriggerServerEvent("kye:getCars", v.type)
                        end
                    end
                end
            end
		Citizen.Wait(sleep)
	end
end)

CreateThread(function()
    if Config.Blips.Blips then
        for k, v in pairs(Config.Garages) do
            blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
            SetBlipSprite(blip, Config.Blips[v.type].Sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, Config.Blips[v.type].Scale)
            SetBlipColour(blip, Config.Blips[v.type].Colour)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.Langs.GarageName)
            EndTextCommandSetBlipName(blip)
            table.insert(blipx, blip)
        end
        for k, v in pairs(Config.Impounds) do
            local blip2 = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)

            SetBlipSprite(blip2, Config.Blips["Impounds"].Sprite)
            SetBlipDisplay(blip2, 4)
            SetBlipScale(blip2, Config.Blips["Impounds"].Scale)
            SetBlipColour(blip2, Config.Blips["Impounds"].Colour)
            SetBlipAsShortRange(blip2, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.Langs.ImpoundsName)
            EndTextCommandSetBlipName(blip2)

        end
    end
end)

AddEventHandler("kye:GarageOpenMenu")
RegisterNetEvent("kye:GarageOpenMenu", function (typer,towedcars,incars,outcars,totalcars)
    if typer == "novehicle" then
        notify(Config.Langs.yournovehicle)
    elseif typer == "open" then
        OpenMenu(towedcars,incars,outcars,totalcars)
    end
end)

AddEventHandler("kye:GarageAddVehicle")
RegisterNetEvent("kye:GarageAddVehicle", function (name,plate,fuel,engine,text)
    addedVehicle(GetDisplayNameFromVehicleModel(name),plate,fuel,engine,text)
end)

AddEventHandler("kye:Garage:Spawn")
RegisterNetEvent("kye:Garage:Spawn", function (typerx,vehicle)
    if typerx == "garage" then
        SpawnVehicle(vehicle)
    elseif typerx == "outside" then
        SpawnImpVeh(vehicle)
    end
end)

AddEventHandler("kye:GarageCL:AddGarage")
RegisterNetEvent("kye:GarageCL:AddGarage", function (type)
    local playercoord = GetEntityCoords(PlayerPedId())
    local playerHeading = GetEntityHeading(playerPed)
    local playerPos = vector4(playercoord.x, playercoord.y, playercoord.z, playerHeading)
    if NewGarageLevel == 1 then
        NewGarageLevel = 2 
        if type then 
            typeNew = type
        else 
            typeNew = "car"
        end 
        playercoordNew = playercoord
        notify(Config.Langs.AddGarageLv1)
    else 
        NewGarageLevel = 1 
        NewGarage = {
            type = typeNew,
            coords = playercoordNew,
            spawn_coords = playerPos
        }
        TriggerServerEvent('kye:Garage:AddGarages', NewGarage)
        notify(Config.Langs.AddGarageLv2)
    end
end)

AddEventHandler("kye:Garage:AddNewGarage")
RegisterNetEvent("kye:Garage:AddNewGarage", function (Garagesg)
    Garages = Garagesg
    RemoveAllGarageBlip()
    EditNewBlips()
end)

function OpenMenu(towedcars,incars,outcars,totalcars)
    SendNUIMessage({
        action = "openmenu",
        totalcars = totalcars,
        towedcars = towedcars,
        incars = incars,
        outcars = outcars
    })
    SetNuiFocus(true, true)
end

function addedVehicle(name,plate,fuel,engine,text)
    SendNUIMessage({
        action = "added",
        name = name,
        plate = plate,
        fuel = fuel,
        engine = engine,
        text = text
    })
end

function EditNewBlips() 
    if Config.Blips.Blips then
        for k, v in pairs(Garages) do
            blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
            SetBlipSprite(blip, Config.Blips[v.type].Sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, Config.Blips[v.type].Scale)
            SetBlipColour(blip, Config.Blips[v.type].Colour)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.Langs.GarageName)
            EndTextCommandSetBlipName(blip)
            table.insert(blipx, blip)
        end
    end
end

function SpawnImpVeh(vehiclex)
    vehicleProps = json.decode(vehiclex) 
    if GarageType == "import" then
    local gameVehicles = getAllVehicle()
    for i = 1, #gameVehicles do
        local vehicle = gameVehicles[i]
        if DoesEntityExist(vehicle) then
            if gettrim(GetVehicleNumberPlateText(vehicle)) == gettrim(vehicleProps.plate) then
                notify(Config.Langs.gps)
                local vCoords = GetEntityCoords(vehicle)
                SetNewWaypoint(vCoords.x,vCoords.y)
                return
            end
        end
    end
        spawnimveh(vehicleProps,vehiclex)
    else
        notify(Config.Langs.novehicle)
    end
end

function RemoveAllGarageBlip()
    for k, v in pairs(blipx) do
        RemoveBlip(v)
    end
end

function SpawnVehicle(vehiclex)
    vehicleProps = json.decode(vehiclex) 
    if GarageType == "garage" then
        spawnveh(vehicleProps,vehiclex)
    else 
        notify(Config.Langs.novehicle)
    end
end

function CarParking()
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    local props = getvehicleproperties(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    TriggerServerEvent('kye:Garage:SetStored', plate,1)
    TriggerServerEvent('kye:Garage:SaveProps', plate,props)
    TaskLeaveVehicle(PlayerPedId(), vehicle, 0)
    Citizen.Wait(1500)

    NetworkFadeOutEntity(vehicle, true, true)

    Citizen.Wait(100)

    SetEntityCollision(vehicle, false, false)
    SetEntityAlpha(vehicle, 0.0, true)
    SetEntityAsMissionEntity(vehicle, false, true)
    DeleteEntity(vehicle)
end

function garagesreturn()
    return Garages
end

RegisterNUICallback("close", function ()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("accept", function (data)
    plate = data.plate
    TriggerServerEvent('kye:Garage:CheckCar', plate)
end)