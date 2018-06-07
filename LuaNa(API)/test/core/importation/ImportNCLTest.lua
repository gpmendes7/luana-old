local ImportNCL = require "core/importation/ImportNCL"

local function test1()
  local importNCL = ImportNCL:create()

  assert(importNCL ~= nil, "Error!")
  assert(importNCL:getAlias() == nil, "Error!")
  assert(importNCL:getDocumentURI() == nil, "Error!")
end

local function test2()
  local atts = {
    alias = "doc1",
    documentURI = "document1.ncl"
  }

  local importNCL = ImportNCL:create(atts)

  assert(importNCL:getAlias() == "doc1", "Error!")
  assert(importNCL:getDocumentURI() == "document1.ncl", "Error!")
end

local function test3()
  local importNCL = ImportNCL:create()

  importNCL:setAlias("doc1")
  importNCL:setDocumentURI("document1.ncl")

  assert(importNCL:getAlias() == "doc1", "Error!")
  assert(importNCL:getDocumentURI() == "document1.ncl", "Error!")
end

local function test4()
  local importNCL = ImportNCL:create()
  local status, err

  status, err = pcall(importNCL["setDocumentURI"], importNCL, nil)
  assert(not(status), "Error!")

  status, err = pcall(importNCL["setDocumentURI"], importNCL, 999999)
  assert(not(status), "Error!")

  status, err = pcall(importNCL["setDocumentURI"], importNCL, {})
  assert(not(status), "Error!")

  status, err = pcall(importNCL["setDocumentURI"], importNCL, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local atts = {
    alias = "doc1",
    documentURI = "document1.ncl"
  }

  local importNCL = ImportNCL:create(atts)

  local nclExp = "<importNCL"
  for attribute, _ in pairs(importNCL:getAttributesTypeMap()) do
      nclExp = nclExp.." "..attribute.."=\""..tostring(importNCL[attribute]).."\""
  end

  nclExp = nclExp.."/>\n"

  local nclRet = importNCL:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()