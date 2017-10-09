local NCLElem = require "core/NCLElem"
local ImportBase = require "core/importation/ImportBase"
local Transition = require "core/transition/Transition"

local TransitionBase = NCLElem:extends()

TransitionBase.name = "transitionBase"

TransitionBase.childrenMap = {
 ["importBase"] = {ImportBase, "many"},
 ["transition"] = {Transition, "many"}
}

function TransitionBase:create(attributes, full) 
   local transitionBase = TransitionBase:new()
   
   transitionBase.attributes = { 
      ["id"] = ""
   }
   
   if(attributes ~= nil)then
      transitionBase:setAttributes(attributes)
   end
   
   transitionBase.children = {}    
   transitionBase.importBases = {} 
   transitionBase.transitions = {}
   
   if(full ~= nil)then
      transitionBase:addImportBase(ImportBase:create())  
      transitionBase:addTransition(Transition:create())      
   end
   
   return transitionBase
end

function TransitionBase:setId(id)
   self:addAttribute("id", id)
end

function TransitionBase:getId()
   return self:getAttribute("id")
end

function TransitionBase:addImportBase(importBase)
   self:addChild(importBase)
   table.insert(self.importBases, importBase)
end

function TransitionBase:getImportBasePos(i)
    return self.importBases[i]
end

function TransitionBase:getImportBaseByAlias(alias)
   for _, importBase in ipairs(self.importBases) do
       if(importBase:getAlias() == alias)then
          return importBase
       end
   end
   
   return nil
end

function TransitionBase:setImportBases(...)
    if(#arg>0)then
      for _, importBase in ipairs(arg) do
          self:addRule(importBase)
      end
    end
end

function TransitionBase:removeImportBase(importBase)
   self:removeChild(importBase)
   
   for i, ib in ipairs(self.importBases) do
       if(importBase == ib)then
           table.remove(self.importBases, i)  
       end
   end    
end

function TransitionBase:removeImportBasePos(i)
   self:removeChildPos(i)
   table.remove(self.importBases, i)
end

function TransitionBase:addTransition(transition)
   self:addChild(transition)
   table.insert(self.transitions, transition)
end

function TransitionBase:getTransitionPos(i)
    return self.transitions[i]
end

function TransitionBase:getTransitionById(id)
   for _, transition in ipairs(self.transitions) do
       if(transition:getId() == id)then
          return transition
       end
   end
   
   return nil
end

function TransitionBase:setTransitions(...)
    if(#arg>0)then
      for _, transition in ipairs(arg) do
          self:addTransition(transition)
      end
    end
end

function TransitionBase:removeTransition(transition)
   self:removeChild(transition)
   
   for i, ts in ipairs(self.transitions) do
       if(transition == ts)then
           table.remove(self.transitions, i)  
       end
   end    
end

function TransitionBase:removeTransitionPos(i)
   self:removeChildPos(i)
   table.remove(self.transitions, i)
end

return TransitionBase