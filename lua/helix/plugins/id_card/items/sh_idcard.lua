
ITEM.name = "ID Card"
ITEM.model = Model("models/hlxrp/idcard.mdl")
ITEM.description = "A citizen identification card with ID #%s, assigned to %s."
ITEM.noBusiness = true

function ITEM:GetDescription()
	return string.format(self.description, self:GetData("id", "0"), self:GetData("name", "???"))
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
            if hitEnt:GetClass() == "card_reader" then 
            	local id = item:GetData("id", "0")
              hitEnt:UseIDCard(id)
            end
        end

		return false

	end,
	OnCanRun = function(item)
	end
}