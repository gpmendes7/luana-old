local NCLElem = require "core/NCLElem"
local Region = require "core/adaptation/Region"

local RegionBase = NCLElem:extends()

RegionBase.name = "regionBase"

RegionBase.attributes = { 
  id = nil,
  device = nil,
  region = nil 
}

RegionBase.childsMap = {
 ["region"] = {Region, "many", 1}
}

RegionBase.regions = nil

function RegionBase:create(attributes, full)
   local attributes = attributes or {}     
   local regionBase = RegionBase:new()  
    
   regionBase:setAttributes(attributes)
   regionBase:setChilds()  
   regionBase.regions = {}
   
   if(full ~= nil)then    
      regionBase:addRegion(Region:create())
   end
   
   return regionBase
end

function RegionBase:setId(id)
   self.attributes.id = id
end

function RegionBase:getId()
   return self.attributes.id
end

function RegionBase:setDevice(device)
   self.attributes.device = device
end

function RegionBase:getDevice()
   return self.attributes.device
end

function RegionBase:setRegionExt(region)
   self.attributes.region = region
end

function RegionBase:getRegionExt()
   return self.attributes.region
end

function RegionBase:addRegion(region)
    table.insert(self.regions, region)    
    local p = self:getLastPosChild("region")
    if(p ~= nil)then
       self:addChild(region, p+1)
    else
       self:addChild(region, 1)
    end
end

function RegionBase:getRegion(i)
    return self.regions[i]
end

function RegionBase:getRegionById(id)
   for i, v in ipairs(self.regions) do
       if(self.regions[i]:getId() == id)then
          return self.regions[i]
       end
   end
   
   return nil
end

function RegionBase:setRegions(...)
    if(#arg>0)then
      for i, v in ipairs(arg) do
          self:addRegion(v)
      end
    end
end

return RegionBase