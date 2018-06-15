local NCLElem = require "core/NCLElem"

---
-- Implements Property Class representing <b>&lt;property&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=property">
-- http://handbook.ncl.org.br/doku.php?id=property</a>
-- 
-- @module Property
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local Property = require "core/interface/Property" 
local Property = NCLElem:extends()

---
-- Name of <b>&lt;property&gt;</b> element.
-- 
-- @field [parent=#Property] #string nameElem
Property.nameElem = "property"

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;property&gt;</b> element.
-- 
-- @field [parent=#Property] #table attributesTypeMap 
Property.attributesTypeMap = {
  name = "string",
  value = {"string", "number"},
  externable = "boolean"
}

---
-- Returns a new Property object. 
-- 
-- @function [parent=#Property] create
-- @param #table attributes list of attributes to be initialized.
-- @return #Property new Property object created.
function Property:create(attributes)
  local property = Property:new()

  property.name = nil
  property.value = nil
  property.externable = nil
  
  property.ass = {}

  if(attributes ~= nil)then
    property:setAttributes(attributes)
  end

  return property
end

---
-- Sets a value to `name` attribute of the 
-- <b>&lt;property&gt;</b> element. 
-- 
-- @function [parent=#Property] setName
-- @param #string name `name` attribute of the
-- <b>&lt;property&gt;</b> element.
function Property:setName(name)
  self:addAttribute("name", name)
end

---
-- Returns the value of the `name` attribute of the 
-- <b>&lt;property&gt;</b> element. 
-- 
-- @function [parent=#Property] getName
-- @return #string `name` attribute of the <b>&lt;property&gt;</b> element.
function Property:getName()
  return self:getAttribute("name")
end

---
-- Sets a value to `value` attribute of the 
-- <b>&lt;property&gt;</b> element. 
-- 
-- @function [parent=#Property] setValue
-- @param #stringOrnumber value `value` attribute of the
-- <b>&lt;property&gt;</b> element.
function Property:setValue(value)
  self:addAttribute("value", value)
end

---
-- Returns the value of the `value` attribute of the 
-- <b>&lt;property&gt;</b> element. 
-- 
-- @function [parent=#Property] getValue
-- @return #stringOrnumber `value` attribute of the <b>&lt;property&gt;</b> element.
function Property:getValue()
  return self:getAttribute("value")
end

---
-- Sets a value to `externable` attribute of the 
-- <b>&lt;property&gt;</b> element. 
-- 
-- @function [parent=#Property] setExternable
-- @param #boolean externable `externable` attribute of the
-- <b>&lt;property&gt;</b> element.
function Property:setExternable(externable)
  self:addAttribute("externable", externable)
end

---
-- Returns the value of the `externable` attribute of the 
-- <b>&lt;property&gt;</b> element. 
-- 
-- @function [parent=#Property] getExternable
-- @return #boolean `externable` attribute of the <b>&lt;property&gt;</b> element.
function Property:getExternable()
  return self:getAttribute("externable")
end

return Property