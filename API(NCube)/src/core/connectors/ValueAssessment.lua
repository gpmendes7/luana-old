local NCLElem = require "core/NCLElem"

local ValueAssessment = NCLElem:extends()

ValueAssessment.name = "valueAssessment"

function ValueAssessment:create(attributes)
   local valueAssessment = ValueAssessment:new()
   
   valueAssessment.attributes = { 
    ["value"] = ""
   }
   
   if(attributes ~= nil)then
      valueAssessment:setAttributes(attributes)
   end
   
   return valueAssessment
end

function ValueAssessment:setValue(value)
    self:addAttribute("value", value)
end

function ValueAssessment:getValue()
   return self:getAttribute("value")
end

return ValueAssessment