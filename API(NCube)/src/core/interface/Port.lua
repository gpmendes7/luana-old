local NCLElem = require "core/structure_content/NCLElem"

local Port = NCLElem:extends()

Port.name = "port"

Port.attributes = {
  id = nil,  
  component = nil,
  interface = nil
}

function Port:create(attributes)  
   local attributes = attributes or {}  
   local port = Port:new()   
   
   port:setAttributes(attributes)
   port:setChilds()
   
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