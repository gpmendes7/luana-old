local NCLElem = require "core/NCLElem"

---
-- Implements ImportNCL Class representing <b>&lt;importNCL&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=importncl">
-- http://handbook.ncl.org.br/doku.php?id=importncl</a>
-- 
-- @module ImportNCL
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local ImportNCL = require "core/importantion/ImportNCL" 
local ImportNCL = NCLElem:extends()

---
-- Name of <b>&lt;importNCL&gt;</b> element.
-- 
-- @field [parent=#ImportNCL] #string nameElem 
ImportNCL.nameElem = "importNCL"

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;importNCL&gt;</b> element.
-- 
-- @field [parent=#ImportNCL] #table attributesTypeMap 
ImportNCL.attributesTypeMap = {
  alias = "string",
  documentURI = "string"
}

---
-- Returns a new ImportNCL object. 
-- 
-- @function [parent=#ImportNCL] create
-- @param #table attributes list of attributes to be initialized.
-- @return #ImportNCL new ImportNCL object created.
function ImportNCL:create(attributes)
  local importNCL = ImportNCL:new()

  importNCL.alias = nil
  importNCL.documentURI = nil

  if(attributes ~= nil)then
    importNCL:setAttributes(attributes)
  end

  return importNCL
end

---
-- Sets a value to `alias` attribute of the 
-- <b>&lt;importNCL&gt;</b> element. 
-- 
-- @function [parent=#ImportNCL] setAlias
-- @param #string alias `alias` attribute of the
-- <b>&lt;importNCL&gt;</b> element.
function ImportNCL:setAlias(alias)
  self:addAttribute("alias", alias)
end

---
-- Returns the value of the `alias` attribute of the 
-- <b>&lt;importNCL&gt;</b> element. 
-- 
-- @function [parent=#ImportNCL] getAlias
-- @return #string `alias` attribute of the <b>&lt;ImportNCL&gt;</b> element.
function ImportNCL:getAlias()
  return self:getAttribute("alias")
end

---
-- Sets a value to `documentURI` attribute of the 
-- <b>&lt;importNCL&gt;</b> element. 
-- 
-- @function [parent=#ImportNCL] setDocumentURI
-- @param #string documentURI `documentURI` attribute of the
-- <b>&lt;importNCL&gt;</b> element.
function ImportNCL:setDocumentURI(documentURI)
  self:addAttribute("documentURI", documentURI)
end

---
-- Returns the value of the `documentURI` attribute of the 
-- <b>&lt;importNCL&gt;</b> element. 
-- 
-- @function [parent=#ImportNCL] getDocumentURI
-- @return #string `documentURI` attribute of the <b>&lt;importNCL&gt;</b> element.
function ImportNCL:getDocumentURI()
  return self:getAttribute("documentURI")
end

return ImportNCL