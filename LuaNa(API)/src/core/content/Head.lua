local NCLElem = require "core/NCLElem"
local ImportedDocumentBase = require "core/importation/ImportedDocumentBase"
local RuleBase = require "core/switches/RuleBase"
local TransitionBase = require "core/transition/TransitionBase"
local RegionBase = require "core/layout/RegionBase"
local DescriptorBase = require "core/layout/DescriptorBase"
local ConnectorBase = require "core/connectors/ConnectorBase"
local Meta = require "core/metadata/Meta"
local MetaData = require "core/metadata/MetaData"

---
-- Implements Head Class representing <b>&lt;head&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=head">
-- http://handbook.ncl.org.br/doku.php?id=head</a>
-- 
-- @module Head
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local Head = require "core/content/Head" 
local Head = NCLElem:extends()

---
-- Name of <b>&lt;head&gt;</b> element.
-- 
-- @field [parent=#Head] #string nameElem 
Head.nameElem = "head"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;head&gt;</b> element.
-- 
-- @field [parent=#Head] #table childrenMap
Head.childrenMap = {
  importedDocumentBase = {ImportedDocumentBase, "one"},
  ruleBase = {RuleBase, "one"},
  transitionBase = {TransitionBase, "one"},
  regionBase = {RegionBase, "many"},
  descriptorBase = {DescriptorBase, "one"},
  connectorBase = {ConnectorBase, "one"},
  meta = {Meta, "many"},
  metadata = {MetaData, "many"}
}

---
-- Returns a new Head object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#Head] create
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #Head new Head object created.
function Head:create(full)
  local head = Head:new()

  head.children = {}
  head.regionBases = {}
  head.metas = {}
  head.metadatas = {}

  if(full ~= nil)then
    head:setImportedDocumentBase(ImportedDocumentBase:create(nil, full))
    head:setRuleBase(RuleBase:create(nil, full))
    head:setTransitionBase(TransitionBase:create(nil, full))
    head:addRegionBase(RegionBase:create(nil, full))
    head:setDescriptorBase(DescriptorBase:create(nil, full))
    head:setConnectorBase(ConnectorBase:create(nil, full))
    head:addMeta(Meta:create(nil, full))
    head:addMetaData(MetaData:create())
  end

  return head
end

---
-- Sets the <b>&lt;importedDocumentBase&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element. 
-- 
-- @function [parent=#Head] setImportedDocumentBase
-- @param #ImportedDocumentBase importedDocumentBase object representing the 
-- <b>&lt;importedDocumentBase&gt;</b> element.
function Head:setImportedDocumentBase(importedDocumentBase)
  if((type(importedDocumentBase) == "table"
    and importedDocumentBase["getNameElem"] ~= nil
    and importedDocumentBase:getNameElem() ~= "importedDocumentBase")
    or (type(importedDocumentBase) == "table"
    and importedDocumentBase["getNameElem"] == nil)
    or type(importedDocumentBase) ~= "table")then
    error("Error! Invalid importedDocumentBase element!", 2)
  end

  self:addChild(importedDocumentBase, 1)
  self.importedDocumentBase = importedDocumentBase
end

---
-- Returns the <b>&lt;importedDocumentBase&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element.
--  
-- @function [parent=#Head] getImportedDocumentBase
-- @return #ImportedDocumentBase importedDocumentBase object representing 
-- the <b>&lt;importedDocumentBase&gt;</b> element.
function Head:getImportedDocumentBase()
  return self.importedDocumentBase
end

---
-- Removes the <b>&lt;importedDocumentBase&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element.
-- 
-- @function [parent=#Head] removeImportedDocumentBase
function Head:removeImportedDocumentBase()
  self:removeChild(self.importedDocumentBase)
  self.importedDocumentBase = nil
end

---
-- Sets the <b>&lt;ruleBase&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element. 
-- 
-- @function [parent=#Head] setRuleBase
-- @param #RuleBase ruleBase object representing the 
-- <b>&lt;ruleBase&gt;</b> element.
function Head:setRuleBase(ruleBase)
  if((type(ruleBase) == "table"
    and ruleBase["getNameElem"] ~= nil
    and ruleBase:getNameElem() ~= "ruleBase")
    or (type(ruleBase) == "table"
    and ruleBase["getNameElem"] == nil)
    or type(ruleBase) ~= "table")then
    error("Error! Invalid ruleBase element!", 2)
  end

  local p

  if(self.ruleBase == nil)then
    p = self:getPosAvailable("importedDocumentBase")
    if(p ~= nil)then
      self:addChild(ruleBase, p)
    else
      self:addChild(ruleBase, 1)
    end
  else
    p = self:getPosAvailable("ruleBase") - 1
    self:removeChildPos(p)
    self:addChild(ruleBase, p)
  end

  self.ruleBase = ruleBase
end

---
-- Returns the <b>&lt;ruleBase&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element.
--  
-- @function [parent=#Head] getRuleBase
-- @return #RuleBase ruleBase object representing 
-- the <b>&lt;ruleBase&gt;</b> element.
function Head:getRuleBase()
  return self.ruleBase
end

---
-- Removes the <b>&lt;ruleBase&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element.
-- 
-- @function [parent=#Head] removeRuleBase
function Head:removeRuleBase()
  self:removeChild(self.ruleBase)
  self.ruleBase = nil
end

---
-- Sets the <b>&lt;transitionBase&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element. 
-- 
-- @function [parent=#Head] setTransitionBase
-- @param #TransitionBase transitionBase object representing the 
-- <b>&lt;transitionBase&gt;</b> element.
function Head:setTransitionBase(transitionBase)
  if((type(transitionBase) == "table"
    and transitionBase["getNameElem"] ~= nil
    and transitionBase:getNameElem() ~= "transitionBase")
    or (type(transitionBase) == "table"
    and transitionBase["getNameElem"] == nil)
    or type(transitionBase) ~= "table")then
    error("Error! Invalid transitionBase element!", 2)
  end

  local p

  if(self.transitionBase == nil)then
    p = self:getPosAvailable("ruleBase", "importedDocumentBase")
    if(p ~= nil)then
      self:addChild(transitionBase, p)
    else
      self:addChild(transitionBase, 1)
    end
  else
    p = self:getPosAvailable("transitionBase") - 1
    self:removeChildPos(p)
    self:addChild(transitionBase, p)
  end

  self.transitionBase = transitionBase
end

---
-- Returns the <b>&lt;transitionBase&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element.
--  
-- @function [parent=#Head] getTransitionBase
-- @return #TransitionBase transitionBase object representing 
-- the <b>&lt;transitionBase&gt;</b> element.
function Head:getTransitionBase()
  return self.transitionBase
end

---
-- Removes the <b>&lt;transitionBase&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element.
-- 
-- @function [parent=#Head] removeTransitionBase
function Head:removeTransitionBase()
  self:removeChild(self.transitionBase)
  self.transitionBase = nil
end

---
-- Adds a <b>&lt;regionBase&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element. 
-- 
-- @function [parent=#Head] addRegionBase
-- @param #RegionBase regionBase object representing the 
-- <b>&lt;regionBase&gt;</b> element.
function Head:addRegionBase(regionBase)
  if((type(regionBase) == "table"
    and regionBase["getNameElem"] ~= nil
    and regionBase:getNameElem() ~= "regionBase")
    or (type(regionBase) == "table"
    and regionBase["getNameElem"] == nil)
    or type(regionBase) ~= "table")then
    error("Error! Invalid regionBase element!", 2)
  end

  local p = self:getPosAvailable("regionBase", "transitionBase", "ruleBase", "importedDocumentBase")

  if(p ~= nil)then
    self:addChild(regionBase, p)
  else
    self:addChild(regionBase, 1)
  end

  table.insert(self.regionBases, regionBase)
end

---
-- Returns a <b>&lt;regionBase&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Head] getRegionBasePos
-- @param #number p  position of the object representing the <b>&lt;regionBase&gt;</b> element.
function Head:getRegionBasePos(p)
  if(self.regionBases == nil)then
    error("Error! head element with nil regionBases list!", 2)
  elseif(p > #self.regionBases)then
    error("Error! head element doesn't have a regionBase child in position "..p.."!", 2)
  end

  return self.regionBases[p]
end

---
-- Returns a <b>&lt;regionBase&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#Head] getRegionBaseById
-- @param #string id `id` attribute of the <b>&lt;regionBase&gt;</b> element.
function Head:getRegionBaseById(id)
  if(id == nil)then
    error("Error! id attribute of regionBase element must be informed!", 2)
  elseif(self.regionBases == nil)then
    error("Error! head element with nil regionBases list!", 2)
  end

  for _, regionBase in ipairs(self.regionBases) do
    if(regionBase:getId() == id)then
      return regionBase
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;regionBase&gt;</b> child elements of the <b>&lt;head&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Head] setRegionBases
-- @param #RegionBase ... objects representing the <b>&lt;regionBase&gt;</b> element.
function Head:setRegionBases(...)
  if(#arg>0)then
    for _, regionBase in ipairs(arg) do
      self:addRegionBase(regionBase)
    end
  end
end

---
-- Removes a <b>&lt;regionBase&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element. 
-- 
-- @function [parent=#Head] removeRegionBase
-- @param #RegionBase regionBase object representing the <b>&lt;regionBase&gt;</b> element.
function Head:removeRegionBase(regionBase)
  if((type(regionBase) == "table"
    and regionBase["getNameElem"] ~= nil
    and regionBase:getNameElem() ~= "regionBase")
    or (type(regionBase) == "table"
    and regionBase["getNameElem"] == nil)
    or type(regionBase) ~= "table")then
    error("Error! Invalid regionBase element!", 2)
  elseif(self.children == nil)then
    error("Error! head element with nil children list!", 2)
  elseif(self.regionBases == nil)then
    error("Error! head element with nil regionBases list!", 2)
  end

  self:removeChild(regionBase)

  for p, rb in ipairs(self.regionBases) do
    if(regionBase == rb)then
      table.remove(self.regionBases, p)
    end
  end
end

---
-- Removes a <b>&lt;regionBase&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element in position `p`.
-- 
-- @function [parent=#Head] removeRegionBasePos
-- @param #number p position of the <b>&lt;regionBase&gt;</b> child element.
function Head:removeRegionBasePos(p)
  if(self.children == nil)then
    error("Error! head element with nil children list!", 2)
  elseif(self.regionBases == nil)then
    error("Error! head element with nil regionBases list!", 2)
  elseif(p > #self.children)then
    error("Error! head element doesn't have a regionBase child in position "..p.."!", 2)
  elseif(p > #self.regionBases)then
    error("Error! head element doesn't have a regionBase child in position "..p.."!", 2)
  end

  self:removeChild(self.regionBases[p])
  table.remove(self.regionBases, p)
end

---
-- Sets the <b>&lt;descriptorBase&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element. 
-- 
-- @function [parent=#Head] setDescriptorBase
-- @param #DescriptorBase descriptorBase object representing the 
-- <b>&lt;descriptorBase&gt;</b> element.
function Head:setDescriptorBase(descriptorBase)
  if((type(descriptorBase) == "table"
    and descriptorBase["getNameElem"] ~= nil
    and descriptorBase:getNameElem() ~= "descriptorBase")
    or (type(descriptorBase) == "table"
    and descriptorBase["getNameElem"] == nil)
    or type(descriptorBase) ~= "table")then
    error("Error! Invalid descriptorBase element!", 2)
  end

  local p

  if(self.descriptorBase == nil)then
    p = self:getPosAvailable("regionBase", "transitionBase", "ruleBase", "importedDocumentBase")
    if(p ~= nil)then
      self:addChild(descriptorBase, p)
    else
      self:addChild(descriptorBase, 1)
    end
  else
    p = self:getPosAvailable("descriptorBase") - 1
    self:removeChildPos(p)
    self:addChild(descriptorBase, p)
  end

  self.descriptorBase = descriptorBase
end

---
-- Returns the <b>&lt;descriptorBase&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element.
--  
-- @function [parent=#Head] getDescriptorBase
-- @return #DescriptorBase descriptorBase object representing 
-- the <b>&lt;descriptorBase&gt;</b> element.
function Head:getDescriptorBase()
  return self.descriptorBase
end

---
-- Removes the <b>&lt;descriptorBase&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element.
-- 
-- @function [parent=#Head] removeDescriptorBase
function Head:removeDescriptorBase()
  self:removeChild(self.descriptorBase)
  self.descriptorBase = nil
end

---
-- Sets the <b>&lt;connectorBase&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element. 
-- 
-- @function [parent=#Head] setConnectorBase
-- @param #ConnectorBase connectorBase object representing the 
-- <b>&lt;connectorBase&gt;</b> element.
function Head:setConnectorBase(connectorBase)
  if((type(connectorBase) == "table"
    and connectorBase["getNameElem"] ~= nil
    and connectorBase:getNameElem() ~= "connectorBase")
    or (type(connectorBase) == "table"
    and connectorBase["getNameElem"] == nil)
    or type(connectorBase) ~= "table")then
    error("Error! Invalid connectorBase element!", 2)
  end

  local p

  if(self.connectorBase == nil)then
    p = self:getPosAvailable("descriptorBase", "regionBase", "transitionBase",
      "ruleBase", "importedDocumentBase")
    if(p ~= nil)then
      self:addChild(connectorBase, p)
    else
      self:addChild(connectorBase, 1)
    end
  else
    p = self:getPosAvailable("connectorBase") - 1
    self:removeChildPos(p)
    self:addChild(connectorBase, p)
  end

  self.connectorBase = connectorBase
end

---
-- Returns the <b>&lt;connectorBase&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element.
--  
-- @function [parent=#Head] getConnectorBase
-- @return #ConnectorBase connectorBase object representing 
-- the <b>&lt;connectorBase&gt;</b> element.
function Head:getConnectorBase()
  return self.connectorBase
end

---
-- Removes the <b>&lt;connectorBase&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element.
-- 
-- @function [parent=#Head] removeConnectorBase
function Head:removeConnectorBase()
  self:removeChild(self.connectorBase)
  self.connectorBase = nil
end

---
-- Adds a <b>&lt;meta&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element. 
-- 
-- @function [parent=#Head] addMeta
-- @param #Meta meta object representing the 
-- <b>&lt;meta&gt;</b> element.
function Head:addMeta(meta)
  if((type(meta) == "table"
    and meta["getNameElem"] ~= nil
    and meta:getNameElem() ~= "meta")
    or (type(meta) == "table"
    and meta["getNameElem"] == nil)
    or type(meta) ~= "table")then
    error("Error! Invalid meta element!", 2)
  end

  local p = self:getPosAvailable("connectorBase", "descriptorBase", "regionBase",
    "transitionBase", "ruleBase", "importedDocumentBase")

  if(p ~= nil)then
    self:addChild(meta, p)
  else
    self:addChild(meta)
  end

  table.insert(self.metas, meta)
end

---
-- Returns a <b>&lt;meta&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Head] getMetaPos
-- @param #number p  position of the object representing the <b>&lt;meta&gt;</b> element.
function Head:getMetaPos(p)
  if(self.metas == nil)then
    error("Error! head element with nil metas list!", 2)
  elseif(p > #self.metas)then
    error("Error! head element doesn't have a meta child in position "..p.."!", 2)
  end

  return self.metas[p]
end

---
-- Adds so many <b>&lt;meta&gt;</b> child elements of the <b>&lt;head&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Head] setMetas
-- @param #Meta ... objects representing the <b>&lt;meta&gt;</b> element.
function Head:setMetas(...)
  if(#arg>0)then
    for _, meta in ipairs(arg) do
      self:addMedia(meta)
    end
  end
end

---
-- Removes a <b>&lt;meta&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element. 
-- 
-- @function [parent=#Head] removeMeta
-- @param #Meta meta object representing the <b>&lt;meta&gt;</b> element.
function Head:removeMeta(meta)
  if((type(meta) == "table"
    and meta["getNameElem"] ~= nil
    and meta:getNameElem() ~= "meta")
    or (type(meta) == "table"
    and meta["getNameElem"] == nil)
    or type(meta) ~= "table")then
    error("Error! Invalid meta element!", 2)
  elseif(self.children == nil)then
    error("Error! head element with nil children list!", 2)
  elseif(self.metas == nil)then
    error("Error! head element with nil metas list!", 2)
  end

  self:removeChild(meta)

  for p, mt in ipairs(self.metas) do
    if(meta == mt)then
      table.remove(self.metas, p)
    end
  end
end

---
-- Removes a <b>&lt;meta&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element in position `p`.
-- 
-- @function [parent=#Head] removeMetaPos
-- @param #number p position of the <b>&lt;meta&gt;</b> child element.
function Head:removeMetaPos(p)
  if(self.children == nil)then
    error("Error! head element with nil children list!", 2)
  elseif(self.metas == nil)then
    error("Error! head element with nil metas list!", 2)
  elseif(p > #self.children)then
    error("Error! head element doesn't have a meta child in position "..p.."!", 2)
  elseif(p > #self.metas)then
    error("Error! head element doesn't have a meta child in position "..p.."!", 2)
  end

  self:removeChildPos(p)
  table.remove(self.metas, p)
end

---
-- Adds a <b>&lt;metadata&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element. 
-- 
-- @function [parent=#Head] addMetaData
-- @param #Metadata metadata object representing the 
-- <b>&lt;metadata&gt;</b> element.
function Head:addMetaData(metadata)
  if((type(metadata) == "table"
    and metadata["getNameElem"] ~= nil
    and metadata:getNameElem() ~= "metadata")
    or (type(metadata) == "table"
    and metadata["getNameElem"] == nil)
    or type(metadata) ~= "table")then
    error("Error! Invalid metadata element!", 2)
  end

  local p = self:getPosAvailable("meta", "connectorBase", "descriptorBase", "regionBase",
    "transitionBase", "ruleBase", "importedDocumentBase")

  if(p ~= nil)then
    self:addChild(metadata, p)
  else
    self:addChild(metadata, 1)
  end

  table.insert(self.metadatas, metadata)
end

---
-- Returns a <b>&lt;metadata&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Head] getMetaDataPos
-- @param #number p  position of the object representing the <b>&lt;metadata&gt;</b> element.
function Head:getMetaDataPos(p)
  if(self.metadatas == nil)then
    error("Error! head element with nil metadatas list!", 2)
  elseif(p > #self.metadatas)then
    error("Error! head element doesn't have a metadata child in position "..p.."!", 2)
  end

  return self.metadatas[p]
end

---
-- Adds so many <b>&lt;metadata&gt;</b> child elements of the <b>&lt;head&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Head] setMetaDatas
-- @param #Metadata ... objects representing the <b>&lt;metadata&gt;</b> element.
function Head:setMetaDatas(...)
  if(#arg>0)then
    for _, metadata in ipairs(arg) do
      self:addMedia(metadata)
    end
  end
end

---
-- Removes a <b>&lt;metadata&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element. 
-- 
-- @function [parent=#Head] removeMetaData
-- @param #Metadata metadata object representing the <b>&lt;metadata&gt;</b> element.
function Head:removeMetaData(metadata)
  if((type(metadata) == "table"
    and metadata["getNameElem"] ~= nil
    and metadata:getNameElem() ~= "metadata")
    or (type(metadata) == "table"
    and metadata["getNameElem"] == nil)
    or type(metadata) ~= "table")then
    error("Error! Invalid metadata element!", 2)
  elseif(self.children == nil)then
    error("Error! head element with nil children list!", 2)
  elseif(self.metadatas == nil)then
    error("Error! head element with nil metadatas list!", 2)
  end

  self:removeChild(metadata)

  for p, mt in ipairs(self.metadatas) do
    if(metadata == mt)then
      table.remove(self.metadatas, p)
    end
  end
end

---
-- Removes a <b>&lt;metadata&gt;</b> child element of the 
-- <b>&lt;head&gt;</b> element in position `p`.
-- 
-- @function [parent=#Head] removeMetaDataPos
-- @param #number p position of the <b>&lt;metadata&gt;</b> child element.
function Head:removeMetaDataPos(p)
  if(self.children == nil)then
    error("Error! head element with nil children list!", 2)
  elseif(self.metadatas == nil)then
    error("Error! head element with nil metadatas list!", 2)
  elseif(p > #self.children)then
    error("Error! head element doesn't have a metadata child in position "..p.."!", 2)
  elseif(p > #self.metadatas)then
    error("Error! head element doesn't have a metadata child in position "..p.."!", 2)
  end

  self:removeChild(self.metadatas[p])
  table.remove(self.metadatas, p)
end

return Head