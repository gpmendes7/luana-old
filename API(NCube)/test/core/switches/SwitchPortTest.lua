local SwitchPort = require "core/switches/SwitchPort"
local Mapping = require "core/switches/Mapping"

local function test1()
   local switchPort = nil
   
   switchPort = SwitchPort:create()
   assert(switchPort ~= nil, "Error!")
   assert(switchPort:getId() == "", "Error!") 
end

local function test2()
   local switchPort = nil
   
   local atts = {
      ["id"] = "sp1"
   }     
   
   switchPort = SwitchPort:create(atts)
   assert(switchPort:getId() == "sp1", "Error!")   
end

local function test3()
   local switchPort = nil
      
   switchPort = SwitchPort:create()
   
   switchPort:setId("sp1") 
   
   assert(switchPort:getId() == "sp1", "Error!") 
end

local function test4()
   local switchPort = nil
      
   switchPort = SwitchPort:create(nil, 1)
   assert(switchPort:getMappingPos(1) ~= nil, "Error!")

   switchPort:addMapping(Mapping:create())
   assert(switchPort:getMappingPos(2) ~= nil, "Error!")
   
   switchPort = SwitchPort:create()
   switchPort:addMapping(Mapping:create{["component"] = "enForm"})
   assert(switchPort:getDescendantByAttribute("component", "enForm") ~= nil, "Error!")
end

local function test5()
   local switchPort = SwitchPort:create{["id"] = "sp1"}
   local mapping = Mapping:create{["component"] = "enForm"}
 
   switchPort:addMapping(mapping)
   assert(switchPort:getDescendantByAttribute("component", "enForm") ~= nil, "Error!") 
    
   switchPort:removeMapping(mapping)
   assert(switchPort:getDescendantByAttribute("component", "enForm") == nil, "Error!") 
   
   switchPort:addMapping(mapping)
   switchPort:removeMappingPos(1)
   assert(switchPort:getDescendantByAttribute("component", "enForm") == nil, "Error!") 
end

local function test6()
   local switchPort = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
        ["id"] = "sp1"
   }  
      
   switchPort = SwitchPort:create(atts)
   
   nclExp = "<switchPort"   
   for attribute, value in pairs(switchPort:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
  
   nclExp = nclExp.."/>\n"

   nclRet = switchPort:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

local function test7()      
   local switchPort = nil 
    
   local mapping = nil
  
   local nclExp, nclRet = nil
   
   switchPort = SwitchPort:create{["id"] = "sp1"}
   nclExp = "<switchPort id=\"sp1\">\n"
   
   mapping = Mapping:create{["component"] = "enForm"}
   nclExp = nclExp.." <mapping component=\"enForm\"/>\n"
           
   nclExp = nclExp.."</switchPort>\n"  

   switchPort:addMapping(mapping)  

   nclRet = switchPort:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()
test7()