local NCLElem = require "core/NCLElem"

local DefaultComponent = NCLElem:extends()

DefaultComponent.name = "defaultComponent"

DefaultComponent.attributesTypeMap = {
  component = "string"
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
 if(type(component) == "table")then
    if(component.getId ~= nil)then
      self:addAttribute("component", component:getId())
    end

    self.componentAss = component
    table.insert(component.ass, self)
  else
    self:addAttribute("component", component)
  end
end

function DefaultComponent:getComponent()
  return self:getAttribute("component")
end

return DefaultComponent
