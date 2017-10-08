local NCLElem = require "core/content/NCLElem"
local Descriptor = require "core/layout/Descriptor"

local DescriptorBase = NCLElem:extends()

DescriptorBase.name = "descriptorBase"

DescriptorBase.childrenMap = {
 ["descriptor"] = {Descriptor, "many"}
}

function DescriptorBase:create(attributes, full) 
   local descriptorBase = DescriptorBase:new()
   
   descriptorBase.attributes = { 
      ["id"] = ""
   }
   
   if(attributes ~= nil)then
      descriptorBase:setAttributes(attributes)
   end
   
   descriptorBase.children = {}    
   descriptorBase.descriptors = {}
   
   if(full ~= nil)then
      descriptorBase:addDescriptor(Descriptor:create())     
   end
   
   return descriptorBase
end

function DescriptorBase:setId(id)
   self:addAttribute("id", id)
end

function DescriptorBase:getId()
   return self:getAttribute("id")
end

function DescriptorBase:addDescriptor(descriptor)
    table.insert(self.descriptors, descriptor)    
    local p = self:getPosAvailable("descriptor")
    if(p ~= nil)then
       self:addChild(descriptor, p)
    else
       self:addChild(descriptor, 1)
    end
end

function DescriptorBase:getDescriptorPos(i)
    return self.descriptors[i]
end

function DescriptorBase:getDescriptorById(id)
   for _, descriptor in ipairs(self.descriptors) do
       if(descriptor:getId() == id)then
          return descriptor
       end
   end
   
   return nil
end

function DescriptorBase:setDescriptors(...)
    if(#arg>0)then
      for _, descriptor in ipairs(arg) do
          self:addDescriptor(descriptor)
      end
    end
end

function DescriptorBase:removeDescriptor(descriptor)
   self:removeChild(descriptor)
   
   for i, dc in ipairs(self.descriptors) do
       if(descriptor == dc)then
           table.remove(self.descriptors, i)  
       end
   end    
end

function DescriptorBase:removeDescriptorPos(i)
   self:removeChildPos(i)
   table.remove(self.descriptors, i)
end

return DescriptorBase