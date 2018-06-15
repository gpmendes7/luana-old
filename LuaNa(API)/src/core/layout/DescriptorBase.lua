local NCLElem = require "core/NCLElem"
local DescriptorSwitch = require "core/switches/DescriptorSwitch"
local ImportBase = require "core/importation/ImportBase"
local Descriptor = require "core/layout/Descriptor"

---
-- Implements DescriptorBase Class representing <b>&lt;descriptorBase&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=descriptorbase">
-- http://handbook.ncl.org.br/doku.php?id=descriptorbase</a>
-- 
-- @module DescriptorBase
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local DescriptorBase = require "core/layout/DescriptorBase" 
local DescriptorBase = NCLElem:extends()

---
-- Name of <b>&lt;descriptorBase&gt;</b> element.
-- 
-- @field [parent=#DescriptorBase] #string nameElem 
DescriptorBase.nameElem = "descriptorBase"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;descriptorBase&gt;</b> element.
-- 
-- @field [parent=#DescriptorBase] #table childrenMap
DescriptorBase.childrenMap = {
  descriptorSwitch = {DescriptorSwitch, "many"},
  importBase = {ImportBase, "many"},
  descriptor = {Descriptor, "many"}
}

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;descriptorBase&gt;</b> element.
-- 
-- @field [parent=#DescriptorBase] #table attributesTypeMap 
DescriptorBase.attributesTypeMap = {
  id = "string"
}

---
-- Returns a new DescriptorBase object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#DescriptorBase] create
-- @param #table attributes list of attributes to be initialized.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #DescriptorBase DescriptorBase object created.
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

---
-- Sets a value to `id` attribute of the 
-- <b>&lt;descriptorBase&gt;</b> element. 
-- 
-- @function [parent=#DescriptorBase] setId
-- @param #string id `id` attribute of the
-- <b>&lt;descriptorBase&gt;</b> element.
function DescriptorBase:setId(id)
  self:addAttribute("id", id)
end

---
-- Returns the value of the `id` attribute of the 
-- <b>&lt;descriptorBase&gt;</b> element. 
-- 
-- @function [parent=#DescriptorBase] getId
-- @return #string `id` attribute of the <b>&lt;descriptorBase&gt;</b> element.
function DescriptorBase:getId()
  return self:getAttribute("id")
end

---
-- Adds a <b>&lt;descriptorSwitch&gt;</b> child element of the 
-- <b>&lt;descriptorBase&gt;</b> element. 
-- 
-- @function [parent=#DescriptorBase] addDescriptorSwitch
-- @param #DescriptorSwitch descriptorSwitch object representing the 
-- <b>&lt;descriptorSwitch&gt;</b> element.
function DescriptorBase:addDescriptorSwitch(descriptorSwitch)
  if((type(descriptorSwitch) == "table"
    and descriptorSwitch["getNameElem"] ~= nil
    and descriptorSwitch:getNameElem() ~= "descriptorSwitch")
    or (type(descriptorSwitch) == "table"
    and descriptorSwitch["getNameElem"] == nil)
    or type(descriptorSwitch) ~= "table")then
    error("Error! Invalid descriptorSwitch element!", 2)
  end

  self:addChild(descriptorSwitch)
  table.insert(self.descriptorSwitchs, descriptorSwitch)
end

---
-- Returns a <b>&lt;descriptorSwitch&gt;</b> child element of the 
-- <b>&lt;descriptorBase&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#DescriptorBase] getDescriptorSwitchPos
-- @param #number p  position of the object representing 
-- the <b>&lt;descriptorSwitch&gt;</b> element.
function DescriptorBase:getDescriptorSwitchPos(p)
  if(self.descriptorSwitchs == nil)then
    error("Error! descriptorBase element with nil descriptorSwitchs list!", 2)
  elseif(p > #self.descriptorSwitchs)then
    error("Error! descriptorBase element doesn't have a descriptorSwitch child in position "..p.."!", 2)
  end

  return self.descriptorSwitchs[p]
end

---
-- Returns a <b>&lt;descriptorSwitch&gt;</b> child element of the 
-- <b>&lt;descriptorBase&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#DescriptorBase] getDescriptorSwitchById
-- @param #string id `id` attribute of the <b>&lt;descriptorSwitch&gt;</b> element.
function DescriptorBase:getDescriptorSwitchById(id)
  if(id == nil)then
    error("Error! id attribute of descriptorSwitch element must be informed!", 2)
  elseif(self.descriptorSwitchs == nil)then
    error("Error! descriptorBase element with nil descriptorSwitchs list!", 2)
  end

  for _, descriptorSwitch in ipairs(self.descriptorSwitchs) do
    if(descriptorSwitch:getId() == id)then
      return descriptorSwitch
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;descriptorSwitch&gt;</b> child elements of the <b>&lt;descriptorBase&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#DescriptorBase] setDescriptorSwitchs
-- @param #DescriptorSwitch ... objects representing the <b>&lt;descriptorSwitch&gt;</b> element.
function DescriptorBase:setDescriptorSwitchs(...)
  if(#arg>0)then
    for _, descriptorSwitch in ipairs(arg) do
      self:addDescriptorSwitch(descriptorSwitch)
    end
  end
end

---
-- Removes a <b>&lt;descriptorSwitch&gt;</b> child element of the 
-- <b>&lt;descriptorBase&gt;</b> element. 
-- 
-- @function [parent=#DescriptorBase] removeDescriptorSwitch
-- @param #DescriptorSwitch descriptorSwitch object representing the <b>&lt;descriptorSwitch&gt;</b> element.
function DescriptorBase:removeDescriptorSwitch(descriptorSwitch)
  if((type(descriptorSwitch) == "table"
    and descriptorSwitch["getNameElem"] ~= nil
    and descriptorSwitch:getNameElem() ~= "descriptorSwitch")
    or (type(descriptorSwitch) == "table"
    and descriptorSwitch["getNameElem"] == nil)
    or type(descriptorSwitch) ~= "table")then
    error("Error! Invalid descriptorSwitch element!", 2)
  elseif(self.children == nil)then
    error("Error! descriptorBase element with nil children list!", 2)
  elseif(self.descriptorSwitchs == nil)then
    error("Error! descriptorBase element with nil descriptorSwitchs list!", 2)
  end

  self:removeChild(descriptorSwitch)

  for p, dc in ipairs(self.descriptorSwitchs) do
    if(descriptorSwitch == dc)then
      table.remove(self.descriptorSwitchs, p)
    end
  end
end

---
-- Removes a <b>&lt;descriptorSwitch&gt;</b> child element of the 
-- <b>&lt;descriptorBase&gt;</b> element in position `p`.
-- 
-- @function [parent=#DescriptorBase] removeDescriptorParamPos
-- @param #number p position of the <b>&lt;descriptorSwitch&gt;</b> child element.
function DescriptorBase:removeDescriptorSwitchPos(p)
  if(self.children == nil)then
    error("Error! descriptorBase element with nil children list!", 2)
  elseif(self.descriptorSwitchs == nil)then
    error("Error! descriptorBase element with nil descriptorSwitchs list!", 2)
  elseif(p > #self.children)then
    error("Error! descriptorBase element doesn't have a descriptorSwitch child in position "..p.."!", 2)
  elseif(p > #self.descriptorSwitchs)then
    error("Error! descriptorBase element doesn't have a descriptorSwitch child in position "..p.."!", 2)
  end

  self:removeChild(self.descriptorSwitchs[p])
  table.remove(self.descriptorSwitchs, p)
end

---
-- Adds a <b>&lt;importBase&gt;</b> child element of the 
-- <b>&lt;descriptorBase&gt;</b> element. 
-- 
-- @function [parent=#DescriptorBase] addImportBase
-- @param #ImportBase importBase object representing the 
-- <b>&lt;importBase&gt;</b> element.
function DescriptorBase:addImportBase(importBase)
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
-- <b>&lt;descriptorBase&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#DescriptorBase] getImportBasePos
-- @param #number p  position of the object representing 
-- the <b>&lt;importBase&gt;</b> element.
function DescriptorBase:getImportBasePos(p)
  if(self.importBases == nil)then
    error("Error! descriptorBase element with nil importBases list!", 2)
  elseif(p > #self.importBases)then
    error("Error! descriptorBase element doesn't have a importBase child in position "..p.."!", 2)
  end

  return self.importBases[p]
end

---
-- Returns a <b>&lt;importBase&gt;</b> child element of the 
-- <b>&lt;descriptorBase&gt;</b> element
-- by `alias` attribute.
--  
-- @function [parent=#DescriptorBase] getImportBaseByAlias
-- @param #string alias `alias` attribute of the <b>&lt;importBase&gt;</b> element.
function DescriptorBase:getImportBaseByAlias(alias)
  if(alias == nil)then
    error("Error! alias attribute of importBase element must be informed!", 2)
  elseif(self.importBases == nil)then
    error("Error! descriptorBase element with nil importBases list!", 2)
  end

  for _, importBase in ipairs(self.importBases) do
    if(importBase:getAlias() == alias)then
      return importBase
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;importBase&gt;</b> child elements of the <b>&lt;descriptorBase&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#DescriptorBase] setImportBases
-- @param #ImportBase ... objects representing the <b>&lt;importBase&gt;</b> element.
function DescriptorBase:setImportBases(...)
  if(#arg>0)then
    for _, importBase in ipairs(arg) do
      self:addRule(importBase)
    end
  end
end

---
-- Removes a <b>&lt;importBase&gt;</b> child element of the 
-- <b>&lt;descriptorBase&gt;</b> element. 
-- 
-- @function [parent=#DescriptorBase] removeImportBase
-- @param #ImportBase importBase object representing the <b>&lt;importBase&gt;</b> element.
function DescriptorBase:removeImportBase(importBase)
  if((type(importBase) == "table"
    and importBase["getNameElem"] ~= nil
    and importBase:getNameElem() ~= "importBase")
    or (type(importBase) == "table"
    and importBase["getNameElem"] == nil)
    or type(importBase) ~= "table")then
    error("Error! Invalid importBase element!", 2)
  elseif(self.children == nil)then
    error("Error! descriptorBase element with nil children list!", 2)
  elseif(self.importBases == nil)then
    error("Error! descriptorBase element with nil importBases list!", 2)
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
-- <b>&lt;descriptorBase&gt;</b> element in position `p`.
-- 
-- @function [parent=#DescriptorBase] removeImportBasePos
-- @param #number p position of the <b>&lt;importBase&gt;</b> child element.
function DescriptorBase:removeImportBasePos(p)
  if(self.children == nil)then
    error("Error! descriptorBase element with nil children list!", 2)
  elseif(self.importBases == nil)then
    error("Error! descriptorBase element with nil importBases list!", 2)
  elseif(p > #self.children)then
    error("Error! descriptorBase element doesn't have a importBase child in position "..p.."!", 2)
  elseif(p > #self.importBases)then
    error("Error! descriptorBase element doesn't have a importBase child in position "..p.."!", 2)
  end

  self:removeChild(self.importBases[p])
  table.remove(self.importBases, p)
end

---
-- Adds a <b>&lt;descriptor&gt;</b> child element of the 
-- <b>&lt;descriptorBase&gt;</b> element. 
-- 
-- @function [parent=#DescriptorBase] addDescriptor
-- @param #Descriptor descriptor object representing the 
-- <b>&lt;descriptor&gt;</b> element.
function DescriptorBase:addDescriptor(descriptor)
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
-- <b>&lt;descriptorBase&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#DescriptorBase] getDescriptorPos
-- @param #number p  position of the object representing 
-- the <b>&lt;descriptor&gt;</b> element.
function DescriptorBase:getDescriptorPos(p)
  if(self.descriptors == nil)then
    error("Error! descriptorBase element with nil descriptors list!", 2)
  elseif(p > #self.descriptors)then
    error("Error! descriptorBase element doesn't have a descriptor child in position "..p.."!", 2)
  end

  return self.descriptors[p]
end

---
-- Returns a <b>&lt;descriptor&gt;</b> child element of the 
-- <b>&lt;descriptorBase&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#DescriptorBase] getDescriptorById
-- @param #string id `id` attribute of the <b>&lt;descriptor&gt;</b> element.
function DescriptorBase:getDescriptorById(id)
  if(id == nil)then
    error("Error! id attribute of descriptor element must be informed!", 2)
  elseif(self.descriptors == nil)then
    error("Error! descriptorBase element with nil descriptors list!", 2)
  end

  for _, descriptor in ipairs(self.descriptors) do
    if(descriptor:getId() == id)then
      return descriptor
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;descriptor&gt;</b> child elements of the <b>&lt;descriptorBase&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#DescriptorBase] setDescriptors
-- @param #Descriptor ... objects representing the <b>&lt;descriptor&gt;</b> element.
function DescriptorBase:setDescriptors(...)
  if(#arg>0)then
    for _, descriptor in ipairs(arg) do
      self:addDescriptor(descriptor)
    end
  end
end

---
-- Removes a <b>&lt;descriptor&gt;</b> child element of the 
-- <b>&lt;descriptorBase&gt;</b> element. 
-- 
-- @function [parent=#DescriptorBase] removeDescriptor
-- @param #Descriptor descriptor object representing the <b>&lt;descriptor&gt;</b> element.
function DescriptorBase:removeDescriptor(descriptor)
  if((type(descriptor) == "table"
    and descriptor["getNameElem"] ~= nil
    and descriptor:getNameElem() ~= "descriptor")
    or (type(descriptor) == "table"
    and descriptor["getNameElem"] == nil)
    or type(descriptor) ~= "table")then
    error("Error! Invalid descriptor element!", 2)
  elseif(self.children == nil)then
    error("Error! descriptorBase element with nil children list!", 2)
  elseif(self.descriptors == nil)then
    error("Error! descriptorBase element with nil descriptors list!", 2)
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
-- <b>&lt;descriptorBase&gt;</b> element in position `p`.
-- 
-- @function [parent=#DescriptorBase] removeDescriptorPos
-- @param #number p position of the <b>&lt;descriptor&gt;</b> child element.
function DescriptorBase:removeDescriptorPos(p)
  if(self.children == nil)then
    error("Error! descriptorBase element with nil children list!", 2)
  elseif(self.descriptors == nil)then
    error("Error! descriptorBase element with nil descriptors list!", 2)
  elseif(p > #self.children)then
    error("Error! descriptorBase element doesn't have a descriptor child in position "..p.."!", 2)
  elseif(p > #self.descriptors)then
    error("Error! descriptorBase element doesn't have a descriptor child in position "..p.."!", 2)
  end

  self:removeChild(self.descriptors[p])
  table.remove(self.descriptors, p)
end

return DescriptorBase