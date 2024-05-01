ESX = exports["es_extended"]:getSharedObject()

-------------------------------- 

 function checkAllowed(id)
    for k, v in pairs(getadmin()) do
        if id == v then
      return true
        end
    end
    return false
  end

  -------------------------------- 

AddEventHandler('esx:playerLoaded',function(playerId)
    Citizen.Wait(5000)
    TriggerClientEvent('kye:Garage:AddNewGarage', playerId,  GarageReturns())
    Citizen.Wait(15000)
    TriggerClientEvent('kye:Garage:AddNewGarage', playerId,  GarageReturns())
    Citizen.Wait(25000)
    TriggerClientEvent('kye:Garage:AddNewGarage', playerId,  GarageReturns())
end)

-------------------------------- 

function getidentifier(xPlayer)
	hex = xPlayer.identifier
	return hex
end

-------------------------------- 

function getplayer(source)
	xPlayer = ESX.GetPlayerFromId
	return xPlayer
end

-------------------------------- 
--SQL CODE --

AddEventHandler("kye:getCars")
RegisterNetEvent("kye:getCars", function (typer)
    local totalcars = 0
    local incars = 0
    local outcars = 0
    local towedcars = 0
    local src = source
    local zrt = getplayer()
    local xPlayer = zrt(src)	
    identifier = getidentifier(xPlayer) 
    local first = false 
        local data = ExecuteSql("SELECT * FROM `owned_vehicles` WHERE owner = '"..identifier.."' and type = '"..typer.."'")
        for k,v in pairs(data) do
            totalcars = totalcars + 1 
            vehicle = json.decode(v.vehicle)
            if vehicle.engineHealth then 
                if v.stored == 0 then 
                    outcars = outcars + 1
                    TriggerClientEvent("kye:GarageAddVehicle", src,vehicle.model, v.plate,vehicle.fuelLevel,vehicle.engineHealth / 10, "CAR OUTSIDE OR TOWED")
                elseif v.stored == 1 then
                    incars = incars + 1
                    TriggerClientEvent("kye:GarageAddVehicle", src,vehicle.model, v.plate,vehicle.fuelLevel,vehicle.engineHealth / 10, "IN THE GARAGE")
                elseif v.stored == 2 then 
                    towedcars = towedcars + 1
                    TriggerClientEvent("kye:GarageAddVehicle", src,vehicle.model, v.plate,vehicle.fuelLevel,vehicle.engineHealth / 10, "CAR OUTSIDE OR TOWED")
                    end
                else
                if v.stored == 0 then 
                    outcars = outcars + 1
                    TriggerClientEvent("kye:GarageAddVehicle", src,vehicle.model, v.plate,100, 100, "CAR OUTSIDE OR TOWED")
                elseif v.stored == 1 then
                    incars = incars + 1
                    TriggerClientEvent("kye:GarageAddVehicle", src,vehicle.model, v.plate, 100, 100, "IN THE GARAGE")
                elseif v.stored == 2 then 
                    towedcars = towedcars + 1
                    TriggerClientEvent("kye:GarageAddVehicle", src,vehicle.model, v.plate,100, 100, "CAR OUTSIDE OR TOWED")
                end
            end
            first = true     
        end
    if first then
        TriggerClientEvent("kye:GarageOpenMenu", src, "open",outcars,incars,towedcars,totalcars) 
        else 
        TriggerClientEvent("kye:GarageOpenMenu", src, "novehicle") 
    end
end)

RegisterNetEvent("kye:Garage:CheckCar")
AddEventHandler("kye:Garage:CheckCar", function (plate)
    local src = source
    local data = ExecuteSql("SELECT * FROM `owned_vehicles` WHERE plate = '"..plate.."' ")
    for k,v in pairs(data) do
        vehicle = json.decode(v.vehicle)
        if vehicle.engineHealth then 
            if v.stored == 0 then 
               TriggerClientEvent("kye:Garage:Spawn",src, "outside", v.vehicle)
            elseif v.stored == 1 then
                TriggerEvent("kye:Garage:SetStored",plate,0)
                TriggerClientEvent("kye:Garage:Spawn",src, "garage", v.vehicle)
            elseif v.stored == 2 then 
               TriggerEvent("kye:Garage:SetStored",plate,0)
               TriggerClientEvent("kye:Garage:Spawn",src, "outside", v.vehicle)
                end
            else
            if v.stored == 0 then 
                TriggerClientEvent("kye:Garage:Spawn",src, "outside", v.vehicle)
            elseif v.stored == 1 then
                TriggerEvent("kye:Garage:SetStored",plate,0)
                TriggerClientEvent("kye:Garage:Spawn",src, "garage", v.vehicle)
            elseif v.stored == 2 then 
                TriggerEvent("kye:Garage:SetStored",plate,0)
                TriggerClientEvent("kye:Garage:Spawn",src, "outside", v.vehicle)
            end
        end
    end
end)

AddEventHandler("kye:Garage:SetStored")
RegisterNetEvent("kye:Garage:SetStored", function (plate,stored)
    ExecuteSql("UPDATE `owned_vehicles` SET stored = '"..stored.."' WHERE plate = '"..plate.."'")
end)

AddEventHandler("kye:Garage:SaveProps")
RegisterNetEvent("kye:Garage:SaveProps", function (plate,props)
    ExecuteSql("UPDATE `owned_vehicles` SET vehicle = '"..json.encode(props).."' WHERE plate = '"..plate.."'")
end)

------------------------------------------------------------------------------------

-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX --

------------------------------------------------------------------------------------

function ExecuteSql(query)
    local IsBusy = true
    local result = nil
    if Config.Mysql == "oxmysql" then
        if MySQL == nil then
            exports.oxmysql:execute(query, function(data)
                result = data
                IsBusy = false
            end)
            -------------------------------- 
        else
            MySQL.query(query, {}, function(data)
                result = data
                IsBusy = false
            end)
        end
        -------------------------------- 
    elseif Config.Mysql == "ghmattimysql" then
        exports.ghmattimysql:execute(query, {}, function(data)
            result = data
            IsBusy = false
        end)
    elseif Config.Mysql == "mysql-async" then   
        MySQL.Async.fetchAll(query, {}, function(data)
            result = data
            IsBusy = false
        end)
        -------------------------------- 
    end
    while IsBusy do
        Citizen.Wait(0)
    end
    return result
end

------------------------------------------------------------------------------------

------------------------------------------------------------------------------------

-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX --

------------------------------------------------------------------------------------