local NCLElem = require "core/NCLElem"

local DefaultDescriptor = NCLElem:extends()

DefaultDescriptor.name = "defaultDescriptor"

function DefaultDescriptor:create(attributes)
   local defaultDescriptor = DefaultDescriptor:new()
   
   defaultDescriptor.attributes = { 
    ["descriptor"] = ""
   }
   
   if(attributes ~= nil)then
      defaultDescriptor:setAttributes(attributes)
   end
   
   return defaultDescriptor
end

function DefaultDescriptor:setDescriptor(descriptor)
    self:addAttribute("descriptor", descriptor)
end

function DefaultDescriptor:getDescriptor()
   return self:getAttribute("descriptor")
end

return DefaultDescriptor