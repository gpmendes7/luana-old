local BindParam = require "core/linking/BindParam"

local function test1()
  local bindParam = BindParam:create()

  assert(bindParam ~= nil, "Error!")
  assert(bindParam:getName() == nil, "Error!")
  assert(bindParam:getValue() == nil, "Error!")
end

local function test2()
  local atts = {
    name = "keyCode",
    value = "YELLOW"
  }

  local bindParam = BindParam:create(atts)

  assert(bindParam:getName() == "keyCode", "Error!")
  assert(bindParam:getValue() == "YELLOW", "Error!")
end

local function test3()
  local bindParam = BindParam:create()

  bindParam:setName("keyCode")
  bindParam:setValue("YELLOW")

  assert(bindParam:getName() == "keyCode", "Error!")
  assert(bindParam:getValue() == "YELLOW", "Error!")
end

local function test4()
  local bindParam = BindParam:create()
  local status, err

  status, err = pcall(bindParam["setName"], bindParam, nil)
  assert(not(status), "Error!")

  status, err = pcall(bindParam["setName"], bindParam, {})
  assert(not(status), "Error!")

  status, err = pcall(bindParam["setName"], bindParam, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local atts = {
    name = "keyCode",
    value = "YELLOW"
  }

  local bindParam = BindParam:create(atts)

  local nclExp = "<bindParam"
  for attribute, _ in pairs(bindParam:getAttributesTypeMap()) do
    if(bindParam:getSymbols() ~= nil and bindParam:getSymbol(attribute) ~= nil)then
      nclExp = nclExp.." "..attribute.."=\""..bindParam[attribute]..bindParam:getSymbol(attribute).."\""
    else
      nclExp = nclExp.." "..attribute.."=\""..tostring(bindParam[attribute]).."\""
    end
  end

  nclExp = nclExp.."/>\n"

  local nclRet = bindParam:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()