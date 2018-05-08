local ValueAssessment = require "core/connectors/ValueAssessment"

local function test1()
   local valueAssessment = ValueAssessment:create()
   
   assert(valueAssessment ~= nil, "Error!")
   assert(valueAssessment:getValue() == nil, "Error!")  
end

local function test2()   
   local atts = {
     value = "value"
   }     
   
   local valueAssessment = ValueAssessment:create(atts)
   
   assert(valueAssessment:getValue() == "value", "Error!")  
end

local function test3() 
   local valueAssessment = ValueAssessment:create()
   
   valueAssessment:setValue("value")  
   
   assert(valueAssessment:getValue() == "value", "Error!")  
end

local function test4()
  local valueAssessment = ValueAssessment:create()
  local status, err

  status, err = pcall(valueAssessment["setValue"], ValueAssessment, nil)
  assert(not(status), "Error!")

  status, err = pcall(valueAssessment["setValue"], ValueAssessment, {})
  assert(not(status), "Error!")

  status, err = pcall(valueAssessment["setValue"], ValueAssessment, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
   local atts = {
      value = "value"
   }    
      
   local valueAssessment = ValueAssessment:create(atts)
   
   local nclExp = "<valueAssessment"   
   for attribute, _ in pairs(valueAssessment:getAttributesTypeMap()) do
    if(valueAssessment.symbols ~= nil and valueAssessment.symbols[attribute] ~= nil)then
      nclExp = nclExp.." "..attribute.."=\""..valueAssessment[attribute]..valueAssessment.symbols[attribute].."\""
    else
      nclExp = nclExp.." "..attribute.."=\""..tostring(valueAssessment[attribute]).."\""
    end
   end
  
   nclExp = nclExp.."/>\n"

   local nclRet = valueAssessment:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()