local NCLElem = require "core/structure_content/NCLElem"

local Descriptor = NCLElem:extends()

Descriptor.name = "descriptor"

Descriptor.hasAss = true

Descriptor.assMap = {
  {"region", "regionAss"}
}

Descriptor.regionAss = nil

function Descriptor:create(attributes)  
   local descriptor = Descriptor:new() 
   
   descriptor.attributes = {
      ["id"] = "", 
      ["player"] = "",
      ["explicitDur"] = "", 
      ["region"] = "",
      ["freeze"] = "",
      ["moveLeft"] = "", 
      ["moveRight"] = "", 
      ["moveUp"] = "", 
      ["moveDown"] = "", 
      ["focusIndex"] = "", 
      ["focusBorderColor"] = "", 
      ["focusBorderWidth"] = "", 
      ["focusBorderTransparency"] = "", 
      ["focusSrc"] = "", 
      ["focusSelSrc"] = "", 
      ["selBorderColor"] = "", 
      ["transIn"] = "", 
      ["transOut"] = ""
   }     
   
   if(attributes ~= nil)then
      descriptor:setAttributes(attributes)
   end
     
   descriptor.children = {}
   
   return descriptor
end

function Descriptor:setId(id)
   self:addAttribute("id", id)
end

function Descriptor:getId()
   return self:getAttribute("id")
end

function Descriptor:setPlayer(player)
   self:addAttribute("player", player)
end

function Descriptor:getPlayer()
   return self:getAttribute("player")
end

function Descriptor:setExplicitDur(explicitDur)
   self:addAttribute("explicitDur", explicitDur)
end

function Descriptor:getExplicitDur()
   return self:getAttribute("explicitDur")
end

function Descriptor:setRegion(region)
   self:addAttribute("region", region)
end

function Descriptor:getRegion()
   return self:getAttribute("region")
end

function Descriptor:setRegionAss(regionAss)
   self.regionAss = regionAss
end

function Descriptor:getRegionAss()
   return self.regionAss
end

function Descriptor:setFreeze(freeze)
   self:addAttribute("freeze", freeze)
end

function Descriptor:getFreeze()
   return self:getAttribute("freeze")
end

function Descriptor:setMoveLeft(moveLeft)
   self:addAttribute("moveLeft", moveLeft)
end

function Descriptor:getMoveLeft()
   return self:getAttribute("moveLeft")
end

function Descriptor:setMoveRight(moveRight)
   self:addAttribute("moveRight", moveRight)
end

function Descriptor:getMoveRight()
   return self:getAttribute("moveRight")
end

function Descriptor:setMoveUp(moveUp)
   self:addAttribute("moveUp", moveUp)
end

function Descriptor:getMoveUp()
   return self:getAttribute("moveUp")
end

function Descriptor:setMoveDown(moveDown)
   self:addAttribute("moveDown", moveDown)
end

function Descriptor:getMoveDown()
   return self:getAttribute("moveDown")
end

function Descriptor:setFocusIndex(focusIndex)
   self:addAttribute("focusIndex", focusIndex)
end

function Descriptor:getFocusIndex()
   return self:getAttribute("focusIndex")
end

function Descriptor:setFocusBorderColor(focusBorderColor)
   self:addAttribute("focusBorderColor", focusBorderColor)
end

function Descriptor:getFocusBorderColor()
   return self:getAttribute("focusBorderColor")
end

function Descriptor:setFocusBorderWidth(focusBorderWidth)
   self:addAttribute("focusBorderWidth", focusBorderWidth)
end

function Descriptor:getFocusBorderWidth()
   return self:getAttribute("focusBorderWidth")
end

function Descriptor:setFocusBorderTransparency(focusBorderTransparency)
   self:addAttribute("focusBorderTransparency", focusBorderTransparency)
end

function Descriptor:getFocusBorderTransparency()
   return self:getAttribute("focusBorderTransparency")
end

function Descriptor:setFocusSrc(focusSrc)
   self:addAttribute("focusSrc", focusSrc)
end

function Descriptor:getFocusSrc()
   return self:getAttribute("focusSrc")
end

function Descriptor:setFocusSelSrc(focusSelSrc)
   self:addAttribute("focusSelSrc", focusSelSrc)
end

function Descriptor:getFocusSelSrc()
   return self:getAttribute("focusSelSrc")
end

function Descriptor:setSelBorderColor(selBorderColor)
   self:addAttribute("selBorderColor", selBorderColor)
end

function Descriptor:getSelBorderColor()
   return self:getAttribute("selBorderColor")
end

function Descriptor:setTransIn(transIn)
   self:addAttribute("transIn", transIn)
end

function Descriptor:getTransIn()
   return self:getAttribute("transIn")
end

function Descriptor:setTransOut(transOut)
   self:addAttribute("transOut", transOut)
end

function Descriptor:getTransOut()
   return self:getAttribute("transOut")
end

return Descriptor