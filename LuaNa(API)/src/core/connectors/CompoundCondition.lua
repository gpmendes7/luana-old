local NCLElem = require "core/NCLElem"
local SimpleCondition = require "core/connectors/SimpleCondition"
local AssessmentStatement = require "core/connectors/AssessmentStatement"
local CompoundStatement = require "core/connectors/CompoundStatement"

---
-- Implements CompoundCondition Class representing <b>&lt;compoundCondition&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=compoundcondition">
-- http://handbook.ncl.org.br/doku.php?id=compoundcondition</a>
-- 
-- @module CompoundCondition
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local CompoundCondition = require "core/connectors/CompoundCondition" 
local CompoundCondition = NCLElem:extends()

---
-- Name of <b>&lt;compoundCondition&gt;</b> element.
-- 
-- @field [parent=#CompoundCondition] #string nameElem
CompoundCondition.nameElem = "compoundCondition"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;compoundCondition&gt;</b> element.
-- 
-- @field [parent=#CompoundCondition] #table childrenMap
CompoundCondition.childrenMap = {
  simpleCondition = {SimpleCondition, "many"},
  compoundCondition = {CompoundCondition, "many"},
  assessmentStatement = {AssessmentStatement, "many"},
  compoundStatement = {CompoundStatement, "many"}
}

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;compoundCondition&gt;</b> element.
-- 
-- @field [parent=#CompoundCondition] #table attributesTypeMap 
CompoundCondition.attributesTypeMap = {
  operator = "string",
  delay = {"string", "number"}
}

---
-- List containing all possible pre-definied values to string attributes
-- belonging to <b>&lt;compoundCondition&gt;</b> element.
-- 
-- @field [parent=#CompoundCondition] #table attributesStringValueMap
CompoundCondition.attributesStringValueMap = {
  operator = {"and", "or"}
}

---
-- List containing all possible pre-definied symbols to numeric attributes
-- belonging to <b>&lt;compoundCondition&gt;</b> element.
-- 
-- @field [parent=#CompoundCondition] #table attributesSymbolMap 
CompoundCondition.attributesSymbolMap = {
  delay = "s"
}

---
-- Returns a new CompoundCondition object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#CompoundCondition] create
-- @param #table attributes list of attributes to be initialized.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #CompoundCondition new CompoundCondition object created.
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

---
-- Sets a value to `operator` attribute of the 
-- <b>&lt;compoundCondition&gt;</b> element. 
-- 
-- @function [parent=#CompoundCondition] setComparator
-- @param #string operator `operator` attribute of the
-- <b>&lt;compoundCondition&gt;</b> element.
function CompoundCondition:setOperator(operator)
  self:addAttribute("operator", operator)
end

---
-- Returns the value of the `operator` attribute of the 
-- <b>&lt;compoundCondition&gt;</b> element. 
-- 
-- @function [parent=#CompoundCondition] getComparator
-- @return #string `operator` attribute of the <b>&lt;compoundCondition&gt;</b> element.
function CompoundCondition:getOperator()
  return self:getAttribute("operator")
end

---
-- Sets a value to `delay` attribute of the 
-- <b>&lt;compoundCondition&gt;</b> element. 
-- 
-- @function [parent=#CompoundCondition] setDelay
-- @param #stringOrnumber delay `delay` attribute of the
-- <b>&lt;compoundCondition&gt;</b> element.
function CompoundCondition:setDelay(delay)
  self:addAttribute("delay", delay)
end

---
-- Returns the value of the `delay` attribute of the 
-- <b>&lt;compoundCondition&gt;</b> element. 
-- 
-- @function [parent=#CompoundCondition] getDelay
-- @return #stringOrnumber `delay` attribute of the <b>&lt;compoundCondition&gt;</b> element.
function CompoundCondition:getDelay()
  return self:getAttribute("delay")
end

---
-- Adds a <b>&lt;simpleCondition&gt;</b> child element of the 
-- <b>&lt;compoundCondition&gt;</b> element. 
-- 
-- @function [parent=#CompoundCondition] addSimpleCondition
-- @param #SimpleCondition simpleCondition object representing the 
-- <b>&lt;simpleCondition&gt;</b> element.
function CompoundCondition:addSimpleCondition(simpleCondition)
  if((type(simpleCondition) == "table"
    and simpleCondition["getNameElem"] ~= nil
    and simpleCondition:getNameElem() ~= "simpleCondition")
    or (type(simpleCondition) == "table"
    and simpleCondition["getNameElem"] == nil)
    or type(simpleCondition) ~= "table")then
    error("Error! Invalid simpleCondition element!", 2)
  end

  self:addChild(simpleCondition)
  table.insert(self.simpleConditions, simpleCondition)
end

---
-- Returns a <b>&lt;simpleCondition&gt;</b> child element of the 
-- <b>&lt;compoundCondition&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#CompoundCondition] getSimpleConditionPos
-- @param #number p  position of the object representing the <b>&lt;simpleCondition&gt;</b> element.
function CompoundCondition:getSimpleConditionPos(p)
  if(self.simpleConditions == nil)then
    error("Error! compoundCondition element with nil simpleConditions list!", 2)
  elseif(p > #self.simpleConditions)then
    error("Error! compoundCondition element doesn't have a simpleCondition child in position "..p.."!", 2)
  end

  return self.simpleConditions[p]
end

---
-- Adds so many <b>&lt;simpleCondition&gt;</b> child elements of the <b>&lt;compoundCondition&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#CompoundCondition] setSimpleConditions
-- @param #SimpleCondition ... objects representing the <b>&lt;simpleCondition&gt;</b> element.
function CompoundCondition:setSimpleConditions(...)
  if(#arg>0)then
    for _, simpleCondition in ipairs(arg) do
      self:addSimpleCondition(simpleCondition)
    end
  end
end

---
-- Removes a <b>&lt;simpleCondition&gt;</b> child element of the 
-- <b>&lt;compoundCondition&gt;</b> element. 
-- 
-- @function [parent=#CompoundCondition] removeSimpleCondition
-- @param #SimpleCondition simpleCondition object representing the <b>&lt;simpleCondition&gt;</b> element.
function CompoundCondition:removeSimpleCondition(simpleCondition)
  if((type(simpleCondition) == "table"
    and simpleCondition["getNameElem"] ~= nil
    and simpleCondition:getNameElem() ~= "simpleCondition")
    or (type(simpleCondition) == "table"
    and simpleCondition["getNameElem"] == nil)
    or type(simpleCondition) ~= "table")then
    error("Error! Invalid simpleCondition element!", 2)
  elseif(self.children == nil)then
    error("Error! compoundCondition element with nil children list!", 2)
  elseif(self.simpleConditions == nil)then
    error("Error! compoundCondition element with nil simpleConditions list!", 2)
  end

  self:removeChild(simpleCondition)

  for p, sc in ipairs(self.simpleConditions) do
    if(simpleCondition == sc)then
      table.remove(self.simpleConditions, p)
    end
  end
end

---
-- Removes a <b>&lt;simpleCondition&gt;</b> child element of the 
-- <b>&lt;compoundCondition&gt;</b> element in position `p`.
-- 
-- @function [parent=#CompoundCondition] removeSimpleConditionPos
-- @param #number p position of the <b>&lt;simpleCondition&gt;</b> child element.
function CompoundCondition:removeSimpleConditionPos(p)
  if(self.children == nil)then
    error("Error! compoundCondition element with nil children list!", 2)
  elseif(self.simpleConditions == nil)then
    error("Error! compoundCondition element with nil simpleConditions list!", 2)
  elseif(p > #self.children)then
    error("Error! compoundCondition element doesn't have a simpleCondition child in position "..p.."!", 2)
  elseif(p > #self.simpleConditions)then
    error("Error! compoundCondition element doesn't have a simpleCondition child in position "..p.."!", 2)
  end

  self:removeChild(self.simpleConditions[p])
  table.remove(self.simpleConditions, p)
end

---
-- Adds a <b>&lt;compoundCondition&gt;</b> child element of the 
-- <b>&lt;compoundCondition&gt;</b> element. 
-- 
-- @function [parent=#CompoundCondition] addCompoundCondition
-- @param #CompoundCondition compoundCondition object representing the 
-- <b>&lt;compoundCondition&gt;</b> element.
function CompoundCondition:addCompoundCondition(compoundCondition)
  if((type(compoundCondition) == "table"
    and compoundCondition["getNameElem"] ~= nil
    and compoundCondition:getNameElem() ~= "compoundCondition")
    or (type(compoundCondition) == "table"
    and compoundCondition["getNameElem"] == nil)
    or type(compoundCondition) ~= "table")then
    error("Error! Invalid compoundCondition element!", 2)
  end

  self:addChild(compoundCondition)
  table.insert(self.compoundConditions, compoundCondition)
end

---
-- Returns a <b>&lt;compoundCondition&gt;</b> child element of the 
-- <b>&lt;compoundCondition&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#CompoundCondition] getCompoundConditionPos
-- @param #number p  position of the object representing the <b>&lt;compoundCondition&gt;</b> element.
function CompoundCondition:getCompoundConditionPos(p)
  if(self.compoundConditions == nil)then
    error("Error! compoundCondition element with nil compoundConditions list!", 2)
  elseif(p > #self.compoundConditions)then
    error("Error! compoundCondition element doesn't have a compoundCondition child in position "..p.."!", 2)
  end

  return self.compoundConditions[p]
end

---
-- Adds so many <b>&lt;compoundCondition&gt;</b> child elements of the <b>&lt;compoundCondition&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#CompoundCondition] setCompoundConditions
-- @param #CompoundCondition ... objects representing the <b>&lt;compoundCondition&gt;</b> element.
function CompoundCondition:setCompoundConditions(...)
  if(#arg>0)then
    for i, compoundCondition in ipairs(arg) do
      self:addCompoundCondition(compoundCondition)
    end
  end
end

---
-- Removes a <b>&lt;compoundCondition&gt;</b> child element of the 
-- <b>&lt;compoundCondition&gt;</b> element. 
-- 
-- @function [parent=#CompoundCondition] removeCompoundCondition
-- @param #CompoundCondition compoundCondition object representing the <b>&lt;compoundCondition&gt;</b> element.
function CompoundCondition:removeCompoundCondition(compoundCondition)
  if((type(compoundCondition) == "table"
    and compoundCondition["getNameElem"] ~= nil
    and compoundCondition:getNameElem() ~= "compoundCondition")
    or (type(compoundCondition) == "table"
    and compoundCondition["getNameElem"] == nil)
    or type(compoundCondition) ~= "table")then
    error("Error! Invalid compoundCondition element!", 2)
  elseif(self.children == nil)then
    error("Error! compoundCondition element with nil children list!", 2)
  elseif(self.compoundConditions == nil)then
    error("Error! compoundCondition element with nil compoundConditions list!", 2)
  end

  self:removeChild(compoundCondition)

  for p, cc in ipairs(self.compoundConditions) do
    if(compoundCondition == cc)then
      table.remove(self.compoundConditions, p)
    end
  end
end

---
-- Removes a <b>&lt;compoundCondition&gt;</b> child element of the 
-- <b>&lt;compoundCondition&gt;</b> element in position `p`.
-- 
-- @function [parent=#CompoundCondition] removeCompoundConditionPos
-- @param #number p position of the <b>&lt;compoundCondition&gt;</b> child element.
function CompoundCondition:removeCompoundConditionPos(p)
  if(self.children == nil)then
    error("Error! compoundCondition element with nil children list!", 2)
  elseif(self.compoundConditions == nil)then
    error("Error! compoundCondition element with nil compoundConditions list!", 2)
  elseif(p > #self.children)then
    error("Error! compoundCondition element doesn't have a compoundCondition child in position "..p.."!", 2)
  elseif(p > #self.compoundConditions)then
    error("Error! compoundCondition element doesn't have a compoundCondition child in position "..p.."!", 2)
  end

  self:removeChild(self.compoundConditions[p])
  table.remove(self.compoundConditions, p)
end

---
-- Adds a <b>&lt;assessmentStatement&gt;</b> child element of the 
-- <b>&lt;compoundCondition&gt;</b> element. 
-- 
-- @function [parent=#CompoundCondition] addAssessmentStatement
-- @param #AssessmentStatement assessmentStatement object representing the 
-- <b>&lt;assessmentStatement&gt;</b> element.
function CompoundCondition:addAssessmentStatement(assessmentStatement)
  if((type(assessmentStatement) == "table"
    and assessmentStatement["getNameElem"] ~= nil
    and assessmentStatement:getNameElem() ~= "assessmentStatement")
    or (type(assessmentStatement) == "table"
    and assessmentStatement["getNameElem"] == nil)
    or type(assessmentStatement) ~= "table")then
    error("Error! Invalid assessmentStatement element!", 2)
  end

  self:addChild(assessmentStatement)
  table.insert(self.assessmentStatements, assessmentStatement)
end

---
-- Returns a <b>&lt;assessmentStatement&gt;</b> child element of the 
-- <b>&lt;compoundCondition&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#CompoundCondition] getAssessmentStatementPos
-- @param #number p  position of the object representing the <b>&lt;assessmentStatement&gt;</b> element.
function CompoundCondition:getAssessmentStatementPos(p)
  if(self.assessmentStatements == nil)then
    error("Error! compoundCondition element with nil assessmentStatements list!", 2)
  elseif(p > #self.assessmentStatements)then
    error("Error! compoundCondition element doesn't have a assessmentStatement child in position "..p.."!", 2)
  end

  return self.assessmentStatements[p]
end

---
-- Adds so many <b>&lt;assessmentStatement&gt;</b> child elements of the <b>&lt;compoundCondition&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#CompoundCondition] setAssessmentStatements
-- @param #AssessmentStatement ... objects representing the <b>&lt;assessmentStatement&gt;</b> element.
function CompoundCondition:setAssessmentStatements(...)
  if(#arg>0)then
    for _, assessmentStatement in ipairs(arg) do
      self:addAssessmentStatement(assessmentStatement)
    end
  end
end

---
-- Removes a <b>&lt;assessmentStatement&gt;</b> child element of the 
-- <b>&lt;compoundCondition&gt;</b> element. 
-- 
-- @function [parent=#CompoundCondition] removeAssessmentStatement
-- @param #AssessmentStatement assessmentStatement object representing the <b>&lt;assessmentStatement&gt;</b> element.
function CompoundCondition:removeAssessmentStatement(assessmentStatement)
  if((type(assessmentStatement) == "table"
    and assessmentStatement["getNameElem"] ~= nil
    and assessmentStatement:getNameElem() ~= "assessmentStatement")
    or (type(assessmentStatement) == "table"
    and assessmentStatement["getNameElem"] == nil)
    or type(assessmentStatement) ~= "table")then
    error("Error! Invalid assessmentStatement element!", 2)
  elseif(self.children == nil)then
    error("Error! compoundCondition element with nil children list!", 2)
  elseif(self.assessmentStatements == nil)then
    error("Error! compoundCondition element with nil assessmentStatements list!", 2)
  end

  self:removeChild(assessmentStatement)

  for p, as in ipairs(self.assessmentStatements) do
    if(assessmentStatement == as)then
      table.remove(self.assessmentStatements, p)
    end
  end
end

---
-- Removes a <b>&lt;assessmentStatement&gt;</b> child element of the 
-- <b>&lt;compoundCondition&gt;</b> element in position `p`.
-- 
-- @function [parent=#CompoundCondition] removeAssessmentStatementPos
-- @param #number p position of the <b>&lt;assessmentStatement&gt;</b> child element.
function CompoundCondition:removeAssessmentStatementPos(p)
  if(self.children == nil)then
    error("Error! compoundCondition element with nil children list!", 2)
  elseif(self.assessmentStatements == nil)then
    error("Error! compoundCondition element with nil assessmentStatements list!", 2)
  elseif(p > #self.children)then
    error("Error! compoundCondition element doesn't have a assessmentStatement child in position "..p.."!", 2)
  elseif(p > #self.assessmentStatements)then
    error("Error! compoundCondition element doesn't have a assessmentStatement child in position "..p.."!", 2)
  end

  self:removeChild(self.assessmentStatements[p])
  table.remove(self.assessmentStatements, p)
end

---
-- Adds a <b>&lt;compoundStatement&gt;</b> child element of the 
-- <b>&lt;compoundCondition&gt;</b> element. 
-- 
-- @function [parent=#CompoundCondition] addCompoundStatement
-- @param #CompoundStatement compoundStatement object representing the 
-- <b>&lt;compoundStatement&gt;</b> element.
function CompoundCondition:addCompoundStatement(compoundStatement)
  if((type(compoundStatement) == "table"
    and compoundStatement["getNameElem"] ~= nil
    and compoundStatement:getNameElem() ~= "compoundStatement")
    or (type(compoundStatement) == "table"
    and compoundStatement["getNameElem"] == nil)
    or type(compoundStatement) ~= "table")then
    error("Error! Invalid compoundStatement element!", 2)
  end

  self:addChild(compoundStatement)
  table.insert(self.compoundStatements, compoundStatement)
end

---
-- Returns a <b>&lt;compoundStatement&gt;</b> child element of the 
-- <b>&lt;compoundCondition&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#CompoundCondition] getCompoundStatementPos
-- @param #number p  position of the object representing the <b>&lt;compoundStatement&gt;</b> element.
function CompoundCondition:getCompoundStatementPos(p)
  if(self.compoundStatements == nil)then
    error("Error! compoundCondition element with nil compoundStatements list!", 2)
  elseif(p > #self.compoundStatements)then
    error("Error! compoundCondition element doesn't have a compoundStatement child in position "..p.."!", 2)
  end

  return self.compoundStatements[p]
end

---
-- Adds so many <b>&lt;compoundStatement&gt;</b> child elements of the <b>&lt;compoundCondition&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#CompoundCondition] setCompoundStatements
-- @param #CompoundStatement ... objects representing the <b>&lt;compoundStatement&gt;</b> element.
function CompoundCondition:setCompoundStatements(...)
  if(#arg>0)then
    for _, compoundStatement in ipairs(arg) do
      self:addCompoundStatement(compoundStatement)
    end
  end
end

---
-- Removes a <b>&lt;compoundStatement&gt;</b> child element of the 
-- <b>&lt;compoundCondition&gt;</b> element. 
-- 
-- @function [parent=#CompoundCondition] removeCompoundStatement
-- @param #CompoundStatement compoundStatement object representing the <b>&lt;compoundStatement&gt;</b> element.
function CompoundCondition:removeCompoundStatement(compoundStatement)
  if((type(compoundStatement) == "table"
    and compoundStatement["getNameElem"] ~= nil
    and compoundStatement:getNameElem() ~= "compoundStatement")
    or (type(compoundStatement) == "table"
    and compoundStatement["getNameElem"] == nil)
    or type(compoundStatement) ~= "table")then
    error("Error! Invalid compoundStatement element!", 2)
  elseif(self.children == nil)then
    error("Error! compoundCondition element with nil children list!", 2)
  elseif(self.compoundStatements == nil)then
    error("Error! compoundCondition element with nil compoundStatements list!", 2)
  end

  self:removeChild(compoundStatement)

  for p, cs in ipairs(self.compoundStatements) do
    if(compoundStatement == cs)then
      table.remove(self.compoundStatements, p)
    end
  end
end

---
-- Removes a <b>&lt;compoundStatement&gt;</b> child element of the 
-- <b>&lt;compoundCondition&gt;</b> element in position `p`.
-- 
-- @function [parent=#CompoundCondition] removeCompoundStatementPos
-- @param #number p position of the <b>&lt;compoundStatement&gt;</b> child element.
function CompoundCondition:removeCompoundStatementPos(p)
  if(self.children == nil)then
    error("Error! compoundCondition element with nil children list!", 2)
  elseif(self.compoundStatements == nil)then
    error("Error! compoundCondition element with nil compoundStatements list!", 2)
  elseif(p > #self.children)then
    error("Error! compoundCondition element doesn't have a compoundStatement child in position "..p.."!", 2)
  elseif(p > #self.compoundStatements)then
    error("Error! compoundCondition element doesn't have a compoundStatement child in position "..p.."!", 2)
  end

  self:removeChild(self.compoundStatements[p])
  table.remove(self.compoundStatements, p)
end

return CompoundCondition