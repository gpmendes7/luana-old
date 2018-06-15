local Mapping = require "core/switches/Mapping"

local function test1()
  local mapping = Mapping:create()

  assert(mapping ~= nil, "Error!")
  assert(mapping:getComponent() == nil, "Error!")
  assert(mapping:getComponentAss() == nil, "Error!")
  assert(mapping:getInterface() == nil, "Error!")
  assert(mapping:getInterfaceAss() == nil, "Error!")
end

local function test2()
  local atts = {
    component = "enForm",
    interface = "interface"
  }

  local mapping = Mapping:create(atts)

  assert(mapping:getComponent() == "enForm", "Error!")
  assert(mapping:getInterface() == "interface", "Error!")
end

local function test3()
  local mapping = Mapping:create()

  mapping:setComponent("enForm")
  mapping:setInterface("interface")

  assert(mapping:getComponent() == "enForm", "Error!")
  assert(mapping:getInterface() == "interface", "Error!")
end

local function test4()
  local mapping = Mapping:create()
  local status, err

  status, err = pcall(mapping["setComponent"], mapping, Mapping:create())
  assert(not(status), "Error!")

  status, err = pcall(mapping["setComponent"], mapping, nil)
  assert(not(status), "Error!")

  status, err = pcall(mapping["setComponent"], mapping, {})
  assert(not(status), "Error!")

  status, err = pcall(mapping["setComponent"], mapping, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local atts = {
    component = "enForm",
    interface = "interface"
  }

  local mapping = Mapping:create(atts)

  local nclExp = "<mapping"
  for attribute, _ in pairs(mapping:getAttributesTypeMap()) do
      nclExp = nclExp.." "..attribute.."=\""..tostring(mapping[attribute]).."\""
  end

  nclExp = nclExp.."/>\n"

  local nclRet = mapping:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()