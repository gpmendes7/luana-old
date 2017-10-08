local NCLElem = require "core/NCLElem"

local BindRule = NCLElem:extends()

BindRule.name = "bindRule"

function BindRule:create(attributes)
   local bindRule = BindRule:new()
   
   bindRule.attributes = { 
    ["constituent"] = "",
    ["rule"] = ""
   }
   
   if(attributes ~= nil)then
      bindRule:setAttributes(attributes)
   end
   
   return bindRule
end

function BindRule:setConstituent(constituent)
    self:addAttribute("constituent", constituent)
end

function BindRule:getConstituent()
   return self:getAttribute("constituent")
end

function BindRule:setRule(rule)
    self:addAttribute("rule", rule)
end

function BindRule:getRule()
   return self:getAttribute("rule")
end

return BindRule