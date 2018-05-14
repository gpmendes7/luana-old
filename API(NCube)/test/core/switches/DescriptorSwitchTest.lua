local DescriptorSwitch = require "core/switches/DescriptorSwitch"
local DefaultDescriptor = require "core/switches/DefaultDescriptor"
local BindRule = require "core/switches/BindRule"
local Descriptor = require "core/layout/Descriptor"

local function test1()
  local descriptorSwitch = DescriptorSwitch:create()

  assert(descriptorSwitch ~= nil, "Error!")
  assert(descriptorSwitch:getId() == nil, "Error!")
end

local function test2()
  local atts = {
    id = "ds1"
  }

  local descriptorSwitch = DescriptorSwitch:create(atts)

  assert(descriptorSwitch:getId() == "ds1", "Error!")
end

local function test3()
  local descriptorSwitch = DescriptorSwitch:create()

  descriptorSwitch:setId("ds1")

  assert(descriptorSwitch:getId() == "ds1", "Error!")
end

local function test4()
  local descriptorSwitch = DescriptorSwitch:create()
  local status, err

  status, err = pcall(descriptorSwitch["setId"], descriptorSwitch, nil)
  assert(not(status), "Error!")

  status, err = pcall(descriptorSwitch["setId"], descriptorSwitch, {})
  assert(not(status), "Error!")

  status, err = pcall(descriptorSwitch["setId"], descriptorSwitch, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local descriptorSwitch

  descriptorSwitch = DescriptorSwitch:create(nil, 1)
  assert(descriptorSwitch:getDefaultDescriptor() ~= nil, "Error!")
  assert(descriptorSwitch:getBindRulePos(1) ~= nil, "Error!")
  assert(descriptorSwitch:getDescriptorPos(1) ~= nil, "Error!")

  descriptorSwitch:addBindRule(BindRule:create())
  assert(descriptorSwitch:getBindRulePos(2) ~= nil, "Error!")

  descriptorSwitch:addDescriptor(Descriptor:create())
  assert(descriptorSwitch:getDescriptorPos(2) ~= nil, "Error!")

  descriptorSwitch = DescriptorSwitch:create()
  descriptorSwitch:setDefaultDescriptor(DefaultDescriptor:create{descriptor = "df"})
  assert(descriptorSwitch:getDescendantByAttribute("descriptor", "df") ~= nil, "Error!")

  descriptorSwitch = DescriptorSwitch:create()
  descriptorSwitch:addBindRule(BindRule:create{rule = "rPt"})
  assert(descriptorSwitch:getDescendantByAttribute("rule", "rPt") ~= nil, "Error!")

  descriptorSwitch = DescriptorSwitch:create()
  descriptorSwitch:addDescriptor(Descriptor:create{id = "d1"})
  assert(descriptorSwitch:getDescendantByAttribute("id", "d1") ~= nil, "Error!")
end

local function test6()
  local descriptorSwitch = DescriptorSwitch:create{id = "ds1"}
  local defaultDescriptor = DefaultDescriptor:create{descriptor = "df"}
  local bindRule = BindRule:create{rule = "rPt"}
  local descriptor = Descriptor:create{id = "d1"}

  descriptorSwitch:setDefaultDescriptor(defaultDescriptor)
  assert(descriptorSwitch:getDescendantByAttribute("descriptor", "df") ~= nil, "Error!")

  descriptorSwitch:removeDefaultDescriptor(defaultDescriptor)
  assert(descriptorSwitch:getDescendantByAttribute("descriptor", "df") == nil, "Error!")

  descriptorSwitch:addBindRule(bindRule)
  assert(descriptorSwitch:getDescendantByAttribute("rule", "rPt") ~= nil, "Error!")

  descriptorSwitch:removeBindRule(bindRule)
  assert(descriptorSwitch:getDescendantByAttribute("rule", "rPt") == nil, "Error!")

  descriptorSwitch:addBindRule(bindRule)
  descriptorSwitch:removeBindRulePos(1)
  assert(descriptorSwitch:getDescendantByAttribute("rule", "rPt") == nil, "Error!")

  descriptorSwitch:addDescriptor(descriptor)
  assert(descriptorSwitch:getDescendantByAttribute("id", "d1") ~= nil, "Error!")

  descriptorSwitch:removeDescriptor(descriptor)
  assert(descriptorSwitch:getDescendantByAttribute("id", "d1") == nil, "Error!")

  descriptorSwitch:addDescriptor(descriptor)
  descriptorSwitch:removeDescriptorPos(1)
  assert(descriptorSwitch:getDescendantByAttribute("id", "d1") == nil, "Error!")
end

local function test7()
  local descriptorSwitch = DescriptorSwitch:create{id = "ds1"}
  local status, err

  status, err = pcall(descriptorSwitch["addBindRule"], descriptorSwitch, DefaultDescriptor:create())
  assert(not(status), "Error!")

  status, err = pcall(descriptorSwitch["addBindRule"], descriptorSwitch, "invalid")
  assert(not(status), "Error!")

  status, err = pcall(descriptorSwitch["addBindRule"], descriptorSwitch, nil)
  assert(not(status), "Error!")

  status, err = pcall(descriptorSwitch["addBindRule"], descriptorSwitch, 999999)
  assert(not(status), "Error!")

  status, err = pcall(descriptorSwitch["addBindRule"], descriptorSwitch, {})
  assert(not(status), "Error!")

  status, err = pcall(descriptorSwitch["addBindRule"], descriptorSwitch, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test8()
  local atts = {
    id = "ds1"
  }

  local descriptorSwitch = DescriptorSwitch:create(atts)

  local nclExp = "<descriptorSwitch id=\"ds1\"/>\n"

  local nclRet = descriptorSwitch:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

local function test9()
  local descriptorSwitch = DescriptorSwitch:create{["id"] = "ds1"}
  local nclExp = "<descriptorSwitch id=\"ds1\">\n"

  local defaultDescriptor = DefaultDescriptor:create{["descriptor"] = "df"}
  nclExp = nclExp.." <defaultDescriptor descriptor=\"df\"/>\n"

  local bindRule = BindRule:create{["rule"] = "rPt"}
  nclExp = nclExp.." <bindRule rule=\"rPt\"/>\n"

  local descriptor = Descriptor:create{["id"] = "d1"}
  nclExp = nclExp.." <descriptor id=\"d1\"/>\n"

  nclExp = nclExp.."</descriptorSwitch>\n"

  descriptorSwitch:setDefaultDescriptor(defaultDescriptor)
  descriptorSwitch:addBindRule(bindRule)
  descriptorSwitch:addDescriptor(descriptor)

  local nclRet = descriptorSwitch:table2Ncl(0)

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