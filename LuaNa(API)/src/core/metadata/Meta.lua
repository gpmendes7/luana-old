local NCLElem = require "core/NCLElem"

---
-- Implements Meta Class representing <b>&lt;meta&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=meta">
-- http://handbook.ncl.org.br/doku.php?id=meta</a>
-- 
-- @module Meta
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local Meta = require "core/metadata/Meta" 
local Meta = NCLElem:extends()

---
-- Name of <b>&lt;meta&gt;</b> element.
-- 
-- @field [parent=#Meta] #string nameElem
Meta.nameElem = "meta"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;meta&gt;</b> element.
-- 
-- @field [parent=#Meta] #table childrenMap
Meta.attributesTypeMap = {
  name = "string",
  content = "string"
}

---
-- Returns a new Meta object. 
-- 
-- @function [parent=#Meta] create
-- @param #table attributes list of attributes to be initialized.
-- @return #Meta new Meta object created.
function Meta:create(attributes)
  local meta = Meta:new()

  meta.name = nil
  meta.content = nil

  if(attributes ~= nil)then
    meta:setAttributes(attributes)
  end

  return meta
end

---
-- Sets a value to `name` attribute of the 
-- <b>&lt;meta&gt;</b> element. 
-- 
-- @function [parent=#Meta] setName
-- @param #string name `name` atribute of the
-- <b>&lt;meta&gt;</b> element.
function Meta:setName(name)
  self:addAttribute("name", name)
end

---
-- Returns the value of the `name` attribute of the 
-- <b>&lt;meta&gt;</b> element. 
-- 
-- @function [parent=#Meta] getName
-- @return #string `name` atribute of the <b>&lt;meta&gt;</b> element.
function Meta:getName()
  return self:getAttribute("name")
end

---
-- Sets a value to `content` attribute of the 
-- <b>&lt;meta&gt;</b> element. 
-- 
-- @function [parent=#Meta] setContent
-- @param #string content `content` atribute of the
-- <b>&lt;meta&gt;</b> element.
function Meta:setContent(content)
  self:addAttribute("content", content)
end

---
-- Returns the value of the `content` attribute of the 
-- <b>&lt;meta&gt;</b> element. 
-- 
-- @function [parent=#Meta] getContent
-- @return #string `content` atribute of the <b>&lt;meta&gt;</b> element.
function Meta:getContent()
  return self:getAttribute("content")
end

return Meta