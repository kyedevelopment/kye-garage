Config = {}

Config.Mysql = "oxmysql" -- oxmysql , mysql-async , ghmattimysql
Config.Distance = 5 -- Where to access the menu
Config.AdminAddGarageCommand = "add_garage" -- admin garage
Config.Commands = {
	AdminAddGarageCommand = "add_garage", -- admin garage
	GiveAdminCommand = "garage_permission" -- cmd in garage add permission command
}

Config.Markers = {
	Garages = {
		Type = 21,
		Size = {
			x = 1.0,
			y = 1.0,
			z = 0.5,
		},
		Color = {
			r = 50,
			g = 200,
			b = 50,
		},
	},
	Impounds = {
		Type = 21,
		Size = {
			x = 1.0,
			y = 1.0,
			z = 0.5,
		},
		Color = {
			r = 200,
			g = 51,
			b = 51,
		},
	},
}

Config.Blips = {
    Blips = true,
    car = {
		Sprite = 357,
		Scale = 0.8,
		Colour = 4,
    },
    boat = {
		Sprite = 357,
		Scale = 0.8,
		Colour = 4,
    },
    air = {
        Sprite = 357,
		Scale = 0.8,
		Colour = 4,
    },
    Impounds = {
        Sprite = 357,
		Scale = 0.8,
		Colour = 1,
    }
}

exports("getGarages", function()
	return Config.Garages
end)
exports("getImpounds", function()
	return Config.Impounds
end)

Config.Langs = {
	novehicle = "You can't get this car out of here.",
	yournovehicle = "You don't have a car",
	gps = "Vehicle marked on GPS outside",
	ispedveh = "You can't access it while inside the vehicle",
	GarageName = "Garage",
	ImpoundsName = "Impound",
	GarageText = "[E] - Open Garage",
	GarageText_park = "[E] - Parking Car",
	ImpoundText = "[E] - Open Impound",
	AddGarageLv1 = "Location Selected , Now go to the Spawn location and use the same command",
	AddGarageLv2 = "Added Garage"
}

Config.Impounds = {
    {
        type = "car", -- car , boat , air
        coords = vector3(100.6884, -1073.426, 29.37411),
        spawn_coords =vector4(121.2525, -1080.609, 29.19272, 1.873257)
    },
}

Config.Admins = {
    "f12eec9a9a7aedb1c17c0ff2812faaac0751cde1",
}
Config.Garages = {
    {
        type = "car",
        coords = vector3(-67.925750732422, -1165.9440917969, 25.981439590454),
        spawn_coords = vector4(-66.692680358887, -1160.3992919922, 25.912178039551, 0.0),
    },
    {
        type = "car",
        coords = vector3(273.47482299805, -343.97290039062, 44.919883728027),
        spawn_coords = vector4(272.63336181641, -335.55212402344, 44.919883728027, 0.0),
    },
    {
        type = "car",
        coords = vector3(-475.76904296875, -818.78277587891, 30.462129592896),
        spawn_coords = vector4(-468.67501831055, -809.33587646484, 30.538684844971, 0.0),
    },
    {
        type = "car",
        coords = vector3(214.11990356445, -809.50134277344, 31.014888763428),
        spawn_coords = vector4(209.79797363281, -793.48797607422, 30.929304122925, 0.0),
    },
    {
        type = "car",
        coords = vector3(-68.921859741211, -1818.4470214844, 26.941968917847),
        spawn_coords = vector4(-58.376796722412, -1843.0462646484, 26.537179946899, 0.0),
    },
    {
        type = "car",
        coords = vector3(324.67623901367, -1366.5270996094, 31.95908164978),
        spawn_coords = vector4(321.23751831055, -1352.9305419922, 32.259986877441, 0.0),
    },
    {
        type = "car",
        coords = vector3(596.60955810547, 91.28443145752, 93.129554748535),
        spawn_coords = vector4(611.67828369141, 91.703628540039, 92.428489685059, 0.0),
    },
    {
        type = "car",
        coords = vector3(-535.64178466797, 57.764400482178, 52.57986831665),
        spawn_coords = vector4(-513.27221679688, 64.804481506348, 52.580715179443, 0.0),
    },
    {
        type = "car",
        coords = vector3(220.06976318359, -2575.609375, 6.159264087677),
        spawn_coords = vector4(194.68054199219, -2557.8647460938, 5.9003901481628, 0.0),
    },
}