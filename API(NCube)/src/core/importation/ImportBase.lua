local NCLElem = require "core/NCLElem"

local ImportBase = NCLElem:extends()

ImportBase.nameElem = "importBase"

ImportBase.attributesTypeMap = {
  alias = "string",
  documentURI = "string",
  region = "string",
  baseId = "string"
}

ImportBase.assMap = {
  {"region", "regionAss"},
  {"baseId", "baseIdAss"}
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
  if(type(region) == "table"
    and region["getNameElem"] ~= nil
    and region:getNameElem() == "region")then
    self:addAttribute("region", region:getId())
    self.regionAss = region
    table.insert(region.ass, self)
  elseif(type(region) == "string" )then
    self:addAttribute("region", region)
  else
    error("Error! Invalid region element!", 2)
  end
end

function ImportBase:getRegion()
  return self:getAttribute("region")
end

function ImportBase:getRegionAss()
  return self.regionAss
end

function ImportBase:setBaseId(baseId)
  if(type(baseId) == "table"
    and baseId["getNameElem"] ~= nil
    and baseId:getNameElem() == "regionBase")then
    self:addAttribute("baseId", baseId:getId())
    self.baseIdAss = baseId
    table.insert(baseId.ass, self)
  elseif(type(baseId) == "string" )then
    self:addAttribute("baseId", baseId)
  else
    error("Error! Invalid region element!", 2)
  end
end

function ImportBase:getBaseId()
  return self:getAttribute("baseId")
end

function ImportBase:getBaseIdAss()
  return self.baseIdAss
end

return ImportBase