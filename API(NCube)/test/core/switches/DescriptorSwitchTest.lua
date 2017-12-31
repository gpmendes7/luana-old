local DescriptorSwitch = require "core/switches/DescriptorSwitch"
local DefaultDescriptor = require "core/switches/DefaultDescriptor"
local BindRule = require "core/switches/BindRule"
local Descriptor = require "core/layout/Descriptor"

local function test1()
   local descriptorSwitch = nil
   
   descriptorSwitch = DescriptorSwitch:create()
   assert(descriptorSwitch ~= nil, "Error!")
   assert(descriptorSwitch:getId() == "", "Error!") 
end

local function test2()
   local descriptorSwitch = nil
   
   local atts = {
      ["id"] = "ds1"
   }     
   
   descriptorSwitch = DescriptorSwitch:create(atts)
   assert(descriptorSwitch:getId() == "ds1", "Error!")   
end

local function test3()
   local descriptorSwitch = nil
      
   descriptorSwitch = DescriptorSwitch:create()
   
   descriptorSwitch:setId("ds1")  
   
   assert(descriptorSwitch:getId() == "ds1", "Error!")  
end

local function test4()
   local descriptorSwitch = nil
      
   descriptorSwitch = DescriptorSwitch:create(nil, 1)
   assert(descriptorSwitch:getDefaultDescriptor() ~= nil, "Error!")
   assert(descriptorSwitch:getBindRulePos(1) ~= nil, "Error!")
   assert(descriptorSwitch:getDescriptorPos(1) ~= nil, "Error!")

   descriptorSwitch:addBindRule(BindRule:create())
   assert(descriptorSwitch:getBindRulePos(2) ~= nil, "Error!")
   
   descriptorSwitch:addDescriptor(Descriptor:create())
   assert(descriptorSwitch:getDescriptorPos(2) ~= nil, "Error!")
   
   descriptorSwitch = DescriptorSwitch:create()
   descriptorSwitch:setDefaultDescriptor(DefaultDescriptor:create{["descriptor"] = "df"})
   assert(descriptorSwitch:getDescendantByAttribute("descriptor", "df") ~= nil, "Error!")
   
   descriptorSwitch = DescriptorSwitch:create()
   descriptorSwitch:addBindRule(BindRule:create{["rule"] = "rPt"})
   assert(descriptorSwitch:getDescendantByAttribute("rule", "rPt") ~= nil, "Error!")
   
   descriptorSwitch = DescriptorSwitch:create()
   descriptorSwitch:addDescriptor(Descriptor:create{["id"] = "d1"})
   assert(descriptorSwitch:getDescendantByAttribute("id", "d1") ~= nil, "Error!")
end

local function test5()
   local descriptorSwitch = DescriptorSwitch:create{["id"] = "ds1"}
   local defaultDescriptor = DefaultDescriptor:create{["descriptor"] = "df"}
   local bindRule = BindRule:create{["rule"] = "rPt"}
   local descriptor = Descriptor:create{["id"] = "d1"}
   
   descriptorSwitch:setDefaultDescriptor(defaultDescriptor)
   assert(descriptorSwitch:getDescendantByAttribute("descriptor", "df") ~= nil, "Error!") 
    
   descriptorSwitch:removeDefaultDescriptor(defaultDescriptor)
   assert(descriptorSwitch:getDescendantByAttribute("descriptor", "df") == nil, "Error!") 
 
   descriptorSwitch:addBindRule(bindRule)
   assert(descriptorSwitch:getDescendantByAttribute("rule", "rPt") ~= nil, "Error!") 
    
   descriptorSwitch:removeBindRule(bindRule)
   assert(descriptorSwitch:getDescendantByAttribute("rule", "rPt") == nil, "Error!") 
   
   descriptorSwitch:addBindRule(bindRule)
   descriptorSwitch:removeBindRulePos(1)
   assert(descriptorSwitch:getDescendantByAttribute("rule", "rPt") == nil, "Error!") 
   
   descriptorSwitch:addDescriptor(descriptor)
   assert(descriptorSwitch:getDescendantByAttribute("id", "d1") ~= nil, "Error!") 
    
   descriptorSwitch:removeDescriptor(descriptor)
   assert(descriptorSwitch:getDescendantByAttribute("id", "d1") == nil, "Error!") 
   
   descriptorSwitch:addDescriptor(descriptor)
   descriptorSwitch:removeDescriptorPos(1)
   assert(descriptorSwitch:getDescendantByAttribute("id", "d1") == nil, "Error!")    
end

local function test6()
   local descriptorSwitch = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
     ["id"] = "ds1"
   }  
      
   descriptorSwitch = DescriptorSwitch:create(atts)
   
   nclExp = "<descriptorSwitch"   
   for attribute, value in pairs(descriptorSwitch:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
  
   nclExp = nclExp.."/>\n"

   nclRet = descriptorSwitch:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

local function test7()   
      local descriptorSwitch = DescriptorSwitch:create{["id"] = "ds1"}
   local defaultDescriptor = DefaultDescriptor:create{["descriptor"] = "df"}
   local bindRule = BindRule:create{["rule"] = "rPt"}
   local descriptor = Descriptor:create{["id"] = "d1"}
   

   local descriptorSwitch = nil 
    
   local defaultDescriptor, bindRule, descriptor = nil
  
   local nclExp, nclRet = nil
   
   descriptorSwitch = DescriptorSwitch:create{["id"] = "ds1"}
   nclExp = "<descriptorSwitch id=\"ds1\">\n"
   
   defaultDescriptor = DefaultDescriptor:create{["descriptor"] = "df"}
   nclExp = nclExp.." <defaultDescriptor descriptor=\"df\"/>\n"
   
   bindRule = BindRule:create{["rule"] = "rPt"}
   nclExp = nclExp.." <bindRule rule=\"rPt\"/>\n"
   
   descriptor = Descriptor:create{["id"] = "d1"}
   nclExp = nclExp.." <descriptor id=\"d1\"/>\n" 
                      
   nclExp = nclExp.."</descriptorSwitch>\n"  

   descriptorSwitch:setDefaultDescriptor(defaultDescriptor) 
   descriptorSwitch:addBindRule(bindRule)      
   descriptorSwitch:addDescriptor(descriptor)
   
   nclRet = descriptorSwitch:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()
test7()