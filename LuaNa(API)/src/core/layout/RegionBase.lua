local NCLElem = require "core/NCLElem"
local ImportBase = require "core/importation/ImportBase"
local Region = require "core/layout/Region"

---
-- Implements RegionBase Class representing <b>&lt;regionBase&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=regionbase">
-- http://handbook.ncl.org.br/doku.php?id=regionbase</a>
-- 
-- @module RegionBase
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local RegionBase = require "core/layout/RegionBase" 
local RegionBase = NCLElem:extends()

---
-- Name of <b>&lt;regionBase&gt;</b> element.
-- 
-- @field [parent=#RegionBase] #string nameElem 
RegionBase.nameElem = "regionBase"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;regionBase&gt;</b> element.
-- 
-- @field [parent=#RegionBase] #table childrenMap
RegionBase.childrenMap = {
  importBase = {ImportBase, "many"},
  region = {Region, "many"}
}

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;regionBase&gt;</b> element.
-- 
-- @field [parent=#RegionBase] #table attributesTypeMap 
RegionBase.attributesTypeMap = {
  id = "string",
  device = "string",
  region = "string"
}

---
-- List with associative map that connects an attribute to an specific object
-- representing a child NCL element of <b>&lt;regionBase&gt;</b> element.
-- 
-- @field [parent=#RegionBase] #table assMap
RegionBase.assMap = {
  {"region", "regionAss"}
}

---
-- Returns a new RegionBase object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#RegionBase] create
-- @param #table attributes list of attributes to be initialized.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #RegionBase RegionBase object created.
function RegionBase:create(attributes, full)
  local regionBase = RegionBase:new()

  regionBase.id = nil
  regionBase.device = nil
  regionBase.region = nil

  regionBase.regionAss = nil

  regionBase.ass = {}

  if(attributes ~= nil)then
    regionBase:setAttributes(attributes)
  end

  regionBase.children = {}
  regionBase.importBases = {}
  regionBase.regions = {}

  if(full ~= nil)then
    regionBase:addImportBase(ImportBase:create())
    regionBase:addRegion(Region:create())
  end

  return regionBase
end

---
-- Sets a value to `id` attribute of the 
-- <b>&lt;regionBase&gt;</b> element. 
-- 
-- @function [parent=#RegionBase] setId
-- @param #string id `id` atribute of the
-- <b>&lt;regionBase&gt;</b> element.
function RegionBase:setId(id)
  self:addAttribute("id", id)
end

---
-- Returns the value of the `id` attribute of the 
-- <b>&lt;regionBase&gt;</b> element. 
-- 
-- @function [parent=#RegionBase] getId
-- @return #string `id` atribute of the <b>&lt;regionBase&gt;</b> element.
function RegionBase:getId()
  return self:getAttribute("id")
end

---
-- Sets a value to `device` attribute of the 
-- <b>&lt;regionBase&gt;</b> element. 
-- 
-- @function [parent=#RegionBase] setDevice
-- @param #string device `device` atribute of the
-- <b>&lt;regionBase&gt;</b> element.
function RegionBase:setDevice(device)
  self:addAttribute("device", device)
end

---
-- Returns the value of the `device` attribute of the 
-- <b>&lt;regionBase&gt;</b> element. 
-- 
-- @function [parent=#RegionBase] getDevice
-- @return #string `device` atribute of the <b>&lt;regionBase&gt;</b> element.
function RegionBase:getDevice()
  return self:getAttribute("device")
end

---
-- Sets a value to `region` attribute of the 
-- <b>&lt;regionBase&gt;</b> element. 
-- 
-- @function [parent=#RegionBase] setRegion
-- @param #stringOrobject region `region` atribute of the
-- <b>&lt;regionBase&gt;</b> element.
function RegionBase:setRegion(region)
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
-- <b>&lt;regionBase&gt;</b> element. 
-- 
-- @function [parent=#RegionBase] getRegion
-- @return #string `region` atribute of the <b>&lt;regionBase&gt;</b> element.
function RegionBase:getRegion()
  return self:getAttribute("region")
end

---
-- Returns the region associated to
-- <b>&lt;regionBase&gt;</b> element. 
-- 
-- @function [parent=#RegionBase] getRegionAss
-- @return #object region associated to <b>&lt;regionBase&gt;</b> element.
function RegionBase:getRegionAss()
  return self.regionAss
end

---
-- Adds a <b>&lt;importBase&gt;</b> child element of the 
-- <b>&lt;regionBase&gt;</b> element. 
-- 
-- @function [parent=#RegionBase] addImportBase
-- @param #ImportBase importBase object representing the 
-- <b>&lt;importBase&gt;</b> element.
function RegionBase:addImportBase(importBase)
  if((type(importBase) == "table"
    and importBase["getNameElem"] ~= nil
    and importBase:getNameElem() ~= "importBase")
    or (type(importBase) == "table"
    and importBase["getNameElem"] == nil)
    or type(importBase) ~= "table")then
    error("Error! Invalid importBase element!", 2)
  end

  self:addChild(importBase)
  table.insert(self.importBases, importBase)
end

---
-- Returns a <b>&lt;importBase&gt;</b> child element of the 
-- <b>&lt;regionBase&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#RegionBase] getImportBasePos
-- @param #number p  position of the object representing 
-- the <b>&lt;importBase&gt;</b> element.
function RegionBase:getImportBasePos(p)
  if(self.importBases == nil)then
    error("Error! regionBase element with nil importBases list!", 2)
  elseif(p > #self.importBases)then
    error("Error! regionBase element doesn't have a importBase child in position "..p.."!", 2)
  end

  return self.importBases[p]
end

---
-- Returns a <b>&lt;importBase&gt;</b> child element of the 
-- <b>&lt;regionBase&gt;</b> element
-- by `alias` attribute.
--  
-- @function [parent=#RegionBase] getImportBaseByAlias
-- @param #string alias `alias` attribute of the <b>&lt;importBase&gt;</b> element.
function RegionBase:getImportBaseByAlias(alias)
  if(alias == nil)then
    error("Error! alias attribute of importBase element must be informed!", 2)
  elseif(self.importBases == nil)then
    error("Error! regionBase element with nil importBases list!", 2)
  end

  for _, importBase in ipairs(self.importBases) do
    if(importBase:getAlias() == alias)then
      return importBase
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;importBase&gt;</b> child elements of the <b>&lt;regionBase&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#RegionBase] setImportBases
-- @param #ImportBase ... objects representing the <b>&lt;importBase&gt;</b> element.
function RegionBase:setImportBases(...)
  if(#arg>0)then
    for _, importBase in ipairs(arg) do
      self:addImportBase(importBase)
    end
  end
end

---
-- Removes a <b>&lt;importBase&gt;</b> child element of the 
-- <b>&lt;regionBase&gt;</b> element. 
-- 
-- @function [parent=#RegionBase] removeImportBase
-- @param #ImportBase importBase object representing the <b>&lt;importBase&gt;</b> element.
function RegionBase:removeImportBase(importBase)
  if((type(importBase) == "table"
    and importBase["getNameElem"] ~= nil
    and importBase:getNameElem() ~= "importBase")
    or (type(importBase) == "table"
    and importBase["getNameElem"] == nil)
    or type(importBase) ~= "table")then
    error("Error! Invalid importBase element!", 2)
  elseif(self.children == nil)then
    error("Error! regionBase element with nil children list!", 2)
  elseif(self.importBases == nil)then
    error("Error! regionBase element with nil importBases list!", 2)
  end

  self:removeChild(importBase)

  for p, ib in ipairs(self.importBases) do
    if(importBase == ib)then
      table.remove(self.importBases, p)
    end
  end
end

---
-- Removes a <b>&lt;importBase&gt;</b> child element of the 
-- <b>&lt;regionBase&gt;</b> element in position `p`.
-- 
-- @function [parent=#RegionBase] removeImportBasePos
-- @param #number p position of the <b>&lt;importBase&gt;</b> child element.
function RegionBase:removeImportBasePos(p)
  if(self.children == nil)then
    error("Error! regionBase element with nil children list!", 2)
  elseif(self.importBases == nil)then
    error("Error! regionBase element with nil importBases list!", 2)
  elseif(p > #self.children)then
    error("Error! regionBase element doesn't have a importBase child in position "..p.."!", 2)
  elseif(p > #self.importBases)then
    error("Error! regionBase element doesn't have a importBase child in position "..p.."!", 2)
  end

  self:removeChild(self.importBases[p])
  table.remove(self.importBases, p)
end

---
-- Adds a <b>&lt;region&gt;</b> child element of the 
-- <b>&lt;regionBase&gt;</b> element. 
-- 
-- @function [parent=#RegionBase] addRegion
-- @param #Region region object representing the 
-- <b>&lt;region&gt;</b> element.
function RegionBase:addRegion(region)
  if((type(region) == "table"
    and region["getNameElem"] ~= nil
    and region:getNameElem() ~= "region")
    or (type(region) == "table"
    and region["getNameElem"] == nil)
    or type(region) ~= "table")then
    error("Error! Invalid region element!", 2)
  end

  self:addChild(region)
  table.insert(self.regions, region)
end

---
-- Returns a <b>&lt;region&gt;</b> child element of the 
-- <b>&lt;regionBase&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#RegionBase] getRegionPos
-- @param #number p  position of the object representing 
-- the <b>&lt;region&gt;</b> element.
function RegionBase:getRegionPos(p)
  if(self.regions == nil)then
    error("Error! regionBase element with nil regions list!", 2)
  elseif(p > #self.regions)then
    error("Error! regionBase element doesn't have a region child in position "..p.."!", 2)
  end

  return self.regions[p]
end

---
-- Returns a <b>&lt;region&gt;</b> child element of the 
-- <b>&lt;regionBase&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#RegionBase] getRegionById
-- @param #string id `id` attribute of the <b>&lt;region&gt;</b> element.
function RegionBase:getRegionById(id)
  if(id == nil)then
    error("Error! id attribute of region element must be informed!", 2)
  elseif(self.regions == nil)then
    error("Error! regionBase element with nil regions list!", 2)
  end

  for _, region in ipairs(self.regions) do
    if(region:getId() == id)then
      return region
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;region&gt;</b> child elements of the <b>&lt;regionBase&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#RegionBase] setRegions
-- @param #Region ... objects representing the <b>&lt;region&gt;</b> element.
function RegionBase:setRegions(...)
  if(#arg>0)then
    for _, region in ipairs(arg) do
      self:addRegion(region)
    end
  end
end

---
-- Removes a <b>&lt;region&gt;</b> child element of the 
-- <b>&lt;regionBase&gt;</b> element. 
-- 
-- @function [parent=#RegionBase] removeRegion
-- @param #Region region object representing the <b>&lt;region&gt;</b> element.
function RegionBase:removeRegion(region)
  if((type(region) == "table"
    and region["getNameElem"] ~= nil
    and region:getNameElem() ~= "region")
    or (type(region) == "table"
    and region["getNameElem"] == nil)
    or type(region) ~= "table")then
    error("Error! Invalid region element!", 2)
  elseif(self.children == nil)then
    error("Error! regionBase element with nil children list!", 2)
  elseif(self.regions == nil)then
    error("Error! regionBase element with nil regions list!", 2)
  end

  self:removeChild(region)

  for p, rg in ipairs(self.regions) do
    if(region == rg)then
      table.remove(self.regions, p)
    end
  end
end

---
-- Removes a <b>&lt;region&gt;</b> child element of the 
-- <b>&lt;regionBase&gt;</b> element in position `p`.
-- 
-- @function [parent=#RegionBase] removeRegionPos
-- @param #number p position of the <b>&lt;region&gt;</b> child element.
function RegionBase:removeRegionPos(p)
  if(self.children == nil)then
    error("Error! regionBase element with nil children list!", 2)
  elseif(self.regions == nil)then
    error("Error! regionBase element with nil regions list!", 2)
  elseif(p > #self.children)then
    error("Error! regionBase element doesn't have a region child in position "..p.."!", 2)
  elseif(p > #self.regions)then
    error("Error! regionBase element doesn't have a region child in position "..p.."!", 2)
  end

  self:removeChild(self.regions[p])
  table.remove(self.regions, p)
end

return RegionBase