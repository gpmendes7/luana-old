local NCLElem = require "core/content/NCLElem"
local Rule = require "core/switches/Rule"
local CompositeRule = require "core/switches/CompositeRule"

local RuleBase = NCLElem:extends()

RuleBase.name = "ruleBase"

RuleBase.childrenMap = {
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
   ruleBase.rules = {}
   ruleBase.compositeRules = {}
   
   if(full ~= nil)then
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

function RuleBase:addRule(rule)
    table.insert(self.rules, rule)    
    local p = self:getPosAvailable("rule", "compositeRule")
    if(p ~= nil)then
       self:addChild(rule, p)
    else
       self:addChild(rule, 1)
    end
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
   
   for i, dc in ipairs(self.rules) do
       if(rule == dc)then
           table.remove(self.rules, i)  
       end
   end    
end

function RuleBase:removeRulePos(i)
   self:removeChildPos(i)
   table.remove(self.rules, i)
end

function RuleBase:addCompositeRule(compositeRule)
    table.insert(self.compositeRules, compositeRule)    
    local p = self:getPosAvailable("compositeRule", "rule")
    if(p ~= nil)then
       self:addChild(compositeRule, p)
    else
       self:addChild(compositeRule, 1)
    end
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
   
   for i, ca in ipairs(self.compositeRules) do
       if(compositeRule == ca)then
           table.remove(self.compositeRules, i)  
       end
   end 
end

function RuleBase:removeCompositeRulePos(i)
   self:removeChildPos(i)
   table.remove(self.compositeRules, i)
end

return RuleBase