local NCLElem = require "core/NCLElem"

local AttributeAssessment = NCLElem:extends()

AttributeAssessment.name = "attributeAssessment"

function AttributeAssessment:create(attributes)
   local attributeAssessment = AttributeAssessment:new()
   
   attributeAssessment.attributes = { 
    ["role"] = "",
    ["eventType"] = "",
    ["key"] = "",
    ["attributeType"] = "",
    ["offset"] = ""
   }
   
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