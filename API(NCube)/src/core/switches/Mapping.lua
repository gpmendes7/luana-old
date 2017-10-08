local NCLElem = require "core/NCLElem"

local Mapping = NCLElem:extends()

Mapping.name = "mapping"

function Mapping:create(attributes)
   local mapping = Mapping:new()
   
   mapping.attributes = { 
    ["component"] = "",
    ["interface"] = ""
   }
   
   if(attributes ~= nil)then
      mapping:setAttributes(attributes)
   end
   
   return mapping
end

function Mapping:setComponent(component)
    self:addAttribute("component", component)
end

function Mapping:getComponent()
   return self:getAttribute("component")
end

function Mapping:setInterface(interface)
    self:addAttribute("interface", interface)
end

function Mapping:getInterface()
   return self:getAttribute("interface")
end

return Mapping