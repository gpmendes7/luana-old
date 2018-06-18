local NCLElem = require "core/NCLElem"
local Mapping = require "core/switches/Mapping"

---
-- Implements SwitchPort Class representing <b>&lt;switchPort&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=switchPort">
-- http://handbook.ncl.org.br/doku.php?id=switchPort</a>
-- 
-- @module SwitchPort
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local SwitchPort = require "core/switches/SwitchPort" 
local SwitchPort = NCLElem:extends()

---
-- Name of <b>&lt;switchPort&gt;</b> element.
-- 
-- @field [parent=#SwitchPort] #string nameElem
SwitchPort.nameElem = "switchPort"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;switchPort&gt;</b> element.
-- 
-- @field [parent=#SwitchPort] #table childrenMap
SwitchPort.childrenMap = {
  mapping = {Mapping, "many"}
}

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;switchPort&gt;</b> element.
-- 
-- @field [parent=#SwitchPort] #table attributesTypeMap  
SwitchPort.attributesTypeMap = {
  id = "string"
}

---
-- Returns a new SwitchPort object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#SwitchPort] create
-- @param #table attributes list of attributes to be initialized.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #SwitchPort new SwitchPort object created.
function SwitchPort:create(attributes, full)
  local switchPort = SwitchPort:new()

  switchPort.id = nil

  switchPort.ass = {}

  if(attributes ~= nil)then
    switchPort:setAttributes(attributes)
  end

  switchPort.children = {}
  switchPort.mappings = {}

  if(full ~= nil)then
    switchPort:addMapping(Mapping:create())
  end

  return switchPort
end

---
-- Sets a value to `id` attribute of the 
-- <b>&lt;switchPort&gt;</b> element. 
-- 
-- @function [parent=#SwitchPort] setId
-- @param #string id `id` attribute of the
-- <b>&lt;switchPort&gt;</b> element.
function SwitchPort:setId(id)
  self:addAttribute("id", id)
end

---
-- Returns the value of the `id` attribute of the 
-- <b>&lt;switchPort&gt;</b> element. 
-- 
-- @function [parent=#SwitchPort] getId
-- @return #string `id` attribute of the <b>&lt;switchPort&gt;</b> element.
function SwitchPort:getId()
  return self:getAttribute("id")
end

---
-- Adds a <b>&lt;mapping&gt;</b> child element of the 
-- <b>&lt;switchPort&gt;</b> element. 
-- 
-- @function [parent=#SwitchPort] addMapping
-- @param #Mapping mapping object representing the 
-- <b>&lt;mapping&gt;</b> element.
function SwitchPort:addMapping(mapping)
  if((type(mapping) == "table"
    and mapping["getNameElem"] ~= nil
    and mapping:getNameElem() ~= "mapping")
    or (type(mapping) == "table"
    and mapping["getNameElem"] == nil)
    or type(mapping) ~= "table")then
    error("Error! Invalid mapping element!", 2)
  end

  self:addChild(mapping)
  table.insert(self.mappings, mapping)
end

---
-- Returns a <b>&lt;mapping&gt;</b> child element of the 
-- <b>&lt;switchPort&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#SwitchPort] getMappingPos
-- @param #number p position of the object representing the <b>&lt;mapping&gt;</b> element.
function SwitchPort:getMappingPos(p)
  if(self.mappings == nil)then
    error("Error! switchPort element with nil mappings list!", 2)
  elseif(p > #self.mappings)then
    error("Error! switchPort element doesn't have a mapping child in position "..p.."!", 2)
  end

  return self.mappings[p]
end

---
-- Returns a <b>&lt;mapping&gt;</b> child element of the 
-- <b>&lt;switchPort&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#SwitchPort] getMappingById
-- @param #string id `id` attribute of the <b>&lt;mapping&gt;</b> element.
function SwitchPort:getMappingById(id)
  if(id == nil)then
    error("Error! id attribute of mapping element must be informed!", 2)
  elseif(self.mappings == nil)then
    error("Error! switchPort element with nil mappings list!", 2)
  end

  for _, mapping in ipairs(self.mappings) do
    if(mapping:getId() == id)then
      return mapping
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;mapping&gt;</b> child elements of the <b>&lt;switchPort&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#SwitchPort] setMappings
-- @param #Mapping ... objects representing the <b>&lt;mapping&gt;</b> element.
function SwitchPort:setMappings(...)
  if(#arg>0)then
    for _, mapping in ipairs(arg) do
      self:addMapping(mapping)
    end
  end
end

---
-- Removes a <b>&lt;mapping&gt;</b> child element of the 
-- <b>&lt;switchPort&gt;</b> element. 
-- 
-- @function [parent=#SwitchPort] removeMapping
-- @param #Mapping mapping object representing the <b>&lt;mapping&gt;</b> element.
function SwitchPort:removeMapping(mapping)
  if((type(mapping) == "table"
    and mapping["getNameElem"] ~= nil
    and mapping:getNameElem() ~= "mapping")
    or (type(mapping) == "table"
    and mapping["getNameElem"] == nil)
    or type(mapping) ~= "table")then
    error("Error! Invalid mapping element!", 2)
  elseif(self.children == nil)then
    error("Error! switchPort element with nil children list!", 2)
  elseif(self.mappings == nil)then
    error("Error! switchPort element with nil mappings list!", 2)
  end

  self:removeChild(mapping)

  for p, dc in ipairs(self.mappings) do
    if(mapping == dc)then
      table.remove(self.mappings, p)
    end
  end
end

---
-- Removes a <b>&lt;mapping&gt;</b> child element of the 
-- <b>&lt;switchPort&gt;</b> element in position `p`.
-- 
-- @function [parent=#SwitchPort] removeMappingPos
-- @param #number p position of the <b>&lt;mapping&gt;</b> child element.
function SwitchPort:removeMappingPos(p)
  if(self.children == nil)then
    error("Error! switchPort element with nil children list!", 2)
  elseif(self.mappings == nil)then
    error("Error! switchPort element with nil mappings list!", 2)
  elseif(p > #self.children)then
    error("Error! switchPort element doesn't have a mapping child in position "..p.."!", 2)
  elseif(p > #self.mappings)then
    error("Error! switchPort element doesn't have a mapping child in position "..p.."!", 2)
  end

  self:removeChild(self.mappings[p])
  table.remove(self.mappings, p)
end

return SwitchPort