local SimpleAction = require "core/connectors/SimpleAction"

local function test1()
   local simpleAction = nil
   
   simpleAction = SimpleAction:create()
   assert(simpleAction ~= nil, "Error!")
   assert(simpleAction:getRole() == "", "Error!")  
   assert(simpleAction:getDelay() == "", "Error!")  
   assert(simpleAction:getEventType() == "", "Error!")  
   assert(simpleAction:getActionType() == "", "Error!") 
   assert(simpleAction:getValue() == "", "Error!")
   assert(simpleAction:getMin() == "", "Error!")  
   assert(simpleAction:getMax() == "", "Error!") 
   assert(simpleAction:getQualifier() == "", "Error!") 
   assert(simpleAction:getRepeat() == "", "Error!") 
   assert(simpleAction:getRepeatDelay() == "", "Error!") 
   assert(simpleAction:getDuration() == "", "Error!")  
   assert(simpleAction:getBy() == "", "Error!")  
end

local function test2()
   local simpleAction = nil
   
   local atts = {
      ["role"] = "set",
      ["delay"] = "0.3s",
      ["eventType"] = "attribution",
      ["actionType"] = "start",
      ["value"] = "$var",
      ["min"] = "2",
      ["max"] = "unbounded",
      ["qualifier"] = "seq",
      ["repeat"] = "3",
      ["repeatDelay"] = "3",
      ["duration"] = "3",
      ["by"] = "4"
   }     
   
   simpleAction = SimpleAction:create(atts)
   assert(simpleAction:getRole() == "set", "Error!")  
   assert(simpleAction:getDelay() == "0.3s", "Error!")  
   assert(simpleAction:getEventType() == "attribution", "Error!")  
   assert(simpleAction:getActionType() == "start", "Error!") 
   assert(simpleAction:getValue() == "$var", "Error!")
   assert(simpleAction:getMin() == "2", "Error!")  
   assert(simpleAction:getMax() == "unbounded", "Error!") 
   assert(simpleAction:getQualifier() == "seq", "Error!") 
   assert(simpleAction:getRepeat() == "3", "Error!") 
   assert(simpleAction:getRepeatDelay() == "3", "Error!") 
   assert(simpleAction:getDuration() == "3", "Error!")  
   assert(simpleAction:getBy() == "4", "Error!")  
end

local function test3()
   local simpleAction = nil
      
   simpleAction = SimpleAction:create()
   
   simpleAction:setRole("set")  
   simpleAction:setDelay("0.3s")  
   simpleAction:setEventType("attribution")  
   simpleAction:setActionType("start") 
   simpleAction:setValue("$var")
   simpleAction:setMin("2")  
   simpleAction:setMax("unbounded") 
   simpleAction:setQualifier("seq") 
   simpleAction:setRepeat("3") 
   simpleAction:setRepeatDelay("3") 
   simpleAction:setDuration("3")  
   simpleAction:setBy("4")   
   
   assert(simpleAction:getRole() == "set", "Error!")  
   assert(simpleAction:getDelay() == "0.3s", "Error!")  
   assert(simpleAction:getEventType() == "attribution", "Error!")  
   assert(simpleAction:getActionType() == "start", "Error!") 
   assert(simpleAction:getValue() == "$var", "Error!")
   assert(simpleAction:getMin() == "2", "Error!")  
   assert(simpleAction:getMax() == "unbounded", "Error!") 
   assert(simpleAction:getQualifier() == "seq", "Error!") 
   assert(simpleAction:getRepeat() == "3", "Error!") 
   assert(simpleAction:getRepeatDelay() == "3", "Error!") 
   assert(simpleAction:getDuration() == "3", "Error!")  
   assert(simpleAction:getBy() == "4", "Error!") 
end

local function test4()
   local simpleAction = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
      ["role"] = "set",
      ["delay"] = "0.3s",
      ["eventType"] = "attribution",
      ["actionType"] = "start",
      ["value"] = "$var",
      ["min"] = "2",
      ["max"] = "unbounded",
      ["qualifier"] = "seq",
      ["repeat"] = "3",
      ["repeatDelay"] = "3",
      ["duration"] = "3",
      ["by"] = "4"
   }    
      
   simpleAction = SimpleAction:create(atts)
   
   nclExp = "<simpleAction"   
   for attribute, value in pairs(simpleAction:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
  
   nclExp = nclExp.."/>\n"

   nclRet = simpleAction:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()