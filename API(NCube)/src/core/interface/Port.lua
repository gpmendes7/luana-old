local NCLElem = require "core/NCLElem"

local Port = NCLElem:extends()

Port.nameElem = "port"

Port.attributesTypeMap = {
  id = "string",
  component = "string",
  interface = "string"
}

Port.assMap = {
  {"component", "componentAss"},
  {"interface", "interfaceAss"}
}

function Port:create(attributes)
  local port = Port:new()

  port.id = nil
  port.component = nil
  port.interface = nil

  port.componentAss = nil
  port.interfaceAss = nil

  port.ass = {}

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
    if(component["getId"] ~= nil)then
      self:addAttribute("component", component:getId())
    elseif(component["getName"] ~= nil)then
      self:addAttribute("component", component:getName())
    else
      error("Error! Invalid component element!")
    end

    self.componentAss = component
    table.insert(component.ass, self)
  elseif(type(component) == "string" )then
    self:addAttribute("component", component)
  else
    error("Error! Invalid component element!")
  end
end

function Port:getComponent()
  return self:getAttribute("component")
end

function Port:getComponentAss()
  return self.componentAss
end

function Port:setInterface(interface)
  if(type(interface) == "table")then
    if(interface["getId"] ~= nil)then
      self:addAttribute("interface", interface:getId())
    elseif(interface["getName"] ~= nil)then
      self:addAttribute("interface", interface:getName())
    else
      error("Error! Invalid interface element!")
    end

    self.interfaceAss = interface
    table.insert(interface.ass, self)
  elseif(type(interface) == "string" )then
    self:addAttribute("interface", interface)
  else
    error("Error! Invalid interface element!")
  end
end

function Port:getInterface()
  return self:getAttribute("interface")
end

function Port:getInterfaceAss()
  return self.interfaceAss
end

return Port