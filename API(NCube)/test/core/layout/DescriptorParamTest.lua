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

test1()
test2()
test3()