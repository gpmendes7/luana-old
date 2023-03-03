local NCLElem = require "LuaNa(API)/src/core/NCLElem"
local Port = require ".LuaNa(API)/src/core/interface/Port"
local Property = require "LuaNa(API)/src/core/interface/Property"
local Media = require "LuaNa(API)/src/core/content/Media"
local Link = require "LuaNa(API)/src/core/linking/Link"
local Meta = require "LuaNa(API)/src/core/metadata/Meta"
local MetaData = require "LuaNa(API)/src/core/metadata/MetaData"
local DefaultComponent = require "LuaNa(API)/src/core/switches/DefaultComponent"
local SwitchPort = require "LuaNa(API)/src/core/switches/SwitchPort"
local BindRule = require "LuaNa(API)/src/core/switches/BindRule"

---
-- Implements Context Class representing <b>&lt;context&gt;</b> element and
-- Switch Class representing <b>&lt;switch&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=context">
-- http://handbook.ncl.org.br/doku.php?id=context</a> and
-- <a href="http://handbook.ncl.org.br/doku.php?id=switch">
-- http://handbook.ncl.org.br/doku.php?id=switch</a>
-- 
-- @module CompositeNode
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local CompositeNodes = require "core/content/CompositeNode"
-- local Context = CompositeNodes[1]
-- local Switch = CompositeNodes[2]
 
local Context = NCLElem:extends()

local Switch = NCLElem:extends()

---
-- Name of <b>&lt;context&gt;</b> element.
-- 
-- @field [parent=#Context] #string nameElem
Context.nameElem = "context"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;context&gt;</b> element.
-- 
-- @field [parent=#Context] #table childrenMap
Context.childrenMap = {
  port = {Port, "many"},
  property = {Property, "many"},
  media = {Media, "many"},
  context = {Context, "many"},
  link = {Link, "many"},
  switch = {Switch, "many"},
  meta = {Meta, "many"},
  metadata = {MetaData, "many"}
}

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;context&gt;</b> element.
-- 
-- @field [parent=#Context] #table attributesTypeMap
Context.attributesTypeMap = {
  id = "string",
  refer = "string"
}

---
-- List with associative map that connects an attribute to an specific object
-- representing a child NCL element of <b>&lt;context&gt;</b> element.
-- 
-- @field [parent=#Context] #table assMap
Context.assMap = {
  {"refer", "referAss"}
}

---
-- Returns a new Context object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#Context] create
-- @param #table attributes list of attributes to be initialized.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #Context new Context object created.
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

---
-- Sets a value to `id` attribute of the 
-- <b>&lt;context&gt;</b> element. 
-- 
-- @function [parent=#Context] setId
-- @param #string id `id` attribute of the
-- <b>&lt;context&gt;</b> element.
function Context:setId(id)
  self:addAttribute("id", id)
end

---
-- Returns the value of the `id` attribute of the 
-- <b>&lt;context&gt;</b> element. 
-- 
-- @function [parent=#Context] getId
-- @return #string `id` attribute of the <b>&lt;context&gt;</b> element.
function Context:getId()
  return self:getAttribute("id")
end

---
-- Sets a value to `refer` attribute of the 
-- <b>&lt;context&gt;</b> element. 
-- 
-- @function [parent=#Context] setRefer
-- @param #stringOrObject refer `refer` attribute of the
-- <b>&lt;context&gt;</b> element.
function Context:setRefer(refer)
  if(type(refer) == "table")then
    if(refer["getNameElem"] ~= nil
      and refer:getNameElem() ~= "context"
      and refer:getNameElem() ~= "body")then
      error("Error! Invalid refer element!", 2)
    elseif(refer:getId() ~= nil)then
      self:addAttribute("refer", refer:getId())
      self.referAss = refer
      table.insert(refer.ass, self)
    else
      error("Error! Refer element with nil id attribute!", 2)
    end
  elseif(type(refer) == "string" )then
    self:addAttribute("refer", refer)
  else
    error("Error! Invalid refer element!", 2)
  end
end

---
-- Returns the value of the `refer` attribute of the 
-- <b>&lt;context&gt;</b> element. 
-- 
-- @function [parent=#Context] getRefer
-- @return #string `refer` attribute of the <b>&lt;context&gt;</b> element.
function Context:getRefer()
  return self:getAttribute("refer")
end

---
-- Returns the refer associated to
-- <b>&lt;context&gt;</b> element. 
-- 
-- @function [parent=#Context] getReferAss
-- @return #object refer associated to <b>&lt;context&gt;</b> element.
function Context:getReferAss()
  return self.referAss
end

---
-- Adds a <b>&lt;port&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element. 
-- 
-- @function [parent=#Context] addPort
-- @param #Port port object representing the 
-- <b>&lt;port&gt;</b> element.
function Context:addPort(port)
  if((type(port) == "table"
    and port["getNameElem"] ~= nil
    and port:getNameElem() ~= "port")
    or (type(port) == "table"
    and port["getNameElem"] == nil)
    or type(port) ~= "table")then
    error("Error! Invalid port element!", 2)
  end

  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(port, p-1)
  else
    self:addChild(port)
  end

  table.insert(self.ports, port)
end

---
-- Returns a <b>&lt;port&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Context] getPortPos
-- @param #number p  position of the object representing the <b>&lt;port&gt;</b> element.
function Context:getPortPos(p)
  if(self.ports == nil)then
    error("Error! context element with nil ports list!", 2)
  elseif(p > #self.ports)then
    error("Error! context element element doesn't have a port child in position "..p.."!", 2)
  end

  return self.ports[p]
end

---
-- Returns a <b>&lt;port&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#Context] getPortById
-- @param #string id `id` attribute of the <b>&lt;port&gt;</b> element.
function Context:getPortById(id)
  if(id == nil)then
    error("Error! id attribute of port element must be informed!", 2)
  elseif(self.ports == nil)then
    error("Error! context element with nil ports list!", 2)
  end

  for _, port in ipairs(self.ports) do
    if(port:getId() == id)then
      return port
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;port&gt;</b> child elements of the <b>&lt;context&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Context] setPorts
-- @param #Port ... objects representing the <b>&lt;port&gt;</b> element.
function Context:setPorts(...)
  if(#arg>0)then
    for _, port in ipairs(arg) do
      self:addPort(port)
    end
  end
end

---
-- Removes a <b>&lt;port&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element. 
-- 
-- @function [parent=#Context] removePort
-- @param #Port port object representing the <b>&lt;port&gt;</b> element.
function Context:removePort(port)
  if((type(port) == "table"
    and port["getNameElem"] ~= nil
    and port:getNameElem() ~= "port")
    or (type(port) == "table"
    and port["getNameElem"] == nil)
    or type(port) ~= "table")then
    error("Error! Invalid port element!", 2)
  elseif(self.children == nil)then
    error("Error! context element with nil children list!", 2)
  elseif(self.ports == nil)then
    error("Error! context element with nil ports list!", 2)
  end

  self:removeChild(port)

  for p, pt in ipairs(self.ports) do
    if(port == pt)then
      table.remove(self.ports, p)
    end
  end
end

---
-- Removes a <b>&lt;port&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element in position `p`.
-- 
-- @function [parent=#Context] removePortPos
-- @param #number p position of the <b>&lt;port&gt;</b> child element.
function Context:removePortPos(p)
  if(self.children == nil)then
    error("Error! context element with nil children list!", 2)
  elseif(self.ports == nil)then
    error("Error! context element with nil ports list!", 2)
  elseif(p > #self.children)then
    error("Error! context element doesn't have a port child in position "..p.."!", 2)
  elseif(p > #self.ports)then
    error("Error! context element doesn't have a port child in position "..p.."!", 2)
  end

  self:removeChild(self.ports[p])
  table.remove(self.ports, p)
end

---
-- Adds a <b>&lt;property&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element. 
-- 
-- @function [parent=#Context] addProperty
-- @param #Property property object representing the 
-- <b>&lt;property&gt;</b> element.
function Context:addProperty(property)
  if((type(property) == "table"
    and property["getNameElem"] ~= nil
    and property:getNameElem() ~= "property")
    or (type(property) == "table"
    and property["getNameElem"] == nil)
    or type(property) ~= "table")then
    error("Error! Invalid property element!", 2)
  end

  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(property, p-1)
  else
    self:addChild(property)
  end

  table.insert(self.propertys, property)
end

---
-- Returns a <b>&lt;property&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Context] getPropertyPos
-- @param #number p  position of the object representing the <b>&lt;property&gt;</b> element.
function Context:getPropertyPos(p)
  if(self.propertys == nil)then
    error("Error! context element with nil propertys list!", 2)
  elseif(p > #self.propertys)then
    error("Error! context element doesn't have a property child in position "..p.."!", 2)
  end

  return self.propertys[p]
end

---
-- Returns a <b>&lt;property&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element
-- by `name` attribute.
--  
-- @function [parent=#Context] getPropertyByName
-- @param #string name `name` attribute of the <b>&lt;property&gt;</b> element.
function Context:getPropertyByName(name)
  if(name == nil)then
    error("Error! name attribute of property element must be informed!", 2)
  elseif(self.propertys == nil)then
    error("Error! context element with nil propertys list!", 2)
  end

  for _, property in ipairs(self.propertys) do
    if(property:getName() == name)then
      return property
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;property&gt;</b> child elements of the <b>&lt;context&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Context] setPropertys
-- @param #Property ... objects representing the <b>&lt;property&gt;</b> element.
function Context:setPropertys(...)
  if(#arg>0)then
    for _, property in ipairs(arg) do
      self:addProperty(property)
    end
  end
end

---
-- Removes a <b>&lt;property&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element. 
-- 
-- @function [parent=#Context] removeProperty
-- @param #Property property object representing the <b>&lt;property&gt;</b> element.
function Context:removeProperty(property)
  if((type(property) == "table"
    and property["getNameElem"] ~= nil
    and property:getNameElem() ~= "property")
    or (type(property) == "table"
    and property["getNameElem"] == nil)
    or type(property) ~= "table")then
    error("Error! Invalid property element!")
  elseif(self.children == nil)then
    error("Error! context element with nil children list!", 2)
  elseif(self.propertys == nil)then
    error("Error! context element with nil propertys list!", 2)
  end

  self:removeChild(property)

  for p, pr in ipairs(self.propertys) do
    if(property == pr)then
      table.remove(self.propertys, p)
    end
  end
end

---
-- Removes a <b>&lt;property&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element in position `p`.
-- 
-- @function [parent=#Context] removePropertyPos
-- @param #number p position of the <b>&lt;property&gt;</b> child element.
function Context:removePropertyPos(p)
  if(self.children == nil)then
    error("Error! context element with nil children list!", 2)
  elseif(self.propertys == nil)then
    error("Error! context element with nil propertys list!", 2)
  elseif(p > #self.children)then
    error("Error! context element doesn't have a property child in position "..p.."!", 2)
  elseif(p > #self.propertys)then
    error("Error! context element doesn't have a property child in position "..p.."!", 2)
  end

  self:removeChild(self.propertys[p])
  table.remove(self.propertys, p)
end

---
-- Adds a <b>&lt;media&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element. 
-- 
-- @function [parent=#Context] addMedia
-- @param #Media media object representing the 
-- <b>&lt;media&gt;</b> element.
function Context:addMedia(media)
  if((type(media) == "table"
    and media["getNameElem"] ~= nil
    and media:getNameElem() ~= "media")
    or (type(media) == "table"
    and media["getNameElem"] == nil)
    or type(media) ~= "table")then
    error("Error! Invalid media element!", 2)
  end

  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(media, p-1)
  else
    self:addChild(media)
  end

  table.insert(self.medias, media)
end

---
-- Returns a <b>&lt;media&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Context] getMediaPos
-- @param #number p  position of the object representing the <b>&lt;media&gt;</b> element.
function Context:getMediaPos(p)
  if(self.medias == nil)then
    error("Error! context element with nil medias list!", 2)
  elseif(p > #self.medias)then
    error("Error! context element doesn't have a media child in position "..p.."!", 2)
  end

  return self.medias[p]
end

---
-- Returns a <b>&lt;media&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#Context] getMediaById
-- @param #string id `id` attribute of the <b>&lt;media&gt;</b> element.
function Context:getMediaById(id)
  if(id == nil)then
    error("Error! id attribute of media element must be informed!", 2)
  elseif(self.medias == nil)then
    error("Error! context element with nil medias list!", 2)
  end

  for _, media in ipairs(self.medias) do
    if(media:getId() == id)then
      return media
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;media&gt;</b> child elements of the <b>&lt;context&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Context] setMedias
-- @param #Media ... objects representing the <b>&lt;media&gt;</b> element.
function Context:setMedias(...)
  if(#arg>0)then
    for _, media in ipairs(arg) do
      self:addMedia(media)
    end
  end
end

---
-- Removes a <b>&lt;media&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element. 
-- 
-- @function [parent=#Context] removeMedia
-- @param #Media media object representing the <b>&lt;media&gt;</b> element.
function Context:removeMedia(media)
  if((type(media) == "table"
    and media["getNameElem"] ~= nil
    and media:getNameElem() ~= "media")
    or (type(media) == "table"
    and media["getNameElem"] == nil)
    or type(media) ~= "table")then
    error("Error! Invalid media element!", 2)
  elseif(self.children == nil)then
    error("Error! context element with nil children list!", 2)
  elseif(self.medias == nil)then
    error("Error! context element with nil medias list!", 2)
  end

  self:removeChild(media)

  for p, md in ipairs(self.medias) do
    if(media == md)then
      table.remove(self.medias, p)
    end
  end
end

---
-- Removes a <b>&lt;media&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element in position `p`.
-- 
-- @function [parent=#Context] removeMediaPos
-- @param #number p position of the <b>&lt;media&gt;</b> child element.
function Context:removeMediaPos(p)
  if(self.children == nil)then
    error("Error! context element with nil children list!", 2)
  elseif(self.medias == nil)then
    error("Error! context element with nil medias list!", 2)
  elseif(p > #self.children)then
    error("Error! context element doesn't have a media child in position "..p.."!", 2)
  elseif(p > #self.medias)then
    error("Error! context element doesn't have a media child in position "..p.."!", 2)
  end

  self:removeChild(self.medias[p])
  table.remove(self.medias, p)
end

---
-- Adds a <b>&lt;context&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element. 
-- 
-- @function [parent=#Context] addContext
-- @param #Context context object representing the 
-- <b>&lt;context&gt;</b> element.
function Context:addContext(context)
  if((type(context) == "table"
    and context["getNameElem"] ~= nil
    and context:getNameElem() ~= "context")
    or (type(context) == "table"
    and context["getNameElem"] == nil)
    or type(context) ~= "table")then
    error("Error! Invalid context element!", 2)
  end

  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(context, p-1)
  else
    self:addChild(context)
  end

  table.insert(self.contexts, context)
end

---
-- Returns a <b>&lt;context&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Context] getContextPos
-- @param #number p  position of the object representing the <b>&lt;context&gt;</b> element.
function Context:getContextPos(p)
  if(self.contexts == nil)then
    error("Error! context element with nil contexts list!", 2)
  elseif(p > #self.contexts)then
    error("Error! context element doesn't have a context child in position "..p.."!", 2)
  end

  return self.contexts[p]
end

---
-- Returns a <b>&lt;context&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#Context] getContextById
-- @param #string id `id` attribute of the <b>&lt;context&gt;</b> element.
function Context:getContextById(id)
  if(self.contexts == nil)then
    error("Error! context element with nil contexts list!", 2)
  elseif(id == nil)then
    error("Error! id attribute of context element must be informed!", 2)
  end

  for _, context in ipairs(self.contexts) do
    if(context:getId() == id)then
      return context
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;context&gt;</b> child elements of the <b>&lt;context&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Context] setContexts
-- @param #Context ... objects representing the <b>&lt;context&gt;</b> element.
function Context:setContexts(...)
  if(#arg>0)then
    for _, context in ipairs(arg) do
      self:addContext(context)
    end
  end
end

---
-- Removes a <b>&lt;context&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element. 
-- 
-- @function [parent=#Context] removeContext
-- @param #Context context object representing the <b>&lt;context&gt;</b> element.
function Context:removeContext(context)
  if((type(context) == "table"
    and context["getNameElem"] ~= nil
    and context:getNameElem() ~= "context")
    or (type(context) == "table"
    and context["getNameElem"] == nil)
    or type(context) ~= "table")then
    error("Error! Invalid context element!", 2)
  elseif(self.children == nil)then
    error("Error! context element with nil children list!", 2)
  elseif(self.contexts == nil)then
    error("Error! context element with nil contexts list!", 2)
  end

  self:removeChild(context)

  for p, ct in ipairs(self.contexts) do
    if(context == ct)then
      table.remove(self.contexts, p)
    end
  end
end

---
-- Removes a <b>&lt;context&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element in position `p`.
-- 
-- @function [parent=#Context] removeContextPos
-- @param #number p position of the <b>&lt;context&gt;</b> child element.
function Context:removeContextPos(p)
  if(self.children == nil)then
    error("Error! context element with nil children list!", 2)
  elseif(self.contexts == nil)then
    error("Error! context element with nil contexts list!", 2)
  elseif(p > #self.children)then
    error("Error! context element doesn't have a context child in position "..p.."!", 2)
  elseif(p > #self.contexts)then
    error("Error! context element doesn't have a context child in position "..p.."!", 2)
  end

  self:removeChild(self.contexts[p])
  table.remove(self.contexts, p)
end

---
-- Adds a <b>&lt;link&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element. 
-- 
-- @function [parent=#Context] addLink
-- @param #Link link object representing the 
-- <b>&lt;link&gt;</b> element.
function Context:addLink(link)
  if((type(link) == "table"
    and link["getNameElem"] ~= nil
    and link:getNameElem() ~= "link")
    or (type(link) == "table"
    and link["getNameElem"] == nil)
    or type(link) ~= "table")then
    error("Error! Invalid link element!", 2)
  end

  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(link, p)
  else
    self:addChild(link)
  end

  table.insert(self.links, link)
end

---
-- Returns a <b>&lt;link&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Context] getLinkPos
-- @param #number p  position of the object representing the <b>&lt;link&gt;</b> element.
function Context:getLinkPos(p)
  if(self.links == nil)then
    error("Error! context element with nil links list!", 2)
  elseif(p > #self.links)then
    error("Error! context element doesn't have a link child in position "..p.."!", 2)
  end

  return self.links[p]
end

---
-- Returns a <b>&lt;link&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#Context] getLinkById
-- @param #string id `id` attribute of the <b>&lt;link&gt;</b> element.
function Context:getLinkById(id)
  if(id == nil)then
    error("Error! id attribute of link element must be informed!", 2)
  elseif(self.links == nil)then
    error("Error! context element with nil links list!", 2)
  end

  for _, link in ipairs(self.links) do
    if(link:getId() == id)then
      return link
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;link&gt;</b> child elements of the <b>&lt;context&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Context] setLinks
-- @param #Link ... objects representing the <b>&lt;link&gt;</b> element.
function Context:setLinks(...)
  if(#arg>0)then
    for _, link in ipairs(arg) do
      self:addMedia(link)
    end
  end
end

---
-- Removes a <b>&lt;link&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element. 
-- 
-- @function [parent=#Context] removeLink
-- @param #Link link object representing the <b>&lt;link&gt;</b> element.
function Context:removeLink(link)
  if((type(link) == "table"
    and link["getNameElem"] ~= nil
    and link:getNameElem() ~= "link")
    or (type(link) == "table"
    and link["getNameElem"] == nil)
    or type(link) ~= "table")then
    error("Error! Invalid link element!", 2)
  elseif(self.children == nil)then
    error("Error! context element with nil children list!", 2)
  elseif(self.links == nil)then
    error("Error! context element with nil links list!", 2)
  end

  self:removeChild(link)

  for p, lk in ipairs(self.links) do
    if(link == lk)then
      table.remove(self.links, p)
    end
  end
end

---
-- Removes a <b>&lt;link&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element in position `p`.
-- 
-- @function [parent=#Context] removeLinkPos
-- @param #number p position of the <b>&lt;link&gt;</b> child element.
function Context:removeLinkPos(p)
  if(self.children == nil)then
    error("Error! context element with nil children list!", 2)
  elseif(self.links == nil)then
    error("Error! context element with nil links list!", 2)
  elseif(p > #self.children)then
    error("Error! context element doesn't have a link child in position "..p.."!", 2)
  elseif(p > #self.links)then
    error("Error! context element doesn't have a link child in position "..p.."!", 2)
  end

  self:removeChild(self.links[p])
  table.remove(self.links, p)
end

---
-- Adds a <b>&lt;switch&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element. 
-- 
-- @function [parent=#Context] addSwitch
-- @param #Switch switch object representing the 
-- <b>&lt;switch&gt;</b> element.
function Context:addSwitch(switch)
  if((type(switch) == "table"
    and switch["getNameElem"] ~= nil
    and switch:getNameElem() ~= "switch")
    or (type(switch) == "table"
    and switch["getNameElem"] == nil)
    or type(switch) ~= "table")then
    error("Error! Invalid switch element!", 2)
  end

  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(switch, p-1)
  else
    self:addChild(switch)
  end

  table.insert(self.switchs, switch)
end

---
-- Returns a <b>&lt;switch&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Context] getSwitchPos
-- @param #number p  position of the object representing the <b>&lt;switch&gt;</b> element.
function Context:getSwitchPos(p)
  if(self.switchs == nil)then
    error("Error! context element with nil switchs list!", 2)
  elseif(p > #self.switchs)then
    error("Error! context element doesn't have a switch child in position "..p.."!", 2)
  end

  return self.switchs[p]
end

---
-- Returns a <b>&lt;switch&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#Context] getSwitchById
-- @param #string id `id` attribute of the <b>&lt;switch&gt;</b> element.
function Context:getSwitchById(id)
  if(id == nil)then
    error("Error! id attribute of switch element must be informed!", 2)
  elseif(self.switchs == nil)then
    error("Error! context element with nil switchs list!", 2)
  end

  for _, switch in ipairs(self.switchs) do
    if(switch:getId() == id)then
      return switch
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;switch&gt;</b> child elements of the <b>&lt;context&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Context] setSwitchs
-- @param #Switch ... objects representing the <b>&lt;switch&gt;</b> element.
function Context:setSwitchs(...)
  if(#arg>0)then
    for _, switch in ipairs(arg) do
      self:addSwitch(switch)
    end
  end
end

---
-- Removes a <b>&lt;switch&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element. 
-- 
-- @function [parent=#Context] removeSwitch
-- @param #Switch switch object representing the <b>&lt;switch&gt;</b> element.
function Context:removeSwitch(switch)
  if((type(switch) == "table"
    and switch["getNameElem"] ~= nil
    and switch:getNameElem() ~= "switch")
    or (type(switch) == "table"
    and switch["getNameElem"] == nil)
    or type(switch) ~= "table")then
    error("Error! Invalid switch element!", 2)
  elseif(self.children == nil)then
    error("Error! context element with nil children list!", 2)
  elseif(self.switchs == nil)then
    error("Error! context element with nil switchs list!", 2)
  end

  self:removeChild(switch)

  for p, sw in ipairs(self.switchs) do
    if(switch == sw)then
      table.remove(self.switchs, p)
    end
  end
end

---
-- Removes a <b>&lt;switch&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element in position `p`.
-- 
-- @function [parent=#Context] removeSwitchPos
-- @param #number p position of the <b>&lt;switch&gt;</b> child element.
function Context:removeSwitchPos(p)
  if(self.children == nil)then
    error("Error! context element with nil children list!", 2)
  elseif(self.switchs == nil)then
    error("Error! context element with nil switchs list!", 2)
  elseif(p > #self.children)then
    error("Error! context element doesn't have a switch child in position "..p.."!", 2)
  elseif(p > #self.switchs)then
    error("Error! context element doesn't have a switch child in position "..p.."!", 2)
  end

  self:removeChild(self.switchs[p])
  table.remove(self.switchs, p)
end

---
-- Adds a <b>&lt;meta&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element. 
-- 
-- @function [parent=#Context] addMeta
-- @param #Meta meta object representing the 
-- <b>&lt;meta&gt;</b> element.
function Context:addMeta(meta)
  if((type(meta) == "table"
    and meta["getNameElem"] ~= nil
    and meta:getNameElem() ~= "meta")
    or (type(meta) == "table"
    and meta["getNameElem"] == nil)
    or type(meta) ~= "table")then
    error("Error! Invalid meta element!", 2)
  end

  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(meta, p-1)
  else
    self:addChild(meta)
  end

  table.insert(self.metas, meta)
end

---
-- Returns a <b>&lt;meta&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Context] getMetaPos
-- @param #number p  position of the object representing the <b>&lt;meta&gt;</b> element.
function Context:getMetaPos(p)
  if(self.metas == nil)then
    error("Error! context element with nil metas list!", 2)
  elseif(p > #self.metas)then
    error("Error! context element doesn't have a meta child in position "..p.."!", 2)
  end

  return self.metas[p]
end

---
-- Adds so many <b>&lt;meta&gt;</b> child elements of the <b>&lt;context&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Context] setMetas
-- @param #Meta ... objects representing the <b>&lt;meta&gt;</b> element.
function Context:setMetas(...)
  if(#arg>0)then
    for _, meta in ipairs(arg) do
      self:addMedia(meta)
    end
  end
end

---
-- Removes a <b>&lt;meta&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element. 
-- 
-- @function [parent=#Context] removeMeta
-- @param #Meta meta object representing the <b>&lt;meta&gt;</b> element.
function Context:removeMeta(meta)
  if((type(meta) == "table"
    and meta["getNameElem"] ~= nil
    and meta:getNameElem() ~= "meta")
    or (type(meta) == "table"
    and meta["getNameElem"] == nil)
    or type(meta) ~= "table")then
    error("Error! Invalid meta element!", 2)
  elseif(self.children == nil)then
    error("Error! context element with nil children list!", 2)
  elseif(self.metas == nil)then
    error("Error! context element with nil metas list!", 2)
  end

  self:removeChild(meta)

  for p, mt in ipairs(self.metas) do
    if(meta == mt)then
      table.remove(self.metas, p)
    end
  end
end

---
-- Removes a <b>&lt;meta&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element in position `p`.
-- 
-- @function [parent=#Context] removeMetaPos
-- @param #number p position of the <b>&lt;meta&gt;</b> child element.
function Context:removeMetaPos(p)
  if(self.children == nil)then
    error("Error! context element with nil children list!", 2)
  elseif(self.metas == nil)then
    error("Error! context element with nil metas list!", 2)
  elseif(p > #self.children)then
    error("Error! context element doesn't have a meta child in position "..p.."!", 2)
  elseif(p > #self.metas)then
    error("Error! context element doesn't have a meta child in position "..p.."!", 2)
  end

  self:removeChild(self.metas[p])
  table.remove(self.metas, p)
end

---
-- Adds a <b>&lt;metadata&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element. 
-- 
-- @function [parent=#Context] addMetaData
-- @param #Metadata metadata object representing the 
-- <b>&lt;metadata&gt;</b> element.
function Context:addMetaData(metadata)
  if((type(metadata) == "table"
    and metadata["getNameElem"] ~= nil
    and metadata:getNameElem() ~= "metadata")
    or (type(metadata) == "table"
    and metadata["getNameElem"] == nil)
    or type(metadata) ~= "table")then
    error("Error! Invalid metadata element!", 2)
  end

  local p = self:getPosAvailable("link")

  if(p ~= nil)then
    self:addChild(metadata, p-1)
  else
    self:addChild(metadata, 1)
  end

  table.insert(self.metadatas, metadata)
end

---
-- Returns a <b>&lt;metadata&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Context] getMetaDataPos
-- @param #number p  position of the object representing the <b>&lt;metadata&gt;</b> element.
function Context:getMetaDataPos(p)
  if(self.metadatas == nil)then
    error("Error! context element with nil metadatas list!", 2)
  elseif(p > #self.metadatas)then
    error("Error! context element doesn't have a metadata child in position "..p.."!", 2)
  end

  return self.metadatas[p]
end

---
-- Adds so many <b>&lt;metadata&gt;</b> child elements of the <b>&lt;context&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Context] setMetaDatas
-- @param #Metadata ... objects representing the <b>&lt;metadata&gt;</b> element.
function Context:setMetaDatas(...)
  if(#arg>0)then
    for _, metadata in ipairs(arg) do
      self:addMedia(metadata)
    end
  end
end

---
-- Removes a <b>&lt;metadata&gt;</b> child element of the 
-- <b>&lt;body&gt;</b> element. 
-- 
-- @function [parent=#Context] removeMetaData
-- @param #Metadata metadata object representing the <b>&lt;metadata&gt;</b> element.
function Context:removeMetaData(metadata)
  if((type(metadata) == "table"
    and metadata["getNameElem"] ~= nil
    and metadata:getNameElem() ~= "metadata")
    or (type(metadata) == "table"
    and metadata["getNameElem"] == nil)
    or type(metadata) ~= "table")then
    error("Error! Invalid metadata element!", 2)
  elseif(self.children == nil)then
    error("Error! context element with nil children list!", 2)
  elseif(self.metadatas == nil)then
    error("Error! context element with nil metadatas list!", 2)
  end

  self:removeChild(metadata)

  for p, mt in ipairs(self.metadatas) do
    if(metadata == mt)then
      table.remove(self.metadatas, p)
    end
  end
end

---
-- Removes a <b>&lt;metadata&gt;</b> child element of the 
-- <b>&lt;context&gt;</b> element in position `p`.
-- 
-- @function [parent=#Context] removeMetaDataPos
-- @param #number p position of the <b>&lt;metadata&gt;</b> child element.
function Context:removeMetaDataPos(p)
  if(self.children == nil)then
    error("Error! context element with nil children list!", 2)
  elseif(self.metadatas == nil)then
    error("Error! context element with nil metadatas list!", 2)
  elseif(p > #self.children)then
    error("Error! context element doesn't have a metadata child in position "..p.."!", 2)
  elseif(p > #self.metadatas)then
    error("Error! context element doesn't have a metadata child in position "..p.."!", 2)
  end

  self:removeChild(self.metadatas[p])
  table.remove(self.metadatas, p)
end

---
-- Name of <b>&lt;switch&gt;</b> element.
-- 
-- @field [parent=#Switch] #string nameElem 
Switch.nameElem = "switch"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;switch&gt;</b> element.
-- 
-- @field [parent=#Switch] #table childrenMap
Switch.childrenMap = {
  defaultComponent = {DefaultComponent, "one"},
  switchPort = {SwitchPort, "many"},
  bindRule = {BindRule, "many"},
  media = {Media, "many"},
  context = {Context, "many"},
  switch = {Switch, "many"}
}

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;switch&gt;</b> element.
-- 
-- @field [parent=#Switch] #table attributesTypeMap
Switch.attributesTypeMap = {
  id = "string",
  refer = "string"
}

---
-- List with associative map that connects an attribute to an specific object
-- representing a child NCL element of <b>&lt;switch&gt;</b> element.
-- 
-- @field [parent=#Switch] #table assMap
Switch.assMap = {
  {"refer", "referAss"}
}

---
-- Returns a new Switch object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#Switch] create
-- @param #table attributes list of attributes to be initialized.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #Switch new Switch object created.
function Switch:create(attributes, full)
  local switch = Switch:new()

  switch.id = nil
  switch.refer = nil

  switch.referAss = nil

  switch.ass = {}

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

---
-- Sets a value to `id` attribute of the 
-- <b>&lt;switch&gt;</b> element. 
-- 
-- @function [parent=#Switch] setId
-- @param #string id `id` attribute of the
-- <b>&lt;body&gt;</b> element.
function Switch:setId(id)
  self:addAttribute("id", id)
end

---
-- Returns the value of the `id` attribute of the 
-- <b>&lt;switch&gt;</b> element. 
-- 
-- @function [parent=#Switch] getId
-- @return #string `id` attribute of the <b>&lt;switch&gt;</b> element.
function Switch:getId()
  return self:getAttribute("id")
end

---
-- Sets a value to `refer` attribute of the 
-- <b>&lt;switch&gt;</b> element. 
-- 
-- @function [parent=#Switch] setRefer
-- @param #stringOrObject refer `refer` attribute of the
-- <b>&lt;switch&gt;</b> element.
function Switch:setRefer(refer)
  if(type(refer) == "table")then
    if(refer["getNameElem"] ~= nil
      and refer:getNameElem() ~= "switch")then
      error("Error! Invalid refer element!", 2)
    elseif(refer:getId() ~= nil)then
      self:addAttribute("refer", refer:getId())
      self.referAss = refer
      table.insert(refer.ass, self)
    else
      error("Error! Refer element with nil id attribute!", 2)
    end
  elseif(type(refer) == "string" )then
    self:addAttribute("refer", refer)
  else
    error("Error! Invalid refer element!", 2)
  end
end

---
-- Returns the value of the `refer` attribute of the 
-- <b>&lt;switch&gt;</b> element. 
-- 
-- @function [parent=#Switch] getRefer
-- @return #string `refer` attribute of the <b>&lt;switch&gt;</b> element.
function Switch:getRefer()
  return self:getAttribute("refer")
end

---
-- Returns the refer associated to
-- <b>&lt;switch&gt;</b> element. 
-- 
-- @function [parent=#Switch] getReferAss
-- @return #object refer associated to <b>&lt;switch&gt;</b> element.
function Switch:getReferAss()
  return self.referAss
end

---
-- Sets the <b>&lt;defaultComponent&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element. 
-- 
-- @function [parent=#Switch] setDefaultComponent
-- @param #DefaultComponent defaultComponent object representing the 
-- <b>&lt;defaultComponent&gt;</b> element.
function Switch:setDefaultComponent(defaultComponent)
  if((type(defaultComponent) == "table"
    and defaultComponent["getNameElem"] ~= nil
    and defaultComponent:getNameElem() ~= "defaultComponent")
    or (type(defaultComponent) == "table"
    and defaultComponent["getNameElem"] == nil)
    or type(defaultComponent) ~= "table")then
    error("Error! Invalid defaultComponent element!", 2)
  end

  self:addChild(defaultComponent, 1)
  self.defaultComponent = defaultComponent
end

---
-- Returns the <b>&lt;defaultComponent&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element.
--  
-- @function [parent=#Switch] getDefaultComponent
-- @return #DefaultComponent defaultComponent object representing the <b>&lt;defaultComponent&gt;</b> element.
function Switch:getDefaultComponent()
  return self.defaultComponent
end

---
-- Removes the <b>&lt;defaultComponent&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element.
-- 
-- @function [parent=#Switch] removeDefaultComponent
function Switch:removeDefaultComponent()
  self:removeChild(self.defaultComponent)
  self.defaultComponent = nil
end

---
-- Adds a <b>&lt;switchPort&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element. 
-- 
-- @function [parent=#Switch] addSwitchPort
-- @param #SwitchPort switchPort object representing the 
-- <b>&lt;switchPort&gt;</b> element.
function Switch:addSwitchPort(switchPort)
  if((type(switchPort) == "table"
    and switchPort["getNameElem"] ~= nil
    and switchPort:getNameElem() ~= "switchPort")
    or (type(switchPort) == "table"
    and switchPort["getNameElem"] == nil)
    or type(switchPort) ~= "table")then
    error("Error! Invalid switchPort element!", 2)
  end

  self:addChild(switchPort)
  table.insert(self.switchPorts, switchPort)
end

---
-- Returns a <b>&lt;switchPort&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Switch] getSwitchPortPos
-- @param #number p  position of the object representing the <b>&lt;switchPort&gt;</b> element.
function Switch:getSwitchPortPos(p)
  if(self.switchPorts == nil)then
    error("Error! switch element with nil switchPorts list!", 2)
  elseif(p > #self.switchPorts)then
    error("Error! switch element doesn't have a switchPort child in position "..p.."!", 2)
  end

  return self.switchPorts[p]
end

---
-- Returns a <b>&lt;switchPort&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#Switch] getSwitchPortById
-- @param #string id `id` attribute of the <b>&lt;switchPort&gt;</b> element.
function Switch:getSwitchPortById(id)
  if(id == nil)then
    error("Error! id attribute of switchPort element must be informed!", 2)
  elseif(self.switchPorts == nil)then
    error("Error! switch element with nil switchPorts list!", 2)
  end

  for _, switchPort in ipairs(self.switchPorts) do
    if(switchPort:getId() == id)then
      return switchPort
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;switchPort&gt;</b> child elements of the <b>&lt;switch&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Switch] setSwitchPorts
-- @param #SwitchPort ... objects representing the <b>&lt;switchPort&gt;</b> element.
function Switch:setSwitchPorts(...)
  if(#arg>0)then
    for _, switchPort in ipairs(arg) do
      self:addSwitchPort(switchPort)
    end
  end
end

---
-- Removes a <b>&lt;switchPort&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element. 
-- 
-- @function [parent=#Switch] removeSwitchPort
-- @param #SwitchPort switchPort object representing the <b>&lt;switchPort&gt;</b> element.
function Switch:removeSwitchPort(switchPort)
  if((type(switchPort) == "table"
    and switchPort["getNameElem"] ~= nil
    and switchPort:getNameElem() ~= "switchPort")
    or (type(switchPort) == "table"
    and switchPort["getNameElem"] == nil)
    or type(switchPort) ~= "table")then
    error("Error! Invalid switchPort element!", 2)
  elseif(self.children == nil)then
    error("Error! switch element with nil children list!", 2)
  elseif(self.switchPorts == nil)then
    error("Error! switch element with nil switchPorts list!", 2)
  end

  self:removeChild(switchPort)

  for p, sp in ipairs(self.switchPorts) do
    if(switchPort == sp)then
      table.remove(self.switchPorts, p)
    end
  end
end

---
-- Removes a <b>&lt;switchPort&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element in position `p`.
-- 
-- @function [parent=#Switch] removeSwitchPortPos
-- @param #number p position of the <b>&lt;switchPort&gt;</b> child element.
function Switch:removeSwitchPortPos(p)
  if(self.children == nil)then
    error("Error! switch element with nil children list!", 2)
  elseif(self.switchPorts == nil)then
    error("Error! switch element with nil switchPorts list!", 2)
  elseif(p > #self.children)then
    error("Error! switch element doesn't have a switchPort child in position "..p.."!", 2)
  elseif(p > #self.switchPorts)then
    error("Error! switch element doesn't have a switchPort child in position "..p.."!", 2)
  end

  self:removeChild(self.switchPorts[p])
  table.remove(self.switchPorts, p)
end

---
-- Adds a <b>&lt;bindRule&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element. 
-- 
-- @function [parent=#Switch] addBindRule
-- @param #BindRule bindRule object representing the 
-- <b>&lt;bindRule&gt;</b> element.
function Switch:addBindRule(bindRule)
  if((type(bindRule) == "table"
    and bindRule["getNameElem"] ~= nil
    and bindRule:getNameElem() ~= "bindRule")
    or (type(bindRule) == "table"
    and bindRule["getNameElem"] == nil)
    or type(bindRule) ~= "table")then
    error("Error! Invalid bindRule element!", 2)
  end

  self:addChild(bindRule)
  table.insert(self.bindRules, bindRule)
end

---
-- Returns a <b>&lt;bindRule&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Switch] getBindRulePos
-- @param #number p  position of the object representing the <b>&lt;bindRule&gt;</b> element.
function Switch:getBindRulePos(p)
  if(self.bindRules == nil)then
    error("Error! switch element with nil bindRules list!", 2)
  elseif(p > #self.bindRules)then
    error("Error! switch element doesn't have a bindRule child in position "..p.."!", 2)
  end

  return self.bindRules[p]
end

---
-- Adds so many <b>&lt;bindRule&gt;</b> child elements of the <b>&lt;switch&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Switch] setBindRules
-- @param #BindRule ... objects representing the <b>&lt;bindRule&gt;</b> element.
function Switch:setBindRules(...)
  if(#arg>0)then
    for _, bindRule in ipairs(arg) do
      self:addBindRule(bindRule)
    end
  end
end

---
-- Removes a <b>&lt;bindRule&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element. 
-- 
-- @function [parent=#Switch] removeBindRule
-- @param #BindRule bindRule object representing the <b>&lt;bindRule&gt;</b> element.
function Switch:removeBindRule(bindRule)
  if((type(bindRule) == "table"
    and bindRule["getNameElem"] ~= nil
    and bindRule:getNameElem() ~= "bindRule")
    or (type(bindRule) == "table"
    and bindRule["getNameElem"] == nil)
    or type(bindRule) ~= "table")then
    error("Error! Invalid bindRule element!", 2)
  elseif(self.children == nil)then
    error("Error! switch element with nil children list!", 2)
  elseif(self.bindRules == nil)then
    error("Error! switch element with nil bindRules list!", 2)
  end

  self:removeChild(bindRule)

  for p, br in ipairs(self.bindRules) do
    if(bindRule == br)then
      table.remove(self.bindRules, p)
    end
  end
end

---
-- Removes a <b>&lt;bindRule&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element in position `p`.
-- 
-- @function [parent=#Switch] removeBindRulePos
-- @param #number p position of the <b>&lt;bindRule&gt;</b> child element.
function Switch:removeBindRulePos(p)
  if(self.children == nil)then
    error("Error! switch element with nil children list!", 2)
  elseif(self.bindRules == nil)then
    error("Error! switch element with nil bindRules list!", 2)
  elseif(p > #self.children)then
    error("Error! switch element doesn't have a bindRule child in position "..p.."!", 2)
  elseif(p > #self.bindRules)then
    error("Error! switch element doesn't have a bindRule child in position "..p.."!", 2)
  end

  self:removeChild(self.bindRules[p])
  table.remove(self.bindRules, p)
end

---
-- Adds a <b>&lt;media&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element. 
-- 
-- @function [parent=#Switch] addMedia
-- @param #Media media object representing the 
-- <b>&lt;media&gt;</b> element.
function Switch:addMedia(media)
  if((type(media) == "table"
    and media["getNameElem"] ~= nil
    and media:getNameElem() ~= "media")
    or (type(media) == "table"
    and media["getNameElem"] == nil)
    or type(media) ~= "table")then
    error("Error! Invalid media element!", 2)
  end

  self:addChild(media)
  table.insert(self.medias, media)
end

---
-- Returns a <b>&lt;media&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Switch] getMediaPos
-- @param #number p  position of the object representing the <b>&lt;media&gt;</b> element.
function Switch:getMediaPos(p)
  if(self.medias == nil)then
    error("Error! switch element with nil medias list!", 2)
  elseif(p > #self.medias)then
    error("Error! switch element doesn't have a media child in position "..p.."!", 2)
  end

  return self.medias[p]
end

---
-- Returns a <b>&lt;media&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#Switch] getMediaById
-- @param #string id `id` attribute of the <b>&lt;media&gt;</b> element.
function Switch:getMediaById(id)
  if(id == nil)then
    error("Error! id attribute of media element must be informed!", 2)
  elseif(self.switchs == nil)then
    error("Error! switch element with nil switchs list!", 2)
  end

  for _, media in ipairs(self.medias) do
    if(media:getId() == id)then
      return media
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;media&gt;</b> child elements of the <b>&lt;switch&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Switch] setMedias
-- @param #Media ... objects representing the <b>&lt;media&gt;</b> element.
function Switch:setMedias(...)
  if(#arg>0)then
    for _, media in ipairs(arg) do
      self:addMedia(media)
    end
  end
end

---
-- Removes a <b>&lt;media&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element. 
-- 
-- @function [parent=#Switch] removeMedia
-- @param #Media media object representing the <b>&lt;media&gt;</b> element.
function Switch:removeMedia(media)
  if((type(media) == "table"
    and media["getNameElem"] ~= nil
    and media:getNameElem() ~= "media")
    or (type(media) == "table"
    and media["getNameElem"] == nil)
    or type(media) ~= "table")then
    error("Error! Invalid media element!", 2)
  elseif(self.children == nil)then
    error("Error! switch element with nil children list!", 2)
  elseif(self.medias == nil)then
    error("Error! switch element with nil medias list!", 2)
  end

  self:removeChild(media)

  for p, md in ipairs(self.medias) do
    if(media == md)then
      table.remove(self.medias, p)
    end
  end
end

---
-- Removes a <b>&lt;media&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element in position `p`.
-- 
-- @function [parent=#Switch] removeMediaPos
-- @param #number p position of the <b>&lt;media&gt;</b> child element.
function Switch:removeMediaPos(p)
  if(self.children == nil)then
    error("Error! switch element with nil children list!", 2)
  elseif(self.medias == nil)then
    error("Error! switch element with nil medias list!", 2)
  elseif(p > #self.children)then
    error("Error! switch element doesn't have a media child in position "..p.."!", 2)
  elseif(p > #self.medias)then
    error("Error! switch element doesn't have a media child in position "..p.."!", 2)
  end

  self:removeChild(self.medias[p])
  table.remove(self.medias, p)
end

---
-- Adds a <b>&lt;context&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element. 
-- 
-- @function [parent=#Switch] addContext
-- @param #Context context object representing the 
-- <b>&lt;context&gt;</b> element.
function Switch:addContext(context)
  if((type(context) == "table"
    and context["getNameElem"] ~= nil
    and context:getNameElem() ~= "context")
    or (type(context) == "table"
    and context["getNameElem"] == nil)
    or type(context) ~= "table")then
    error("Error! Invalid context element!", 2)
  end

  self:addChild(context)
  table.insert(self.contexts, context)
end

---
-- Returns a <b>&lt;context&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Switch] getContextPos
-- @param #number p  position of the object representing the <b>&lt;context&gt;</b> element.
function Switch:getContextPos(p)
  if(self.contexts == nil)then
    error("Error! switch element with nil contexts list!", 2)
  elseif(p > #self.contexts)then
    error("Error! switch element doesn't have a context child in position "..p.."!", 2)
  end

  return self.contexts[p]
end

---
-- Returns a <b>&lt;context&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#Switch] getContextById
-- @param #string id `id` attribute of the <b>&lt;context&gt;</b> element.
function Switch:getContextById(id)
  if(id == nil)then
    error("Error! id attribute of context element must be informed!", 2)
  elseif(self.contexts == nil)then
    error("Error! switch element with nil contexts list!", 2)
  end

  for _, context in ipairs(self.contexts) do
    if(context:getId() == id)then
      return context
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;context&gt;</b> child elements of the <b>&lt;switch&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Switch] setContexts
-- @param #Context ... objects representing the <b>&lt;context&gt;</b> element.
function Switch:setContexts(...)
  if(#arg>0)then
    for _, context in ipairs(arg) do
      self:addContext(context)
    end
  end
end

---
-- Removes a <b>&lt;context&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element. 
-- 
-- @function [parent=#Switch] removeContext
-- @param #Context context object representing the <b>&lt;context&gt;</b> element.
function Switch:removeContext(context)
  if((type(context) == "table"
    and context["getNameElem"] ~= nil
    and context:getNameElem() ~= "context")
    or (type(context) == "table"
    and context["getNameElem"] == nil)
    or type(context) ~= "table")then
    error("Error! Invalid context element!", 2)
  elseif(self.children == nil)then
    error("Error! switch element with nil children list!", 2)
  elseif(self.contexts == nil)then
    error("Error! switch element with nil contexts list!", 2)
  end

  self:removeChild(context)

  for p, ct in ipairs(self.contexts) do
    if(context == ct)then
      table.remove(self.contexts, p)
    end
  end
end

---
-- Removes a <b>&lt;context&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element in position `p`.
-- 
-- @function [parent=#Switch] removeContextPos
-- @param #number p position of the <b>&lt;context&gt;</b> child element.
function Switch:removeContextPos(p)
  if(self.children == nil)then
    error("Error! switch element with nil children list!", 2)
  elseif(self.contexts == nil)then
    error("Error! switch element with nil contexts list!", 2)
  elseif(p > #self.children)then
    error("Error! switch element doesn't have a context child in position "..p.."!", 2)
  elseif(p > #self.contexts)then
    error("Error! switch element doesn't have a context child in position "..p.."!", 2)
  end

  self:removeChild(self.contexts[p])
  table.remove(self.contexts, p)
end

---
-- Adds a <b>&lt;switch&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element. 
-- 
-- @function [parent=#Switch] addSwitch
-- @param #Switch switch object representing the 
-- <b>&lt;switch&gt;</b> element.
function Switch:addSwitch(switch)
  if((type(switch) == "table"
    and switch["getNameElem"] ~= nil
    and switch:getNameElem() ~= "switch")
    or (type(switch) == "table"
    and switch["getNameElem"] == nil)
    or type(switch) ~= "table")then
    error("Error! Invalid switch element!", 2)
  end

  self:addChild(switch)
  table.insert(self.switchs, switch)
end

---
-- Returns a <b>&lt;switch&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Switch] getSwitchPos
-- @param #number p  position of the object representing the <b>&lt;switch&gt;</b> element.
function Switch:getSwitchPos(p)
  if(self.switchs == nil)then
    error("Error! switch element with nil switchs list!", 2)
  elseif(p > #self.switchs)then
    error("Error! switch element doesn't have a switch child in position "..p.."!", 2)
  end

  return self.switchs[p]
end

---
-- Returns a <b>&lt;switch&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#Switch] getSwitchById
-- @param #string id `id` attribute of the <b>&lt;switch&gt;</b> element.
function Switch:getSwitchById(id)
  if(id == nil)then
    error("Error! id attribute of switch element must be informed!", 2)
  elseif(self.switchs == nil)then
    error("Error! switch element with nil switchs list!", 2)
  end

  for _, switch in ipairs(self.switchs) do
    if(switch:getId() == id)then
      return switch
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;switch&gt;</b> child elements of the <b>&lt;switch&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Switch] setSwitchs
-- @param #Switch ... objects representing the <b>&lt;switch&gt;</b> element.
function Switch:setSwitchs(...)
  if(#arg>0)then
    for _, switch in ipairs(arg) do
      self:addSwitch(switch)
    end
  end
end

---
-- Removes a <b>&lt;switch&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element. 
-- 
-- @function [parent=#Switch] removeSwitch
-- @param #Switch switch object representing the <b>&lt;switch&gt;</b> element.
function Switch:removeSwitch(switch)
  if((type(switch) == "table"
    and switch["getNameElem"] ~= nil
    and switch:getNameElem() ~= "switch")
    or (type(switch) == "table"
    and switch["getNameElem"] == nil)
    or type(switch) ~= "table")then
    error("Error! Invalid switch element!", 2)
  elseif(self.children == nil)then
    error("Error! switch element with nil children list!", 2)
  elseif(self.switchs == nil)then
    error("Error! switch element with nil switchs list!", 2)
  end

  self:removeChild(switch)

  for i, sw in ipairs(self.switchs) do
    if(switch == sw)then
      table.remove(self.switchs, i)
    end
  end
end

---
-- Removes a <b>&lt;switch&gt;</b> child element of the 
-- <b>&lt;switch&gt;</b> element in position `p`.
-- 
-- @function [parent=#Switch] removeSwitchPos
-- @param #number p position of the <b>&lt;switch&gt;</b> child element.
function Switch:removeSwitchPos(p)
  if(self.children == nil)then
    error("Error! switch element with nil children list!", 2)
  elseif(self.switchs == nil)then
    error("Error! switch element with nil switchs list!", 2)
  elseif(p > #self.children)then
    error("Error! switch element element doesn't have a switch child in position "..p.."!", 2)
  elseif(p > #self.switchs)then
    error("Error! switch element element doesn't have a switch child in position "..p.."!", 2)
  end

  self:removeChild(self.switchs[p])
  table.remove(self.switchs, p)
end

local CompositeNodes = {Context, Switch}

return CompositeNodes