local NCLElem = require "core/structure_content/NCLElem"

local BindParam = NCLElem:extends()

BindParam.name = "bindParam"

function BindParam:create(attributes)  
   local bindParam = BindParam:new() 
   
   bindParam.attributes = {
     ["name"] = "",
     ["value"] = ""
   }
     
   if(attributes ~= nil)then
      bindParam:setAttributes(attributes)
   end
   
   return bindParam
end

function BindParam:setName(name)
   self.attributes.name = name
end

function BindParam:getName()
   return self.attributes.name
end

function BindParam:setValue(value)
   self.attributes.value = value
end

function BindParam:getValue()
   return self.attributes.value
end

return BindParam