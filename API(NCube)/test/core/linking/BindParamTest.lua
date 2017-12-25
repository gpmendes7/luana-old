local BindParam = require "core/linking/BindParam"

local function test1()
   local bindParam = nil
   
   bindParam = BindParam:create()
   assert(bindParam ~= nil, "Error!")
   assert(bindParam:getName() == "", "Error!")
   assert(bindParam:getValue() == "", "Error!")     
end

local function test2()
   local bindParam = nil
   
   local atts = { 
     ["name"] = "keyCode",
     ["value"] = "YELLOW"
   }
   
   bindParam = BindParam:create(atts)
   assert(bindParam:getName() == "keyCode", "Error!")
   assert(bindParam:getValue() == "YELLOW", "Error!")   
end

local function test3()
   local bindParam = nil
      
   bindParam = BindParam:create()
   
   bindParam:setName("keyCode")
   bindParam:setValue("YELLOW")
   
   assert(bindParam:getName() == "keyCode", "Error!")
   assert(bindParam:getValue() == "YELLOW", "Error!")   
end

local function test4()
   local bindParam = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
     ["name"] = "keyCode",
     ["value"] = "YELLOW"
   }    
      
   bindParam = BindParam:create(atts)
   
   nclExp = "<bindParam"   
   for attribute, value in pairs(bindParam:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
   
   nclExp = nclExp.."/>\n"

   nclRet = bindParam:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()