local AttributeAssessment = require "../../src/core/connectors/AttributeAssessment"

local function test1()
  local attributeAssessment = AttributeAssessment:create()
  
  assert(attributeAssessment ~= nil, "Error!")
  assert(attributeAssessment:getRole() == nil, "Error!")
  assert(attributeAssessment:getEventType() == nil, "Error!")
  assert(attributeAssessment:getKey() == nil, "Error!")
  assert(attributeAssessment:getAttributeType() == nil, "Error!")
  assert(attributeAssessment:getOffset() == nil, "Error!")
end

local function test2()
  local atts = {
    role = "attNodeTest",
    eventType = "presentation",
    key = "CURSOR_DOWN",
    attributeType = "nodeProperty",
    offset = "offset"
  }

  local attributeAssessment = AttributeAssessment:create(atts)
  
  assert(attributeAssessment:getRole() == "attNodeTest", "Error!")
  assert(attributeAssessment:getEventType() == "presentation", "Error!")
  assert(attributeAssessment:getKey() == "CURSOR_DOWN", "Error!")
  assert(attributeAssessment:getAttributeType() == "nodeProperty", "Error!")
  assert(attributeAssessment:getOffset() == "offset", "Error!")
end

local function test3()
  local attributeAssessment

  attributeAssessment = AttributeAssessment:create()
  attributeAssessment:setRole("attNodeTest")
  attributeAssessment:setEventType("presentation")
  attributeAssessment:setKey("CURSOR_DOWN")
  attributeAssessment:setAttributeType("nodeProperty")
  attributeAssessment:setOffset("offset")

  assert(attributeAssessment:getRole() == "attNodeTest", "Error!")
  assert(attributeAssessment:getEventType() == "presentation", "Error!")
  assert(attributeAssessment:getKey() == "CURSOR_DOWN", "Error!")
  assert(attributeAssessment:getAttributeType() == "nodeProperty", "Error!")
  assert(attributeAssessment:getOffset() == "offset", "Error!")
end

local function test4()
  local attributeAssessment = AttributeAssessment:create()
  local status, err

  status, err = pcall(attributeAssessment["setKey"], attributeAssessment, "invalid")
  assert(not(status), "Error!")

  status, err = pcall(attributeAssessment["setKey"], attributeAssessment, nil)
  assert(not(status), "Error!")

  status, err = pcall(attributeAssessment["setKey"], attributeAssessment, 999999)
  assert(not(status), "Error!")

  status, err = pcall(attributeAssessment["setKey"], attributeAssessment, {})
  assert(not(status), "Error!")

  status, err = pcall(attributeAssessment["setKey"], attributeAssessment, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local atts = {
    role = "attNodeTest",
    eventType = "presentation",
    key = "CURSOR_DOWN",
    attributeType = "nodeProperty",
    offset = "offset"
  }

  local attributeAssessment = AttributeAssessment:create(atts)

  local nclExp = "<attributeAssessment"
  for attribute, _ in pairs(attributeAssessment:getAttributesTypeMap()) do
      nclExp = nclExp.." "..attribute.."=\""..tostring(attributeAssessment[attribute]).."\""
  end

  nclExp = nclExp.."/>\n"

  local nclRet = attributeAssessment:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()