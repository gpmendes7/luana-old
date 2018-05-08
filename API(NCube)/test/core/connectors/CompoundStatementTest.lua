local CompoundStatement = require "core/connectors/CompoundStatement"
local AssessmentStatement = require "core/connectors/AssessmentStatement"

local function test1()
  local compoundStatement = CompoundStatement:create()

  assert(compoundStatement ~= nil, "Error!")
  assert(compoundStatement:getOperator() == nil, "Error!")
  assert(compoundStatement:getIsNegated() == nil, "Error!")
end

local function test2()
  local atts = {
    operator = "and",
    isNegated = true
  }

  local compoundStatement = CompoundStatement:create(atts)

  assert(compoundStatement:getOperator() == "and", "Error!")
  assert(compoundStatement:getIsNegated() == true, "Error!")
end

local function test3()
  local compoundStatement = CompoundStatement:create()

  compoundStatement:setOperator("and")
  compoundStatement:setIsNegated(true)

  assert(compoundStatement:getOperator() == "and", "Error!")
  assert(compoundStatement:getIsNegated() == true, "Error!")
end

local function test4()
  local compoundStatement = CompoundStatement:create()
  local status, err
  
  status, err = pcall(compoundStatement["setIsNegated"], CompoundStatement, "invalid")
  assert(not(status), "Error!")
  
  status, err = pcall(compoundStatement["setIsNegated"], CompoundStatement, nil)
  assert(not(status), "Error!")
   
  status, err = pcall(compoundStatement["setIsNegated"], CompoundStatement, 999999)
  assert(not(status), "Error!")

  status, err = pcall(compoundStatement["setIsNegated"], CompoundStatement, {})
  assert(not(status), "Error!")

  status, err = pcall(compoundStatement["setIsNegated"], CompoundStatement, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local compoundStatement

  compoundStatement = CompoundStatement:create(nil, 1)
  assert(compoundStatement:getAssessmentStatementPos(1) ~= nil, "Error!")

  compoundStatement:addAssessmentStatement(AssessmentStatement:create())
  assert(compoundStatement:getAssessmentStatementPos(2) ~= nil, "Error!")

  compoundStatement:addCompoundStatement(CompoundStatement:create())
  assert(compoundStatement:getCompoundStatementPos(2) ~= nil, "Error!")

  compoundStatement = CompoundStatement:create()
  compoundStatement:addAssessmentStatement(AssessmentStatement:create{comparator = "eq"})
  assert(compoundStatement:getDescendantByAttribute("comparator", "eq") ~= nil, "Error!")

  compoundStatement = CompoundStatement:create()
  compoundStatement:addCompoundStatement(CompoundStatement:create{operator = "and"})
  assert(compoundStatement:getDescendantByAttribute("operator", "and") ~= nil, "Error!")
end

local function test6()
  local compoundStatement1 = CompoundStatement:create{operator = "and"}
  local assessmentStatement = AssessmentStatement:create{comparator = "eq"}
  local compoundStatement2 = CompoundStatement:create{operator = "or"}

  compoundStatement1:addAssessmentStatement(assessmentStatement)
  assert(compoundStatement1:getDescendantByAttribute("comparator", "eq") ~= nil, "Error!")

  compoundStatement1:removeAssessmentStatement(assessmentStatement)
  assert(compoundStatement1:getDescendantByAttribute("comparator", "eq") == nil, "Error!")

  compoundStatement1:addAssessmentStatement(assessmentStatement)
  compoundStatement1:removeAssessmentStatementPos(1)
  assert(compoundStatement1:getDescendantByAttribute("comparator", "eq") == nil, "Error!")

  compoundStatement1:addCompoundStatement(compoundStatement2)
  assert(compoundStatement1:getDescendantByAttribute("operator", "or") ~= nil, "Error!")

  compoundStatement1:removeCompoundStatement(compoundStatement2)
  assert(compoundStatement1:getDescendantByAttribute("operator", "or") == nil, "Error!")

  compoundStatement1:addCompoundStatement(compoundStatement2)
  compoundStatement1:removeCompoundStatementPos(1)
  assert(compoundStatement1:getDescendantByAttribute("operator", "or") == nil, "Error!")
end

local function test7()
  local atts = {
    operator = "and",
    isNegated = true
  }

  local compoundStatement = CompoundStatement:create(atts)

  local nclExp = "<compoundStatement"
  for attribute, _ in pairs(compoundStatement:getAttributesTypeMap()) do
    if(compoundStatement.symbols ~= nil and compoundStatement.symbols[attribute] ~= nil)then
      nclExp = nclExp.." "..attribute.."=\""..compoundStatement[attribute]..compoundStatement.symbols[attribute].."\""
    else
      nclExp = nclExp.." "..attribute.."=\""..tostring(compoundStatement[attribute]).."\""
    end
  end

  nclExp = nclExp.."/>\n"

  local nclRet = compoundStatement:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

local function test8()
  local compoundStatement = CompoundStatement:create{operator = "and"}
  local nclExp = "<compoundStatement operator=\"and\">\n"

  local assessmentStatement = AssessmentStatement:create{comparator = "eq"}
  nclExp = nclExp.." <assessmentStatement comparator=\"eq\"/>\n"

  nclExp = nclExp.."</compoundStatement>\n"

  compoundStatement:addAssessmentStatement(assessmentStatement)

  local nclRet = compoundStatement:table2Ncl(0)

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