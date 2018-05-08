local CausalConnector = require "core/connectors/CausalConnector"
local ConnectorParam = require "core/connectors/ConnectorParam"
local SimpleCondition = require "core/connectors/SimpleCondition"
local CompoundCondition = require "core/connectors/CompoundCondition"
local SimpleAction = require "core/connectors/SimpleAction"
local CompoundAction = require "core/connectors/CompoundAction"

local function test1()
  local causalConnector = CausalConnector:create()

  assert(causalConnector ~= nil, "Error!")
  assert(causalConnector:getId() == nil, "Error!")
end

local function test2()
  local atts = {
    id = "cc"
  }

  local causalConnector = CausalConnector:create(atts)

  assert(causalConnector:getId() == "cc", "Error!")
end

local function test3()
  local causalConnector = CausalConnector:create()
  
  causalConnector:setId("cc")

  assert(causalConnector:getId() == "cc", "Error!")
end

local function test4()
  local causalConnector = CausalConnector:create()
  local status, err

  status, err = pcall(causalConnector["setKey"], CausalConnector, nil)
  assert(not(status), "Error!")

  status, err = pcall(causalConnector["setKey"], CausalConnector, 999999)
  assert(not(status), "Error!")

  status, err = pcall(causalConnector["setKey"], CausalConnector, {})
  assert(not(status), "Error!")

  status, err = pcall(causalConnector["setKey"], CausalConnector, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local causalConnector

  causalConnector = CausalConnector:create(nil, 1)
  assert(causalConnector:getConnectorParamPos(1) ~= nil, "Error!")
  assert(causalConnector:getCompoundCondition() ~= nil, "Error!")
  assert(causalConnector:getCompoundAction() ~= nil, "Error!")

  causalConnector:addConnectorParam(ConnectorParam:create())
  assert(causalConnector:getConnectorParamPos(2) ~= nil, "Error!")

  causalConnector = CausalConnector:create()
  causalConnector:setSimpleCondition(SimpleCondition:create())
  assert(causalConnector:getSimpleCondition() ~= nil, "Error!")

  causalConnector = CausalConnector:create()
  causalConnector:setSimpleAction(SimpleAction:create())
  assert(causalConnector:getSimpleAction() ~= nil, "Error!")
end

local function test6()
  local causalConnector = CausalConnector:create{id = "cc"}
  local connectorParam = ConnectorParam:create{name = "var"}
  local simpleCondition = SimpleCondition:create{role = "onSelection"}
  local compoundCondition = CompoundCondition:create{operator = "and"}
  local simpleAction = SimpleAction:create{role = "set"}
  local compoundAction = CompoundAction:create{operator = "par"}

  causalConnector:addConnectorParam(connectorParam)
  assert(causalConnector:getDescendantByAttribute("name", "var") ~= nil, "Error!")

  causalConnector:removeConnectorParam(connectorParam)
  assert(causalConnector:getDescendantByAttribute("name", "var") == nil, "Error!")

  causalConnector:addConnectorParam(connectorParam)
  causalConnector:removeConnectorParamPos(1)
  assert(causalConnector:getDescendantByAttribute("name", "var") == nil, "Error!")

  causalConnector:setSimpleCondition(simpleCondition)
  assert(causalConnector:getDescendantByAttribute("role", "onSelection") ~= nil, "Error!")

  causalConnector:removeSimpleCondition(simpleCondition)
  assert(causalConnector:getDescendantByAttribute("role", "onSelection") == nil, "Error!")

  causalConnector:setCompoundCondition(compoundCondition)
  assert(causalConnector:getDescendantByAttribute("operator", "and") ~= nil, "Error!")

  causalConnector:removeCompoundCondition(compoundCondition)
  assert(causalConnector:getDescendantByAttribute("operator", "and") == nil, "Error!")

  causalConnector:setSimpleAction(simpleAction)
  assert(causalConnector:getDescendantByAttribute("role", "set") ~= nil, "Error!")

  causalConnector:removeSimpleAction(simpleAction)
  assert(causalConnector:getDescendantByAttribute("role", "set") == nil, "Error!")

  causalConnector:setCompoundAction(compoundAction)
  assert(causalConnector:getDescendantByAttribute("operator", "par") ~= nil, "Error!")

  causalConnector:removeCompoundAction(compoundAction)
  assert(causalConnector:getDescendantByAttribute("operator", "par") == nil, "Error!")
end

local function test7()
  local atts = {
    id = "cc"
  }

  local causalConnector = CausalConnector:create(atts)

  local nclExp = "<causalConnector"
  for attribute, _ in pairs(causalConnector:getAttributesTypeMap()) do
    if(causalConnector.symbols ~= nil and causalConnector.symbols[attribute] ~= nil)then
      nclExp = nclExp.." "..attribute.."=\""..causalConnector[attribute]..causalConnector.symbols[attribute].."\""
    else
      nclExp = nclExp.." "..attribute.."=\""..tostring(causalConnector[attribute]).."\""
    end
  end

  nclExp = nclExp.."/>\n"

  local nclRet = causalConnector:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

local function test7()
  local causalConnector
  local connectorParam
  local simpleCondition, compoundCondition
  local simpleAction, compoundAction
  local nclExp, nclRet

  causalConnector = CausalConnector:create{id = "cc"}
  nclExp = "<causalConnector id=\"cc\">\n"

  connectorParam = ConnectorParam:create{name = "var"}
  nclExp = nclExp.." <connectorParam name=\"var\"/>\n"

  simpleAction = SimpleAction:create{role = "set"}
  nclExp = nclExp.." <simpleAction role=\"set\"/>\n"

  simpleCondition = SimpleCondition:create{role = "onSelection"}
  nclExp = nclExp.." <simpleCondition role=\"onSelection\"/>\n"

  nclExp = nclExp.."</causalConnector>\n"

  causalConnector:addConnectorParam(connectorParam)
  causalConnector:setSimpleCondition(simpleCondition)
  causalConnector:setSimpleAction(simpleAction)

  nclRet = causalConnector:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")

  nclExp = nil

  causalConnector = CausalConnector:create{id = "cc"}
  nclExp = "<causalConnector id=\"cc\">\n"

  connectorParam = ConnectorParam:create{name = "var"}
  nclExp = nclExp.." <connectorParam name=\"var\"/>\n"

  compoundAction = CompoundAction:create{operator = "par"}
  nclExp = nclExp.." <compoundAction operator=\"par\"/>\n"

  compoundCondition = CompoundCondition:create{operator = "and"}
  nclExp = nclExp.." <compoundCondition operator=\"and\"/>\n"

  nclExp = nclExp.."</causalConnector>\n"

  causalConnector:addConnectorParam(connectorParam)
  causalConnector:setCompoundCondition(compoundCondition)
  causalConnector:setCompoundAction(compoundAction)

  nclRet = causalConnector:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()
test7()