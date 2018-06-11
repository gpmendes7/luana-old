local Media = require "core/content/Media"
local Area = require "core/interface/Area"
local Property = require "core/interface/Property"

local function test1()
  local media = Media:create()

  assert(media ~= nil, "Error!")
  assert(media:getId() == nil, "Error!")
  assert(media:getSrc() == nil, "Error!")
  assert(media:getType() == nil, "Error!")
  assert(media:getRefer() == nil, "Error!")
  assert(media:getReferAss() == nil, "Error!")
  assert(media:getInstance() == nil, "Error!")
  assert(media:getDescriptor() == nil, "Error!")
end

local function test2()
  local atts = {
    id = "m1",
    src = "img1.png",
    type = "type1",
    refer = "reference",
    instance = "new",
    newInstance="newInstance",
    descriptor = "d1"
  }

  local media = Media:create(atts)

  assert(media:getId() == "m1", "Error!")
  assert(media:getSrc() == "img1.png", "Error!")
  assert(media:getType() == "type1", "Error!")
  assert(media:getRefer() == "reference", "Error!")
  assert(media:getInstance() == "new", "Error!")
  assert(media:getNewInstance() == "newInstance", "Error!")
  assert(media:getDescriptor() == "d1", "Error!")
end

local function test3()
  local media = Media:create()

  media:setId("m1")
  media:setSrc("img1.png")
  media:setType("type1")
  media:setRefer("reference")
  media:setInstance("new")
  media:setNewInstance("newInstance")
  media:setDescriptor("d1")

  assert(media:getId() == "m1", "Error!")
  assert(media:getSrc() == "img1.png", "Error!")
  assert(media:getType() == "type1", "Error!")
  assert(media:getRefer() == "reference", "Error!")
  assert(media:getInstance() == "new", "Error!")
  assert(media:getNewInstance() == "newInstance", "Error!")
  assert(media:getDescriptor() == "d1", "Error!")
end

local function test4()
  local media = Media:create()
  local status, err
  local file, msg

  status, err = pcall(media["setInstance"], media, "invalid")
  assert(not(status), "Error!")
  file, msg = err:match("(.-:%d+): (.+)")
  assert(msg == "Error! Value invalid passed to instance attribute is not a possible value in media element!", "Error!")

  status, err = pcall(media["setInstance"], media, nil)
  assert(not(status), "Error!")
  file, msg = err:match("(.-:%d+): (.+)")
  assert(msg == "Error! Nil value passed to instance attribute in media element!", "Error!")

  status, err = pcall(media["setInstance"], media, {})
  assert(not(status), "Error!")
  file, msg = err:match("(.-:%d+): (.+)")
  assert(msg == "Error! Type of instance attribute is not valid to media element!", "Error!")

  status, err = pcall(media["setInstance"], media, function(a, b) return a+b end)
  assert(not(status), "Error!")
  file, msg = err:match("(.-:%d+): (.+)")
  assert(msg == "Error! Type of instance attribute is not valid to media element!", "Error!")
end

local function test5()
  local media

  media = Media:create(nil, 1)
  assert(media:getAreaPos(1) ~= nil, "Error!")
  assert(media:getPropertyPos(1) ~= nil, "Error!")

  media:addArea(Area:create())
  assert(media:getAreaPos(2) ~= nil, "Error!")

  media:addProperty(Property:create())
  assert(media:getPropertyPos(2) ~= nil, "Error!")

  media:addArea(Area:create{id = "a1"})
  assert(media:getAreaById("a1") ~= nil, "Error!")

  media:addProperty(Property:create{name = "sound"})
  assert(media:getPropertyByName("sound") ~= nil, "Error!")
end

local function test6()
  local area1 = Area:create{id = "a1"}
  local area2 = Area:create{id = "a2"}
  local area3 = Area:create{id = "a3"}
  local area4 = Area:create{id = "a4"}

  local property1 = Property:create{name = "color"}
  local property2 = Property:create{name = "sound"}
  local property3 = Property:create{name = "saturation"}
  local property4 = Property:create{name = "level"}

  local media = Media:create{id = "m1"}

  media:addArea(area1)
  media:addArea(area2)
  media:addArea(area3)
  media:addArea(area4)

  media:removeArea(area4)
  assert(media:getAreaById("a4") == nil, "Error!")

  media:removeAreaPos(2)
  assert(media:getAreaById("a2") == nil, "Error!")

  media:addProperty(property1)
  media:addProperty(property2)
  media:addProperty(property3)
  media:addProperty(property4)

  media:removeProperty(property4)
  assert(media:getPropertyByName("level") == nil, "Error!")

  media:removePropertyPos(2)
  assert(media:getPropertyByName("sound") == nil, "Error!")
end

local function test7()
  local media = Media:create{id = "m1"}
  local status, err

  status, err = pcall(media["addProperty"], media, "invalid")
  assert(not(status), "Error!")
  assert(err == "Error! Invalid property element!", "Error!")

  status, err = pcall(media["addProperty"], media, nil)
  assert(not(status), "Error!")
  assert(err == "Error! Invalid property element!", "Error!")

  status, err = pcall(media["addProperty"], media, 999999)
  assert(not(status), "Error!")
  assert(err == "Error! Invalid property element!", "Error!")

  status, err = pcall(media["addProperty"], media, {})
  assert(err == "Error! Invalid property element!", "Error!")
  assert(not(status), "Error!")

  status, err = pcall(media["addProperty"], media, function(a, b) return a+b end)
  assert(not(status), "Error!")
  assert(err == "Error! Invalid property element!", "Error!")
end

local function test8()
  local atts = {
    id = "m1",
    src = "img1.png",
    type = "type1",
    refer = "reference",
    instance = "new",
    newInstance="newInstance",
    descriptor = "d1"
  }

  local media = Media:create(atts)

  local nclExp = "<media"
  for attribute, _ in pairs(media:getAttributesTypeMap()) do
    nclExp = nclExp.." "..attribute.."=\""..tostring(media[attribute]).."\""
  end

  nclExp = nclExp.."/>\n"

  local nclRet = media:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

local function test9()
  local media = Media:create{id = "m1"}
  local nclExp = "<media id=\"m1\">\n"

  local area = Area:create{id = "a1"}
  nclExp = nclExp.." <area id=\"a1\"/>\n"

  local property = Property:create{name = "sound"}
  nclExp = nclExp.." <property name=\"sound\"/>\n"

  nclExp = nclExp.."</media>\n"

  media:addArea(area)
  media:addProperty(property)

  local nclRet = media:table2Ncl(0)

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