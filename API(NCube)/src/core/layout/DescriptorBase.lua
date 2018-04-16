local NCLElem = require "core/NCLElem"
local DescriptorSwitch = require "core/switches/DescriptorSwitch"
local ImportBase = require "core/importation/ImportBase"
local Descriptor = require "core/layout/Descriptor"

local DescriptorBase = NCLElem:extends()

DescriptorBase.name = "descriptorBase"

DescriptorBase.childrenMap = {
  descriptorSwitch = {DescriptorSwitch, "many"},
  importBase = {ImportBase, "many"},
  descriptor = {Descriptor, "many"}
}

DescriptorBase.attributesTypeMap = {
  id = "string"
}

function DescriptorBase:create(attributes, full)
  local descriptorBase = DescriptorBase:new()

  descriptorBase.id = nil

  if(attributes ~= nil)then
    descriptorBase:setAttributes(attributes)
  end

  descriptorBase.children = {}
  descriptorBase.importBases = {}
  descriptorBase.descriptors = {}
  descriptorBase.descriptorSwitchs = {}

  if(full ~= nil)then
    descriptorBase:addImportBase(ImportBase:create())
    descriptorBase:addDescriptor(Descriptor:create(nil, full))
    descriptorBase:addDescriptorSwitch(DescriptorSwitch:create(nil, full))
  end

  return descriptorBase
end

function DescriptorBase:setId(id)
  self:addAttribute("id", id)
end

function DescriptorBase:getId()
  return self:getAttribute("id")
end

function DescriptorBase:addDescriptorSwitch(descriptorSwitch)
  self:addChild(descriptorSwitch)
  table.insert(self.descriptorSwitchs, descriptorSwitch)
end

function DescriptorBase:getDescriptorSwitchPos(p)
  if(p > #self.descriptors)then
    error("Error! descriptorBase element doesn't have a descriptorSwitch child in position "..p.."!", 2)
  end

  return self.descriptorSwitchs[p]
end

function DescriptorBase:getDescriptorSwitchById(id)
  if(id == nil)then
    error("Error! id attribute of descriptorSwitch element must be informed!", 2)
  end

  for _, descriptorSwitch in ipairs(self.descriptorSwitchs) do
    if(descriptorSwitch:getId() == id)then
      return descriptorSwitch
    end
  end

  return nil
end

function DescriptorBase:setDescriptorSwitchs(...)
  if(#arg>0)then
    for _, descriptorSwitch in ipairs(arg) do
      self:addDescriptorSwitch(descriptorSwitch)
    end
  end
end

function DescriptorBase:removeDescriptorSwitch(descriptorSwitch)
  self:removeChild(descriptorSwitch)

  for p, dc in ipairs(self.descriptorSwitchs) do
    if(descriptorSwitch == dc)then
      table.remove(self.descriptorSwitchs, p)
    end
  end
end

function DescriptorBase:removeDescriptorSwitchPos(p)
  self:removeChildPos(p)
  table.remove(self.descriptorSwitchs, p)
end

function DescriptorBase:addImportBase(importBase)
  self:addChild(importBase)
  table.insert(self.importBases, importBase)
end

function DescriptorBase:getImportBasePos(p)
  if(p > #self.importBases)then
    error("Error! descriptorBase element doesn't have a importBase child in position "..p.."!", 2)
  end

  return self.importBases[p]
end

function DescriptorBase:getImportBaseByAlias(alias)
  if(alias == nil)then
    error("Error! alias attribute of importBase element must be informed!", 2)
  end

  for _, importBase in ipairs(self.importBases) do
    if(importBase:getAlias() == alias)then
      return importBase
    end
  end

  return nil
end

function DescriptorBase:setImportBases(...)
  if(#arg>0)then
    for _, importBase in ipairs(arg) do
      self:addRule(importBase)
    end
  end
end

function DescriptorBase:removeImportBase(importBase)
  self:removeChild(importBase)

  for p, ib in ipairs(self.importBases) do
    if(importBase == ib)then
      table.remove(self.importBases, p)
    end
  end
end

function DescriptorBase:removeImportBasePos(p)
  self:removeChildPos(p)
  table.remove(self.importBases, p)
end

function DescriptorBase:addDescriptor(descriptor)
  self:addChild(descriptor)
  table.insert(self.descriptors, descriptor)
end

function DescriptorBase:getDescriptorPos(p)
  if(p > #self.descriptors)then
    error("Error! descriptorBase element doesn't have a descriptor child in position "..p.."!", 2)
  end

  return self.descriptors[p]
end

function DescriptorBase:getDescriptorById(id)
  if(id == nil)then
    error("Error! id attribute of descriptor element must be informed!", 2)
  end

  for _, descriptor in ipairs(self.descriptors) do
    if(descriptor:getId() == id)then
      return descriptor
    end
  end

  return nil
end

function DescriptorBase:setDescriptors(...)
  if(#arg>0)then
    for _, descriptor in ipairs(arg) do
      self:addDescriptor(descriptor)
    end
  end
end

function DescriptorBase:removeDescriptor(descriptor)
  self:removeChild(descriptor)

  for p, dc in ipairs(self.descriptors) do
    if(descriptor == dc)then
      table.remove(self.descriptors, p)
    end
  end
end

function DescriptorBase:removeDescriptorPos(p)
  self:removeChildPos(p)
  table.remove(self.descriptors, p)
end

return DescriptorBase
