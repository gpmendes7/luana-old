local NCLElem = require "core/structure_content/NCLElem"
local SimpleAction = require "core/connectors/SimpleAction"

local CompoundAction = NCLElem:extends()

CompoundAction.name = "compoundAction"

CompoundAction.childrenMap = {
 ["simpleAction"] = {SimpleAction, "many"},
 ["compoundAction"] = {CompoundAction, "many"}
}

function CompoundAction:create(attributes, full)   
   local compoundAction = CompoundAction:new()  
   
   compoundAction.attributes = {
      ["operator"] = "",
      ["delay"] = ""
   }
       
   if(attributes ~= nil)then
      compoundAction:setAttributes(attributes)
   end
   
   compoundAction.children = {}
   compoundAction.simpleActions = {}
   compoundAction.compoundActions = {}
   
   if(full ~= nil)then      
      compoundAction:addCompoundAction(CompoundAction:create())
      compoundAction:addSimpleAction(SimpleAction:create())
   end
   
   return compoundAction
end

function CompoundAction:setOperator(operator)
   self:addAttribute("operator", operator)
end

function CompoundAction:getOperator()
   return self:getAttribute("operator")
end

function CompoundAction:setDelay(delay)
   self:addAttribute("delay", delay)
end

function CompoundAction:getDelay()
   return self:getAttribute("delay")
end

function CompoundAction:addSimpleAction(simpleAction)
    table.insert(self.simpleActions, simpleAction)    
    local p = self:getPosAvailable("simpleAction", "compoundAction")
    if(p ~= nil)then
       self:addChild(simpleAction, p)
    else
       self:addChild(simpleAction, 1)
    end
end

function CompoundAction:getSimpleActionPos(i)
    return self.simpleActions[i]
end

function CompoundAction:setSimpleActions(...)
    if(#arg>0)then
      for _, simpleAction in ipairs(arg) do
          self:addSimpleAction(simpleAction)
      end
    end
end

function CompoundAction:removeSimpleAction(simpleAction)
   self:removeChild(simpleAction)
   
   for i, sa in ipairs(self.simpleActions) do
       if(simpleAction == sa)then
           table.remove(self.simpleActions, i)  
       end
   end 
end

function CompoundAction:removeSimpleActionPos(i)
   self:removeChildPos(i)
   table.remove(self.simpleActions, i)
end

function CompoundAction:addCompoundAction(compoundAction)
    table.insert(self.compoundActions, compoundAction)    
    local p = self:getPosAvailable("compoundAction", "simpleAction")
    if(p ~= nil)then
       self:addChild(compoundAction, p)
    else
       self:addChild(compoundAction, 1)
    end
end

function CompoundAction:getCompoundActionPos(i)
    return self.compoundActions[i]
end

function CompoundAction:setCompoundActions(...)
    if(#arg>0)then
      for _, compoundAction in ipairs(arg) do
          self:addCompoundAction(compoundAction)
      end
    end
end

function CompoundAction:removeCompoundAction(compoundAction)
   self:removeChild(compoundAction)
   
   for i, ca in ipairs(self.compoundActions) do
       if(compoundAction == ca)then
           table.remove(self.compoundActions, i)  
       end
   end 
end

function CompoundAction:removeCompoundActionPos(i)
   self:removeChildPos(i)
   table.remove(self.compoundActions, i)
end

return CompoundAction