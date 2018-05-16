local Port = require "core/interface/Port"

local function test1()
  local port = Port:create()

  assert(port ~= nil, "Error!")
  assert(port:getId() == nil, "Error!")
  assert(port:getComponent() == nil, "Error!")
  assert(port:getComponentAss() == nil, "Error!")
  assert(port:getInterface() == nil, "Error!")
  assert(port:getInterfaceAss() == nil, "Error!")
end

local function test2()
  local atts = {
    id = "port",
    component = "context1",
    interface = "a1"
  }

  local port = Port:create(atts)

  assert(port:getId() == "port", "Error!")
  assert(port:getComponent() == "context1", "Error!")
  assert(port:getInterface() == "a1", "Error!")
end

local function test3()
  local port = Port:create()

  port:setId("port")
  port:setComponent("context1")
  port:setInterface("a1")

  assert(port:getId() == "port", "Error!")
  assert(port:getComponent() == "context1", "Error!")
  assert(port:getInterface() == "a1", "Error!")
end

local function test4()
  local port = Port:create()
  local status, err

  status, err = pcall(port["setId"], port, nil)
  assert(not(status), "Error!")

  status, err = pcall(port["setId"], port, {})
  assert(not(status), "Error!")

  status, err = pcall(port["setId"], port, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local atts = {
    id = "port",
    component = "context1",
    interface = "a1"
  }

  local port = Port:create(atts)

  local nclExp = "<port"
  for attribute, _ in pairs(port:getAttributesTypeMap()) do
      nclExp = nclExp.." "..attribute.."=\""..tostring(port[attribute]).."\""
  end

  nclExp = nclExp.."/>\n"

  local nclRet = port:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()