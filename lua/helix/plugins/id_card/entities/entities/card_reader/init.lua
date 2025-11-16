AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/hlxrp/cardreader.mdl")
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)	
	if SERVER then self:SetUseType(SIMPLE_USE) end
end

function ENT:SpawnFunction(ply, tr, classname)
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create(classname)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:StartTouch( ent )
    if ent:GetClass() == "ix_item" then
        local item = ent:GetItemTable()
        if item.uniqueID == "idcard" then
        local id = ent:GetData("id", "00000")
        self:UseIDCard(id)
        end
    end
end


function ENT:Use(ply)
    if not IsValid(ply) then return end
    local char = ply:GetCharacter()
    if not char then return end
    local inv = char:GetInventory()
    if not inv then return end

    for _, item in pairs(inv:GetItems() or {}) do
        if item.uniqueID == "idcard" and item.data and item.data.id then
            local id = item.data.id
            local target = GetCharacterByID(id)
            if not target then return  end

            local fac = ix.faction.Get(target:GetFaction())
            if not fac then return  end

            if fac.name == self:GetFaction() then
                if self._lastUse and self._lastUse > CurTime() then return end
                self._lastUse = CurTime() + 0.5
                return self:UseIDCard(id)
            else
                return 
            end
        end
    end

end


function ENT:UseIDCard(id)
    if not id then return end

    self.nextUse = self.nextUse or 0
    if CurTime() < self.nextUse then return end
    self.nextUse = CurTime() + 2

    local char = GetCharacterByID(id)
    if not char then return self:EmitSound("buttons/button2.wav", 75, 100, 1, CHAN_AUTO) end

    local factionID = char:GetFaction()
    if not factionID then return self:EmitSound("buttons/button2.wav", 75, 100, 1, CHAN_AUTO) end

    local faction = ix.faction.Get(factionID)
    if not faction or not faction.name then return self:EmitSound("buttons/button2.wav", 75, 100, 1, CHAN_AUTO) end

    if faction.name == self:GetFaction() then
        self:EmitSound("buttons/button9.wav", 75, 100, 1, CHAN_AUTO)

        local pos = self:GetPos()
        local entities = ents.FindInSphere(pos, 100)
        local door

        for _, ent in ipairs(entities or {}) do
            if IsValid(ent) and ent:IsDoor() then
                ent:Fire("Unlock", "", 0)
                ent:Fire("Open", "", 0)
                door = ent
                break
            end
        end

        if door then
            timer.Create("close_door_" .. self:EntIndex(), 4, 1, function()
                if IsValid(door) then
                    door:Fire("Close", "", 0)
                    door:Fire("Lock", "", 0)
                end
            end)
        end
    else
        self:EmitSound("buttons/button2.wav", 75, 100, 1, CHAN_AUTO)
    end
end
