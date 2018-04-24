local NCLElem = require "core/NCLElem"

local ValueAssessment = NCLElem:extends()

ValueAssessment.nameElem = "valueAssessment"

ValueAssessment.attributesTypeMap = {
  value = "string"
}

function ValueAssessment:create(attributes)
  local valueAssessment = ValueAssessment:new()

  valueAssessment.value = nil

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
