local TransitionBase = require "core/transition/TransitionBase"
local ImportBase = require "core/importation/ImportBase"
local Transition = require "core/transition/Transition"

local function test1()
   local transitionBase = nil
   
   transitionBase = TransitionBase:create()
   assert(transitionBase ~= nil, "Error!")
   assert(transitionBase:getId() == "", "Error!")
end

local function test2()
   local transitionBase = nil
   
   local atts = {
      ["id"] = "transitionBase"
   }     
   
   transitionBase = TransitionBase:create(atts)
   assert(transitionBase:getId() == "transitionBase", "Error!") 
end

local function test3()
   local transitionBase = nil
      
   transitionBase = TransitionBase:create()
   
   transitionBase:setId("transitionBase")
   
   assert(transitionBase:getId() == "transitionBase", "Error!") 
end

local function test4()
   local transitionBase = nil
      
   transitionBase = TransitionBase:create(nil, 1)
   assert(transitionBase:getImportBasePos(1) ~= nil, "Error!")
   assert(transitionBase:getTransitionPos(1) ~= nil, "Error!")
   
   transitionBase:addImportBase(ImportBase:create())
   assert(transitionBase:getImportBasePos(2) ~= nil, "Error!")
   
   transitionBase:addTransition(Transition:create())
   assert(transitionBase:getTransitionPos(2) ~= nil, "Error!")
   
   transitionBase:addImportBase(ImportBase:create{["alias"] = "connBase"})
   assert(transitionBase:getDescendantByAttribute("alias", "connBase") ~= nil, "Error!")   
   
   transitionBase:addTransition(Transition:create{["id"] = "transition"})
   assert(transitionBase:getDescendantByAttribute("id", "transition") ~= nil, "Error!")   
end

local function test5()
   local transitionBase = TransitionBase:create{["id"] = "transitionBase"}
   local importBase1 = ImportBase:create{["alias"] = "connBase1"}
   local importBase2 = ImportBase:create{["alias"] = "connBase2"}
   local transition1 = Transition:create{["id"] = "transition1"}
   local transition2 = Transition:create{["id"] = "transition2"}
 
   transitionBase:setImportBases(importBase1, importBase2)
   assert(transitionBase:getDescendantByAttribute("alias", "connBase1") ~= nil, "Error!") 
   assert(transitionBase:getDescendantByAttribute("alias", "connBase2") ~= nil, "Error!") 
    
   transitionBase:removeImportBase(importBase1)
   assert(transitionBase:getDescendantByAttribute("alias", "connBase1") == nil, "Error!") 
   
   transitionBase:removeImportBasePos(1)
   assert(transitionBase:getDescendantByAttribute("alias", "connBase2") == nil, "Error!")
   
   transitionBase:setTransitions(transition1, transition2)
   assert(transitionBase:getDescendantByAttribute("id", "transition1") ~= nil, "Error!") 
   assert(transitionBase:getDescendantByAttribute("id", "transition2") ~= nil, "Error!") 
    
   transitionBase:removeTransition(transition1)
   assert(transitionBase:getDescendantByAttribute("id", "transition1") == nil, "Error!") 
   
   transitionBase:removeTransitionPos(1)
   assert(transitionBase:getDescendantByAttribute("id", "transition2") == nil, "Error!")
end

local function test6()
   local transitionBase = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
      ["id"] = "transitionBase"
   }    
      
   transitionBase = TransitionBase:create(atts)
   
   nclExp = "<transitionBase"   
   for attribute, value in pairs(transitionBase:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
  
   nclExp = nclExp.."/>\n"

   nclRet = transitionBase:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

local function test7()
   local transitionBase = nil
   
   local transition, importBase = nil
   
   local nclExp, nclRet = nil
   
   transitionBase = TransitionBase:create{["id"] = "transitionBase"}
   nclExp = "<transitionBase id=\"transitionBase\">\n"
      
   transition = Transition:create{["id"] = "transition"}
   nclExp = nclExp.." <transition id=\"transition\"/>\n"  
   
   importBase = ImportBase:create{["alias"] = "connBase"}
   nclExp = nclExp.." <importBase alias=\"connBase\"/>\n"  
      
   nclExp = nclExp.."</transitionBase>\n"  

   transitionBase:addTransition(transition)
   transitionBase:addImportBase(importBase)     

   nclRet = transitionBase:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()
test7()