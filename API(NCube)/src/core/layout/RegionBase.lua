local NCLElem = require "core/structure_content/NCLElem"
local Region = require "core/layout/Region"

local RegionBase = NCLElem:extends()

RegionBase.name = "regionBase"

RegionBase.childrenMap = {
 ["region"] = {Region, "many"}
}

function RegionBase:create(attributes, full)
   local attributes = attributes or {}     
   local regionBase = RegionBase:new()  
   
   regionBase.attributes = { 
      ["id"] = "",
      ["device"] = "",
      ["region"] = "" 
   }
   
   if(attributes ~= nil)then
      regionBase:setAttributes(attributes)
   end
   
   regionBase.children = {}  
   regionBase.regions = {}
   
   if(full ~= nil)then    
      regionBase:addRegion(Region:create())
   end
   
   return regionBase
end

function RegionBase:setId(id)
   self:addAttribute("id", id)
end

function RegionBase:getId()
   return self:getAttribute("id")
end

function RegionBase:setDevice(device)
   self:addAttribute("device", device)
end

function RegionBase:getDevice()
   return self:getAttribute("device")
end

function RegionBase:setRegion(region)
   self:addAttribute("region", region)
end

function RegionBase:getRegion()
   return self:getAttribute("region")
end

function RegionBase:addRegion(region)
    table.insert(self.regions, region)    
    local p = self:getPosAvailable("region")
    if(p ~= nil)then
       self:addChild(region, p)
    else
       self:addChild(region, 1)
    end
end

function RegionBase:getRegionPos(i)
    return self.regions[i]
end

function RegionBase:getRegionById(id)
   for _, region in ipairs(self.regions) do
       if(region:getId() == id)then
          return region
       end
   end
   
   return nil
end

function RegionBase:setRegions(...)
    if(#arg>0)then
      for _, region in ipairs(arg) do
          self:addRegion(region)
      end
    end
end

function RegionBase:removeRegion(region)
   self:removeChild(region)
      
   for i, rg in ipairs(self.regions) do
       if(region == rg)then
           table.remove(self.regions, i)  
       end
   end 
end

function RegionBase:removeRegionPos(i)
   self:removeChildPos(i)
   table.remove(self.regions, i)
end

return RegionBase