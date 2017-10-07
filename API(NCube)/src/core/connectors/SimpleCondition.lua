local NCLElem = require "core/structure_content/NCLElem"

local SimpleCondition = NCLElem:extends()

SimpleCondition.name = "simpleCondition"

function SimpleCondition:create(attributes)   
   local simpleCondition = SimpleCondition:new() 
   
   simpleCondition.attributes = {
      ["role"] = "",
      ["delay"] = "",
      ["eventType"] = "",
      ["key"] = "",
      ["transition"] = "",
      ["min"] = "",
      ["max"] = "",
      ["qualifier"] = ""
   }
   
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