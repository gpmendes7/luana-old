local ImportBase = require "core/importation/ImportBase"

local function test1()
  local importBase = ImportBase:create()

  assert(importBase ~= nil, "Error!")
  assert(importBase:getAlias() == nil, "Error!")
  assert(importBase:getDocumentURI() == nil, "Error!")
  assert(importBase:getRegion() == nil, "Error!")
  assert(importBase:getBaseId() == nil, "Error!")
end

local function test2()
  local importBase = nil

  local atts = {
    alias = "connBase",
    documentURI = "connBase.ncl",
    region = "region",
    baseId = "bc"
  }

  local importBase = ImportBase:create(atts)

  assert(importBase:getAlias() == "connBase", "Error!")
  assert(importBase:getDocumentURI() == "connBase.ncl", "Error!")
  assert(importBase:getRegion() == "region", "Error!")
  assert(importBase:getBaseId() == "bc", "Error!")
end

local function test3()
  local importBase = ImportBase:create()

  importBase:setAlias("connBase")
  importBase:setDocumentURI("connBase.ncl")
  importBase:setRegion("region")
  importBase:setBaseId("bc")

  assert(importBase:getAlias() == "connBase", "Error!")
  assert(importBase:getDocumentURI() == "connBase.ncl", "Error!")
  assert(importBase:getRegion() == "region", "Error!")
  assert(importBase:getBaseId() == "bc", "Error!")
end

local function test4()
  local importBase = ImportBase:create()
  local status, err

  status, err = pcall(importBase["setAlias"], ImportBase, nil)
  assert(not(status), "Error!")

  status, err = pcall(importBase["setAlias"], ImportBase, 999999)
  assert(not(status), "Error!")

  status, err = pcall(importBase["setAlias"], ImportBase, {})
  assert(not(status), "Error!")

  status, err = pcall(importBase["setAlias"], ImportBase, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local atts = {
    alias = "connBase",
    documentURI = "connBase.ncl",
    region = "region",
    baseId = "bc"
  }

  local importBase = ImportBase:create(atts)

  local nclExp = "<importBase"
  for attribute, _ in pairs(importBase:getAttributesTypeMap()) do
    if(importBase.symbols ~= nil and importBase.symbols[attribute] ~= nil)then
      nclExp = nclExp.." "..attribute.."=\""..importBase[attribute]..importBase.symbols[attribute].."\""
    else
      nclExp = nclExp.." "..attribute.."=\""..tostring(importBase[attribute]).."\""
    end
  end

  nclExp = nclExp.."/>\n"

  local nclRet = importBase:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()