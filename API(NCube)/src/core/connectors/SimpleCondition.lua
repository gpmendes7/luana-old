local NCLElem = require "core/NCLElem"

local SimpleCondition = NCLElem:extends()

SimpleCondition.nameElem = "simpleCondition"

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

  if(attributes ~= nil)then
    simpleCondition:setAttributes(attributes)
  end

  return simpleCondition
end

function SimpleCondition:setRole(role)
  self:addAttribute("role", role)
end

function SimpleCondition:getRole()
  return self:getAttribute("role")
end

function SimpleCondition:setDelay(delay)
  self:addAttribute("delay", delay)
end

function SimpleCondition:getDelay()
  return self:getAttribute("delay")
end

function SimpleCondition:setEventType(eventType)
  self:addAttribute("eventType", eventType)
end

function SimpleCondition:getEventType()
  return self:getAttribute("eventType")
end

function SimpleCondition:setKey(key)
  self:addAttribute("key", key)
end

function SimpleCondition:getKey()
  return self:getAttribute("key")
end

function SimpleCondition:setTransition(transition)
  self:addAttribute("transition", transition)
end

function SimpleCondition:getTransition()
  return self:getAttribute("transition")
end

function SimpleCondition:setMin(min)
  self:addAttribute("min", min)
end

function SimpleCondition:getMin()
  return self:getAttribute("min")
end

function SimpleCondition:setMax(max)
  self:addAttribute("max", max)
end

function SimpleCondition:getMax()
  return self:getAttribute("max")
end

function SimpleCondition:setQualifier(qualifier)
  self:addAttribute("qualifier", qualifier)
end

function SimpleCondition:getQualifier()
  return self:getAttribute("qualifier")
end

return SimpleCondition