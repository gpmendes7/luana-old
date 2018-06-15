local NCLElem = require "core/NCLElem"

---
-- Implements AttributeAssessment Class representing <b>&lt;attributeAssessment&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=attributeassessment">
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
local AttributeAssessment = NCLElem:extends()

---
-- Name of <b>&lt;attributeAssessment&gt;</b> element.
-- 
-- @field [parent=#AttributeAssessment] #string nameElem 
AttributeAssessment.nameElem = "attributeAssessment"

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;attributeAssessment&gt;</b> element.
-- 
-- @field [parent=#AttributeAssessment] #table attributesTypeMap
AttributeAssessment.attributesTypeMap = {
  role = "string",
  eventType = "string",
  key = "string",
  attributeType = "string",
  offset = "string"
}

---
-- List containing all possible pre-definied values to string attributes
-- belonging to <b>&lt;attributeAssessment&gt;</b> element.
-- 
-- @field [parent=#AttributeAssessment] #table attributesStringValueMap 
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

---
-- Returns a new AttributeAssessment object.   
-- 
-- @function [parent=#AttributeAssessment] create
-- @param #table attributes list of attributes to be initialized.
-- @return #AttributeAssessment new AttributeAssessment object created.
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

---
-- Sets a value to `role` attribute of the 
-- <b>&lt;attributeAssessment&gt;</b> element. 
-- 
-- @function [parent=#AttributeAssessment] setRole
-- @param #string role `role` attribute of the
-- <b>&lt;attributeAssessment&gt;</b> element.
function AttributeAssessment:setRole(role)
  self:addAttribute("role", role)
end

---
-- Returns the value of the `role` attribute of the 
-- <b>&lt;attributeAssessment&gt;</b> element. 
-- 
-- @function [parent=#AttributeAssessment] getRole
-- @return #string `role` attribute of the <b>&lt;attributeAssessment&gt;</b> element.
function AttributeAssessment:getRole()
  return self:getAttribute("role")
end

---
-- Sets a value to `eventType` attribute of the 
-- <b>&lt;attributeAssessment&gt;</b> element. 
-- 
-- @function [parent=#AttributeAssessment] setEventType
-- @param #string eventType `eventType` attribute of the
-- <b>&lt;attributeAssessment&gt;</b> element.
function AttributeAssessment:setEventType(eventType)
  self:addAttribute("eventType", eventType)
end

---
-- Returns the value of the `eventType` attribute of the 
-- <b>&lt;attributeAssessment&gt;</b> element. 
-- 
-- @function [parent=#AttributeAssessment] getEventType
-- @return #string `eventType` attribute of the <b>&lt;attributeAssessment&gt;</b> element.
function AttributeAssessment:getEventType()
  return self:getAttribute("eventType")
end

---
-- Sets a value to `key` attribute of the 
-- <b>&lt;attributeAssessment&gt;</b> element. 
-- 
-- @function [parent=#AttributeAssessment] setKey
-- @param #string key `key` attribute of the
-- <b>&lt;attributeAssessment&gt;</b> element.
function AttributeAssessment:setKey(key)
  self:addAttribute("key", key)
end

---
-- Returns the value of the `key` attribute of the 
-- <b>&lt;attributeAssessment&gt;</b> element. 
-- 
-- @function [parent=#AttributeAssessment] getKey
-- @return #string `key` attribute of the <b>&lt;attributeAssessment&gt;</b> element.
function AttributeAssessment:getKey()
  return self:getAttribute("key")
end

---
-- Sets a value to `attributeType` attribute of the 
-- <b>&lt;attributeAssessment&gt;</b> element. 
-- 
-- @function [parent=#AttributeAssessment] setAttributeType
-- @param #string attributeType `attributeType` attribute of the
-- <b>&lt;attributeAssessment&gt;</b> element.
function AttributeAssessment:setAttributeType(attributeType)
  self:addAttribute("attributeType", attributeType)
end

---
-- Returns the value of the `attributeType` attribute of the 
-- <b>&lt;attributeAssessment&gt;</b> element. 
-- 
-- @function [parent=#AttributeAssessment] getAttributeType
-- @return #string `attributeType` attribute of the <b>&lt;attributeAssessment&gt;</b> element.
function AttributeAssessment:getAttributeType()
  return self:getAttribute("attributeType")
end

---
-- Sets a value to `offset` attribute of the 
-- <b>&lt;attributeAssessment&gt;</b> element. 
-- 
-- @function [parent=#AttributeAssessment] setOffset
-- @param #string offset `offset` attribute of the
-- <b>&lt;attributeAssessment&gt;</b> element.
function AttributeAssessment:setOffset(offset)
  self:addAttribute("offset", offset)
end

---
-- Returns the value of the `offset` attribute of the 
-- <b>&lt;attributeAssessment&gt;</b> element. 
-- 
-- @function [parent=#AttributeAssessment] getOffset
-- @return #string `offset` attribute of the <b>&lt;attributeAssessment&gt;</b> element.
function AttributeAssessment:getOffset()
  return self:getAttribute("offset")
end

return AttributeAssessment