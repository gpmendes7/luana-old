local NCLElem = require "core/NCLElem"

local DefaultComponent = NCLElem:extends()

DefaultComponent.nameElem = "defaultComponent"

DefaultComponent.attributesTypeMap = {
  component = "string"
}

DefaultComponent.assMap = {
  {"component", "componentAss"}
}

function DefaultComponent:create(attributes)
  local defaultComponent = DefaultComponent:new()

  defaultComponent.component = nil

  defaultComponent.componentAss = nil

  if(attributes ~= nil)then
    defaultComponent:setAttributes(attributes)
  end

  return defaultComponent
end

function DefaultComponent:setComponent(component)
  if(type(component) == "table"
    and component["getNameElem"] ~= nil
    and component:getNameElem() == "switch")then
    self:addAttribute("component", component:getId())
    self.componentAss = component
    table.insert(component.ass, self)
  elseif(type(component) == "string" )then
    self:addAttribute("component", component)
  else
    error("Error! Invalid component element!", 2)
  end
end

function DefaultComponent:getComponent()
  return self:getAttribute("component")
end

return DefaultComponent