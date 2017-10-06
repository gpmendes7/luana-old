local NCLElem = require "core/structure_content/NCLElem"

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
   self.attributes.id = id
end

function ElementD:getId()
   return self.attributes.id
end

function ElementD:setDesc(desc)
   self.attributes.desc = desc
end

function ElementD:getDesc()
   return self.attributes.desc
end

return ElementD