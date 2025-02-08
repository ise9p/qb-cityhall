Config = {}

Config.TextUILabel = 'City Hall' 
Config.TextUILabelE = '[E] City Hall' 

Config.WebhookURL = ""

Config.NPC = {
    [1] = {
        coords = vector4(233.42, -417.67, 48.1, 346.35),  -- 
        model = "s_m_m_fiboffice_02", 
        synced = true 
    },
}

Config.menu = 'ox'
Config.showTextUI = 'ox'

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