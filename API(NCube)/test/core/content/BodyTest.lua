local Body = require "core/content/Body"
local Port = require "core/interface/Port"
local Property = require "core/interface/Property"
local Media = require "core/content/Media"
local CompositeNodes = require "core/content/CompositeNode"
local Context = CompositeNodes[1]
local Switch = CompositeNodes[2]
local Link = require "core/linking/Link"
local Meta = require "core/metadata/Meta"
local MetaData = require "core/metadata/MetaData"

local function test1()
  local body = Body:create()

  assert(body ~= nil, "Error!")
  assert(body:getId() == nil, "Error!")
end

local function test2()
  local atts = {
    id = "b1"
  }

  local body = Context:create(atts)

  assert(body:getId() == "b1", "Error!")
end

local function test3()
  local body = Body:create()

  body:setId("b1")

  assert(body:getId() == "b1", "Error!")
end

local function test4()
  local body = Body:create()
  local status, err

  status, err = pcall(body["setId"], Body, nil)
  assert(not(status), "Error!")

  status, err = pcall(body["setId"], Body, 999999)
  assert(not(status), "Error!")

  status, err = pcall(body["setId"], Body, {})
  assert(not(status), "Error!")

  status, err = pcall(body["setId"], Body, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local body = Body:create(nil, 1)

  assert(body:getPortPos(1) ~= nil, "Error!")
  assert(body:getPropertyPos(1) ~= nil, "Error!")
  assert(body:getMediaPos(1) ~= nil, "Error!")
  assert(body:getContextPos(1) ~= nil, "Error!")
  assert(body:getSwitchPos(1) ~= nil, "Error!")
  assert(body:getLinkPos(1) ~= nil, "Error!")
  assert(body:getMetaPos(1) ~= nil, "Error!")
  assert(body:getMetaDataPos(1) ~= nil, "Error!")

  body:addPort(Port:create())
  assert(body:getPortPos(2) ~= nil, "Error!")

  body:addProperty(Property:create())
  assert(body:getPropertyPos(2) ~= nil, "Error!")

  body:addMedia(Media:create())
  assert(body:getMediaPos(2) ~= nil, "Error!")

  body:addContext(Context:create())
  assert(body:getContextPos(2) ~= nil, "Error!")

  body:addSwitch(Switch:create())
  assert(body:getSwitchPos(2) ~= nil, "Error!")

  body:addLink(Link:create())
  assert(body:getLinkPos(2) ~= nil, "Error!")

  body:addMeta(Meta:create())
  assert(body:getMetaPos(2) ~= nil, "Error!")

  body:addMetaData(MetaData:create())
  assert(body:getMetaDataPos(2) ~= nil, "Error!")

  body:addPort(Port:create{id = "p1"})
  assert(body:getPortById("p1") ~= nil, "Error!")

  body:addProperty(Property:create{name = "sound"})
  assert(body:getPropertyByName("sound") ~= nil, "Error!")

  body:addMedia(Media:create{id = "m1"})
  assert(body:getMediaById("m1") ~= nil, "Error!")

  body:addContext(Context:create{id = "c1"})
  assert(body:getContextById("c1") ~= nil, "Error!")

  body:addSwitch(Switch:create{id = "s1"})
  assert(body:getSwitchById("s1") ~= nil, "Error!")

  body:addLink(Link:create{id = "l1"})
  assert(body:getLinkById("l1") ~= nil, "Error!")

  body:addMeta(Meta:create{name = "mt"})
  assert(body:getDescendantByAttribute("name", "mt") ~= nil, "Error!")

  body:addMetaData(MetaData:create())
  assert(body:getMetaDataPos(1) ~= nil, "Error!")
end

local function test6()
  local body = Body:create()
  local port = Port:create{id = "p1"}
  local property = Property:create{name = "sound"}
  local media = Media:create{id = "m1"}
  local context = Context:create{id = "c1"}
  local link = Link:create{id = "l1"}
  local switch = Switch:create{id = "s1"}
  local meta = Meta:create{name = "mt"}
  local metadata = MetaData:create()

  body:addPort(port)
  body:removePort(port)
  assert(body:getPortById("p1") == nil, "Error!")

  body:addPort(port)
  body:removePortPos(1)
  assert(body:getPortById("p1") == nil, "Error!")

  body:addProperty(property)
  body:removeProperty(property)
  assert(body:getPropertyByName("sound") == nil, "Error!")

  body:addProperty(property)
  body:removePropertyPos(1)
  assert(body:getPropertyByName("sound") == nil, "Error!")

  body:addMedia(media)
  body:removeMedia(media)
  assert(body:getMediaById("m1") == nil, "Error!")

  body:addMedia(media)
  body:removeMediaPos(1)
  assert(body:getMediaById("m1") == nil, "Error!")

  body:addContext(context)
  body:removeContext(context)
  assert(body:getContextById("c1") == nil, "Error!")

  body:addContext(context)
  body:removeContextPos(1)
  assert(body:getContextById("c1") == nil, "Error!")

  body:addLink(link)
  body:removeLink(link)
  assert(body:getLinkById("s1") == nil, "Error!")

  body:addLink(link)
  body:removeLinkPos(1)
  assert(body:getLinkById("s1") == nil, "Error!")

  body:addSwitch(switch)
  body:removeSwitch(switch)
  assert(body:getSwitchById("s1") == nil, "Error!")

  body:addSwitch(switch)
  body:removeSwitchPos(1)
  assert(body:getSwitchById("s1") == nil, "Error!")

  body:addMeta(meta)
  body:removeMeta(meta)
  assert(body:getDescendantByAttribute("name", "mt") == nil, "Error!")

  body:addMeta(meta)
  body:removeMetaPos(1)
  assert(body:getDescendantByAttribute("name", "mt") == nil, "Error!")

  body:addMetaData(metadata)
  body:removeMetaData(metadata)
  assert(#body.metadatas == 0, "Error!")

  body:addMeta(meta)
  body:removeMetaPos(1)
  assert(#body.metadatas == 0, "Error!")
end

local function test7()
  local atts = {
    id = "b1"
  }

  local body = Body:create(atts)

  local nclExp = "<body"
  for attribute, _ in pairs(body:getAttributesTypeMap()) do
      nclExp = nclExp.." "..attribute.."=\""..tostring(body[attribute]).."\""
  end

  nclExp = nclExp.."/>\n"

  local nclRet = body:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

local function test8()
  local body = Body:create{id = "b1"}
  local nclExp = "<body id=\"b1\">\n"

  local port = Port:create{id = "p1"}
  nclExp = nclExp.." <port id=\"p1\"/>\n"

  local property = Property:create{name = "sound"}
  nclExp = nclExp.." <property name=\"sound\"/>\n"

  local media = Media:create{id = "m1"}
  nclExp = nclExp.." <media id=\"m1\"/>\n"

  local context = Context:create{id = "c1"}
  nclExp = nclExp.." <context id=\"c1\"/>\n"

  local switch = Switch:create{id = "s1"}
  nclExp = nclExp.." <switch id=\"s1\"/>\n"

  local meta = Meta:create{name = "mt"}
  nclExp = nclExp.." <meta name=\"mt\"/>\n"

  local link = Link:create{id = "l1"}
  nclExp = nclExp.." <link id=\"l1\"/>\n"

  nclExp = nclExp.."</body>\n"

  body:addPort(port)
  body:addProperty(property)
  body:addMedia(media)
  body:addContext(context)
  body:addSwitch(switch)
  body:addMeta(meta)
  body:addLink(link)

  local nclRet = body:table2Ncl(0)

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