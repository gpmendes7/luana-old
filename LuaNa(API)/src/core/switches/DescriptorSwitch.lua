local NCLElem = require "core/NCLElem"
local DefaultDescriptor = require "core/switches/DefaultDescriptor"
local BindRule = require "core/switches/BindRule"
local Descriptor = require "core/layout/Descriptor"

local DescriptorSwitch = NCLElem:extends()

DescriptorSwitch.nameElem = "descriptorSwitch"

DescriptorSwitch.childrenMap = {
  defaultDescriptor = {DefaultDescriptor, "one"},
  bindRule = {BindRule, "many"},
  descriptor = {Descriptor, "many"}
}

DescriptorSwitch.attributesTypeMap = {
  id = "string"
}

function DescriptorSwitch:create(attributes, full)
  local descriptorSwitch = DescriptorSwitch:new()

  descriptorSwitch.id = nil

  if(attributes ~= nil)then
    descriptorSwitch:setAttributes(attributes)
  end

  descriptorSwitch.children = {}
  descriptorSwitch.defaultDescriptor = {}
  descriptorSwitch.bindRules = {}
  descriptorSwitch.descriptors = {}

  descriptorSwitch.ass = {}

  if(full ~= nil)then
    descriptorSwitch:setDefaultDescriptor(DefaultDescriptor:create())
    descriptorSwitch:addBindRule(BindRule:create(nil, full))
    descriptorSwitch:addDescriptor(Descriptor:create(nil, full))
  end

  return descriptorSwitch
end

function DescriptorSwitch:setId(id)
  self:addAttribute("id", id)
end

function DescriptorSwitch:getId()
  return self:getAttribute("id")
end

function DescriptorSwitch:setDefaultDescriptor(defaultDescriptor)
  if((type(defaultDescriptor) == "table"
    and defaultDescriptor["getNameElem"] ~= nil
    and defaultDescriptor:getNameElem() ~= "defaultDescriptor")
    or (type(defaultDescriptor) == "table"
    and defaultDescriptor["getNameElem"] == nil)
    or type(defaultDescriptor) ~= "table")then
    error("Error! Invalid defaultDescriptor element!", 2)
  end

  self:addChild(defaultDescriptor, 1)
  self.defaultDescriptor = defaultDescriptor
end

function DescriptorSwitch:getDefaultDescriptor()
  return self.defaultDescriptor
end

function DescriptorSwitch:removeDefaultDescriptor()
  self:removeChild(self.defaultDescriptor)
  self.defaultDescriptor = nil
end

function DescriptorSwitch:addBindRule(bindRule)
  if((type(bindRule) == "table"
    and bindRule["getNameElem"] ~= nil
    and bindRule:getNameElem() ~= "bindRule")
    or (type(bindRule) == "table"
    and bindRule["getNameElem"] == nil)
    or type(bindRule) ~= "table")then
    error("Error! Invalid bindRule element!", 2)
  end

  self:addChild(bindRule)
  table.insert(self.bindRules, bindRule)
end

function DescriptorSwitch:getBindRulePos(p)
  if(self.bindRules == nil)then
    error("Error! descriptorSwitch element with nil bindRules list!", 2)
  elseif(p > #self.bindRules)then
    error("Error! descriptorSwitch element doesn't have a bindRule child in position "..p.."!", 2)
  end

  return self.bindRules[p]
end

function DescriptorSwitch:getBindRuleById(id)
  if(id == nil)then
    error("Error! id attribute of bindRule element must be informed!", 2)
  elseif(self.bindRules == nil)then
    error("Error! descriptorSwitch element with nil bindRules list!", 2)
  end

  for _, bindRule in ipairs(self.bindRules) do
    if(bindRule:getId() == id)then
      return bindRule
    end
  end

  return nil
end

function DescriptorSwitch:setBindRules(...)
  if(#arg>0)then
    for _, bindRule in ipairs(arg) do
      self:addBindRule(bindRule)
    end
  end
end

function DescriptorSwitch:removeBindRule(bindRule)
  if((type(bindRule) == "table"
    and bindRule["getNameElem"] ~= nil
    and bindRule:getNameElem() ~= "bindRule")
    or (type(bindRule) == "table"
    and bindRule["getNameElem"] == nil)
    or type(bindRule) ~= "table")then
    error("Error! Invalid bindRule element!")
  elseif(self.children == nil)then
    error("Error! descriptorSwitch element with nil children list!", 2)
  elseif(self.bindRules == nil)then
    error("Error! descriptorSwitch element with nil bindRules list!", 2)
  end

  self:removeChild(bindRule)

  for p, cc in ipairs(self.bindRules) do
    if(bindRule == cc)then
      table.remove(self.bindRules, p)
    end
  end
end

function DescriptorSwitch:removeBindRulePos(p)
  if(self.children == nil)then
    error("Error! descriptorSwitch element with nil children list!", 2)
  elseif(self.bindRules == nil)then
    error("Error! descriptorSwitch element with nil bindRules list!", 2)
  elseif(p > #self.children)then
    error("Error! descriptorSwitch element doesn't have a bindRule child in position "..p.."!", 2)
  elseif(p > #self.bindRules)then
    error("Error! descriptorSwitch element doesn't have a bindRule child in position "..p.."!", 2)
  end

  self:removeChild(self.bindRules[p])
  table.remove(self.bindRules, p)
end

function DescriptorSwitch:addDescriptor(descriptor)
  if((type(descriptor) == "table"
    and descriptor["getNameElem"] ~= nil
    and descriptor:getNameElem() ~= "descriptor")
    or (type(descriptor) == "table"
    and descriptor["getNameElem"] == nil)
    or type(descriptor) ~= "table")then
    error("Error! Invalid descriptor element!", 2)
  end

  self:addChild(descriptor)
  table.insert(self.descriptors, descriptor)
end

function DescriptorSwitch:getDescriptorPos(p)
  if(self.descriptors == nil)then
    error("Error! descriptorSwitch element with nil descriptors list!", 2)
  elseif(p > #self.descriptors)then
    error("Error! descriptorSwitch element doesn't have a descriptor child in position "..p.."!", 2)
  end

  return self.descriptors[p]
end

function DescriptorSwitch:getDescriptorById(id)
  if(id == nil)then
    error("Error! id attribute of descriptor element must be informed!", 2)
  elseif(self.descriptors == nil)then
    error("Error! descriptorSwitch element with nil descriptors list!", 2)
  end

  for _, descriptor in ipairs(self.descriptors) do
    if(descriptor:getId() == id)then
      return descriptor
    end
  end

  return nil
end

function DescriptorSwitch:setDescriptors(...)
  if(#arg>0)then
    for _, descriptor in ipairs(arg) do
      self:addDescriptor(descriptor)
    end
  end
end

function DescriptorSwitch:removeDescriptor(descriptor)
  if((type(descriptor) == "table"
    and descriptor["getNameElem"] ~= nil
    and descriptor:getNameElem() ~= "descriptor")
    or (type(descriptor) == "table"
    and descriptor["getNameElem"] == nil)
    or type(descriptor) ~= "table")then
    error("Error! Invalid descriptor element!", 2)
  elseif(self.children == nil)then
    error("Error! descriptorSwitch element with nil children list!", 2)
  elseif(self.descriptors == nil)then
    error("Error! descriptorSwitch element with nil descriptors list!", 2)
  end

  self:removeChild(descriptor)

  for p, dc in ipairs(self.descriptors) do
    if(descriptor == dc)then
      table.remove(self.descriptors, p)
    end
  end
end

function DescriptorSwitch:removeDescriptorPos(p)
  if(self.children == nil)then
    error("Error! descriptorSwitch element with nil children list!", 2)
  elseif(self.descriptors == nil)then
    error("Error! descriptorSwitch element with nil descriptors list!", 2)
  elseif(p > #self.children)then
    error("Error! descriptorSwitch element doesn't have a descriptor child in position "..p.."!", 2)
  elseif(p > #self.descriptors)then
    error("Error! descriptorSwitch element doesn't have a descriptor child in position "..p.."!", 2)
  end

  self:removeChild(self.descriptors[p])
  table.remove(self.descriptors, p)
end

return DescriptorSwitch