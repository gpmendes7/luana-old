local NCLElem = require "core/NCLElem"

local AttributeAssessment = NCLElem:extends()

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
