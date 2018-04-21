local NCLElem = require "core/NCLElem"

local DefaultDescriptor = NCLElem:extends()

DefaultDescriptor.name = "defaultDescriptor"

DefaultDescriptor.attributesTypeMap = {
  descriptor = "string"
}

function DefaultDescriptor:create(attributes)
  local defaultDescriptor = DefaultDescriptor:new()

  defaultDescriptor.descriptor = nil
  
  defaultDescriptor.descriptorAss = nil

  if(attributes ~= nil)then
    defaultDescriptor:setAttributes(attributes)
  end

  return defaultDescriptor
end

function DefaultDescriptor:setDescriptor(descriptor)
  if(type(descriptor) == "table" and descriptor.name == "descriptor")then
    self:addAttribute("descriptor", descriptor:getId())
    self.descriptorAss = descriptor
    table.insert(descriptor.ass, self)
  else
    self:addAttribute("descriptor", descriptor)
  end
end

function DefaultDescriptor:getDescriptor()
  return self:getAttribute("descriptor")
end

return DefaultDescriptor
