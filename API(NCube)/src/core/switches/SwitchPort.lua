local NCLElem = require "core/NCLElem"
local Mapping = require "core/switches/Mapping"

local SwitchPort = NCLElem:extends()

SwitchPort.name = "switchPort"

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
  self:addChild(mapping)
  table.insert(self.mappings, mapping)
end

function SwitchPort:getMappingPos(p)
  if(p > #self.mappings)then
    error("Error! switchPort element doesn't have a mapping child in position "..p.."!", 2)
  end

  return self.mappings[p]
end

function SwitchPort:getMappingById(id)
  if(id == nil)then
    error("Error! id attribute of mapping element must be informed!", 2)
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
  self:removeChild(mapping)

  for p, dc in ipairs(self.mappings) do
    if(mapping == dc)then
      table.remove(self.mappings, p)
    end
  end
end

function SwitchPort:removeMappingPos(p)
  self:removeChildPos(p)
  table.remove(self.mappings, p)
end

return SwitchPort