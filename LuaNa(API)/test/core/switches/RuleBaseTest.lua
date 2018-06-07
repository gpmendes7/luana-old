local RuleBase = require "core/switches/RuleBase"
local ImportBase = require "core/importation/ImportBase"
local Rule = require "core/switches/Rule"
local CompositeRule = require "core/switches/CompositeRule"

local function test1()
  local ruleBase = RuleBase:create()

  assert(ruleBase ~= nil, "Error!")
  assert(ruleBase:getId() == nil, "Error!")
end

local function test2()
  local atts = {
    id = "rb1"
  }

  local ruleBase = RuleBase:create(atts)

  assert(ruleBase:getId() == "rb1", "Error!")
end

local function test3()
  local ruleBase = RuleBase:create()

  ruleBase:setId("rb1")

  assert(ruleBase:getId() == "rb1", "Error!")
end

local function test4()
  local ruleBase = RuleBase:create()
  local status, err

  status, err = pcall(ruleBase["setId"], ruleBase, nil)
  assert(not(status), "Error!")

  status, err = pcall(ruleBase["setId"], ruleBase, {})
  assert(not(status), "Error!")

  status, err = pcall(ruleBase["setId"], ruleBase, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local ruleBase

  ruleBase = RuleBase:create(nil, 1)
  assert(ruleBase:getImportBasePos(1) ~= nil, "Error!")
  assert(ruleBase:getRulePos(1) ~= nil, "Error!")
  assert(ruleBase:getCompositeRulePos(1) ~= nil, "Error!")

  ruleBase:addImportBase(ImportBase:create())
  assert(ruleBase:getImportBasePos(2) ~= nil, "Error!")

  ruleBase:addRule(Rule:create())
  assert(ruleBase:getRulePos(2) ~= nil, "Error!")

  ruleBase:addCompositeRule(CompositeRule:create())
  assert(ruleBase:getCompositeRulePos(2) ~= nil, "Error!")

  ruleBase = RuleBase:create()
  ruleBase:addImportBase(ImportBase:create{alias = "connBase"})
  assert(ruleBase:getDescendantByAttribute("alias", "connBase") ~= nil, "Error!")

  ruleBase = RuleBase:create()
  ruleBase:addRule(Rule:create{id = "r1"})
  assert(ruleBase:getDescendantByAttribute("id", "r1") ~= nil, "Error!")

  ruleBase = RuleBase:create()
  ruleBase:addCompositeRule(CompositeRule:create{id = "cr1"})
  assert(ruleBase:getDescendantByAttribute("id", "cr1") ~= nil, "Error!")
end

local function test6()
  local ruleBase = RuleBase:create{id = "rb1"}
  local importBase = ImportBase:create{alias = "connBase"}
  local rule = Rule:create{id = "r1"}
  local compositeRule = CompositeRule:create{id = "cr1"}

  ruleBase:addImportBase(importBase)
  assert(ruleBase:getDescendantByAttribute("alias", "connBase") ~= nil, "Error!")

  ruleBase:removeImportBase(importBase)
  assert(ruleBase:getDescendantByAttribute("alias", "connBase") == nil, "Error!")

  ruleBase:addImportBase(importBase)
  ruleBase:removeImportBasePos(1)
  assert(ruleBase:getDescendantByAttribute("alias", "connBase") == nil, "Error!")

  ruleBase:addRule(rule)
  assert(ruleBase:getDescendantByAttribute("id", "r1") ~= nil, "Error!")

  ruleBase:removeRule(rule)
  assert(ruleBase:getDescendantByAttribute("id", "r1") == nil, "Error!")

  ruleBase:addRule(rule)
  ruleBase:removeRulePos(1)
  assert(ruleBase:getDescendantByAttribute("id", "r1") == nil, "Error!")

  ruleBase:addCompositeRule(compositeRule)
  assert(ruleBase:getDescendantByAttribute("id", "cr1") ~= nil, "Error!")

  ruleBase:removeCompositeRule(compositeRule)
  assert(ruleBase:getDescendantByAttribute("id", "cr1") == nil, "Error!")

  ruleBase:addCompositeRule(compositeRule)
  ruleBase:removeCompositeRulePos(1)
  assert(ruleBase:getDescendantByAttribute("id", "cr1") == nil, "Error!")
end

local function test7()
  local ruleBase = RuleBase:create()
  local status, err

  status, err = pcall(ruleBase["addRule"], ruleBase, CompositeRule:create())
  assert(not(status), "Error!")

  status, err = pcall(ruleBase["addRule"], ruleBase, "invalid")
  assert(not(status), "Error!")

  status, err = pcall(ruleBase["addRule"], ruleBase, nil)
  assert(not(status), "Error!")

  status, err = pcall(ruleBase["addRule"], ruleBase, {})
  assert(not(status), "Error!")

  status, err = pcall(ruleBase["addRule"], ruleBase, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test8()
  local atts = {
    id = "rb1"
  }

  local ruleBase = RuleBase:create(atts)

  local nclExp = "<ruleBase"
  for attribute, _ in pairs(ruleBase:getAttributesTypeMap()) do
    nclExp = nclExp.." "..attribute.."=\""..tostring(ruleBase[attribute]).."\""
  end

  nclExp = nclExp.."/>\n"

  local nclRet = ruleBase:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

local function test9()
  local ruleBase = RuleBase:create{id = "rb1"}
  local nclExp = "<ruleBase id=\"rb1\">\n"

  local importBase = ImportBase:create{alias = "connBase"}
  nclExp = nclExp.." <importBase alias=\"connBase\"/>\n"

  local rule = Rule:create{id = "r1"}
  nclExp = nclExp.." <rule id=\"r1\"/>\n"

  local compositeRule = CompositeRule:create{id = "cr1"}
  nclExp = nclExp.." <compositeRule id=\"cr1\"/>\n"

  nclExp = nclExp.."</ruleBase>\n"

  ruleBase:addImportBase(importBase)
  ruleBase:addRule(rule)
  ruleBase:addCompositeRule(compositeRule)

  local nclRet = ruleBase:table2Ncl(0)

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