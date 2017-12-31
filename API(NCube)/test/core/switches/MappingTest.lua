local Mapping = require "core/switches/Mapping"

local function test1()
   local mapping = nil
   
   mapping = Mapping:create()
   assert(mapping ~= nil, "Error!")
   assert(mapping:getComponent() == "", "Error!")  
   assert(mapping:getInterface() == "", "Error!")  
end

local function test2()
   local mapping = nil
   
   local atts = {
    ["component"] = "enForm",
    ["interface"] = "interface"
   }     
   
   mapping = Mapping:create(atts)
   assert(mapping:getComponent() == "enForm", "Error!")  
   assert(mapping:getInterface() == "interface", "Error!")  
end

local function test3()
   local mapping = nil
      
   mapping = Mapping:create()
   
   mapping:setComponent("enForm")  
   mapping:setInterface("interface")  

   assert(mapping:getComponent() == "enForm", "Error!")  
   assert(mapping:getInterface() == "interface", "Error!") 
end

local function test4()
   local mapping = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
    ["component"] = "enForm",
    ["interface"] = "interface"
   }    
      
   mapping = Mapping:create(atts)
   
   nclExp = "<mapping"   
   for attribute, value in pairs(mapping:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
  
   nclExp = nclExp.."/>\n"

   nclRet = mapping:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()