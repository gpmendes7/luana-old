local NCLElem = require "LuaNa(API)/src/core/NCLElem"

---
-- Implements Rule Class representing <b>&lt;rule&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=rule">
-- http://handbook.ncl.org.br/doku.php?id=rule</a>
-- 
-- @module Rule
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local Rule = require "core/content/Rule"
local Rule = NCLElem:extends()

---
-- Name of <b>&lt;rule&gt;</b> element.
-- 
-- @field [parent=#Rule] #string nameElem
Rule.nameElem = "rule"

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;rule&gt;</b> element.
-- 
-- @field [parent=#Rule] #table attributesTypeMap  
Rule.attributesTypeMap = {
  id = "string",
  var = "string",
  comparator = "string",
  value = {"string", "number"}
}

---
-- List containing all possible pre-definied values to string attributes
-- belonging to <b>&lt;rule&gt;</b> element.
-- 
-- @field [parent=#Rule] #table attributesStringValueMap 
Rule.attributesStringValueMap = {
  comparator = {"eq", "ne", "gt", "lt", "gte", "lte"}
}

---
-- Returns a new Rule object. 
-- 
-- @function [parent=#Rule] create
-- @param #table attributes list of attributes to be initialized.
-- @return #Rule new Rule object created.
function Rule:create(attributes)
  local rule = Rule:new()

  rule.id = nil
  rule.var = nil
  rule.comparator = nil
  rule.value = nil
  
  rule.ass = {}

  if(attributes ~= nil)then
    rule:setAttributes(attributes)
  end

  return rule
end

---
-- Sets a value to `id` attribute of the 
-- <b>&lt;rule&gt;</b> element. 
-- 
-- @function [parent=#Rule] setId
-- @param #string id `id` attribute of the
-- <b>&lt;rule&gt;</b> element.
function Rule:setId(id)
  self:addAttribute("id", id)
end

---
-- Returns the value of the `id` attribute of the 
-- <b>&lt;rule&gt;</b> element. 
-- 
-- @function [parent=#Rule] getId
-- @return #string `id` attribute of the <b>&lt;rule&gt;</b> element.
function Rule:getId()
  return self:getAttribute("id")
end

---
-- Sets a value to `var` attribute of the 
-- <b>&lt;rule&gt;</b> element. 
-- 
-- @function [parent=#Rule] setVar
-- @param #string var `var` attribute of the
-- <b>&lt;rule&gt;</b> element.
function Rule:setVar(var)
  self:addAttribute("var", var)
end

---
-- Returns the value of the `var` attribute of the 
-- <b>&lt;rule&gt;</b> element. 
-- 
-- @function [parent=#Rule] getVar
-- @return #string `var` attribute of the <b>&lt;rule&gt;</b> element.
function Rule:getVar()
  return self:getAttribute("var")
end

---
-- Sets a value to `comparator` attribute of the 
-- <b>&lt;rule&gt;</b> element. 
-- 
-- @function [parent=#Rule] setComparator
-- @param #string comparator `comparator` attribute of the
-- <b>&lt;rule&gt;</b> element.
function Rule:setComparator(comparator)
  self:addAttribute("comparator", comparator)
end

---
-- Returns the value of the `comparator` attribute of the 
-- <b>&lt;rule&gt;</b> element. 
-- 
-- @function [parent=#Rule] getComparator
-- @return #string `comparator` attribute of the <b>&lt;rule&gt;</b> element.
function Rule:getComparator()
  return self:getAttribute("comparator")
end

---
-- Sets a value to `value` attribute of the 
-- <b>&lt;rule&gt;</b> element. 
-- 
-- @function [parent=#Rule] setValue
-- @param #stringOrnumber value `value` attribute of the
-- <b>&lt;rule&gt;</b> element.
function Rule:setValue(value)
  self:addAttribute("value", value)
end

---
-- Returns the value of the `value` attribute of the 
-- <b>&lt;rule&gt;</b> element. 
-- 
-- @function [parent=#Rule] getValue
-- @return #stringOrnumber `value` attribute of the <b>&lt;rule&gt;</b> element.
function Rule:getValue()
  return self:getAttribute("value")
end

return Rule