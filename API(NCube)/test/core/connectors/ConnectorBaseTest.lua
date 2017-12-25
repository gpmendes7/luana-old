local ConnectorBase = require "core/connectors/ConnectorBase"
local ImportBase = require "core/importation/ImportBase"
local CausalConnector = require "core/connectors/CausalConnector"

local function test1()
   local connectorBase = nil
   
   connectorBase = ConnectorBase:create()
   assert(connectorBase ~= nil, "Error!")
   assert(connectorBase:getId() == "", "Error!")    
end

local function test2()
   local connectorBase = nil
   
   local atts = {
      ["id"] = "cb"
   }     
   
   connectorBase = ConnectorBase:create(atts)
   assert(connectorBase:getId() == "cb", "Error!") 
end

local function test3()
   local connectorBase = nil
      
   connectorBase = ConnectorBase:create()
   
   connectorBase:setId("cb") 
   
   assert(connectorBase:getId() == "cb", "Error!") 
end

local function test4()
   local connectorBase = nil
      
   connectorBase = ConnectorBase:create(nil, 1)
   assert(connectorBase:getImportBasePos(1) ~= nil, "Error!")
   assert(connectorBase:getCausalConnectorPos(1) ~= nil, "Error!")
    
   connectorBase:addImportBase(ImportBase:create())
   assert(connectorBase:getImportBasePos(2) ~= nil, "Error!")
   
   connectorBase:addCausalConnector(CausalConnector:create())
   assert(connectorBase:getCausalConnectorPos(2) ~= nil, "Error!")
end

local function test5()
   local connectorBase = ConnectorBase:create{["id"] = "cb"}
   local importBase = ImportBase:create{["alias"] = "ib"}
   local causalConnector = CausalConnector:create{["id"] = "cc"}

   connectorBase:addImportBase(importBase)
   assert(connectorBase:getDescendantByAttribute("alias", "ib") ~= nil, "Error!") 
    
   connectorBase:removeImportBase(importBase)
   assert(connectorBase:getDescendantByAttribute("alias", "ib") == nil, "Error!") 
   
   connectorBase:addImportBase(importBase)
   connectorBase:removeImportBasePos(1)
   assert(connectorBase:getDescendantByAttribute("alias", "ib") == nil, "Error!")
end

local function test6()
   local connectorBase = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
      ["id"] = "cb"
   }  
      
   connectorBase = ConnectorBase:create(atts)
   
   nclExp = "<connectorBase"   
   for attribute, value in pairs(connectorBase:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
  
   nclExp = nclExp.."/>\n"

   nclRet = connectorBase:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

local function test7()   
   local connectorBase = nil
   
   local importBase, causalConnector = nil
   
   local nclExp, nclRet = nil
   
   connectorBase = ConnectorBase:create{["id"] = "cb"}
   nclExp = "<connectorBase id=\"cb\">\n"
   
   importBase = ImportBase:create{["alias"] = "ib"}
   nclExp = nclExp.." <importBase alias=\"ib\"/>\n"
   
   causalConnector = CausalConnector:create{["id"] = "cc"}
   nclExp = nclExp.." <causalConnector id=\"cc\"/>\n"
                    
   nclExp = nclExp.."</connectorBase>\n"  

   connectorBase:addImportBase(importBase)
   connectorBase:addCausalConnector(causalConnector) 
   
   nclRet = connectorBase:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()
test7()