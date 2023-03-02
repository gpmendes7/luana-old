local NCLElem = require "../../src/core/NCLElem"

---
-- Implements DescriptorParam Class representing <b>&lt;descriptorParam&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=descriptorparam">
-- http://handbook.ncl.org.br/doku.php?id=descriptorparam</a>
-- 
-- @module DescriptorParam
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local DescriptorParam = require "core/layout/DescriptorParam" 
local DescriptorParam = NCLElem:extends()

---
-- Name of <b>&lt;descriptorParam&gt;</b> element.
-- 
-- @field [parent=#DescriptorParam] #string nameElem 
DescriptorParam.nameElem = "descriptorParam"

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;descriptorParam&gt;</b> element.
-- 
-- @field [parent=#DescriptorParam] #table attributesTypeMap 
DescriptorParam.attributesTypeMap = {
  name = "string",
  value = {"string", "number"}
}

---
-- Returns a new DescriptorParam object. 
-- 
-- @function [parent=#DescriptorParam] create
-- @param #table attributes list of attributes to be initialized.
-- @return #DescriptorParam new DescriptorParam object created.
function DescriptorParam:create(attributes)
  local descriptorParam = DescriptorParam:new()

  descriptorParam.name = nil
  descriptorParam.value = nil
  
  descriptorParam.ass = {}

  if(attributes ~= nil)then
    descriptorParam:setAttributes(attributes)
  end

  return descriptorParam
end

---
-- Sets a value to `name` attribute of the 
-- <b>&lt;descriptorParam&gt;</b> element. 
-- 
-- @function [parent=#DescriptorParam] setName
-- @param #string name `name` attribute of the
-- <b>&lt;descriptorParam&gt;</b> element.
function DescriptorParam:setName(name)
  self:addAttribute("name", name)
end

---
-- Returns the value of the `name` attribute of the 
-- <b>&lt;descriptorParam&gt;</b> element. 
-- 
-- @function [parent=#DescriptorParam] getName
-- @return #string `name` attribute of the <b>&lt;descriptorParam&gt;</b> element.
function DescriptorParam:getName()
  return self:getAttribute("name")
end

---
-- Sets a value to `value` attribute of the 
-- <b>&lt;descriptorParam&gt;</b> element. 
-- 
-- @function [parent=#DescriptorParam] setValue
-- @param #stringOrnumber value `value` attribute of the
-- <b>&lt;descriptorParam&gt;</b> element.
function DescriptorParam:setValue(value)
  self:addAttribute("value", value)
end

---
-- Returns the value of the `value` attribute of the 
-- <b>&lt;descriptorParam&gt;</b> element. 
-- 
-- @function [parent=#DescriptorParam] getValue
-- @return #stringOrnumber `value` attribute of the <b>&lt;descriptorParam&gt;</b> element.
function DescriptorParam:getValue()
  return self:getAttribute("value")
end

return DescriptorParam