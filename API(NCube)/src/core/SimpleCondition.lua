local NCLElem = require "core/NCLElem"

local SimpleCondition = Class:createClass(NCLElem)

SimpleCondition.name = "simpleCondition"

SimpleCondition.attributes = {
  role = nil,
  delay = nil,
  eventType = nil,
  key = nil,
  transition = nil,
  min = nil,
  max = nil,
  qualifier = nil
}

function SimpleCondition:create(attributes)  
   local attributes = attributes or {}  
   local simpleCondition = SimpleCondition:new() 
     
   simpleCondition:setAttributes(attributes)
   simpleCondition:setChilds()
   
   return simpleCondition
end

function SimpleCondition:setRole(role)
   self.attributes.role = role
end

function SimpleCondition:getRole()
   return self.attributes.role
end

function SimpleCondition:setDelay(delay)
   self.attributes.delay = delay
end

function SimpleCondition:getDelay()
   return self.attributes.delay
end

function SimpleCondition:setDelay(delay)
   self.attributes.delay = delay
end

function SimpleCondition:getDelay()
   return self.attributes.delay
end

function SimpleCondition:setKey(key)
   self.attributes.key = key
end

function SimpleCondition:getKey()
   return self.attributes.key
end

function SimpleCondition:setTransition(transition)
   self.attributes.transition = transition
end

function SimpleCondition:getTransition()
   return self.attributes.transition
end

function SimpleCondition:setMin(min)
   self.attributes.min = min
end

function SimpleCondition:getMin()
   return self.attributes.min
end

function SimpleCondition:setMax(max)
   self.attributes.max = max
end

function SimpleCondition:getMax()
   return self.attributes.max
end

function SimpleCondition:setQualifier(qualifier)
   self.attributes.qualifier = qualifier
end

function SimpleCondition:getQualifier()
   return self.attributes.qualifier
end

return SimpleCondition