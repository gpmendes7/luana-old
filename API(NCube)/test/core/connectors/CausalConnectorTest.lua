local CausalConnector = require "core/connectors/CausalConnector"
local ConnectorParam = require "core/connectors/ConnectorParam"
local SimpleCondition = require "core/connectors/SimpleCondition"
local CompoundCondition = require "core/connectors/CompoundCondition"
local SimpleAction = require "core/connectors/SimpleAction"
local CompoundAction = require "core/connectors/CompoundAction"

local function test1()
   local causalConnector = nil
   
   causalConnector = CausalConnector:create()
   assert(causalConnector ~= nil, "Error!")
   assert(causalConnector:getId() == "", "Error!")    
end

local function test2()
   local causalConnector = nil
   
   local atts = {
      ["id"] = "cc"
   }     
   
   causalConnector = CausalConnector:create(atts)
   assert(causalConnector:getId() == "cc", "Error!") 
end

local function test3()
   local causalConnector = nil
      
   causalConnector = CausalConnector:create()
   
   causalConnector:setId("cc") 
   
   assert(causalConnector:getId() == "cc", "Error!") 
end

local function test4()
   local causalConnector = nil
      
   causalConnector = CausalConnector:create(nil, 1)
   assert(causalConnector:getConnectorParamPos(1) ~= nil, "Error!")
   assert(causalConnector:getCompoundCondition() ~= nil, "Error!")
   assert(causalConnector:getCompoundAction() ~= nil, "Error!")
    
   causalConnector:addConnectorParam(ConnectorParam:create())
   assert(causalConnector:getConnectorParamPos(2) ~= nil, "Error!")
   
   causalConnector = CausalConnector:create()
   causalConnector:setSimpleCondition(SimpleCondition:create())
   assert(causalConnector:getSimpleCondition() ~= nil, "Error!")
   
   causalConnector = CausalConnector:create()
   causalConnector:setSimpleAction(SimpleAction:create())
   assert(causalConnector:getSimpleAction() ~= nil, "Error!")
end

local function test5()
   local causalConnector = CausalConnector:create{["id"] = "cc"}
   local connectorParam = ConnectorParam:create{["name"] = "var"}
   local simpleCondition = SimpleCondition:create{["role"] = "onSelection"}
   local compoundCondition = CompoundCondition:create{["operator"] = "and"}
   local simpleAction = SimpleAction:create{["role"] = "set"}
   local compoundAction = CompoundAction:create{["operator"] = "or"}
   
   causalConnector:addConnectorParam(connectorParam)
   assert(causalConnector:getDescendantByAttribute("name", "var") ~= nil, "Error!") 
    
   causalConnector:removeConnectorParam(connectorParam)
   assert(causalConnector:getDescendantByAttribute("name", "var") == nil, "Error!") 
   
   causalConnector:addConnectorParam(connectorParam)
   causalConnector:removeConnectorParamPos(1)
   assert(causalConnector:getDescendantByAttribute("name", "var") == nil, "Error!")
 
   causalConnector:setSimpleCondition(simpleCondition)
   assert(causalConnector:getDescendantByAttribute("role", "onSelection") ~= nil, "Error!") 
    
   causalConnector:removeSimpleCondition(simpleCondition)
   assert(causalConnector:getDescendantByAttribute("role", "onSelection") == nil, "Error!") 
   
   causalConnector:setCompoundCondition(compoundCondition)
   assert(causalConnector:getDescendantByAttribute("operator", "and") ~= nil, "Error!") 
    
   causalConnector:removeCompoundCondition(compoundCondition)
   assert(causalConnector:getDescendantByAttribute("operator", "and") == nil, "Error!") 
   
   causalConnector:setSimpleAction(simpleAction)
   assert(causalConnector:getDescendantByAttribute("role", "set") ~= nil, "Error!") 
    
   causalConnector:removeSimpleAction(simpleAction)
   assert(causalConnector:getDescendantByAttribute("role", "set") == nil, "Error!") 
   
   causalConnector:setCompoundAction(compoundAction)
   assert(causalConnector:getDescendantByAttribute("operator", "or") ~= nil, "Error!") 
    
   causalConnector:removeCompoundAction(compoundAction)
   assert(causalConnector:getDescendantByAttribute("operator", "or") == nil, "Error!") 
end

local function test6()
   local causalConnector = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
      ["id"] = "cc"
   }  
      
   causalConnector = CausalConnector:create(atts)
   
   nclExp = "<causalConnector"   
   for attribute, value in pairs(causalConnector:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
  
   nclExp = nclExp.."/>\n"

   nclRet = causalConnector:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

local function test7()   
   local causalConnector = nil
   
   local connectorParam, simpleCondition, compoundCondition, simpleAction, compoundAction = nil
   
   local nclExp, nclRet = nil
   
   causalConnector = CausalConnector:create{["id"] = "cc"}
   nclExp = "<causalConnector id=\"cc\">\n"
   
   connectorParam = ConnectorParam:create{["name"] = "var"}
   nclExp = nclExp.." <connectorParam name=\"var\"/>\n"
            
   simpleAction = SimpleAction:create{["role"] = "set"}
   nclExp = nclExp.." <simpleAction role=\"set\"/>\n"  
   
   simpleCondition = SimpleCondition:create{["role"] = "onSelection"}
   nclExp = nclExp.." <simpleCondition role=\"onSelection\"/>\n" 
        
   nclExp = nclExp.."</causalConnector>\n"  

   causalConnector:addConnectorParam(connectorParam)
   causalConnector:setSimpleCondition(simpleCondition) 
   causalConnector:setSimpleAction(simpleAction) 
   
   nclRet = causalConnector:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
   
   nclExp = nil
   
   causalConnector = CausalConnector:create{["id"] = "cc"}
   nclExp = "<causalConnector id=\"cc\">\n"
   
   connectorParam = ConnectorParam:create{["name"] = "var"}
   nclExp = nclExp.." <connectorParam name=\"var\"/>\n"  
      
   compoundAction = CompoundAction:create{["operator"] = "or"}
   nclExp = nclExp.." <compoundAction operator=\"or\"/>\n"  
   
   compoundCondition = CompoundCondition:create{["operator"] = "and"}
   nclExp = nclExp.." <compoundCondition operator=\"and\"/>\n" 
   
   nclExp = nclExp.."</causalConnector>\n"  
   
   causalConnector:addConnectorParam(connectorParam)
   causalConnector:setCompoundCondition(compoundCondition) 
   causalConnector:setCompoundAction(compoundAction)
   
   nclRet = causalConnector:table2Ncl(0) 
       
   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()
test7()