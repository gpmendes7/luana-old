local NCLElem = require "core/structure_content/NCLElem"

local ElementE = NCLElem:extends()

ElementE.name = "elementE"

ElementE.attributes = nil

function ElementE:create(attributes)
   local elementE = ElementE:new()   
   
   elementE.attributes = {
     ["id"] = "",  
     ["desc"] = ""
   }
   
   if(attributes ~= nil)then
      elementE:setAttributes(attributes)
   end
         
   return elementE
end

function ElementE:setId(id)
   self.attributes.id = id
end

function ElementE:getId()
   return self.attributes.id
end

function ElementE:setDesc(desc)
   self.attributes.desc = desc
end

function ElementE:getDesc()
   return self.attributes.desc
end

return ElementE