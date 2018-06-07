local NCLElem = require "core/NCLElem"
local ImportNCL = require "core/importation/ImportNCL"

local ImportedDocumentBase = NCLElem:extends()

ImportedDocumentBase.nameElem = "importedDocumentBase"

ImportedDocumentBase.childrenMap = {
  importNCL = {ImportNCL, "many"}
}

ImportedDocumentBase.attributesTypeMap = {
  id = "string"
}

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

function ImportedDocumentBase:setId(id)
  self:addAttribute("id", id)
end

function ImportedDocumentBase:getId()
  return self:getAttribute("id")
end

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

function ImportedDocumentBase:getImportNCLPos(p)
  if(self.importNCLs == nil)then
    error("Error! importedDocumentBase element with nil importNCLs list!", 2)
  elseif(p > #self.importNCLs)then
    error("Error! importedDocumentBase element doesn't have a importNCL child in position "..p.."!", 2)
  end

  return self.importNCLs[p]
end

function ImportedDocumentBase:setImportNCLs(...)
  if(#arg>0)then
    for _, importNCL in ipairs(arg) do
      self:addImportNCL(importNCL)
    end
  end
end

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