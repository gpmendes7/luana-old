local NCLElem = require "core/NCLElem"

local ImportBase = NCLElem:extends()

ImportBase.name = "importBase"

ImportBase.attributesTypeMap = {
  alias = "string",
  documentURI = "string",
  region = "string",
  baseId = "string"
}

function ImportBase:create(attributes)
  local importBase = ImportBase:new()

  importBase.alias = nil
  importBase.documentURI = nil
  importBase.region = nil
  importBase.baseId = nil

  importBase.regionAss = nil
  importBase.baseIdAss = nil

  if(attributes ~= nil)then
    importBase:setAttributes(attributes)
  end

  return importBase
end

function ImportBase:setAlias(alias)
  self:addAttribute("alias", alias)
end

function ImportBase:getAlias()
  return self:getAttribute("alias")
end

function ImportBase:setDocumentURI(documentURI)
  self:addAttribute("documentURI", documentURI)
end

function ImportBase:getDocumentURI()
  return self:getAttribute("documentURI")
end

function ImportBase:setRegion(region)
  if(type(region) == "table" and region.name == "region")then
    self:addAttribute("region", region:getId())
    self.regionAss = region
    table.insert(region.ass, self)
  else
    self:addAttribute("region", region)
  end
end

function ImportBase:getRegion()
  return self:getAttribute("region")
end

function ImportBase:setBaseId(baseId)
  if(type(baseId) == "table" and baseId.name == "regionBase")then
    self:addAttribute("baseId", baseId:getId())
    self.baseIdAss = baseId
    table.insert(baseId.ass, self)
  else
    self:addAttribute("baseId", baseId)
  end
end

function ImportBase:getBaseId()
  return self:getAttribute("baseId")
end

return ImportBase