local NCLElem = require "core/NCLElem"
local BindParam = require "core/linking/BindParam"

local Bind = NCLElem:extends()

Bind.name = "bind"

Bind.childrenMap = {
  bindParam = {BindParam, "many"}
}

Bind.attributesTypeMap = {
  role = "string",
  component = "string",
  interface = "string",
  descriptor = "string"
}

function Bind:create(attributes, full)
  local bind = Bind:new()

  bind.role = nil
  bind.component = nil
  bind.interface = nil
  bind.descriptor = nil

  bind.componentAss = nil
  bind.interfaceAss = nil
  bind.descriptorAss = nil

  if(attributes ~= nil)then
    bind:setAttributes(attributes)
  end

  bind.children = {}
  bind.bindParams = {}

  if(full ~= nil)then
    bind:addBindParam(BindParam:create())
  end

  return bind
end

function Bind:setRole(role)
  self:addAttribute("role", role)
end

function Bind:getRole()
  return self:getAttribute("role")
end

function Bind:setComponent(component)
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

function Bind:getComponent()
  return self:getAttribute("component")
end

function Bind:setInterface(interface)
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

function Bind:getInterface()
  return self:getAttribute("interface")
end

function Bind:setDescriptor(descriptor)
  if(type(descriptor) == "table" and descriptor.name == "descriptor")then
    self:addAttribute("descriptor", descriptor:getId())
    self.descriptorAss = descriptor
    table.insert(descriptor.ass, self)
  else
    self:addAttribute("descriptor", descriptor)
  end
end

function Bind:getDescriptor()
  return self:getAttribute("descriptor")
end

function Bind:addBindParam(bindParam)
  local p = self:getPosAvailable("bindParam")

  if(p ~= nil)then
    self:addChild(bindParam, p)
  else
    self:addChild(bindParam, 1)
  end

  table.insert(self.bindParams, bindParam)
end

function Bind:getBindParamPos(p)
  if(p > #self.bindParams)then
    error("Error! bind element doesn't have a bindParam child in position "..p.."!", 2)
  end

  return self.bindParams[p]
end

function Bind:setBindParams(...)
  if(#arg>0)then
    for _, bindParam in ipairs(arg) do
      self:addBindParam(bindParam)
    end
  end
end

function Bind:removeBindParam(bindParam)
  self:removeChild(bindParam)

  for p, bp in ipairs(self.bindParams) do
    if(bindParam == bp)then
      table.remove(self.bindParams, p)
    end
  end
end

function Bind:removeBindParamPos(p)
  self:removeChildPos(p)
  table.remove(self.bindParams, p)
end

return Bind
