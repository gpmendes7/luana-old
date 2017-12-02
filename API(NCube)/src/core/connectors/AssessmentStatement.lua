local NCLElem = require "core/NCLElem"
local AttributeAssessment = require "core/connectors/AttributeAssessment"
local ValueAssessment = require "core/connectors/ValueAssessment"

local AssessmentStatement = NCLElem:extends()

AssessmentStatement.name = "assessmentStatement"

AssessmentStatement.childrenMap = {
 ["attributeAssessment"] = {AttributeAssessment, "many"}, 
 ["valueAssessment"] = {ValueAssessment, "one"}
}

function AssessmentStatement:create(attributes, full)
   local assessmentStatement = AssessmentStatement:new()
   
   assessmentStatement.attributes = {
      ["comparator"] = ""
   }     
   
   if(attributes ~= nil)then
      assessmentStatement:setAttributes(attributes)
   end 
   
   assessmentStatement.children = {}
   assessmentStatement.attributeAssessments = {}
   
   if(full ~= nil)then   
      assessmentStatement:addAttributeAssessment(AttributeAssessment:create())
      assessmentStatement:setValueAssessment(ValueAssessment:create())
   end
   
   return assessmentStatement
end

function AssessmentStatement:setComparator(comparator)
   self:addAttribute("comparator", comparator)
end

function AssessmentStatement:getComparator()
   return self:getAttribute("comparator")
end

function AssessmentStatement:addAttributeAssessment(attributeAssessment)            
   table.insert(self.attributeAssessments, attributeAssessment) 
   local p = self:getPosAvailable("attributeAssessment")
   
   if(p ~= nil)then
      self:addChild(attributeAssessment, p)
   else
      self:addChild(attributeAssessment, 1)
   end   
end

function AssessmentStatement:getAttributeAssessmentPos(i)
   return self.attributeAssessments[i]
end

function AssessmentStatement:setAttributeAssessments(...)
    if(#arg>0)then
      for _, attributeAssessment in ipairs(arg) do
         self:addAttributeAssessment(attributeAssessment)
      end
    end
end

function AssessmentStatement:removeAttributeAssessment(attributeAssessment)
   self:removeChild(attributeAssessment)
   
   for i, aa in ipairs(self.attributeAssessments) do
       if(attributeAssessment == aa)then
           table.remove(self.attributeAssessments, i)  
       end
   end 
end

function AssessmentStatement:removeAttributeAssessmentPos(i)
   self:removeChildPos(i)
   table.remove(self.attributeAssessments, i)
end

function AssessmentStatement:setValueAssessment(valueAssessment)   
   local p = nil 
   
   if(self.valueAssessment == nil)then
      p = self:getPosAvailable("attributeAssessment")          
      if(p ~= nil)then
         self:addChild(valueAssessment, p)
       else
         self:addChild(valueAssessment, 1)
      end    
   else
       p = self:getPosAvailable("valueAssessment") - 1
       self:removeChildPos(p)
       self:addChild(valueAssessment, p)
   end
   
   self.valueAssessment = valueAssessment
end

function AssessmentStatement:getValueAssessment()
   return self.valueAssessment
end

function AssessmentStatement:removeValueAssessment()
   self:removeChild(self.valueAssessment)
   self.valueAssessment = nil
end

return AssessmentStatement