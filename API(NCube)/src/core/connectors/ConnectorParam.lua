local NCLElem = require "core/structure_content/NCLElem"

local ConnectorParam = NCLElem:extends()

ConnectorParam .name = "connectorParam"

ConnectorParam .attributes = {
  name = nil,
  type = nil
}

function ConnectorParam:create(attributes)  
   local attributes = attributes or {}  
   local connectorParam = ConnectorParam:new() 
     
   connectorParam:setAttributes(attributes)
   connectorParam:setChilds()
   
   return connectorParam
end

function ConnectorParam:setName(name)
   self.attributes.name = name
end

function ConnectorParam:getName()
   return self.attributes.name
end

function ConnectorParam:setType(type)
   self.attributes.type = type
end

function ConnectorParam:getType()
   return self.attributes.type
end

return ConnectorParam