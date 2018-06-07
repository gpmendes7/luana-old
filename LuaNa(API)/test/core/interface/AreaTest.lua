local Area = require "core/interface/Area"

local function test1()
  local area = Area:create()

  assert(area ~= nil, "Error!")
  assert(area:getId() == nil, "Error!")
  assert(area:getCoords() == nil, "Error!")
  assert(area:getBegin() == nil, "Error!")
  assert(area:getEnd() == nil, "Error!")
  assert(area:getBeginText() == nil, "Error!")
  assert(area:getEndText() == nil, "Error!")
  assert(area:getBeginPosition() == nil, "Error!")
  assert(area:getEndPosition() == nil, "Error!")
  assert(area:getFirst() == nil, "Error!")
  assert(area:getLast() == nil, "Error!")
  assert(area:getLabel() == nil, "Error!")
  assert(area:getClip() == nil, "Error!")
end

local function test2()
  local atts = {
    id = "a1",
    coords = "4, 5",
    begin = 5,
    ["end"] = 10,
    beginText = "begin",
    endText = "end",
    beginPosition = 5,
    endPosition = 10,
    first = 100,
    last = 200,
    label = "area1",
    clip = "endOffset"
  }

  local area = Area:create(atts)

  assert(area:getId() == "a1", "Error!")
  assert(area:getCoords() == "4, 5", "Error!")
  assert(area:getBegin() == 5, "Error!")
  assert(area:getEnd() == 10, "Error!")
  assert(area:getBeginText() == "begin", "Error!")
  assert(area:getEndText() == "end", "Error!")
  assert(area:getBeginPosition() == 5, "Error!")
  assert(area:getEndPosition() == 10, "Error!")
  assert(area:getFirst() == 100, "Error!")
  assert(area:getLast() == 200, "Error!")
  assert(area:getLabel() == "area1", "Error!")
  assert(area:getClip() == "endOffset", "Error!")
end

local function test3()
  local area = Area:create()

  area:setId("a1")
  area:setCoords("4, 5")
  area:setBegin(5)
  area:setEnd(10)
  area:setBeginText("begin")
  area:setEndText("end")
  area:setBeginPosition(5)
  area:setEndPosition(10)
  area:setFirst(100)
  area:setLast(200)
  area:setLabel("area1")
  area:setClip("endOffset")

  assert(area:getId() == "a1", "Error!")
  assert(area:getCoords() == "4, 5", "Error!")
  assert(area:getBegin() == 5, "Error!")
  assert(area:getEnd() == 10, "Error!")
  assert(area:getBeginText() == "begin", "Error!")
  assert(area:getEndText() == "end", "Error!")
  assert(area:getBeginPosition() == 5, "Error!")
  assert(area:getEndPosition() == 10, "Error!")
  assert(area:getFirst() == 100, "Error!")
  assert(area:getLast() == 200, "Error!")
  assert(area:getLabel() == "area1", "Error!")
  assert(area:getClip() == "endOffset", "Error!")
end

local function test4()
  local area = Area:create()
  local status, err

  status, err = pcall(area["setEventType"], area, "invalid")
  assert(not(status), "Error!")

  status, err = pcall(area["setFirst"], area, nil)
  assert(not(status), "Error!")

  status, err = pcall(area["setFirst"], area, {})
  assert(not(status), "Error!")

  status, err = pcall(area["setFirst"], area, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local atts = {
    id = "a1",
    coords = "4, 5",
    begin = 5,
    ["end"] = 10,
    beginText = "begin",
    endText = "end",
    beginPosition = 5,
    endPosition = 10,
    first = 100,
    last = 200,
    label = "area1",
    clip = "endOffset"
  }

  local area = Area:create(atts)

  area:addSymbol("begin", "s")
  area:addSymbol("end", "s")
  area:addSymbol("first", "f")
  area:addSymbol("last", "f")

  local nclExp = "<area"
  for attribute, _ in pairs(area:getAttributesTypeMap()) do
    if(area:getSymbols() ~= nil and area:getSymbol(attribute) ~= nil)then
      nclExp = nclExp.." "..attribute.."=\""..area[attribute]..area:getSymbol(attribute).."\""
    else
      nclExp = nclExp.." "..attribute.."=\""..tostring(area[attribute]).."\""
    end
  end

  nclExp = nclExp.."/>\n"

  local nclRet = area:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()