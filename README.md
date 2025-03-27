# City Hall System

## Overview
This system allows players to interact with a City Hall in a FiveM server, offering functionalities like job selection, obtaining identity documents (e.g., ID card, driver license), and managing various administrative tasks.

## Features
- Fixed `qb-menu` not sending a notification when selecting an option.
- Added support for **Eye Interaction** (`qb-target` & `ox-target`) for the Ped.
- You can now choose between **DrawText** or **Eye Interaction** for the Ped.
- Added notifications (`qb-notify` & `ox-lib notify`) across the entire script.

## Configuration
Modify the `config.lua` file to customize settings:

### General Settings
```lua
Config.TextUILabel = 'City Hall' -- ox_lib/mt_lib text ui
Config.TextUILabelE = '[E] City Hall'  -- qbcore text ui
Config.WebhookURL = ""
```

### NPC Configuration
```lua
Config.NPC = {
    [1] = {
        coords = vector4(237.75, -413.09, 48.11, 345.65),
        model = "s_m_m_fiboffice_02", 
        synced = true 
    },
}
```

### Menu & UI Settings
```lua
Config.menu = 'qb' -- Options: 'qb' (qb-menu) or 'ox' (ox_lib menu)
Config.showTextUI = 'qb' -- Options: 'qb' (qbcore text UI) or 'ox' (ox_lib) or 'mt' (mt_lib)
Config.notify = 'qb' -- Options: 'qb' (qb-notify) or 'ox' (ox-lib notify)
Config.Ped = 'target' -- Options: 'target' (qb-target/ox-target) or 'DrewText'
Config.target = 'qb' -- Options: 'qb' (qb-target) or 'ox' (ox_target)
```

### Job Configuration
```lua
Config.Jobs = {
    {label = 'Unemployed', job = 'unemployed', grade = '0', icon = 'fas fa-broom', underMaintenance = false},  
    {label = 'Garbage', job = 'garbage', grade = '0', icon = 'fas fa-trash', underMaintenance = false},    
}
```

### Blip Configuration
```lua
Config.CityHallBlip = {
    coords = vector3(233.42, -417.67, 48.1), 
    sprite = 682,
    scale = 0.6,  
    colour = 0,   
    name = "City Hall", 
}
```

### Documents Configuration
```lua
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
```

## Installation
1. Download and extract the script into your `resources` folder.
2. Add `ensure qb-cityhall` to your `server.cfg`.
3. Configure the `config.lua` file as needed.
4. Restart your server and enjoy!

## Dependencies
- **QBCore Framework**
- `qb-menu` or `ox_lib menu`
- `qb-target` or `ox-target`
- `qb-notify` or `ox-lib notify`

## Support
For any issues or suggestions, feel free to open an issue or contact support!
