local NCLElem = require "core/content/NCLElem"

local Rule = NCLElem:extends()

Rule.name = "rule"

function Rule:create(attributes)
   local rule = Rule:new()
   
   rule.attributes = { 
    ["id"] = "",  
    ["var"] = "", 
    ["comparator"] = "", 
    ["value"] = ""
   }
   
   if(attributes ~= nil)then
      rule:setAttributes(attributes)
   end
   
   return rule
end

function Rule:setId(id)
    self:addAttribute("id", id)
end

function Rule:getId()
   return self:getAttribute("id")
end

function Rule:setVar(var)
    self:addAttribute("var", var)
end

function Rule:getVar()
   return self:getAttribute("var")
end

function Rule:setComparator(comparator)
    self:addAttribute("comparator", comparator)
end

function Rule:getComparator()
   return self:getAttribute("comparator")
end

function Rule:setValue(value)
    self:addAttribute("value", value)
end

function Rule:getValue()
   return self:getAttribute("value")
end

return Rule