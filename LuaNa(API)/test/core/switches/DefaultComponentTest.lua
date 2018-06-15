local DefaultComponent = require "core/switches/DefaultComponent"

local function test1()
  local defaultComponent = DefaultComponent:create()

  assert(defaultComponent ~= nil, "Error!")
  assert(defaultComponent:getComponent() == nil, "Error!")
  assert(defaultComponent:getComponentAss() == nil, "Error!")
end

local function test2()
  local atts = {
    component = "component"
  }

  local defaultComponent = DefaultComponent:create(atts)

  assert(defaultComponent ~= nil, "Error!")
  assert(defaultComponent:getComponent() == "component", "Error!")
end

local function test3()
  local defaultComponent = DefaultComponent:create()

  defaultComponent:setComponent("component")

  assert(defaultComponent:getComponent() == "component", "Error!")
end

local function test4()
  local defaultComponent = DefaultComponent:create()
  local status, err

  status, err = pcall(defaultComponent["setComponent"], defaultComponent, nil)
  assert(not(status), "Error!")

  status, err = pcall(defaultComponent["setComponent"], defaultComponent, {})
  assert(not(status), "Error!")

  status, err = pcall(defaultComponent["setComponent"], defaultComponent, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local atts = {
    component = "component"
  }

  local defaultComponent = DefaultComponent:create(atts)

  local nclExp = "<defaultComponent component=\"component\"/>\n"

  local nclRet = defaultComponent:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()