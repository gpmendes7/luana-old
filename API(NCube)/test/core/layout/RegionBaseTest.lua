local RegionBase = require "core/layout/RegionBase"
local ImportBase = require "core/importation/ImportBase"
local Region = require "core/layout/Region"

local function test1()
   local regionBase = nil
   
   regionBase = RegionBase:create()
   assert(regionBase ~= nil, "Error!")
   assert(regionBase:getId() == "", "Error!")  
   assert(regionBase:getDevice() == "", "Error!")
   assert(regionBase:getRegion() == "", "Error!")
end

local function test2()
   local regionBase = nil
   
   local atts = {
      ["id"] = "regionBase",
      ["device"] = "systemScreen(1)",
      ["region"] = "region" 
   }     
   
   regionBase = RegionBase:create(atts)
   assert(regionBase:getId() == "regionBase", "Error!")
   assert(regionBase:getDevice() == "systemScreen(1)", "Error!")
   assert(regionBase:getRegion() == "region", "Error!")
end

local function test3()
   local regionBase = nil
      
   regionBase = RegionBase:create()
   
   regionBase:setId("regionBase")
   regionBase:setDevice("systemScreen(1)")
   regionBase:setRegion("region")

   assert(regionBase:getId() == "regionBase", "Error!")
   assert(regionBase:getDevice() == "systemScreen(1)", "Error!")
   assert(regionBase:getRegion() == "region", "Error!")
end

local function test4()
   local regionBase = nil
      
   regionBase = RegionBase:create(nil, 1)
   assert(regionBase:getImportBasePos(1) ~= nil, "Error!")
   
   regionBase:addImportBase(ImportBase:create())
   assert(regionBase:getImportBasePos(2) ~= nil, "Error!")
   
   regionBase:addImportBase(ImportBase:create{["alias"] = "baseRegioes"})
   assert(regionBase:getImportBaseByAlias("baseRegioes") ~= nil, "Error!")
end

local function test5()
   local regionBase = nil
      
   regionBase = RegionBase:create(nil, 1)
   assert(regionBase:getRegionPos(1) ~= nil, "Error!")
   
   regionBase:addRegion(Region:create())
   assert(regionBase:getRegionPos(2) ~= nil, "Error!")
   
   regionBase:addRegion(Region:create{["id"] = "rg2"})
   assert(regionBase:getRegionById("rg2") ~= nil, "Error!")
end

local function test6()
   local regionBase1 = RegionBase:create{["id"] = "regionBase1"}
   
   local importBase1 = ImportBase:create{["alias"] = "baseRegioes1"}
   local importBase2 = ImportBase:create{["alias"] = "baseRegioes2"}
   local importBase3 = ImportBase:create{["alias"] = "baseRegioes3"}
   
   regionBase1:setImportBases(importBase1, importBase2, importBase3)
   assert(regionBase1:getImportBaseByAlias("baseRegioes1") ~= nil, "Error!")
   assert(regionBase1:getImportBaseByAlias("baseRegioes1") ~= nil, "Error!")
   assert(regionBase1:getImportBaseByAlias("baseRegioes1") ~= nil, "Error!")

   regionBase1:removeImportBase(importBase1)
   assert(regionBase1:getImportBaseByAlias("baseRegioes1") == nil, "Error!")
   
   regionBase1:removeImportBasePos(1)
   assert(regionBase1:getImportBaseByAlias("baseRegioes2") == nil, "Error!")
end

local function test7()
   local regionBase1 = RegionBase:create{["id"] = "regionBase1"}
   
   local region1 = Region:create{["id"] = "region1"}
   local region2 = Region:create{["id"] = "region2"}
   local region3 = Region:create{["id"] = "region3"}
   
   regionBase1:setRegions(region1, region2, region3)
   assert(regionBase1:getRegionById("region1") ~= nil, "Error!")
   assert(regionBase1:getRegionById("region2") ~= nil, "Error!")
   assert(regionBase1:getRegionById("region3") ~= nil, "Error!")
    
   regionBase1:removeRegion(region1)
   assert(regionBase1:getRegionById("region1") == nil, "Error!")
   
   regionBase1:removeRegionPos(1)
   assert(region1:getRegionById("region2") == nil, "Error!")
end


test1()
test2()
test3()
test4()
test5()
test6()
test7()