local NCLElem = require "core/NCLElem"
local Port = require "core/interface/Port"
local Property = require "core/interface/Property"
local Media = require "core/content/Media"
local CompositeNodes = require "core/content/CompositeNode"
local Context = CompositeNodes[1]
local Switch = CompositeNodes[2]
local Link = require "core/linking/Link"
local Meta = require "core/metadata/Meta"
local MetaData = require "core/metadata/MetaData"

local Body = NCLElem:extends()

Body.name = "body"

Body.childrenMap = {
  port = {Port, "many"},
  property = {Property, "many"},
  media = {Media, "many"},
  context = {Context, "many"},
  switch = {Switch, "many"},
  link = {Link, "many"},
  meta = {Meta, "many"},
  metadata = {MetaData, "many"}
}

Body.attributesTypeMap = {
  id = "string"
}

function Body:create(attributes, full)
  local body = Body:new()

  body.id = nil

  if(attributes ~= nil)then
    body:setAttributes(attributes)
  end

  body.children = {}
  body.ports = {}
  body.propertys = {}
  body.medias = {}
  body.contexts = {}
  body.switchs = {}
  body.links = {}
  body.metas = {}
  body.metadatas = {}

  if(full ~= nil)then
    body:addPort(Port:create())
    body:addProperty(Property:create())
    body:addMedia(Media:create(nil, full))
    body:addContext(Context:create(nil, full))
    body:addSwitch(Switch:create(nil, full))
    body:addLink(Link:create(nil, full))
    body:addMeta(Meta:create(nil, full))
    body:addMetaData(MetaData:create())
  end

  return body
end

function Body:setId(id)
  self:addAttribute("id", id)
end

function Body:getId()
  return self:getAttribute("id")
end

function Body:addPort(port)
  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(port, p-1)
  else
    self:addChild(port)
  end

  table.insert(self.ports, port)
end

function Body:getPortPos(p)
  if(p > #self.ports)then
    error("Error! body element doesn't have a port child in position "..p.."!", 2)
  end

  return self.ports[p]
end

function Body:getPortById(id)
  if(id == nil)then
    error("Error! id attribute of port element must be informed!", 2)
  end

  for _, port in ipairs(self.ports) do
    if(port:getId() == id)then
      return port
    end
  end

  return nil
end

function Body:setPorts(...)
  if(#arg>0)then
    for _, port in ipairs(arg) do
      self:addPort(port)
    end
  end
end

function Body:removePort(port)
  self:removeChild(port)

  for p, pt in ipairs(self.ports) do
    if(port == pt)then
      table.remove(self.ports, p)
    end
  end
end

function Body:removePortPos(p)
  self:removeChildPos(p)
  table.remove(self.ports, p)
end

function Body:addProperty(property)
  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(property, p-1)
  else
    self:addChild(property)
  end

  table.insert(self.propertys, property)
end

function Body:getPropertyPos(p)
  if(p > #self.propertys)then
    error("Error! body element doesn't have a property child in position "..p.."!", 2)
  end

  return self.propertys[p]
end

function Body:getPropertyByName(name)
  if(name == nil)then
    error("Error! name attribute of property element must be informed!", 2)
  end

  for _, property in ipairs(self.propertys) do
    if(property:getName() == name)then
      return property
    end
  end

  return nil
end

function Body:setPropertys(...)
  if(#arg>0)then
    for _, property in ipairs(arg) do
      self:addProperty(property)
    end
  end
end

function Body:removeProperty(property)
  self:removeChild(property)

  for p, pr in ipairs(self.propertys) do
    if(property == pr)then
      table.remove(self.propertys, p)
    end
  end
end

function Body:removePropertyPos(p)
  self:removeChildPos(p)
  table.remove(self.propertys, p)
end

function Body:addMedia(media)
  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(media, p-1)
  else
    self:addChild(media)
  end

  table.insert(self.medias, media)
end

function Body:getMediaPos(p)
  if(p > #self.medias)then
    error("Error! body element doesn't have a media child in position "..p.."!", 2)
  end

  return self.medias[p]
end

function Body:getMediaById(id)
  if(id == nil)then
    error("Error! id attribute of media element must be informed!", 2)
  end

  for _, media in ipairs(self.medias) do
    if(media:getId() == id)then
      return media
    end
  end

  return nil
end

function Body:setMedias(...)
  if(#arg>0)then
    for _, media in ipairs(arg) do
      self:addMedia(media)
    end
  end
end
function Body:removeMedia(media)
  self:removeChild(media)

  for p, md in ipairs(self.medias) do
    if(media == md)then
      table.remove(self.medias, p)
    end
  end
end

function Body:removeMediaPos(p)
  self:removeChildPos(p)
  table.remove(self.medias, p)
end

function Body:addContext(context)
  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(context, p-1)
  else
    self:addChild(context)
  end

  table.insert(self.contexts, context)
end

function Body:getContextPos(p)
  if(p > #self.contexts)then
    error("Error! body element doesn't have a context child in position "..p.."!", 2)
  end

  return self.contexts[p]
end

function Body:getContextById(id)
  if(id == nil)then
    error("Error! id attribute of context element must be informed!", 2)
  end

  for _, context in ipairs(self.contexts) do
    if(context:getId() == id)then
      return context
    end
  end

  return nil
end

function Body:setContexts(...)
  if(#arg>0)then
    for _, context in ipairs(arg) do
      self:addContext(context)
    end
  end
end

function Body:removeContext(context)
  self:removeChild(context)

  for p, ct in ipairs(self.contexts) do
    if(context == ct)then
      table.remove(self.contexts, p)
    end
  end
end

function Body:removeContextPos(p)
  self:removeChildPos(p)
  table.remove(self.contexts, p)
end

function Body:addSwitch(switch)
  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(switch, p-1)
  else
    self:addChild(switch)
  end

  table.insert(self.switchs, switch)
end

function Body:getSwitchPos(p)
  if(p > #self.switchs)then
    error("Error! body element doesn't have a switch child in position "..p.."!", 2)
  end

  return self.switchs[p]
end

function Body:getSwitchById(id)
  if(id == nil)then
    error("Error! id attribute of switch element must be informed!", 2)
  end

  for _, switch in ipairs(self.switchs) do
    if(switch:getId() == id)then
      return switch
    end
  end

  return nil
end

function Body:setSwitchs(...)
  if(#arg>0)then
    for _, switch in ipairs(arg) do
      self:addSwitch(switch)
    end
  end
end

function Body:removeSwitch(switch)
  self:removeChild(switch)

  for p, sw in ipairs(self.switchs) do
    if(switch == sw)then
      table.remove(self.switchs, p)
    end
  end
end

function Body:removeSwitchPos(p)
  self:removeChildPos(p)
  table.remove(self.switchs, p)
end


function Body:addLink(link)
  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(link, p)
  else
    self:addChild(link)
  end

  table.insert(self.links, link)
end

function Body:getLinkPos(p)
  if(p > #self.links)then
    error("Error! body element doesn't have a link child in position "..p.."!", 2)
  end

  return self.links[p]
end

function Body:getLinkById(id)
  if(id == nil)then
    error("Error! id attribute of link element must be informed!", 2)
  end

  for _, link in ipairs(self.links) do
    if(link:getId() == id)then
      return link
    end
  end

  return nil
end

function Body:setLinks(...)
  if(#arg>0)then
    for _, link in ipairs(arg) do
      self:addMedia(link)
    end
  end
end
function Body:removeLink(link)
  self:removeChild(link)

  for p, lk in ipairs(self.links) do
    if(link == lk)then
      table.remove(self.links, p)
    end
  end
end

function Body:removeLinkPos(p)
  self:removeChildPos(p)
  table.remove(self.links, p)
end

function Body:addMeta(meta)
  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(meta, p-1)
  else
    self:addChild(meta)
  end

  table.insert(self.metas, meta)
end

function Body:getMetaPos(p)
  if(p > #self.metas)then
    error("Error! body element doesn't have a meta child in position "..p.."!", 2)
  end

  return self.metas[p]
end

function Body:setMetas(...)
  if(#arg>0)then
    for _, meta in ipairs(arg) do
      self:addMedia(meta)
    end
  end
end
function Body:removeMeta(meta)
  self:removeChild(meta)

  for p, mt in ipairs(self.metas) do
    if(meta == mt)then
      table.remove(self.metas, p)
    end
  end
end

function Body:removeMetaPos(p)
  self:removeChildPos(p)
  table.remove(self.metas, p)
end

function Body:addMetaData(metadata)
  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(metadata, p-1)
  else
    self:addChild(metadata, 1)
  end

  table.insert(self.metadatas, metadata)
end

function Body:getMetaDataPos(p)
  if(p > #self.metadatas)then
    error("Error! body element doesn't have a metadata child in position "..p.."!", 2)
  end

  return self.metadatas[p]
end

function Body:setMetaDatas(...)
  if(#arg>0)then
    for _, metadata in ipairs(arg) do
      self:addMedia(metadata)
    end
  end
end

function Body:removeMetaData(metadata)
  self:removeChild(metadata)

  for p, mt in ipairs(self.metadatas) do
    if(metadata == mt)then
      table.remove(self.metadatas, p)
    end
  end
end

function Body:removeMetaDataPos(p)
  self:removeChildPos(p)
  table.remove(self.metadatas, p)
end

return Body
