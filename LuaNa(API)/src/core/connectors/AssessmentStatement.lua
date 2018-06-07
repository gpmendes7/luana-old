local NCLElem = require "core/NCLElem"
local AttributeAssessment = require "core/connectors/AttributeAssessment"
local ValueAssessment = require "core/connectors/ValueAssessment"

---
-- Implements AssessmentStatement Class representing <b>&lt;assessmentStatement&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=assessmentstatement">
-- http://handbook.ncl.org.br/doku.php?id=assessmentstatement</a>
-- 
-- @module AssessmentStatement
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local AssessmentStatement = require "core/connectors/AssessmentStatement" 
local AssessmentStatement = NCLElem:extends()

---
-- Name of <b>&lt;assessmentStatement&gt;</b> element.
-- 
-- @field [parent=#AssessmentStatement] #string nameElem  
AssessmentStatement.nameElem = "assessmentStatement"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;assessmentStatement&gt;</b> element.
-- 
-- @field [parent=#AssessmentStatement] #table childrenMap
AssessmentStatement.childrenMap = {
  attributeAssessment = {AttributeAssessment, "many"},
  valueAssessment = {ValueAssessment, "one"}
}

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;assessmentStatement&gt;</b> element.
-- 
-- @field [parent=#AssessmentStatement] #table attributesTypeMap  
AssessmentStatement.attributesTypeMap = {
  comparator = "string"
}

---
-- List containing all possible pre-definied values to string attributes
-- belonging to <b>&lt;assessmentStatement&gt;</b> element.
-- 
-- @field [parent=#AssessmentStatement] #table attributesStringValueMap 
AssessmentStatement.attributesStringValueMap = {
  comparator = {"eq", "ne", "gt", "lt", "gte", "lte"}
}

---
-- Returns a new AssessmentStatement object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#AssessmentStatement] create
-- @param #table attributes list of attributes to be initialized.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #AssessmentStatement new AssessmentStatement object created.
function AssessmentStatement:create(attributes, full)
  local assessmentStatement = AssessmentStatement:new()

  assessmentStatement.comparator = nil

  if(attributes ~= nil)then
    assessmentStatement:setAttributes(attributes)
  end

  assessmentStatement.children = {}
  assessmentStatement.attributeAssessments = {}

  if(full ~= nil)then
    assessmentStatement:addAttributeAssessment(AttributeAssessment:create())
    assessmentStatement:setValueAssessment(ValueAssessment:create())
  end

  return assessmentStatement
end

---
-- Sets a value to `comparator` attribute of the 
-- <b>&lt;assessmentStatement&gt;</b> element. 
-- 
-- @function [parent=#AssessmentStatement] setComparator
-- @param #string comparator `comparator` atribute of the
-- <b>&lt;assessmentStatement&gt;</b> element.
function AssessmentStatement:setComparator(comparator)
  self:addAttribute("comparator", comparator)
end

---
-- Returns the value of the `comparator` attribute of the 
-- <b>&lt;assessmentStatement&gt;</b> element. 
-- 
-- @function [parent=#AssessmentStatement] getComparator
-- @return #string `comparator` atribute of the <b>&lt;assessmentStatement&gt;</b> element.
function AssessmentStatement:getComparator()
  return self:getAttribute("comparator")
end

---
-- Adds a <b>&lt;attributeAssessment&gt;</b> child element of the 
-- <b>&lt;assessmentStatement&gt;</b> element. 
-- 
-- @function [parent=#AssessmentStatement] addAttributeAssessment
-- @param #AttributeAssessment attributeAssessment object representing the 
-- <b>&lt;attributeAssessment&gt;</b> element.
function AssessmentStatement:addAttributeAssessment(attributeAssessment)
  if((type(attributeAssessment) == "table"
    and attributeAssessment["getNameElem"] ~= nil
    and attributeAssessment:getNameElem() ~= "attributeAssessment")
    or (type(attributeAssessment) == "table"
    and attributeAssessment["getNameElem"] == nil)
    or type(attributeAssessment) ~= "table")then
    error("Error! Invalid attributeAssessment element!", 2)
  end

  local p = self:getPosAvailable("attributeAssessment")

  if(p ~= nil)then
    self:addChild(attributeAssessment, p)
  else
    self:addChild(attributeAssessment, 1)
  end

  table.insert(self.attributeAssessments, attributeAssessment)
end

---
-- Returns a <b>&lt;attributeAssessments&gt;</b> child element of the 
-- <b>&lt;assessmentStatement&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#AssessmentStatement] getAttributeAssessmentPos
-- @param #number p  position of the object representing the <b>&lt;attributeAssessments&gt;</b> element.
function AssessmentStatement:getAttributeAssessmentPos(p)
  if(self.attributeAssessments == nil)then
    error("Error! assessmentStatement element with nil attributeAssessments list!", 2)
  elseif(p > #self.attributeAssessments)then
    error("Error! assessmentStatement element doesn't have an attributeAssessment child in position "..p.."!", 2)
  end

  return self.attributeAssessments[p]
end

---
-- Adds so many <b>&lt;attributeAssessment&gt;</b> child elements of the <b>&lt;assessmentStatement&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#AssessmentStatement] setAttributeAssessments
-- @param #AttributeAssessment ... objects representing the <b>&lt;attributeAssessment&gt;</b> element.
function AssessmentStatement:setAttributeAssessments(...)
  if(#arg>0)then
    for _, attributeAssessment in ipairs(arg) do
      self:addAttributeAssessment(attributeAssessment)
    end
  end
end

---
-- Removes a <b>&lt;attributeAssessment&gt;</b> child element of the 
-- <b>&lt;assessmentStatement&gt;</b> element. 
-- 
-- @function [parent=#AssessmentStatement] removeAttributeAssessment
-- @param #AttributeAssessment attributeAssessment object representing the <b>&lt;attributeAssessment&gt;</b> element.
function AssessmentStatement:removeAttributeAssessment(attributeAssessment)
  if((type(attributeAssessment) == "table"
    and attributeAssessment["getNameElem"] ~= nil
    and attributeAssessment:getNameElem() ~= "attributeAssessment")
    or (type(attributeAssessment) == "table"
    and attributeAssessment["getNameElem"] == nil)
    or type(attributeAssessment) ~= "table")then
    error("Error! Invalid attributeAssessment element!", 2)
  elseif(self.children == nil)then
    error("Error! assessmentStatement element with nil children list!", 2)
  elseif(self.attributeAssessments == nil)then
    error("Error! assessmentStatement element with nil attributeAssessments list!", 2)
  end

  self:removeChild(attributeAssessment)

  for p, aa in ipairs(self.attributeAssessments) do
    if(attributeAssessment == aa)then
      table.remove(self.attributeAssessments, p)
    end
  end
end

---
-- Removes a <b>&lt;attributeAssessment&gt;</b> child element of the 
-- <b>&lt;assessmentStatement&gt;</b> element in position `p`.
-- 
-- @function [parent=#AssessmentStatement] removeAttributeAssessmentPos
-- @param #number p position of the <b>&lt;attributeAssessment&gt;</b> child element.
function AssessmentStatement:removeAttributeAssessmentPos(p)
  if(self.children == nil)then
    error("Error! assessmentStatement element with nil children list!", 2)
  elseif(self.attributeAssessments == nil)then
    error("Error! assessmentStatement element with nil attributeAssessments list!", 2)
  elseif(p > #self.children)then
    error("Error! assessmentStatement element doesn't have a attributeAssessment child in position "..p.."!", 2)
  elseif(p > #self.attributeAssessments)then
    error("Error! assessmentStatement element doesn't have a attributeAssessment child in position "..p.."!", 2)
  end

  self:removeChild(self.attributeAssessments[p])
  table.remove(self.attributeAssessments, p)
end

---
-- Sets the <b>&lt;valueAssessment&gt;</b> child element of the 
-- <b>&lt;assessmentStatement&gt;</b> element. 
-- 
-- @function [parent=#AssessmentStatement] setValueAssessment
-- @param #ValueAssessment valueAssessment object representing the 
-- <b>&lt;valueAssessment&gt;</b> element.
function AssessmentStatement:setValueAssessment(valueAssessment)
  if((type(valueAssessment) == "table"
    and valueAssessment["getNameElem"] ~= nil
    and valueAssessment:getNameElem() ~= "valueAssessment")
    or (type(valueAssessment) == "table"
    and valueAssessment["getNameElem"] == nil)
    or type(valueAssessment) ~= "table")then
    error("Error! Invalid valueAssessment element!", 2)
  end

  local p

  if(self.valueAssessment == nil)then
    p = self:getPosAvailable("attributeAssessment")
    if(p ~= nil)then
      self:addChild(valueAssessment, p)
    else
      self:addChild(valueAssessment, 1)
    end
  else
    p = self:getPosAvailable("valueAssessment") - 1
    self:removeChildPos(p)
    self:addChild(valueAssessment, p)
  end

  self.valueAssessment = valueAssessment
end

---
-- Returns the <b>&lt;valueAssessment&gt;</b> child element of the 
-- <b>&lt;assessmentStatement&gt;</b> element.
--  
-- @function [parent=#AssessmentStatement] getValueAssessment
-- @return #ValueAssessment valueAssessment object representing the <b>&lt;valueAssessment&gt;</b> element.
function AssessmentStatement:getValueAssessment()
  return self.valueAssessment
end

---
-- Removes the <b>&lt;valueAssessment&gt;</b> child element of the 
-- <b>&lt;assessmentStatement&gt;</b> element.
-- 
-- @function [parent=#AssessmentStatement] removeValueAssessment
function AssessmentStatement:removeValueAssessment()
  self:removeChild(self.valueAssessment)
  self.valueAssessment = nil
end

return AssessmentStatement