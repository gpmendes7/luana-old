local NCLElem = require "LuaNa(API)/src/core/NCLElem"

---
-- Implements DefaultDescriptor Class representing <b>&lt;defaultDescriptor&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=defaultdescriptor">
-- http://handbook.ncl.org.br/doku.php?id=defaultdescriptor</a>
-- 
-- @module DefaultDescriptor
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local DefaultDescriptor = require "core/switches/DefaultDescriptor" 
local DefaultDescriptor = NCLElem:extends()

---
-- Name of <b>&lt;defaultDescriptor&gt;</b> element.
-- 
-- @field [parent=#DefaultDescriptor] #string nameElem 
DefaultDescriptor.nameElem = "defaultDescriptor"

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;defaultDescriptor&gt;</b> element.
-- 
-- @field [parent=#DefaultDescriptor] #table attributesTypeMap
DefaultDescriptor.attributesTypeMap = {
  descriptor = "string"
}

---
-- List with associative map that connects an attribute to an specific object
-- representing a child NCL element of <b>&lt;defaultDescriptor&gt;</b> element.
-- 
-- @field [parent=#DefaultDescriptor] #table assMap
DefaultDescriptor.assMap = {
  {"descriptor", "descriptorAss"}
}

---
-- Returns a new DefaultDescriptor object. 
-- 
-- @function [parent=#DefaultDescriptor] create
-- @param #table attributes list of attributes to be initialized.
-- @return #DefaultDescriptor new DefaultDescriptor object created.
function DefaultDescriptor:create(attributes)
  local defaultDescriptor = DefaultDescriptor:new()

  defaultDescriptor.descriptor = nil

  defaultDescriptor.descriptorAss = nil

  if(attributes ~= nil)then
    defaultDescriptor:setAttributes(attributes)
  end

  return defaultDescriptor
end

---
-- Sets a value to `descriptor` attribute of the 
-- <b>&lt;defaultDescriptor&gt;</b> element. 
-- 
-- @function [parent=#DefaultDescriptor] setDescriptor
-- @param #stringOrObject descriptor `descriptor` attribute of the
-- <b>&lt;defaultDescriptor&gt;</b> element.
function DefaultDescriptor:setDescriptor(descriptor)
  if(type(descriptor) == "table"
    and descriptor["getNameElem"] ~= nil
    and descriptor:getNameElem() == "descriptor")then
    self:addAttribute("descriptor", descriptor:getId())
    self.descriptorAss = descriptor
    table.insert(descriptor.ass, self)
  elseif(type(descriptor) == "string" )then
    self:addAttribute("descriptor", descriptor)
  else
    error("Error! Invalid descriptor element!", 2)
  end
end

---
-- Returns the value of the `descriptor` attribute of the 
-- <b>&lt;defaultDescriptor&gt;</b> element. 
-- 
-- @function [parent=#DefaultDescriptor] getDescriptor
-- @return #string `descriptor` attribute of the <b>&lt;defaultDescriptor&gt;</b> element.
function DefaultDescriptor:getDescriptor()
  return self:getAttribute("descriptor")
end

---
-- Returns the descriptor associated to
-- <b>&lt;defaultDescriptor&gt;</b> element. 
-- 
-- @function [parent=#DefaultDescriptor] getDescriptorAss
-- @return #object descriptor associated to <b>&lt;defaultDescriptor&gt;</b> element.
function DefaultDescriptor:getDescriptorAss()
  return self.descriptorAss
end

return DefaultDescriptor