local NCLElem = require "core/NCLElem"

local AttributeAssessment = NCLElem:extends()

---
-- Implements AttributeAssessment Class representing <b>&lt;attributeAssessment&gt;</b> element.
-- 
-- The <b>&lt;attributeAssessment&gt;</b> element is used to define a variable to be evaluated, in <b>&lt;assessmentStatement&gt;</b> elements, against other variable values or an absolute value.
-- 
-- The variable can be a property specifies in a <b>&lt;property&gt;</b> element, or can be a (presentation, selection or attribution) event attribute: occurrences, repetition or state (which has the following values: “occurring”, “paused”, or “sleeping”).
-- 
-- The <b>&lt;attributeAssessment&gt;</b> element has a `role` attribute, which has to be unique in the connector role set. This attribute is the connector interface point, which is associated to node interfaces (<b>&lt;port&gt;</b>, <b>&lt;area&gt;</b>, <b>&lt;property&gt;</b> or <b>&lt;switchPort&gt;</b> elements) by a <b>&lt;link&gt;</b> that refers to the connector.
-- 
-- The variable defined by the element depends on its `eventType` attribute and its `attributeType` attribute:
--   If the `eventType` value is “presentation”, the attributeType attribute may specifyas variable:the “occurrences” or “repetition” event attributes,or the “state” event state.
--   If the `eventType` is “attribution” the attributeType may have the values: “nodeProperty” (specifying a node property), “occurrences”, “repetition” or “state”.
--   If the `eventType` value is “selection”, the <b>&lt;attributeAssessment&gt;</b> can also define to which selection apparatus (for example, keyboard keys or remote control keys) it refers, through its key attribute. The `attributeType` attribute may have the values: “occurrences” (default) or “state”.
--   An `offset` value may be added to an <b>&lt;attributeAssessment&gt;</b> before its comparison in an <assessmentStatement> element. For example, an offset may be added to an attributeassessment to specify: “the screen vertical position plus 50 pixels”.
--  
-- Implemented based in: <a href="http://handbook.ncl.org.br/doku.php?id=attributeassessment">
-- http://handbook.ncl.org.br/doku.php?id=attributeassessment</a>
-- 
-- @module AttributeAssessment
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local AttributeAssessment = require "core/connectors/AttributeAssessment" 
AttributeAssessment.nameElem = "attributeAssessment"

AttributeAssessment.attributesTypeMap = {
  role = "string",
  eventType = "string",
  key = "string",
  attributeType = "string",
  offset = "string"
}

AttributeAssessment.attributesStringValueMap = {
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
  attributeType = {"nodeProperty", "occurrences", "repetition", "state"}
}

function AttributeAssessment:create(attributes)
  local attributeAssessment = AttributeAssessment:new()

  attributeAssessment.role = nil
  attributeAssessment.eventType = nil
  attributeAssessment.key = nil
  attributeAssessment.attributeType = nil
  attributeAssessment.offset = nil

  if(attributes ~= nil)then
    attributeAssessment:setAttributes(attributes)
  end

  return attributeAssessment
end

function AttributeAssessment:setRole(role)
  self:addAttribute("role", role)
end

function AttributeAssessment:getRole()
  return self:getAttribute("role")
end

function AttributeAssessment:setEventType(eventType)
  self:addAttribute("eventType", eventType)
end

function AttributeAssessment:getEventType()
  return self:getAttribute("eventType")
end

function AttributeAssessment:setKey(key)
  self:addAttribute("key", key)
end

function AttributeAssessment:getKey()
  return self:getAttribute("key")
end

function AttributeAssessment:setAttributeType(attributeType)
  self:addAttribute("attributeType", attributeType)
end

function AttributeAssessment:getAttributeType()
  return self:getAttribute("attributeType")
end

function AttributeAssessment:setOffset(offset)
  self:addAttribute("offset", offset)
end

function AttributeAssessment:getOffset()
  return self:getAttribute("offset")
end

return AttributeAssessment