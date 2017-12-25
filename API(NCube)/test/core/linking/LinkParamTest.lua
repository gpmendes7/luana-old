local LinkParam = require "core/linking/LinkParam"

local function test1()
   local linkParam = nil
   
   linkParam = LinkParam:create()
   assert(linkParam ~= nil, "Error!")
   assert(linkParam:getName() == "", "Error!")
   assert(linkParam:getValue() == "", "Error!")     
end

local function test2()
   local linkParam = nil
   
   local atts = { 
     ["name"] = "delay",
     ["value"] = "0.5s"
   }
   
   linkParam = LinkParam:create(atts)
   assert(linkParam:getName() == "delay", "Error!")
   assert(linkParam:getValue() == "0.5s", "Error!")   
end

local function test3()
   local linkParam = nil
      
   linkParam = LinkParam:create()
   
   linkParam:setName("delay")
   linkParam:setValue("0.5s")
   
   assert(linkParam:getName() == "delay", "Error!")
   assert(linkParam:getValue() == "0.5s", "Error!")   
end

local function test4()
   local linkParam = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
     ["name"] = "delay",
     ["value"] = "0.5s"
   }    
      
   linkParam = LinkParam:create(atts)
   
   nclExp = "<linkParam"   
   for attribute, value in pairs(linkParam:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
   
   nclExp = nclExp.."/>\n"

   nclRet = linkParam:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()