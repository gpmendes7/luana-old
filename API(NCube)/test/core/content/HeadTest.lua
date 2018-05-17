local Head = require "core/content/Head"
local ImportedDocumentBase = require "core/importation/ImportedDocumentBase"
local RuleBase = require "core/switches/RuleBase"
local TransitionBase = require "core/transition/TransitionBase"
local RegionBase = require "core/layout/RegionBase"
local DescriptorBase = require "core/layout/DescriptorBase"
local ConnectorBase = require "core/connectors/ConnectorBase"
local Meta = require "core/metadata/Meta"
local MetaData = require "core/metadata/MetaData"

local function test1()
  local head = Head:create()

  assert(head ~= nil, "Error!")
end

local function test2()
  local head

  head = Head:create(1)
  assert(head:getImportedDocumentBase() ~= nil, "Error!")
  assert(head:getRuleBase() ~= nil, "Error!")
  assert(head:getTransitionBase() ~= nil, "Error!")
  assert(head:getRegionBasePos(1) ~= nil, "Error!")
  assert(head:getDescriptorBase() ~= nil, "Error!")
  assert(head:getConnectorBase() ~= nil, "Error!")
  assert(head:getMetaPos(1) ~= nil, "Error!")
  assert(head:getMetaDataPos(1) ~= nil, "Error!")

  head:addRegionBase(RegionBase:create())
  assert(head:getRegionBasePos(2) ~= nil, "Error!")

  head:addMeta(Meta:create())
  assert(head:getMetaPos(2) ~= nil, "Error!")

  head:addMetaData(MetaData:create())
  assert(head:getMetaDataPos(2) ~= nil, "Error!")

  head:setImportedDocumentBase(ImportedDocumentBase:create{id = "importedDocumentBase1"})
  assert(head:getDescendantByAttribute("id", "importedDocumentBase1") ~= nil, "Error!")

  head:setRuleBase(RuleBase:create{id = "rb1"})
  assert(head:getDescendantByAttribute("id", "rb1") ~= nil, "Error!")

  head:setTransitionBase(TransitionBase:create{id = "t1"})
  assert(head:getDescendantByAttribute("id", "t1") ~= nil, "Error!")

  head:addRegionBase(RegionBase:create{id = "rgb1"})
  assert(head:getDescendantByAttribute("id", "rgb1") ~= nil, "Error!")

  head:setDescriptorBase(DescriptorBase:create{id = "db1"})
  assert(head:getDescendantByAttribute("id", "db1") ~= nil, "Error!")

  head:setConnectorBase(ConnectorBase:create{id = "cb1"})
  assert(head:getDescendantByAttribute("id", "cb1") ~= nil, "Error!")

  head:addMeta(Meta:create{name = "mt"})
  assert(head:getDescendantByAttribute("name", "mt") ~= nil, "Error!")
end

local function test3()
  local head = Head:create()
  local importedDocumentBase = ImportedDocumentBase:create{id = "i1"}
  local ruleBase = RuleBase:create{id = "rb1"}
  local transitionBase = TransitionBase:create{id = "t1"}
  local regionBase = RegionBase:create{id = "rgb1"}
  local descriptorBase = DescriptorBase:create{id = "db1"}
  local connectorBase = ConnectorBase:create{id = "cb1"}
  local meta = Meta:create{name = "mt"}
  local metadata = MetaData:create()

  head:setImportedDocumentBase(importedDocumentBase)
  head:removeImportedDocumentBase(importedDocumentBase)
  assert(head:getDescendantByAttribute("id", "i1") == nil, "Error!")

  head:setRuleBase(ruleBase)
  head:removeRuleBase(ruleBase)
  assert(head:getDescendantByAttribute("id", "rb1") == nil, "Error!")

  head:setTransitionBase(transitionBase)
  head:removeTransitionBase(transitionBase)
  assert(head:getDescendantByAttribute("id", "t1") == nil, "Error!")

  head:addRegionBase(regionBase)
  head:removeRegionBase(regionBase)
  assert(head:getDescendantByAttribute("id", "rb1") == nil, "Error!")

  head:addRegionBase(regionBase)
  head:removeRegionBasePos(1)
  assert(head:getDescendantByAttribute("id", "rb1") == nil, "Error!")

  head:setDescriptorBase(descriptorBase)
  head:removeDescriptorBase(descriptorBase)
  assert(head:getDescendantByAttribute("id", "db1") == nil, "Error!")

  head:setConnectorBase(connectorBase)
  head:removeConnectorBase(connectorBase)
  assert(head:getDescendantByAttribute("id", "cb1") == nil, "Error!")

  head:addMeta(meta)
  head:removeMeta(meta)
  assert(#head.metas == 0, "Error!")

  head:addMeta(meta)
  head:removeMetaPos(1)
  assert(#head.metas == 0, "Error!")

  head:addMetaData(metadata)
  head:removeMetaData(metadata)
  assert(#head.metadatas == 0, "Error!")

  head:addMetaData(metadata)
  head:removeMetaDataPos(1)
  assert(#head.metadatas == 0, "Error!")
end

local function test4()
  local head = Head:create()
  local status, err
  local file, msg

  status, err = pcall(head["setConnectorBase"], head, DescriptorBase:create())
  assert(not(status), "Error!")
  assert(err == "Error! Invalid connectorBase element!", "Error!")

  status, err = pcall(head["setConnectorBase"], head, "invalid")
  assert(not(status), "Error!")
  assert(err == "Error! Invalid connectorBase element!", "Error!")

  status, err = pcall(head["setConnectorBase"], head, nil)
  assert(not(status), "Error!")
  assert(err == "Error! Invalid connectorBase element!", "Error!")

  status, err = pcall(head["setConnectorBase"], head, {})
  assert(not(status), "Error!")
  assert(err == "Error! Invalid connectorBase element!", "Error!")
    
  status, err = pcall(head["setConnectorBase"], head, function(a, b) return a+b end)
  assert(not(status), "Error!")
  assert(err == "Error! Invalid connectorBase element!", "Error!")
end

local function test5()
  local head = Head:create()
  local nclExp = "<head>\n"

  local importedDocumentBase = ImportedDocumentBase:create{id = "i1"}
  nclExp = nclExp.." <importedDocumentBase id=\"i1\"/>\n"

  local ruleBase = RuleBase:create{id = "rb1"}
  nclExp = nclExp.." <ruleBase id=\"rb1\"/>\n"

  local transitionBase = TransitionBase:create{id = "t1"}
  nclExp = nclExp.." <transitionBase id=\"t1\"/>\n"

  local regionBase = RegionBase:create{id = "rgb1"}
  nclExp = nclExp.." <regionBase id=\"rgb1\"/>\n"

  local descriptorBase = DescriptorBase:create{id = "db1"}
  nclExp = nclExp.." <descriptorBase id=\"db1\"/>\n"

  local connectorBase = ConnectorBase:create{id = "cb1"}
  nclExp = nclExp.." <connectorBase id=\"cb1\"/>\n"

  local meta = Meta:create{name = "mt"}
  nclExp = nclExp.." <meta name=\"mt\"/>\n"

  local metadata = MetaData:create()
  nclExp = nclExp.." <metadata>\n </metadata>\n"

  nclExp = nclExp.."</head>\n"

  head:setImportedDocumentBase(importedDocumentBase)
  head:setRuleBase(ruleBase)
  head:setTransitionBase(transitionBase)
  head:addRegionBase(regionBase)
  head:setDescriptorBase(descriptorBase)
  head:setConnectorBase(connectorBase)
  head:addMeta(meta)
  head:addMetaData(metadata)
 
  local nclRet = head:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()