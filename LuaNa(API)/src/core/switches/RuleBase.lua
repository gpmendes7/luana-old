local NCLElem = require "../../src/core/NCLElem"
local ImportBase = require "../../src/core/importation/ImportBase"
local Rule = require "../../src/core/switches/Rule"
local CompositeRule = require "../../src/core/switches/CompositeRule"

---
-- Implements RuleBase Class representing <b>&lt;ruleBase&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=ruleBase">
-- http://handbook.ncl.org.br/doku.php?id=ruleBase</a>
-- 
-- @module RuleBase
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local RuleBase = require "core/switches/RuleBase" 
local RuleBase = NCLElem:extends()

---
-- Name of <b>&lt;ruleBase&gt;</b> element.
-- 
-- @field [parent=#RuleBase] #string nameElem
RuleBase.nameElem = "ruleBase"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;ruleBase&gt;</b> element.
-- 
-- @field [parent=#RuleBase] #table childrenMap
RuleBase.childrenMap = {
  importBase = {ImportBase, "many"},
  rule = {Rule, "many"},
  compositeRule = {CompositeRule, "many"}
}

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;ruleBase&gt;</b> element.
-- 
-- @field [parent=#RuleBase] #table attributesTypeMap  
RuleBase.attributesTypeMap = {
  id = "string"
}

---
-- Returns a new RuleBase object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#RuleBase] create
-- @param #table attributes list of attributes to be initialized.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #RuleBase new RuleBase object created.
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

---
-- Sets a value to `id` attribute of the 
-- <b>&lt;ruleBase&gt;</b> element. 
-- 
-- @function [parent=#RuleBase] setId
-- @param #string id `id` attribute of the
-- <b>&lt;ruleBase&gt;</b> element.
function RuleBase:setId(id)
  self:addAttribute("id", id)
end

---
-- Returns the value of the `id` attribute of the 
-- <b>&lt;ruleBase&gt;</b> element. 
-- 
-- @function [parent=#RuleBase] getId
-- @return #string `id` attribute of the <b>&lt;ruleBase&gt;</b> element.
function RuleBase:getId()
  return self:getAttribute("id")
end

---
-- Adds a <b>&lt;importBase&gt;</b> child element of the 
-- <b>&lt;ruleBase&gt;</b> element. 
-- 
-- @function [parent=#RuleBase] addImportBase
-- @param #ImportBase importBase object representing the 
-- <b>&lt;importBase&gt;</b> element.
function RuleBase:addImportBase(importBase)
  if((type(importBase) == "table"
    and importBase["getNameElem"] ~= nil
    and importBase:getNameElem() ~= "importBase")
    or (type(importBase) == "table"
    and importBase["getNameElem"] == nil)
    or type(importBase) ~= "table")then
    error("Error! Invalid importBase element!", 2)
  end

  self:addChild(importBase)
  table.insert(self.importBases, importBase)
end

---
-- Returns a <b>&lt;importBase&gt;</b> child element of the 
-- <b>&lt;ruleBase&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#RuleBase] getImportBasePos
-- @param #number p position of the object representing the <b>&lt;importBase&gt;</b> element.
function RuleBase:getImportBasePos(p)
  if(self.importBases == nil)then
    error("Error! ruleBase element with nil importBases list!", 2)
  elseif(p > #self.importBases)then
    error("Error! ruleBase element doesn't have a importBase child in position "..p.."!", 2)
  end

  return self.importBases[p]
end

---
-- Returns a <b>&lt;importBase&gt;</b> child element of the 
-- <b>&lt;ruleBase&gt;</b> element
-- by `alias` attribute.
--  
-- @function [parent=#RuleBase] getImportBaseByAlias
-- @param #string alias `alias` attribute of the <b>&lt;importBase&gt;</b> element.
function RuleBase:getImportBaseByAlias(alias)
  if(alias == nil)then
    error("Error! alias attribute of importBase element must be informed!", 2)
  elseif(self.importBases == nil)then
    error("Error! ruleBase element with nil importBases list!", 2)
  end

  for _, importBase in ipairs(self.importBases) do
    if(importBase:getAlias() == alias)then
      return importBase
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;importBase&gt;</b> child elements of the <b>&lt;ruleBase&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#RuleBase] setImportBases
-- @param #ImportBase ... objects representing the <b>&lt;importBase&gt;</b> element.
function RuleBase:setImportBases(...)
  if(#arg>0)then
    for _, importBase in ipairs(arg) do
      self:addRule(importBase)
    end
  end
end

---
-- Removes a <b>&lt;importBase&gt;</b> child element of the 
-- <b>&lt;ruleBase&gt;</b> element. 
-- 
-- @function [parent=#RuleBase] removeImportBase
-- @param #ImportBase importBase object representing the <b>&lt;importBase&gt;</b> element.
function RuleBase:removeImportBase(importBase)
  if((type(importBase) == "table"
    and importBase["getNameElem"] ~= nil
    and importBase:getNameElem() ~= "importBase")
    or (type(importBase) == "table"
    and importBase["getNameElem"] == nil)
    or type(importBase) ~= "table")then
    error("Error! Invalid importBase element!", 2)
  elseif(self.children == nil)then
    error("Error! ruleBase element with nil children list!", 2)
  elseif(self.importBases == nil)then
    error("Error! ruleBase element with nil importBases list!", 2)
  end

  self:removeChild(importBase)

  for p, ib in ipairs(self.importBases) do
    if(importBase == ib)then
      table.remove(self.importBases, p)
    end
  end
end

---
-- Removes a <b>&lt;importBase&gt;</b> child element of the 
-- <b>&lt;ruleBase&gt;</b> element in position `p`.
-- 
-- @function [parent=#RuleBase] removeImportBasePos
-- @param #number p position of the <b>&lt;importBase&gt;</b> child element.
function RuleBase:removeImportBasePos(p)
  if(self.children == nil)then
    error("Error! ruleBase element with nil children list!", 2)
  elseif(self.importBases == nil)then
    error("Error! ruleBase element with nil importBases list!", 2)
  elseif(p > #self.children)then
    error("Error! ruleBase element doesn't have a importBase child in position "..p.."!", 2)
  elseif(p > #self.importBases)then
    error("Error! ruleBase element doesn't have a importBase child in position "..p.."!", 2)
  end

  self:removeChild(self.importBases[p])
  table.remove(self.importBases, p)
end

---
-- Adds a <b>&lt;rule&gt;</b> child element of the 
-- <b>&lt;ruleBase&gt;</b> element. 
-- 
-- @function [parent=#RuleBase] addRule
-- @param #Rule rule object representing the 
-- <b>&lt;rule&gt;</b> element.
function RuleBase:addRule(rule)
  if((type(rule) == "table"
    and rule["getNameElem"] ~= nil
    and rule:getNameElem() ~= "rule")
    or (type(rule) == "table"
    and rule["getNameElem"] == nil)
    or type(rule) ~= "table")then
    error("Error! Invalid rule element!", 2)
  end

  self:addChild(rule)
  table.insert(self.rules, rule)
end

---
-- Returns a <b>&lt;rule&gt;</b> child element of the 
-- <b>&lt;ruleBase&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#RuleBase] getRulePos
-- @param #number p position of the object representing the <b>&lt;rule&gt;</b> element.
function RuleBase:getRulePos(p)
  if(self.rules == nil)then
    error("Error! ruleBase element with nil rules list!", 2)
  elseif(p > #self.rules)then
    error("Error! ruleBase element doesn't have a rule child in position "..p.."!", 2)
  end

  return self.rules[p]
end

---
-- Returns a <b>&lt;rule&gt;</b> child element of the 
-- <b>&lt;ruleBase&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#RuleBase] getRuleById
-- @param #string id `id` attribute of the <b>&lt;rule&gt;</b> element.
function RuleBase:getRuleById(id)
  if(id == nil)then
    error("Error! id attribute of rule element must be informed!", 2)
  elseif(self.rules == nil)then
    error("Error! ruleBase element with nil rules list!", 2)
  end

  for _, rule in ipairs(self.rules) do
    if(rule:getId() == id)then
      return rule
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;rule&gt;</b> child elements of the <b>&lt;ruleBase&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#RuleBase] setRules
-- @param #Rule ... objects representing the <b>&lt;rule&gt;</b> element.
function RuleBase:setRules(...)
  if(#arg>0)then
    for _, rule in ipairs(arg) do
      self:addRule(rule)
    end
  end
end

---
-- Removes a <b>&lt;rule&gt;</b> child element of the 
-- <b>&lt;ruleBase&gt;</b> element. 
-- 
-- @function [parent=#RuleBase] removeRule
-- @param #Rule rule object representing the <b>&lt;rule&gt;</b> element.
function RuleBase:removeRule(rule)
  if((type(rule) == "table"
    and rule["getNameElem"] ~= nil
    and rule:getNameElem() ~= "rule")
    or (type(rule) == "table"
    and rule["getNameElem"] == nil)
    or type(rule) ~= "table")then
    error("Error! Invalid rule element!", 2)
  elseif(self.children == nil)then
    error("Error! ruleBase element with nil children list!", 2)
  elseif(self.rules == nil)then
    error("Error! ruleBase element with nil rules list!", 2)
  end

  self:removeChild(rule)

  for p, rl in ipairs(self.rules) do
    if(rule == rl)then
      table.remove(self.rules, p)
    end
  end
end

---
-- Removes a <b>&lt;rule&gt;</b> child element of the 
-- <b>&lt;ruleBase&gt;</b> element in position `p`.
-- 
-- @function [parent=#RuleBase] removeRulePos
-- @param #number p position of the <b>&lt;rule&gt;</b> child element.
function RuleBase:removeRulePos(p)
  if(self.children == nil)then
    error("Error! ruleBase element with nil children list!", 2)
  elseif(self.rules == nil)then
    error("Error! ruleBase element with nil rules list!", 2)
  elseif(p > #self.children)then
    error("Error! ruleBase element doesn't have a rule child in position "..p.."!", 2)
  elseif(p > #self.rules)then
    error("Error! ruleBase element doesn't have a rule child in position "..p.."!", 2)
  end

  self:removeChild(self.rules[p])
  table.remove(self.rules, p)
end

---
-- Adds a <b>&lt;compositeRule&gt;</b> child element of the 
-- <b>&lt;ruleBase&gt;</b> element. 
-- 
-- @function [parent=#RuleBase] addCompositeRule
-- @param #CompositeRule compositeRule object representing the 
-- <b>&lt;compositeRule&gt;</b> element.
function RuleBase:addCompositeRule(compositeRule)
  if((type(compositeRule) == "table"
    and compositeRule["getNameElem"] ~= nil
    and compositeRule:getNameElem() ~= "compositeRule")
    or (type(compositeRule) == "table"
    and compositeRule["getNameElem"] == nil)
    or type(compositeRule) ~= "table")then
    error("Error! Invalid compositeRule element!", 2)
  end

  self:addChild(compositeRule)
  table.insert(self.compositeRules, compositeRule)
end

---
-- Returns a <b>&lt;compositeRule&gt;</b> child element of the 
-- <b>&lt;ruleBase&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#RuleBase] getCompositeRulePos
-- @param #number p position of the object representing the <b>&lt;compositeRule&gt;</b> element.
function RuleBase:getCompositeRulePos(p)
  if(self.compositeRules == nil)then
    error("Error! ruleBase element with nil compositeRules list!", 2)
  elseif(p > #self.compositeRules)then
    error("Error! ruleBase element doesn't have a compositeRule child in position "..p.."!", 2)
  end

  return self.compositeRules[p]
end

---
-- Adds so many <b>&lt;compositeRule&gt;</b> child elements of the <b>&lt;ruleBase&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#RuleBase] setCompositeRules
-- @param #CompositeRule ... objects representing the <b>&lt;compositeRule&gt;</b> element.
function RuleBase:setCompositeRules(...)
  if(#arg>0)then
    for _, compositeRule in ipairs(arg) do
      self:addCompositeRule(compositeRule)
    end
  end
end

---
-- Removes a <b>&lt;compositeRule&gt;</b> child element of the 
-- <b>&lt;ruleBase&gt;</b> element. 
-- 
-- @function [parent=#RuleBase] removeCompositeRule
-- @param #CompositeRule compositeRule object representing the <b>&lt;compositeRule&gt;</b> element.
function RuleBase:removeCompositeRule(compositeRule)
  if((type(compositeRule) == "table"
    and compositeRule["getNameElem"] ~= nil
    and compositeRule:getNameElem() ~= "compositeRule")
    or (type(compositeRule) == "table"
    and compositeRule["getNameElem"] == nil)
    or type(compositeRule) ~= "table")then
    error("Error! Invalid compositeRule element!", 2)
  elseif(self.children == nil)then
    error("Error! ruleBase element with nil children list!", 2)
  elseif(self.compositeRules == nil)then
    error("Error! ruleBase element with nil compositeRules list!", 2)
  end

  self:removeChild(compositeRule)

  for p, cr in ipairs(self.compositeRules) do
    if(compositeRule == cr)then
      table.remove(self.compositeRules, p)
    end
  end
end

---
-- Removes a <b>&lt;compositeRule&gt;</b> child element of the 
-- <b>&lt;ruleBase&gt;</b> element in position `p`.
-- 
-- @function [parent=#RuleBase] removeCompositeRulePos
-- @param #number p position of the <b>&lt;compositeRule&gt;</b> child element.
function RuleBase:removeCompositeRulePos(p)
  if(self.children == nil)then
    error("Error! ruleBase element with nil children list!", 2)
  elseif(self.compositeRules == nil)then
    error("Error! ruleBase element with nil compositeRules list!", 2)
  elseif(p > #self.children)then
    error("Error! ruleBase element doesn't have a compositeRule child in position "..p.."!", 2)
  elseif(p > #self.compositeRules)then
    error("Error! ruleBase element doesn't have a compositeRule child in position "..p.."!", 2)
  end

  self:removeChild(self.compositeRules[p])
  table.remove(self.compositeRules, p)
end

return RuleBase