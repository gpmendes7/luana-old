local NCLElem = require "core/NCLElem"

local ConnectorParam = NCLElem:extends()

ConnectorParam.nameElem = "connectorParam"

ConnectorParam.attributesTypeMap = {
  name = "string",
  type = "string"
}

function ConnectorParam:create(attributes)
  local connectorParam = ConnectorParam:new()

  connectorParam.name = nil
  connectorParam.type = nil

  if(attributes ~= nil)then
    connectorParam:setAttributes(attributes)
  end

  return connectorParam
end

function ConnectorParam:setName(name)
  self:addAttribute("name", name)
end

function ConnectorParam:getName()
  return self:getAttribute("name")
end

function ConnectorParam:setType(type)
  self:addAttribute("type", type)
end

function ConnectorParam:getType()
  return self:getAttribute("type")
end

return ConnectorParam
