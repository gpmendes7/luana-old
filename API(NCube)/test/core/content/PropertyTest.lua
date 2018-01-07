local Property = require "core/interface/Property"

local function test1()
   local property = nil
   
   property = Property:create()
   assert(property ~= nil, "Error!")
   assert(property:getName() == "", "Error!")
   assert(property:getValue() == "", "Error!") 
   assert(property:getExternable() == "", "Error!")  
end

local function test2()
   local property = nil
   
   local atts = { 
      ["name"] = "sound", 
      ["value"] = "2", 
      ["externable"] = "ext"
   }
   
   property = Property:create(atts)
   assert(property:getName() == "sound", "Error!")
   assert(property:getValue() == "2", "Error!") 
   assert(property:getExternable() == "ext", "Error!")  
end


local function test3()
   local property = nil
      
   property = Property:create()
   
   property:setName("sound")
   property:setValue("2") 
   property:setExternable("ext") 
   
   assert(property:getName() == "sound", "Error!")
   assert(property:getValue() == "2", "Error!") 
   assert(property:getExternable() == "ext", "Error!") 
end

local function test4()
   local property = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
      ["name"] = "sound", 
      ["value"] = "2", 
      ["externable"] = "ext"
   }    
      
   property = Property:create(atts)
   
   nclExp = "<property"   
   for attribute, value in pairs(property:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
   
   nclExp = nclExp.."/>\n"

   nclRet = property:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()