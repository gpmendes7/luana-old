local SwitchPort = require "core/switches/SwitchPort"
local Mapping = require "core/switches/Mapping"

local function test1()
  local switchPort = SwitchPort:create()

  assert(switchPort ~= nil, "Error!")
  assert(switchPort:getId() == nil, "Error!")
end

local function test2()
  local atts = {
    id = "sp1"
  }

  local switchPort = SwitchPort:create(atts)

  assert(switchPort:getId() == "sp1", "Error!")
end

local function test3()
  local switchPort = SwitchPort:create()

  switchPort:setId("sp1")

  assert(switchPort:getId() == "sp1", "Error!")
end

local function test4()
  local switchPort = SwitchPort:create()
  local status, err

  status, err = pcall(switchPort["setId"], switchPort, nil)
  assert(not(status), "Error!")

  status, err = pcall(switchPort["setId"], switchPort, {})
  assert(not(status), "Error!")

  status, err = pcall(switchPort["setId"], switchPort, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local switchPort

  switchPort = SwitchPort:create(nil, 1)
  assert(switchPort:getMappingPos(1) ~= nil, "Error!")

  switchPort:addMapping(Mapping:create())
  assert(switchPort:getMappingPos(2) ~= nil, "Error!")

  switchPort = SwitchPort:create()
  switchPort:addMapping(Mapping:create{["component"] = "enForm"})
  assert(switchPort:getDescendantByAttribute("component", "enForm") ~= nil, "Error!")
end

local function test6()
  local switchPort = SwitchPort:create{id = "sp1"}
  local mapping = Mapping:create{component = "enForm"}

  switchPort:addMapping(mapping)
  assert(switchPort:getDescendantByAttribute("component", "enForm") ~= nil, "Error!")

  switchPort:removeMapping(mapping)
  assert(switchPort:getDescendantByAttribute("component", "enForm") == nil, "Error!")

  switchPort:addMapping(mapping)
  switchPort:removeMappingPos(1)
  assert(switchPort:getDescendantByAttribute("component", "enForm") == nil, "Error!")
end

local function test7()
  local switchPort = SwitchPort:create()
  local status, err

  status, err = pcall(switchPort["addMapping"], switchPort, SwitchPort)
  assert(not(status), "Error!")

  status, err = pcall(switchPort["addMapping"], switchPort, "invalid")
  assert(not(status), "Error!")

  status, err = pcall(switchPort["addMapping"], switchPort, nil)
  assert(not(status), "Error!")

  status, err = pcall(switchPort["addMapping"], switchPort, {})
  assert(not(status), "Error!")

  status, err = pcall(switchPort["addMapping"], switchPort, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test8()
  local atts = {
    id = "sp1"
  }

  local switchPort = SwitchPort:create(atts)

  local nclExp = "<switchPort id=\"sp1\"/>\n"

  local nclRet = switchPort:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

local function test9()
  local switchPort = SwitchPort:create{id = "sp1"}
  local nclExp = "<switchPort id=\"sp1\">\n"

  local mapping = Mapping:create{component = "enForm"}
  nclExp = nclExp.." <mapping component=\"enForm\"/>\n"

  nclExp = nclExp.."</switchPort>\n"

  switchPort:addMapping(mapping)

  local nclRet = switchPort:table2Ncl(0)

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