local NCLElem = require "core/NCLElem"

local Property = NCLElem:extends()

Property.name = "property"

Property.attributesTypeMap = {
  name = "string",
  value = "string",
  externable = "boolean"
}

function Property:create(attributes)
  local property = Property:new()

  property.name = nil
  property.value = nil
  property.externable = nil
  
  property.ass = {}

  if(attributes ~= nil)then
    property:setAttributes(attributes)
  end

  return property
end

function Property:setName(name)
  self:addAttribute("name", name)
end

function Property:getName()
  return self:getAttribute("name")
end

function Property:setValue(value)
  self:addAttribute("value", value)
end

function Property:getValue()
  return self:getAttribute("value")
end

function Property:setExternable(externable)
  self:addAttribute("externable", externable)
end

function Property:getExternable()
  return self:getAttribute("externable")
end

return Property
