local BindRule = require "core/switches/BindRule"

local function test1()
  local bindRule = BindRule:create()

  assert(bindRule ~= nil, "Error!")
  assert(bindRule:getConstituent() == nil, "Error!")
  assert(bindRule:getRule() == nil, "Error!")
end

local function test2()
  local atts = {
    constituent = "audio1",
    rule = "rPt"
  }

  local bindRule = BindRule:create(atts)

  assert(bindRule:getConstituent() == "audio1", "Error!")
  assert(bindRule:getRule() == "rPt", "Error!")
end

local function test3()
  local bindRule = BindRule:create()

  bindRule:setConstituent("audio1")
  bindRule:setRule("rPt")

  assert(bindRule:getConstituent() == "audio1", "Error!")
  assert(bindRule:getRule() == "rPt", "Error!")
end

local function test4()
  local bindRule = BindRule:create()
  local status, err

  status, err = pcall(bindRule["setConstituent"], bindRule, nil)
  assert(not(status), "Error!")

  status, err = pcall(bindRule["setConstituent"], bindRule, 999999)
  assert(not(status), "Error!")

  status, err = pcall(bindRule["setConstituent"], bindRule, {})
  assert(not(status), "Error!")

  status, err = pcall(bindRule["setConstituent"], bindRule, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local atts = {
    constituent = "audio1",
    rule = "rPt"
  }

  local bindRule = BindRule:create(atts)

  local nclExp = "<bindRule"
  for attribute, _ in pairs(bindRule:getAttributesTypeMap()) do
    nclExp = nclExp.." "..attribute.."=\""..tostring(bindRule[attribute]).."\""
  end

  nclExp = nclExp.."/>\n"

  local nclRet = bindRule:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()