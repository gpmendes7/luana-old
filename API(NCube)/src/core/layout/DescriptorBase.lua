local NCLElem = require "core/structure_content/NCLElem"
local Descriptor = require "core/layout/Descriptor"

local DescriptorBase = NCLElem:extends()

DescriptorBase.name = "descriptorBase"

DescriptorBase.attributes = { 
  id = nil
}

DescriptorBase.childsMap = {
 ["descriptor"] = {Descriptor, "many"}
}

DescriptorBase.descriptors = nil

function DescriptorBase:create(attributes, full)
   local attributes = attributes or {}  
   local descriptorBase = DescriptorBase:new()
   
   descriptorBase:setAttributes(attributes)
   descriptorBase:setChilds()    
   descriptorBase.descriptors = {}
   
   if(full ~= nil)then
      descriptorBase:addDescriptor(Descriptor:create())     
   end
   
   return descriptorBase
end

function DescriptorBase:setId(id)
   self.attributes.id = id
end

function DescriptorBase:getId()
   return self.attributes.id
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

function DescriptorBase:getDescriptor(i)
    return self.descriptors[i]
end

function DescriptorBase:getDescriptorById(id)
   for i, descriptor in ipairs(self.descriptors) do
       if(descriptor:getId() == id)then
          return descriptor
       end
   end
   
   return nil
end

function DescriptorBase:setDescriptors(...)
    if(#arg>0)then
      for i, v in ipairs(arg) do
          self:addDescriptor(v)
      end
    end
end

function DescriptorBase:removeDescriptor(descriptor)
   self:removeChild(descriptor)
end

function DescriptorBase:removeDescriptorPos(i)
   self:removeChild(self.descriptors[i])
end

return DescriptorBase