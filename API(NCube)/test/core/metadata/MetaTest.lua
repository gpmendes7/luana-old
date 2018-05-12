local Meta = require "core/metadata/Meta"

local function test1()
  local meta = Meta:create()

  assert(meta ~= nil, "Error!")
  assert(meta:getName() == nil, "Error!")
  assert(meta:getContent() == nil, "Error!")
end

local function test2()
  local atts = {
    name = "meta",
    content = "content"
  }

  local meta = Meta:create(atts)

  assert(meta:getName() == "meta", "Error!")
  assert(meta:getContent() == "content", "Error!")
end

local function test3()
  local meta = Meta:create()

  meta:setName("meta")
  meta:setContent("content")

  assert(meta:getName() == "meta", "Error!")
  assert(meta:getContent() == "content", "Error!")
end

local function test4()
  local meta = Meta:create()
  local status, err

  status, err = pcall(meta["setName"], meta, nil)
  assert(not(status), "Error!")

  status, err = pcall(meta["setName"], meta, {})
  assert(not(status), "Error!")

  status, err = pcall(meta["setName"], meta, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local atts = {
    name = "meta",
    content = "content"
  }

  local meta = Meta:create(atts)

  local nclExp = "<meta"
  for attribute, _ in pairs(meta:getAttributesTypeMap()) do
      nclExp = nclExp.." "..attribute.."=\""..tostring(meta[attribute]).."\""
  end

  nclExp = nclExp.."/>\n"

  local nclRet = meta:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end


test1()
test2()
test3()
test4()
test5()