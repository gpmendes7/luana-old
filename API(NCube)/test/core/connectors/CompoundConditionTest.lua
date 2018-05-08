local CompoundCondition = require "core/connectors/CompoundCondition"
local SimpleCondition = require "core/connectors/SimpleCondition"
local AssessmentStatement = require "core/connectors/AssessmentStatement"
local CompoundStatement = require "core/connectors/CompoundStatement"

local function test1()
  local compoundCondition = CompoundCondition:create()

  assert(compoundCondition ~= nil, "Error!")
  assert(compoundCondition:getOperator() == nil, "Error!")
  assert(compoundCondition:getDelay() == nil, "Error!")
end

local function test2()
  local atts = {
    operator = "and",
    delay = 10
  }

  local compoundCondition = CompoundCondition:create(atts)
  
  assert(compoundCondition:getOperator() == "and", "Error!")
  assert(compoundCondition:getDelay() == 10, "Error!")
end

local function test3()
  local compoundCondition = CompoundCondition:create()

  compoundCondition:setOperator("and")
  compoundCondition:setDelay(10)

  assert(compoundCondition:getOperator() == "and", "Error!")
  assert(compoundCondition:getDelay() == 10, "Error!")
end

local function test4()
  local compoundCondition = CompoundCondition:create()
  local status, err

  status, err = pcall(compoundCondition["setDelay"], CompoundCondition, nil)
  assert(not(status), "Error!")

  status, err = pcall(compoundCondition["setDelay"], CompoundCondition, {})
  assert(not(status), "Error!")

  status, err = pcall(compoundCondition["setDelay"], CompoundCondition, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local compoundCondition = CompoundCondition:create(nil, 1)
  
  assert(compoundCondition:getAssessmentStatementPos(1) ~= nil, "Error!")
  assert(compoundCondition:getSimpleConditionPos(1) ~= nil, "Error!")
  assert(compoundCondition:getCompoundStatementPos(1) ~= nil, "Error!")
  assert(compoundCondition:getCompoundConditionPos(1) ~= nil, "Error!")

  compoundCondition:addAssessmentStatement(AssessmentStatement:create())
  assert(compoundCondition:getAssessmentStatementPos(2) ~= nil, "Error!")

  compoundCondition:addSimpleCondition(SimpleCondition:create())
  assert(compoundCondition:getSimpleConditionPos(2) ~= nil, "Error!")

  compoundCondition:addCompoundStatement(CompoundStatement:create())
  assert(compoundCondition:getCompoundStatementPos(2) ~= nil, "Error!")

  compoundCondition:addCompoundCondition(CompoundCondition:create())
  assert(compoundCondition:getCompoundConditionPos(2) ~= nil, "Error!")

  compoundCondition = CompoundCondition:create()
  compoundCondition:addAssessmentStatement(AssessmentStatement:create{comparator = "eq"})
  assert(compoundCondition:getDescendantByAttribute("comparator", "eq") ~= nil, "Error!")

  compoundCondition = CompoundCondition:create()
  compoundCondition:addSimpleCondition(SimpleCondition:create{role = "onSelection"})
  assert(compoundCondition:getDescendantByAttribute("role", "onSelection") ~= nil, "Error!")

  compoundCondition = CompoundCondition:create()
  compoundCondition:addCompoundStatement(CompoundStatement:create{operator = "and"})
  assert(compoundCondition:getDescendantByAttribute("operator", "and") ~= nil, "Error!")

  compoundCondition = CompoundCondition:create()
  compoundCondition:addCompoundCondition(CompoundCondition:create{operator = "or"})
  assert(compoundCondition:getDescendantByAttribute("operator", "or") ~= nil, "Error!")
end

local function test6()
  local compoundCondition1 = CompoundCondition:create{operator = "and"}
  local simpleCondition = SimpleCondition:create{role = "onSelection"}
  local assessmentStatement = AssessmentStatement:create{comparator = "eq"}
  local compoundStatement = CompoundStatement:create{operator = "and"}
  local compoundCondition2 = CompoundCondition:create{operator = "or"}

  compoundCondition1:addSimpleCondition(simpleCondition)
  assert(compoundCondition1:getDescendantByAttribute("role", "onSelection") ~= nil, "Error!")

  compoundCondition1:removeSimpleCondition(simpleCondition)
  assert(compoundCondition1:getDescendantByAttribute("role", "onSelection") == nil, "Error!")

  compoundCondition1:addSimpleCondition(simpleCondition)
  compoundCondition1:removeSimpleConditionPos(1)
  assert(compoundCondition1:getDescendantByAttribute("role", "onSelection") == nil, "Error!")

  compoundCondition1:addAssessmentStatement(assessmentStatement)
  assert(compoundCondition1:getDescendantByAttribute("comparator", "eq") ~= nil, "Error!")

  compoundCondition1:removeAssessmentStatement(assessmentStatement)
  assert(compoundCondition1:getDescendantByAttribute("comparator", "eq") == nil, "Error!")

  compoundCondition1:addAssessmentStatement(assessmentStatement)
  compoundCondition1:removeAssessmentStatementPos(1)
  assert(compoundCondition1:getDescendantByAttribute("comparator", "eq") == nil, "Error!")

  compoundCondition1:addCompoundStatement(compoundStatement)
  assert(compoundCondition1:getDescendantByAttribute("operator", "and") ~= nil, "Error!")

  compoundCondition1:removeCompoundStatement(compoundStatement)
  assert(compoundCondition1:getDescendantByAttribute("operator", "and") == nil, "Error!")

  compoundCondition1:addCompoundStatement(compoundStatement)
  compoundCondition1:removeCompoundStatementPos(1)
  assert(compoundCondition1:getDescendantByAttribute("operator", "and") == nil, "Error!")

  compoundCondition1:addCompoundCondition(compoundCondition2)
  assert(compoundCondition1:getDescendantByAttribute("operator", "or") ~= nil, "Error!")

  compoundCondition1:removeCompoundCondition(compoundCondition2)
  assert(compoundCondition1:getDescendantByAttribute("operator", "or") == nil, "Error!")

  compoundCondition1:addCompoundCondition(compoundCondition2)
  compoundCondition1:removeCompoundConditionPos(1)
  assert(compoundCondition1:getDescendantByAttribute("operator", "or") == nil, "Error!")
end

local function test7()
  local atts = {
    operator = "and",
    delay = 10
  }

  local compoundCondition = CompoundCondition:create(atts)
  
  compoundCondition.symbols["delay"] = "s"

  local nclExp = "<compoundCondition"
  for attribute, typeAtt in pairs(compoundCondition:getAttributesTypeMap()) do
    if(compoundCondition.symbols ~= nil and compoundCondition.symbols[attribute] ~= nil)then
      nclExp = nclExp.." "..attribute.."=\""..compoundCondition[attribute]..compoundCondition.symbols[attribute].."\""
    else
      nclExp = nclExp.." "..attribute.."=\""..tostring(compoundCondition[attribute]).."\""
    end
  end

  nclExp = nclExp.."/>\n"

  local nclRet = compoundCondition:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

local function test7()
  local compoundCondition1 = CompoundCondition:create{operator = "and"}
  local nclExp = "<compoundCondition operator=\"and\">\n"

  local simpleCondition = SimpleCondition:create{role = "onSelection"}
  nclExp = nclExp.." <simpleCondition role=\"onSelection\"/>\n"

  local compoundCondition2 = CompoundCondition:create{operator = "or"}
  nclExp = nclExp.." <compoundCondition operator=\"or\"/>\n"

  local assessmentStatement = AssessmentStatement:create{comparator = "eq"}
  nclExp = nclExp.." <assessmentStatement comparator=\"eq\"/>\n"

  local compoundStatement = CompoundStatement:create{operator = "and"}
  nclExp = nclExp.." <compoundStatement operator=\"and\"/>\n"

  nclExp = nclExp.."</compoundCondition>\n"

  compoundCondition1:addSimpleCondition(simpleCondition)
  compoundCondition1:addCompoundCondition(compoundCondition2)
  compoundCondition1:addAssessmentStatement(assessmentStatement)
  compoundCondition1:addCompoundStatement(compoundStatement)

  local nclRet = compoundCondition1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()
test7()