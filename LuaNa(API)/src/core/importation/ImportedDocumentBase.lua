local NCLElem = require "core/NCLElem"
local ImportNCL = require "core/importation/ImportNCL"

---
-- Implements ImportedDocumentBase Class representing <b>&lt;importedDocumentBase&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=importeddocumentbase">
-- http://handbook.ncl.org.br/doku.php?id=importeddocumentbase</a>
-- 
-- @module ImportedDocumentBase
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local ImportedDocumentBase = require "core/importantion/ImportedDocumentBase" 
local ImportedDocumentBase = NCLElem:extends()

---
-- Name of <b>&lt;importedDocumentBase&gt;</b> element.
-- 
-- @field [parent=#ImportedDocumentBase] #string nameElem 
ImportedDocumentBase.nameElem = "importedDocumentBase"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;importedDocumentBase&gt;</b> element.
-- 
-- @field [parent=#ImportedDocumentBase] #table childrenMap
ImportedDocumentBase.childrenMap = {
  importNCL = {ImportNCL, "many"}
}

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;importedDocumentBase&gt;</b> element.
-- 
-- @field [parent=#ImportedDocumentBase] #table attributesTypeMap 
ImportedDocumentBase.attributesTypeMap = {
  id = "string"
}

---
-- Returns a new ImportedDocumentBase object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#ImportedDocumentBase] create
-- @param #table attributes list of attributes to be initialized.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #ImportedDocumentBase new ImportedDocumentBase object created.
function ImportedDocumentBase:create(attributes, full)
  local importedDocumentBase = ImportedDocumentBase:new()

  importedDocumentBase.id = nil

  if(attributes ~= nil)then
    importedDocumentBase:setAttributes(attributes)
  end

  importedDocumentBase.children = {}
  importedDocumentBase.importNCLs = {}

  if(full ~= nil)then
    importedDocumentBase:addImportNCL(ImportNCL:create())
  end

  return importedDocumentBase
end

---
-- Sets a value to `id` attribute of the 
-- <b>&lt;importedDocumentBase&gt;</b> element. 
-- 
-- @function [parent=#ImportedDocumentBase] setId
-- @param #string id `id` atribute of the
-- <b>&lt;importedDocumentBase&gt;</b> element.
function ImportedDocumentBase:setId(id)
  self:addAttribute("id", id)
end

---
-- Returns the value of the `id` attribute of the 
-- <b>&lt;importedDocumentBase&gt;</b> element. 
-- 
-- @function [parent=#ImportedDocumentBase] getId
-- @return #string `id` atribute of the <b>&lt;importedDocumentBase&gt;</b> element.
function ImportedDocumentBase:getId()
  return self:getAttribute("id")
end

---
-- Adds a <b>&lt;importNCL&gt;</b> child element of the 
-- <b>&lt;importedDocumentBase&gt;</b> element. 
-- 
-- @function [parent=#ImportedDocumentBase] addImportNCL
-- @param #ImportNCL importNCL object representing the 
-- <b>&lt;importNCL&gt;</b> element.
function ImportedDocumentBase:addImportNCL(importNCL)
  if((type(importNCL) == "table"
    and importNCL["getNameElem"] ~= nil
    and importNCL:getNameElem() ~= "importNCL")
    or (type(importNCL) == "table"
    and importNCL["getNameElem"] == nil)
    or type(importNCL) ~= "table")then
    error("Error! Invalid importNCL element!", 2)
  end

  self:addChild(importNCL)
  table.insert(self.importNCLs, importNCL)
end

---
-- Returns a <b>&lt;importNCL&gt;</b> child element of the 
-- <b>&lt;importedDocumentBase&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#ImportedDocumentBase] getImportNCLPos
-- @param #number p  position of the object representing the <b>&lt;importNCL&gt;</b> element.
function ImportedDocumentBase:getImportNCLPos(p)
  if(self.importNCLs == nil)then
    error("Error! importedDocumentBase element with nil importNCLs list!", 2)
  elseif(p > #self.importNCLs)then
    error("Error! importedDocumentBase element doesn't have a importNCL child in position "..p.."!", 2)
  end

  return self.importNCLs[p]
end

---
-- Adds so many <b>&lt;importNCL&gt;</b> child elements of the <b>&lt;importedDocumentBase&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#ImportedDocumentBase] setImportNCLs
-- @param #ImportNCL ... objects representing the <b>&lt;importNCL&gt;</b> element.
function ImportedDocumentBase:setImportNCLs(...)
  if(#arg>0)then
    for _, importNCL in ipairs(arg) do
      self:addImportNCL(importNCL)
    end
  end
end

---
-- Removes a <b>&lt;importNCL&gt;</b> child element of the 
-- <b>&lt;importedDocumentBase&gt;</b> element. 
-- 
-- @function [parent=#ImportedDocumentBase] removeImportNCL
-- @param #ImportNCL importNCL object representing the <b>&lt;importNCL&gt;</b> element.
function ImportedDocumentBase:removeImportNCL(importNCL)
  if((type(importNCL) == "table"
    and importNCL["getNameElem"] ~= nil
    and importNCL:getNameElem() ~= "importNCL")
    or (type(importNCL) == "table"
    and importNCL["getNameElem"] == nil)
    or type(importNCL) ~= "table")then
    error("Error! Invalid importNCL element!", 2)
  elseif(self.children == nil)then
    error("Error! importedDocumentBase element with nil children list!", 2)
  elseif(self.importNCLs == nil)then
    error("Error! importedDocumentBase element with nil importNCLs list!", 2)
  end

  self:removeChild(importNCL)

  for p, ip in ipairs(self.importNCLs) do
    if(importNCL == ip)then
      table.remove(self.importNCLs, p)
    end
  end
end

---
-- Removes a <b>&lt;importNCL&gt;</b> child element of the 
-- <b>&lt;importedDocumentBase&gt;</b> element in position `p`.
-- 
-- @function [parent=#ImportedDocumentBase] removeImportNCLPos
-- @param #number p position of the <b>&lt;importNCL&gt;</b> child element.
function ImportedDocumentBase:removeImportNCLPos(p)
  if(self.children == nil)then
    error("Error! importedDocumentBase element with nil children list!", 2)
  elseif(self.importNCLs == nil)then
    error("Error! importedDocumentBase element with nil importNCLs list!", 2)
  elseif(p > #self.children)then
    error("Error! importedDocumentBase element doesn't have a importNCL child in position "..p.."!", 2)
  elseif(p > #self.importNCLs)then
    error("Error! importedDocumentBase element doesn't have a importNCL child in position "..p.."!", 2)
  end

  self:removeChild(self.importNCLs[p])
  table.remove(self.importNCLs, p)
end

return ImportedDocumentBase