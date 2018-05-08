local SimpleCondition = require "core/connectors/SimpleCondition"

local function test1()
  local simpleCondition = SimpleCondition:create()

  assert(simpleCondition ~= nil, "Error!")
  assert(simpleCondition:getRole() == nil, "Error!")
  assert(simpleCondition:getDelay() == nil, "Error!")
  assert(simpleCondition:getEventType() == nil, "Error!")
  assert(simpleCondition:getKey() == nil, "Error!")
  assert(simpleCondition:getTransition() == nil, "Error!")
  assert(simpleCondition:getMin() == nil, "Error!")
  assert(simpleCondition:getMax() == nil, "Error!")
  assert(simpleCondition:getQualifier() == nil, "Error!")
end

local function test2()
  local atts = {
    role = "onSelection",
    delay = 0.3,
    eventType = "selection",
    key = "$keyCode",
    transition = "starts",
    min = 2,
    max = "unbounded",
    qualifier = "or"
  }

  local simpleCondition = SimpleCondition:create(atts)

  assert(simpleCondition:getRole() == "onSelection", "Error!")
  assert(simpleCondition:getDelay() == 0.3, "Error!")
  assert(simpleCondition:getEventType() == "selection", "Error!")
  assert(simpleCondition:getKey() == "$keyCode", "Error!")
  assert(simpleCondition:getTransition() == "starts", "Error!")
  assert(simpleCondition:getMin() == 2, "Error!")
  assert(simpleCondition:getMax() == "unbounded", "Error!")
  assert(simpleCondition:getQualifier() == "or", "Error!")
end

local function test3()
  local simpleCondition = SimpleCondition:create()

  simpleCondition:setRole("onSelection")
  simpleCondition:setDelay(0.3)
  simpleCondition:setEventType("selection")
  simpleCondition:setKey("$keyCode")
  simpleCondition:setTransition("starts")
  simpleCondition:setMin(2)
  simpleCondition:setMax("unbounded")
  simpleCondition:setQualifier("or")

  assert(simpleCondition:getRole() == "onSelection", "Error!")
  assert(simpleCondition:getDelay() == 0.3, "Error!")
  assert(simpleCondition:getEventType() == "selection", "Error!")
  assert(simpleCondition:getKey() == "$keyCode", "Error!")
  assert(simpleCondition:getTransition() == "starts", "Error!")
  assert(simpleCondition:getMin() == 2, "Error!")
  assert(simpleCondition:getMax() == "unbounded", "Error!")
  assert(simpleCondition:getQualifier() == "or", "Error!")
end

local function test4()
  local simpleCondition = SimpleCondition:create()
  local status, err

  status, err = pcall(simpleCondition["setEventType"], SimpleCondition, "invalid")
  assert(not(status), "Error!")

  status, err = pcall(simpleCondition["setEventType"], SimpleCondition, nil)
  assert(not(status), "Error!")

  status, err = pcall(simpleCondition["setEventType"], SimpleCondition, 999999)
  assert(not(status), "Error!")

  status, err = pcall(simpleCondition["setEventType"], SimpleCondition, {})
  assert(not(status), "Error!")

  status, err = pcall(simpleCondition["setEventType"], SimpleCondition, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local atts = {
    role = "onSelection",
    delay = 0.3,
    eventType = "selection",
    key = "$keyCode",
    transition = "starts",
    min = 2,
    max = "unbounded",
    qualifier = "or"
  }

  local simpleCondition = SimpleCondition:create(atts)
  
  simpleCondition.symbols["delay"] = "s"

  local nclExp = "<simpleCondition"
  for attribute, _ in pairs(simpleCondition:getAttributesTypeMap()) do
    if(simpleCondition.symbols ~= nil and simpleCondition.symbols[attribute] ~= nil)then
      nclExp = nclExp.." "..attribute.."=\""..simpleCondition[attribute]..simpleCondition.symbols[attribute].."\""
    else
      nclExp = nclExp.." "..attribute.."=\""..tostring(simpleCondition[attribute]).."\""
    end
  end

  nclExp = nclExp.."/>\n"

  local nclRet = simpleCondition:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()