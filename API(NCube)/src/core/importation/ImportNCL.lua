local NCLElem = require "core/NCLElem"

local ImportNCL = NCLElem:extends()

ImportNCL.name = "importNCL"

ImportNCL.attributesTypeMap = {
  alias = "string",
  documentURI = "string"
}

function ImportNCL:create(attributes)
  local importNCL = ImportNCL:new()

  importNCL.alias = nil
  importNCL.documentURI = nil

  if(attributes ~= nil)then
    importNCL:setAttributes(attributes)
  end

  return importNCL
end

function ImportNCL:setAlias(alias)
  self:addAttribute("alias", alias)
end

function ImportNCL:getAlias()
  return self:getAttribute("alias")
end

function ImportNCL:setDocumentURI(documentURI)
  self:addAttribute("documentURI", documentURI)
end

function ImportNCL:getDocumentURI()
  return self:getAttribute("documentURI")
end

return ImportNCL
