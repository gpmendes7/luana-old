local Link = require "core/linking/Link"
local LinkParam = require "core/linking/LinkParam"
local Bind = require "core/linking/Bind"

local function test1()
  local link = Link:create()

  assert(link ~= nil, "Error!")
  assert(link:getId() == nil, "Error!")
  assert(link:getXConnector() == nil, "Error!")
end

local function test2()
  local atts = {
    id = "link1",
    xconnector = "onBeginStart"
  }

  local link = Link:create(atts)

  assert(link:getId() == "link1", "Error!")
  assert(link:getXConnector() == "onBeginStart", "Error!")
end

local function test3()
  local link = Link:create()

  link:setId("link1")
  link:setXConnector("onBeginStart")

  assert(link:getId() == "link1", "Error!")
  assert(link:getXConnector() == "onBeginStart", "Error!")
end

local function test4()
  local link = Link:create()
  local status, err
  
  status, err = pcall(link["setId"], link, nil)
  assert(not(status), "Error!")

  status, err = pcall(link["setId"], link, {})
  assert(not(status), "Error!")

  status, err = pcall(link["setId"], link, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local link

  link = Link:create(nil, 1)
  assert(link:getLinkParamPos(1) ~= nil, "Error!")
  assert(link:getBindPos(1) ~= nil, "Error!")

  link:addLinkParam(LinkParam:create())
  assert(link:getLinkParamPos(2) ~= nil, "Error!")

  link:addBind(Bind:create())
  assert(link:getBindPos(2) ~= nil, "Error!")

  link:addLinkParam(LinkParam:create{name = "delay"})
  assert(link:getDescendantByAttribute("name", "delay") ~= nil, "Error!")

  link:addBind(Bind:create{role = "onBegin"})
  assert(link:getDescendantByAttribute("role", "onBegin") ~= nil, "Error!")
end

local function test6()
  local link = Link:create{id = "link1"}
  local linkParam = LinkParam:create{name = "delay"}
  local bind = Bind:create{role = "onBegin"}

  link:addLinkParam(linkParam)
  assert(link:getDescendantByAttribute("name", "delay") ~= nil, "Error!")

  link:removeLinkParam(linkParam)
  assert(link:getDescendantByAttribute("name", "delay") == nil, "Error!")

  link:addLinkParam(linkParam)
  link:removeLinkParamPos(1)
  assert(link:getDescendantByAttribute("name", "delay") == nil, "Error!")

  link:addBind(bind)
  assert(link:getDescendantByAttribute("role", "onBegin") ~= nil, "Error!")

  link:removeBind(bind)
  assert(link:getDescendantByAttribute("role", "onBegin") == nil, "Error!")

  link:addBind(bind)
  link:removeBindPos(1)
  assert(link:getDescendantByAttribute("role", "onBegin") == nil, "Error!")
end

local function test7()
  local link = Link:create()
  local status, err
    
  status, err = pcall(link["addLinkParam"], link, Bind:create())
  assert(not(status), "Error!")
  
  status, err = pcall(link["addLinkParam"], link, "invalid")
  assert(not(status), "Error!")

  status, err = pcall(link["addLinkParam"], link, nil)
  assert(not(status), "Error!")

  status, err = pcall(link["addLinkParam"], link, 999999)
  assert(not(status), "Error!")

  status, err = pcall(link["addLinkParam"], link, {})
  assert(not(status), "Error!")

  status, err = pcall(link["addLinkParam"], link, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test8()
  local atts = {
    id = "link1",
    xconnector = "onBeginStart"
  }

  local link = Link:create(atts)

  local nclExp = "<link"
  for attribute, _ in pairs(link:getAttributesTypeMap()) do
      nclExp = nclExp.." "..attribute.."=\""..tostring(link[attribute]).."\""
  end

  nclExp = nclExp.."/>\n"

  local nclRet = link:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

local function test9()
  local link = Link:create{id = "link1"}
  local nclExp = "<link id=\"link1\">\n"

  local linkParam =  LinkParam:create{name = "delay"}
  nclExp = nclExp.." <linkParam name=\"delay\"/>\n"

  local bind = Bind:create{role = "onBegin"}
  nclExp = nclExp.." <bind role=\"onBegin\"/>\n"

  nclExp = nclExp.."</link>\n"

  link:addLinkParam(linkParam)
  link:addBind(bind)

  local nclRet = link:table2Ncl(0)

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