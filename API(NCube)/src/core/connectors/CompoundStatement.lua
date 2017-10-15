local NCLElem = require "core/NCLElem"
local AssessmentStatement = require "core/connectors/AssessmentStatement"

local CompoundStatement = NCLElem:extends()

CompoundStatement.name = "compoundStatement"

CompoundStatement.childrenMap = {
 ["assessmentStatement"] = {AssessmentStatement, "many"},
 ["compoundStatement"] = {CompoundStatement, "many"}
}

function CompoundStatement:create(attributes, full)   
   local compoundStatement = CompoundStatement:new()  
   
   compoundStatement.attributes = {
      ["operator"] = "",
      ["isNegated"] = ""
   }
       
   if(attributes ~= nil)then
      compoundStatement:setAttributes(attributes)
   end
   
   compoundStatement.children = {}
   compoundStatement.assessmentStatements = {}
   compoundStatement.compoundStatements = {}
   
   if(full ~= nil)then      
      compoundStatement:addAssessmentStatement(AssessmentStatement:create())
      compoundStatement:addCompoundStatement(CompoundStatement:create())
   end
   
   return compoundStatement
end

function CompoundStatement:setOperator(operator)
   self:addAttribute("operator", operator)
end

function CompoundStatement:getOperator()
   return self:getAttribute("operator")
end

function CompoundStatement:setIsNegated(isNegated)
   self:addAttribute("isNegated", isNegated)
end

function CompoundStatement:getIsNegated()
   return self:getAttribute("isNegated")
end

function CompoundStatement:addAssessmentStatement(assessmentStatement)
    table.insert(self.assessmentStatements, assessmentStatement)    
    local p = self:getPosAvailable("assessmentStatement", "compoundStatement")
    if(p ~= nil)then
       self:addChild(assessmentStatement, p)
    else
       self:addChild(assessmentStatement, 1)
    end
end

function CompoundStatement:getAssessmentStatementPos(i)
    return self.assessmentStatements[i]
end

function CompoundStatement:setAssessmentStatements(...)
    if(#arg>0)then
      for _, assessmentStatement in ipairs(arg) do
          self:addAssessmentStatement(assessmentStatement)
      end
    end
end

function CompoundStatement:removeAssessmentStatement(assessmentStatement)
   self:removeChild(assessmentStatement)
   
   for i, as in ipairs(self.assessmentStatements) do
       if(assessmentStatement == as)then
           table.remove(self.assessmentStatements, i)  
       end
   end 
end

function CompoundStatement:removeAssessmentStatementPos(i)
   self:removeChildPos(i)
   table.remove(self.assessmentStatements, i)
end

function CompoundStatement:addCompoundStatement(compoundStatement)
    table.insert(self.compoundStatements, compoundStatement)    
    local p = self:getPosAvailable("compoundStatement", "assessmentStatement")
    if(p ~= nil)then
       self:addChild(compoundStatement, p)
    else
       self:addChild(compoundStatement, 1)
    end
end

function CompoundStatement:getCompoundStatementPos(i)
    return self.compoundStatements[i]
end

function CompoundStatement:setCompoundStatements(...)
    if(#arg>0)then
      for _, compoundStatement in ipairs(arg) do
          self:addCompoundStatement(compoundStatement)
      end
    end
end

function CompoundStatement:removeCompoundStatement(compoundStatement)
   self:removeChild(compoundStatement)
   
   for i, cs in ipairs(self.compoundStatements) do
       if(compoundStatement == cs)then
           table.remove(self.compoundStatements, i)  
       end
   end 
end

function CompoundStatement:removeCompoundStatementPos(i)
   self:removeChildPos(i)
   table.remove(self.compoundStatements, i)
end

return CompoundStatement