local Transition = require "core/transition/Transition"

local function test1()
   local transition = nil
   
   transition = Transition:create()
   assert(transition ~= nil, "Error!")
   assert(transition:getId() == "", "Error!")  
   assert(transition:getType() == "", "Error!")  
   assert(transition:getSubType() == "", "Error!")
   assert(transition:getDur() == "", "Error!")  
   assert(transition:getStartProgress() == "", "Error!")
   assert(transition:getEndProgress() == "", "Error!")   
   assert(transition:getDirection() == "", "Error!")  
   assert(transition:getFadeColor() == "", "Error!")   
   assert(transition:getHorzRepeat() == "", "Error!")   
   assert(transition:getVertRepeat() == "", "Error!")   
   assert(transition:getBorderWidth() == "", "Error!")  
   assert(transition:getBorderColor() == "", "Error!")  
end

local function test2()
   local transition = nil
   
   local atts = {
     ["id"] = "transition", 
     ["type"] = "barWipe", 
     ["subtype"] = "leftToRight", 
     ["dur"] = "5s", 
     ["startProgress"] = "0.2", 
     ["endProgress"] = "0.5", 
     ["direction"] = "forward", 
     ["fadeColor"] = "silver", 
     ["horzRepeat"] = "2", 
     ["vertRepeat"] = "3", 
     ["borderWidth"] = "2", 
     ["borderColor"] = "white"
   }     
   
   transition = Transition:create(atts)
   assert(transition:getId() == "transition", "Error!")  
   assert(transition:getType() == "barWipe", "Error!")  
   assert(transition:getSubType() == "leftToRight", "Error!")
   assert(transition:getDur() == "5s", "Error!")  
   assert(transition:getStartProgress() == "0.2", "Error!")
   assert(transition:getEndProgress() == "0.5", "Error!")   
   assert(transition:getDirection() == "forward", "Error!")  
   assert(transition:getFadeColor() == "silver", "Error!")   
   assert(transition:getHorzRepeat() == "2", "Error!")   
   assert(transition:getVertRepeat() == "3", "Error!")   
   assert(transition:getBorderWidth() == "2", "Error!")  
   assert(transition:getBorderColor() == "white", "Error!")
end

local function test3()
   local transition = nil
      
   transition = Transition:create()
   
   transition:setId("transition")  
   transition:setType("barWipe")  
   transition:setSubType("leftToRight")
   transition:setDur("5s")  
   transition:setStartProgress("0.2")
   transition:setEndProgress("0.5")   
   transition:setDirection("forward")  
   transition:setFadeColor("silver")   
   transition:setHorzRepeat("2")   
   transition:setVertRepeat("3")   
   transition:setBorderWidth("2")  
   transition:setBorderColor("white")
   
   assert(transition:getId() == "transition", "Error!")  
   assert(transition:getType() == "barWipe", "Error!")  
   assert(transition:getSubType() == "leftToRight", "Error!")
   assert(transition:getDur() == "5s", "Error!")  
   assert(transition:getStartProgress() == "0.2", "Error!")
   assert(transition:getEndProgress() == "0.5", "Error!")   
   assert(transition:getDirection() == "forward", "Error!")  
   assert(transition:getFadeColor() == "silver", "Error!")   
   assert(transition:getHorzRepeat() == "2", "Error!")   
   assert(transition:getVertRepeat() == "3", "Error!")   
   assert(transition:getBorderWidth() == "2", "Error!")  
   assert(transition:getBorderColor() == "white", "Error!")
end

local function test4()
   local transition = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
     ["id"] = "transition", 
     ["type"] = "barWipe", 
     ["subtype"] = "leftToRight", 
     ["dur"] = "5s", 
     ["startProgress"] = "0.2", 
     ["endProgress"] = "0.5", 
     ["direction"] = "forward", 
     ["fadeColor"] = "silver", 
     ["horzRepeat"] = "2", 
     ["vertRepeat"] = "3", 
     ["borderWidth"] = "2", 
     ["borderColor"] = "white"
   }    
      
   transition = Transition:create(atts)
   
   nclExp = "<transition"   
   for attribute, value in pairs(transition:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
  
   nclExp = nclExp.."/>\n"

   nclRet = transition:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
