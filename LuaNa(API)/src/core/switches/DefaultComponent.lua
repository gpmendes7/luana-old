local NCLElem = require "core/NCLElem"

---
-- Implements DefaultComponent Class representing <b>&lt;defaultComponent&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=defaultcomponent">
-- http://handbook.ncl.org.br/doku.php?id=defaultcomponent</a>
-- 
-- @module DefaultComponent
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local DefaultComponent = require "core/switches/DefaultComponent" 
local DefaultComponent = NCLElem:extends()

---
-- Name of <b>&lt;defaultComponent&gt;</b> element.
-- 
-- @field [parent=#DefaultComponent] #string nameElem 
DefaultComponent.nameElem = "defaultComponent"

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;defaultComponent&gt;</b> element.
-- 
-- @field [parent=#DefaultComponent] #table attributesTypeMap
DefaultComponent.attributesTypeMap = {
  component = "string"
}

---
-- List with associative map that connects an attribute to an specific object
-- representing a child NCL element of <b>&lt;defaultComponent&gt;</b> element.
-- 
-- @field [parent=#DefaultComponent] #table assMap
DefaultComponent.assMap = {
  {"component", "componentAss"}
}

---
-- Returns a new DefaultComponent object. 
-- 
-- @function [parent=#DefaultComponent] create
-- @param #table attributes list of attributes to be initialized.
-- @return #DefaultComponent new DefaultComponent object created.
function DefaultComponent:create(attributes)
  local defaultComponent = DefaultComponent:new()

  defaultComponent.component = nil

  defaultComponent.componentAss = nil

  if(attributes ~= nil)then
    defaultComponent:setAttributes(attributes)
  end

  return defaultComponent
end

---
-- Sets a value to `component` attribute of the 
-- <b>&lt;defaultComponent&gt;</b> element. 
-- 
-- @function [parent=#DefaultComponent] setRefer
-- @param #stringOrObject component `component` attribute of the
-- <b>&lt;defaultComponent&gt;</b> element.
function DefaultComponent:setComponent(component)
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
-- <b>&lt;defaultComponent&gt;</b> element. 
-- 
-- @function [parent=#DefaultComponent] getComponent
-- @return #string `component` attribute of the <b>&lt;defaultComponent&gt;</b> element.
function DefaultComponent:getComponent()
  return self:getAttribute("component")
end

---
-- Returns the component associated to
-- <b>&lt;defaultComponent&gt;</b> element. 
-- 
-- @function [parent=#Media] getReferAss
-- @return #object component associated to <b>&lt;defaultComponent&gt;</b> element.
function DefaultComponent:getComponentAss()
  return self.componentAss
end

return DefaultComponent