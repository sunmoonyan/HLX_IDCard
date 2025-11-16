ENT.Base = "base_ai"
ENT.Type = "anim"
ENT.PrintName		= "Card Reader"
ENT.Category		= "Helix" 
ENT.Instructions	= ""
ENT.Spawnable		= true
ENT.AdminOnly = true
ENT.Editable = true

function ENT:SetupDataTables()
    self:NetworkVar( "String",0, "Faction",{ KeyName = "faction",Edit = { type = "String",order = 1,category = "General"} } )	
end
