fx_version 'cerulean'
game 'gta5'

author 'Se9p'
description 'This script adds NPC interactions and City Hall functionality with job selection'
version '1.0.0'

shared_script {
    'config.lua',
    '@ox_lib/init.lua'
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}
lua54 'yes'
