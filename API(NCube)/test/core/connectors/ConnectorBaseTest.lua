local ConnectorBase = require "core/connectors/ConnectorBase"
local ImportBase = require "core/importation/ImportBase"
local CausalConnector = require "core/connectors/CausalConnector"

local function test1()
  local connectorBase = ConnectorBase:create()

  assert(connectorBase ~= nil, "Error!")
  assert(connectorBase:getId() == nil, "Error!")
end

local function test2()
  local atts = {
    id = "cb"
  }

  local connectorBase = ConnectorBase:create(atts)
  
  assert(connectorBase:getId() == "cb", "Error!")
end

local function test3()
  local connectorBase = ConnectorBase:create()

  connectorBase:setId("cb")

  assert(connectorBase:getId() == "cb", "Error!")
end

local function test4()
  local connectorBase = ConnectorBase:create()
  local status, err

  status, err = pcall(connectorBase["setId"], ConnectorBase, nil)
  assert(not(status), "Error!")

  status, err = pcall(connectorBase["setId"], ConnectorBase, 999999)
  assert(not(status), "Error!")

  status, err = pcall(connectorBase["setId"], ConnectorBase, {})
  assert(not(status), "Error!")

  status, err = pcall(connectorBase["setId"], ConnectorBase, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local connectorBase

  connectorBase = ConnectorBase:create(nil, 1)
  assert(connectorBase:getImportBasePos(1) ~= nil, "Error!")
  assert(connectorBase:getCausalConnectorPos(1) ~= nil, "Error!")

  connectorBase:addImportBase(ImportBase:create())
  assert(connectorBase:getImportBasePos(2) ~= nil, "Error!")

  connectorBase:addCausalConnector(CausalConnector:create())
  assert(connectorBase:getCausalConnectorPos(2) ~= nil, "Error!")
end

local function test6()
  local connectorBase = ConnectorBase:create{id = "cb"}
  local importBase = ImportBase:create{alias = "ib"}
  local causalConnector = CausalConnector:create{id = "cc"}

  connectorBase:addImportBase(importBase)
  assert(connectorBase:getDescendantByAttribute("alias", "ib") ~= nil, "Error!")

  connectorBase:removeImportBase(importBase)
  assert(connectorBase:getDescendantByAttribute("alias", "ib") == nil, "Error!")

  connectorBase:addImportBase(importBase)
  connectorBase:removeImportBasePos(1)
  assert(connectorBase:getDescendantByAttribute("alias", "ib") == nil, "Error!")
end

local function test7()
  local connectorBase = ConnectorBase:create()
  local status, err
    
  status, err = pcall(connectorBase["removeImportBase"], connectorBase, CausalConnector:create())
  assert(not(status), "Error!")
  
  status, err = pcall(connectorBase["removeImportBase"], connectorBase, "invalid")
  assert(not(status), "Error!")

  status, err = pcall(connectorBase["removeImportBase"], connectorBase, nil)
  assert(not(status), "Error!")

  status, err = pcall(connectorBase["removeImportBase"], connectorBase, 999999)
  assert(not(status), "Error!")

  status, err = pcall(connectorBase["removeImportBase"], connectorBase, {})
  assert(not(status), "Error!")

  status, err = pcall(connectorBase["removeImportBase"], connectorBase, function(a, b) return a+b end)
  assert(not(status), "Error!")
end


local function test8()
  local atts = {
    id = "cb"
  }

  local connectorBase = ConnectorBase:create(atts)

  local nclExp = "<connectorBase id=\"cb\"/>\n"

  local nclRet = connectorBase:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

local function test9()
  local connectorBase = ConnectorBase:create{id = "cb"}
  local nclExp = "<connectorBase id=\"cb\">\n"

  local importBase = ImportBase:create{alias = "ib"}
  nclExp = nclExp.." <importBase alias=\"ib\"/>\n"

  local causalConnector = CausalConnector:create{id = "cc"}
  nclExp = nclExp.." <causalConnector id=\"cc\"/>\n"

  nclExp = nclExp.."</connectorBase>\n"

  connectorBase:addImportBase(importBase)
  connectorBase:addCausalConnector(causalConnector)

  local nclRet = connectorBase:table2Ncl(0)

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