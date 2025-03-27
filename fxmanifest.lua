fx_version 'cerulean'
game 'gta5'

author 'Se9p'
description 'City Hall system with multiple UI framework support'
version '1.0.1'

shared_script {
    'config.lua',
    '@ox_lib/init.lua', -- [Optional]
}

client_scripts {
    '@mt_lib/client/mt_lib.lua', -- [Optional]
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

dependencies {
    'qb-core',
    'ox_lib', -- [Optional]
    'mt_lib', -- [Optional]
}

lua54 'yes'
