local NCLElem = require "core/NCLElem"

local SimpleAction = NCLElem:extends()

SimpleAction.name = "simpleAction"

SimpleAction.attributes = {
  role = nil,
  delay = nil,
  eventType = nil,
  actionType = nil,
  value = nil,
  min = nil,
  max = nil,
  qualifier = nil,
  ["repeat"] = nil,
  repeatDelay = nil,
  duration = nil,
  by = nil
}

function SimpleAction:create(attributes)  
   local attributes = attributes or {}  
   local simpleAction = SimpleAction:new() 
     
   simpleAction:setAttributes(attributes)
   simpleAction:setChilds()
   
   return simpleAction
end

function SimpleAction:setRole(role)
   self.attributes.role = role
end

function SimpleAction:getRole()
   return self.attributes.role
end

function SimpleAction:setDelay(delay)
   self.attributes.delay = delay
end

function SimpleAction:getDelay()
   return self.attributes.delay
end

function SimpleAction:setEventType(eventType)
   self.attributes.eventType = eventType
end

function SimpleAction:getEventType()
   return self.attributes.eventType
end

function SimpleAction:setActionType(actionType)
   self.attributes.actionType = actionType
end

function SimpleAction:getActionType()
   return self.attributes.actionType
end

function SimpleAction:setValue(value)
   self.attributes.value = value
end

function SimpleAction:getValue()
   return self.attributes.value
end

function SimpleAction:setMin(min)
   self.attributes.min = min
end

function SimpleAction:getMin()
   return self.attributes.min
end

function SimpleAction:setMax(max)
   self.attributes.max = max
end

function SimpleAction:getMax()
   return self.attributes.max
end

function SimpleAction:setQualifier(qualifier)
   self.attributes.qualifier = qualifier
end

function SimpleAction:getQualifier()
   return self.attributes.qualifier
end

function SimpleAction:setRepeat(rep)
   self.attributes["repeat"] = rep
end

function SimpleAction:getRepeat()
   return self.attributes["repeat"]
end

function SimpleAction:setRepeatDelay(repeatDelay)
   self.attributes.repeatDelay = repeatDelay
end

function SimpleAction:getRepeatDelay()
   return self.attributes.repeatDelay
end

function SimpleAction:setDuration(duration)
   self.attributes.duration = duration
end

function SimpleAction:getDuration()
   return self.attributes.duration
end

function SimpleAction:setBy(by)
   self.attributes.by = by
end

function SimpleAction:getBy()
   return self.attributes.by
end

return SimpleAction