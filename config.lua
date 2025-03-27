Config = {}

Config.TextUILabel = 'City Hall' -- ox_lib/mt_lib text ui
Config.TextUILabelE = '[E] City Hall'  -- qbcore text ui

Config.WebhookURL = ""

Config.NPC = {
    [1] = {
        coords = vector4(237.75, -413.09, 48.11, 345.65),  -- 
        model = "s_m_m_fiboffice_02", 
        synced = true 
    },
}

Config.menu = 'qb' -- [ 'qb' qb-menu or 'ox' ox_lib menu ]
Config.showTextUI = 'qb' -- [ 'qb' or 'ox' ox_lib or 'mt' mt_lib ]
Config.notify = 'qb' -- [ 'qb' or 'ox' ox_lib ]
Config.Ped = 'target' -- [ 'target' or 'DrewText' ]
Config.target = 'qb' -- [ 'qb' qb-target or 'ox' ox_target ]

--[[ 
    underMaintenance = false, -- الوظيفة متاحة
    underMaintenance = true, -- الوظيفة تحت الصيانة
]]
Config.Jobs = {
    {label = 'Unemployed', job = 'unemployed', grade = '0', icon = 'fas fa-broom', underMaintenance = false},  
    {label = 'Garbage', job = 'garbage', grade = '0', icon = 'fas fa-trash', underMaintenance = false},    
}

Config.CityHallBlip = {
    coords = vector3(233.42, -417.67, 48.1), 
    sprite = 682,
    scale = 0.6,  
    colour = 0,   
    name = "City Hall", 
}


Config.Documents = {
    {
        label = 'ID Card', 
        desc = 'Take ID Card for 50$', 
        item = 'id_card', 
        price = '50', 
        icon = 'fas fa-id-card'
    },
    {
        label = 'Driver license',
        desc = 'Take Driver License 50$',
        item = 'driver_license',
        price = '50',
        icon = 'fas fa-id-card'
    }
}
