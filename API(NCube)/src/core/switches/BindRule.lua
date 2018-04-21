local NCLElem = require "core/NCLElem"

local BindRule = NCLElem:extends()

BindRule.name = "bindRule"

BindRule.attributesTypeMap = {
  constituent = "string",
  rule = "string"
}

function BindRule:create(attributes)
  local bindRule = BindRule:new()

  bindRule.constituent = nil
  bindRule.rule = nil

  bindRule.constituentAss = nil
  bindRule.ruleAss = nil

  if(attributes ~= nil)then
    bindRule:setAttributes(attributes)
  end

  return bindRule
end

function BindRule:setConstituent(constituent)
  if(type(constituent) == "table")then
    if(constituent.getId ~= nil)then
      self:addAttribute("constituent", constituent:getId())
    end

    self.constituentAss = constituent
    table.insert(constituent.ass, self)
  else
    self:addAttribute("constituent", constituent)
  end
end

function BindRule:getConstituent()
  return self:getAttribute("constituent")
end

function BindRule:setRule(rule)
  if(type(rule) == "table")then
    if(rule.getId ~= nil)then
      self:addAttribute("rule", rule:getId())
    end

    self.ruleAss = rule
    table.insert(rule.ass, self)
  else
    self:addAttribute("rule", rule)
  end
end

function BindRule:getRule()
  return self:getAttribute("rule")
end

return BindRule
