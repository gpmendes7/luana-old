local NCLElem = require "core/NCLElem"

local Transition = NCLElem:extends()

Transition.name = "transition"

function Transition:create(attributes)
   local transition = Transition:new()
   
   transition.attributes = { 
     ["id"] = "", 
     ["type"] = "", 
     ["subtype"] = "", 
     ["dur"] = "", 
     ["startProgress"] = "", 
     ["endProgress"] = "", 
     ["direction"] = "", 
     ["fadeColor"] = "", 
     ["horzRepeat"] = "", 
     ["vertRepeat"] = "", 
     ["borderWidth"] = "", 
     ["borderColor"] = ""
   }
   
   if(attributes ~= nil)then
      transition:setAttributes(attributes)
   end
   
   return transition
end

function Transition:setId(id)
   self:addAttribute("id", id)
end

function Transition:getId()
   return self:getAttribute("id")
end

function Transition:setType(type)
    self:addAttribute("type", type)
end

function Transition:getType()
   return self:getAttribute("type")
end

function Transition:setSubType(subtype)
    self:addAttribute("subtype", subtype)
end

function Transition:getSubType()
   return self:getAttribute("subtype")
end

function Transition:setDur(dur)
    self:addAttribute("dur", dur)
end

function Transition:getDur()
   return self:getAttribute("dur")
end

function Transition:setStartProgress(startProgress)
    self:addAttribute("startProgress", startProgress)
end

function Transition:getStartProgress()
   return self:getAttribute("startProgress")
end

function Transition:setEndProgress(endProgress)
    self:addAttribute("endProgress", endProgress)
end

function Transition:getEndProgress()
   return self:getAttribute("endProgress")
end

function Transition:setDirection(direction)
    self:addAttribute("direction", direction)
end

function Transition:getDirection()
   return self:getAttribute("direction")
end

function Transition:setFadeColor(fadeColor)
    self:addAttribute("fadeColor", fadeColor)
end

function Transition:getFadeColor()
   return self:getAttribute("fadeColor")
end

function Transition:setHorzRepeat(horzRepeat)
    self:addAttribute("horzRepeat", horzRepeat)
end

function Transition:getHorzRepeat()
   return self:getAttribute("horzRepeat")
end

function Transition:setVertRepeat(vertRepeat)
    self:addAttribute("vertRepeat", vertRepeat)
end

function Transition:getVertRepeat()
   return self:getAttribute("vertRepeat")
end

function Transition:setBorderWidth(borderWidth)
    self:addAttribute("borderWidth", borderWidth)
end

function Transition:getBorderWidth()
   return self:getAttribute("borderWidth")
end

function Transition:setBorderColor(borderColor)
    self:addAttribute("borderColor", borderColor)
end

function Transition:getBorderColor()
   return self:getAttribute("borderColor")
end

return Transition