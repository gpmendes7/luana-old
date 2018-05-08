local AssessmentStatement = require "core/connectors/AssessmentStatement"
local AttributeAssessment = require "core/connectors/AttributeAssessment"
local ValueAssessment = require "core/connectors/ValueAssessment"

local function test1()
  local assessmentStatement = AssessmentStatement:create()

  assert(assessmentStatement ~= nil, "Error!")
  assert(assessmentStatement:getComparator() == nil, "Error!")
end

local function test2()
  local atts = {
    comparator = "eq"
  }

  local assessmentStatement = AssessmentStatement:create(atts)

  assert(assessmentStatement:getComparator() == "eq", "Error!")
end

local function test3()
  local assessmentStatement = AssessmentStatement:create()
  
  assessmentStatement:setComparator("eq")

  assert(assessmentStatement:getComparator() == "eq", "Error!")
end

local function test4()
  local assessmentStatement = AssessmentStatement:create()
  local status, err

  status, err = pcall(assessmentStatement["setComparator"], AssessmentStatement, "invalid")
  assert(not(status), "Error!")

  status, err = pcall(assessmentStatement["setComparator"], AssessmentStatement, nil)
  assert(not(status), "Error!")

  status, err = pcall(assessmentStatement["setComparator"], AssessmentStatement, 999999)
  assert(not(status), "Error!")

  status, err = pcall(assessmentStatement["setComparator"], AssessmentStatement, {})
  assert(not(status), "Error!")

  status, err = pcall(assessmentStatement["setComparator"], AssessmentStatement, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local assessmentStatement

  assessmentStatement = AssessmentStatement:create(nil, 1)
  assert(assessmentStatement:getAttributeAssessmentPos(1) ~= nil, "Error!")

  assessmentStatement:addAttributeAssessment(AttributeAssessment:create())
  assert(assessmentStatement:getAttributeAssessmentPos(2) ~= nil, "Error!")

  assessmentStatement = AssessmentStatement:create(nil, 1)
  assessmentStatement:addAttributeAssessment(AttributeAssessment:create{role = "attNodeTest"})
  assert(assessmentStatement:getDescendantByAttribute("role", "attNodeTest") ~= nil, "Error!")

  assessmentStatement = AssessmentStatement:create(nil, 1)
  assessmentStatement:setValueAssessment(ValueAssessment:create())
  assert(assessmentStatement:getValueAssessment() ~= nil, "Error!")

  assessmentStatement:setValueAssessment(ValueAssessment:create{value = "false"})
  assert(assessmentStatement:getDescendantByAttribute("value", "false") ~= nil, "Error!")
end

local function test6()
  local assessmentStatement = AssessmentStatement:create{comparator = "eq"}
  local attributeAssessment1 = AttributeAssessment:create{role = "attNodeTest1"}
  local attributeAssessment2 = AttributeAssessment:create{role = "attNodeTest2"}
  local valueAssessment1 = ValueAssessment:create{value = "false"}
  local valueAssessment2 = ValueAssessment:create{value = "true"}

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

local function test7()
  local atts = {
    comparator = "eq"
  }

  local assessmentStatement = AssessmentStatement:create(atts)

  local nclExp = "<assessmentStatement"
  for attribute, _ in pairs(assessmentStatement:getAttributesTypeMap()) do
    if(assessmentStatement.symbols ~= nil and assessmentStatement.symbols[attribute] ~= nil)then
      nclExp = nclExp.." "..attribute.."=\""..assessmentStatement[attribute]..assessmentStatement.symbols[attribute].."\""
    else
      nclExp = nclExp.." "..attribute.."=\""..tostring(assessmentStatement[attribute]).."\""
    end
  end

  nclExp = nclExp.."/>\n"

  local nclRet = assessmentStatement:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

local function test8()
  local nclExp = ""

  local assessmentStatement = AssessmentStatement:create{comparator = "eq"}
  nclExp = "<assessmentStatement comparator=\"eq\">\n"

  local attributeAssessment = AttributeAssessment:create{role = "attNodeTest1"}
  nclExp = nclExp.." <attributeAssessment role=\"attNodeTest1\"/>\n"

  local valueAssessment = ValueAssessment:create{value = "false"}
  nclExp = nclExp.." <valueAssessment value=\"false\"/>\n"

  nclExp = nclExp.."</assessmentStatement>\n"

  assessmentStatement:addAttributeAssessment(attributeAssessment)
  assessmentStatement:setValueAssessment(valueAssessment)

  local nclRet = assessmentStatement:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()
test7()
test8()