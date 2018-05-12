local Property = require "core/interface/Property"

local function test1()
  local property = Property:create()

  assert(property ~= nil, "Error!")
  assert(property:getName() == nil, "Error!")
  assert(property:getValue() == nil, "Error!")
  assert(property:getExternable() == nil, "Error!")
end

local function test2()
  local atts = {
    name = "sound",
    value = "2",
    externable = true
  }

  local property = Property:create(atts)

  assert(property:getName() == "sound", "Error!")
  assert(property:getValue() == "2", "Error!")
  assert(property:getExternable() == true, "Error!")
end


local function test3()
  local property = Property:create()

  property:setName("sound")
  property:setValue("2")
  property:setExternable(true)

  assert(property:getName() == "sound", "Error!")
  assert(property:getValue() == "2", "Error!")
  assert(property:getExternable() == true, "Error!")
end

local function test4()
  local property = Property:create()
  local status, err

  status, err = pcall(property["setName"], Property, nil)
  assert(not(status), "Error!")

  status, err = pcall(property["setName"], Property, {})
  assert(not(status), "Error!")

  status, err = pcall(property["setName"], Property, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local atts = {
    name = "sound",
    value = "2",
    externable = true
  }

  local property = Property:create(atts)

  local nclExp = "<property"
  for attribute, _ in pairs(property:getAttributesTypeMap()) do
      nclExp = nclExp.." "..attribute.."=\""..tostring(property[attribute]).."\""
  end

  nclExp = nclExp.."/>\n"

  local nclRet = property:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()