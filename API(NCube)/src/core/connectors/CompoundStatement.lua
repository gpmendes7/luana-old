local NCLElem = require "core/NCLElem"
local AssessmentStatement = require "core/connectors/AssessmentStatement"

local CompoundStatement = NCLElem:extends()

CompoundStatement.nameElem = "compoundStatement"

CompoundStatement.childrenMap = {
  assessmentStatement = {AssessmentStatement, "many"},
  compoundStatement = {CompoundStatement, "many"}
}

CompoundStatement.attributesTypeMap = {
  operator = "string",
  isNegated = "boolean"
}

CompoundStatement.attributesStringValueMap = {
  operator = {"and", "or"}
}

function CompoundStatement:create(attributes, full)
  local compoundStatement = CompoundStatement:new()

  compoundStatement.operator= nil
  compoundStatement.isNegated = nil

  if(attributes ~= nil)then
    compoundStatement:setAttributes(attributes)
  end

  compoundStatement.children = {}
  compoundStatement.assessmentStatements = {}
  compoundStatement.compoundStatements = {}

  if(full ~= nil)then
    compoundStatement:addAssessmentStatement(AssessmentStatement:create())
    compoundStatement:addCompoundStatement(CompoundStatement:create())
  end

  return compoundStatement
end

function CompoundStatement:setOperator(operator)
  self:addAttribute("operator", operator)
end

function CompoundStatement:getOperator()
  return self:getAttribute("operator")
end

function CompoundStatement:setIsNegated(isNegated)
  self:addAttribute("isNegated", isNegated)
end

function CompoundStatement:getIsNegated()
  return self:getAttribute("isNegated")
end

function CompoundStatement:addAssessmentStatement(assessmentStatement)
  self:addChild(assessmentStatement)
  table.insert(self.assessmentStatements, assessmentStatement)
end

function CompoundStatement:getAssessmentStatementPos(p)
  if(p > #self.assessmentStatements)then
    error("Error! compoundStatement element doesn't have a assessmentStatement child in position "..p.."!", 2)
  end

  return self.assessmentStatements[p]
end

function CompoundStatement:setAssessmentStatements(...)
  if(#arg>0)then
    for _, assessmentStatement in ipairs(arg) do
      self:addAssessmentStatement(assessmentStatement)
    end
  end
end

function CompoundStatement:removeAssessmentStatement(assessmentStatement)
  self:removeChild(assessmentStatement)

  for p, as in ipairs(self.assessmentStatements) do
    if(assessmentStatement == as)then
      table.remove(self.assessmentStatements, p)
    end
  end
end

function CompoundStatement:removeAssessmentStatementPos(p)
  self:removeChildPos(p)
  table.remove(self.assessmentStatements, p)
end

function CompoundStatement:addCompoundStatement(compoundStatement)
  self:addChild(compoundStatement)
  table.insert(self.compoundStatements, compoundStatement)
end

function CompoundStatement:getCompoundStatementPos(p)
  if(p > #self.compoundStatements)then
    error("Error! compoundStatement element doesn't have a compoundStatement child in position "..p.."!", 2)
  end

  return self.compoundStatements[p]
end

function CompoundStatement:setCompoundStatements(...)
  if(#arg>0)then
    for _, compoundStatement in ipairs(arg) do
      self:addCompoundStatement(compoundStatement)
    end
  end
end

function CompoundStatement:removeCompoundStatement(compoundStatement)
  self:removeChild(compoundStatement)

  for p, cs in ipairs(self.compoundStatements) do
    if(compoundStatement == cs)then
      table.remove(self.compoundStatements, p)
    end
  end
end

function CompoundStatement:removeCompoundStatementPos(p)
  self:removeChildPos(p)
  table.remove(self.compoundStatements, p)
end

return CompoundStatement
