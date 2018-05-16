local NCLElem = require "core/NCLElem"
local ImportedDocumentBase = require "core/importation/ImportedDocumentBase"
local RuleBase = require "core/switches/RuleBase"
local TransitionBase = require "core/transition/TransitionBase"
local RegionBase = require "core/layout/RegionBase"
local DescriptorBase = require "core/layout/DescriptorBase"
local ConnectorBase = require "core/connectors/ConnectorBase"
local Meta = require "core/metadata/Meta"
local MetaData = require "core/metadata/MetaData"

local Head = NCLElem:extends()

Head.nameElem = "head"

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

function Head:getImportedDocumentBase()
  return self.importedDocumentBase
end

function Head:removeImportedDocumentBase()
  self:removeChild(self.importedDocumentBase)
  self.importedDocumentBase = nil
end

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

function Head:getRuleBase()
  return self.ruleBase
end

function Head:removeRuleBase()
  self:removeChild(self.ruleBase)
  self.ruleBase = nil
end

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

function Head:getTransitionBase()
  return self.transitionBase
end

function Head:removeTransitionBase()
  self:removeChild(self.transitionBase)
  self.transitionBase = nil
end

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

function Head:getRegionBasePos(p)
  return self.regionBases[p]
end

function Head:getRegionBaseById(id)
  for _, regionBase in ipairs(self.regionBases) do
    if(regionBase:getId() == id)then
      return regionBase
    end
  end

  return nil
end

function Head:setRegionBases(...)
  if(#arg>0)then
    for _, regionBase in ipairs(arg) do
      self:addRegionBase(regionBase)
    end
  end
end

function Head:removeRegionBase(regionBase)
  if((type(regionBase) == "table"
    and regionBase["getNameElem"] ~= nil
    and regionBase:getNameElem() ~= "regionBase")
    or (type(regionBase) == "table"
    and regionBase["getNameElem"] == nil)
    or type(regionBase) ~= "table")then
    error("Error! Invalid regionBase element!", 2)
  end


  self:removeChild(regionBase)

  for p, rb in ipairs(self.regionBases) do
    if(regionBase == rb)then
      table.remove(self.regionBases, p)
    end
  end
end

function Head:removeRegionBasePos(p)
  self:removeChildPos(p)
  table.remove(self.regionBases, p)
end

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

function Head:getDescriptorBase()
  return self.descriptorBase
end

function Head:removeDescriptorBase()
  self:removeChild(self.descriptorBase)
  self.descriptorBase = nil
end

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

function Head:getConnectorBase()
  return self.connectorBase
end

function Head:removeConnectorBase()
  self:removeChild(self.connectorBase)
  self.connectorBase = nil
end

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

function Head:getMetaPos(p)
  if(p > #self.metas)then
    error("Error! head element doesn't have a meta child in position "..p.."!", 2)
  end

  return self.metas[p]
end

function Head:setMetas(...)
  if(#arg>0)then
    for _, meta in ipairs(arg) do
      self:addMedia(meta)
    end
  end
end
function Head:removeMeta(meta)
  if((type(meta) == "table"
    and meta["getNameElem"] ~= nil
    and meta:getNameElem() ~= "meta")
    or (type(meta) == "table"
    and meta["getNameElem"] == nil)
    or type(meta) ~= "table")then
    error("Error! Invalid meta element!", 2)
  end

  self:removeChild(meta)

  for p, mt in ipairs(self.metas) do
    if(meta == mt)then
      table.remove(self.metas, p)
    end
  end
end

function Head:removeMetaPos(p)
  self:removeChildPos(p)
  table.remove(self.metas, p)
end

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

function Head:getMetaDataPos(p)
  return self.metadatas[p]
end

function Head:setMetaDatas(...)
  if(#arg>0)then
    for _, metadata in ipairs(arg) do
      self:addMedia(metadata)
    end
  end
end

function Head:removeMetaData(metadata)
  if((type(metadata) == "table"
    and metadata["getNameElem"] ~= nil
    and metadata:getNameElem() ~= "metadata")
    or (type(metadata) == "table"
    and metadata["getNameElem"] == nil)
    or type(metadata) ~= "table")then
    error("Error! Invalid metadata element!", 2)
  end

  self:removeChild(metadata)

  for p, mt in ipairs(self.metadatas) do
    if(metadata == mt)then
      table.remove(self.metadatas, p)
    end
  end
end

function Head:removeMetaDataPos(p)
  self:removeChildPos(p)
  table.remove(self.metadatas, p)
end

return Head