local NCLElem = require "core/NCLElem"

local Rule = NCLElem:extends()

Rule.name = "rule"

Rule.attributesTypeMap = {
  id = "string",
  var = "string",
  comparator = "string",
  value = "string"
}

Rule.attributesStringValueMap = {
  comparator = {"eq", "ne", "gt", "lt", "gte", "lte"}
}

function Rule:create(attributes)
  local rule = Rule:new()

  rule.id = nil
  rule.var = nil
  rule.comparator = nil
  rule.value = nil

  if(attributes ~= nil)then
    rule:setAttributes(attributes)
  end

  return rule
end

function Rule:setId(id)
  self:addAttribute("id", id)
end

function Rule:getId()
  return self:getAttribute("id")
end

function Rule:setVar(var)
  self:addAttribute("var", var)
end

function Rule:getVar()
  return self:getAttribute("var")
end

function Rule:setComparator(comparator)
  self:addAttribute("comparator", comparator)
end

function Rule:getComparator()
  return self:getAttribute("comparator")
end

function Rule:setValue(value)
  self:addAttribute("value", value)
end

function Rule:getValue()
  return self:getAttribute("value")
end

return Rule