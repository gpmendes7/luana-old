local NCLElem = require "core/content/NCLElem"

local Port = NCLElem:extends()

Port.name = "port"

function Port:create(attributes)  
   local port = Port:new()   
   
   port.attributes = {
      ["id"] = "",  
      ["component"] = "",
      ["interface"] = ""
   }
   
   if(attributes ~= nil)then
      port:setAttributes(attributes)
   end
   
   return port
end

function Port:setId(id)
   self:addAttribute("id", id)
end

function Port:getId()
   return self:getAttribute("id")
end

function Port:setComponent(component)
   self:addAttribute("component", component)
end

function Port:getComponent()
   return self:getAttribute("component")
end

function Port:setInterface(interface)
   self:addAttribute("interface", interface)
end

function Port:getInterface()
   return self:getAttribute("interface")
end

return Port