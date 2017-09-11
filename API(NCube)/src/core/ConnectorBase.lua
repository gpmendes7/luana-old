local NCLElem = require "core/NCLElem"

local ConnectorBase = Class:createClass(NCLElem)

ConnectorBase.name = "connectorBase"

ConnectorBase.attributes = {
  id = nil
}

ConnectorBase.childsMap = {
 
}

function ConnectorBase:create(attributes)  
   local attributes = attributes or {}  
   local connectorBase = ConnectorBase:new() 
     
   connectorBase:setAttributes(attributes)
   connectorBase:setChilds()
   
   return connectorBase
end

function ConnectorBase:setId(id)
   self.attributes.id = id
end

function ConnectorBase:getId()
   return self.attributes.id
end

return ConnectorBase