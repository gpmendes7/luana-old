local CompoundAction = require "core/connectors/CompoundAction"
local SimpleAction = require "core/connectors/SimpleAction"

local function test1()
  local compoundAction = CompoundAction:create()

  assert(compoundAction ~= nil, "Error!")
  assert(compoundAction:getOperator() == nil, "Error!")
  assert(compoundAction:getDelay() == nil, "Error!")
end

local function test2()
  local atts = {
    operator = "seq",
    delay = 10
  }

  local compoundAction = CompoundAction:create(atts)

  assert(compoundAction:getOperator() == "seq", "Error!")
  assert(compoundAction:getDelay() == 10, "Error!")
end

local function test3()
  local compoundAction = CompoundAction:create()

  compoundAction:setOperator("seq")
  compoundAction:setDelay(10)

  assert(compoundAction:getOperator() == "seq", "Error!")
  assert(compoundAction:getDelay() == 10, "Error!")
end

local function test4()
  local compoundAction = CompoundAction:create()
  local status, err

  status, err = pcall(compoundAction["setDelay"], compoundAction, nil)
  assert(not(status), "Error!")

  status, err = pcall(compoundAction["setDelay"], compoundAction, {})
  assert(not(status), "Error!")

  status, err = pcall(compoundAction["setDelay"], compoundAction, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local compoundAction = CompoundAction:create(nil, 1)

  assert(compoundAction:getSimpleActionPos(1) ~= nil, "Error!")
  assert(compoundAction:getCompoundActionPos(1) ~= nil, "Error!")

  compoundAction:addSimpleAction(SimpleAction:create())
  assert(compoundAction:getSimpleActionPos(2) ~= nil, "Error!")

  compoundAction:addCompoundAction(CompoundAction:create())
  assert(compoundAction:getCompoundActionPos(2) ~= nil, "Error!")

  compoundAction = CompoundAction:create()
  compoundAction:addSimpleAction(SimpleAction:create{role = "set"})
  assert(compoundAction:getDescendantByAttribute("role", "set") ~= nil, "Error!")

  compoundAction = CompoundAction:create()
  compoundAction:addCompoundAction(CompoundAction:create{operator = "seq"})
  assert(compoundAction:getDescendantByAttribute("operator", "seq") ~= nil, "Error!")
end

local function test6()
  local compoundAction1 = CompoundAction:create{operator = "seq"}
  local simpleAction = SimpleAction:create{role = "set"}
  local compoundAction2 = CompoundAction:create{operator = "par"}

  compoundAction1:addSimpleAction(simpleAction)
  assert(compoundAction1:getDescendantByAttribute("role", "set") ~= nil, "Error!")

  compoundAction1:removeSimpleAction(simpleAction)
  assert(compoundAction1:getDescendantByAttribute("role", "set") == nil, "Error!")

  compoundAction1:addSimpleAction(simpleAction)
  compoundAction1:removeSimpleActionPos(1)
  assert(compoundAction1:getDescendantByAttribute("role", "set") == nil, "Error!")

  compoundAction1:addCompoundAction(compoundAction2)
  assert(compoundAction1:getDescendantByAttribute("operator", "par") ~= nil, "Error!")

  compoundAction1:removeCompoundAction(compoundAction2)
  assert(compoundAction1:getDescendantByAttribute("operator", "par") == nil, "Error!")

  compoundAction1:addCompoundAction(compoundAction2)
  compoundAction1:removeCompoundActionPos(1)
  assert(compoundAction1:getDescendantByAttribute("operator", "par") == nil, "Error!")
end

local function test7()
  local compoundAction = CompoundAction:create()
  local status, err
    
  status, err = pcall(compoundAction["addSimpleAction"], compoundAction, CompoundAction:create())
  assert(not(status), "Error!")
  
  status, err = pcall(compoundAction["addSimpleAction"], compoundAction, "invalid")
  assert(not(status), "Error!")

  status, err = pcall(compoundAction["addSimpleAction"], compoundAction, nil)
  assert(not(status), "Error!")

  status, err = pcall(compoundAction["addSimpleAction"], compoundAction, 999999)
  assert(not(status), "Error!")

  status, err = pcall(compoundAction["addSimpleAction"], compoundAction, {})
  assert(not(status), "Error!")

  status, err = pcall(compoundAction["addSimpleAction"], compoundAction, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test8()
  local atts = {
    operator = "seq",
    delay = 10
  }

  local compoundAction = CompoundAction:create(atts)
  
  compoundAction:addSymbol("delay", "s")

  local nclExp = "<compoundAction"
  for attribute, typeAtt in pairs(compoundAction:getAttributesTypeMap()) do
    if(compoundAction:getSymbols() ~= nil and compoundAction:getSymbol(attribute) ~= nil)then
      nclExp = nclExp.." "..attribute.."=\""..compoundAction[attribute]..compoundAction:getSymbol(attribute).."\""
    else
      nclExp = nclExp.." "..attribute.."=\""..tostring(compoundAction[attribute]).."\""
    end
  end

  local nclExp = nclExp.."/>\n"

  local nclRet = compoundAction:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

local function test9()
  local compoundAction1 = CompoundAction:create{["operator"] = "seq"}
  local nclExp = "<compoundAction operator=\"seq\">\n"

  local simpleAction = SimpleAction:create{["role"] = "set"}
  nclExp = nclExp.." <simpleAction role=\"set\"/>\n"

  local compoundAction2 = CompoundAction:create{["operator"] = "par"}
  nclExp = nclExp.." <compoundAction operator=\"par\"/>\n"

  nclExp = nclExp.."</compoundAction>\n"

  compoundAction1:addSimpleAction(simpleAction)
  compoundAction1:addCompoundAction(compoundAction2)

  local nclRet = compoundAction1:table2Ncl(0)

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