local NCLElem = require "core/content/NCLElem"

local DescriptorParam = NCLElem:extends()

DescriptorParam.name = "descriptorParam"

function DescriptorParam:create(attributes)  
   local descriptorParam = DescriptorParam:new() 
   
   descriptorParam.attributes = {
     ["name"] = "",
     ["value"] = ""
   }
     
   if(attributes ~= nil)then
      descriptorParam:setAttributes(attributes)
   end
   
   return descriptorParam
end

function DescriptorParam:setName(name)
   self:addAttribute("name", name)
end

function DescriptorParam:getName()
   return self:getAttribute("name")
end

function DescriptorParam:setValue(value)
   self:addAttribute("value", value)
end

function DescriptorParam:getValue()
   return self:getAttribute("value")
end

return DescriptorParam