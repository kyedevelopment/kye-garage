local Admins = {}
local Garages = {}

AddEventHandler("kye:Garage:AddGarages")
RegisterNetEvent("kye:Garage:AddGarages", function (g)
    local zrt = getplayer()
    local xPlayer = zrt(source)	
    local identifier = getidentifier(xPlayer)
    if checkAllowed(identifier) then
        local encodedGarage = json.encode(g)
        table.insert(Garages, g)
        AddNoSaveGarages(g)
    end
end)


AddEventHandler("onResourceStart", function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  for k,v in pairs(Config.Admins) do
    table.insert(Admins, v)
  end
  for k,v in pairs(Config.Garages) do
    x = {
        type = v.type,
        coords = v.coords,
        spawn_coords = v.spawn_coords
    }
    table.insert(Garages, x)
  end
  Citizen.Wait(2500)
  TriggerClientEvent('kye:Garage:AddNewGarage', -1, Garages)
  Citizen.Wait(10000)
  TriggerClientEvent('kye:Garage:AddNewGarage', -1, Garages)
end)

RegisterCommand(Config.Commands.AdminAddGarageCommand, function (source, args)
    local zrt = getplayer()
    local xPlayer = zrt(source)	
    local identifier = getidentifier(xPlayer)
    if checkAllowed(identifier) then
        TriggerClientEvent("kye:GarageCL:AddGarage", source, tonumber(args[1]))
    end
end)

RegisterCommand(Config.Commands.GiveAdminCommand, function (source, args)
    if source == 0 then
        if tonumber(args[1]) then
        local zrt = getplayer()
        local xPlayer = zrt(tonumber(args[1]))	
        local identifier = getidentifier(xPlayer)
        AddNoSaveAdmin(identifier)
        RemoveAdmins()
        end
    end
end)

function AddNoSaveGarages()
    RemoveGarages()
    Citizen.Wait(500)
    AddGarages()
end

function AddGarages()
    local path = GetResourcePath(GetCurrentResourceName())
    local file = io.open(path.."/shared/config.lua", "a") 

    file:write("Config.Garages = {")
    for k,v in pairs(Garages) do
        file:write("\n    {")
        file:write("\n        type = \"" .. v.type .. "\",")
        file:write("\n        coords = vector3(" .. v.coords.x .. ", " .. v.coords.y .. ", " .. v.coords.z .. "),")
        file:write("\n        spawn_coords = vector4(" .. v.spawn_coords.x .. ", " .. v.spawn_coords.y .. ", " .. v.spawn_coords.z .. ", " .. v.spawn_coords.w .. "),")
        file:write("\n    },")
    end
    file:write("\n}")
    file:close()
    Citizen.Wait(2500)
    TriggerClientEvent('kye:Garage:AddNewGarage', -1, Garages)
end

function GarageReturns()
  return Garages
end

function RemoveGarages()
    local path = GetResourcePath(GetCurrentResourceName())
    local file = io.open(path .. "/shared/config.lua", "r")
    
    if not file then
        return
    end
    
    local content = file:read("*all")
    file:close()
    
    content = string.gsub(content, "Config%.Garages%s*=%s*%b{}\n", "")
    content = string.gsub(content, "Config%.Garages%s*=%s*{}\n", "")
    content = string.gsub(content, "Config%.Garages%s*=%s*%b{}%s*", "")
    content = string.gsub(content, "Config%.Garages%s*=%s*{}%s*", "")
    
    file = io.open(path .. "/shared/config.lua", "w")
    file:write(content)
    file:close()
end



function AddNoSaveAdmin(identifier)
    table.insert(Admins, identifier)
    AddAdmin()
    RemoveAdmins()
end

function AddAdmin()
    local path = GetResourcePath(GetCurrentResourceName())
    local file = io.open(path.."/shared/config.lua", "a") 
    
    local hasConfigAdmins = false
    for line in io.lines(path.."/shared/config.lua") do
      if line:find("Config%.Admins%s*=%s*{") then
        hasConfigAdmins = true
        break
      end
    end
    file:write("\n}")
      file:write("\nConfig.Admins = {")
		for k,v in pairs(Admins) do
            file:write("\n    \"" .. v .. "\",")
        end
      file:write("\n}")
    
    file:close()
end

function RemoveAdmins()
    local path = GetResourcePath(GetCurrentResourceName())
    local file = io.open(path .. "/shared/config.lua", "r")
    
    if not file then
    else
        local content = file:read("*all")
        file:close()
        content = string.gsub(content, "Config%.Admins%s*=%s*{.-}%s*\n", "")
        file = io.open(path .. "/shared/config.lua", "w")
        file:write(content)
        file:close()
    end
end

function lines_from(file)
    lines = {}
    for line in io.lines(file) do 
      lines[#lines + 1] = line
    end
    return lines
end

function DeleteString(path, before)
    local inf = assert(io.open(path, "r+"), "Failed to open input file")
    local lines = ""
    while true do
        local line = inf:read("*line")
		if not line then break end
		
		if line ~= before then lines = lines .. line .. "\n" end
    end
    inf:close()
    file = io.open(path, "w")
    file:write(lines)
    file:close()
end

function lines_from(file)
    lines = {}
    for line in io.lines(file) do 
      lines[#lines + 1] = line
    end
    return lines
  end

function getadmin()
    return Admins
end
