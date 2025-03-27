local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    for _, v in pairs(Config.NPC) do
        local modelHash = GetHashKey(v.model)
        RequestModel(modelHash)
        
        while not HasModelLoaded(modelHash) do
            Wait(500)
        end
        
        local created_ped = CreatePed(0, modelHash, v.coords.x, v.coords.y, v.coords.z - 1, v.coords.w, false, false)
        
        FreezeEntityPosition(created_ped, true)
        SetEntityInvincible(created_ped, true)
        SetBlockingOfNonTemporaryEvents(created_ped, true)
    end
end)

CreateThread(function()
    local blip = AddBlipForCoord(Config.CityHallBlip.coords.x, Config.CityHallBlip.coords.y, Config.CityHallBlip.coords.z)
    
    SetBlipSprite(blip, Config.CityHallBlip.sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, Config.CityHallBlip.scale)
    SetBlipColour(blip, Config.CityHallBlip.colour)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.CityHallBlip.name)
    EndTextCommandSetBlipName(blip)
end)

CreateThread(function()
    if Config.Ped == "target" then
        if Config.target == "qb" then
            exports['qb-target']:AddTargetModel(Config.NPC[1].model, {
                options = {
                    {
                        type = "client",
                        event = "qb-cityhall:mainMenu",
                        icon = "fas fa-city",
                        label = "Access City Hall",
                    }
                },
                distance = 2.5,
            })
        elseif Config.target == "ox" then
            exports.ox_target:addModel(Config.NPC[1].model, {
                {
                    name = 'cityhall_access',
                    icon = "fas fa-city",
                    label = "Access City Hall",
                    onSelect = function()
                        TriggerEvent("qb-cityhall:mainMenu")
                    end,
                    distance = 2.5,
                }
            })
        end
    elseif Config.Ped == "DrewText" then
        while true do
            toPed = false
            wait = 1000
            for k, v in pairs(Config.NPC) do
                local pos = GetEntityCoords(PlayerPedId())
                local Distance = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                if Distance < 2 then
                    toPed = true
                    wait = 5
                    if Config.showTextUI == "qb" then
                        exports["qb-core"]:DrawText(Config.TextUILabelE, "left")
                    elseif Config.showTextUI == "ox" then
                        lib.showTextUI(Config.TextUILabelE, { position = "left-center" })
                    elseif Config.showTextUI == "mt" then
                        exports["mt_lib"]:DrawText(Config.TextUILabelE)
                    end
                    if IsControlJustPressed(0, 38) then
                        TriggerEvent('qb-cityhall:mainMenu')
                    end
                else
                    if Config.showTextUI == "qb" then
                        exports["qb-core"]:HideText()
                    elseif Config.showTextUI == "ox" then
                        lib.hideTextUI()
                    elseif Config.showTextUI == "mt" then
                        exports["mt_lib"]:HideText()
                    end
                    wait = 1000
                end
            end
            Wait(wait)
        end
    end
end)

RegisterNetEvent('qb-cityhall:mainMenu', function()
    if Config.menu == "qb" then
        local menuOptions = {
            {
                header = "City Hall", 
                isMenuHeader = true
            },
            {
                header = "Take Job",
                txt = "Browse available jobs and select one to apply for.",
                icon = "fa-solid fa-address-book",
                params = { event = "qb-cityhall:jobMenu" }
            },
            {
                header = "Identity Documents",
                txt = "View and obtain necessary identity documents.",
                icon = "fa-solid fa-id-card",
                params = { event = "qb-cityhall:cardMenu" }
            },
            {
                header = "Exit",
                txt = "Close the menu.",
                icon = "fa-solid fa-sign-out-alt",
                params = { event = "" }
            }
        }
    
        TriggerEvent('qb-menu:client:openMenu', menuOptions)
    elseif Config.menu == "ox" then
        lib.registerContext({
            id = 'cityhall_main_menu',
            title = 'City Hall',
            menu = 'main',
            options = {
                {
                    title = 'Take Job',
                    description = 'Browse available jobs and select one to apply for.',
                    icon = 'fa-solid fa-address-book',
                    event = 'qb-cityhall:jobMenu',
                },
                {
                    title = 'Identity Documents',
                    description = 'View and obtain necessary identity documents.',
                    icon = 'fa-solid fa-id-card',
                    event = 'qb-cityhall:cardMenu',
                },
            },
        })
        lib.showContext('cityhall_main_menu')
    end
end)


RegisterNetEvent('qb-cityhall:jobMenu', function(data)
    if Config.menu == "qb" then
        local menuOptions = {
            {
                header = "Select Job:",
                isMenuHeader = true
            }
        }
    
        for _, v in pairs(Config.Jobs) do
            if not v.underMaintenance then
                table.insert(menuOptions, {
                    header = v.label,
                    txt = "Apply for this job.",
                    icon = v.icon,
                    params = {
                        event = "qb-cityhall:setjob", 
                        args = { job = v.job, grade = v.grade }
                    }
                })
            else
                table.insert(menuOptions, {
                    header = v.label .. " (Under Maintenance)",
                    txt = "This job is currently unavailable.",
                    icon = v.icon,
                    isDisabled = true,
                    params = { event = "", args = {} }
                })
            end
        end
    
        TriggerEvent('qb-menu:client:openMenu', menuOptions)
    elseif Config.menu == "ox" then
        local jobMenu = {
            id = 'job_menu',
            title = 'Select Job:',
            options = {}
        }
    
        for _, v in pairs(Config.Jobs) do
            if not v.underMaintenance then
                table.insert(jobMenu.options, {
                    title = v.label,
                    description = 'Apply for this job.',
                    icon = v.icon,
                    serverEvent = 'qb-cityhall:setjob',
                    args = { job = v.job, grade = v.grade },
                })
            else
                table.insert(jobMenu.options, {
                    title = v.label .. " (Under Maintenance)",
                    description = 'This job is currently unavailable.',
                    icon = v.icon,
                    isDisabled = true,
                    serverEvent = '',
                    args = {},
                })
            end
        end
    
        lib.registerContext(jobMenu)
        lib.showContext('job_menu')
    end
end)


RegisterNetEvent('qb-cityhall:cardMenu', function(data)
    if Config.menu == "qb" then
        local menuOptions = {
            {
                header = "Take Identity Documents:",
                isMenuHeader = true
            }
        }
    
        for _, v in pairs(Config.Documents) do
            table.insert(menuOptions, {
                header = v.label,
                txt = v.desc,
                icon = v.icon,
                params = {
                    event = "qb-cityhall:giveitem", 
                    args = { label = v.label, item = v.item, price = v.price }
                }
            })
        end
    
        TriggerEvent('qb-menu:client:openMenu', menuOptions)
    elseif Config.menu == "ox" then
        local cardMenu = {
            id = 'card_menu',
            title = 'Take Identity Documents:',
            options = {}
        }
    
        for _, v in pairs(Config.Documents) do
            table.insert(cardMenu.options, {
                title = v.label,
                description = v.desc,
                icon = v.icon,
                serverEvent = 'qb-cityhall:giveitem',
                args = { label = v.label, item = v.item, price = v.price },
            })
        end
    
        lib.registerContext(cardMenu)
        lib.showContext('card_menu')
    end
end)

RegisterNetEvent('qb-cityhall:giveitem', function(data)
    TriggerServerEvent('qb-cityhall:giveitem', data)
end)

RegisterNetEvent('qb-cityhall:setjob', function(data)
    TriggerServerEvent('qb-cityhall:setjob', data)
end)
