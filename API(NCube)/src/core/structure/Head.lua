local NCLElem = require "core/NCLElem"
local RegionBase = require "core/adaptation/RegionBase"
local DescriptorBase = require "core/adaptation/DescriptorBase"
local ConnectorBase = require "core/synchronism/ConnectorBase"

local Head = NCLElem:extends()

Head.name = "head"

Head.childsMap = {
 ["regionBase"] = {RegionBase, "many", 1}, 
 ["descriptorBase"] = {DescriptorBase, "one", 2},
 ["connectorBase"] = {ConnectorBase, "many", 3}
}

Head.regionBases = nil
Head.descriptorBase = nil
Head.connectorBases = nil

function Head:create(full)
   local head = Head:new()     
    
   head:setChilds()   
   head.regionBases = {}
   head.connectorBases = {}
   
   if(full ~= nil)then            
      head:addRegionBase(RegionBase:create(nil, full))            
      head:setDescriptorBase(DescriptorBase:create(nil, full))      
      head:addConnectorBase(ConnectorBase:create(nil, full))
   end
   
   return head
end

function Head:addRegionBase(regionBase)
    table.insert(self.regionBases, regionBase)    
    local p = self:getPosAvailable("regionBase")
    if(p ~= nil)then
       self:addChild(regionBase, p)
    else
       self:addChild(regionBase, 1)
    end
end

function Head:getRegionBase(i)
    return self.regionBases[i]
end

function Head:getRegionBaseById(id)
   for i, regionBase in ipairs(self.regionBases) do
       if(regionBase:getId() == id)then
          return regionBase
       end
   end
   
   return nil
end

function Head:setRegionBases(...)
    if(#arg>0)then
      for i, v in ipairs(arg) do
          self:addRegionBase(v)
      end
    end
end

function Head:removeRegionBase(regionBase)
   self:removeChild(regionBase)
end

function Head:removeRegionBasePos(i)
   self:removeChild(self.regionBases[i])
end

function Head:setDescriptorBase(descriptorBase)
   local p = nil 
   
   if(self.descriptorBase == nil)then
      p = self:getPosAvailable("regionBase")          
      if(p ~= nil)then
         self:addChild(descriptorBase, p)
       else
         self:addChild(descriptorBase, 1)
      end    
   else
       p = self:getPosAvailable("descriptorBase") - 1
       self:removeChild(p)
       self:addChild(descriptorBase, p)
   end
   
    self.descriptorBase = descriptorBase        
end

function Head:getDescriptorBase()
   return self.descriptorBase
end

function Head:removeDescriptorBase()
   self:removeChild(self.descriptorBase)
   self.descriptorBase = nil
end

function Head:addConnectorBase(connectorBase)
    table.insert(self.connectorBases, connectorBase)   
  
    local p = self:getPosAvailable("connectorBase", "descriptorBase", "regionBase")  
    if(p ~= nil)then
       self:addChild(connectorBase, p)
    else
       self:addChild(connectorBase, 1)
    end
end

function Head:getConnectorBase(i)
    return self.connectorBases[i]
end

function Head:getConnectorBaseById(id)
   for i, connectorBase in ipairs(self.connectorBases) do
       if(connectorBase:getId() == id)then
          return connectorBase
       end
   end
   
   return nil
end

function Head:setConnectorBases(...)
    if(#arg>0)then
      for i, v in ipairs(arg) do
          self:addConnectorBase(v)
      end
    end
end

function Head:removeConnectorBase(connectorBase)
   self:removeChild(connectorBase)
end

function Head:removeConnectorBasePos(i)
   self:removeChild(self.connectorBases[i])
end

return Head