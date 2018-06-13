local NCLElem = require "core/NCLElem"
local BindParam = require "core/linking/BindParam"

---
-- Implements Bind Class representing <b>&lt;bind&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=bind">
-- http://handbook.ncl.org.br/doku.php?id=bind</a>
-- 
-- @module Bind
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local Bind = require "core/linking/Bind" 
local Bind = NCLElem:extends()

---
-- Name of <b>&lt;bind&gt;</b> element.
-- 
-- @field [parent=#Bind] #string nameElem
Bind.nameElem = "bind"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;bind&gt;</b> element.
-- 
-- @field [parent=#Bind] #table childrenMap
Bind.childrenMap = {
  bindParam = {BindParam, "many"}
}

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;bind&gt;</b> element.
-- 
-- @field [parent=#Bind] #table attributesTypeMap 
Bind.attributesTypeMap = {
  role = "string",
  component = "string",
  interface = "string",
  descriptor = "string"
}

---
-- List with associative map that connects an attribute to an specific object
-- representing a child NCL element of <b>&lt;bind&gt;</b> element.
-- 
-- @field [parent=#Bind] #table assMap
Bind.assMap = {
  {"component", "componentAss"},
  {"interface", "interfaceAss"},
  {"descriptor", "descriptorAss"}
}

---
-- Returns a new Bind object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#Bind] create
-- @param #table attributes list of attributes to be initialized.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #Bind Bind object created.
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

---
-- Sets a value to `role` attribute of the 
-- <b>&lt;bind&gt;</b> element. 
-- 
-- @function [parent=#Bind] setRole
-- @param #string role `role` atribute of the
-- <b>&lt;bind&gt;</b> element.
function Bind:setRole(role)
  self:addAttribute("role", role)
end

---
-- Returns the value of the `role` attribute of the 
-- <b>&lt;bind&gt;</b> element. 
-- 
-- @function [parent=#Bind] getRole
-- @return #string `role` atribute of the <b>&lt;bind&gt;</b> element.
function Bind:getRole()
  return self:getAttribute("role")
end

---
-- Sets a value to `component` attribute of the 
-- <b>&lt;bind&gt;</b> element. 
-- 
-- @function [parent=#Bind] setComponent
-- @param #stringOrobject component `component` atribute of the
-- <b>&lt;bind&gt;</b> element.
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

---
-- Returns the value of the `component` attribute of the 
-- <b>&lt;bind&gt;</b> element. 
-- 
-- @function [parent=#Bind] getComponent
-- @return #string `component` atribute of the <b>&lt;bind&gt;</b> element.
function Bind:getComponent()
  return self:getAttribute("component")
end

---
-- Returns the component associated to
-- <b>&lt;bind&gt;</b> element. 
-- 
-- @function [parent=#Bind] getComponentAss
-- @return #object component associated to <b>&lt;bind&gt;</b> element.
function Bind:getComponentAss()
  return self.componentAss
end

---
-- Sets a value to `interface` attribute of the 
-- <b>&lt;bind&gt;</b> element. 
-- 
-- @function [parent=#Bind] setInterface
-- @param #stringOrobject interface `interface` atribute of the
-- <b>&lt;bind&gt;</b> element.
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

---
-- Returns the value of the `interface` attribute of the 
-- <b>&lt;bind&gt;</b> element. 
-- 
-- @function [parent=#Bind] getInterface
-- @return #string `interface` atribute of the <b>&lt;bind&gt;</b> element.
function Bind:getInterface()
  return self:getAttribute("interface")
end

---
-- Returns the interface associated to
-- <b>&lt;bind&gt;</b> element. 
-- 
-- @function [parent=#Bind] getInterfaceAss
-- @return #object interface associated to <b>&lt;bind&gt;</b> element.
function Bind:getInterfaceAss()
  return self.interfaceAss
end

---
-- Sets a value to `descriptor` attribute of the 
-- <b>&lt;bind&gt;</b> element. 
-- 
-- @function [parent=#Bind] setDescriptor
-- @param #stringOrobject descriptor `descriptor` atribute of the
-- <b>&lt;bind&gt;</b> element.
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

---
-- Returns the value of the `descriptor` attribute of the 
-- <b>&lt;bind&gt;</b> element. 
-- 
-- @function [parent=#Bind] getDescriptor
-- @return #string `descriptor` atribute of the <b>&lt;bind&gt;</b> element.
function Bind:getDescriptor()
  return self:getAttribute("descriptor")
end

---
-- Returns the descriptor associated to
-- <b>&lt;bind&gt;</b> element. 
-- 
-- @function [parent=#Bind] getDescriptorAss
-- @return #object descriptor associated to <b>&lt;bind&gt;</b> element.
function Bind:getDescriptorAss()
  return self.descriptorAss
end

---
-- Adds a <b>&lt;bindParam&gt;</b> child element of the 
-- <b>&lt;bind&gt;</b> element. 
-- 
-- @function [parent=#Bind] addBindParam
-- @param #BindParam bindParam object representing the 
-- <b>&lt;bindParam&gt;</b> element.
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

---
-- Returns a <b>&lt;bindParam&gt;</b> child element of the 
-- <b>&lt;bind&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Bind] getBindParamPos
-- @param #number p  position of the object representing 
-- the <b>&lt;bindParam&gt;</b> element.
function Bind:getBindParamPos(p)
  if(self.bindParams == nil)then
    error("Error! bind element with nil bindParams list!", 2)
  elseif(p > #self.bindParams)then
    error("Error! bind element doesn't have a bindParam child in position "..p.."!", 2)
  end

  return self.bindParams[p]
end

---
-- Adds so many <b>&lt;bindParam&gt;</b> child elements of the <b>&lt;bind&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Bind] setBindParams
-- @param #BindParam ... objects representing the <b>&lt;bindParam&gt;</b> element.
function Bind:setBindParams(...)
  if(#arg>0)then
    for _, bindParam in ipairs(arg) do
      self:addBindParam(bindParam)
    end
  end
end

---
-- Removes a <b>&lt;bindParam&gt;</b> child element of the 
-- <b>&lt;bind&gt;</b> element. 
-- 
-- @function [parent=#Bind] removeBindParam
-- @param #BindParam bindParam object representing the <b>&lt;bindParam&gt;</b> element.
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

---
-- Removes a <b>&lt;bindParam&gt;</b> child element of the 
-- <b>&lt;bind&gt;</b> element in position `p`.
-- 
-- @function [parent=#Bind] removeBindParamPos
-- @param #number p position of the <b>&lt;bindParam&gt;</b> child element.
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