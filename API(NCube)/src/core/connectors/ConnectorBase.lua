local NCLElem = require "core/NCLElem"
local CausalConnector = require "core/connectors/CausalConnector"

local ConnectorBase = NCLElem:extends()

ConnectorBase.name = "connectorBase"

ConnectorBase.childrenMap = {
 ["causalConnector"] = {CausalConnector, "many"}
}

function ConnectorBase:create(attributes, full)  
   local connectorBase = ConnectorBase:new() 
   
   connectorBase.attributes = {
      ["id"] = ""
   }  
   
   if(attributes ~= nil)then
      connectorBase:setAttributes(attributes)
   end
     
   connectorBase.children = {}
   connectorBase.causalConnectors = {}
    
   if(full ~= nil)then      
       connectorBase:addCausalConnector(CausalConnector:create(nil, full))       
   end
   
   return connectorBase
end

function ConnectorBase:setId(id)
   self:addAttribute("id", id)
end

function ConnectorBase:getId()
   return self:getAttribute("id")
end

function ConnectorBase:addCausalConnector(causalConnector)
   self:addChild(causalConnector)
   table.insert(self.causalConnectors, causalConnector)
end

function ConnectorBase:getCausalConnectorPos(i)
    return self.causalConnectors[i]
end

function ConnectorBase:getCausalConnectorById(id)
   for _, causalConnector in ipairs(self.causalConnectors) do
       if(causalConnector:getId() == id)then
          return causalConnector
       end
   end
   
   return nil
end

function ConnectorBase:setCausalConnectors(...)
    if(#arg>0)then
      for _, causalConnector in ipairs(arg) do
          self:addCausalConnector(causalConnector)
      end
    end
end

function ConnectorBase:removeCausalConnector(causalConnector)
   self:removeChild(causalConnector)
   
   for i, cc in ipairs(self.causalConnectors) do
       if(causalConnector == cc)then
           table.remove(self.causalConnectors, i)  
       end
   end 
end

function ConnectorBase:removeCausalConnectorPos(i)
   self:removeChildPos(i)
   table.remove(self.causalConnectors, i)
end

return ConnectorBase