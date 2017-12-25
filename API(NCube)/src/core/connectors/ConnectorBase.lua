local NCLElem = require "core/NCLElem"
local ImportBase = require "core/importation/ImportBase"
local CausalConnector = require "core/connectors/CausalConnector"

local ConnectorBase = NCLElem:extends()

ConnectorBase.name = "connectorBase"

ConnectorBase.childrenMap = {
 ["importBase"] = {ImportBase, "many"},
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
   connectorBase.importBases = {} 
   connectorBase.causalConnectors = {}
    
   if(full ~= nil)then    
      connectorBase:addImportBase(ImportBase:create())    
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

function ConnectorBase:addImportBase(importBase)
   self:addChild(importBase)
   table.insert(self.importBases, importBase)
end

function ConnectorBase:getImportBasePos(p)
    return self.importBases[p]
end

function ConnectorBase:getImportBaseByAlias(alias)
   for _, importBase in ipairs(self.importBases) do
       if(importBase:getAlias() == alias)then
          return importBase
       end
   end
   
   return nil
end

function ConnectorBase:setImportBases(...)
    if(#arg>0)then
      for _, importBase in ipairs(arg) do
          self:addRule(importBase)
      end
    end
end

function ConnectorBase:removeImportBase(importBase)
   self:removeChild(importBase)
   
   for p, ib in ipairs(self.importBases) do
       if(importBase == ib)then
           table.remove(self.importBases, p)  
       end
   end    
end

function ConnectorBase:removeImportBasePos(p)
   self:removeChildPos(p)
   table.remove(self.importBases, p)
end

function ConnectorBase:addCausalConnector(causalConnector)
   self:addChild(causalConnector)
   table.insert(self.causalConnectors, causalConnector)
end

function ConnectorBase:getCausalConnectorPos(p)
    return self.causalConnectors[p]
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
   
   for p, cc in ipairs(self.causalConnectors) do
       if(causalConnector == cc)then
           table.remove(self.causalConnectors, p)  
       end
   end 
end

function ConnectorBase:removeCausalConnectorPos(p)
   self:removeChildPos(p)
   table.remove(self.causalConnectors, p)
end

return ConnectorBase