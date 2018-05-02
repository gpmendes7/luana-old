local NCLElem = require "core/NCLElem"
local Area = require "core/interface/Area"
local Property = require "core/interface/Property"

local Media = NCLElem:extends()

Media.nameElem = "media"

Media.childrenMap = {
  area = {Area, "many"},
  property = {Property, "many"}
}

Media.attributesTypeMap = {
  id = "string",
  src = "string",
  type = "string",
  refer = "string",
  instance = "string",
  newInstance = "string",
  descriptor = "string",
}

Media.attributesStringValueMap = {
  instance = {"new", "instSame", "gradSame"}
}

Media.assMap = {
  {"refer", "referAss"},
  {"descriptor", "descriptorAss"}
}

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

function Media:setId(id)
  self:addAttribute("id", id)
end

function Media:getId()
  return self:getAttribute("id")
end

function Media:setSrc(src)
  self:addAttribute("src", src)
end

function Media:getSrc()
  return self:getAttribute("src")
end

function Media:setType(type)
  self:addAttribute("type", type)
end

function Media:getType()
  return self:getAttribute("type")
end

function Media:setRefer(refer)
  if(type(refer) == "table" and refer.nameElem == "media")then
    self:addAttribute("refer", refer:getId())
    self.referAss = refer
    table.insert(refer.ass, self)
  else
    self:addAttribute("refer", refer)
  end
end

function Media:getRefer()
  return self:getAttribute("refer")
end

function Media:setInstance(instance)
  self:addAttribute("instance", instance)
end

function Media:getInstance()
  return self:getAttribute("instance")
end

function Media:setNewInstance(newInstance)
  self:addAttribute("newInstance", newInstance)
end

function Media:getNewInstance()
  return self:getAttribute("newInstance")
end


function Media:setDescriptor(descriptor)
  if(type(descriptor) == "table" and descriptor.nameElem == "descriptor")then
    self:addAttribute("descriptor", descriptor:getId())
    self.descriptorAss = descriptor
    table.insert(descriptor.ass, self)
  else
    self:addAttribute("descriptor", descriptor)
  end
end

function Media:getDescriptor()
  return self:getAttribute("descriptor")
end

function Media:addArea(area)
  self:addChild(area)
  table.insert(self.areas, area)
end

function Media:getAreaPos(p)
  if(p > #self.areas)then
    error("Error! media element doesn't have a area child in position "..p.."!", 2)
  end

  return self.areas[p]
end

function Media:getAreaById(id)
  if(id == nil)then
    error("Error! id attribute of area element must be informed!", 2)
  end

  for _, area in ipairs(self.areas) do
    if(area:getId() == id)then
      return area
    end
  end

  return nil
end

function Media:setAreas(...)
  if(#arg>0)then
    for _, area in ipairs(arg) do
      self:addArea(area)
    end
  end
end

function Media:removeArea(area)
  self:removeChild(area)

  for p, ar in ipairs(self.areas) do
    if(area == ar)then
      table.remove(self.areas, p)
    end
  end
end

function Media:removeAreaPos(p)
  self:removeChildPos(p)
  table.remove(self.areas, p)
end

function Media:addProperty(property)
  self:addChild(property)
  table.insert(self.propertys, property)
end

function Media:getPropertyPos(p)
  if(p > #self.propertys)then
    error("Error! media element doesn't have a property child in position "..p.."!", 2)
  end

  return self.propertys[p]
end

function Media:getPropertyByName(name)
  if(name == nil)then
    error("Error! name attribute of property element must be informed!", 2)
  end

  for _, property in ipairs(self.propertys) do
    if(property:getName() == name)then
      return property
    end
  end

  return nil
end

function Media:setPropertys(...)
  if(#arg>0)then
    for _, property in ipairs(arg) do
      self:addProperty(property)
    end
  end
end

function Media:removeProperty(property)
  self:removeChild(property)

  for p, pr in ipairs(self.propertys) do
    if(property == pr)then
      table.remove(self.propertys, p)
    end
  end
end

function Media:removePropertyPos(p)
  self:removeChildPos(p)
  table.remove(self.propertys, p)
end

return Media