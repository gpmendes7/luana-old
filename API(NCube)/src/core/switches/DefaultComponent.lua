local NCLElem = require "core/content/NCLElem"

local DefaultComponent = NCLElem:extends()

DefaultComponent.name = "defaultComponent"

function DefaultComponent:create(attributes)
   local defaultComponent = DefaultComponent:new()
   
   defaultComponent.attributes = { 
    ["component"] = ""
   }
   
   if(attributes ~= nil)then
      defaultComponent:setAttributes(attributes)
   end
   
   return defaultComponent
end

function DefaultComponent:setComponent(component)
    self:addAttribute("component", component)
end

function DefaultComponent:getComponent()
   return self:getAttribute("component")
end

return DefaultComponent