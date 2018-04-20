local NCLElem = require "core/NCLElem"

local Port = NCLElem:extends()

Port.name = "port"

Port.attributesTypeMap = {
  id = "string",
  component = "string",
  interface = "string"
}

function Port:create(attributes)
  local port = Port:new()

  port.id = nil
  port.component = nil
  port.interface = nil

  port.componentAss = nil
  port.interfaceAss = nil
  
  if(attributes ~= nil)then
    port:setAttributes(attributes)
  end

  return port
end

function Port:setId(id)
  self:addAttribute("id", id)
end

function Port:getId()
  return self:getAttribute("id")
end

function Port:setComponent(component)
  if(type(component) == "table")then
    if(component.getId ~= nil)then
      self:addAttribute("component", component:getId())
    elseif(component.getName ~= nil)then
      self:addAttribute("component", component:getName())
    end
    
    self.componentAss = component
    table.insert(component.ass, self)
  else
    self:addAttribute("component", component)
  end
end

function Port:getComponent()
  return self:getAttribute("component")
end

function Port:setInterface(interface)
  if(type(interface) == "table")then
    if(interface.getId ~= nil)then
      self:addAttribute("interface", interface:getId())
    elseif(interface.getName ~= nil)then
      self:addAttribute("interface", interface:getName())
    end
    
    self.interfaceAss = interface
    table.insert(interface.ass, self)
  else
    self:addAttribute("interface", interface)
  end
end

function Port:getInterface()
  return self:getAttribute("interface")
end

return Port
