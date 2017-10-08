local NCLElem = require "core/NCLElem"

local ElementD = NCLElem:extends()

ElementD.name = "elementD"

ElementD.attributes = nil

function ElementD:create(attributes)  
   local elementD = ElementD:new()   
   
   elementD.attributes = {
     ["id"] = "",  
     ["desc"] = ""
   }
   
   if(attributes ~= nil)then
      elementD:setAttributes(attributes)
   end
         
   return elementD
end

function ElementD:setId(id)
   self:addAttribute("id", id)
end

function ElementD:getId()
   return self:getAttribute("id")
end

function ElementD:setDesc(desc)
   self:addAttribute("desc", desc)
end

function ElementD:getDesc()
   return self:getAttribute("desc")
end

return ElementD