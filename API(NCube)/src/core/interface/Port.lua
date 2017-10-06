local NCLElem = require "core/structure_content/NCLElem"

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
   self.attributes.id = id
end

function Port:getId()
   return self.attributes.id
end

function Port:setComponent(component)
   self.attributes.component = component
end

function Port:getComponent()
   return self.attributes.component
end

function Port:setInterface(interface)
   self.attributes.interface = interface
end

function Port:getInterface()
   return self.attributes.interface
end

return Port