local DescriptorParam = require "core/layout/DescriptorParam"

local function test1()
  local descriptorParam = DescriptorParam:create()

  assert(descriptorParam ~= nil, "Error!")
  assert(descriptorParam:getName() == nil, "Error!")
  assert(descriptorParam:getValue() == nil, "Error!")
end

local function test2()
  local atts = {
    name = "soundLevel",
    value = 0.9
  }

  local descriptorParam = DescriptorParam:create(atts)

  assert(descriptorParam:getName() == "soundLevel", "Error!")
  assert(descriptorParam:getValue() == 0.9, "Error!")
end

local function test3()
  local descriptorParam = DescriptorParam:create()

  descriptorParam:setName("soundLevel")
  descriptorParam:setValue(0.9)

  assert(descriptorParam:getName() == "soundLevel", "Error!")
  assert(descriptorParam:getValue() == 0.9, "Error!")
end

local function test4()
  local descriptorParam = DescriptorParam:create()
  local status, err

  status, err = pcall(descriptorParam["setValue"], descriptorParam, nil)
  assert(not(status), "Error!")

  status, err = pcall(descriptorParam["setValue"], descriptorParam, {})
  assert(not(status), "Error!")

  status, err = pcall(descriptorParam["setValue"], descriptorParam, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local atts = {
    name = "soundLevel",
    value = 0.9
  }

  local descriptorParam = DescriptorParam:create(atts)

  local nclExp = "<descriptorParam"
  for attribute, _ in pairs(descriptorParam:getAttributesTypeMap()) do
      nclExp = nclExp.." "..attribute.."=\""..tostring(descriptorParam[attribute]).."\""
  end

  nclExp = nclExp.."/>\n"

  local nclRet = descriptorParam:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()