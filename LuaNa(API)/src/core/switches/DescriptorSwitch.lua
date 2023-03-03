local NCLElem = require "LuaNa(API)/src/core/NCLElem"
local DefaultDescriptor = require "LuaNa(API)/src/core/switches/DefaultDescriptor"
local BindRule = require "LuaNa(API)/src/core/switches/BindRule"
local Descriptor = require "LuaNa(API)/src/core/layout/Descriptor"

---
-- Implements DescriptorSwitch Class representing <b>&lt;descriptorSwitch&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=descriptorswitch">
-- http://handbook.ncl.org.br/doku.php?id=descriptorswitch</a>
-- 
-- @module DescriptorSwitch
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local DescriptorSwitch = require "core/switches/DescriptorSwitch"
local DescriptorSwitch = NCLElem:extends()

---
-- Name of <b>&lt;descriptorSwitch&gt;</b> element.
-- 
-- @field [parent=#DescriptorSwitch] #string nameElem
DescriptorSwitch.nameElem = "descriptorSwitch"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;descriptorSwitch&gt;</b> element.
-- 
-- @field [parent=#DescriptorSwitch] #table childrenMap
DescriptorSwitch.childrenMap = {
  defaultDescriptor = {DefaultDescriptor, "one"},
  bindRule = {BindRule, "many"},
  descriptor = {Descriptor, "many"}
}

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;descriptorSwitch&gt;</b> element.
-- 
-- @field [parent=#DescriptorSwitch] #table attributesTypeMap 
DescriptorSwitch.attributesTypeMap = {
  id = "string"
}

---
-- Returns a new DescriptorSwitch object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#DescriptorSwitch] create
-- @param #table attributes list of attributes to be initialized.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #DescriptorSwitch new DescriptorSwitch object created.
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

---
-- Sets a value to `id` attribute of the 
-- <b>&lt;descriptorSwitch&gt;</b> element. 
-- 
-- @function [parent=#DescriptorSwitch] setId
-- @param #string id `id` attribute of the
-- <b>&lt;descriptorSwitch&gt;</b> element.
function DescriptorSwitch:setId(id)
  self:addAttribute("id", id)
end

---
-- Returns the value of the `id` attribute of the 
-- <b>&lt;descriptorSwitch&gt;</b> element. 
-- 
-- @function [parent=#DescriptorSwitch] getId
-- @return #string `id` attribute of the <b>&lt;descriptorSwitch&gt;</b> element.
function DescriptorSwitch:getId()
  return self:getAttribute("id")
end

---
-- Sets the <b>&lt;defaultDescriptor&gt;</b> child element of the 
-- <b>&lt;descriptorSwitch&gt;</b> element. 
-- 
-- @function [parent=#DescriptorSwitch] setDefaultDescriptor
-- @param #DefaultDescriptor defaultDescriptor object representing the 
-- <b>&lt;defaultDescriptor&gt;</b> element.
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

---
-- Returns the <b>&lt;defaultDescriptor&gt;</b> child element of the 
-- <b>&lt;descriptorSwitch&gt;</b> element.
--  
-- @function [parent=#DescriptorSwitch] getDefaultDescriptor
-- @return #DefaultDescriptor defaultDescriptor object representing the <b>&lt;defaultDescriptor&gt;</b> element.
function DescriptorSwitch:getDefaultDescriptor()
  return self.defaultDescriptor
end

---
-- Removes the <b>&lt;defaultDescriptor&gt;</b> child element of the 
-- <b>&lt;descriptorSwitch&gt;</b> element.
-- 
-- @function [parent=#DescriptorSwitch] removeDefaultDescriptor
function DescriptorSwitch:removeDefaultDescriptor()
  self:removeChild(self.defaultDescriptor)
  self.defaultDescriptor = nil
end

---
-- Adds a <b>&lt;bindRule&gt;</b> child element of the 
-- <b>&lt;descriptorSwitch&gt;</b> element. 
-- 
-- @function [parent=#DescriptorSwitch] addBindRule
-- @param #BindRule bindRule object representing the 
-- <b>&lt;bindRule&gt;</b> element.
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

---
-- Returns a <b>&lt;bindRule&gt;</b> child element of the 
-- <b>&lt;descriptorSwitch&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#DescriptorSwitch] getBindRulePos
-- @param #number p  position of the object representing 
-- the <b>&lt;bindRule&gt;</b> element.
function DescriptorSwitch:getBindRulePos(p)
  if(self.bindRules == nil)then
    error("Error! descriptorSwitch element with nil bindRules list!", 2)
  elseif(p > #self.bindRules)then
    error("Error! descriptorSwitch element doesn't have a bindRule child in position "..p.."!", 2)
  end

  return self.bindRules[p]
end

---
-- Returns a <b>&lt;bindRule&gt;</b> child element of the 
-- <b>&lt;descriptorSwitch&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#DescriptorSwitch] getBindRuleById
-- @param #string id `id` attribute of the <b>&lt;bindRule&gt;</b> element.
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

---
-- Adds so many <b>&lt;bindRule&gt;</b> child elements of the <b>&lt;descriptorSwitch&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#DescriptorSwitch] setBindRules
-- @param #BindRule ... objects representing the <b>&lt;bindRule&gt;</b> element.
function DescriptorSwitch:setBindRules(...)
  if(#arg>0)then
    for _, bindRule in ipairs(arg) do
      self:addBindRule(bindRule)
    end
  end
end

---
-- Removes a <b>&lt;bindRule&gt;</b> child element of the 
-- <b>&lt;descriptorSwitch&gt;</b> element. 
-- 
-- @function [parent=#DescriptorSwitch] removeBindRule
-- @param #BindRule bindRule object representing the <b>&lt;bindRule&gt;</b> element.
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

---
-- Removes a <b>&lt;bindRule&gt;</b> child element of the 
-- <b>&lt;descriptorSwitch&gt;</b> element in position `p`.
-- 
-- @function [parent=#DescriptorSwitch] removeBindRulePos
-- @param #number p position of the <b>&lt;bindRule&gt;</b> child element.
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

---
-- Adds a <b>&lt;descriptor&gt;</b> child element of the 
-- <b>&lt;descriptorSwitch&gt;</b> element. 
-- 
-- @function [parent=#DescriptorSwitch] addDescriptor
-- @param #Descriptor descriptor object representing the 
-- <b>&lt;descriptor&gt;</b> element.
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

---
-- Returns a <b>&lt;descriptor&gt;</b> child element of the 
-- <b>&lt;descriptorSwitch&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#DescriptorSwitch] getDescriptorPos
-- @param #number p  position of the object representing 
-- the <b>&lt;descriptor&gt;</b> element.
function DescriptorSwitch:getDescriptorPos(p)
  if(self.descriptors == nil)then
    error("Error! descriptorSwitch element with nil descriptors list!", 2)
  elseif(p > #self.descriptors)then
    error("Error! descriptorSwitch element doesn't have a descriptor child in position "..p.."!", 2)
  end

  return self.descriptors[p]
end

---
-- Returns a <b>&lt;descriptor&gt;</b> child element of the 
-- <b>&lt;descriptorSwitch&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#DescriptorSwitch] getDescriptorById
-- @param #string id `id` attribute of the <b>&lt;descriptor&gt;</b> element.
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

---
-- Adds so many <b>&lt;descriptor&gt;</b> child elements of the <b>&lt;descriptorSwitch&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#DescriptorSwitch] setDescriptors
-- @param #Descriptor ... objects representing the <b>&lt;descriptor&gt;</b> element.
function DescriptorSwitch:setDescriptors(...)
  if(#arg>0)then
    for _, descriptor in ipairs(arg) do
      self:addDescriptor(descriptor)
    end
  end
end

---
-- Removes a <b>&lt;descriptor&gt;</b> child element of the 
-- <b>&lt;descriptorSwitch&gt;</b> element. 
-- 
-- @function [parent=#DescriptorSwitch] removeDescriptor
-- @param #Descriptor descriptor object representing the <b>&lt;descriptor&gt;</b> element.
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

---
-- Removes a <b>&lt;descriptor&gt;</b> child element of the 
-- <b>&lt;descriptorSwitch&gt;</b> element in position `p`.
-- 
-- @function [parent=#DescriptorSwitch] removeDescriptorPos
-- @param #number p position of the <b>&lt;descriptor&gt;</b> child element.
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