local NCLElem = require "core/NCLElem"
local SimpleCondition = require "core/connectors/SimpleCondition"
local AssessmentStatement = require "core/connectors/AssessmentStatement"
local CompoundStatement = require "core/connectors/CompoundStatement"

local CompoundCondition = NCLElem:extends()

CompoundCondition.nameElem = "compoundCondition"

CompoundCondition.childrenMap = {
  simpleCondition = {SimpleCondition, "many"},
  compoundCondition = {CompoundCondition, "many"},
  assessmentStatement = {AssessmentStatement, "many"},
  compoundStatement = {CompoundStatement, "many"}
}

CompoundCondition.attributesTypeMap = {
  operator = "string",
  delay = {"string", "number"}
}

CompoundCondition.attributesStringValueMap = {
  operator = {"and", "or"}
}

CompoundCondition.attributesSymbolMap = {
  delay = "s"
}

function CompoundCondition:create(attributes, full)
  local compoundCondition = CompoundCondition:new()

  compoundCondition.operator = nil
  compoundCondition.delay = nil

  if(attributes ~= nil)then
    compoundCondition:setAttributes(attributes)
  end

  compoundCondition.children = {}
  compoundCondition.simpleConditions = {}
  compoundCondition.compoundConditions = {}
  compoundCondition.assessmentStatements = {}
  compoundCondition.compoundStatements = {}
  
  compoundCondition.symbols = {}

  if(full ~= nil)then
    compoundCondition:addSimpleCondition(SimpleCondition:create())
    compoundCondition:addCompoundCondition(CompoundCondition:create())
    compoundCondition:addAssessmentStatement(AssessmentStatement:create())
    compoundCondition:addCompoundStatement(CompoundStatement:create())
  end

  return compoundCondition
end

function CompoundCondition:setOperator(operator)
  self:addAttribute("operator", operator)
end

function CompoundCondition:getOperator()
  return self:getAttribute("operator")
end

function CompoundCondition:setDelay(delay, symbol)
  self:addAttribute("delay", delay, symbol)
end

function CompoundCondition:getDelay()
  return self:getAttribute("delay")
end

function CompoundCondition:addSimpleCondition(simpleCondition)
  if((type(simpleCondition) == "table"
    and simpleCondition["getNameElem"] ~= nil
    and simpleCondition:getNameElem() ~= "simpleCondition")
    or type(simpleCondition) ~= "table")then
    error("Error! Invalid simpleCondition element!")
  end
  
  self:addChild(simpleCondition)
  table.insert(self.simpleConditions, simpleCondition)
end

function CompoundCondition:getSimpleConditionPos(p)
  if(p > #self.simpleConditions)then
    error("Error! compoundCondition element doesn't have a simpleCondition child in position "..p.."!", 2)
  end

  return self.simpleConditions[p]
end

function CompoundCondition:setSimpleConditions(...)
  if(#arg>0)then
    for _, simpleCondition in ipairs(arg) do
      self:addSimpleCondition(simpleCondition)
    end
  end
end

function CompoundCondition:removeSimpleCondition(simpleCondition)
  if((type(simpleCondition) == "table"
    and simpleCondition["getNameElem"] ~= nil
    and simpleCondition:getNameElem() ~= "simpleCondition")
    or type(simpleCondition) ~= "table")then
    error("Error! Invalid simpleCondition element!")
  end
  
  self:removeChild(simpleCondition)

  for p, sc in ipairs(self.simpleConditions) do
    if(simpleCondition == sc)then
      table.remove(self.simpleConditions, p)
    end
  end
end

function CompoundCondition:removeSimpleConditionPos(p)
  self:removeChildPos(p)
  table.remove(self.simpleConditions, p)
end

function CompoundCondition:addCompoundCondition(compoundCondition)
  if((type(compoundCondition) == "table"
    and compoundCondition["getNameElem"] ~= nil
    and compoundCondition:getNameElem() ~= "compoundCondition")
    or type(compoundCondition) ~= "table")then
    error("Error! Invalid compoundCondition element!")
  end
  
  self:addChild(compoundCondition)
  table.insert(self.compoundConditions, compoundCondition)
end

function CompoundCondition:getCompoundConditionPos(p)
  if(p > #self.compoundConditions)then
    error("Error! compoundCondition element doesn't have a compoundCondition child in position "..p.."!", 2)
  end

  return self.compoundConditions[p]
end

function CompoundCondition:setCompoundConditions(...)
  if(#arg>0)then
    for i, compoundCondition in ipairs(arg) do
      self:addCompoundCondition(compoundCondition)
    end
  end
end

function CompoundCondition:removeCompoundCondition(compoundCondition)
  if((type(compoundCondition) == "table"
    and compoundCondition["getNameElem"] ~= nil
    and compoundCondition:getNameElem() ~= "compoundCondition")
    or type(compoundCondition) ~= "table")then
    error("Error! Invalid compoundCondition element!")
  end
  
  self:removeChild(compoundCondition)

  for p, cc in ipairs(self.compoundConditions) do
    if(compoundCondition == cc)then
      table.remove(self.compoundConditions, p)
    end
  end
end

function CompoundCondition:removeCompoundConditionPos(p)
  self:removeChildPos(p)
  table.remove(self.compoundConditions, p)
end

function CompoundCondition:addAssessmentStatement(assessmentStatement)
  if((type(assessmentStatement) == "table"
    and assessmentStatement["getNameElem"] ~= nil
    and assessmentStatement:getNameElem() ~= "assessmentStatement")
    or type(assessmentStatement) ~= "table")then
    error("Error! Invalid assessmentStatement element!")
  end
  
  self:addChild(assessmentStatement)
  table.insert(self.assessmentStatements, assessmentStatement)
end

function CompoundCondition:getAssessmentStatementPos(p)
  if(p > #self.assessmentStatements)then
    error("Error! compoundCondition element doesn't have a assessmentStatement child in position "..p.."!", 2)
  end

  return self.assessmentStatements[p]
end

function CompoundCondition:setAssessmentStatements(...)
  if(#arg>0)then
    for _, assessmentStatement in ipairs(arg) do
      self:addAssessmentStatement(assessmentStatement)
    end
  end
end

function CompoundCondition:removeAssessmentStatement(assessmentStatement)
  if((type(assessmentStatement) == "table"
    and assessmentStatement["getNameElem"] ~= nil
    and assessmentStatement:getNameElem() ~= "assessmentStatement")
    or type(assessmentStatement) ~= "table")then
    error("Error! Invalid assessmentStatement element!")
  end
  
  self:removeChild(assessmentStatement)

  for p, as in ipairs(self.assessmentStatements) do
    if(assessmentStatement == as)then
      table.remove(self.assessmentStatements, p)
    end
  end
end

function CompoundCondition:removeAssessmentStatementPos(p)
  self:removeChildPos(p)
  table.remove(self.assessmentStatements, p)
end

function CompoundCondition:addCompoundStatement(compoundStatement)
  if((type(compoundStatement) == "table"
    and compoundStatement["getNameElem"] ~= nil
    and compoundStatement:getNameElem() ~= "compoundStatement")
    or type(compoundStatement) ~= "table")then
    error("Error! Invalid compoundStatement element!")
  end
  
  self:addChild(compoundStatement)
  table.insert(self.compoundStatements, compoundStatement)
end

function CompoundCondition:getCompoundStatementPos(p)
  if(p > #self.compoundStatements)then
    error("Error! compoundCondition element doesn't have a compoundStatement child in position "..p.."!", 2)
  end

  return self.compoundStatements[p]
end

function CompoundCondition:setCompoundStatements(...)
  if(#arg>0)then
    for _, compoundStatement in ipairs(arg) do
      self:addCompoundStatement(compoundStatement)
    end
  end
end

function CompoundCondition:removeCompoundStatement(compoundStatement)
  if((type(compoundStatement) == "table"
    and compoundStatement["getNameElem"] ~= nil
    and compoundStatement:getNameElem() ~= "compoundStatement")
    or type(compoundStatement) ~= "table")then
    error("Error! Invalid compoundStatement element!")
  end
  
  self:removeChild(compoundStatement)

  for p, cs in ipairs(self.compoundStatements) do
    if(compoundStatement == cs)then
      table.remove(self.compoundStatements, p)
    end
  end
end

function CompoundCondition:removeCompoundStatementPos(p)
  self:removeChildPos(p)
  table.remove(self.compoundStatements, p)
end

return CompoundCondition