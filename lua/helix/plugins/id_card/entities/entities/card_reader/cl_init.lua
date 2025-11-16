include("shared.lua") 

function ENT:Draw() 
    self:DrawModel() 
end 

ENT.PopulateEntityInfo = true

function ENT:OnPopulateEntityInfo(container)
    local name = container:AddRow("name")
    name:SetImportant()
    name:SetText("Card Reader")
    name:SizeToContents()

    if self:GetFaction() != "" then
            local description = container:AddRow("description")
            description:SetText("Restricted access: "..self:GetFaction().." only")
            description:SizeToContents()
    end
end