local NCLElem = require "core/NCLElem"

---
-- Implements ValueAssessment Class representing <b>&lt;valueAssessment&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=valueassessment">
-- http://handbook.ncl.org.br/doku.php?id=valueassessment</a>
-- 
-- @module ValueAssessment
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local ValueAssessment = require "core/connectors/ValueAssessment" 
local ValueAssessment = NCLElem:extends()

---
-- Name of <b>&lt;valueAssessment&gt;</b> element.
-- 
-- @field [parent=#ValueAssessment] #string nameElem
ValueAssessment.nameElem = "valueAssessment"

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;valueAssessment&gt;</b> element.
-- 
-- @field [parent=#ValueAssessment] #table attributesTypeMap 
ValueAssessment.attributesTypeMap = {
  value = "string"
}

---
-- Returns a new ValueAssessment object. 
-- 
-- @function [parent=#ValueAssessment] create
-- @param #table attributes list of attributes to be initialized.
-- @return #ValueAssessment new ValueAssessment object created.
function ValueAssessment:create(attributes)
  local valueAssessment = ValueAssessment:new()

  valueAssessment.value = nil

  if(attributes ~= nil)then
    valueAssessment:setAttributes(attributes)
  end

  return valueAssessment
end

---
-- Sets a value to `value` attribute of the 
-- <b>&lt;valueAssessment&gt;</b> element. 
-- 
-- @function [parent=#ValueAssessment] setValue
-- @param #string value `value` attribute of the
-- <b>&lt;valueAssessment&gt;</b> element.
function ValueAssessment:setValue(value)
  self:addAttribute("value", value)
end

---
-- Returns the value of the `value` attribute of the 
-- <b>&lt;valueAssessment&gt;</b> element. 
-- 
-- @function [parent=#ValueAssessment] getValue
-- @return #string `value` attribute of the <b>&lt;valueAssessment&gt;</b> element.
function ValueAssessment:getValue()
  return self:getAttribute("value")
end

return ValueAssessment