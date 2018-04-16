local NCLElem = require "core/NCLElem"
local ImportNCL = require "core/importation/ImportNCL"

local ImportedDocumentBase = NCLElem:extends()

ImportedDocumentBase.name = "importedDocumentBase"

ImportedDocumentBase.childrenMap = {
  ["importNCL"] = {ImportNCL, "many"}
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
  self:addChild(importNCL)
  table.insert(self.importNCLs, importNCL)
end

function ImportedDocumentBase:getImportNCLPos(i)
  return self.importNCLs[i]
end

function ImportedDocumentBase:setImportNCLs(...)
  if(#arg>0)then
    for _, importNCL in ipairs(arg) do
      self:addImportNCL(importNCL)
    end
  end
end

function ImportedDocumentBase:removeImportNCL(importNCL)
  self:removeChild(importNCL)

  for i, ip in ipairs(self.importNCLs) do
    if(importNCL == ip)then
      table.remove(self.importNCLs, i)
    end
  end
end

function ImportedDocumentBase:removeImportNCLPos(i)
  self:removeChildPos(i)
  table.remove(self.importNCLs, i)
end

return ImportedDocumentBase
