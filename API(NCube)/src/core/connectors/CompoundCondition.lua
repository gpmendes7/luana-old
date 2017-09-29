local NCLElem = require "core/structure_content/NCLElem"
local SimpleCondition = require "core/connectors/SimpleCondition"

local CompoundCondition = NCLElem:extends()

CompoundCondition.name = "compoundCondition"

CompoundCondition.attributes = {
  operator = nil,
  delay = nil
}

CompoundCondition.childsMap = {
 ["simpleCondition"] = {SimpleCondition, "many", 1},
 ["compoundCondition"] = {CompoundCondition, "many", 2}
}

CompoundCondition.simpleConditions = nil
CompoundCondition.compoundConditions = nil

function CompoundCondition:create(attributes, full)  
   local attributes = attributes or {}  
   local compoundCondition = CompoundCondition:new() 
     
   compoundCondition:setAttributes(attributes)
   compoundCondition:setChilds()
   
   if(full ~= nil)then      
      compoundCondition.simpleConditions = {}
      compoundCondition:addChild({} , 1)
      
      compoundCondition.compoundConditions = {}
      compoundCondition:addChild({} , 2)
   end
   
   return compoundCondition
end

function CompoundCondition:setOperator(operator)
   self.attributes.operator = operator
end

function CompoundCondition:getOperator()
   return self.attributes.operator
end

function CompoundCondition:setDelay(delay)
   self.attributes.delay = delay
end

function CompoundCondition:getDelay()
   return self.attributes.delay
end

function CompoundCondition:addSimpleCondition(simpleCondition)
    table.insert(self.simpleConditions, simpleCondition)
    table.insert(self:getChild(1), simpleCondition)
end

function CompoundCondition:getSimpleCondition(i)
    return self.simpleConditions[i]
end

function CompoundCondition:setSimpleConditions(...)
    if(#arg>0)then
      for i, v in ipairs(arg) do
          self:addSimpleCondition(v)
      end
    end
end

function CompoundCondition:addCompoundCondition(compoundCondition)
    table.insert(self.compoundConditions, compoundCondition)
    table.insert(self:getChild(2), compoundCondition)
end

function CompoundCondition:getCompoundCondition(i)
    return self.compoundConditions[i]
end

function CompoundCondition:setCompoundConditions(...)
    if(#arg>0)then
      for i, v in ipairs(arg) do
          self:addCompoundCondition(v)
      end
    end
end

return CompoundCondition