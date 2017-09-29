local NCLElem = require "core/NCLElem"
local CausalConnector = require "core/synchronism/CausalConnector"

local ConnectorBase = NCLElem:extends()

ConnectorBase.name = "connectorBase"

ConnectorBase.attributes = {
  id = nil
}

ConnectorBase.childsMap = {
 ["causalConnector"] = {CausalConnector, "many", 1}
}

ConnectorBase.causalConnectors = nil

function ConnectorBase:create(attributes, full)  
   local attributes = attributes or {}  
   local connectorBase = ConnectorBase:new() 
     
   connectorBase:setAttributes(attributes)
   connectorBase:setChilds()
   connectorBase.causalConnectors = {}
    
   if(full ~= nil)then      
       connectorBase:addCausalConnector(CausalConnector:create(nil, full))       
   end
   
   return connectorBase
end

function ConnectorBase:setId(id)
   self.attributes.id = id
end

function ConnectorBase:getId()
   return self.attributes.id
end

function ConnectorBase:addCausalConnector(causalConnector)
    table.insert(self.causalConnectors, causalConnector)    
    local p = self:getLastPosChild("causalConnector")
    if(p ~= nil)then
       self:addChild(causalConnector, p+1)
    else
       self:addChild(causalConnector, 1)
    end
end

function ConnectorBase:getCausalConnector(i)
    return self.causalConnectors[i]
end

function ConnectorBase:getCausalConnectorById(id)
   for i, causalConnector in ipairs(self.causalConnectors) do
       if(causalConnector:getId() == id)then
          return causalConnector
       end
   end
   
   return nil
end

function ConnectorBase:setRegionBases(...)
    if(#arg>0)then
      for i, v in ipairs(arg) do
          self:addRegionBase(v)
      end
    end
end

return ConnectorBase