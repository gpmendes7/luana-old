local LinkParam = require "core/linking/LinkParam"

local function test1()
  local linkParam = LinkParam:create()

  assert(linkParam ~= nil, "Error!")
  assert(linkParam:getName() == nil, "Error!")
  assert(linkParam:getValue() == nil, "Error!")
end

local function test2()
  local atts = {
    name = "delay",
    value = "0.5s"
  }

  local linkParam = LinkParam:create(atts)

  assert(linkParam:getName() == "delay", "Error!")
  assert(linkParam:getValue() == "0.5s", "Error!")
end

local function test3()
  local linkParam = LinkParam:create()

  linkParam:setName("delay")
  linkParam:setValue("0.5s")

  assert(linkParam:getName() == "delay", "Error!")
  assert(linkParam:getValue() == "0.5s", "Error!")
end

local function test4()
  local linkParam = LinkParam:create()
  local status, err

  status, err = pcall(linkParam["setName"], linkParam, nil)
  assert(not(status), "Error!")

  status, err = pcall(linkParam["setName"], linkParam, 999999)
  assert(not(status), "Error!")

  status, err = pcall(linkParam["setName"], linkParam, {})
  assert(not(status), "Error!")

  status, err = pcall(linkParam["setName"], linkParam, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local atts = {
    name = "delay",
    value = "0.5s"
  }

  local linkParam = LinkParam:create(atts)

  local nclExp = "<linkParam"
  for attribute, _ in pairs(linkParam:getAttributesTypeMap()) do
    if(linkParam:getSymbols() ~= nil and linkParam:getSymbol(attribute) ~= nil)then
      nclExp = nclExp.." "..attribute.."=\""..linkParam[attribute]..linkParam:getSymbol(attribute).."\""
    else
      nclExp = nclExp.." "..attribute.."=\""..tostring(linkParam[attribute]).."\""
    end
  end

  nclExp = nclExp.."/>\n"

  local nclRet = linkParam:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()