local NCLElem = require "../../src/core/NCLElem"

---
-- Implements Port Class representing <b>&lt;port&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=port">
-- http://handbook.ncl.org.br/doku.php?id=port</a>
-- 
-- @module Port
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local Port = require "core/interface/Port" 
local Port = NCLElem:extends()

---
-- Name of <b>&lt;port&gt;</b> element.
-- 
-- @field [parent=#Port] #string nameElem
Port.nameElem = "port"

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;port&gt;</b> element.
-- 
-- @field [parent=#Port] #table attributesTypeMap 
Port.attributesTypeMap = {
  id = "string",
  component = "string",
  interface = "string"
}

---
-- List with associative map that connects an attribute to an specific object
-- representing a child NCL element of <b>&lt;port&gt;</b> element.
-- 
-- @field [parent=#Port] #table assMap
Port.assMap = {
  {"component", "componentAss"},
  {"interface", "interfaceAss"}
}

---
-- Returns a new Port object. 
-- 
-- @function [parent=#Port] create
-- @param #table attributes list of attributes to be initialized.
-- @return #Port new Port object created.
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

---
-- Sets a value to `id` attribute of the 
-- <b>&lt;port&gt;</b> element. 
-- 
-- @function [parent=#Port] setId
-- @param #string id `id` attribute of the
-- <b>&lt;port&gt;</b> element.
function Port:setId(id)
  self:addAttribute("id", id)
end

---
-- Returns the value of the `id` attribute of the 
-- <b>&lt;port&gt;</b> element. 
-- 
-- @function [parent=#Port] getId
-- @return #string `id` attribute of the <b>&lt;port&gt;</b> element.
function Port:getId()
  return self:getAttribute("id")
end

---
-- Sets a value to `component` attribute of the 
-- <b>&lt;port&gt;</b> element. 
-- 
-- @function [parent=#Port] setComponent
-- @param #stringOrobject component `component` attribute of the
-- <b>&lt;port&gt;</b> element.
function Port:setComponent(component)
  if(type(component) == "table")then
    if(component["getNameElem"] ~= nil
      and component:getNameElem() ~= "context"
      and component:getNameElem() ~= "switch"
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

---
-- Returns the value of the `component` attribute of the 
-- <b>&lt;port&gt;</b> element. 
-- 
-- @function [parent=#Port] getComponent
-- @return #string `component` attribute of the <b>&lt;port&gt;</b> element.
function Port:getComponent()
  return self:getAttribute("component")
end

---
-- Returns the component associated to
-- <b>&lt;port&gt;</b> element. 
-- 
-- @function [parent=#Port] getComponentAss
-- @return #object component associated to <b>&lt;port&gt;</b> element.
function Port:getComponentAss()
  return self.componentAss
end

---
-- Sets a value to `interface` attribute of the 
-- <b>&lt;port&gt;</b> element. 
-- 
-- @function [parent=#Port] setInterface
-- @param #stringOrobject interface `interface` attribute of the
-- <b>&lt;port&gt;</b> element.
function Port:setInterface(interface)
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

---
-- Returns the value of the `interface` attribute of the 
-- <b>&lt;port&gt;</b> element. 
-- 
-- @function [parent=#Port] getInterface
-- @return #string `interface` attribute of the <b>&lt;port&gt;</b> element.
function Port:getInterface()
  return self:getAttribute("interface")
end

---
-- Returns the interface associated to
-- <b>&lt;port&gt;</b> element. 
-- 
-- @function [parent=#Port] getInterfaceAss
-- @return #object interface associated to <b>&lt;port&gt;</b> element.
function Port:getInterfaceAss()
  return self.interfaceAss
end

return Port