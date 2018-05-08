local SimpleAction = require "core/connectors/SimpleAction"

local function test1()
  local simpleAction = SimpleAction:create()

  assert(simpleAction ~= nil, "Error!")
  assert(simpleAction:getRole() == nil, "Error!")
  assert(simpleAction:getDelay() == nil, "Error!")
  assert(simpleAction:getEventType() == nil, "Error!")
  assert(simpleAction:getActionType() == nil, "Error!")
  assert(simpleAction:getValue() == nil, "Error!")
  assert(simpleAction:getMin() == nil, "Error!")
  assert(simpleAction:getMax() == nil, "Error!")
  assert(simpleAction:getQualifier() == nil, "Error!")
  assert(simpleAction:getRepeat() == nil, "Error!")
  assert(simpleAction:getRepeatDelay() == nil, "Error!")
  assert(simpleAction:getDuration() == nil, "Error!")
  assert(simpleAction:getBy() == nil, "Error!")
end

local function test2()
  local atts = {
    role = "set",
    delay = 0.3,
    eventType = "attribution",
    actionType = "start",
    value = "$var",
    min = 2,
    max = "unbounded",
    qualifier = "seq",
    ["repeat"] = 3,
    repeatDelay = 3,
    duration = 3,
    by = 4
  }

  local simpleAction = SimpleAction:create(atts)

  assert(simpleAction:getRole() == "set", "Error!")
  assert(simpleAction:getDelay() == 0.3, "Error!")
  assert(simpleAction:getEventType() == "attribution", "Error!")
  assert(simpleAction:getActionType() == "start", "Error!")
  assert(simpleAction:getValue() == "$var", "Error!")
  assert(simpleAction:getMin() == 2, "Error!")
  assert(simpleAction:getMax() == "unbounded", "Error!")
  assert(simpleAction:getQualifier() == "seq", "Error!")
  assert(simpleAction:getRepeat() == 3, "Error!")
  assert(simpleAction:getRepeatDelay() == 3, "Error!")
  assert(simpleAction:getDuration() == 3, "Error!")
  assert(simpleAction:getBy() == 4, "Error!")
end

local function test3()
  local simpleAction = SimpleAction:create()

  simpleAction:setRole("set")
  simpleAction:setDelay(0.3)
  simpleAction:setEventType("attribution")
  simpleAction:setActionType("start")
  simpleAction:setValue("$var")
  simpleAction:setMin(2)
  simpleAction:setMax("unbounded")
  simpleAction:setQualifier("seq")
  simpleAction:setRepeat(3)
  simpleAction:setRepeatDelay(3)
  simpleAction:setDuration(3)
  simpleAction:setBy(4)

  assert(simpleAction:getRole() == "set", "Error!")
  assert(simpleAction:getDelay() == 0.3, "Error!")
  assert(simpleAction:getEventType() == "attribution", "Error!")
  assert(simpleAction:getActionType() == "start", "Error!")
  assert(simpleAction:getValue() == "$var", "Error!")
  assert(simpleAction:getMin() == 2, "Error!")
  assert(simpleAction:getMax() == "unbounded", "Error!")
  assert(simpleAction:getQualifier() == "seq", "Error!")
  assert(simpleAction:getRepeat() == 3, "Error!")
  assert(simpleAction:getRepeatDelay() == 3, "Error!")
  assert(simpleAction:getDuration() == 3, "Error!")
  assert(simpleAction:getBy() == 4, "Error!")
end

local function test4()
  local simpleAction = SimpleAction:create()
  local status, err

  status, err = pcall(simpleAction["setEventType"], SimpleAction, "invalid")
  assert(not(status), "Error!")

  status, err = pcall(simpleAction["setEventType"], SimpleAction, nil)
  assert(not(status), "Error!")

  status, err = pcall(simpleAction["setEventType"], SimpleAction, 999999)
  assert(not(status), "Error!")

  status, err = pcall(simpleAction["setEventType"], SimpleAction, {})
  assert(not(status), "Error!")

  status, err = pcall(simpleAction["setEventType"], SimpleAction, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local atts = {
    role = "set",
    delay = 0.3,
    eventType = "attribution",
    actionType = "start",
    value = "$var",
    min = "2",
    max = "unbounded",
    qualifier = "seq",
    ["repeat"] = 3,
    repeatDelay = 3,
    duration = 3,
    by = 4
  }

  local simpleAction = SimpleAction:create(atts)
  
  simpleAction.symbols["delay"] = "s"
  simpleAction.symbols["repeat"] = "s"
  simpleAction.symbols["duration"] = "s"

  local nclExp = "<simpleAction"
  for attribute, _ in pairs(simpleAction:getAttributesTypeMap()) do
    if(simpleAction.symbols ~= nil and simpleAction.symbols[attribute] ~= nil)then
      nclExp = nclExp.." "..attribute.."=\""..simpleAction[attribute]..simpleAction.symbols[attribute].."\""
    else
      nclExp = nclExp.." "..attribute.."=\""..tostring(simpleAction[attribute]).."\""
    end
  end
 
  nclExp = nclExp.."/>\n"

  local nclRet = simpleAction:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()