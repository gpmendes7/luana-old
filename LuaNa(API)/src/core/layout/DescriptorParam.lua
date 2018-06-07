local NCLElem = require "core/NCLElem"

local DescriptorParam = NCLElem:extends()

DescriptorParam.nameElem = "descriptorParam"

DescriptorParam.attributesTypeMap = {
  name = "string",
  value = {"string", "number"}
}

function DescriptorParam:create(attributes)
  local descriptorParam = DescriptorParam:new()

  descriptorParam.name = nil
  descriptorParam.value = nil
  
  descriptorParam.ass = {}

  if(attributes ~= nil)then
    descriptorParam:setAttributes(attributes)
  end

  return descriptorParam
end

function DescriptorParam:setName(name)
  self:addAttribute("name", name)
end

function DescriptorParam:getName()
  return self:getAttribute("name")
end

function DescriptorParam:setValue(value)
  self:addAttribute("value", value)
end

function DescriptorParam:getValue()
  return self:getAttribute("value")
end

return DescriptorParam