local NCLElem = require "core/NCLElem"
local Area = require "core/interface/Area"
local Property = require "core/interface/Property"

---
-- Implements Media Class representing <b>&lt;media&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=media">
-- http://handbook.ncl.org.br/doku.php?id=media</a>
-- 
-- @module Media
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local Media = require "core/content/Media" 
local Media = NCLElem:extends()

---
-- Name of <b>&lt;media&gt;</b> element.
-- 
-- @field [parent=#Media] #string nameElem 
Media.nameElem = "media"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;media&gt;</b> element.
-- 
-- @field [parent=#Media] #table childrenMap
Media.childrenMap = {
  area = {Area, "many"},
  property = {Property, "many"}
}

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;media&gt;</b> element.
-- 
-- @field [parent=#Media] #table attributesTypeMap  
Media.attributesTypeMap = {
  id = "string",
  src = "string",
  type = "string",
  refer = "string",
  instance = "string",
  newInstance = "string",
  descriptor = "string",
}

---
-- List containing all possible pre-definied values to string attributes
-- belonging to <b>&lt;media&gt;</b> element.
-- 
-- @field [parent=#Media] #table attributesStringValueMap
Media.attributesStringValueMap = {
  instance = {"new", "instSame", "gradSame"}
}

---
-- List with associative map that connects an attribute to an specific object
-- representing a child NCL element of <b>&lt;media&gt;</b> element.
-- 
-- @field [parent=#Media] #table assMap
Media.assMap = {
  {"refer", "referAss"},
  {"descriptor", "descriptorAss"}
}

---
-- Returns a new Media object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#Media] create
-- @param #table attributes list of attributes to be initialized.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #Media new Media object created.
function Media:create(attributes, full)
  local media = Media:new()

  media.id = nil
  media.src = nil
  media.type = nil
  media.refer = nil
  media.instance = nil
  media.newInstance = nil
  media.descriptor = nil

  media.referAss = nil
  media.descriptorAss = nil

  media.ass = {}

  if(attributes ~= nil)then
    media:setAttributes(attributes)
  end

  media.children = {}
  media.areas = {}
  media.propertys = {}

  if(full ~= nil)then
    media:addArea(Area:create())
    media:addProperty(Property:create())
  end

  return media
end

---
-- Sets a value to `id` attribute of the 
-- <b>&lt;media&gt;</b> element. 
-- 
-- @function [parent=#Media] setId
-- @param #string id `id` atribute of the
-- <b>&lt;media&gt;</b> element.
function Media:setId(id)
  self:addAttribute("id", id)
end

---
-- Returns the value of the `id` attribute of the 
-- <b>&lt;media&gt;</b> element. 
-- 
-- @function [parent=#Media] getId
-- @return #string `id` atribute of the <b>&lt;media&gt;</b> element.
function Media:getId()
  return self:getAttribute("id")
end

---
-- Sets a value to `src` attribute of the 
-- <b>&lt;media&gt;</b> element. 
-- 
-- @function [parent=#Media] setSrc
-- @param #string src `src` atribute of the
-- <b>&lt;media&gt;</b> element.
function Media:setSrc(src)
  self:addAttribute("src", src)
end

---
-- Returns the value of the `src` attribute of the 
-- <b>&lt;media&gt;</b> element. 
-- 
-- @function [parent=#Media] getSrc
-- @return #string `src` atribute of the <b>&lt;media&gt;</b> element.
function Media:getSrc()
  return self:getAttribute("src")
end

---
-- Sets a value to `type` attribute of the 
-- <b>&lt;media&gt;</b> element. 
-- 
-- @function [parent=#Media] setType
-- @param #string type `type` atribute of the
-- <b>&lt;media&gt;</b> element.
function Media:setType(type)
  self:addAttribute("type", type)
end

---
-- Returns the value of the `type` attribute of the 
-- <b>&lt;media&gt;</b> element. 
-- 
-- @function [parent=#Media] getType
-- @return #string `type` atribute of the <b>&lt;media&gt;</b> element.
function Media:getType()
  return self:getAttribute("type")
end

---
-- Sets a value to `refer` attribute of the 
-- <b>&lt;media&gt;</b> element. 
-- 
-- @function [parent=#Media] setRefer
-- @param #stringOrObject refer `refer` atribute of the
-- <b>&lt;media&gt;</b> element.
function Media:setRefer(refer)
  if(type(refer) == "table")then
    if(refer["getNameElem"] ~= nil
      and refer:getNameElem() ~= "media")then
      error("Error! Invalid refer element!", 2)
    elseif(refer:getId() ~= nil)then
      self:addAttribute("refer", refer:getId())
      self.referAss = refer
      table.insert(refer.ass, self)
    else
      error("Error! Refer element with nil id attribute!", 2)
    end
  elseif(type(refer) == "string" )then
    self:addAttribute("refer", refer)
  else
    error("Error! Invalid refer element!", 2)
  end
end

---
-- Returns the value of the `refer` attribute of the 
-- <b>&lt;media&gt;</b> element. 
-- 
-- @function [parent=#Media] getRefer
-- @return #string `refer` atribute of the <b>&lt;media&gt;</b> element.
function Media:getRefer()
  return self:getAttribute("refer")
end

---
-- Returns the refer associated to
-- <b>&lt;media&gt;</b> element. 
-- 
-- @function [parent=#Media] getReferAss
-- @return #object refer associated to <b>&lt;media&gt;</b> element.
function Media:getReferAss()
  return self.referAss
end

---
-- Sets a value to `instance` attribute of the 
-- <b>&lt;media&gt;</b> element. 
-- 
-- @function [parent=#Media] setType
-- @param #string instance `instance` atribute of the
-- <b>&lt;media&gt;</b> element.
function Media:setInstance(instance)
  self:addAttribute("instance", instance)
end

---
-- Returns the value of the `instance` attribute of the 
-- <b>&lt;media&gt;</b> element. 
-- 
-- @function [parent=#Media] getInstance
-- @return #string `instance` atribute of the <b>&lt;media&gt;</b> element.
function Media:getInstance()
  return self:getAttribute("instance")
end

---
-- Sets a value to `newInstance` attribute of the 
-- <b>&lt;media&gt;</b> element. 
-- 
-- @function [parent=#Media] setNewInstance
-- @param #string newInstance `newInstance` atribute of the
-- <b>&lt;media&gt;</b> element.
function Media:setNewInstance(newInstance)
  self:addAttribute("newInstance", newInstance)
end

---
-- Returns the value of the `newInstance` attribute of the 
-- <b>&lt;media&gt;</b> element. 
-- 
-- @function [parent=#Media] getNewInstance
-- @return #string `newInstance` atribute of the <b>&lt;media&gt;</b> element.
function Media:getNewInstance()
  return self:getAttribute("newInstance")
end

---
-- Sets a value to `descriptor` attribute of the 
-- <b>&lt;media&gt;</b> element. 
-- 
-- @function [parent=#Media] setDescriptor
-- @param #stringOrObject descriptor `descriptor` atribute of the
-- <b>&lt;media&gt;</b> element.
function Media:setDescriptor(descriptor)
  if(type(descriptor) == "table"
    and descriptor["getNameElem"] ~= nil
    and descriptor:getNameElem() == "descriptor")then
    self:addAttribute("descriptor", descriptor:getId())
    self.descriptorAss = descriptor
    table.insert(self.descriptorAss.ass, self)
  elseif(type(descriptor) == "string")then
    self:addAttribute("descriptor", descriptor)
  else
    error("Error! Invalid descriptor element!", 2)
  end
end

---
-- Returns the value of the `descriptor` attribute of the 
-- <b>&lt;media&gt;</b> element. 
-- 
-- @function [parent=#Media] getDescriptor
-- @return #string `descriptor` atribute of the <b>&lt;media&gt;</b> element.
function Media:getDescriptor()
  return self:getAttribute("descriptor")
end

---
-- Adds a <b>&lt;area&gt;</b> child element of the 
-- <b>&lt;media&gt;</b> element. 
-- 
-- @function [parent=#Media] addArea
-- @param #Area area object representing the 
-- <b>&lt;area&gt;</b> element.
function Media:addArea(area)
  if((type(area) == "table"
    and area["getNameElem"] ~= nil
    and area:getNameElem() ~= "area")
    or (type(area) == "table"
    and area["getNameElem"] == nil)
    or type(area) ~= "table")then
    error("Error! Invalid area element!", 2)
  end

  self:addChild(area)
  table.insert(self.areas, area)
end

---
-- Returns a <b>&lt;area&gt;</b> child element of the 
-- <b>&lt;media&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Media] getAreaPos
-- @param #number p  position of the object representing 
-- the <b>&lt;area&gt;</b> element.
function Media:getAreaPos(p)
  if(self.areas == nil)then
    error("Error! media element with nil areas list!", 2)
  elseif(p > #self.areas)then
    error("Error! media element doesn't have a area child in position "..p.."!", 2)
  end

  return self.areas[p]
end

---
-- Returns a <b>&lt;area&gt;</b> child element of the 
-- <b>&lt;media&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#Media] getAreaById
-- @param #string id `id` attribute of the <b>&lt;area&gt;</b> element.
function Media:getAreaById(id)
  if(id == nil)then
    error("Error! id attribute of area element must be informed!", 2)
  elseif(self.areas == nil)then
    error("Error! media element with nil areas list!", 2)
  end

  for _, area in ipairs(self.areas) do
    if(area:getId() == id)then
      return area
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;area&gt;</b> child elements of the <b>&lt;media&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Media] setAreas
-- @param #Area ... objects representing the <b>&lt;area&gt;</b> element.
function Media:setAreas(...)
  if(#arg>0)then
    for _, area in ipairs(arg) do
      self:addArea(area)
    end
  end
end

---
-- Removes a <b>&lt;area&gt;</b> child element of the 
-- <b>&lt;media&gt;</b> element. 
-- 
-- @function [parent=#Media] removeArea
-- @param #Area area object representing the <b>&lt;area&gt;</b> element.
function Media:removeArea(area)
  if((type(area) == "table"
    and area["getNameElem"] ~= nil
    and area:getNameElem() ~= "area")
    or (type(area) == "table"
    and area["getNameElem"] == nil)
    or type(area) ~= "table")then
    error("Error! Invalid area element!", 2)
  elseif(self.children == nil)then
    error("Error! media element with nil children list!", 2)
  elseif(self.areas == nil)then
    error("Error! media element with nil areas list!", 2)
  end

  self:removeChild(area)

  for p, ar in ipairs(self.areas) do
    if(area == ar)then
      table.remove(self.areas, p)
    end
  end
end

---
-- Removes a <b>&lt;area&gt;</b> child element of the 
-- <b>&lt;media&gt;</b> element in position `p`.
-- 
-- @function [parent=#Media] removeAreaPos
-- @param #number p position of the <b>&lt;area&gt;</b> child element.
function Media:removeAreaPos(p)
  if(self.children == nil)then
    error("Error! media element with nil children list!", 2)
  elseif(self.areas == nil)then
    error("Error! media element with nil areas list!", 2)
  elseif(p > #self.children)then
    error("Error! media element doesn't have a area child in position "..p.."!", 2)
  elseif(p > #self.areas)then
    error("Error! media element doesn't have a area child in position "..p.."!", 2)
  end

  self:removeChild(self.areas[p])
  table.remove(self.areas, p)
end

---
-- Adds a <b>&lt;property&gt;</b> child element of the 
-- <b>&lt;media&gt;</b> element. 
-- 
-- @function [parent=#Media] addProperty
-- @param #Property property object representing the 
-- <b>&lt;property&gt;</b> element.
function Media:addProperty(property)
  if((type(property) == "table"
    and property["getNameElem"] ~= nil
    and property:getNameElem() ~= "property")
    or (type(property) == "table"
    and property["getNameElem"] == nil)
    or type(property) ~= "table")then
    error("Error! Invalid property element!", 2)
  end

  self:addChild(property)
  table.insert(self.propertys, property)
end

---
-- Returns a <b>&lt;property&gt;</b> child element of the 
-- <b>&lt;media&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Media] getPropertyPos
-- @param #number p  position of the object representing the <b>&lt;property&gt;</b> element.
function Media:getPropertyPos(p)
  if(self.propertys == nil)then
    error("Error! media element with nil propertys list!", 2)
  elseif(p > #self.propertys)then
    error("Error! media element doesn't have a property child in position "..p.."!", 2)
  end

  return self.propertys[p]
end

---
-- Returns a <b>&lt;property&gt;</b> child element of the 
-- <b>&lt;media&gt;</b> element
-- by `name` attribute.
--  
-- @function [parent=#Media] getPropertyByName
-- @param #string name `name` attribute of the <b>&lt;property&gt;</b> element.
function Media:getPropertyByName(name)
  if(name == nil)then
    error("Error! name attribute of property element must be informed!", 2)
  elseif(self.propertys == nil)then
    error("Error! media element with nil propertys list!", 2)
  end

  for _, property in ipairs(self.propertys) do
    if(property:getName() == name)then
      return property
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;property&gt;</b> child elements of the <b>&lt;media&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Media] setPropertys
-- @param #Property ... objects representing the <b>&lt;property&gt;</b> element.
function Media:setPropertys(...)
  if(#arg>0)then
    for _, property in ipairs(arg) do
      self:addProperty(property)
    end
  end
end

---
-- Removes a <b>&lt;property&gt;</b> child element of the 
-- <b>&lt;media&gt;</b> element. 
-- 
-- @function [parent=#Media] removeProperty
-- @param #Property property object representing the <b>&lt;property&gt;</b> element.
function Media:removeProperty(property)
  if((type(property) == "table"
    and property["getNameElem"] ~= nil
    and property:getNameElem() ~= "property")
    or (type(property) == "table"
    and property["getNameElem"] == nil)
    or type(property) ~= "table")then
    error("Error! Invalid property element!", 2)
  elseif(self.children == nil)then
    error("Error! media element with nil children list!", 2)
  elseif(self.propertys == nil)then
    error("Error! media element with nil propertys list!", 2)
  end

  self:removeChild(property)

  for p, pr in ipairs(self.propertys) do
    if(property == pr)then
      table.remove(self.propertys, p)
    end
  end
end

---
-- Removes a <b>&lt;property&gt;</b> child element of the 
-- <b>&lt;media&gt;</b> element in position `p`.
-- 
-- @function [parent=#Media] removePropertyPos
-- @param #number p position of the <b>&lt;property&gt;</b> child element.
function Media:removePropertyPos(p)
  if(self.children == nil)then
    error("Error! media element with nil children list!", 2)
  elseif(self.propertys == nil)then
    error("Error! media element with nil propertys list!", 2)
  elseif(p > #self.children)then
    error("Error! media element doesn't have a property child in position "..p.."!", 2)
  elseif(p > #self.propertys)then
    error("Error! media element doesn't have a property child in position "..p.."!", 2)
  end

  self:removeChild(self.propertys[p])
  table.remove(self.propertys, p)
end

return Media