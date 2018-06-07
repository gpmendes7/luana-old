local NCLElem = require "core/NCLElem"
local LinkParam = require "core/linking/LinkParam"
local Bind = require "core/linking/Bind"

local Link = NCLElem:extends()

Link.nameElem = "link"

Link.childrenMap = {
  linkParam = {LinkParam, "many"},
  bind = {Bind, "many"}
}

Link.attributesTypeMap = {
  id = "string",
  xconnector = "string"
}

Link.assMap = {
  {"xconnector", "causalConnectorAss"}
}

function Link:create(attributes, full)
  local link = Link:new()

  link.id = nil
  link.xconnector = nil

  link.causalConnectorAss = nil

  if(attributes ~= nil)then
    link:setAttributes(attributes)
  end

  link.children = {}
  link.linkParams = {}
  link.binds = {}

  if(full ~= nil)then
    link:addLinkParam(LinkParam:create())
    link:addBind(Bind:create(nil, full))
  end

  return link
end

function Link:setId(id)
  self:addAttribute("id", id)
end

function Link:getId()
  return self:getAttribute("id")
end

function Link:setXConnector(xconnector)
  if(type(xconnector) == "table"
    and xconnector["getNameElem"] ~= nil
    and xconnector:getNameElem() == "causalConnector")then
    self:addAttribute("xconnector", xconnector:getId())
    self.causalConnectorAss = xconnector
    table.insert(xconnector.ass, self)
  elseif(type(xconnector) == "string" )then
    self:addAttribute("xconnector", xconnector)
  else
    error("Error! Invalid causalConnector element!", 2)
  end
end

function Link:getXConnector()
  return self:getAttribute("xconnector")
end

function Link:addLinkParam(linkParam)
  if((type(linkParam) == "table"
    and linkParam["getNameElem"] ~= nil
    and linkParam:getNameElem() ~= "linkParam")
    or (type(linkParam) == "table"
    and linkParam["getNameElem"] == nil)
    or type(linkParam) ~= "table")then
    error("Error! Invalid linkParam element!", 2)
  end

  self:addChild(linkParam)
  table.insert(self.linkParams, linkParam)
end

function Link:getLinkParamPos(p)
  if(self.linkParams == nil)then
    error("Error! link element with nil linkParams list!", 2)
  elseif(p > #self.linkParams)then
    error("Error! link element doesn't have a linkParam child in position "..p.."!", 2)
  end

  return self.linkParams[p]
end

function Link:setLinkParams(...)
  if(#arg>0)then
    for _, linkParam in ipairs(arg) do
      self:addLinkParam(linkParam)
    end
  end
end

function Link:removeLinkParam(linkParam)
  if((type(linkParam) == "table"
    and linkParam["getNameElem"] ~= nil
    and linkParam:getNameElem() ~= "linkParam")
    or (type(linkParam) == "table"
    and linkParam["getNameElem"] == nil)
    or type(linkParam) ~= "table")then
    error("Error! Invalid linkParam element!", 2)
  elseif(self.children == nil)then
    error("Error! link element with nil children list!", 2)
  elseif(self.linkParams == nil)then
    error("Error! link element with nil linkParams list!", 2)
  end

  self:removeChild(linkParam)

  for p, lp in ipairs(self.linkParams) do
    if(linkParam == lp)then
      table.remove(self.linkParams, p)
    end
  end
end

function Link:removeLinkParamPos(p)
  if(self.children == nil)then
    error("Error! link element with nil children list!", 2)
  elseif(self.linkParams == nil)then
    error("Error! link element with nil linkParams list!", 2)
  elseif(p > #self.children)then
    error("Error! link element doesn't have a linkParam child in position "..p.."!", 2)
  elseif(p > #self.linkParams)then
    error("Error! link element doesn't have a linkParam child in position "..p.."!", 2)
  end

  self:removeChild(self.linkParams[p])
  table.remove(self.linkParams, p)
end

function Link:addBind(bind)
  if((type(bind) == "table"
    and bind["getNameElem"] ~= nil
    and bind:getNameElem() ~= "bind")
    or (type(bind) == "table"
    and bind["getNameElem"] == nil)
    or type(bind) ~= "table")then
    error("Error! Invalid bind element!", 2)
  end

  self:addChild(bind)
  table.insert(self.binds, bind)
end

function Link:getBindPos(p)
  if(self.binds == nil)then
    error("Error! link element with nil binds list!", 2)
  elseif(p > #self.binds)then
    error("Error! link element doesn't have a bind child in position "..p.."!", 2)
  end

  return self.binds[p]
end

function Link:setBinds(...)
  if(#arg>0)then
    for _, bind in ipairs(arg) do
      self:addBind(bind)
    end
  end
end

function Link:removeBind(bind)
  if((type(bind) == "table"
    and bind["getNameElem"] ~= nil
    and bind:getNameElem() ~= "bind")
    or (type(bind) == "table"
    and bind["getNameElem"] == nil)
    or type(bind) ~= "table")then
    error("Error! Invalid bind element!", 2)
  elseif(self.children == nil)then
    error("Error! link element with nil children list!", 2)
  elseif(self.binds == nil)then
    error("Error! link element with nil link list!", 2)
  end

  self:removeChild(bind)

  for p, bd in ipairs(self.binds) do
    if(bind == bd)then
      table.remove(self.binds, p)
    end
  end
end

function Link:removeBindPos(p)
  if(self.children == nil)then
    error("Error! link element with nil children list!", 2)
  elseif(self.binds == nil)then
    error("Error! link element with nil binds list!", 2)
  elseif(p > #self.children)then
    error("Error! link element doesn't have a bind child in position "..p.."!", 2)
  elseif(p > #self.binds)then
    error("Error! link element doesn't have a bind child in position "..p.."!", 2)
  end

  self:removeChild(self.binds[p])
  table.remove(self.binds, p)
end

return Link