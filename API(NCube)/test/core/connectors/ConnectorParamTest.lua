local ConnectorParam = require "core/connectors/ConnectorParam"

local function test1()
   local connectorParam = nil
   
   connectorParam = ConnectorParam:create()
   assert(connectorParam ~= nil, "Error!")
   assert(connectorParam:getName() == "", "Error!")  
   assert(connectorParam:getType() == "", "Error!")   
end

local function test2()
   local connectorParam = nil
   
   local atts = {
     ["name"] = "var",
     ["type"] = "integer"
   }     
   
   connectorParam = ConnectorParam:create(atts)
   assert(connectorParam ~= nil, "Error!")
   assert(connectorParam:getName() == "var", "Error!")  
   assert(connectorParam:getType() == "integer", "Error!") 
end

local function test3()
   local connectorParam = nil
      
   connectorParam = ConnectorParam:create()
   
   connectorParam:setName("var")  
   connectorParam:setType("integer") 
   
   assert(connectorParam ~= nil, "Error!")
   assert(connectorParam:getName() == "var", "Error!")  
   assert(connectorParam:getType() == "integer", "Error!") 
end

local function test4()
   local connectorParam = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
     ["name"] = "var",
     ["type"] = "integer"
   }    
      
   connectorParam = ConnectorParam:create(atts)
   
   nclExp = "<connectorParam"   
   for attribute, value in pairs(connectorParam:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
  
   nclExp = nclExp.."/>\n"

   nclRet = connectorParam:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()