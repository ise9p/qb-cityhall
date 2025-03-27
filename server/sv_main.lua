local QBCore = exports['qb-core']:GetCoreObject()

local function GetIdentifiers(playerId)
    local identifiers = GetPlayerIdentifiers(playerId)
    local ids = {
        discord = "N/A",
        steam = "N/A",
        license = "N/A",
        fivem = "N/A"
    }

    for _, id in ipairs(identifiers) do
        if id:sub(1, 8) == "discord:" then
            ids.discord = id:sub(9)
        elseif id:sub(1, 6) == "steam:" then
            ids.steam = id
        elseif id:sub(1, 8) == "license:" then
            ids.license = id
        elseif id:sub(1, 6) == "fivem:" then
            ids.fivem = id
        end
    end

    return ids
end


RegisterServerEvent('qb-cityhall:setjob', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        local currentJob = Player.PlayerData.job.name
        local jobConfig = Config.Jobs[data.job]
        local identifiers = GetIdentifiers(src)


        if jobConfig and jobConfig.underMaintenance then
            if Config.notify == "qb" then
                TriggerClientEvent('QBCore:Notify', src, 'This job is currently under maintenance. Please try again later.', 'error')
            elseif Config.notify == "ox" then
                TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'This job is currently under maintenance. Please try again later.'})
            end
        elseif currentJob == data.job then
            if Config.notify == "qb" then
                TriggerClientEvent('QBCore:Notify', src, 'You already have ' .. data.job .. '!', 'error')
            elseif Config.notify == "ox" then
                TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'You already have ' .. data.job .. '!'})
            end
        else
            Player.Functions.SetJob(data.job, data.grade)
            if Config.notify == "qb" then
                TriggerClientEvent('QBCore:Notify', src, 'Your job has been set to ' .. data.job, 'success')
            elseif Config.notify == "ox" then
                TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'Your job has been set to ' .. data.job})
            end

            local logData = {
                username = "CityHall Log",
                avatar_url = "https://example.com/avatar.png", 
                embeds = {
                    {
                        title = "Job Change",
                        description = string.format(
                            "Player: **%s %s**\nCitizen ID: **%s**\nDiscord: **<@%s>**\nSteam: **%s**\nLicense: **%s**\nFiveM: **%s**\nPrevious Job: **%s**\nNew Job: **%s**\nGrade: **%s**", 
                            Player.PlayerData.charinfo.firstname,
                            Player.PlayerData.charinfo.lastname,
                            Player.PlayerData.citizenid,
                            identifiers.discord,
                            identifiers.steam,
                            identifiers.license,
                            identifiers.fivem,
                            currentJob,
                            data.job,
                            data.grade
                        ),
                        color = 3447003, 
                        footer = {
                            text = os.date("%Y-%m-%d %H:%M:%S")
                        }
                    }
                }
            }

            PerformHttpRequest(Config.WebhookURL, function(err, text, headers)
                if err then
                    print("Error logging job change: " .. err)
                end
            end, 'POST', json.encode(logData), { ['Content-Type'] = 'application/json' })
        end
    end  
end)


RegisterServerEvent('qb-cityhall:giveitem', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local identifiers = GetIdentifiers(src)

    if Player.Functions.GetItemByName(data.item) then
        if Config.notify == "qb" then
            TriggerClientEvent('QBCore:Notify', src, 'You already have ' .. data.label .. '!', 'error')
        elseif Config.notify == "ox" then
            TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'You already have ' .. data.label .. '!'})
        end
    else
        local info = {}
        if data.item == "id_card" then
            info.citizenid = Player.PlayerData.citizenid
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.gender = Player.PlayerData.charinfo.gender
            info.nationality = Player.PlayerData.charinfo.nationality
        elseif data.item == "driver_license" then
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.type = "Class C Driver License"
        elseif data.item == "weaponlicense" then
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.citizenid = Player.PlayerData.citizenid
            info.license_type = "Weapon License"
        end        

        Player.Functions.AddItem(data.item, 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[data.item], 'add')

        if data.price then
            if Player.Functions.RemoveMoney('cash', data.price) then
                if Config.notify == "qb" then
                    TriggerClientEvent('QBCore:Notify', src, 'You have received ' .. data.label .. ' and paid ' .. data.price .. ' cash', 'success')
                elseif Config.notify == "ox" then
                    TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'You have received ' .. data.label .. ' and paid ' .. data.price .. ' cash'})
                end

                local itemLogData = {
                    username = "CityHall Log",
                    avatar_url = "https://example.com/avatar.png", 
                    embeds = {
                        {
                            title = "Item Transaction",
                            description = string.format(
                                "Player: **%s %s**\nCitizen ID: **%s**\nDiscord: **<@%s>**\nSteam: **%s**\nLicense: **%s**\nFiveM: **%s**\nItem: **%s**\nAmount: **1**\nPrice: **$%s**\nRemaining Cash: **$%s**", 
                                Player.PlayerData.charinfo.firstname,
                                Player.PlayerData.charinfo.lastname,
                                Player.PlayerData.citizenid,
                                identifiers.discord,
                                identifiers.steam,
                                identifiers.license,
                                identifiers.fivem,
                                data.label,
                                data.price,
                                Player.PlayerData.money.cash
                            ),
                            color = 65280, 
                            footer = {
                                text = os.date("%Y-%m-%d %H:%M:%S")
                            }
                        }
                    }
                }

                PerformHttpRequest(Config.WebhookURL, function(err, text, headers)
                    if err then
                        print("Error logging item transaction: " .. err)
                    end
                end, 'POST', json.encode(itemLogData), { ['Content-Type'] = 'application/json' })
            else
                if Config.notify == "qb" then
                    TriggerClientEvent('QBCore:Notify', src, 'You do not have enough cash!', 'error')
                elseif Config.notify == "ox" then
                    TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'You do not have enough cash!'})
                end
            end
        end
    end
end)
