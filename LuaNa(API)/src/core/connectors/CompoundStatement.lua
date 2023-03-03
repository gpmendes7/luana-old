local NCLElem = require "LuaNa(API)/src/core/NCLElem"
local AssessmentStatement = require "LuaNa(API)/src/core/connectors/AssessmentStatement"

---
-- Implements CompoundStatement Class representing <b>&lt;compoundStatement&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=compoundstatement">
-- http://handbook.ncl.org.br/doku.php?id=compoundstatement</a>
-- 
-- @module CompoundStatement
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local CompoundStatement = require "core/connectors/CompoundStatement" 
local CompoundStatement = NCLElem:extends()

---
-- Name of <b>&lt;compoundStatement&gt;</b> element.
-- 
-- @field [parent=#CompoundStatement] #string nameElem
CompoundStatement.nameElem = "compoundStatement"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;compoundStatement&gt;</b> element.
-- 
-- @field [parent=#CompoundStatement] #table childrenMap
CompoundStatement.childrenMap = {
  assessmentStatement = {AssessmentStatement, "many"},
  compoundStatement = {CompoundStatement, "many"}
}

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;compoundStatement&gt;</b> element.
-- 
-- @field [parent=#CompoundStatement] #table attributesTypeMap 
CompoundStatement.attributesTypeMap = {
  operator = "string",
  isNegated = "boolean"
}

---
-- List containing all possible pre-definied values to string attributes
-- belonging to <b>&lt;compoundStatement&gt;</b> element.
-- 
-- @field [parent=#CompoundStatement] #table attributesStringValueMap
CompoundStatement.attributesStringValueMap = {
  operator = {"and", "or"}
}

---
-- Returns a new CompoundStatement object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#CompoundStatement] create
-- @param #table attributes list of attributes to be initialized.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #CompoundStatement new CompoundStatement object created.
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

---
-- Sets a value to `operator` attribute of the 
-- <b>&lt;compoundStatement&gt;</b> element. 
-- 
-- @function [parent=#CompoundStatement] setOperator
-- @param #string operator `operator` attribute of the
-- <b>&lt;compoundStatement&gt;</b> element.
function CompoundStatement:setOperator(operator)
  self:addAttribute("operator", operator)
end

---
-- Returns the value of the `operator` attribute of the 
-- <b>&lt;compoundStatement&gt;</b> element. 
-- 
-- @function [parent=#CompoundStatement] getComparator
-- @return #string `operator` attribute of the <b>&lt;compoundStatement&gt;</b> element.
function CompoundStatement:getOperator()
  return self:getAttribute("operator")
end

---
-- Sets a value to `isNegated` attribute of the 
-- <b>&lt;compoundStatement&gt;</b> element. 
-- 
-- @function [parent=#CompoundStatement] setIsNegated
-- @param #boolean operator `isNegated` attribute of the
-- <b>&lt;compoundStatement&gt;</b> element.
function CompoundStatement:setIsNegated(isNegated)
  self:addAttribute("isNegated", isNegated)
end

---
-- Returns the value of the `isNegated` attribute of the 
-- <b>&lt;compoundStatement&gt;</b> element. 
-- 
-- @function [parent=#CompoundStatement] getIsNegated
-- @return #boolean `isNegated` attribute of the <b>&lt;compoundStatement&gt;</b> element.
function CompoundStatement:getIsNegated()
  return self:getAttribute("isNegated")
end

---
-- Adds a <b>&lt;assessmentStatement&gt;</b> child element of the 
-- <b>&lt;compoundStatement&gt;</b> element. 
-- 
-- @function [parent=#CompoundStatement] addAssessmentStatement
-- @param #AssessmentStatement assessmentStatement object representing the 
-- <b>&lt;assessmentStatement&gt;</b> element.
function CompoundStatement:addAssessmentStatement(assessmentStatement)
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
-- <b>&lt;compoundStatement&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#CompoundStatement] getAssessmentStatementPos
-- @param #number p  position of the object representing the <b>&lt;assessmentStatement&gt;</b> element.
function CompoundStatement:getAssessmentStatementPos(p)
  if(self.assessmentStatements == nil)then
    error("Error! compoundStatement element with nil assessmentStatements list!", 2)
  elseif(p > #self.assessmentStatements)then
    error("Error! compoundStatement element doesn't have a assessmentStatement child in position "..p.."!", 2)
  end

  return self.assessmentStatements[p]
end

---
-- Adds so many <b>&lt;assessmentStatement&gt;</b> child elements of the <b>&lt;compoundStatement&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#CompoundStatement] setAssessmentStatements
-- @param #AssessmentStatement ... objects representing the <b>&lt;assessmentStatement&gt;</b> element.
function CompoundStatement:setAssessmentStatements(...)
  if(#arg>0)then
    for _, assessmentStatement in ipairs(arg) do
      self:addAssessmentStatement(assessmentStatement)
    end
  end
end

---
-- Removes a <b>&lt;assessmentStatement&gt;</b> child element of the 
-- <b>&lt;compoundStatement&gt;</b> element. 
-- 
-- @function [parent=#CompoundStatement] removeAssessmentStatement
-- @param #AssessmentStatement assessmentStatement object representing the <b>&lt;assessmentStatement&gt;</b> element.
function CompoundStatement:removeAssessmentStatement(assessmentStatement)
  if((type(assessmentStatement) == "table"
    and assessmentStatement["getNameElem"] ~= nil
    and assessmentStatement:getNameElem() ~= "assessmentStatement")
    or (type(assessmentStatement) == "table"
    and assessmentStatement["getNameElem"] == nil)
    or type(assessmentStatement) ~= "table")then
    error("Error! Invalid assessmentStatement element!", 2)
  elseif(self.children == nil)then
    error("Error! compoundStatement element with nil children list!", 2)
  elseif(self.assessmentStatements == nil)then
    error("Error! compoundStatement element with nil assessmentStatements list!", 2)
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
-- <b>&lt;compoundStatement&gt;</b> element in position `p`.
-- 
-- @function [parent=#CompoundStatement] removeAssessmentStatementPos
-- @param #number p position of the <b>&lt;assessmentStatement&gt;</b> child element.
function CompoundStatement:removeAssessmentStatementPos(p)
  if(self.children == nil)then
    error("Error! compoundStatement element with nil children list!", 2)
  elseif(self.assessmentStatements == nil)then
    error("Error! compoundStatement element with nil assessmentStatements list!", 2)
  elseif(p > #self.children)then
    error("Error! compoundStatement element doesn't have a assessmentStatement child in position "..p.."!", 2)
  elseif(p > #self.assessmentStatements)then
    error("Error! compoundStatement element doesn't have a assessmentStatement child in position "..p.."!", 2)
  end

  self:removeChild(self.assessmentStatements[p])
  table.remove(self.assessmentStatements, p)
end

---
-- Adds a <b>&lt;compoundStatement&gt;</b> child element of the 
-- <b>&lt;compoundStatement&gt;</b> element. 
-- 
-- @function [parent=#CompoundStatement] addCompoundStatement
-- @param #CompoundStatement compoundStatement object representing the 
-- <b>&lt;compoundStatement&gt;</b> element.
function CompoundStatement:addCompoundStatement(compoundStatement)
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
-- <b>&lt;compoundStatement&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#CompoundStatement] getCompoundStatementPos
-- @param #number p  position of the object representing the <b>&lt;compoundStatement&gt;</b> element.
function CompoundStatement:getCompoundStatementPos(p)
  if(self.compoundStatements == nil)then
    error("Error! compoundStatement element with nil compoundStatements list!", 2)
  elseif(p > #self.compoundStatements)then
    error("Error! compoundStatement element doesn't have a compoundStatement child in position "..p.."!", 2)
  end

  return self.compoundStatements[p]
end

---
-- Adds so many <b>&lt;compoundStatement&gt;</b> child elements of the <b>&lt;compoundStatement&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#CompoundStatement] setCompoundStatements
-- @param #CompoundStatement ... objects representing the <b>&lt;compoundStatement&gt;</b> element.
function CompoundStatement:setCompoundStatements(...)
  if(#arg>0)then
    for _, compoundStatement in ipairs(arg) do
      self:addCompoundStatement(compoundStatement)
    end
  end
end

---
-- Removes a <b>&lt;compoundStatement&gt;</b> child element of the 
-- <b>&lt;compoundStatement&gt;</b> element. 
-- 
-- @function [parent=#CompoundStatement] removeCompoundStatement
-- @param #CompoundStatement compoundStatement object representing the <b>&lt;compoundStatement&gt;</b> element.
function CompoundStatement:removeCompoundStatement(compoundStatement)
  if((type(compoundStatement) == "table"
    and compoundStatement["getNameElem"] ~= nil
    and compoundStatement:getNameElem() ~= "compoundStatement")
    or (type(compoundStatement) == "table"
    and compoundStatement["getNameElem"] == nil)
    or type(compoundStatement) ~= "table")then
    error("Error! Invalid compoundStatement element!", 2)
  elseif(self.children == nil)then
    error("Error! compoundStatement element with nil children list!", 2)
  elseif(self.compoundStatements == nil)then
    error("Error! compoundStatement element with nil compoundStatements list!", 2)
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
-- <b>&lt;compoundStatement&gt;</b> element in position `p`.
-- 
-- @function [parent=#CompoundStatement] removeCompoundStatementPos
-- @param #number p position of the <b>&lt;compoundStatement&gt;</b> child element.
function CompoundStatement:removeCompoundStatementPos(p)
  if(self.children == nil)then
    error("Error! compoundStatement element with nil children list!", 2)
  elseif(self.compoundStatements == nil)then
    error("Error! compoundStatement element with nil compoundStatements list!", 2)
  elseif(p > #self.children)then
    error("Error! compoundStatement element doesn't have a compoundStatement child in position "..p.."!", 2)
  elseif(p > #self.compoundStatements)then
    error("Error! compoundStatement element doesn't have a compoundStatement child in position "..p.."!", 2)
  end

  self:removeChild(self.compoundStatements[p])
  table.remove(self.compoundStatements, p)
end

return CompoundStatement