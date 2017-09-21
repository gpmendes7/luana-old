local NCLElem = require "core/NCLElem"

local Head = Class:createClass(NCLElem)

Head.name = "head"

local RegionBase = require "core/RegionBase"
local DescriptorBase = require "core/DescriptorBase"
local ConnectorBase = require "core/ConnectorBase"

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
    local p = self:getLastPosChild("regionBase")
    if(p ~= nil)then
       self:addChild(regionBase, p+1)
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

function Head:setDescriptorBase(descriptorBase)
   local p = nil 
   
   if(self.descriptorBase == nil)then
      self.descriptorBase = descriptorBase
      
      p = self:getLastPosChild("regionBase")      
      if(p ~= nil)then
         self:addChild(descriptorBase, p+1)
       else
         self:addChild(descriptorBase, 1)
      end    
   else
       p = self:getLastPosChild("descriptorBase")
       self:removeChild(p)
       self:addChild(descriptorBase, p)
   end
   
end

function Head:getDescriptorBase()
   return self.descriptorBase
end

function Head:addConnectorBase(connectorBase)
    table.insert(self.connectorBases, connectorBase)   
    
    local p = nil      
    
    p = self:getLastPosChild("connectorBase")    
    
    if(p ~= nil)then
       self:addChild(connectorBase, p+1)
    else   
      p = self:getLastPosChild("descriptorBase")    
       
      if(p ~= nil)then
         self:addChild(connectorBase, p+1)
      else
         p = self:getLastPosChild("regionBase")   
           
         if(p ~= nil)then
            self:addChild(connectorBase, p+1)
         else
             self:addChild(connectorBase, 1)
         end
      end
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

return Head