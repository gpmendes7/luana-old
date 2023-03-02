local NCLElem = require "../../src/core/NCLElem"

---
-- Implements SimpleAction Class representing <b>&lt;simpleAction&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=simpleaction">
-- http://handbook.ncl.org.br/doku.php?id=simpleaction</a>
-- 
-- @module SimpleAction
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local SimpleAction = require "core/connectors/SimpleAction" 
local SimpleAction = NCLElem:extends()

---
-- Name of <b>&lt;simpleAction&gt;</b> element.
-- 
-- @field [parent=#SimpleAction] #string nameElem
SimpleAction.nameElem = "simpleAction"

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;simpleAction&gt;</b> element.
-- 
-- @field [parent=#SimpleAction] #table attributesTypeMap 
SimpleAction.attributesTypeMap = {
  role = "string",
  delay = {"string", "number"},
  eventType = "string",
  actionType = "string",
  value = {"string", "number"},
  min = {"string", "number"},
  max = {"string", "number"},
  qualifier = "string",
  ["repeat"] = {"string", "number"},
  repeatDelay = {"string", "number"},
  duration = {"string", "number"},
  by = {"string", "number"}
}

---
-- List containing all possible pre-definied values to string attributes
-- belonging to <b>&lt;simpleAction&gt;</b> element.
-- 
-- @field [parent=#SimpleAction] #table attributesStringValueMap 
SimpleAction.attributesStringValueMap = {
  eventType = {"presentation", "selection", "attribution"},
  actionType = {"start", "stop", "abort", "pause", "resume"},
  max = "unbounded",
  qualifier = {"seq", "par"},
  by = {"indefinite"}
}

---
-- List containing all possible pre-definied symbols to numeric attributes
-- belonging to <b>&lt;simpleAction&gt;</b> element.
-- 
-- @field [parent=#SimpleAction] #table attributesSymbolMap 
SimpleAction.attributesSymbolMap = {
  delay = "s",
  repeatDelay = "s",
  duration = "s"
}

---
-- Returns a new SimpleAction object. 
-- 
-- @function [parent=#SimpleAction] create
-- @param #table attributes list of attributes to be initialized.
-- @return #SimpleAction new SimpleAction object created.
function SimpleAction:create(attributes)
  local simpleAction = SimpleAction:new()

  simpleAction.role = nil
  simpleAction.delay = nil
  simpleAction.eventType = nil
  simpleAction.actionType = nil
  simpleAction.value = nil
  simpleAction.min = nil
  simpleAction.max = nil
  simpleAction.qualifier = nil
  simpleAction["repeat"] = nil
  simpleAction.repeatDelay = nil
  simpleAction.duration = nil
  simpleAction.by = nil
  
  simpleAction.symbols = {}

  if(attributes ~= nil)then
    simpleAction:setAttributes(attributes)
  end

  return simpleAction
end

---
-- Sets a value to `role` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] setRole
-- @param #string role `role` attribute of the
-- <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:setRole(role)
  self:addAttribute("role", role)
end

---
-- Returns the value of the `role` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] getRole
-- @return #string `role` attribute of the <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:getRole()
  return self:getAttribute("role")
end

---
-- Sets a value to `delay` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] setDelay
-- @param #stringOrnumber delay `delay` attribute of the
-- <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:setDelay(delay)
  self:addAttribute("delay", delay)
end

---
-- Returns the value of the `delay` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] getDelay
-- @return #stringOrnumber `delay` attribute of the <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:getDelay()
  return self:getAttribute("delay")
end

---
-- Sets a value to `eventType` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] setEventType
-- @param #string eventType `eventType` attribute of the
-- <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:setEventType(eventType)
  self:addAttribute("eventType", eventType)
end

---
-- Returns the value of the `eventType` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] getEventType
-- @return #string `eventType` attribute of the <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:getEventType()
  return self:getAttribute("eventType")
end

---
-- Sets a value to `actionType` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] setActionType
-- @param #string actionType `actionType` attribute of the
-- <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:setActionType(actionType)
  self:addAttribute("actionType", actionType)
end

---
-- Returns the value of the `actionType` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] getActionType
-- @return #string `actionType` attribute of the <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:getActionType()
  return self:getAttribute("actionType")
end

---
-- Sets a value to `value` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] setValue
-- @param #stringOrnumber value `value` attribute of the
-- <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:setValue(value)
  self:addAttribute("value", value)
end

---
-- Returns the value of the `value` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] getValue
-- @return #stringOrnumber `value` attribute of the <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:getValue()
  return self:getAttribute("value")
end

---
-- Sets a value to `min` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] setMin
-- @param #stringOrnumber min `min` attribute of the
-- <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:setMin(min)
  self:addAttribute("min", min)
end

---
-- Returns the value of the `min` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] getMin
-- @return #stringOrnumber `min` attribute of the <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:getMin()
  return self:getAttribute("min")
end

---
-- Sets a value to `max` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] setMax
-- @param #stringOrnumber max `max` attribute of the
-- <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:setMax(max)
  self:addAttribute("max", max)
end

---
-- Returns the value of the `max` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] getMax
-- @return #stringOrnumber `max` attribute of the <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:getMax()
  return self:getAttribute("max")
end

---
-- Sets a value to `qualifier` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] setQualifier
-- @param #string qualifier `qualifier` attribute of the
-- <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:setQualifier(qualifier)
  self:addAttribute("qualifier", qualifier)
end

---
-- Returns the value of the `qualifier` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] getQualifier
-- @return #string `qualifier` attribute of the <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:getQualifier()
  return self:getAttribute("qualifier")
end

---
-- Sets a value to `rep` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] setRepeat
-- @param #stringOrnumber rep `rep` attribute of the
-- <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:setRepeat(rep)
  self:addAttribute("repeat", rep)
end

---
-- Returns the value of the `repeat` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] getRepeat
-- @return #stringOrnumber `repeat` attribute of the <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:getRepeat()
  return self:getAttribute("repeat")
end

---
-- Sets a value to `repeatDelay` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] setRepeatDelay
-- @param #stringOrnumber repeatDelay `repeatDelay` attribute of the
-- <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:setRepeatDelay(repeatDelay)
  self:addAttribute("repeatDelay", repeatDelay)
end

---
-- Returns the value of the `repeatDelay` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] getRepeatDelay
-- @return #stringOrnumber `repeatDelay` attribute of the <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:getRepeatDelay()
  return self:getAttribute("repeatDelay")
end

---
-- Sets a value to `duration` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] setDuration
-- @param #stringOrnumber duration `duration` attribute of the
-- <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:setDuration(duration)
  self:addAttribute("duration", duration)
end

---
-- Returns the value of the `duration` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] getDuration
-- @return #stringOrnumber `duration` attribute of the <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:getDuration()
  return self:getAttribute("duration")
end

---
-- Sets a value to `by` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] setBy
-- @param #stringOrnumber by `by` attribute of the
-- <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:setBy(by)
  self:addAttribute("by", by)
end

---
-- Returns the value of the `by` attribute of the 
-- <b>&lt;simpleAction&gt;</b> element. 
-- 
-- @function [parent=#SimpleAction] getBy
-- @return #stringOrnumber `by` attribute of the <b>&lt;simpleAction&gt;</b> element.
function SimpleAction:getBy()
  return self:getAttribute("by")
end

return SimpleAction