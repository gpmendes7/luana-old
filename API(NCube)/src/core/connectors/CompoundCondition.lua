local NCLElem = require "core/structure_content/NCLElem"
local SimpleCondition = require "core/connectors/SimpleCondition"

local CompoundCondition = NCLElem:extends()

CompoundCondition.name = "compoundCondition"

CompoundCondition.childrenMap = {
 ["simpleCondition"] = {SimpleCondition, "many"},
 ["compoundCondition"] = {CompoundCondition, "many"}
}

function CompoundCondition:create(attributes, full)  
   local compoundCondition = CompoundCondition:new() 
   
   compoundCondition.attributes = {
     ["operator"] = "",
     ["delay"] = ""
   }
   
   if(attributes ~= nil)then
      compoundCondition:setAttributes(attributes)
   end
   
   compoundCondition.children = {}
   compoundCondition.simpleConditions = {}
   compoundCondition.compoundConditions = {}
    
   if(full ~= nil)then      
      compoundCondition:addCompoundCondition(CompoundCondition:create())
      compoundCondition:addSimpleCondition(SimpleCondition:create())
   end
   
   return compoundCondition
end

function CompoundCondition:setOperator(operator)
   self:addAttribute("operator", operator)
end

function CompoundCondition:getOperator()
   return self:getAttribute("operator")
end

function CompoundCondition:setDelay(delay)
   self:addAttribute("delay", delay)
end

function CompoundCondition:getDelay()
   return self:getAttribute("delay")
end

function CompoundCondition:addSimpleCondition(simpleCondition)
    table.insert(self.simpleConditions, simpleCondition)    
    local p = self:getPosAvailable("simpleCondition", "compoundCondition")
    if(p ~= nil)then
       self:addChild(simpleCondition, p)
    else
       self:addChild(simpleCondition, 1)
    end
end

function CompoundCondition:getSimpleConditionPos(i)
    return self.simpleConditions[i]
end

function CompoundCondition:setSimpleConditions(...)
    if(#arg>0)then
      for i, simpleCondition in ipairs(arg) do
          self:addSimpleCondition(simpleCondition)
      end
    end
end

function CompoundCondition:removeSimpleCondition(simpleCondition)
   self:removeChild(simpleCondition)
   
   for i, sc in ipairs(self.simpleConditions) do
       if(simpleCondition == sc)then
           table.remove(self.simpleConditions, i)  
       end
   end 
end

function CompoundCondition:removeSimpleConditionPos(i)
   self:removeChildPos(i)
   table.remove(self.simpleConditions, i)
end

function CompoundCondition:addCompoundCondition(compoundCondition)
    table.insert(self.compoundConditions, compoundCondition)    
    local p = self:getPosAvailable("compoundCondition", "simpleCondition")
    if(p ~= nil)then
       self:addChild(compoundCondition, p)
    else
       self:addChild(compoundCondition, 1)
    end
end

function CompoundCondition:getCompoundConditionPos(i)
    return self.compoundConditions[i]
end

function CompoundCondition:setCompoundConditions(...)
    if(#arg>0)then
      for i, compoundCondition in ipairs(arg) do
          self:addCompoundCondition(compoundCondition)
      end
    end
end

function CompoundCondition:removeCompoundCondition(compoundCondition)
   self:removeChild(compoundCondition)
   
   for i, cc in ipairs(self.compoundConditions) do
       if(compoundCondition == cc)then
           table.remove(self.compoundConditions, i)  
       end
   end 
end

function CompoundCondition:removeCompoundConditionPos(i)
   self:removeChildPos(i)
   table.remove(self.compoundConditions, i)
end

return CompoundCondition