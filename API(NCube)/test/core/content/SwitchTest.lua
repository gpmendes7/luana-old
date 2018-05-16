local CompositeNodes = require "core/content/CompositeNode"
local Context = CompositeNodes[1]
local Switch = CompositeNodes[2]
local DefaultComponent = require "core/switches/DefaultComponent"
local SwitchPort = require "core/switches/SwitchPort"
local BindRule = require "core/switches/BindRule"
local Media = require "core/content/Media"

local function test1()
  local switch = Switch:create()

  assert(switch ~= nil, "Error!")
  assert(switch:getId() == nil, "Error!")
  assert(switch:getRefer() == nil, "Error!")
end

local function test2()
  local atts = {
    id = "s1",
    refer = "rf"
  }

  local switch = Switch:create(atts)

  assert(switch:getId() == "s1", "Error!")
  assert(switch:getRefer() == "rf", "Error!")
end

local function test3()
  local switch = Switch:create()

  switch:setId("s1")
  switch:setRefer("rf")

  assert(switch:getId() == "s1", "Error!")
  assert(switch:getRefer() == "rf", "Error!")
end

local function test4()
  local switch = Switch:create()
  local status, err
  local file, msg

  status, err = pcall(switch["setId"], switch, nil)
  assert(not(status), "Error!")
  file, msg = err:match("(.-:%d+): (.+)")
  assert(msg == "Error! Nil value passed to id attribute in switch element!", "Error!")

  status, err = pcall(switch["setId"], switch, {})
  assert(not(status), "Error!")
  file, msg = err:match("(.-:%d+): (.+)")
  assert(msg == "Error! Type of id attribute is not valid to switch element!", "Error!")

  status, err = pcall(switch["setId"], switch, function(a, b) return a+b end)
  assert(not(status), "Error!")
  file, msg = err:match("(.-:%d+): (.+)")
  assert(msg == "Error! Type of id attribute is not valid to switch element!", "Error!")
end

local function test5()
  local switch

  switch = Switch:create(nil, 1)
  assert(switch:getDefaultComponent(1) ~= nil, "Error!")
  assert(switch:getSwitchPortPos(1) ~= nil, "Error!")
  assert(switch:getBindRulePos(1) ~= nil, "Error!")
  assert(switch:getMediaPos(1) ~= nil, "Error!")
  assert(switch:getContextPos(1) ~= nil, "Error!")
  assert(switch:getSwitchPos(1) ~= nil, "Error!")

  switch:addSwitchPort(SwitchPort:create())
  assert(switch:getSwitchPortPos(2) ~= nil, "Error!")

  switch:addBindRule(BindRule:create())
  assert(switch:getBindRulePos(2) ~= nil, "Error!")

  switch:addMedia(Media:create())
  assert(switch:getMediaPos(2) ~= nil, "Error!")

  switch:addContext(Context:create())
  assert(switch:getContextPos(2) ~= nil, "Error!")

  switch:addSwitch(Switch:create())
  assert(switch:getSwitchPos(2) ~= nil, "Error!")

  switch:setDefaultComponent(DefaultComponent:create{component = "comp"})
  assert(switch:getDescendantByAttribute("component", "comp") ~= nil, "Error!")

  switch:addSwitchPort(SwitchPort:create{id = "sp1"})
  assert(switch:getSwitchPortById("sp1") ~= nil, "Error!")

  switch:addBindRule(BindRule:create{constituent = "audio1"})
  assert(switch:getDescendantByAttribute("constituent", "audio1") ~= nil, "Error!")

  switch:addMedia(Media:create{id = "m1"})
  assert(switch:getMediaById("m1") ~= nil, "Error!")

  switch:addContext(Context:create{id = "c1"})
  assert(switch:getContextById("c1") ~= nil, "Error!")

  switch:addSwitch(Switch:create{id = "s1"})
  assert(switch:getSwitchById("s1") ~= nil, "Error!")
end

local function test6()
  local switch1 = Switch:create{id = "s1"}
  local defaultComponent = DefaultComponent:create{component = "comp"}
  local switchPort = SwitchPort:create{id = "sp1"}
  local bindRule = BindRule:create{constituent = "audio1"}
  local media = Media:create{id = "m1"}
  local context = Context:create{id = "c1"}
  local switch2 = Switch:create{id = "s2"}

  switch1:setDefaultComponent(defaultComponent)
  switch1:removeDefaultComponent(defaultComponent)
  assert(switch1:getDescendantByAttribute("component", "comp") == nil, "Error!")

  switch1:addSwitchPort(switchPort)
  switch1:removeSwitchPort(switchPort)
  assert(switch1:getSwitchPortById("sp1") == nil, "Error!")

  switch1:addSwitchPort(switchPort)
  switch1:removeSwitchPortPos(1)
  assert(switch1:getSwitchPortById("sp1") == nil, "Error!")

  switch1:addBindRule(bindRule)
  switch1:removeBindRule(bindRule)
  assert(switch1:getDescendantByAttribute("constituent", "audio1") == nil, "Error!")

  switch1:addBindRule(bindRule)
  switch1:removeBindRulePos(1)
  assert(switch1:getDescendantByAttribute("constituent", "audio1") == nil, "Error!")

  switch1:addMedia(media)
  switch1:removeMedia(media)
  assert(switch1:getMediaById("m1") == nil, "Error!")

  switch1:addMedia(media)
  switch1:removeMediaPos(1)
  assert(switch1:getMediaById("m1") == nil, "Error!")

  switch1:addContext(context)
  switch1:removeContext(context)
  assert(switch1:getContextById("c1") == nil, "Error!")

  switch1:addContext(context)
  switch1:removeContextPos(1)
  assert(switch1:getContextById("c1") == nil, "Error!")

  switch1:addSwitch(switch2)
  switch1:removeSwitch(switch2)
  assert(switch1:getSwitchById("s2") == nil, "Error!")

  switch1:addSwitch(switch2)
  switch1:removeSwitchPos(1)
  assert(switch1:getSwitchById("s2") == nil, "Error!")
end

local function test7()
  local switch = Switch:create()
  local status, err
  local file, msg

  status, err = pcall(switch["addSwitchPort"], switch, Context:create())
  assert(not(status), "Error!")
  assert(err == "Error! Invalid switchPort element!", "Error!")

  status, err = pcall(switch["addSwitchPort"], switch, "invalid")
  assert(not(status), "Error!")
  assert(err == "Error! Invalid switchPort element!", "Error!")

  status, err = pcall(switch["addSwitchPort"], switch, nil)
  assert(not(status), "Error!")
  assert(err == "Error! Invalid switchPort element!", "Error!")

  status, err = pcall(switch["addSwitchPort"], switch, 999999)
  assert(not(status), "Error!")
  assert(err == "Error! Invalid switchPort element!", "Error!")

  status, err = pcall(switch["addSwitchPort"], switch, {})
  assert(not(status), "Error!")
  assert(err == "Error! Invalid switchPort element!", "Error!")
  
  status, err = pcall(switch["addSwitchPort"], switch, function(a, b) return a+b end)
  assert(not(status), "Error!")
  assert(err == "Error! Invalid switchPort element!", "Error!")
end

local function test8()
  local switch = Switch:create()
  local status, err

  status, err = pcall(switch["removeSwitchPort"], switch, Context:create())
  assert(not(status), "Error!")
  assert(err == "Error! Invalid switchPort element!", "Error!")

  status, err = pcall(switch["removeSwitchPortPos"], switch, 2)
  assert(not(status), "Error!")
  assert(err == "Error! switch element doesn't have a switchPort child in position 2!", "Error!")

  switch:addSwitchPort(SwitchPort:create())

  status, err = pcall(switch["removeSwitchPortPos"], switch, 2)
  assert(not(status), "Error!")
  assert(err == "Error! switch element doesn't have a switchPort child in position 2!", "Error!")
end

local function test9()
  local atts = {
    id = "s1",
    refer = "rf"
  }

  local switch = Switch:create(atts)

  local nclExp = "<switch"
  for attribute, _ in pairs(switch:getAttributesTypeMap()) do
    nclExp = nclExp.." "..attribute.."=\""..tostring(switch[attribute]).."\""
  end

  nclExp = nclExp.."/>\n"

  local nclRet = switch:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

local function test10()
  local switch1 = Switch:create{id = "s1"}
  nclExp = "<switch id=\"s1\">\n"

  local defaultComponent = DefaultComponent:create{component = "comp"}
  local nclExp = nclExp.." <defaultComponent component=\"comp\"/>\n"

  local switchPort = SwitchPort:create{id = "sp1"}
  nclExp = nclExp.." <switchPort id=\"sp1\"/>\n"

  local bindRule = BindRule:create{constituent = "audio1"}
  nclExp = nclExp.." <bindRule constituent=\"audio1\"/>\n"

  local media = Media:create{id = "m1"}
  nclExp = nclExp.." <media id=\"m1\"/>\n"

  local context = Context:create{id = "c1"}
  nclExp = nclExp.." <context id=\"c1\"/>\n"

  local switch2 = Switch:create{id = "s2"}
  nclExp = nclExp.." <switch id=\"s2\"/>\n"

  nclExp = nclExp.."</switch>\n"

  switch1:setDefaultComponent(defaultComponent)
  switch1:addSwitchPort(switchPort)
  switch1:addBindRule(bindRule)
  switch1:addMedia(media)
  switch1:addContext(context)
  switch1:addSwitch(switch2)

  nclRet = switch1:table2Ncl(0)

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
test10()