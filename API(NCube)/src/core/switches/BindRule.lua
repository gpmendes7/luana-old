local NCLElem = require "core/NCLElem"

local BindRule = NCLElem:extends()

BindRule.nameElem = "bindRule"

BindRule.attributesTypeMap = {
  constituent = "string",
  rule = "string"
}

BindRule.assMap = {
  {"constituent", "constituentAss"},
  {"rule", "ruleAss"}
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
    if(constituent["getId"] ~= nil)then
      self:addAttribute("constituent", constituent:getId())
    else
      error("Error! Invalid constituent element!", 2)
    end

    self.constituentAss = constituent
    table.insert(constituent.ass, self)
  elseif(type(constituent) == "string" )then
    self:addAttribute("constituent", constituent)
  else
    error("Error! Invalid constituent element!", 2)
  end
end

function BindRule:getConstituent()
  return self:getAttribute("constituent")
end

function BindRule:setRule(rule)
  if(type(rule) == "table")then
    if(rule["getId"] ~= nil)then
      self:addAttribute("rule", rule:getId())
    else
      error("Error! Invalid rule element!", 2)
    end

    self.ruleAss = rule
    table.insert(rule.ass, self)
  elseif(type(rule) == "string" )then
    self:addAttribute("rule", rule)
  else
    error("Error! Invalid rule element!", 2)
  end
end

function BindRule:getRule()
  return self:getAttribute("rule")
end

return BindRule