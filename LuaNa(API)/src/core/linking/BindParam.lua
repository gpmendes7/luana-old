local NCLElem = require "../../src/core/NCLElem"

---
-- Implements BindParam Class representing <b>&lt;bindParam&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=bindparam">
-- http://handbook.ncl.org.br/doku.php?id=bindparam</a>
-- 
-- @module BindParam
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local BindParam = require "core/linking/BindParam" 
local BindParam = NCLElem:extends()

---
-- Name of <b>&lt;bindParam&gt;</b> element.
-- 
-- @field [parent=#BindParam] #string nameElem
BindParam.nameElem = "bindParam"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;bindParam&gt;</b> element.
-- 
-- @field [parent=#BindParam] #table childrenMap
BindParam.attributesTypeMap = {
  name = "string",
  value = {"string", "number"}
}

---
-- Returns a new BindParam object. 
-- 
-- @function [parent=#BindParam] create
-- @param #table attributes list of attributes to be initialized.
-- @return #BindParam new BindParam object created.
function BindParam:create(attributes)
  local bindParam = BindParam:new()

  bindParam.name = nil
  bindParam.value = nil
  
  bindParam.symbols = {}

  if(attributes ~= nil)then
    bindParam:setAttributes(attributes)
  end

  return bindParam
end

---
-- Sets a value to `name` attribute of the 
-- <b>&lt;bindParam&gt;</b> element. 
-- 
-- @function [parent=#BindParam] setName
-- @param #string name `name` attribute of the
-- <b>&lt;bindParam&gt;</b> element.
function BindParam:setName(name)
  self:addAttribute("name", name)
end

---
-- Returns the value of the `name` attribute of the 
-- <b>&lt;bindParam&gt;</b> element. 
-- 
-- @function [parent=#BindParam] getName
-- @return #string `name` attribute of the <b>&lt;bindParam&gt;</b> element.
function BindParam:getName()
  return self:getAttribute("name")
end

---
-- Sets a value to `value` attribute of the 
-- <b>&lt;bindParam&gt;</b> element. 
-- 
-- @function [parent=#BindParam] setValue
-- @param #stringOrnumber value `value` attribute of the
-- <b>&lt;bindParam&gt;</b> element.
function BindParam:setValue(value)
  self:addAttribute("value", value)
end

---
-- Returns the value of the `value` attribute of the 
-- <b>&lt;bindParam&gt;</b> element. 
-- 
-- @function [parent=#BindParam] getValue
-- @return #stringOrnumber `value` attribute of the <b>&lt;bindParam&gt;</b> element.
function BindParam:getValue()
  return self:getAttribute("value")
end

return BindParam