local NCLElem = require "core/NCLElem"
local Rule = require "core/switches/Rule"

local CompositeRule = NCLElem:extends()

CompositeRule.nameElem = "compositeRule"

CompositeRule.childrenMap = {
  rule = {Rule, "many"},
  compositeRule = {CompositeRule, "many"}
}

CompositeRule.attributesTypeMap = {
  id = "string",
  operator = "string"
}

CompositeRule.attributesStringValueMap = {
  operator = {"and", "or"}
}

function CompositeRule:create(attributes, full)
  local compositeRule = CompositeRule:new()

  compositeRule.id = nil
  compositeRule.operator = nil

  if(attributes ~= nil)then
    compositeRule:setAttributes(attributes)
  end

  compositeRule.children = {}
  compositeRule.rules = {}
  compositeRule.compositeRules = {}

  if(full ~= nil)then
    compositeRule:addRule(Rule:create())
    compositeRule:addCompositeRule(CompositeRule:create())
  end

  return compositeRule
end

function CompositeRule:setId(id)
  self:addAttribute("id", id)
end

function CompositeRule:getId()
  return self:getAttribute("id")
end

function CompositeRule:setOperator(operator)
  self:addAttribute("operator", operator)
end

function CompositeRule:getOperator()
  return self:getAttribute("operator")
end

function CompositeRule:addRule(rule)
  table.insert(self.rules, rule)
  local p = self:getPosAvailable("rule", "compositeRule")
  if(p ~= nil)then
    self:addChild(rule, p)
  else
    self:addChild(rule, 1)
  end
end

function CompositeRule:getRulePos(p)
  if(p > #self.rules)then
    error("Error! compositeRule element doesn't have a rule child in position "..p.."!", 2)
  end

  return self.rules[p]
end

function CompositeRule:setRules(...)
  if(#arg>0)then
    for _, rule in ipairs(arg) do
      self:addRule(rule)
    end
  end
end

function CompositeRule:removeRule(rule)
  self:removeChild(rule)

  for p, sa in ipairs(self.rules) do
    if(rule == sa)then
      table.remove(self.rules, p)
    end
  end
end

function CompositeRule:removeRulePos(p)
  self:removeChildPos(p)
  table.remove(self.rules, p)
end

function CompositeRule:addCompositeRule(compositeRule)
  table.insert(self.compositeRules, compositeRule)
  local p = self:getPosAvailable("compositeRule", "rule")
  if(p ~= nil)then
    self:addChild(compositeRule, p)
  else
    self:addChild(compositeRule, 1)
  end
end

function CompositeRule:getCompositeRulePos(p)
  if(p > #self.compositeRules)then
    error("Error! compositeRule element doesn't have a compositeRule child in position "..p.."!", 2)
  end

  return self.compositeRules[p]
end

function CompositeRule:setCompositeRules(...)
  if(#arg>0)then
    for _, compositeRule in ipairs(arg) do
      self:addCompositeRule(compositeRule)
    end
  end
end

function CompositeRule:removeCompositeRule(compositeRule)
  self:removeChild(compositeRule)

  for p, ca in ipairs(self.compositeRules) do
    if(compositeRule == ca)then
      table.remove(self.compositeRules, p)
    end
  end
end

function CompositeRule:removeCompositeRulePos(p)
  self:removeChildPos(p)
  table.remove(self.compositeRules, p)
end

return CompositeRule