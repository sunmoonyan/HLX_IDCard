
ITEM.name = "ID Card"
ITEM.model = Model("models/hlxrp/idcard.mdl")
ITEM.description = "A citizen identification card with ID #%s, assigned to %s."
ITEM.noBusiness = true

function ITEM:GetDescription()
	return string.format(self.description, self:GetData("id", "00000"), self:GetData("name", "nobody"))
end

ITEM.functions.Scan = {
	name = "scan",
	tip = "equipTip",
	icon = "icon16/vcard.png",
	OnRun = function(item)
		local owner = item["player"]
        local reach = 50
        local trace = util.TraceLine({
          start = owner:GetShootPos(),
          endpos = owner:GetShootPos() + owner:GetAimVector() * reach,
          filter = owner
        })

        local hitEnt = trace.Entity
         if IsValid(hitEnt) then
            if hitEnt:GetClass() == "police_equippement_locker" then 
            hitEnt:UseIDCard(item:GetData("id", "0000"))
            end
        end

		return false
	end,
	OnCanRun = function(item)
	end
}