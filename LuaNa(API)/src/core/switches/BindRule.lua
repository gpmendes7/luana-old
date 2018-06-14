local NCLElem = require "core/NCLElem"

---
-- Implements BindRule Class representing <b>&lt;bindRule&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=bindrule">
-- http://handbook.ncl.org.br/doku.php?id=bindrule</a>
-- 
-- @module BindRule
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local BindRule = require "core/switches/BindRule" 
local BindRule = NCLElem:extends()

---
-- Name of <b>&lt;bindRule&gt;</b> element.
-- 
-- @field [parent=#BindRule] #string nameElem
BindRule.nameElem = "bindRule"

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;bindRule&gt;</b> element.
-- 
-- @field [parent=#BindRule] #table attributesTypeMap 
BindRule.attributesTypeMap = {
  constituent = "string",
  rule = "string"
}

---
-- List with associative map that connects an attribute to an specific object
-- representing a child NCL element of <b>&lt;bindRule&gt;</b> element.
-- 
-- @field [parent=#BindRule] #table assMap
BindRule.assMap = {
  {"constituent", "constituentAss"},
  {"rule", "ruleAss"}
}

---
-- Returns a new BindRule object. 
-- 
-- @function [parent=#BindRule] create
-- @param #table attributes list of attributes to be initialized.
-- @return #BindRule new BindRule object created.
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

---
-- Sets a value to `constituent` attribute of the 
-- <b>&lt;bindRule&gt;</b> element. 
-- 
-- @function [parent=#BindRule] setConstituent
-- @param #stringOrobject constituent `constituent` atribute of the
-- <b>&lt;bindRule&gt;</b> element.
function BindRule:setConstituent(constituent)
  if(type(constituent) == "table")then
     if(constituent["getNameElem"] ~= nil
      and constituent:getNameElem() ~= "switch"
      and constituent:getNameElem() ~= "context"
      and constituent:getNameElem() ~= "media"
      and constituent:getNameElem() ~= "descriptor")then
      error("Error! Invalid constituent element!", 2)
    elseif(constituent:getId() ~= nil)then
      self:addAttribute("constituent", constituent:getId())
      self.constituentAss = constituent
      table.insert(constituent.ass, self)
    else
      error("Error! Constituent element with nil id attribute!", 2)
    end
  elseif(type(constituent) == "string" )then
    self:addAttribute("constituent", constituent)
  else
    error("Error! Invalid constituent element!", 2)
  end
end

---
-- Returns the value of the `constituent` attribute of the 
-- <b>&lt;bindRule&gt;</b> element. 
-- 
-- @function [parent=#BindRule] getConstituent
-- @return #string `constituent` atribute of the <b>&lt;bindRule&gt;</b> element.
function BindRule:getConstituent()
  return self:getAttribute("constituent")
end

---
-- Returns the constituent associated to
-- <b>&lt;bindRule&gt;</b> element. 
-- 
-- @function [parent=#BindRule] getConstituentAss
-- @return #object constituent associated to <b>&lt;bindRule&gt;</b> element.
function BindRule:getConstituentAss()
  return self.constituentAss
end

---
-- Sets a value to `rule` attribute of the 
-- <b>&lt;bindRule&gt;</b> element. 
-- 
-- @function [parent=#BindRule] setRule
-- @param #stringOrobject rule `rule` atribute of the
-- <b>&lt;bindRule&gt;</b> element.
function BindRule:setRule(rule)
  if(type(rule) == "table")then
    if(rule["getNameElem"] ~= nil
      and rule:getNameElem() ~= "rule"
      and rule:getNameElem() ~= "compositeRule")then
      error("Error! Invalid rule element!", 2)
    elseif(rule:getId() ~= nil)then
      self:addAttribute("rule", rule:getId())
      self.ruleAss = rule
      table.insert(rule.ass, self)
    else
      error("Error! Rule element with nil id attribute!", 2)
    end
  elseif(type(rule) == "string" )then
    self:addAttribute("rule", rule)
  else
    error("Error! Invalid rule element!", 2)
  end
end

---
-- Returns the value of the `rule` attribute of the 
-- <b>&lt;bindRule&gt;</b> element. 
-- 
-- @function [parent=#BindRule] getRule
-- @return #string `rule` atribute of the <b>&lt;bindRule&gt;</b> element.
function BindRule:getRule()
  return self:getAttribute("rule")
end

---
-- Returns the rule associated to
-- <b>&lt;bindRule&gt;</b> element. 
-- 
-- @function [parent=#BindRule] getRuleAss
-- @return #object rule associated to <b>&lt;bindRule&gt;</b> element.
function BindRule:getRuleAss()
  return self.ruleAss
end

return BindRule