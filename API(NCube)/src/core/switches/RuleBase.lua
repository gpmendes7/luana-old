local NCLElem = require "core/NCLElem"
local ImportBase = require "core/importation/ImportBase"
local Rule = require "core/switches/Rule"
local CompositeRule = require "core/switches/CompositeRule"

local RuleBase = NCLElem:extends()

RuleBase.nameElem = "ruleBase"

RuleBase.childrenMap = {
  importBase = {ImportBase, "many"},
  rule = {Rule, "many"},
  compositeRule = {CompositeRule, "many"}
}

RuleBase.attributesTypeMap = {
  id = "string"
}

function RuleBase:create(attributes, full)
  local ruleBase = RuleBase:new()

  ruleBase.id = nil

  if(attributes ~= nil)then
    ruleBase:setAttributes(attributes)
  end

  ruleBase.children = {}
  ruleBase.importBases = {}
  ruleBase.rules = {}
  ruleBase.compositeRules = {}

  if(full ~= nil)then
    ruleBase:addImportBase(ImportBase:create())
    ruleBase:addRule(Rule:create())
    ruleBase:addCompositeRule(CompositeRule:create(nil, full))
  end

  return ruleBase
end

function RuleBase:setId(id)
  self:addAttribute("id", id)
end

function RuleBase:getId()
  return self:getAttribute("id")
end

function RuleBase:addImportBase(importBase)
  if((type(importBase) == "table"
    and importBase["getNameElem"] ~= nil
    and importBase:getNameElem() ~= "importBase")
    or type(importBase) ~= "table")then
    error("Error! Invalid importBase element!")
  end

  self:addChild(importBase)
  table.insert(self.importBases, importBase)
end

function RuleBase:getImportBasePos(p)
  if(p > #self.importBases)then
    error("Error! ruleBase element doesn't have a importBase child in position "..p.."!", 2)
  end

  return self.importBases[p]
end

function RuleBase:getImportBaseByAlias(alias)
  if(alias == nil)then
    error("Error! alias attribute of importBase element must be informed!", 2)
  end

  for _, importBase in ipairs(self.importBases) do
    if(importBase:getAlias() == alias)then
      return importBase
    end
  end

  return nil
end

function RuleBase:setImportBases(...)
  if(#arg>0)then
    for _, importBase in ipairs(arg) do
      self:addRule(importBase)
    end
  end
end

function RuleBase:removeImportBase(importBase)
  if((type(importBase) == "table"
    and importBase["getNameElem"] ~= nil
    and importBase:getNameElem() ~= "importBase")
    or type(importBase) ~= "table")then
    error("Error! Invalid importBase element!")
  end

  self:removeChild(importBase)

  for p, ib in ipairs(self.importBases) do
    if(importBase == ib)then
      table.remove(self.importBases, p)
    end
  end
end

function RuleBase:removeImportBasePos(p)
  self:removeChildPos(p)
  table.remove(self.importBases, p)
end

function RuleBase:addRule(rule)
  if((type(rule) == "table"
    and rule["getNameElem"] ~= nil
    and rule:getNameElem() ~= "rule")
    or type(rule) ~= "table")then
    error("Error! Invalid rule element!")
  end

  self:addChild(rule)
  table.insert(self.rules, rule)
end

function RuleBase:getRulePos(p)
  if(p > #self.rules)then
    error("Error! ruleBase element doesn't have a rule child in position "..p.."!", 2)
  end

  return self.rules[p]
end

function RuleBase:getRuleById(id)
  if(id == nil)then
    error("Error! id attribute of rule element must be informed!", 2)
  end

  for _, rule in ipairs(self.rules) do
    if(rule:getId() == id)then
      return rule
    end
  end

  return nil
end

function RuleBase:setRules(...)
  if(#arg>0)then
    for _, rule in ipairs(arg) do
      self:addRule(rule)
    end
  end
end

function RuleBase:removeRule(rule)
  if((type(rule) == "table"
    and rule["getNameElem"] ~= nil
    and rule:getNameElem() ~= "rule")
    or type(rule) ~= "table")then
    error("Error! Invalid rule element!")
  end

  self:removeChild(rule)

  for p, rl in ipairs(self.rules) do
    if(rule == rl)then
      table.remove(self.rules, p)
    end
  end
end

function RuleBase:removeRulePos(p)
  self:removeChildPos(p)
  table.remove(self.rules, p)
end

function RuleBase:addCompositeRule(compositeRule)
  if((type(compositeRule) == "table"
    and compositeRule["getNameElem"] ~= nil
    and compositeRule:getNameElem() ~= "compositeRule")
    or type(compositeRule) ~= "table")then
    error("Error! Invalid compositeRule element!")
  end

  self:addChild(compositeRule)
  table.insert(self.compositeRules, compositeRule)
end

function RuleBase:getCompositeRulePos(p)
  if(p > #self.compositeRules)then
    error("Error! ruleBase element doesn't have a compositeRule child in position "..p.."!", 2)
  end

  return self.compositeRules[p]
end

function RuleBase:setCompositeRules(...)
  if(#arg>0)then
    for _, compositeRule in ipairs(arg) do
      self:addCompositeRule(compositeRule)
    end
  end
end

function RuleBase:removeCompositeRule(compositeRule)
  if((type(compositeRule) == "table"
    and compositeRule["getNameElem"] ~= nil
    and compositeRule:getNameElem() ~= "compositeRule")
    or type(compositeRule) ~= "table")then
    error("Error! Invalid compositeRule element!")
  end

  self:removeChild(compositeRule)

  for p, cr in ipairs(self.compositeRules) do
    if(compositeRule == cr)then
      table.remove(self.compositeRules, p)
    end
  end
end

function RuleBase:removeCompositeRulePos(p)
  self:removeChildPos(p)
  table.remove(self.compositeRules, p)
end

return RuleBase