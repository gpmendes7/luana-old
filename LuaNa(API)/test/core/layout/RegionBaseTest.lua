local RegionBase = require "core/layout/RegionBase"
local ImportBase = require "core/importation/ImportBase"
local Region = require "core/layout/Region"

local function test1()
  local regionBase = RegionBase:create()

  assert(regionBase ~= nil, "Error!")
  assert(regionBase:getId() == nil, "Error!")
  assert(regionBase:getDevice() == nil, "Error!")
  assert(regionBase:getRegion() == nil, "Error!")
end

local function test2()
  local atts = {
    id = "regionBase",
    device = "systemScreen(1)",
    region = "region"
  }

  local regionBase = RegionBase:create(atts)

  assert(regionBase:getId() == "regionBase", "Error!")
  assert(regionBase:getDevice() == "systemScreen(1)", "Error!")
  assert(regionBase:getRegion() == "region", "Error!")
end

local function test3()
  local regionBase = RegionBase:create()

  regionBase:setId("regionBase")
  regionBase:setDevice("systemScreen(1)")
  regionBase:setRegion("region")

  assert(regionBase:getId() == "regionBase", "Error!")
  assert(regionBase:getDevice() == "systemScreen(1)", "Error!")
  assert(regionBase:getRegion() == "region", "Error!")
end

local function test4()
  local regionBase = RegionBase:create()
  local status, err

  status, err = pcall(regionBase["setId"], regionBase, nil)
  assert(not(status), "Error!")

  status, err = pcall(regionBase["setId"], regionBase, {})
  assert(not(status), "Error!")

  status, err = pcall(regionBase["setId"], regionBase, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local regionBase

  regionBase = RegionBase:create(nil, 1)
  assert(regionBase:getImportBasePos(1) ~= nil, "Error!")

  regionBase:addImportBase(ImportBase:create())
  assert(regionBase:getImportBasePos(2) ~= nil, "Error!")

  regionBase:addImportBase(ImportBase:create{alias = "rgBase"})
  assert(regionBase:getImportBaseByAlias("rgBase") ~= nil, "Error!")
end

local function test6()
  local regionBase

  regionBase = RegionBase:create(nil, 1)
  assert(regionBase:getRegionPos(1) ~= nil, "Error!")

  regionBase:addRegion(Region:create())
  assert(regionBase:getRegionPos(2) ~= nil, "Error!")

  regionBase:addRegion(Region:create{id = "rg2"})
  assert(regionBase:getRegionById("rg2") ~= nil, "Error!")
end

local function test7()
  local regionBase = RegionBase:create()
  local status, err

  status, err = pcall(regionBase["addRegion"], regionBase, ImportBase:create())
  assert(not(status), "Error!")

  status, err = pcall(regionBase["addRegion"], regionBase, "invalid")
  assert(not(status), "Error!")

  status, err = pcall(regionBase["addRegion"], regionBase, nil)
  assert(not(status), "Error!")

  status, err = pcall(regionBase["addRegion"], regionBase, 999999)
  assert(not(status), "Error!")

  status, err = pcall(regionBase["addRegion"], regionBase, {})
  assert(not(status), "Error!")

  status, err = pcall(regionBase["addRegion"], regionBase, function(a, b) return a+b end)
  assert(not(status), "Error!")
end


local function test8()
  local regionBase1 = RegionBase:create{id = "regionBase1"}

  local importBase1 = ImportBase:create{alias = "rgBase1"}
  local importBase2 = ImportBase:create{alias = "rgBase2"}
  local importBase3 = ImportBase:create{alias = "rgBase3"}

  regionBase1:setImportBases(importBase1, importBase2, importBase3)
  assert(regionBase1:getImportBaseByAlias("rgBase1") ~= nil, "Error!")
  assert(regionBase1:getImportBaseByAlias("rgBase1") ~= nil, "Error!")
  assert(regionBase1:getImportBaseByAlias("rgBase1") ~= nil, "Error!")

  regionBase1:removeImportBase(importBase1)
  assert(regionBase1:getImportBaseByAlias("rgBase1") == nil, "Error!")

  regionBase1:removeImportBasePos(1)
  assert(regionBase1:getImportBaseByAlias("rgBase2") == nil, "Error!")
end

local function test9()
  local regionBase1 = RegionBase:create{id = "regionBase1"}

  local region1 = Region:create{id = "region1"}
  local region2 = Region:create{id = "region2"}
  local region3 = Region:create{id = "region3"}

  regionBase1:setRegions(region1, region2, region3)
  assert(regionBase1:getRegionById("region1") ~= nil, "Error!")
  assert(regionBase1:getRegionById("region2") ~= nil, "Error!")
  assert(regionBase1:getRegionById("region3") ~= nil, "Error!")

  regionBase1:removeRegion(region1)
  assert(regionBase1:getRegionById("region1") == nil, "Error!")

  regionBase1:removeRegionPos(1)
  assert(region1:getRegionById("region2") == nil, "Error!")
end

local function test10()
  local atts = {
    id = "regionBase",
    device = "systemScreen(1)",
    region = "region"
  }

  local regionBase = RegionBase:create(atts)

  local nclExp = "<regionBase"
  for attribute, _ in pairs(regionBase:getAttributesTypeMap()) do
      nclExp = nclExp.." "..attribute.."=\""..tostring(regionBase[attribute]).."\""
  end

  nclExp = nclExp.."/>\n"

  local nclRet = regionBase:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

local function test11()
  local regionBase = RegionBase:create{id = "rb1"}
  local nclExp = "<regionBase id=\"rb1\">\n"

  local region1 = Region:create{id = "rg1"}
  nclExp = nclExp.." <region id=\"rg1\">\n"

  local region2 = Region:create{id = "rg2"}
  nclExp = nclExp.."  <region id=\"rg2\"/>\n"

  local region3 = Region:create{id = "rg3"}
  nclExp = nclExp.."  <region id=\"rg3\">\n"

  local region4 = Region:create{id = "rg4"}
  nclExp = nclExp.."   <region id=\"rg4\"/>\n"

  nclExp = nclExp.."  </region>\n"
  nclExp = nclExp.." </region>\n"

  region1:setRegions(region2, region3)
  region3:addRegion(region4)
  regionBase:setRegions(region1)

  local importBase = ImportBase:create{alias = "connBase"}
  nclExp = nclExp.." <importBase alias=\"connBase\"/>\n"

  nclExp = nclExp.."</regionBase>\n"

  regionBase:addImportBase(importBase)

  local nclRet = regionBase:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()
test7()
test8()
test9()
test10()
test11()