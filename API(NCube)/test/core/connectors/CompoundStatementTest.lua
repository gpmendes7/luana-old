local CompoundStatement = require "core/connectors/CompoundStatement"
local AssessmentStatement = require "core/connectors/AssessmentStatement"

local function test1()
   local compoundStatement = nil
   
   compoundStatement = CompoundStatement:create()
   assert(compoundStatement ~= nil, "Error!")
   assert(compoundStatement:getOperator() == "", "Error!") 
   assert(compoundStatement:getIsNegated() == "", "Error!")   
end

local function test2()
   local compoundStatement = nil
   
   local atts = {
      ["operator"] = "and",
      ["isNegated"] = "true"
   }     
   
   compoundStatement = CompoundStatement:create(atts)
   assert(compoundStatement ~= nil, "Error!")
   assert(compoundStatement:getOperator() == "and", "Error!") 
   assert(compoundStatement:getIsNegated() == "true", "Error!") 
end

local function test3()
   local compoundStatement = nil
      
   compoundStatement = CompoundStatement:create()
   
   compoundStatement:setOperator("and") 
   compoundStatement:setIsNegated("true") 
   
   assert(compoundStatement ~= nil, "Error!")
   assert(compoundStatement:getOperator() == "and", "Error!") 
   assert(compoundStatement:getIsNegated() == "true", "Error!") 
end

local function test4()
   local compoundStatement = nil
      
   compoundStatement = CompoundStatement:create(nil, 1)
   assert(compoundStatement:getAssessmentStatementPos(1) ~= nil, "Error!")
   
   compoundStatement:addAssessmentStatement(AssessmentStatement:create())
   assert(compoundStatement:getAssessmentStatementPos(2) ~= nil, "Error!")
   
   compoundStatement = CompoundStatement:create(nil, 1)
   compoundStatement:addAssessmentStatement(AssessmentStatement:create{["comparator"] = "eq"})
   assert(compoundStatement:getDescendantByAttribute("comparator", "eq") ~= nil, "Error!")

   compoundStatement = CompoundStatement:create(nil, 1)
   compoundStatement:addCompoundStatement(CompoundStatement:create())
   assert(compoundStatement:getCompoundStatementPos(1) ~= nil, "Error!") 

   compoundStatement:addCompoundStatement(CompoundStatement:create{["operator"] = "and"})
   assert(compoundStatement:getDescendantByAttribute("operator", "and") ~= nil, "Error!") 
end

local function test5()
   local compoundStatement1 = CompoundStatement:create{["operator"] = "and"}
   local assessmentStatement = AssessmentStatement:create{["comparator"] = "eq"}
   local compoundStatement2 = CompoundStatement:create{["operator"] = "or"}
 
   compoundStatement1:addAssessmentStatement(assessmentStatement)
   assert(compoundStatement1:getDescendantByAttribute("comparator", "eq") ~= nil, "Error!") 
    
   compoundStatement1:removeAssessmentStatement(assessmentStatement)
   assert(compoundStatement1:getDescendantByAttribute("comparator", "eq") == nil, "Error!") 
   
   compoundStatement1:addAssessmentStatement(assessmentStatement)
   compoundStatement1:removeAssessmentStatementPos(1)
   assert(compoundStatement1:getDescendantByAttribute("comparator", "eq") == nil, "Error!") 
   
   compoundStatement1:addCompoundStatement(compoundStatement2)
   assert(compoundStatement1:getDescendantByAttribute("operator", "or") ~= nil, "Error!")
   
   compoundStatement1:removeCompoundStatement(compoundStatement2)
   assert(compoundStatement1:getDescendantByAttribute("operator", "or") == nil, "Error!") 
   
   compoundStatement1:addCompoundStatement(compoundStatement2)
   compoundStatement1:removeCompoundStatementPos(1)
   assert(compoundStatement1:getDescendantByAttribute("operator", "or") == nil, "Error!") 
end

local function test6()
   local compoundStatement = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
      ["operator"] = "and",
      ["isNegated"] = "true"
   }    
      
   compoundStatement = CompoundStatement:create(atts)
   
   nclExp = "<compoundStatement"   
   for attribute, value in pairs(compoundStatement:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
  
   nclExp = nclExp.."/>\n"
print(nclExp)
   nclRet = compoundStatement:table2Ncl(0)
print(nclRet)
   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()