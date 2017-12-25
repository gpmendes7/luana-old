local SimpleCondition = require "core/connectors/SimpleCondition"

local function test1()
   local simpleCondition = nil
   
   simpleCondition = SimpleCondition:create()
   assert(simpleCondition ~= nil, "Error!")
   assert(simpleCondition:getRole() == "", "Error!")  
   assert(simpleCondition:getDelay() == "", "Error!")  
   assert(simpleCondition:getEventType() == "", "Error!")  
   assert(simpleCondition:getKey() == "", "Error!")  
   assert(simpleCondition:getTransition() == "", "Error!")  
   assert(simpleCondition:getMin() == "", "Error!")  
   assert(simpleCondition:getMax() == "", "Error!")  
   assert(simpleCondition:getQualifier() == "", "Error!") 
end

local function test2()
   local simpleCondition = nil
   
   local atts = {
      ["role"] = "onSelection",
      ["delay"] = "0.3s",
      ["eventType"] = "selection",
      ["key"] = "$keyCode",
      ["transition"] = "starts",
      ["min"] = "2",
      ["max"] = "unbounded",
      ["qualifier"] = "or"
   }     
   
   simpleCondition = SimpleCondition:create(atts)
   assert(simpleCondition:getRole() == "onSelection", "Error!")  
   assert(simpleCondition:getDelay() == "0.3s", "Error!")  
   assert(simpleCondition:getEventType() == "selection", "Error!")  
   assert(simpleCondition:getKey() == "$keyCode", "Error!")  
   assert(simpleCondition:getTransition() == "starts", "Error!")  
   assert(simpleCondition:getMin() == "2", "Error!")  
   assert(simpleCondition:getMax() == "unbounded", "Error!")  
   assert(simpleCondition:getQualifier() == "or", "Error!") 
end

local function test3()
   local simpleCondition = nil
      
   simpleCondition = SimpleCondition:create()
   
   simpleCondition:setRole("onSelection")  
   simpleCondition:setDelay("0.3s")  
   simpleCondition:setEventType("selection")  
   simpleCondition:setKey("$keyCode")  
   simpleCondition:setTransition("starts")  
   simpleCondition:setMin("2")  
   simpleCondition:setMax("unbounded")  
   simpleCondition:setQualifier("or")   
   
   assert(simpleCondition:getRole() == "onSelection", "Error!")  
   assert(simpleCondition:getDelay() == "0.3s", "Error!")  
   assert(simpleCondition:getEventType() == "selection", "Error!")  
   assert(simpleCondition:getKey() == "$keyCode", "Error!")  
   assert(simpleCondition:getTransition() == "starts", "Error!")  
   assert(simpleCondition:getMin() == "2", "Error!")  
   assert(simpleCondition:getMax() == "unbounded", "Error!")  
   assert(simpleCondition:getQualifier() == "or", "Error!")   
end

local function test4()
   local simpleCondition = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
      ["role"] = "onSelection",
      ["delay"] = "0.3s",
      ["eventType"] = "selection",
      ["key"] = "$keyCode",
      ["transition"] = "starts",
      ["min"] = "2",
      ["max"] = "unbounded",
      ["qualifier"] = "or"
   }    
      
   simpleCondition = SimpleCondition:create(atts)
   
   nclExp = "<simpleCondition"   
   for attribute, value in pairs(simpleCondition:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
  
   nclExp = nclExp.."/>\n"

   nclRet = simpleCondition:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()