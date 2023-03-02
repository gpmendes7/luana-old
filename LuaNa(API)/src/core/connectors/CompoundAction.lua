local NCLElem = require "../../src/core/NCLElem"
local SimpleAction = require "../../src/core/connectors/SimpleAction"

---
-- Implements CompoundAction Class representing <b>&lt;compoundAction&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=compoundaction">
-- http://handbook.ncl.org.br/doku.php?id=compoundaction</a>
-- 
-- @module CompoundAction
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local CompoundAction = require "core/connectors/CompoundAction" 
local CompoundAction = NCLElem:extends()

---
-- Name of <b>&lt;compoundAction&gt;</b> element.
-- 
-- @field [parent=#CompoundAction] #string nameElem  
CompoundAction.nameElem = "compoundAction"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;compoundAction&gt;</b> element.
-- 
-- @field [parent=#CompoundAction] #table childrenMap
CompoundAction.childrenMap = {
  simpleAction = {SimpleAction, "many"},
  compoundAction = {CompoundAction, "many"}
}

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;compoundAction&gt;</b> element.
-- 
-- @field [parent=#CompoundAction] #table attributesTypeMap  
CompoundAction.attributesTypeMap = {
  operator = "string",
  delay = {"string", "number"}
}

---
-- List containing all possible pre-definied values to string attributes
-- belonging to <b>&lt;compoundAction&gt;</b> element.
-- 
-- @field [parent=#CompoundAction] #table attributesStringValueMap 
CompoundAction.attributesStringValueMap = {
  operator = {"seq", "par"}
}

---
-- List containing all possible pre-definied symbols to numeric attributes
-- belonging to <b>&lt;compoundAction&gt;</b> element.
-- 
-- @field [parent=#CompoundAction] #table attributesSymbolMap 
CompoundAction.attributesSymbolMap = {
  delay = "s"
}

---
-- Returns a new CompoundAction object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#CompoundAction] create
-- @param #table attributes list of attributes to be initialized.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #CompoundAction new CompoundAction object created.
function CompoundAction:create(attributes, full)
  local compoundAction = CompoundAction:new()

  compoundAction.operator = nil
  compoundAction.delay = nil

  if(attributes ~= nil)then
    compoundAction:setAttributes(attributes)
  end

  compoundAction.children = {}
  compoundAction.simpleActions = {}
  compoundAction.compoundActions = {}

  compoundAction.symbols = {}

  if(full ~= nil)then
    compoundAction:addSimpleAction(SimpleAction:create())
    compoundAction:addCompoundAction(CompoundAction:create())
  end

  return compoundAction
end

---
-- Sets a value to `operator` attribute of the 
-- <b>&lt;compoundAction&gt;</b> element. 
-- 
-- @function [parent=#CompoundAction] setComparator
-- @param #string operator `operator` attribute of the
-- <b>&lt;compoundAction&gt;</b> element.
function CompoundAction:setOperator(operator)
  self:addAttribute("operator", operator)
end

---
-- Returns the value of the `operator` attribute of the 
-- <b>&lt;compoundAction&gt;</b> element. 
-- 
-- @function [parent=#CompoundAction] getComparator
-- @return #string `operator` attribute of the <b>&lt;compoundAction&gt;</b> element.
function CompoundAction:getOperator()
  return self:getAttribute("operator")
end

---
-- Sets a value to `delay` attribute of the 
-- <b>&lt;compoundAction&gt;</b> element. 
-- 
-- @function [parent=#CompoundAction] setDelay
-- @param #stringOrnumber delay `delay` attribute of the
-- <b>&lt;compoundAction&gt;</b> element.
function CompoundAction:setDelay(delay)
  self:addAttribute("delay", delay)
end

---
-- Returns the value of the `delay` attribute of the 
-- <b>&lt;compoundAction&gt;</b> element. 
-- 
-- @function [parent=#CompoundAction] getDelay
-- @return #stringOrnumber `delay` attribute of the <b>&lt;compoundAction&gt;</b> element.
function CompoundAction:getDelay()
  return self:getAttribute("delay")
end

---
-- Adds a <b>&lt;simpleAction&gt;</b> child element of the 
-- <b>&lt;compoundAction&gt;</b> element. 
-- 
-- @function [parent=#CompoundAction] addSimpleAction
-- @param #SimpleAction simpleAction object representing the 
-- <b>&lt;simpleAction&gt;</b> element.
function CompoundAction:addSimpleAction(simpleAction)
  if((type(simpleAction) == "table"
    and simpleAction["getNameElem"] ~= nil
    and simpleAction:getNameElem() ~= "simpleAction")
    or (type(simpleAction) == "table"
    and simpleAction["getNameElem"] == nil)
    or type(simpleAction) ~= "table")then
    error("Error! Invalid simpleAction element!", 2)
  end

  self:addChild(simpleAction)
  table.insert(self.simpleActions, simpleAction)
end

---
-- Returns a <b>&lt;simpleAction&gt;</b> child element of the 
-- <b>&lt;compoundAction&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#CompoundAction] getSimpleActionPos
-- @param #number p  position of the object representing the <b>&lt;simpleAction&gt;</b> element.
function CompoundAction:getSimpleActionPos(p)
  if(self.simpleActions == nil)then
    error("Error! compoundAction element with nil simpleActions list!", 2)
  elseif(p > #self.simpleActions)then
    error("Error! compoundAction element doesn't have a simpleAction child in position "..p.."!", 2)
  end

  return self.simpleActions[p]
end

---
-- Adds so many <b>&lt;simpleAction&gt;</b> child elements of the <b>&lt;compoundAction&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#CompoundAction] setSimpleActions
-- @param #SimpleAction ... objects representing the <b>&lt;simpleAction&gt;</b> element.
function CompoundAction:setSimpleActions(...)
  if(#arg>0)then
    for _, simpleAction in ipairs(arg) do
      self:addSimpleAction(simpleAction)
    end
  end
end

---
-- Removes a <b>&lt;simpleAction&gt;</b> child element of the 
-- <b>&lt;compoundAction&gt;</b> element. 
-- 
-- @function [parent=#CompoundAction] removeSimpleAction
-- @param #SimpleAction simpleAction object representing the <b>&lt;simpleAction&gt;</b> element.
function CompoundAction:removeSimpleAction(simpleAction)
  if((type(simpleAction) == "table"
    and simpleAction["getNameElem"] ~= nil
    and simpleAction:getNameElem() ~= "simpleAction")
    or (type(simpleAction) == "table"
    and simpleAction["getNameElem"] == nil)
    or type(simpleAction) ~= "table")then
    error("Error! Invalid simpleAction element!", 2)
  elseif(self.children == nil)then
    error("Error! compoundAction element with nil children list!", 2)
  elseif(self.simpleActions == nil)then
    error("Error! compoundAction element with nil simpleActions list!", 2)
  end

  self:removeChild(simpleAction)

  for p, sa in ipairs(self.simpleActions) do
    if(simpleAction == sa)then
      table.remove(self.simpleActions, p)
    end
  end
end

---
-- Removes a <b>&lt;simpleAction&gt;</b> child element of the 
-- <b>&lt;compoundAction&gt;</b> element in position `p`.
-- 
-- @function [parent=#CompoundAction] removeSimpleActionPos
-- @param #number p position of the <b>&lt;simpleAction&gt;</b> child element.
function CompoundAction:removeSimpleActionPos(p)
  if(self.children == nil)then
    error("Error! compoundAction element with nil children list!", 2)
  elseif(self.simpleActions == nil)then
    error("Error! compoundAction element with nil simpleActions list!", 2)
  elseif(p > #self.children)then
    error("Error! compoundAction element doesn't have a simpleAction child in position "..p.."!", 2)
  elseif(p > #self.simpleActions)then
    error("Error! compoundAction element doesn't have a simpleAction child in position "..p.."!", 2)
  end

  self:removeChild(self.simpleActions[p])
  table.remove(self.simpleActions, p)
end

---
-- Adds a <b>&lt;compoundAction&gt;</b> child element of the 
-- <b>&lt;compoundAction&gt;</b> element. 
-- 
-- @function [parent=#CompoundAction] addCompoundAction
-- @param #CompoundAction compoundAction object representing the 
-- <b>&lt;compoundAction&gt;</b> element.
function CompoundAction:addCompoundAction(compoundAction)
  if((type(compoundAction) == "table"
    and compoundAction["getNameElem"] ~= nil
    and compoundAction:getNameElem() ~= "compoundAction")
    or (type(compoundAction) == "table"
    and compoundAction["getNameElem"] == nil)
    or type(compoundAction) ~= "table")then
    error("Error! Invalid compoundAction element!", 2)
  end

  self:addChild(compoundAction)
  table.insert(self.compoundActions, compoundAction)
end

---
-- Returns a <b>&lt;compoundAction&gt;</b> child element of the 
-- <b>&lt;compoundAction&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#CompoundAction] getCompoundActionPos
-- @param #number p  position of the object representing the <b>&lt;compoundAction&gt;</b> element.
function CompoundAction:getCompoundActionPos(p)
  if(self.compoundActions == nil)then
    error("Error! compoundAction element with nil compoundActions list!", 2)
  elseif(p > #self.compoundActions)then
    error("Error! compoundAction element doesn't have a compoundAction child in position "..p.."!", 2)
  end

  return self.compoundActions[p]
end

---
-- Adds so many <b>&lt;compoundAction&gt;</b> child elements of the <b>&lt;compoundAction&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#CompoundAction] setCompoundActions
-- @param #CompoundAction ... objects representing the <b>&lt;compoundAction&gt;</b> element.
function CompoundAction:setCompoundActions(...)
  if(#arg>0)then
    for _, compoundAction in ipairs(arg) do
      self:addCompoundAction(compoundAction)
    end
  end
end

---
-- Removes a <b>&lt;compoundAction&gt;</b> child element of the 
-- <b>&lt;compoundAction&gt;</b> element. 
-- 
-- @function [parent=#CompoundAction] removeSimpleAction
-- @param #CompoundAction compoundAction object representing the <b>&lt;compoundAction&gt;</b> element.
function CompoundAction:removeCompoundAction(compoundAction)
  if((type(compoundAction) == "table"
    and compoundAction["getNameElem"] ~= nil
    and compoundAction:getNameElem() ~= "compoundAction")
    or (type(compoundAction) == "table"
    and compoundAction["getNameElem"] == nil)
    or type(compoundAction) ~= "table")then
    error("Error! Invalid compoundAction element!", 2)
  elseif(self.children == nil)then
    error("Error! compoundAction element with nil children list!", 2)
  elseif(self.compoundActions == nil)then
    error("Error! compoundAction element with nil compoundActions list!", 2)
  end

  self:removeChild(compoundAction)

  for p, ca in ipairs(self.compoundActions) do
    if(compoundAction == ca)then
      table.remove(self.compoundActions, p)
    end
  end
end

---
-- Removes a <b>&lt;compoundAction&gt;</b> child element of the 
-- <b>&lt;compoundAction&gt;</b> element in position `p`.
-- 
-- @function [parent=#CompoundAction] removeCompoundActionPos
-- @param #number p position of the <b>&lt;compoundAction&gt;</b> child element.
function CompoundAction:removeCompoundActionPos(p)
   if(self.children == nil)then
    error("Error! compoundAction element with nil children list!", 2)
  elseif(self.compoundActions == nil)then
    error("Error! compoundAction element with nil compoundActions list!", 2)
  elseif(p > #self.children)then
    error("Error! compoundAction element doesn't have a compoundAction child in position "..p.."!", 2)
  elseif(p > #self.compoundActions)then
    error("Error! compoundAction element doesn't have a compoundAction child in position "..p.."!", 2)
  end
  
  self:removeChild(self.compoundActions[p])
  table.remove(self.compoundActions, p)
end

return CompoundAction