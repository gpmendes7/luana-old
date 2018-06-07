local NCLElem = require "core/NCLElem"
local BindParam = require "core/linking/BindParam"

local Bind = NCLElem:extends()

Bind.nameElem = "bind"

Bind.childrenMap = {
  bindParam = {BindParam, "many"}
}

Bind.attributesTypeMap = {
  role = "string",
  component = "string",
  interface = "string",
  descriptor = "string"
}

Bind.assMap = {
  {"component", "componentAss"},
  {"interface", "interfaceAss"},
  {"descriptor", "descriptorAss"}
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
    if(component["getNameElem"] ~= nil
      and component:getNameElem() ~= "body"
      and component:getNameElem() ~= "switch"
      and component:getNameElem() ~= "context"
      and component:getNameElem() ~= "media")then
      error("Error! Invalid component element!", 2)
    elseif(component:getId() ~= nil)then
      self:addAttribute("component", component:getId())
      self.componentAss = component
      table.insert(component.ass, self)
    else
      error("Error! Component element with nil id attribute!", 2)
    end
  elseif(type(component) == "string" )then
    self:addAttribute("component", component)
  else
    error("Error! Invalid component element!", 2)
  end
end

function Bind:getComponent()
  return self:getAttribute("component")
end

function Bind:setInterface(interface)
  if(type(interface) == "table")then
    if(interface["getNameElem"] ~= nil
      and interface:getNameElem() ~= "area"
      and interface:getNameElem() ~= "property"
      and interface:getNameElem() ~= "port"
      and interface:getNameElem() ~= "switchPort")then
      error("Error! Invalid interface element!", 2)
    else
      if(interface["getId"] ~= nil and interface:getId() ~= nil)then
        self:addAttribute("interface", interface:getId())
      elseif(interface["getName"] ~= nil and interface:getName() ~= nil)then
        self:addAttribute("interface", interface:getName())
      else
        error("Error! Interface element with nil id attribute!", 2)
      end
      self.interfaceAss = interface
      table.insert(interface.ass, self)
    end
  elseif(type(interface) == "string" )then
    self:addAttribute("interface", interface)
  else
    error("Error! Invalid interface element!", 2)
  end
end

function Bind:getInterface()
  return self:getAttribute("interface")
end

function Bind:setDescriptor(descriptor)
  if(type(descriptor) == "table"
    and descriptor["getNameElem"] ~= nil
    and descriptor.nameElem == "descriptor")then
    self:addAttribute("descriptor", descriptor:getId())
    self.descriptorAss = descriptor
    table.insert(descriptor.ass, self)
  elseif(type(descriptor) == "string" )then
    self:addAttribute("descriptor", descriptor)
  else
    error("Error! Invalid descriptor element!", 2)
  end
end

function Bind:getDescriptor()
  return self:getAttribute("descriptor")
end

function Bind:addBindParam(bindParam)
  if((type(bindParam) == "table"
    and bindParam["getNameElem"] ~= nil
    and bindParam:getNameElem() ~= "bindParam")
    or (type(bindParam) == "table"
    and bindParam["getNameElem"] == nil)
    or type(bindParam) ~= "table")then
    error("Error! Invalid bindParam element!", 2)
  end

  local p = self:getPosAvailable("bindParam")

  if(p ~= nil)then
    self:addChild(bindParam, p)
  else
    self:addChild(bindParam, 1)
  end

  table.insert(self.bindParams, bindParam)
end

function Bind:getBindParamPos(p)
  if(self.bindParams == nil)then
    error("Error! bind element with nil bindParams list!", 2)
  elseif(p > #self.bindParams)then
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
  if((type(bindParam) == "table"
    and bindParam["getNameElem"] ~= nil
    and bindParam:getNameElem() ~= "bindParam")
    or (type(bindParam) == "table"
    and bindParam["getNameElem"] == nil)
    or type(bindParam) ~= "table")then
    error("Error! Invalid bindParam element!", 2)
  elseif(self.children == nil)then
    error("Error! bind element with nil children list!", 2)
  elseif(self.bindParams == nil)then
    error("Error! bind element with nil bindParams list!", 2)
  end

  self:removeChild(bindParam)

  for p, bp in ipairs(self.bindParams) do
    if(bindParam == bp)then
      table.remove(self.bindParams, p)
    end
  end
end

function Bind:removeBindParamPos(p)
  if(self.children == nil)then
    error("Error! bind element with nil children list!", 2)
  elseif(self.bindParams == nil)then
    error("Error! bind element with nil bindParams list!", 2)
  elseif(p > #self.children)then
    error("Error! bind element doesn't have a bindParam child in position "..p.."!", 2)
  elseif(p > #self.bindParams)then
    error("Error! bind element doesn't have a bindParam child in position "..p.."!", 2)
  end

  self:removeChild(self.bindParams[p])
  table.remove(self.bindParams, p)
end

return Bind