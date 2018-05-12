local DescriptorBase = require "core/layout/DescriptorBase"
local DescriptorSwitch = require "core/switches/DescriptorSwitch"
local ImportBase = require "core/importation/ImportBase"
local Descriptor = require "core/layout/Descriptor"

local function test1()
  local descriptorBase = DescriptorBase:create()

  assert(descriptorBase ~= nil, "Error!")
  assert(descriptorBase:getId() == nil, "Error!")
end


local function test2()
  local atts = {
    id = "db1"
  }

  local descriptorBase = DescriptorBase:create(atts)

  assert(descriptorBase:getId() == "db1", "Error!")
end

local function test3()
  local descriptorBase = DescriptorBase:create()

  descriptorBase:setId("db1")

  assert(descriptorBase:getId() == "db1", "Error!")
end

local function test4()
  local descriptorBase = DescriptorBase:create()
  local status, err

  status, err = pcall(descriptorBase["setId"], DescriptorBase, nil)
  assert(not(status), "Error!")

  status, err = pcall(descriptorBase["setId"], DescriptorBase, {})
  assert(not(status), "Error!")

  status, err = pcall(descriptorBase["setId"], DescriptorBase, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local descriptorBase

  descriptorBase = DescriptorBase:create(nil, 1)
  assert(descriptorBase:getImportBasePos(1) ~= nil, "Error!")
  assert(descriptorBase:getDescriptorPos(1) ~= nil, "Error!")
  assert(descriptorBase:getDescriptorSwitchPos(1) ~= nil, "Error!")

  descriptorBase:addImportBase(ImportBase:create())

  assert(descriptorBase:getImportBasePos(2) ~= nil, "Error!")

  descriptorBase:addDescriptor(Descriptor:create())
  assert(descriptorBase:getDescriptorPos(2) ~= nil, "Error!")

  descriptorBase:addDescriptorSwitch(DescriptorSwitch:create())
  assert(descriptorBase:getDescriptorSwitchPos(2) ~= nil, "Error!")

  descriptorBase:addImportBase(ImportBase:create{["alias"] = "rgBase"})
  assert(descriptorBase:getImportBaseByAlias("rgBase") ~= nil, "Error!")

  descriptorBase:addDescriptor(Descriptor:create{["id"] = "d1"})
  assert(descriptorBase:getDescriptorById("d1") ~= nil, "Error!")

  descriptorBase:addDescriptorSwitch(DescriptorSwitch:create{["id"] = "ds1"})
  assert(descriptorBase:getDescriptorSwitchById("ds1") ~= nil, "Error!")
end

local function test6()
  local descriptorBase = DescriptorBase:create{id = "db1"}

  local importBase = ImportBase:create{alias = "rgBase1"}
  local descriptor = Descriptor:create{id = "d1"}
  local descriptorSwitch = DescriptorSwitch:create{id = "ds1"}

  descriptorBase:addImportBase(importBase)
  descriptorBase:removeImportBase(importBase)
  assert(descriptorBase:getImportBaseByAlias("rgBase1") == nil, "Error!")

  descriptorBase:addImportBase(importBase)
  descriptorBase:removeImportBasePos(1)
  assert(descriptorBase:getImportBaseByAlias("rgBase2") == nil, "Error!")

  descriptorBase:addDescriptor(descriptor)
  descriptorBase:removeDescriptor(descriptor)
  assert(descriptorBase:getDescriptorById("d1") == nil, "Error!")

  descriptorBase:addImportBase(importBase)
  descriptorBase:removeDescriptorPos(1)
  assert(descriptorBase:getDescriptorById("d1") == nil, "Error!")

  descriptorBase:addDescriptorSwitch(descriptorSwitch)
  descriptorBase:removeDescriptorSwitch(descriptorSwitch)
  assert(descriptorBase:getDescriptorSwitchById("ds1") == nil, "Error!")

  descriptorBase:addDescriptorSwitch(descriptorSwitch)
  descriptorBase:removeDescriptorSwitchPos(1)
  assert(descriptorBase:getDescriptorSwitchById("ds1") == nil, "Error!")
end

local function test7()
  local descriptorBase = DescriptorBase:create()
  local status, err
    
  status, err = pcall(descriptorBase["addDescriptor"], descriptorBase, ImportBase:create())
  assert(not(status), "Error!")
  
  status, err = pcall(descriptorBase["addDescriptor"], descriptorBase, "invalid")
  assert(not(status), "Error!")

  status, err = pcall(descriptorBase["addDescriptor"], descriptorBase, nil)
  assert(not(status), "Error!")

  status, err = pcall(descriptorBase["addDescriptor"], descriptorBase, 999999)
  assert(not(status), "Error!")

  status, err = pcall(descriptorBase["addDescriptor"], descriptorBase, {})
  assert(not(status), "Error!")

  status, err = pcall(descriptorBase["addDescriptor"], descriptorBase, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test7()
  local atts = {
    id = "db1"
  }

  local descriptorBase = DescriptorBase:create(atts)

  local nclExp = "<descriptorBase id=\"db1\"/>\n"

  local nclRet = descriptorBase:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

local function test8()
  local descriptorBase = DescriptorBase:create{id = "db1"}
  local nclExp = "<descriptorBase id=\"db1\">\n"

  local importBase = ImportBase:create{alias = "rgBase1"}
  nclExp = nclExp.." <importBase alias=\"rgBase1\"/>\n"

  local descriptor = Descriptor:create{id = "d1"}
  nclExp = nclExp.." <descriptor id=\"d1\"/>\n"

  local descriptorSwitch = DescriptorSwitch:create{id = "ds1"}
  nclExp = nclExp.." <descriptorSwitch id=\"ds1\"/>\n"

  descriptorBase:addImportBase(importBase)
  descriptorBase:addDescriptor(descriptor)
  descriptorBase:addDescriptorSwitch(descriptorSwitch)

  nclExp = nclExp.."</descriptorBase>\n"

  local nclRet = descriptorBase:table2Ncl(0)

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