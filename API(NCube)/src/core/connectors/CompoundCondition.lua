local NCLElem = require "core/NCLElem"
local SimpleCondition = require "core/connectors/SimpleCondition"
local AssessmentStatement = require "core/connectors/AssessmentStatement"
local CompoundStatement = require "core/connectors/CompoundStatement"

local CompoundCondition = NCLElem:extends()

CompoundCondition.name = "compoundCondition"

CompoundCondition.childrenMap = {
 ["simpleCondition"] = {SimpleCondition, "many"},
 ["compoundCondition"] = {CompoundCondition, "many"},
 ["assessmentStatement"] = {AssessmentStatement, "many"},
 ["compoundStatement"] = {CompoundStatement, "many"}
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
   compoundCondition.assessmentStatements = {}
   compoundCondition.compoundStatements = {}
    
   if(full ~= nil)then  
      compoundCondition:addSimpleCondition(SimpleCondition:create())    
      compoundCondition:addCompoundCondition(CompoundCondition:create())
      compoundCondition:addAssessmentStatement(AssessmentStatement:create())
      compoundCondition:addCompoundStatement(CompoundStatement:create())
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
    self:addChild(simpleCondition)
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
    self:addChild(compoundCondition)
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

function CompoundCondition:addAssessmentStatement(assessmentStatement)
    table.insert(self.assessmentStatements, assessmentStatement)    
    self:addChild(assessmentStatement)
end

function CompoundCondition:getAssessmentStatementPos(i)
    return self.assessmentStatements[i]
end

function CompoundCondition:setAssessmentStatements(...)
    if(#arg>0)then
      for _, assessmentStatement in ipairs(arg) do
          self:addAssessmentStatement(assessmentStatement)
      end
    end
end

function CompoundCondition:removeAssessmentStatement(assessmentStatement)
   self:removeChild(assessmentStatement)
   
   for i, as in ipairs(self.assessmentStatements) do
       if(assessmentStatement == as)then
           table.remove(self.assessmentStatements, i)  
       end
   end 
end

function CompoundCondition:removeAssessmentStatementPos(i)
   self:removeChildPos(i)
   table.remove(self.assessmentStatements, i)
end

function CompoundCondition:addCompoundStatement(compoundStatement)
    table.insert(self.compoundStatements, compoundStatement)    
    self:addChild(compoundStatement)
end

function CompoundCondition:getCompoundStatementPos(i)
    return self.compoundStatements[i]
end

function CompoundCondition:setCompoundStatements(...)
    if(#arg>0)then
      for _, compoundStatement in ipairs(arg) do
          self:addCompoundStatement(compoundStatement)
      end
    end
end

function CompoundCondition:removeCompoundStatement(compoundStatement)
   self:removeChild(compoundStatement)
   
   for i, cs in ipairs(self.compoundStatements) do
       if(compoundStatement == cs)then
           table.remove(self.compoundStatements, i)  
       end
   end 
end

function CompoundCondition:removeCompoundStatementPos(i)
   self:removeChildPos(i)
   table.remove(self.compoundStatements, i)
end

return CompoundCondition