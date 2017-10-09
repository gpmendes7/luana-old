local NCLElem = require "core/NCLElem"
local DefaultDescriptor = require "core/switches/DefaultDescriptor"
local BindRule = require "core/switches/BindRule"
local Descriptor = require "core/layout/Descriptor"

local DescriptorSwitch = NCLElem:extends()

DescriptorSwitch.name = "descriptorSwitch"

DescriptorSwitch.childrenMap = {
 ["defaultDescriptor"] = {DefaultDescriptor, "one"},
 ["bindRule"] = {BindRule, "many"},
 ["descriptor"] = {Descriptor, "many"}
}

function DescriptorSwitch:create(attributes, full)  
   local descriptorSwitch = DescriptorSwitch:new() 
   
   descriptorSwitch.attributes = {
      ["id"] = ""
   }  
   
   if(attributes ~= nil)then
      descriptorSwitch:setAttributes(attributes)
   end
     
   descriptorSwitch.children = {}
   descriptorSwitch.defaultDescriptor = {} 
   descriptorSwitch.bindRules = {}
   descriptorSwitch.descriptors = {}
    
   if(full ~= nil)then    
      descriptorSwitch:setDefaultDescriptor(DefaultDescriptor:create())    
      descriptorSwitch:addBindRule(BindRule:create(nil, full))   
      descriptorSwitch:addDescriptor(Descriptor:create(nil, full))           
   end
   
   return descriptorSwitch
end

function DescriptorSwitch:setId(id)
   self:addAttribute("id", id)
end

function DescriptorSwitch:getId()
   return self:getAttribute("id")
end

function DescriptorSwitch:setDefaultDescriptor(defaultDescriptor)   
   self:addChild(defaultDescriptor, 1)
   self.defaultDescriptor = defaultDescriptor       
end

function DescriptorSwitch:getDefaultDescriptor()
   return self.defaultDescriptor
end

function DescriptorSwitch:removeDefaultDescriptor()
   self:removeChild(self.defaultDescriptor)
   self.defaultDescriptor = nil
end

function DescriptorSwitch:addBindRule(bindRule)
   self:addChild(bindRule)
   table.insert(self.bindRules, bindRule)
end

function DescriptorSwitch:getBindRulePos(i)
    return self.bindRules[i]
end

function DescriptorSwitch:getBindRuleById(id)
   for _, bindRule in ipairs(self.bindRules) do
       if(bindRule:getId() == id)then
          return bindRule
       end
   end
   
   return nil
end

function DescriptorSwitch:setBindRules(...)
    if(#arg>0)then
      for _, bindRule in ipairs(arg) do
          self:addBindRule(bindRule)
      end
    end
end

function DescriptorSwitch:removeBindRule(bindRule)
   self:removeChild(bindRule)
   
   for i, cc in ipairs(self.bindRules) do
       if(bindRule == cc)then
           table.remove(self.bindRules, i)  
       end
   end 
end

function DescriptorSwitch:removeBindRulePos(i)
   self:removeChildPos(i)
   table.remove(self.bindRules, i)
end

function DescriptorSwitch:addDescriptor(descriptor)
   self:addChild(descriptor)
   table.insert(self.descriptors, descriptor)
end

function DescriptorSwitch:getDescriptorPos(i)
    return self.descriptors[i]
end

function DescriptorSwitch:getDescriptorById(id)
   for _, descriptor in ipairs(self.descriptors) do
       if(descriptor:getId() == id)then
          return descriptor
       end
   end
   
   return nil
end

function DescriptorSwitch:setDescriptors(...)
    if(#arg>0)then
      for _, descriptor in ipairs(arg) do
          self:addDescriptor(descriptor)
      end
    end
end

function DescriptorSwitch:removeDescriptor(descriptor)
   self:removeChild(descriptor)
   
   for i, dc in ipairs(self.descriptors) do
       if(descriptor == dc)then
           table.remove(self.descriptors, i)  
       end
   end    
end

function DescriptorSwitch:removeDescriptorPos(i)
   self:removeChildPos(i)
   table.remove(self.descriptors, i)
end

return DescriptorSwitch