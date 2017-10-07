local NCLElem = require "core/structure_content/NCLElem"

local SimpleAction = NCLElem:extends()

SimpleAction.name = "simpleAction"

function SimpleAction:create(attributes)  
   local simpleAction = SimpleAction:new() 
   
   simpleAction.attributes = {
      ["role"] = "",
      ["delay"] = "",
      ["eventType"] = "",
      ["actionType"] = "",
      ["value"] = "",
      ["min"] = "",
      ["max"] = "",
      ["qualifier"] = "",
      ["repeat"] = "",
      ["repeatDelay"] = "",
      ["duration"] = "",
      ["by"] = ""
   }
   
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

function SimpleAction:setDelay(delay)
   self:addAttribute("delay", delay)
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

function SimpleAction:setRepeatDelay(repeatDelay)
   self:addAttribute("repeatDelay", repeatDelay)
end

function SimpleAction:getRepeatDelay()
   return self:getAttribute("repeatDelay")
end

function SimpleAction:setDuration(duration)
   self:addAttribute("duration", duration)
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