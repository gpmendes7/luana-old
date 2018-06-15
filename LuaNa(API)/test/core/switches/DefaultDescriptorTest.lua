local DefaultDescriptor = require "core/switches/DefaultDescriptor"

local function test1()
   local defaultDescriptor = DefaultDescriptor:create()
   
   assert(defaultDescriptor ~= nil, "Error!")
   assert(defaultDescriptor:getDescriptor() == nil, "Error!")   
   assert(defaultDescriptor:getDescriptorAss() == nil, "Error!")   
end

local function test2()   
   local atts = {
       descriptor = "d1"
   }     
   
   local defaultDescriptor = DefaultDescriptor:create(atts)
   
   assert(defaultDescriptor ~= nil, "Error!")
   assert(defaultDescriptor:getDescriptor() == "d1", "Error!") 
end

local function test3()      
   local defaultDescriptor = DefaultDescriptor:create()
   
   defaultDescriptor:setDescriptor("d1")

   assert(defaultDescriptor:getDescriptor() == "d1", "Error!")
end

local function test4()
  local defaultDescriptor = DefaultDescriptor:create()
  local status, err
  
  status, err = pcall(defaultDescriptor["setDescriptor"], defaultDescriptor, DefaultDescriptor:create())
  assert(not(status), "Error!")

  status, err = pcall(defaultDescriptor["setDescriptor"], defaultDescriptor, nil)
  assert(not(status), "Error!")

  status, err = pcall(defaultDescriptor["setDescriptor"], defaultDescriptor, {})
  assert(not(status), "Error!")

  status, err = pcall(defaultDescriptor["setDescriptor"], defaultDescriptor, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
   local atts = {
      descriptor = "d1"
   }    
      
   local defaultDescriptor = DefaultDescriptor:create(atts)
   
   local nclExp = "<defaultDescriptor descriptor=\"d1\"/>\n"

   local nclRet = defaultDescriptor:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()