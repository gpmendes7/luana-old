local Bind = require "core/linking/Bind"
local BindParam = require "core/linking/BindParam"

local function test1()
  local bind = Bind:create()

  assert(bind ~= nil, "Error!")
  assert(bind:getRole() == nil, "Error!")
  assert(bind:getComponent() == nil, "Error!")
  assert(bind:getInterface() == nil, "Error!")
  assert(bind:getDescriptor() == nil, "Error!")
end

local function test2()
  local atts = {
    role = "onBegin",
    component = "img",
    interface = "area",
    descriptor = "d1"
  }

  local bind = Bind:create(atts)

  assert(bind:getRole() == "onBegin", "Error!")
  assert(bind:getComponent() == "img", "Error!")
  assert(bind:getInterface() == "area", "Error!")
  assert(bind:getDescriptor() == "d1", "Error!")
end

local function test3()
  local bind = Bind:create()

  bind:setRole("onBegin")
  bind:setComponent("img")
  bind:setInterface("area")
  bind:setDescriptor("d1")

  assert(bind:getRole() == "onBegin", "Error!")
  assert(bind:getComponent() == "img", "Error!")
  assert(bind:getInterface() == "area", "Error!")
  assert(bind:getDescriptor() == "d1", "Error!")
end

local function test4()
  local bind = Bind:create()
  local status, err

  status, err = pcall(bind["setRole"], bind, nil)
  assert(not(status), "Error!")

  status, err = pcall(bind["setRole"], bind, {})
  assert(not(status), "Error!")

  status, err = pcall(bind["setRole"], bind, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local bind

  bind = Bind:create(nil, 1)
  assert(bind:getBindParamPos(1) ~= nil, "Error!")

  bind:addBindParam(BindParam:create())
  assert(bind:getBindParamPos(2) ~= nil, "Error!")

  bind:addBindParam(BindParam:create{name = "keyCode"})
  assert(bind:getDescendantByAttribute("name", "keyCode") ~= nil, "Error!")
end

local function test6()
  local bind = Bind:create{role = "onBegin"}
  local bindParam = BindParam:create{name = "keyCode"}

  bind:addBindParam(bindParam)
  assert(bind:getDescendantByAttribute("name", "keyCode") ~= nil, "Error!")

  bind:removeBindParam(bindParam)
  assert(bind:getDescendantByAttribute("name", "keyCode") == nil, "Error!")

  bind:addBindParam(bindParam)
  bind:removeBindParamPos(1)
  assert(bind:getDescendantByAttribute("name", "keyCode") == nil, "Error!")
end

local function test7()
  local bind = Bind:create()
  local status, err
    
  status, err = pcall(bind["addBindParam"], bind, Bind:create())
  assert(not(status), "Error!")
  
  status, err = pcall(bind["addBindParam"], bind, "invalid")
  assert(not(status), "Error!")

  status, err = pcall(bind["addBindParam"], bind, nil)
  assert(not(status), "Error!")

  status, err = pcall(bind["addBindParam"], bind, 999999)
  assert(not(status), "Error!")

  status, err = pcall(bind["addBindParam"], bind, {})
  assert(not(status), "Error!")

  status, err = pcall(bind["addBindParam"], bind, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test8()
  local atts = {
    role = "onBegin",
    component = "img",
    interface = "area",
    descriptor = "d1"
  }

  local bind = Bind:create(atts)

  local nclExp = "<bind"
  for attribute, _ in pairs(bind:getAttributesTypeMap()) do
      nclExp = nclExp.." "..attribute.."=\""..tostring(bind[attribute]).."\""
  end

  nclExp = nclExp.."/>\n"

  local nclRet = bind:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

local function test9()
  local bind = Bind:create{["role"] = "onBegin"}
  local nclExp = "<bind role=\"onBegin\">\n"

  local bindParam = BindParam:create{["name"] = "keyCode"}
  nclExp = nclExp.." <bindParam name=\"keyCode\"/>\n"

  nclExp = nclExp.."</bind>\n"

  bind:addBindParam(bindParam)

  local nclRet = bind:table2Ncl(0)

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