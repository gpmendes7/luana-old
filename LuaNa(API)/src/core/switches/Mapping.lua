local NCLElem = require "core/NCLElem"

---
-- Implements Mapping Class representing <b>&lt;mapping&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=mapping">
-- http://handbook.ncl.org.br/doku.php?id=mapping</a>
-- 
-- @module Mapping
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local Mapping = require "core/content/Mapping" 
local Mapping = NCLElem:extends()

---
-- Name of <b>&lt;mapping&gt;</b> element.
-- 
-- @field [parent=#Mapping] #string nameElem
Mapping.nameElem = "mapping"

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;mapping&gt;</b> element.
-- 
-- @field [parent=#Mapping] #table attributesTypeMap  
Mapping.attributesTypeMap = {
  component = "string",
  interface = "string"
}

---
-- List with associative map that connects an attribute to an specific object
-- representing a child NCL element of <b>&lt;mapping&gt;</b> element.
-- 
-- @field [parent=#Mapping] #table assMap
Mapping.assMap = {
  {"component", "componentAss"},
  {"interface", "interfaceAss"}
}

---
-- Returns a new Mapping object. 
-- 
-- @function [parent=#Mapping] create
-- @param #table attributes list of attributes to be initialized.
-- @return #Mapping new Mapping object created.
function Mapping:create(attributes)
  local mapping = Mapping:new()

  mapping.component = nil
  mapping.interface = nil

  mapping.componentAss = nil
  mapping.interfaceAss = nil

  if(attributes ~= nil)then
    mapping:setAttributes(attributes)
  end

  return mapping
end

---
-- Sets a value to `component` attribute of the 
-- <b>&lt;mapping&gt;</b> element. 
-- 
-- @function [parent=#Mapping] setComponent
-- @param #stringOrObject component `component` attribute of the
-- <b>&lt;mapping&gt;</b> element.
function Mapping:setComponent(component)
  if(type(component) == "table")then
    if(component["getNameElem"] ~= nil
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

---
-- Returns the value of the `component` attribute of the 
-- <b>&lt;mapping&gt;</b> element. 
-- 
-- @function [parent=#Mapping] getComponent
-- @return #string `component` attribute of the <b>&lt;mapping&gt;</b> element.
function Mapping:getComponent()
  return self:getAttribute("component")
end

---
-- Returns the component associated to
-- <b>&lt;mapping&gt;</b> element. 
-- 
-- @function [parent=#Mapping] getComponentAss
-- @return #object component associated to <b>&lt;mapping&gt;</b> element.
function Mapping:getComponentAss()
  return self.componentAss
end

---
-- Sets a value to `interface` attribute of the 
-- <b>&lt;mapping&gt;</b> element. 
-- 
-- @function [parent=#Mapping] setInterface
-- @param #stringOrObject interface `interface` attribute of the
-- <b>&lt;mapping&gt;</b> element.
function Mapping:setInterface(interface)
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
-- <b>&lt;mapping&gt;</b> element. 
-- 
-- @function [parent=#Mapping] getInterface
-- @return #string `interface` attribute of the <b>&lt;mapping&gt;</b> element.
function Mapping:getInterface()
  return self:getAttribute("interface")
end

---
-- Returns the interface associated to
-- <b>&lt;mapping&gt;</b> element. 
-- 
-- @function [parent=#Mapping] getInterfaceAss
-- @return #object interface associated to <b>&lt;mapping&gt;</b> element.
function Mapping:getInterfaceAss()
  return self.interfaceAss
end

return Mapping