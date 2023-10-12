fx_version 'cerulean'
game 'gta5'
description 'Slaughter house job for QBCore'
version '1.0.0'
client_scripts {
    'client/*.lua'
}
server_scripts {
    'server/*.lua',
}
shared_script {
    'shared/config.lua',
    'locale/en.lua'
}
escrow_ignore {
    "images/**",
    "shared/**.lua",
    "locale/**.lua",
    "README.md",
}
lua54 'yes'