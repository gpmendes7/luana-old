local NCLElem = require "core/structure_content/NCLElem"

local LinkParam = NCLElem:extends()

LinkParam.name = "linkParam"

function LinkParam:create(attributes)  
   local attributes = attributes or {}  
   local linkParam = LinkParam:new() 
   
   linkParam.attributes = {
      ["name"] = "",
      ["value"] = ""
   }
   
   if(attributes ~= nil)then
      linkParam:setAttributes(attributes)
   end
      
   return linkParam
end

function LinkParam:setName(name)
   self.attributes.name = name
end

function LinkParam:getName()
   return self.attributes.name
end

function LinkParam:setValue(value)
   self.attributes.value = value
end

function LinkParam:getValue()
   return self.attributes.value
end

return LinkParam