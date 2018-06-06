local NCLElem = require "core/NCLElem"

---
-- Implements SimpleCondition Class representing <b>&lt;simpleCondition&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=simplecondition">
-- http://handbook.ncl.org.br/doku.php?id=simplecondition</a>
-- 
-- @module SimpleCondition
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local SimpleCondition = require "core/connectors/SimpleCondition" 
local SimpleCondition = NCLElem:extends()

---
-- Name of <b>&lt;simpleCondition&gt;</b> element.
-- 
-- @field [parent=#SimpleCondition] #string nameElem
SimpleCondition.nameElem = "simpleCondition"

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;simpleCondition&gt;</b> element.
-- 
-- @field [parent=#SimpleCondition] #table attributesTypeMap 
SimpleCondition.attributesTypeMap = {
  role = "string",
  delay = {"string", "number"},
  eventType = "string",
  key = "string",
  transition = "string",
  min = {"string", "number"},
  max = {"string", "number"},
  qualifier = "string"
}

---
-- List containing all possible pre-definied values to string attributes
-- belonging to <b>&lt;simpleCondition&gt;</b> element.
-- 
-- @field [parent=#SimpleCondition] #table attributesStringValueMap
SimpleCondition.attributesStringValueMap = {
  eventType = {"presentation", "selection", "attribution"},
  key = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
    "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
    "U", "V", "W", "X", "Y", "Z", "*", "#", "MENU",
    "INFO", "GUIDE", "CURSOR_DOWN", "CURSOR_LEFT",
    "CURSOR_RIGHT", "CURSOR_UP", "CHANNEL_DOWN",
    "CHANNEL_UP", "VOLUME_DOWN", "VOLUME_UP", "ENTER",
    "RED", "GREEN", "YELLOW", "BLUE", "BACK", "EXIT",
    "POWER", "REWIND", "STOP", "EJECT", "PLAY", "RECORD", "PAUSE"},
  transition = {"starts", "stops", "aborts", "pauses", "resumes"},
  max = "unbounded",
  qualifier = {"and", "or"}
}

---
-- List containing all possible pre-definied symbols to numeric attributes
-- belonging to <b>&lt;simpleCondition&gt;</b> element.
-- 
-- @field [parent=#SimpleCondition] #table attributesSymbolMap 
SimpleCondition.attributesSymbolMap = {
  delay = "s"
}

---
-- Returns a new SimpleCondition object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#SimpleCondition] create
-- @param #table attributes list of attributes to be initialized.
-- @return #SimpleCondition new SimpleCondition object created.
function SimpleCondition:create(attributes)
  local simpleCondition = SimpleCondition:new()

  simpleCondition.role = nil
  simpleCondition.delay = nil
  simpleCondition.eventType = nil
  simpleCondition.key = nil
  simpleCondition.transition = nil
  simpleCondition.min = nil
  simpleCondition.max = nil
  simpleCondition.qualifier = nil
  
  simpleCondition.symbols = {}

  if(attributes ~= nil)then
    simpleCondition:setAttributes(attributes)
  end

  return simpleCondition
end

---
-- Sets a value to `role` attribute of the 
-- <b>&lt;simpleCondition&gt;</b> element. 
-- 
-- @function [parent=#SimpleCondition] setRole
-- @param #string role `role` atribute of the
-- <b>&lt;simpleCondition&gt;</b> element.
function SimpleCondition:setRole(role)
  self:addAttribute("role", role)
end

---
-- Returns the value of the `role` attribute of the 
-- <b>&lt;simpleCondition&gt;</b> element. 
-- 
-- @function [parent=#SimpleCondition] getRole
-- @return #string `role` atribute of the <b>&lt;simpleCondition&gt;</b> element.
function SimpleCondition:getRole()
  return self:getAttribute("role")
end

---
-- Sets a value to `delay` attribute of the 
-- <b>&lt;simpleCondition&gt;</b> element. 
-- 
-- @function [parent=#SimpleCondition] setDelay
-- @param #stringOrNumber delay `delay` atribute of the
-- <b>&lt;simpleCondition&gt;</b> element.
function SimpleCondition:setDelay(delay)
  self:addAttribute("delay", delay)
end

---
-- Returns the value of the `delay` attribute of the 
-- <b>&lt;simpleCondition&gt;</b> element. 
-- 
-- @function [parent=#SimpleCondition] getDelay
-- @return #stringOrNumber `delay` atribute of the <b>&lt;simpleCondition&gt;</b> element.
function SimpleCondition:getDelay()
  return self:getAttribute("delay")
end

---
-- Sets a value to `eventType` attribute of the 
-- <b>&lt;simpleCondition&gt;</b> element. 
-- 
-- @function [parent=#SimpleCondition] setEventType
-- @param #string eventType `eventType` atribute of the
-- <b>&lt;simpleCondition&gt;</b> element.
function SimpleCondition:setEventType(eventType)
  self:addAttribute("eventType", eventType)
end

---
-- Returns the value of the `eventType` attribute of the 
-- <b>&lt;simpleCondition&gt;</b> element. 
-- 
-- @function [parent=#SimpleCondition] getEventType
-- @return #string `eventType` atribute of the <b>&lt;simpleCondition&gt;</b> element.
function SimpleCondition:getEventType()
  return self:getAttribute("eventType")
end

---
-- Sets a value to `key` attribute of the 
-- <b>&lt;simpleCondition&gt;</b> element. 
-- 
-- @function [parent=#SimpleCondition] setKey
-- @param #string key `key` atribute of the
-- <b>&lt;simpleCondition&gt;</b> element.
function SimpleCondition:setKey(key)
  self:addAttribute("key", key)
end

---
-- Returns the value of the `key` attribute of the 
-- <b>&lt;simpleCondition&gt;</b> element. 
-- 
-- @function [parent=#SimpleCondition] getKey
-- @return #string `key` atribute of the <b>&lt;simpleCondition&gt;</b> element.
function SimpleCondition:getKey()
  return self:getAttribute("key")
end

---
-- Sets a value to `transition` attribute of the 
-- <b>&lt;simpleCondition&gt;</b> element. 
-- 
-- @function [parent=#SimpleCondition] setTransition
-- @param #string transition `transition` atribute of the
-- <b>&lt;simpleCondition&gt;</b> element.
function SimpleCondition:setTransition(transition)
  self:addAttribute("transition", transition)
end

---
-- Returns the value of the `transition` attribute of the 
-- <b>&lt;simpleCondition&gt;</b> element. 
-- 
-- @function [parent=#SimpleCondition] getTransition
-- @return #string `transition` atribute of the <b>&lt;simpleCondition&gt;</b> element.
function SimpleCondition:getTransition()
  return self:getAttribute("transition")
end

---
-- Sets a value to `min` attribute of the 
-- <b>&lt;simpleCondition&gt;</b> element. 
-- 
-- @function [parent=#min] setMin
-- @param #stringOrNumber min `min` atribute of the
-- <b>&lt;simpleCondition&gt;</b> element.
function SimpleCondition:setMin(min)
  self:addAttribute("min", min)
end

---
-- Returns the value of the `min` attribute of the 
-- <b>&lt;simpleCondition&gt;</b> element. 
-- 
-- @function [parent=#SimpleCondition] getMin
-- @return #stringOrNumber `min` atribute of the <b>&lt;simpleCondition&gt;</b> element.
function SimpleCondition:getMin()
  return self:getAttribute("min")
end

---
-- Sets a value to `max` attribute of the 
-- <b>&lt;simpleCondition&gt;</b> element. 
-- 
-- @function [parent=#SimpleCondition] setMax
-- @param #stringOrNumber max `max` atribute of the
-- <b>&lt;simpleCondition&gt;</b> element.
function SimpleCondition:setMax(max)
  self:addAttribute("max", max)
end

---
-- Returns the value of the `max` attribute of the 
-- <b>&lt;simpleCondition&gt;</b> element. 
-- 
-- @function [parent=#SimpleCondition] getMax
-- @return #stringOrNumber `max` atribute of the <b>&lt;simpleCondition&gt;</b> element.
function SimpleCondition:getMax()
  return self:getAttribute("max")
end

---
-- Sets a value to `qualifier` attribute of the 
-- <b>&lt;simpleCondition&gt;</b> element. 
-- 
-- @function [parent=#SimpleCondition] setQualifier
-- @param #string qualifier `qualifier` atribute of the
-- <b>&lt;simpleCondition&gt;</b> element.
function SimpleCondition:setQualifier(qualifier)
  self:addAttribute("qualifier", qualifier)
end

---
-- Returns the value of the `qualifier` attribute of the 
-- <b>&lt;simpleCondition&gt;</b> element. 
-- 
-- @function [parent=#SimpleCondition] getQualifier
-- @return #string `qualifier` atribute of the <b>&lt;simpleCondition&gt;</b> element.
function SimpleCondition:getQualifier()
  return self:getAttribute("qualifier")
end

return SimpleCondition