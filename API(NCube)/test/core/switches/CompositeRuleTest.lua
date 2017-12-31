local CompositeRule = require "core/switches/CompositeRule"
local Rule = require "core/switches/Rule"

local function test1()
   local compositeRule = nil
   
   compositeRule = CompositeRule:create()
   assert(compositeRule ~= nil, "Error!")
   assert(compositeRule:getId() == "", "Error!") 
   assert(compositeRule:getOperator() == "", "Error!")   
end

local function test2()
   local compositeRule = nil
   
   local atts = {
      ["id"] = "cr1",
      ["operator"] = "and"
   }     
   
   compositeRule = CompositeRule:create(atts)
   assert(compositeRule:getId() == "cr1", "Error!") 
   assert(compositeRule:getOperator() == "and", "Error!")     
end

local function test3()
   local compositeRule = nil
      
   compositeRule = CompositeRule:create()
   
   compositeRule:setId("cr1") 
   compositeRule:setOperator("and") 
   
   assert(compositeRule:getId() == "cr1", "Error!") 
   assert(compositeRule:getOperator() == "and", "Error!") 
end

local function test4()
   local compositeRule = nil
      
   compositeRule = CompositeRule:create(nil, 1)
   assert(compositeRule:getRulePos(1) ~= nil, "Error!")
   assert(compositeRule:getCompositeRulePos(1) ~= nil, "Error!")

   compositeRule:addRule(Rule:create())
   assert(compositeRule:getRulePos(2) ~= nil, "Error!")
   
   compositeRule:addCompositeRule(CompositeRule:create())
   assert(compositeRule:getCompositeRulePos(2) ~= nil, "Error!")
   
   compositeRule = CompositeRule:create()
   compositeRule:addRule(Rule:create{["id"] = "r1"})
   assert(compositeRule:getDescendantByAttribute("id", "r1") ~= nil, "Error!")
   
   compositeRule = compositeRule:create()
   compositeRule:addCompositeRule(CompositeRule:create{["id"] = "cr1"})
   assert(compositeRule:getDescendantByAttribute("id", "cr1") ~= nil, "Error!")
end

local function test5()
   local compositeRule1 = CompositeRule:create{["id"] = "cr1"}
   local rule = Rule:create{["id"] = "r1"}
   local compositeRule2 = CompositeRule:create{["id"] = "cr2"}
 
   compositeRule1:addRule(rule)
   assert(compositeRule1:getDescendantByAttribute("id", "r1") ~= nil, "Error!") 
    
   compositeRule1:removeRule(rule)
   assert(compositeRule1:getDescendantByAttribute("id", "r1") == nil, "Error!") 
   
   compositeRule1:addRule(rule)
   compositeRule1:removeRulePos(1)
   assert(compositeRule1:getDescendantByAttribute("id", "r1") == nil, "Error!") 
   
   compositeRule1:addCompositeRule(compositeRule2)
   assert(compositeRule1:getDescendantByAttribute("id", "cr2") ~= nil, "Error!") 
    
   compositeRule1:removeCompositeRule(compositeRule2)
   assert(compositeRule1:getDescendantByAttribute("id", "cr2") == nil, "Error!") 
   
   compositeRule1:addCompositeRule(compositeRule2)
   compositeRule1:removeCompositeRulePos(1)
   assert(compositeRule1:getDescendantByAttribute("id", "cr2") == nil, "Error!")    
end

local function test6()
   local compositeRule = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
      ["id"] = "cr1",
      ["operator"] = "and"
   }  
      
   compositeRule = CompositeRule:create(atts)
   
   nclExp = "<compositeRule"   
   for attribute, value in pairs(compositeRule:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
  
   nclExp = nclExp.."/>\n"

   nclRet = compositeRule:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

local function test7()   
 local compositeRule1 = CompositeRule:create{["id"] = "cr1"}
   local rule = Rule:create{["id"] = "r1"}
   local compositeRule2 = CompositeRule:create{["id"] = "cr2"}
   
   local compositeRule1 = nil 
    
   local rule, compositeRule2 = nil
  
   local nclExp, nclRet = nil
   
   compositeRule1 = CompositeRule:create{["id"] = "cr1"}
   nclExp = "<compositeRule id=\"cr1\">\n"
   
   rule = Rule:create{["id"] = "r1"}
   nclExp = nclExp.." <rule id=\"r1\"/>\n"
   
   compositeRule2 = CompositeRule:create{["id"] = "cr2"}
   nclExp = nclExp.." <compositeRule id=\"cr2\"/>\n" 
           
   nclExp = nclExp.."</compositeRule>\n"  

   compositeRule1:addRule(rule) 
   compositeRule1:addCompositeRule(compositeRule2)       

   nclRet = compositeRule1:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()
test7()