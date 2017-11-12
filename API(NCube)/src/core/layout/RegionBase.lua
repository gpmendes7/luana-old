local NCLElem = require "core/NCLElem"
local ImportBase = require "core/importation/ImportBase"
local Region = require "core/layout/Region"

local RegionBase = NCLElem:extends()

RegionBase.name = "regionBase"

RegionBase.childrenMap = {
 ["importBase"] = {ImportBase, "many"},
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
   regionBase.importBases = {} 
   regionBase.regions = {}
   
   if(full ~= nil)then  
      regionBase:addImportBase(ImportBase:create())  
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

function RegionBase:addImportBase(importBase)
   self:addChild(importBase)
   table.insert(self.importBases, importBase)
end

function RegionBase:getImportBasePos(p)
    return self.importBases[p]
end

function RegionBase:getImportBaseByAlias(alias)
   for _, importBase in ipairs(self.importBases) do
       if(importBase:getAlias() == alias)then
          return importBase
       end
   end
   
   return nil
end

function RegionBase:setImportBases(...)
    if(#arg>0)then
      for _, importBase in ipairs(arg) do
          self:addImportBase(importBase)
      end
    end
end

function RegionBase:removeImportBase(importBase)
   self:removeChild(importBase)
   
   for p, ib in ipairs(self.importBases) do
       if(importBase == ib)then
           table.remove(self.importBases, p)  
       end
   end    
end

function RegionBase:removeImportBasePos(p)
   self:removeChildPos(p)
   table.remove(self.importBases, p)
end

function RegionBase:addRegion(region)
   self:addChild(region)
   table.insert(self.regions, region) 
end

function RegionBase:getRegionPos(p)
    return self.regions[p]
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
      
   for p, rg in ipairs(self.regions) do
       if(region == rg)then
           table.remove(self.regions, p)  
       end
   end 
end

function RegionBase:removeRegionPos(p)
   self:removeChildPos(p)
   table.remove(self.regions, p)
end

return RegionBase