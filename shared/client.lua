ESX = exports["es_extended"]:getSharedObject()


-------------------------------- 

function notify(text)
      ESX.ShowNotification(text)
end

-------------------------------- 

function getAllVehicle()
      return ESX.Game.GetVehicles()
end

-------------------------------- 

function gettrim(value)
      if value then
            return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
      else
            return nil
      end
end

-------------------------------- 

function spawnveh(vehicleProps,vehiclex)
      ESX.Game.SpawnVehicle(vehicleProps.model, vector3(garagesreturn()[SelectGarage].spawn_coords.x,garagesreturn()[SelectGarage].spawn_coords.y,garagesreturn()[SelectGarage].spawn_coords.z), garagesreturn()[SelectGarage].spawn_coords.x, function(vehicle)
            ESX.Game.SetVehicleProperties(vehicle, vehicleProps, vehiclex)
            SetVehicleNumberPlateText(vehicle, vehicleProps.plate)
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
      end)
end

-------------------------------- 

function spawnimveh(vehicleProps,vehiclex)
      ESX.Game.SpawnVehicle(vehicleProps.model, vector3(Config.Impounds[SelectGarage].spawn_coords.x,Config.Impounds[SelectGarage].spawn_coords.y,Config.Impounds[SelectGarage].spawn_coords.z), Config.Impounds[SelectGarage].spawn_coords.x, function(vehicle)
            ESX.Game.SetVehicleProperties(vehicle, vehiclex)
            SetVehicleNumberPlateText(vehicle, vehicleProps.plate)
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
      end)
end
-------------------------------- 

function getvehicleproperties(vehicle)
      return ESX.Game.GetVehicleProperties(vehicle)
end

-------------------------------- 

function DrawText3D(x,y,z, text)
      local onScreen,_x,_y=World3dToScreen2d(x,y,z)
      local px,py,pz=table.unpack(GetGameplayCamCoords())
      
      SetTextScale(0.35, 0.35)
      SetTextFont(4)
      SetTextProportional(1)
      SetTextColour(255, 255, 255, 215)
    
      SetTextEntry("STRING")
      SetTextCentre(1)
      AddTextComponentString(text)
      DrawText(_x,_y)
      local factor = (string.len(text)) / 370
      DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
    end