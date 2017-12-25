local Bind = require "core/linking/Bind"
local BindParam = require "core/linking/BindParam"

local function test1()
   local bind = nil
   
   bind = Bind:create()
   assert(bind ~= nil, "Error!")
   assert(bind:getRole() == "", "Error!")  
   assert(bind:getComponent() == "", "Error!")
   assert(bind:getInterface() == "", "Error!")
   assert(bind:getDescriptor() == "", "Error!")
end

local function test2()
   local bind = nil
   
   local atts = {
      ["role"] = "onBegin", 
      ["component"] = "img", 
      ["interface"] = "area", 
      ["descriptor"] = "d1"
   }     
   
   bind = Bind:create(atts)
   assert(bind:getRole() == "onBegin", "Error!")  
   assert(bind:getComponent() == "img", "Error!")
   assert(bind:getInterface() == "area", "Error!")
   assert(bind:getDescriptor() == "d1", "Error!")
end

local function test3()
   local bind = nil
      
   bind = Bind:create()
   
   bind:setRole("onBegin")
   bind:setComponent("img")
   bind:setInterface("area")
   bind:setDescriptor("d1")

   assert(bind:getRole() == "onBegin", "Error!")  
   assert(bind:getComponent() == "img", "Error!")
   assert(bind:getInterface() == "area", "Error!")
   assert(bind:getDescriptor() == "d1", "Error!")
end

local function test4()
   local bind = nil
      
   bind = Bind:create(nil, 1)
   assert(bind:getBindParamPos(1) ~= nil, "Error!")
   
   bind:addBindParam(BindParam:create())
   assert(bind:getBindParamPos(2) ~= nil, "Error!")
   
   bind:addBindParam(BindParam:create{["name"] = "keyCode"})
   assert(bind:getDescendantByAttribute("name", "keyCode") ~= nil, "Error!")
end

local function test5()
   local bind = Bind:create{["role"] = "onBegin"}  
   local bindParam = BindParam:create{["name"] = "keyCode"}

   bind:addBindParam(bindParam)
   assert(bind:getDescendantByAttribute("name", "keyCode") ~= nil, "Error!")

   bind:removeBindParam(bindParam)
   assert(bind:getDescendantByAttribute("name", "keyCode") == nil, "Error!")
   
   bind:addBindParam(bindParam)
   bind:removeBindParamPos(1)
   assert(bind:getDescendantByAttribute("name", "keyCode") == nil, "Error!")
end

local function test6()
   local bind = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
      ["role"] = "onBegin", 
      ["component"] = "img", 
      ["interface"] = "area", 
      ["descriptor"] = "d1"
   }  
      
   bind = Bind:create(atts)
   
   nclExp = "<bind"   
   for attribute, value in pairs(bind:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
   
   nclExp = nclExp.."/>\n"
  
   nclRet = bind:table2Ncl(0)
   
   assert(nclExp == nclRet, "Error!")
end

local function test7()
   local bind = nil
   local bindParam = nil
   
   local nclExp, nclRet = nil
   
   bind = Bind:create{["role"] = "onBegin"}  
   nclExp = "<bind role=\"onBegin\">\n"    
      
   bindParam = BindParam:create{["name"] = "keyCode"}
   nclExp = nclExp.." <bindParam name=\"keyCode\"/>\n"    

   nclExp = nclExp.."</bind>\n"

   bind:addBindParam(bindParam)  

   nclRet = bind:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()
test7()