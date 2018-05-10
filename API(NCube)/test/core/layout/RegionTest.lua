local Region = require "core/layout/Region"

local function test1()
  local region = Region:create()

  assert(region ~= nil, "Error!")
  assert(region:getId() == nil, "Error!")
  assert(region:getTitle() == nil, "Error!")
  assert(region:getLeft() == nil, "Error!")
  assert(region:getRight() == nil, "Error!")
  assert(region:getTop() == nil, "Error!")
  assert(region:getBottom() == nil, "Error!")
  assert(region:getHeight() == nil, "Error!")
  assert(region:getWidth() == nil, "Error!")
  assert(region:getZIndex() == nil, "Error!")
end

local function test2()
  local atts = {
    id = "region",
    title = "title",
    left = 50,
    right = 25,
    top = 50,
    bottom = 25,
    height = 80,
    width = 80,
    zIndex = 3
  }

  local region = Region:create(atts)

  assert(region:getId() == "region", "Error!")
  assert(region:getTitle() == "title", "Error!")
  assert(region:getLeft() == 50, "Error!")
  assert(region:getRight() == 25, "Error!")
  assert(region:getTop() == 50, "Error!")
  assert(region:getBottom() == 25, "Error!")
  assert(region:getHeight() == 80, "Error!")
  assert(region:getWidth() == 80, "Error!")
  assert(region:getZIndex() == 3, "Error!")
end

local function test3()
  local region = Region:create()

  region:setId("region")
  region:setTitle("title")
  region:setLeft(50)
  region:setRight(25)
  region:setTop(50)
  region:setBottom(25)
  region:setHeight(80)
  region:setWidth(80)
  region:setZIndex(3)

  assert(region:getId() == "region", "Error!")
  assert(region:getTitle() == "title", "Error!")
  assert(region:getLeft() == 50, "Error!")
  assert(region:getRight() == 25, "Error!")
  assert(region:getTop() == 50, "Error!")
  assert(region:getBottom() == 25, "Error!")
  assert(region:getHeight() == 80, "Error!")
  assert(region:getWidth() == 80, "Error!")
  assert(region:getZIndex() == 3, "Error!")

  region:setPos(13.5, 18.7, 22.3, 17.8)
  assert(region:getLeft() == 13.5, "Error!")
  assert(region:getRight() == 18.7, "Error!")
  assert(region:getTop() == 22.3, "Error!")
  assert(region:getBottom() == 17.8, "Error!")

  region:setDim(40, 30)
  assert(region:getHeight() == 40, "Error!")
  assert(region:getWidth() == 30, "Error!")
end

local function test4()
  local region = Region:create()
  local status, err

  status, err = pcall(region["setTop"], region, "invalid")
  assert(not(status), "Error!")

  status, err = pcall(region["setTop"], region, nil)
  assert(not(status), "Error!")

  status, err = pcall(region["setTop"], region, {})
  assert(not(status), "Error!")

  status, err = pcall(region["setTop"], region, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local region

  region = Region:create(nil, 1)
  assert(region:getRegionPos(1) ~= nil, "Error!")

  region:addRegion(Region:create())
  assert(region:getRegionPos(2) ~= nil, "Error!")

  region:addRegion(Region:create{id = "rg2"})
  assert(region:getRegionById("rg2") ~= nil, "Error!")
end

local function test6()
  local region1 = Region:create{id = "region1"}
  local region2 = Region:create{id = "region2"}
  local region3 = Region:create{id = "region3"}
  local region4 = Region:create{id = "region4"}

  region1:setRegions(region2, region3, region4)
  assert(region1:getRegionById("region2") ~= nil, "Error!")
  assert(region1:getRegionById("region3") ~= nil, "Error!")
  assert(region1:getRegionById("region4") ~= nil, "Error!")

  region1:removeRegion(region2)
  assert(region1:getRegionById("region2") == nil, "Error!")

  region1:removeRegionPos(1)
  assert(region1:getRegionById("region3") == nil, "Error!")
end

local function test7()
  local region = Region:create()
  local status, err

  status, err = pcall(region["addRegion"], region, "invalid")
  assert(not(status), "Error!")

  status, err = pcall(region["addRegion"], region, nil)
  assert(not(status), "Error!")

  status, err = pcall(region["addRegion"], region, 999999)
  assert(not(status), "Error!")

  status, err = pcall(region["addRegion"], region, {})
  assert(not(status), "Error!")

  status, err = pcall(region["addRegion"], region, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test8()
  local atts = {
    id = "region",
    title = "title",
    left = 50,
    right = 25,
    top = 50,
    bottom = 25,
    height = 80,
    width = 80,
    zIndex = 3
  }

  local region = Region:create(atts)

  region:addSymbol("left", "%")
  region:addSymbol("right", "%")
  region:addSymbol("top", "%")
  region:addSymbol("bottom", "%")
  region:addSymbol("height", "%")
  region:addSymbol("width", "%")

  local nclExp = "<region"
  for attribute, _ in pairs(region:getAttributesTypeMap()) do
    if(region:getSymbols() ~= nil and region:getSymbol(attribute) ~= nil)then
      nclExp = nclExp.." "..attribute.."=\""..region[attribute]..region:getSymbol(attribute).."\""
    else
      nclExp = nclExp.." "..attribute.."=\""..tostring(region[attribute]).."\""
    end
  end

  nclExp = nclExp.."/>\n"

  local nclRet = region:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

local function test9()
  local region1 = Region:create{id = "rg1"}
  local nclExp = "<region id=\"rg1\">\n"

  local region2 = Region:create{id = "rg2"}
  nclExp = nclExp.." <region id=\"rg2\"/>\n"

  local region3 = Region:create{id = "rg3"}
  nclExp = nclExp.." <region id=\"rg3\">\n"

  local region4 = Region:create{id = "rg4"}
  nclExp = nclExp.."  <region id=\"rg4\"/>\n"

  nclExp = nclExp.." </region>\n"
  nclExp = nclExp.."</region>\n"

  region1:setRegions(region2, region3)
  region3:addRegion(region4)

  local nclRet = region1:table2Ncl(0)

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