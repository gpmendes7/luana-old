local NCLElem = require "core/NCLElem"
local Mapping = require "core/switches/Mapping"

local SwitchPort = NCLElem:extends()

SwitchPort.nameElem = "switchPort"

SwitchPort.childrenMap = {
  mapping = {Mapping, "many"}
}

SwitchPort.attributesTypeMap = {
  id = "string"
}

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

function SwitchPort:setId(id)
  self:addAttribute("id", id)
end

function SwitchPort:getId()
  return self:getAttribute("id")
end

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

function SwitchPort:getMappingPos(p)
  if(self.mappings == nil)then
    error("Error! switchPort element with nil mappings list!", 2)
  elseif(p > #self.mappings)then
    error("Error! switchPort element doesn't have a mapping child in position "..p.."!", 2)
  end

  return self.mappings[p]
end

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

function SwitchPort:setMappings(...)
  if(#arg>0)then
    for _, mapping in ipairs(arg) do
      self:addMapping(mapping)
    end
  end
end

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