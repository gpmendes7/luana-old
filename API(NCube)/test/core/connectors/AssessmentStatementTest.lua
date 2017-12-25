local AssessmentStatement = require "core/connectors/AssessmentStatement"
local AttributeAssessment = require "core/connectors/AttributeAssessment"
local ValueAssessment = require "core/connectors/ValueAssessment"

local function test1()
   local assessmentStatement = nil
   
   assessmentStatement = AssessmentStatement:create()
   assert(assessmentStatement ~= nil, "Error!")
   assert(assessmentStatement:getComparator() == "", "Error!")   
end

local function test2()
   local assessmentStatement = nil
   
   local atts = {
      ["comparator"] = "eq"
   }     
   
   assessmentStatement = AssessmentStatement:create(atts)
   assert(assessmentStatement:getComparator() == "eq", "Error!")
end

local function test3()
   local assessmentStatement = nil
      
   assessmentStatement = AssessmentStatement:create()
   
   assessmentStatement:setComparator("eq")
   
   assert(assessmentStatement:getComparator() == "eq", "Error!")
end

local function test4()
   local assessmentStatement = nil
      
   assessmentStatement = AssessmentStatement:create(nil, 1)
   assert(assessmentStatement:getAttributeAssessmentPos(1) ~= nil, "Error!")
   
   assessmentStatement:addAttributeAssessment(AttributeAssessment:create())
   assert(assessmentStatement:getAttributeAssessmentPos(2) ~= nil, "Error!")
   
   assessmentStatement = AssessmentStatement:create(nil, 1)
   assessmentStatement:addAttributeAssessment(AttributeAssessment:create{["role"] = "attNodeTest"})
   assert(assessmentStatement:getDescendantByAttribute("role", "attNodeTest") ~= nil, "Error!")

   assessmentStatement = AssessmentStatement:create(nil, 1)
   assessmentStatement:setValueAssessment(ValueAssessment:create())
   assert(assessmentStatement:getValueAssessment() ~= nil, "Error!") 

   assessmentStatement:setValueAssessment(ValueAssessment:create{["value"] = "false"})
   assert(assessmentStatement:getDescendantByAttribute("value", "false") ~= nil, "Error!") 
end

local function test5()
   local assessmentStatement = AssessmentStatement:create{["comparator"] = "eq"}
   local attributeAssessment1 = AttributeAssessment:create{["role"] = "attNodeTest1"}
   local attributeAssessment2 = AttributeAssessment:create{["role"] = "attNodeTest2"}
   local valueAssessment1 = ValueAssessment:create{["value"] = "false"}
   local valueAssessment2 = ValueAssessment:create{["value"] = "true"}
 
   assessmentStatement:setAttributeAssessments(attributeAssessment1, attributeAssessment2)
   assert(assessmentStatement:getDescendantByAttribute("role", "attNodeTest1") ~= nil, "Error!")
   assert(assessmentStatement:getDescendantByAttribute("role", "attNodeTest2") ~= nil, "Error!")  

   assessmentStatement:removeAttributeAssessment(attributeAssessment1)
   assert(assessmentStatement:getDescendantByAttribute("role", "attNodeTest1") == nil, "Error!")
   
   assessmentStatement:removeAttributeAssessmentPos(1)
   assert(assessmentStatement:getDescendantByAttribute("role", "attNodeTest2") == nil, "Error!")
   
   assessmentStatement:setValueAssessment(valueAssessment1)
   assert(assessmentStatement:getDescendantByAttribute("value", "false") ~= nil, "Error!")
   
   assessmentStatement:setValueAssessment(valueAssessment2)
   assert(assessmentStatement:getDescendantByAttribute("value", "false") == nil, "Error!")
   assert(assessmentStatement:getDescendantByAttribute("value", "true") ~= nil, "Error!")
   
   assessmentStatement:removeValueAssessment(valueAssessment2)
   assert(assessmentStatement:getDescendantByAttribute("value", "true") == nil, "Error!")
end

local function test6()
   local assessmentStatement = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
      ["comparator"] = "eq"
   }    
      
   assessmentStatement = AssessmentStatement:create(atts)
   
   nclExp = "<assessmentStatement"   
   for attribute, value in pairs(assessmentStatement:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
  
   nclExp = nclExp.."/>\n"

   nclRet = assessmentStatement:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

local function test7()
   local assessmentStatement = nil
   
   local attributeAssessment, valueAssessment = nil
   
   local nclExp, nclRet = nil
   
   assessmentStatement = AssessmentStatement:create{["comparator"] = "eq"}
   nclExp = "<assessmentStatement comparator=\"eq\">\n"
      
   attributeAssessment = AttributeAssessment:create{["role"] = "attNodeTest1"}
   nclExp = nclExp.." <attributeAssessment role=\"attNodeTest1\"/>\n"  
  
   valueAssessment = ValueAssessment:create{["value"] = "false"}
   nclExp = nclExp.." <valueAssessment value=\"false\"/>\n"  
   
   nclExp = nclExp.."</assessmentStatement>\n"  

   assessmentStatement:addAttributeAssessment(attributeAssessment) 
   assessmentStatement:setValueAssessment(valueAssessment)        
   
   nclRet = assessmentStatement:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()
test7()