local BindRule = require "core/switches/BindRule"

local function test1()
   local bindRule = nil
   
   bindRule = BindRule:create()
   assert(bindRule ~= nil, "Error!")
   assert(bindRule:getConstituent() == "", "Error!")  
   assert(bindRule:getRule() == "", "Error!")  
end

local function test2()
   local bindRule = nil
   
   local atts = {
     ["constituent"] = "",
     ["rule"] = ""
   }     
   
   bindRule = BindRule:create(atts)
   assert(bindRule:getConstituent() == "", "Error!")  
   assert(bindRule:getRule() == "", "Error!")  
end

local function test3()
   local bindRule = nil
      
   bindRule = BindRule:create()
   
   bindRule:setConstituent("audio1")
   bindRule:setRule("rPt")  

   assert(bindRule:getConstituent() == "audio1", "Error!")  
   assert(bindRule:getRule() == "rPt", "Error!") 
end

local function test4()
   local bindRule = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
     ["constituent"] = "audio1",
     ["rule"] = "rPt"
   }    
      
   bindRule = BindRule:create(atts)
   
   nclExp = "<bindRule"   
   for attribute, value in pairs(bindRule:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
  
   nclExp = nclExp.."/>\n"

   nclRet = bindRule:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end


test1()
test2()
test3()
test4()
