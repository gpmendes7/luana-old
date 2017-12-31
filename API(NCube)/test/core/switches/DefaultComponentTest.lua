local DefaultComponent = require "core/switches/DefaultComponent"

local function test1()
   local defaultComponent = nil
   
   defaultComponent = DefaultComponent:create()
   assert(defaultComponent ~= nil, "Error!")
   assert(defaultComponent:getComponent() == "", "Error!")   
end

local function test2()
   local defaultComponent = nil
   
   local atts = {
       ["component"] = "comp"
   }     
   
   defaultComponent = DefaultComponent:create(atts)
   assert(defaultComponent ~= nil, "Error!")
   assert(defaultComponent:getComponent() == "comp", "Error!") 
end

local function test3()
   local defaultComponent = nil
      
   defaultComponent = DefaultComponent:create()
   
   defaultComponent:setComponent("comp")

   assert(defaultComponent:getComponent() == "comp", "Error!")
end


local function test4()
   local defaultComponent = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
      ["component"] = "comp"
   }    
      
   defaultComponent = DefaultComponent:create(atts)
   
   nclExp = "<defaultComponent"   
   for attribute, value in pairs(defaultComponent:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
  
   nclExp = nclExp.."/>\n"

   nclRet = defaultComponent:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()