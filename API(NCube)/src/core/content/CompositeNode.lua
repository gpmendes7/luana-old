local NCLElem = require "core/NCLElem"

local Port = require "core/interface/Port"
local Property = require "core/interface/Property"
local Media = require "core/content/Media"
local Link = require "core/linking/Link"
local Meta = require "core/metadata/Meta"
local MetaData = require "core/metadata/MetaData"

local Context = NCLElem:extends()
local Switch = NCLElem:extends()

-- Class Context ---

Context.name = "context"

Context.childrenMap = {
  port = {Port, "many"},
  property = {Property, "many"},
  media = {Media, "many"},
  context = {Context, "many"},
  link = {Link, "many"},
  switch = {Switch, "many"},
  meta = {Meta, "many"},
  metadata = {MetaData, "one"}
}

Context.attributesTypeMap = {
  id = "string",
  refer = "string"
}

function Context:create(attributes, full)
  local context = Context:new()

  context.id = nil
  context.refer = nil

  context.referAss = nil

  context.ass = {}

  if(attributes ~= nil)then
    context:setAttributes(attributes)
  end

  context.children = {}
  context.ports = {}
  context.propertys = {}
  context.medias = {}
  context.contexts = {}
  context.links = {}
  context.switchs = {}
  context.metas = {}
  context.metadatas = {}

  if(full ~= nil)then
    context:addPort(Port:create())
    context:addProperty(Property:create())
    context:addMedia(Media:create(nil, full))
    context:addContext(Context:create())
    context:addLink(Link:create(nil, full))
    context:addSwitch(Switch:create())
    context:addMeta(Meta:create())
    context:addMetaData(MetaData:create())
  end

  return context
end

function Context:setId(id)
  self:addAttribute("id", id)
end

function Context:getId()
  return self:getAttribute("id")
end

function Context:setRefer(refer)
  if(type(refer) == "table")then
    self:addAttribute("refer", refer:getId())
    self.referAss = refer
    table.insert(refer.ass, self)
  else
    self:addAttribute("refer", refer)
  end
end

function Context:getRefer()
  return self:getAttribute("refer")
end

function Context:addPort(port)
  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(port, p-1)
  else
    self:addChild(port)
  end

  table.insert(self.ports, port)
end

function Context:getPortPos(p)
  if(p > #self.ports)then
    error("Error! context element doesn't have a port child in position "..p.."!", 2)
  end

  return self.ports[p]
end

function Context:getPortById(id)
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

function Context:setPorts(...)
  if(#arg>0)then
    for _, port in ipairs(arg) do
      self:addPort(port)
    end
  end
end

function Context:removePort(port)
  self:removeChild(port)

  for p, pt in ipairs(self.ports) do
    if(port == pt)then
      table.remove(self.ports, p)
    end
  end
end

function Context:removePortPos(p)
  self:removeChildPos(p)
  table.remove(self.ports, p)
end

function Context:addProperty(property)
  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(property, p-1)
  else
    self:addChild(property)
  end

  table.insert(self.propertys, property)
end

function Context:getPropertyPos(p)
  if(p > #self.propertys)then
    error("Error! context element doesn't have a property child in position "..p.."!", 2)
  end

  return self.propertys[p]
end

function Context:getPropertyByName(name)
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

function Context:setPropertys(...)
  if(#arg>0)then
    for _, property in ipairs(arg) do
      self:addProperty(property)
    end
  end
end

function Context:removeProperty(property)
  self:removeChild(property)

  for p, pr in ipairs(self.propertys) do
    if(property == pr)then
      table.remove(self.propertys, p)
    end
  end
end

function Context:removePropertyPos(p)
  self:removeChildPos(p)
  table.remove(self.propertys, p)
end

function Context:addMedia(media)
  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(media, p-1)
  else
    self:addChild(media)
  end

  table.insert(self.medias, media)
end

function Context:getMediaPos(p)
  if(p > #self.medias)then
    error("Error! context element doesn't have a media child in position "..p.."!", 2)
  end

  return self.medias[p]
end

function Context:getMediaById(id)
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

function Context:setMedias(...)
  if(#arg>0)then
    for _, media in ipairs(arg) do
      self:addMedia(media)
    end
  end
end
function Context:removeMedia(media)
  self:removeChild(media)

  for p, md in ipairs(self.medias) do
    if(media == md)then
      table.remove(self.medias, p)
    end
  end
end

function Context:removeMediaPos(p)
  self:removeChildPos(p)
  table.remove(self.medias, p)
end

function Context:addContext(context)
  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(context, p-1)
  else
    self:addChild(context)
  end

  table.insert(self.contexts, context)
end

function Context:getContextPos(p)
  if(p > #self.contexts)then
    error("Error! context element doesn't have a context child in position "..p.."!", 2)
  end

  return self.contexts[p]
end

function Context:getContextById(id)
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

function Context:setContexts(...)
  if(#arg>0)then
    for _, context in ipairs(arg) do
      self:addContext(context)
    end
  end
end

function Context:removeContext(context)
  self:removeChild(context)

  for p, ct in ipairs(self.contexts) do
    if(context == ct)then
      table.remove(self.contexts, p)
    end
  end
end

function Context:removeContextPos(p)
  self:removeChildPos(p)
  table.remove(self.contexts, p)
end

function Context:addLink(link)
  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(link, p)
  else
    self:addChild(link)
  end

  table.insert(self.links, link)
end

function Context:getLinkPos(p)
  if(p > #self.links)then
    error("Error! context element doesn't have a link child in position "..p.."!", 2)
  end

  return self.links[p]
end

function Context:getLinkById(id)
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

function Context:setLinks(...)
  if(#arg>0)then
    for _, link in ipairs(arg) do
      self:addMedia(link)
    end
  end
end
function Context:removeLink(link)
  self:removeChild(link)

  for p, lk in ipairs(self.links) do
    if(link == lk)then
      table.remove(self.links, p)
    end
  end
end

function Context:removeLinkPos(p)
  self:removeChildPos(p)
  table.remove(self.links, p)
end

function Context:addSwitch(switch)
  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(switch, p-1)
  else
    self:addChild(switch)
  end

  table.insert(self.switchs, switch)
end

function Context:getSwitchPos(p)
  if(p > #self.switchs)then
    error("Error! context element doesn't have a switch child in position "..p.."!", 2)
  end

  return self.switchs[p]
end

function Context:getSwitchById(id)
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

function Context:setSwitchs(...)
  if(#arg>0)then
    for _, switch in ipairs(arg) do
      self:addSwitch(switch)
    end
  end
end

function Context:removeSwitch(switch)
  self:removeChild(switch)

  for p, sw in ipairs(self.switchs) do
    if(switch == sw)then
      table.remove(self.switchs, p)
    end
  end
end

function Context:removeSwitchPos(p)
  self:removeChildPos(p)
  table.remove(self.switchs, p)
end

function Context:addMeta(meta)
  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(meta, p-1)
  else
    self:addChild(meta)
  end

  table.insert(self.metas, meta)
end

function Context:getMetaPos(p)
  if(p > #self.metas)then
    error("Error! context element doesn't have a meta child in position "..p.."!", 2)
  end

  return self.metas[p]
end

function Context:setMetas(...)
  if(#arg>0)then
    for _, meta in ipairs(arg) do
      self:addMedia(meta)
    end
  end
end
function Context:removeMeta(meta)
  self:removeChild(meta)

  for p, mt in ipairs(self.metas) do
    if(meta == mt)then
      table.remove(self.metas, p)
    end
  end
end

function Context:removeMetaPos(p)
  self:removeChildPos(p)
  table.remove(self.metas, p)
end

function Context:addMetaData(metadata)
  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(metadata, p-1)
  else
    self:addChild(metadata, 1)
  end

  table.insert(self.metadatas, metadata)
end

function Context:getMetaDataPos(p)
  if(p > #self.metadatas)then
    error("Error! body element doesn't have a metadata child in position "..p.."!", 2)
  end

  return self.metadatas[p]
end

function Context:setMetaDatas(...)
  if(#arg>0)then
    for _, metadata in ipairs(arg) do
      self:addMedia(metadata)
    end
  end
end

function Context:removeMetaData(metadata)
  self:removeChild(metadata)

  for p, mt in ipairs(self.metadatas) do
    if(metadata == mt)then
      table.remove(self.metadatas, p)
    end
  end
end

-- Classe Switch --

local DefaultComponent = require "core/switches/DefaultComponent"
local SwitchPort = require "core/switches/SwitchPort"
local BindRule = require "core/switches/BindRule"

Switch.name = "switch"

Switch.childrenMap = {
  defaultComponent = {DefaultComponent, "one"},
  switchPort = {SwitchPort, "many"},
  bindRule = {BindRule, "many"},
  media = {Media, "many"},
  context = {Context, "many"},
  switch = {Switch, "many"}
}

Switch.attributesTypeMap = {
  id = "string",
  refer = "string"
}

function Switch:create(attributes, full)
  local switch = Switch:new()

  switch.id = nil
  switch.refer = nil

  switch.referAss = nil

  if(attributes ~= nil)then
    switch:setAttributes(attributes)
  end

  switch.children = {}
  switch.switchPorts = {}
  switch.bindRules = {}
  switch.medias = {}
  switch.contexts = {}
  switch.switchs = {}

  if(full ~= nil)then
    switch:setDefaultComponent(DefaultComponent:create())
    switch:addSwitchPort(SwitchPort:create(nil, full))
    switch:addBindRule(BindRule:create())
    switch:addMedia(Media:create(nil, full))
    switch:addContext(Context:create())
    switch:addSwitch(Switch:create())
  end

  return switch
end

function Switch:setId(id)
  self:addAttribute("id", id)
end

function Switch:getId()
  return self:getAttribute("id")
end

function Switch:setRefer(refer)
  if(type(refer) == "table")then
    self:addAttribute("refer", refer:getId())
    self.referAss = refer
    table.insert(refer.ass, self)
  else
    self:addAttribute("refer", refer)
  end
end

function Switch:getRefer()
  return self:getAttribute("refer")
end

function Switch:setDefaultComponent(defaultComponent)
  self:addChild(defaultComponent, 1)
  self.defaultComponent = defaultComponent
end

function Switch:getDefaultComponent()
  return self.defaultComponent
end

function Switch:removeDefaultComponent()
  self:removeChild(self.defaultComponent)
  self.defaultComponent = nil
end

function Switch:addSwitchPort(switchPort)
  self:addChild(switchPort)
  table.insert(self.switchPorts, switchPort)
end

function Switch:getSwitchPortPos(p)
  if(p > #self.switchPorts)then
    error("Error! switch element doesn't have a switchPort child in position "..p.."!", 2)
  end

  return self.switchPorts[p]
end

function Switch:getSwitchPortById(id)
  if(id == nil)then
    error("Error! id attribute of switchPort element must be informed!", 2)
  end

  for _, switchPort in ipairs(self.switchPorts) do
    if(switchPort:getId() == id)then
      return switchPort
    end
  end

  return nil
end

function Switch:setSwitchPorts(...)
  if(#arg>0)then
    for _, switchPort in ipairs(arg) do
      self:addSwitchPort(switchPort)
    end
  end
end

function Switch:removeSwitchPort(switchPort)
  self:removeChild(switchPort)

  for p, sp in ipairs(self.switchPorts) do
    if(switchPort == sp)then
      table.remove(self.switchPorts, p)
    end
  end
end

function Switch:removeSwitchPortPos(p)
  self:removeChildPos(p)
  table.remove(self.switchPorts, p)
end

function Switch:addBindRule(bindRule)
  self:addChild(bindRule)
  table.insert(self.bindRules, bindRule)
end

function Switch:getBindRulePos(p)
  if(p > #self.bindRules)then
    error("Error! switch element doesn't have a bindRule child in position "..p.."!", 2)
  end

  return self.bindRules[p]
end

function Switch:setBindRules(...)
  if(#arg>0)then
    for _, bindRule in ipairs(arg) do
      self:addBindRule(bindRule)
    end
  end
end

function Switch:removeBindRule(bindRule)
  self:removeChild(bindRule)

  for p, br in ipairs(self.bindRules) do
    if(bindRule == br)then
      table.remove(self.bindRules, p)
    end
  end
end

function Switch:removeBindRulePos(p)
  self:removeChildPos(p)
  table.remove(self.bindRules, p)
end

function Switch:addMedia(media)
  self:addChild(media)
  table.insert(self.medias, media)
end

function Switch:getMediaPos(p)
  if(p > #self.medias)then
    error("Error! switch element doesn't have a media child in position "..p.."!", 2)
  end

  return self.medias[p]
end

function Switch:getMediaById(id)
  for _, media in ipairs(self.medias) do
    if(media:getId() == id)then
      return media
    end
  end

  return nil
end

function Switch:setMedias(...)
  if(#arg>0)then
    for _, media in ipairs(arg) do
      self:addMedia(media)
    end
  end
end
function Switch:removeMedia(media)
  self:removeChild(media)

  for p, md in ipairs(self.medias) do
    if(media == md)then
      table.remove(self.medias, p)
    end
  end
end

function Switch:removeMediaPos(i)
  self:removeChildPos(i)
  table.remove(self.medias, i)
end

function Switch:addContext(context)
  self:addChild(context)
  table.insert(self.contexts, context)
end

function Switch:getContextPos(p)
  if(p > #self.contexts)then
    error("Error! switch element doesn't have a context child in position "..p.."!", 2)
  end

  return self.contexts[p]
end

function Switch:getContextById(id)
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

function Switch:setContexts(...)
  if(#arg>0)then
    for _, context in ipairs(arg) do
      self:addContext(context)
    end
  end
end

function Switch:removeContext(context)
  self:removeChild(context)

  for p, ct in ipairs(self.contexts) do
    if(context == ct)then
      table.remove(self.contexts, p)
    end
  end
end

function Switch:removeContextPos(p)
  self:removeChildPos(p)
  table.remove(self.contexts, p)
end

function Switch:addSwitch(switch)
  self:addChild(switch)
  table.insert(self.switchs, switch)
end

function Switch:getSwitchPos(p)
  if(p > #self.switchs)then
    error("Error! switch element doesn't have a switch child in position "..p.."!", 2)
  end

  return self.switchs[p]
end

function Switch:getSwitchById(id)
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

function Switch:setSwitchs(...)
  if(#arg>0)then
    for _, switch in ipairs(arg) do
      self:addSwitch(switch)
    end
  end
end

function Switch:removeSwitch(switch)
  self:removeChild(switch)

  for i, sw in ipairs(self.switchs) do
    if(switch == sw)then
      table.remove(self.switchs, i)
    end
  end
end

function Switch:removeSwitchPos(p)
  self:removeChildPos(p)
  table.remove(self.switchs, p)
end

local CompositeNodes = {Context, Switch}

return CompositeNodes