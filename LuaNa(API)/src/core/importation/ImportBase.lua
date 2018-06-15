local NCLElem = require "core/NCLElem"

---
-- Implements ImportBase Class representing <b>&lt;importBase&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=importbase">
-- http://handbook.ncl.org.br/doku.php?id=importbase</a>
-- 
-- @module ImportBase
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local ImportBase = require "core/importantion/ImportBase" 
local ImportBase = NCLElem:extends()

---
-- Name of <b>&lt;importBase&gt;</b> element.
-- 
-- @field [parent=#ImportBase] #string nameElem 
ImportBase.nameElem = "importBase"

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;importBase&gt;</b> element.
-- 
-- @field [parent=#ImportBase] #table attributesTypeMap  
ImportBase.attributesTypeMap = {
  alias = "string",
  documentURI = "string",
  region = "string",
  baseId = "string"
}

---
-- List with associative map that connects an attribute to an specific object
-- representing a child NCL element of <b>&lt;importBase&gt;</b> element.
-- 
-- @field [parent=#ImportBase] #table assMap
ImportBase.assMap = {
  {"region", "regionAss"},
  {"baseId", "baseIdAss"}
}

---
-- Returns a new ImportBase object. 
-- 
-- @function [parent=#ImportBase] create
-- @param #table attributes list of attributes to be initialized.
-- @return #ImportBase new ImportBase object created.
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

---
-- Sets a value to `alias` attribute of the 
-- <b>&lt;importBase&gt;</b> element. 
-- 
-- @function [parent=#ImportBase] setAlias
-- @param #string alias `alias` attribute of the
-- <b>&lt;importBase&gt;</b> element.
function ImportBase:setAlias(alias)
  self:addAttribute("alias", alias)
end

---
-- Returns the value of the `alias` attribute of the 
-- <b>&lt;importBase&gt;</b> element. 
-- 
-- @function [parent=#ImportBase] getAlias
-- @return #string `alias` attribute of the <b>&lt;importBase&gt;</b> element.
function ImportBase:getAlias()
  return self:getAttribute("alias")
end

---
-- Sets a value to `documentURI` attribute of the 
-- <b>&lt;importBase&gt;</b> element. 
-- 
-- @function [parent=#ImportBase] setDocumentURI
-- @param #string documentURI `documentURI` attribute of the
-- <b>&lt;importBase&gt;</b> element.
function ImportBase:setDocumentURI(documentURI)
  self:addAttribute("documentURI", documentURI)
end

---
-- Returns the value of the `documentURI` attribute of the 
-- <b>&lt;importBase&gt;</b> element. 
-- 
-- @function [parent=#ImportBase] getDocumentURI
-- @return #string `documentURI` attribute of the <b>&lt;importBase&gt;</b> element.
function ImportBase:getDocumentURI()
  return self:getAttribute("documentURI")
end

---
-- Sets a value to `region` attribute of the 
-- <b>&lt;importBase&gt;</b> element. 
-- 
-- @function [parent=#ImportBase] setRegion
-- @param #stringOrobject region `region` attribute of the
-- <b>&lt;importBase&gt;</b> element.
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

---
-- Returns the value of the `region` attribute of the 
-- <b>&lt;importBase&gt;</b> element. 
-- 
-- @function [parent=#ImportBase] getRegion
-- @return #string `region` attribute of the <b>&lt;importBase&gt;</b> element.
function ImportBase:getRegion()
  return self:getAttribute("region")
end

---
-- Returns the region associated to
-- <b>&lt;importBase&gt;</b> element. 
-- 
-- @function [parent=#ImportBase] getRegionAss
-- @return #object region associated to <b>&lt;importBase&gt;</b> element.
function ImportBase:getRegionAss()
  return self.regionAss
end

---
-- Sets a value to `baseId` attribute of the 
-- <b>&lt;importBase&gt;</b> element. 
-- 
-- @function [parent=#ImportBase] setBaseId
-- @param #stringOrobject baseId `baseId` attribute of the
-- <b>&lt;importBase&gt;</b> element.
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
    error("Error! Invalid baseId element!", 2)
  end
end

---
-- Returns the value of the `baseId` attribute of the 
-- <b>&lt;importBase&gt;</b> element. 
-- 
-- @function [parent=#ImportBase] getBaseId
-- @return #string `baseId` attribute of the <b>&lt;importBase&gt;</b> element.
function ImportBase:getBaseId()
  return self:getAttribute("baseId")
end

---
-- Returns the baseId associated to
-- <b>&lt;importBase&gt;</b> element. 
-- 
-- @function [parent=#ImportBase] getBaseIdAss
-- @return #object baseId associated to <b>&lt;importBase&gt;</b> element.
function ImportBase:getBaseIdAss()
  return self.baseIdAss
end

return ImportBase