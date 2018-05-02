local NCLElem = require "core/NCLElem"

local SimpleAction = NCLElem:extends()

SimpleAction.nameElem = "simpleAction"

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

SimpleAction.attributesStringValueMap = {
  eventType = {"presentation", "selection", "attribution"},
  actionType = {"start", "stop", "abort", "pause", "resume"},
  max = "unbounded",
  qualifier = {"seq", "par"},
  by = {"indefinite"}
}

SimpleAction.attributesSymbolMap = {
  delay = "s",
  repeatDelay = "s",
  duration = "s"
}

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

function SimpleAction:setRole(role)
  self:addAttribute("role", role)
end

function SimpleAction:getRole()
  return self:getAttribute("role")
end

function SimpleAction:setDelay(delay, symbol)
  self:addAttribute("delay", delay, symbol)
end

function SimpleAction:getDelay()
  return self:getAttribute("delay")
end

function SimpleAction:setEventType(eventType)
  self:addAttribute("eventType", eventType)
end

function SimpleAction:getEventType()
  return self:getAttribute("eventType")
end

function SimpleAction:setActionType(actionType)
  self:addAttribute("actionType", actionType)
end

function SimpleAction:getActionType()
  return self:getAttribute("actionType")
end

function SimpleAction:setValue(value)
  self:addAttribute("value", value)
end

function SimpleAction:getValue()
  return self:getAttribute("value")
end

function SimpleAction:setMin(min)
  self:addAttribute("min", min)
end

function SimpleAction:getMin()
  return self:getAttribute("min")
end

function SimpleAction:setMax(max)
  self:addAttribute("max", max)
end

function SimpleAction:getMax()
  return self:getAttribute("max")
end

function SimpleAction:setQualifier(qualifier)
  self:addAttribute("qualifier", qualifier)
end

function SimpleAction:getQualifier()
  return self:getAttribute("qualifier")
end

function SimpleAction:setRepeat(rep)
  self:addAttribute("repeat", rep)
end

function SimpleAction:getRepeat()
  return self:getAttribute("repeat")
end

function SimpleAction:setRepeatDelay(repeatDelay, symbol)
  self:addAttribute("repeatDelay", repeatDelay, symbol)
end

function SimpleAction:getRepeatDelay()
  return self:getAttribute("repeatDelay")
end

function SimpleAction:setDuration(duration, symbol)
  self:addAttribute("duration", duration, symbol)
end

function SimpleAction:getDuration()
  return self:getAttribute("duration")
end

function SimpleAction:setBy(by)
  self:addAttribute("by", by)
end

function SimpleAction:getBy()
  return self:getAttribute("by")
end

return SimpleAction