local NCLElem = require "core/NCLElem"
local ImportBase = require "core/importation/ImportBase"
local CausalConnector = require "core/connectors/CausalConnector"

---
-- Implements ConnectorBase Class representing <b>&lt;connectorBase&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=connectorbase">
-- http://handbook.ncl.org.br/doku.php?id=connectorbase</a>
-- 
-- @module ConnectorBase
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local ConnectorBase = require "core/connectors/ConnectorBase" 
local ConnectorBase = NCLElem:extends()

---
-- Name of <b>&lt;connectorBase&gt;</b> element.
-- 
-- @field [parent=#ConnectorBase] #string nameElem
ConnectorBase.nameElem = "connectorBase"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;connectorBase&gt;</b> element.
-- 
-- @field [parent=#ConnectorBase] #table childrenMap
ConnectorBase.childrenMap = {
  importBase = {ImportBase, "many"},
  causalConnector = {CausalConnector, "many"}
}

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;connectorBase&gt;</b> element.
-- 
-- @field [parent=#ConnectorBase] #table attributesTypeMap 
ConnectorBase.attributesTypeMap = {
  id = "string"
}

---
-- Returns a new ConnectorBase object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#ConnectorBase] create
-- @param #table attributes list of attributes to be initialized.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #ConnectorBase new ConnectorBase object created.
function ConnectorBase:create(attributes, full)
  local connectorBase = ConnectorBase:new()

  connectorBase.id = nil

  if(attributes ~= nil)then
    connectorBase:setAttributes(attributes)
  end

  connectorBase.children = {}
  connectorBase.importBases = {}
  connectorBase.causalConnectors = {}

  if(full ~= nil)then
    connectorBase:addImportBase(ImportBase:create())
    connectorBase:addCausalConnector(CausalConnector:create(nil, full))
  end

  return connectorBase
end

---
-- Sets a value to `id` attribute of the 
-- <b>&lt;connectorBase&gt;</b> element. 
-- 
-- @function [parent=#ConnectorBase] setId
-- @param #string id `id` attribute of the
-- <b>&lt;connectorBase&gt;</b> element.
function ConnectorBase:setId(id)
  self:addAttribute("id", id)
end

---
-- Returns the value of the `id` attribute of the 
-- <b>&lt;connectorBase&gt;</b> element. 
-- 
-- @function [parent=#ConnectorBase] getId
-- @return #string `id` attribute of the <b>&lt;connectorBase&gt;</b> element.
function ConnectorBase:getId()
  return self:getAttribute("id")
end

---
-- Adds a <b>&lt;importBase&gt;</b> child element of the 
-- <b>&lt;connectorBase&gt;</b> element. 
-- 
-- @function [parent=#ConnectorBase] addImportBase
-- @param #ImportBase importBase object representing the 
-- <b>&lt;importBase&gt;</b> element.
function ConnectorBase:addImportBase(importBase)
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
-- <b>&lt;connectorBase&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#ConnectorBase] getImportBasePos
-- @param #number p  position of the object representing the <b>&lt;importBase&gt;</b> element.
function ConnectorBase:getImportBasePos(p)
  if(self.importBases == nil)then
    error("Error! connectorBase element with nil importBases list!", 2)
  elseif(p > #self.importBases)then
    error("Error! connectorBase element doesn't have a importBase child in position "..p.."!", 2)
  end

  return self.importBases[p]
end

---
-- Returns a <b>&lt;importBase&gt;</b> child element of the 
-- <b>&lt;connectorBase&gt;</b> element
-- by `alias` attribute.
--  
-- @function [parent=#ConnectorBase] getImportBaseByAlias
-- @param #string alias `alias` attribute of the <b>&lt;importBase&gt;</b> element.
function ConnectorBase:getImportBaseByAlias(alias)
  if(alias == nil)then
    error("Error! alias attribute of connectorbase element must be informed!", 2)
  elseif(self.importBases == nil)then
    error("Error! connectorBase element with nil importBases list!", 2)
  end

  for _, importBase in ipairs(self.importBases) do
    if(importBase:getAlias() == alias)then
      return importBase
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;importBase&gt;</b> child elements of the <b>&lt;connectorBase&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#ConnectorBase] setImportBases
-- @param #ImportBase ... objects representing the <b>&lt;importBase&gt;</b> element.
function ConnectorBase:setImportBases(...)
  if(#arg>0)then
    for _, importBase in ipairs(arg) do
      self:addRule(importBase)
    end
  end
end

---
-- Removes a <b>&lt;importBase&gt;</b> child element of the 
-- <b>&lt;connectorBase&gt;</b> element. 
-- 
-- @function [parent=#ConnectorBase] removeImportBase
-- @param #ImportBase importBase object representing the <b>&lt;importBase&gt;</b> element.
function ConnectorBase:removeImportBase(importBase)
  if((type(importBase) == "table"
    and importBase["getNameElem"] ~= nil
    and importBase:getNameElem() ~= "importBase")
    or (type(importBase) == "table"
    and importBase["getNameElem"] == nil)
    or type(importBase) ~= "table")then
    error("Error! Invalid importBase element!", 2)
  elseif(self.children == nil)then
    error("Error! connectorBase element with nil children list!", 2)
  elseif(self.importBases == nil)then
    error("Error! connectorBase element with nil importBases list!", 2)
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
-- <b>&lt;connectorBase&gt;</b> element in position `p`.
-- 
-- @function [parent=#ConnectorBase] removeImportBasePos
-- @param #number p position of the <b>&lt;importBase&gt;</b> child element.
function ConnectorBase:removeImportBasePos(p)
  if(self.children == nil)then
    error("Error! connectorBase element with nil children list!", 2)
  elseif(self.importBases == nil)then
    error("Error! connectorBase element with nil importBases list!", 2)
  elseif(p > #self.children)then
    error("Error! connectorBase element doesn't have a importBase child in position "..p.."!", 2)
  elseif(p > #self.importBases)then
    error("Error! connectorBase element doesn't have a importBase child in position "..p.."!", 2)
  end

  self:removeChild(self.importBases[p])
  table.remove(self.importBases, p)
end

---
-- Adds a <b>&lt;causalConnector&gt;</b> child element of the 
-- <b>&lt;connectorBase&gt;</b> element. 
-- 
-- @function [parent=#ConnectorBase] addCausalConnector
-- @param #CausalConnector causalConnector object representing the 
-- <b>&lt;causalConnector&gt;</b> element.
function ConnectorBase:addCausalConnector(causalConnector)
  if((type(causalConnector) == "table"
    and causalConnector["getNameElem"] ~= nil
    and causalConnector:getNameElem() ~= "causalConnector")
    or (type(causalConnector) == "table"
    and causalConnector["getNameElem"] == nil)
    or type(causalConnector) ~= "table")then
    error("Error! Invalid causalConnector element!", 2)
  end

  self:addChild(causalConnector)
  table.insert(self.causalConnectors, causalConnector)
end

---
-- Returns a <b>&lt;causalConnector&gt;</b> child element of the 
-- <b>&lt;connectorBase&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#ConnectorBase] getCausalConnectorPos
-- @param #number p  position of the object representing the <b>&lt;causalConnector&gt;</b> element.
function ConnectorBase:getCausalConnectorPos(p)
  if(self.causalConnectors == nil)then
    error("Error! connectorBase element with nil causalConnectors list!", 2)
  elseif(p > #self.causalConnectors)then
    error("Error! connectorBase element doesn't have a causalConnector child in position "..p.."!", 2)
  end

  return self.causalConnectors[p]
end

---
-- Returns a <b>&lt;causalConnector&gt;</b> child element of the 
-- <b>&lt;connectorBase&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#ConnectorBase] getCausalConnectorById
-- @param #string id `id` attribute of the <b>&lt;causalConnector&gt;</b> element.
function ConnectorBase:getCausalConnectorById(id)
  if(id == nil)then
    error("Error! id attribute of connectorbase element must be informed!", 2)
  elseif(self.causalConnectors == nil)then
    error("Error! connectorBase element with nil causalConnectors list!", 2)
  end

  for _, causalConnector in ipairs(self.causalConnectors) do
    if(causalConnector:getId() == id)then
      return causalConnector
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;causalConnector&gt;</b> child elements of the <b>&lt;connectorBase&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#ConnectorBase] setCausalConnectors
-- @param #CausalConnector ... objects representing the <b>&lt;causalConnector&gt;</b> element.
function ConnectorBase:setCausalConnectors(...)
  if(#arg>0)then
    for _, causalConnector in ipairs(arg) do
      self:addCausalConnector(causalConnector)
    end
  end
end

---
-- Removes a <b>&lt;causalConnector&gt;</b> child element of the 
-- <b>&lt;connectorBase&gt;</b> element. 
-- 
-- @function [parent=#ConnectorBase] removeCausalConnector
-- @param #CausalConnector causalConnector object representing the <b>&lt;causalConnector&gt;</b> element.
function ConnectorBase:removeCausalConnector(causalConnector)
  if((type(causalConnector) == "table"
    and causalConnector["getNameElem"] ~= nil
    and causalConnector:getNameElem() ~= "causalConnector")
    or (type(causalConnector) == "table"
    and causalConnector["getNameElem"] == nil)
    or type(causalConnector) ~= "table")then
    error("Error! Invalid causalConnector element!", 2)
  elseif(self.children == nil)then
    error("Error! connectorBase element with nil children list!", 2)
  elseif(self.causalConnectors == nil)then
    error("Error! connectorBase element with nil causalConnectors list!", 2)
  end

  self:removeChild(causalConnector)

  for p, cc in ipairs(self.causalConnectors) do
    if(causalConnector == cc)then
      table.remove(self.causalConnectors, p)
    end
  end
end

---
-- Removes a <b>&lt;causalConnector&gt;</b> child element of the 
-- <b>&lt;connectorBase&gt;</b> element in position `p`.
-- 
-- @function [parent=#ConnectorBase] removeCausalConnectorPos
-- @param #number p position of the <b>&lt;causalConnector&gt;</b> child element.
function ConnectorBase:removeCausalConnectorPos(p)
  if(self.children == nil)then
    error("Error! connectorBase element with nil children list!", 2)
  elseif(self.causalConnectors == nil)then
    error("Error! connectorBase element with nil causalConnectors list!", 2)
  elseif(p > #self.children)then
    error("Error! connectorBase element doesn't have a causalConnector child in position "..p.."!", 2)
  elseif(p > #self.causalConnectors)then
    error("Error! connectorBase element doesn't have a causalConnector child in position "..p.."!", 2)
  end

  self:removeChild(self.causalConnectors[p])
  table.remove(self.causalConnectors, p)
end

return ConnectorBase