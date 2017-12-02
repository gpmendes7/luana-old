local AttributeAssessment = require "core/connectors/AttributeAssessment"

local function test1()
   local attributeAssessment = nil
   
   attributeAssessment = AttributeAssessment:create()
   assert(attributeAssessment ~= nil, "Error!")
   assert(attributeAssessment:getRole() == "", "Error!")  
   assert(attributeAssessment:getEventType() == "", "Error!") 
   assert(attributeAssessment:getKey() == "", "Error!")  
   assert(attributeAssessment:getAttributeType() == "", "Error!")  
   assert(attributeAssessment:getOffset() == "", "Error!")  
end

local function test2()
   local attributeAssessment = nil
   
   local atts = {
    ["role"] = "attNodeTest",
    ["eventType"] = "attNodeTest",
    ["key"] = "CURSOR_DOWN",
    ["attributeType"] = "nodeProperty",
    ["offset"] = "off"
   }     
   
   attributeAssessment = AttributeAssessment:create(atts)
   assert(attributeAssessment ~= nil, "Error!")
   assert(attributeAssessment:getRole() == "attNodeTest", "Error!")  
   assert(attributeAssessment:getEventType() == "attNodeTest", "Error!") 
   assert(attributeAssessment:getKey() == "CURSOR_DOWN", "Error!")  
   assert(attributeAssessment:getAttributeType() == "nodeProperty", "Error!")  
   assert(attributeAssessment:getOffset() == "off", "Error!")   
end

local function test3()
   local attributeAssessment = nil
      
   attributeAssessment = AttributeAssessment:create()
   
   attributeAssessment:setRole("attNodeTest")  
   attributeAssessment:setEventType("attNodeTest") 
   attributeAssessment:setKey("CURSOR_DOWN")  
   attributeAssessment:setAttributeType("nodeProperty")  
   attributeAssessment:setOffset("off")   
   
   assert(attributeAssessment ~= nil, "Error!")
   assert(attributeAssessment:getRole() == "attNodeTest", "Error!")  
   assert(attributeAssessment:getEventType() == "attNodeTest", "Error!") 
   assert(attributeAssessment:getKey() == "CURSOR_DOWN", "Error!")  
   assert(attributeAssessment:getAttributeType() == "nodeProperty", "Error!")  
   assert(attributeAssessment:getOffset() == "off", "Error!")    
end

local function test4()
   local attributeAssessment = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
    ["role"] = "attNodeTest",
    ["eventType"] = "attNodeTest",
    ["key"] = "CURSOR_DOWN",
    ["attributeType"] = "nodeProperty",
    ["offset"] = "off"
   }    
      
   attributeAssessment = AttributeAssessment:create(atts)
   
   nclExp = "<attributeAssessment"   
   for attribute, value in pairs(attributeAssessment:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
  
   nclExp = nclExp.."/>\n"

   nclRet = attributeAssessment:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()