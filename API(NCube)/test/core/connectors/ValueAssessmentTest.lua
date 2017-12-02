local ValueAssessment = require "core/connectors/ValueAssessment"

local function test1()
   local valueAssessment = nil
   
   valueAssessment = ValueAssessment:create()
   assert(valueAssessment ~= nil, "Error!")
   assert(valueAssessment:getValue() == "", "Error!")  
end

local function test2()
   local valueAssessment = nil
   
   local atts = {
     ["value"] = "false"
   }     
   
   valueAssessment = ValueAssessment:create(atts)
   assert(valueAssessment ~= nil, "Error!")
   assert(valueAssessment:getValue() == "false", "Error!")  
end

local function test3()
   local valueAssessment = nil
      
   valueAssessment = ValueAssessment:create()
   
   valueAssessment:setValue("false")  
   
   assert(valueAssessment ~= nil, "Error!")
   assert(valueAssessment:getValue() == "false", "Error!")  
end

local function test4()
   local valueAssessment = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
      ["value"] = "false"
   }    
      
   valueAssessment = ValueAssessment:create(atts)
   
   nclExp = "<valueAssessment"   
   for attribute, value in pairs(valueAssessment:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
  
   nclExp = nclExp.."/>\n"

   nclRet = valueAssessment:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()