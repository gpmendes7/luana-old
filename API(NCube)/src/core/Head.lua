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
Head.seq = true

function Head:create(full)
   local head = Head:new()
      
   head:setChilds()   
   
   if(full ~= nil)then      
      head.regionBases = {}
      head:addChild({} , 1)
            
      local descriptorBase = DescriptorBase:create(nil, full)
      head:setDescriptorBase(descriptorBase)
      
      head.connectorBases = {}
      head:addChild({} , 3)
   end
   
   return head
end

function Head:addRegionBase(regionBase)
    table.insert(self.regionBases, regionBase)
    table.insert(self:getChild(1), regionBase)
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
   self.descriptorBase = descriptorBase
   self:addChild(descriptorBase, 2)
end

function Head:getDescriptorBase()
   return self.descriptorBase
end

function Head:addConnectorBase(connectorBase)
    table.insert(self.connectorBases, connectorBase)
    table.insert(self:getChild(3), connectorBase)
end

function Head:getConnectorBase(i)
    return self.connectorBase[i]
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