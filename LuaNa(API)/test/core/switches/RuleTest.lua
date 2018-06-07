local Rule = require "core/switches/Rule"

local function test1()
  local rule = Rule:create()

  assert(rule ~= nil, "Error!")
  assert(rule:getId() == nil, "Error!")
  assert(rule:getVar() == nil, "Error!")
  assert(rule:getComparator() == nil, "Error!")
  assert(rule:getValue() == nil, "Error!")
end

local function test2()
  local atts = {
    id = "r1",
    var = "idioma",
    comparator = "eq",
    value = "pt"
  }

  local rule = Rule:create(atts)

  assert(rule:getId() == "r1", "Error!")
  assert(rule:getVar() == "idioma", "Error!")
  assert(rule:getComparator() == "eq", "Error!")
  assert(rule:getValue() == "pt", "Error!")
end

local function test3()
  local rule = Rule:create()

  rule:setId("r1")
  rule:setVar("idioma")
  rule:setComparator("eq")
  rule:setValue("pt")

  assert(rule:getId() == "r1", "Error!")
  assert(rule:getVar() == "idioma", "Error!")
  assert(rule:getComparator() == "eq", "Error!")
  assert(rule:getValue() == "pt", "Error!")
end

local function test4()
  local rule = Rule:create()
  local status, err

  status, err = pcall(rule["setId"], rule, nil)
  assert(not(status), "Error!")

  status, err = pcall(rule["setId"], rule, {})
  assert(not(status), "Error!")

  status, err = pcall(rule["setId"], rule, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local atts = {
    id = "r1",
    var = "idioma",
    comparator = "eq",
    value = "pt"
  }

  local rule = Rule:create(atts)

  local nclExp = "<rule"
  for attribute, _ in pairs(rule:getAttributesTypeMap()) do
    nclExp = nclExp.." "..attribute.."=\""..tostring(rule[attribute]).."\""
  end

  nclExp = nclExp.."/>\n"

  local nclRet = rule:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()