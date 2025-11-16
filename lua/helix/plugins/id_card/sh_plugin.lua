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
PLUGIN.description = "Adds an ID card system and card reader for simple, immersive roleplay access control."

ix.config.Add("giveIdCard", true, "Automatically give a new character an ID card upon creation.", nil, {
    category = "ID Card"
})

if SERVER then

    local character = ix.meta.character
    local IdCard = {}

    function character:GiveIDCard()
        local inv = self:GetInventory()
        inv:Add("idcard", 1, {
            name = self:GetName(),
            id = self:GetID() 
        })
    end


    function PLUGIN:OnCharacterCreated(client, character)
        if ix.config.Get("giveIdCard") then
        character:GiveIDCard()
        end
    end
   


end