--[[
 ________  ___  ___  ________   ________  ___  ___  ___     
|\   ____\|\  \|\  \|\   ___  \|\   ____\|\  \|\  \|\  \    
\ \  \___|\ \  \\\  \ \  \\ \  \ \  \___|\ \  \\\  \ \  \   
 \ \_____  \ \  \\\  \ \  \\ \  \ \_____  \ \   __  \ \  \  
  \|____|\  \ \  \\\  \ \  \\ \  \|____|\  \ \  \ \  \ \  \ 
    ____\_\  \ \_______\ \__\\ \__\____\_\  \ \__\ \__\ \__\
   |\_________\|_______|\|__| \|__|\_________\|__|\|__|\|__|
   \|_________|                   \|_________|              
]]--

local PLUGIN = PLUGIN

PLUGIN.name = "ID Card"
PLUGIN.author = "Sunshi"
PLUGIN.description = "Add id card to the player, usefull for roleplay."
PLUGIN.requires = {}

ix.config.Add("giveIdCard", true, "Automatically give a new character an ID card upon creation.", nil, {
    category = "ID Card"
})


if SERVER then
    function PLUGIN:LoadData()

    end

    function PLUGIN:OnCharacterCreated(client, character)
        character:GiveIDCard()
    end

    include("id_card/sv_idcard.lua")
end