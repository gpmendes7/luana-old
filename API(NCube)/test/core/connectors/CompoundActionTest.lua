local CompoundAction = require "core/connectors/CompoundAction"
local SimpleAction = require "core/connectors/SimpleAction"

local function test1()
   local compoundAction = nil
   
   compoundAction = CompoundAction:create()
   assert(compoundAction ~= nil, "Error!")
   assert(compoundAction:getOperator() == "", "Error!") 
   assert(compoundAction:getDelay() == "", "Error!")   
end

local function test2()
   local compoundAction = nil
   
   local atts = {
      ["operator"] = "and",
      ["delay"] = "10s"
   }     
   
   compoundAction = CompoundAction:create()
   assert(compoundAction ~= nil, "Error!")
   assert(compoundAction:getOperator() == "", "Error!") 
   assert(compoundAction:getDelay() == "", "Error!")   
end

local function test3()
   local compoundAction = nil
      
   compoundAction = CompoundAction:create()
   
   compoundAction:setOperator("and") 
   compoundAction:setDelay("10s") 
   
   assert(compoundAction ~= nil, "Error!")
   assert(compoundAction:getOperator() == "and", "Error!") 
   assert(compoundAction:getDelay() == "10s", "Error!") 
end

local function test4()
   local compoundAction = nil
      
   compoundAction = CompoundAction:create(nil, 1)
   assert(compoundAction:getSimpleActionPos(1) ~= nil, "Error!")
   assert(compoundAction:getCompoundActionPos(1) ~= nil, "Error!")

   compoundAction:addSimpleAction(SimpleAction:create())
   assert(compoundAction:getSimpleActionPos(2) ~= nil, "Error!")
   
   compoundAction:addCompoundAction(CompoundAction:create())
   assert(compoundAction:getCompoundActionPos(2) ~= nil, "Error!")
   
   compoundAction = CompoundAction:create()
   compoundAction:addSimpleAction(SimpleAction:create{["role"] = "set"})
   assert(compoundAction:getDescendantByAttribute("role", "set") ~= nil, "Error!")
   
   compoundAction = CompoundAction:create()
   compoundAction:addCompoundAction(CompoundAction:create{["operator"] = "and"})
   assert(compoundAction:getDescendantByAttribute("operator", "and") ~= nil, "Error!")
end

local function test5()
   local compoundAction1 = CompoundAction:create{["operator"] = "and"}
   local simpleAction = SimpleAction:create{["role"] = "set"}
   local compoundAction2 = CompoundAction:create{["operator"] = "or"}
 
   compoundAction1:addSimpleAction(simpleAction)
   assert(compoundAction1:getDescendantByAttribute("role", "set") ~= nil, "Error!") 
    
   compoundAction1:removeSimpleAction(simpleAction)
   assert(compoundAction1:getDescendantByAttribute("role", "set") == nil, "Error!") 
   
   compoundAction1:addSimpleAction(simpleAction)
   compoundAction1:removeSimpleActionPos(1)
   assert(compoundAction1:getDescendantByAttribute("role", "set") == nil, "Error!") 
   
   compoundAction1:addCompoundAction(compoundAction2)
   assert(compoundAction1:getDescendantByAttribute("operator", "or") ~= nil, "Error!") 
    
   compoundAction1:removeCompoundAction(compoundAction2)
   assert(compoundAction1:getDescendantByAttribute("operator", "or") == nil, "Error!") 
   
   compoundAction1:addCompoundAction(compoundAction2)
   compoundAction1:removeCompoundActionPos(1)
   assert(compoundAction1:getDescendantByAttribute("operator", "or") == nil, "Error!")    
end

local function test6()
   local compoundAction = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
      ["operator"] = "and",
      ["delay"] = "10s"
   }  
      
   compoundAction = CompoundAction:create(atts)
   
   nclExp = "<compoundAction"   
   for attribute, value in pairs(compoundAction:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
  
   nclExp = nclExp.."/>\n"

   nclRet = compoundAction:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

local function test7()   
   local compoundAction1 = nil 
    
   local simpleAction, compoundAction2 = nil
  
   local nclExp, nclRet = nil
   
   compoundAction1 = CompoundAction:create{["operator"] = "and"}
   nclExp = "<compoundAction operator=\"and\">\n"
   
   simpleAction = SimpleAction:create{["role"] = "set"}
   nclExp = nclExp.." <simpleAction role=\"set\"/>\n"
   
   compoundAction2 = CompoundAction:create{["operator"] = "or"}
   nclExp = nclExp.." <compoundAction operator=\"or\"/>\n" 
           
   nclExp = nclExp.."</compoundAction>\n"  

   compoundAction1:addSimpleAction(simpleAction) 
   compoundAction1:addCompoundAction(compoundAction2)       

   nclRet = compoundAction1:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()
test7()