# City Hall System

## Overview
This system allows players to interact with a City Hall in a FiveM server, offering functionalities like job selection, obtaining identity documents (e.g., ID card, driver license), and managing various administrative tasks.

## Features
- NPC Interaction: The system allows players to interact with NPCs placed at the City Hall location.
- Job Menu: Players can select from various available jobs.
- Identity Documents: Players can obtain identity documents such as an ID card and driver license for a fee.
- City Hall Blip: A City Hall marker is placed on the map for easy access.
- Discord Logging: Job changes and item transactions are logged to a specified Discord webhook.

## Installation

1. Add the Script : 
   - Place the script in your `resources` folder.
   - Ensure it's started in your server configuration.

2. Configuring the NPC :
   - Set the coordinates and model of the NPC that will be placed at the City Hall.
   - Example: `coords = vector4(233.42, -417.67, 48.1, 346.35)`.

3. Configuring Jobs :
   - You can customize the available jobs in the `Config.Jobs` table. Each job has properties like label, job name, icon, and whether it's under maintenance.
   - Jobs that are under maintenance will not be available for players to select.

4. Configuring Identity Documents :
   - Configure the available identity documents in the `Config.Documents` table, including the price and description for each document.
   - Example documents: ID Card, Driver License.

5. Blip Customization :
   - Modify the `Config.CityHallBlip` section to change the location, sprite, and appearance of the City Hall blip on the map.
   - Example: `sprite = 682`, `coords = vector3(233.42, -417.67, 48.1)`.

6. Webhook Configuration :
   - Set your own Discord webhook URL in the `Config.WebhookURL` field to log job changes and item transactions to Discord.
   - Example: `Config.WebhookURL = "https://discord.com/api/webhooks/..."`.

7. install ox_lib [https://github.com/overextended/ox_lib] [Opition]

8. install mt_lib [https://github.com/MT-Scripts/mt_lib] [Opition]


## Commands and Interactions
- Job Menu**: Players can view and apply for available jobs by interacting with the City Hall NPC.
- Identity Documents : Players can purchase documents like ID cards and driver licenses.
- City Hall Location : A blip will appear on the map marking the City Hall location for easy navigation.

##  Features
-  using DrawText in qbcore or ox_lib
-  there's uses system

#  Support
Encountered a bug  or have an awesome feature suggestion🌠? Don't hesitate to create an issue in the repository.

# Customization
The script is fully open to modifications. Feel free to tweak it to fit your server's unique needs! 

## Sample Configuration

```lua
Config = {}

Config.TextUILabel = 'City Hall' 
Config.TextUILabelE = '[E] City Hall' 

Config.WebhookURL = "" -- [Add Url WebHook Discord]

Config.NPC = {
    [1] = {
        coords = vector4(233.42, -417.67, 48.1, 346.35),  -- City Hall NPC location
        model = "s_m_m_fiboffice_02", 
        synced = true 
    },
}

Config.menu = 'ox'  -- [ 'qb' qb-menu or 'ox' ox_lib menu ]
Config.showTextUI = 'ox'  -- [ 'qb'  or 'ox' ox_lib  or 'mt' mt_lib ]

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
