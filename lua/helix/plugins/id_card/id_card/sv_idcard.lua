local character = ix.meta.character

function character:GiveIDCard()
        local inv = self:GetInventory()
        inv:Add("idcard", 1, {
            name = self:GetName(),
            id = self:GetID() 
        })
end

function GetCharacterByID(id)
    for client, character in ix.util.GetCharacters() do
       if character:GetID() == id then return character end
    end
end