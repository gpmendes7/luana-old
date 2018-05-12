local NCLElem = require "core/NCLElem"

local BindParam = NCLElem:extends()

BindParam.nameElem = "bindParam"

BindParam.attributesTypeMap = {
  name = "string",
  value = {"string", "number"}
}

function BindParam:create(attributes)
  local bindParam = BindParam:new()

  bindParam.name = nil
  bindParam.value = nil
  
  bindParam.symbols = {}

  if(attributes ~= nil)then
    bindParam:setAttributes(attributes)
  end

  return bindParam
end

function BindParam:setName(name)
  self:addAttribute("name", name)
end

function BindParam:getName()
  return self:getAttribute("name")
end

function BindParam:setValue(value)
  self:addAttribute("value", value)
end

function BindParam:getValue()
  return self:getAttribute("value")
end

return BindParam