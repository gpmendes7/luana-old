local NCLElem = require "core/NCLElem"

local CompoundAction = Class:createClass(NCLElem)

CompoundAction.name = "compoundAction"

CompoundAction.attributes = {
  operator = nil,
  delay = nil
}

local SimpleAction = require "core/SimpleAction"

CompoundAction.childsMap = {
 ["simpleAction"] = {SimpleAction, "many", 1},
 ["compoundAction"] = {CompoundAction, "many", 2}
}

CompoundAction.simpleActions = nil
CompoundAction.compoundActions = nil

function CompoundAction:create(attributes, full)  
   local attributes = attributes or {}  
   local CompoundAction = CompoundAction:new() 
     
   CompoundAction:setAttributes(attributes)
   CompoundAction:setChilds()
   
   if(full ~= nil)then      
      CompoundAction.simpleActions = {}
      CompoundAction:addChild({} , 1)
      
      CompoundAction.compoundActions = {}
      CompoundAction:addChild({} , 2)
   end
   
   return CompoundAction
end

function CompoundAction:setOperator(operator)
   self.attributes.operator = operator
end

function CompoundAction:getOperator()
   return self.attributes.operator
end

function CompoundAction:setDelay(delay)
   self.attributes.delay = delay
end

function CompoundAction:getDelay()
   return self.attributes.delay
end

function CompoundAction:addSimpleAction(simpleAction)
    table.insert(self.simpleActions, simpleAction)
    table.insert(self:getChild(1), simpleAction)
end

function CompoundAction:getSimpleAction(i)
    return self.simpleActions[i]
end

function CompoundAction:setSimpleActions(...)
    if(#arg>0)then
      for i, v in ipairs(arg) do
          self:addSimpleAction(v)
      end
    end
end

function CompoundAction:addCompoundAction(compoundAction)
    table.insert(self.compoundActions, compoundAction)
    table.insert(self:getChild(1), compoundAction)
end

function CompoundAction:getCompoundAction(i)
    return self.compoundActions[i]
end

function CompoundAction:setCompoundActions(...)
    if(#arg>0)then
      for i, v in ipairs(arg) do
          self:addCompoundAction(v)
      end
    end
end

return CompoundAction