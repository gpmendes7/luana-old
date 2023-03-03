local NCLElem = require "LuaNa(API)/src/core/NCLElem"

---
-- Implements LinkParam Class representing <b>&lt;linkParam&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=linkparam">
-- http://handbook.ncl.org.br/doku.php?id=linkparam</a>
-- 
-- @module LinkParam
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local LinkParam = require "core/linking/LinkParam" 
local LinkParam = NCLElem:extends()

---
-- Name of <b>&lt;linkParam&gt;</b> element.
-- 
-- @field [parent=#LinkParam] #string nameElem
LinkParam.nameElem = "linkParam"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;linkParam&gt;</b> element.
-- 
-- @field [parent=#LinkParam] #table childrenMap
LinkParam.attributesTypeMap = {
  name = "string",
  value = {"string", "number"}
}

---
-- Returns a new LinkParam object. 
-- 
-- @function [parent=#LinkParam] create
-- @param #table attributes list of attributes to be initialized.
-- @return #LinkParam new LinkParam object created.
function LinkParam:create(attributes)  
   local linkParam = LinkParam:new() 
   
   linkParam.name = nil
   linkParam.value = nil
   
   linkParam.symbols = {}
   
   if(attributes ~= nil)then
      linkParam:setAttributes(attributes)
   end
      
   return linkParam
end

---
-- Sets a value to `name` attribute of the 
-- <b>&lt;linkParam&gt;</b> element. 
-- 
-- @function [parent=#LinkParam] setName
-- @param #string name `name` attribute of the
-- <b>&lt;linkParam&gt;</b> element.
function LinkParam:setName(name)
   self:addAttribute("name", name)
end

---
-- Returns the value of the `name` attribute of the 
-- <b>&lt;linkParam&gt;</b> element. 
-- 
-- @function [parent=#LinkParam] getName
-- @return #string `name` attribute of the <b>&lt;linkParam&gt;</b> element.
function LinkParam:getName()
   return self:getAttribute("name")
end

---
-- Sets a value to `value` attribute of the 
-- <b>&lt;linkParam&gt;</b> element. 
-- 
-- @function [parent=#LinkParam] setValue
-- @param #stringOrnumber value `value` attribute of the
-- <b>&lt;linkParam&gt;</b> element.
function LinkParam:setValue(value)
   self:addAttribute("value", value)
end

---
-- Returns the value of the `value` attribute of the 
-- <b>&lt;linkParam&gt;</b> element. 
-- 
-- @function [parent=#LinkParam] getValue
-- @return #stringOrnumber `value` attribute of the <b>&lt;linkParam&gt;</b> element.
function LinkParam:getValue()
   return self:getAttribute("value")
end

return LinkParam