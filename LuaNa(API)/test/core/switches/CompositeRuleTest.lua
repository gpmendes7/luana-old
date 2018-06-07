local CompositeRule = require "core/switches/CompositeRule"
local Rule = require "core/switches/Rule"

local function test1()
  local compositeRule = CompositeRule:create()

  assert(compositeRule ~= nil, "Error!")
  assert(compositeRule:getId() == nil, "Error!")
  assert(compositeRule:getOperator() == nil, "Error!")
end

local function test2()
  local atts = {
    id = "cr1",
    operator = "and"
  }

  local compositeRule = CompositeRule:create(atts)

  assert(compositeRule:getId() == "cr1", "Error!")
  assert(compositeRule:getOperator() == "and", "Error!")
end

local function test3()
  local compositeRule = CompositeRule:create()

  compositeRule:setId("cr1")
  compositeRule:setOperator("and")

  assert(compositeRule:getId() == "cr1", "Error!")
  assert(compositeRule:getOperator() == "and", "Error!")
end

local function test4()
  local compositeRule = CompositeRule:create()
  local status, err

  status, err = pcall(compositeRule["setId"], compositeRule, nil)
  assert(not(status), "Error!")

  status, err = pcall(compositeRule["setId"], compositeRule, 999999)
  assert(not(status), "Error!")

  status, err = pcall(compositeRule["setId"], compositeRule, {})
  assert(not(status), "Error!")

  status, err = pcall(compositeRule["setId"], compositeRule, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local compositeRule

  compositeRule = CompositeRule:create(nil, 1)
  assert(compositeRule:getRulePos(1) ~= nil, "Error!")
  assert(compositeRule:getCompositeRulePos(1) ~= nil, "Error!")

  compositeRule:addRule(Rule:create())
  assert(compositeRule:getRulePos(2) ~= nil, "Error!")

  compositeRule:addCompositeRule(CompositeRule:create())
  assert(compositeRule:getCompositeRulePos(2) ~= nil, "Error!")

  compositeRule = CompositeRule:create()
  compositeRule:addRule(Rule:create{id = "r1"})
  assert(compositeRule:getDescendantByAttribute("id", "r1") ~= nil, "Error!")

  compositeRule = compositeRule:create()
  compositeRule:addCompositeRule(CompositeRule:create{id = "cr1"})
  assert(compositeRule:getDescendantByAttribute("id", "cr1") ~= nil, "Error!")
end

local function test6()
  local compositeRule1 = CompositeRule:create{id = "cr1"}
  local rule = Rule:create{id = "r1"}
  local compositeRule2 = CompositeRule:create{id = "cr2"}

  compositeRule1:addRule(rule)
  assert(compositeRule1:getDescendantByAttribute("id", "r1") ~= nil, "Error!")

  compositeRule1:removeRule(rule)
  assert(compositeRule1:getDescendantByAttribute("id", "r1") == nil, "Error!")

  compositeRule1:addRule(rule)
  compositeRule1:removeRulePos(1)
  assert(compositeRule1:getDescendantByAttribute("id", "r1") == nil, "Error!")

  compositeRule1:addCompositeRule(compositeRule2)
  assert(compositeRule1:getDescendantByAttribute("id", "cr2") ~= nil, "Error!")

  compositeRule1:removeCompositeRule(compositeRule2)
  assert(compositeRule1:getDescendantByAttribute("id", "cr2") == nil, "Error!")

  compositeRule1:addCompositeRule(compositeRule2)
  compositeRule1:removeCompositeRulePos(1)
  assert(compositeRule1:getDescendantByAttribute("id", "cr2") == nil, "Error!")
end

local function test7()
  local compositeRule = CompositeRule:create()
  local status, err

  status, err = pcall(compositeRule["removeRule"], compositeRule, CompositeRule:create())
  assert(not(status), "Error!")

  status, err = pcall(compositeRule["removeRule"], compositeRule, "invalid")
  assert(not(status), "Error!")

  status, err = pcall(compositeRule["removeRule"], compositeRule, nil)
  assert(not(status), "Error!")

  status, err = pcall(compositeRule["removeRule"], compositeRule, 999999)
  assert(not(status), "Error!")

  status, err = pcall(compositeRule["removeRule"], compositeRule, {})
  assert(not(status), "Error!")

  status, err = pcall(compositeRule["removeRule"], compositeRule, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test8()
  local atts = {
    id = "cr1",
    operator = "and"
  }

  local compositeRule = CompositeRule:create(atts)

  local nclExp = "<compositeRule"
  for attribute, _ in pairs(compositeRule:getAttributesTypeMap()) do
    nclExp = nclExp.." "..attribute.."=\""..tostring(compositeRule[attribute]).."\""
  end

  nclExp = nclExp.."/>\n"

  local nclRet = compositeRule:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

local function test9()
  local compositeRule1 = CompositeRule:create{id = "cr1"}
  local nclExp = "<compositeRule id=\"cr1\">\n"

  local rule = Rule:create{id = "r1"}
  nclExp = nclExp.." <rule id=\"r1\"/>\n"

  local compositeRule2 = CompositeRule:create{id = "cr2"}
  nclExp = nclExp.." <compositeRule id=\"cr2\"/>\n"

  nclExp = nclExp.."</compositeRule>\n"

  compositeRule1:addRule(rule)
  compositeRule1:addCompositeRule(compositeRule2)

  local nclRet = compositeRule1:table2Ncl(0)

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