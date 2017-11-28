local DescriptorParam = require "core/layout/DescriptorParam"

local function test1()
   local descriptorParam = nil
   
   descriptorParam = DescriptorParam:create()
   assert(descriptorParam ~= nil, "Error!")
   assert(descriptorParam:getName() == "", "Error!")
   assert(descriptorParam:getValue() == "", "Error!")     
end

local function test2()
   local descriptorParam = nil
   
   local atts = { 
     ["name"] = "soundLevel",
     ["value"] = "0.9"
   }
   
   descriptorParam = DescriptorParam:create(atts)
   assert(descriptorParam:getName() == "soundLevel", "Error!")
   assert(descriptorParam:getValue() == "0.9", "Error!")   
end

local function test3()
   local descriptorParam = nil
      
   descriptorParam = DescriptorParam:create()
   
   descriptorParam:setName("soundLevel")
   descriptorParam:setValue("0.9")
   
   assert(descriptorParam:getName() == "soundLevel", "Error!")
   assert(descriptorParam:getValue() == "0.9", "Error!") 
end

local function test4()
   local descriptorParam = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
     ["name"] = "soundLevel",
     ["value"] = "0.9"
   }    
      
   descriptorParam = DescriptorParam:create(atts)
   
   nclExp = "<descriptorParam"   
   for attribute, value in pairs(descriptorParam:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
   
   nclExp = nclExp.."/>\n"

   nclRet = descriptorParam:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()