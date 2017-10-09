local NCLElem = require "core/NCLElem"
local ImportBase = require "core/importation/ImportBase"
local Rule = require "core/switches/Rule"
local CompositeRule = require "core/switches/CompositeRule"

local RuleBase = NCLElem:extends()

RuleBase.name = "ruleBase"

RuleBase.childrenMap = {
 ["importBase"] = {ImportBase, "many"},
 ["rule"] = {Rule, "many"},
 ["compositeRule"] = {CompositeRule, "many"}
}

function RuleBase:create(attributes, full) 
   local ruleBase = RuleBase:new()
   
   ruleBase.attributes = { 
      ["id"] = ""
   }
   
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
   self:addChild(importBase)
   table.insert(self.importBases, importBase)
end

function RuleBase:getImportBasePos(i)
    return self.importBases[i]
end

function RuleBase:getImportBaseByAlias(alias)
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
   self:removeChild(importBase)
   
   for i, ib in ipairs(self.importBases) do
       if(importBase == ib)then
           table.remove(self.importBases, i)  
       end
   end    
end

function RuleBase:removeImportBasePos(i)
   self:removeChildPos(i)
   table.remove(self.importBases, i)
end

function RuleBase:addRule(rule)
   self:addChild(rule)
   table.insert(self.rules, rule)
end

function RuleBase:getRulePos(i)
    return self.rules[i]
end

function RuleBase:getRuleById(id)
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
   self:removeChild(rule)
   
   for i, rl in ipairs(self.rules) do
       if(rule == rl)then
           table.remove(self.rules, i)  
       end
   end    
end

function RuleBase:removeRulePos(i)
   self:removeChildPos(i)
   table.remove(self.rules, i)
end

function RuleBase:addCompositeRule(compositeRule)
   self:addChild(compositeRule)
   table.insert(self.compositeRules, compositeRule)
end

function RuleBase:getCompositeRulePos(i)
    return self.compositeRules[i]
end

function RuleBase:setCompositeRules(...)
    if(#arg>0)then
      for _, compositeRule in ipairs(arg) do
          self:addCompositeRule(compositeRule)
      end
    end
end

function RuleBase:removeCompositeRule(compositeRule)
   self:removeChild(compositeRule)
   
   for i, cr in ipairs(self.compositeRules) do
       if(compositeRule == cr)then
           table.remove(self.compositeRules, i)  
       end
   end 
end

function RuleBase:removeCompositeRulePos(i)
   self:removeChildPos(i)
   table.remove(self.compositeRules, i)
end

return RuleBase