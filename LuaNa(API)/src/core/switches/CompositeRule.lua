local NCLElem = require "../../src/core/NCLElem"
local Rule = require "../../src/core/switches/Rule"

---
-- Implements CompositeRule Class representing <b>&lt;compositeRule&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=compositerule">
-- http://handbook.ncl.org.br/doku.php?id=compositerule</a>
-- 
-- @module CompositeRule
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local CompositeRule = require "core/switches/CompositeRule" 
local CompositeRule = NCLElem:extends()

---
-- Name of <b>&lt;compositeRule&gt;</b> element.
-- 
-- @field [parent=#CompositeRule] #string nameElem 
CompositeRule.nameElem = "compositeRule"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;compositeRule&gt;</b> element.
-- 
-- @field [parent=#CompositeRule] #table childrenMap
CompositeRule.childrenMap = {
  rule = {Rule, "many"},
  compositeRule = {CompositeRule, "many"}
}

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;compositeRule&gt;</b> element.
-- 
-- @field [parent=#CompositeRule] #table attributesTypeMap  
CompositeRule.attributesTypeMap = {
  id = "string",
  operator = "string"
}

---
-- List containing all possible pre-definied values to string attributes
-- belonging to <b>&lt;compositeRule&gt;</b> element.
-- 
-- @field [parent=#CompositeRule] #table attributesStringValueMap
CompositeRule.attributesStringValueMap = {
  operator = {"and", "or"}
}

---
-- Returns a new CompositeRule object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#CompositeRule] create
-- @param #table attributes list of attributes to be initialized.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #CompositeRule new CompositeRule object created.
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
  
  compositeRule.ass = {}

  return compositeRule
end

---
-- Sets a value to `id` attribute of the 
-- <b>&lt;compositeRule&gt;</b> element. 
-- 
-- @function [parent=#CompositeRule] setId
-- @param #string id `id` attribute of the
-- <b>&lt;compositeRule&gt;</b> element.
function CompositeRule:setId(id)
  self:addAttribute("id", id)
end

---
-- Returns the value of the `id` attribute of the 
-- <b>&lt;compositeRule&gt;</b> element. 
-- 
-- @function [parent=#CompositeRule] getId
-- @return #string `id` attribute of the <b>&lt;compositeRule&gt;</b> element.
function CompositeRule:getId()
  return self:getAttribute("id")
end

---
-- Sets a value to `operator` attribute of the 
-- <b>&lt;compositeRule&gt;</b> element. 
-- 
-- @function [parent=#CompositeRule] setOperator
-- @param #string operator `operator` attribute of the
-- <b>&lt;compositeRule&gt;</b> element.
function CompositeRule:setOperator(operator)
  self:addAttribute("operator", operator)
end

---
-- Returns the value of the `operator` attribute of the 
-- <b>&lt;compositeRule&gt;</b> element. 
-- 
-- @function [parent=#CompositeRule] getOperator
-- @return #string `operator` attribute of the <b>&lt;compositeRule&gt;</b> element.
function CompositeRule:getOperator()
  return self:getAttribute("operator")
end

---
-- Adds a <b>&lt;rule&gt;</b> child element of the 
-- <b>&lt;compositeRule&gt;</b> element. 
-- 
-- @function [parent=#CompositeRule] addRule
-- @param #Rule rule object representing the 
-- <b>&lt;rule&gt;</b> element.
function CompositeRule:addRule(rule)
  if((type(rule) == "table"
    and rule["getNameElem"] ~= nil
    and rule:getNameElem() ~= "rule")
    or (type(rule) == "table"
    and rule["getNameElem"] == nil)
    or type(rule) ~= "table")then
    error("Error! Invalid rule element!", 2)
  end

  local p = self:getPosAvailable("rule", "compositeRule")

  if(p ~= nil)then
    self:addChild(rule, p)
  else
    self:addChild(rule, 1)
  end

  table.insert(self.rules, rule)
end

---
-- Returns a <b>&lt;rule&gt;</b> child element of the 
-- <b>&lt;compositeRule&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#CompositeRule] getRulePos
-- @param #number p position of the object representing the <b>&lt;rule&gt;</b> element.
function CompositeRule:getRulePos(p)
  if(self.rules == nil)then
    error("Error! compositeRule element with nil rules list!", 2)
  elseif(p > #self.rules)then
    error("Error! compositeRule element doesn't have a rule child in position "..p.."!", 2)
  end

  return self.rules[p]
end

---
-- Adds so many <b>&lt;rule&gt;</b> child elements of the <b>&lt;compositeRule&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#CompositeRule] setRules
-- @param #Rule ... objects representing the <b>&lt;rule&gt;</b> element.
function CompositeRule:setRules(...)
  if(#arg>0)then
    for _, rule in ipairs(arg) do
      self:addRule(rule)
    end
  end
end

---
-- Removes a <b>&lt;rule&gt;</b> child element of the 
-- <b>&lt;compositeRule&gt;</b> element. 
-- 
-- @function [parent=#CompositeRule] removeRule
-- @param #Rule rule object representing the <b>&lt;rule&gt;</b> element.
function CompositeRule:removeRule(rule)
  if((type(rule) == "table"
    and rule["getNameElem"] ~= nil
    and rule:getNameElem() ~= "rule")
    or (type(rule) == "table"
    and rule["getNameElem"] == nil)
    or type(rule) ~= "table")then
    error("Error! Invalid rule element!", 2)
  elseif(self.children == nil)then
    error("Error! compositeRule element with nil children list!", 2)
  elseif(self.rules == nil)then
    error("Error! compositeRule element with nil rules list!", 2)
  end

  self:removeChild(rule)

  for p, sa in ipairs(self.rules) do
    if(rule == sa)then
      table.remove(self.rules, p)
    end
  end
end

---
-- Removes a <b>&lt;rule&gt;</b> child element of the 
-- <b>&lt;compositeRule&gt;</b> element in position `p`.
-- 
-- @function [parent=#CompositeRule] removeRulePos
-- @param #number p position of the <b>&lt;rule&gt;</b> child element.
function CompositeRule:removeRulePos(p)
  if(self.children == nil)then
    error("Error! compositeRule element with nil children list!", 2)
  elseif(self.rules == nil)then
    error("Error! compositeRule element with nil rules list!", 2)
  elseif(p > #self.children)then
    error("Error! compositeRule element doesn't have a rule child in position "..p.."!", 2)
  elseif(p > #self.rules)then
    error("Error! compositeRule element doesn't have a rule child in position "..p.."!", 2)
  end

  self:removeChild(self.rules[p])
  table.remove(self.rules, p)
end

---
-- Adds a <b>&lt;compositeRule&gt;</b> child element of the 
-- <b>&lt;compositeRule&gt;</b> element. 
-- 
-- @function [parent=#CompositeRule] addCompositeRule
-- @param #CompositeRule compositeRule object representing the 
-- <b>&lt;compositeRule&gt;</b> element.
function CompositeRule:addCompositeRule(compositeRule)
  if((type(compositeRule) == "table"
    and compositeRule["getNameElem"] ~= nil
    and compositeRule:getNameElem() ~= "compositeRule")
    or (type(compositeRule) == "table"
    and compositeRule["getNameElem"] == nil)
    or type(compositeRule) ~= "table")then
    error("Error! Invalid compositeRule element!", 2)
  end

  local p = self:getPosAvailable("compositeRule", "rule")

  if(p ~= nil)then
    self:addChild(compositeRule, p)
  else
    self:addChild(compositeRule, 1)
  end

  table.insert(self.compositeRules, compositeRule)
end

---
-- Returns a <b>&lt;compositeRule&gt;</b> child element of the 
-- <b>&lt;compositeRule&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#CompositeRule] getCompositeRulePos
-- @param #number p position of the object representing the <b>&lt;compositeRule&gt;</b> element.
function CompositeRule:getCompositeRulePos(p)
  if(self.compositeRules == nil)then
    error("Error! compositeRule element with nil compositeRules list!", 2)
  elseif(p > #self.compositeRules)then
    error("Error! compositeRule element doesn't have a compositeRule child in position "..p.."!", 2)
  end

  return self.compositeRules[p]
end

---
-- Adds so many <b>&lt;compositeRule&gt;</b> child elements of the <b>&lt;compositeRule&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#CompositeRule] setCompositeRules
-- @param #CompositeRule ... objects representing the <b>&lt;compositeRule&gt;</b> element.
function CompositeRule:setCompositeRules(...)
  if(#arg>0)then
    for _, compositeRule in ipairs(arg) do
      self:addCompositeRule(compositeRule)
    end
  end
end

---
-- Removes a <b>&lt;compositeRule&gt;</b> child element of the 
-- <b>&lt;compositeRule&gt;</b> element. 
-- 
-- @function [parent=#CompositeRule] removeCompositeRule
-- @param #CompositeRule compositeRule object representing the <b>&lt;compositeRule&gt;</b> element.
function CompositeRule:removeCompositeRule(compositeRule)
  if((type(compositeRule) == "table"
    and compositeRule["getNameElem"] ~= nil
    and compositeRule:getNameElem() ~= "compositeRule")
    or (type(compositeRule) == "table"
    and compositeRule["getNameElem"] == nil)
    or type(compositeRule) ~= "table")then
    error("Error! Invalid compositeRule element!", 2)
  elseif(self.children == nil)then
    error("Error! compositeRule element with nil children list!", 2)
  elseif(self.compositeRules == nil)then
    error("Error! compositeRule element with nil compositeRules list!", 2)
  end

  self:removeChild(compositeRule)

  for p, ca in ipairs(self.compositeRules) do
    if(compositeRule == ca)then
      table.remove(self.compositeRules, p)
    end
  end
end

---
-- Removes a <b>&lt;compositeRule&gt;</b> child element of the 
-- <b>&lt;compositeRule&gt;</b> element in position `p`.
-- 
-- @function [parent=#CompositeRule] removeCompositeRulePos
-- @param #number p position of the <b>&lt;compositeRule&gt;</b> child element.
function CompositeRule:removeCompositeRulePos(p)
  if(self.children == nil)then
    error("Error! compositeRule element with nil children list!", 2)
  elseif(self.compositeRules == nil)then
    error("Error! compositeRule element with nil compositeRules list!", 2)
  elseif(p > #self.children)then
    error("Error! compositeRule element doesn't have a compositeRule child in position "..p.."!", 2)
  elseif(p > #self.compositeRules)then
    error("Error! compositeRule element doesn't have a compositeRule child in position "..p.."!", 2)
  end

  self:removeChild(self.compositeRules[p])
  table.remove(self.compositeRules, p)
end

return CompositeRule