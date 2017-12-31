local DefaultDescriptor = require "core/switches/DefaultDescriptor"

local function test1()
   local defaultDescriptor = nil
   
   defaultDescriptor = DefaultDescriptor:create()
   assert(defaultDescriptor ~= nil, "Error!")
   assert(defaultDescriptor:getDescriptor() == "", "Error!")   
end

local function test2()
   local defaultDescriptor = nil
   
   local atts = {
       ["descriptor"] = "d1"
   }     
   
   defaultDescriptor = DefaultDescriptor:create(atts)
   assert(defaultDescriptor ~= nil, "Error!")
   assert(defaultDescriptor:getDescriptor() == "d1", "Error!") 
end

local function test3()
   local defaultDescriptor = nil
      
   defaultDescriptor = DefaultDescriptor:create()
   
   defaultDescriptor:setDescriptor("d1")

   assert(defaultDescriptor:getDescriptor() == "d1", "Error!")
end


local function test4()
   local defaultDescriptor = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
      ["descriptor"] = "d1"
   }    
      
   defaultDescriptor = DefaultDescriptor:create(atts)
   
   nclExp = "<defaultDescriptor"   
   for attribute, value in pairs(defaultDescriptor:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
  
   nclExp = nclExp.."/>\n"

   nclRet = defaultDescriptor:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()