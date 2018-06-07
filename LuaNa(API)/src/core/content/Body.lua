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

---
-- Implements Body Class representing <b>&lt;body&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=body">
-- http://handbook.ncl.org.br/doku.php?id=body</a>
-- 
-- @module Body
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local Body = require "core/content/Body" 
local Body = NCLElem:extends()

---
-- Name of <b>&lt;body&gt;</b> element.
-- 
-- @field [parent=#Body] #string nameElem 
Body.nameElem = "body"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;body&gt;</b> element.
-- 
-- @field [parent=#Body] #table childrenMap
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

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;body&gt;</b> element.
-- 
-- @field [parent=#Body] #table attributesTypeMap
Body.attributesTypeMap = {
  id = "string"
}

---
-- Returns a new Body object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#Body] create
-- @param #table attributes list of attributes to be initialized.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #Body new Body object created.
function Body:create(attributes, full)
  local body = Body:new()

  body.id = nil

  body.ass = {}

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

---
-- Sets a value to `id` attribute of the 
-- <b>&lt;body&gt;</b> element. 
-- 
-- @function [parent=#Body] setId
-- @param #string comparator `id` atribute of the
-- <b>&lt;body&gt;</b> element.
function Body:setId(id)
  self:addAttribute("id", id)
end

---
-- Returns the value of the `id` attribute of the 
-- <b>&lt;body&gt;</b> element. 
-- 
-- @function [parent=#Body] getId
-- @return #string `id` atribute of the <b>&lt;body&gt;</b> element.
function Body:getId()
  return self:getAttribute("id")
end

---
-- Adds a <b>&lt;port&gt;</b> child element of the 
-- <b>&lt;body&gt;</b> element. 
-- 
-- @function [parent=#Body] addPort
-- @param #Port port object representing the 
-- <b>&lt;port&gt;</b> element.
function Body:addPort(port)
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
-- <b>&lt;body&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Body] getPortPos
-- @param #number p  position of the object representing the <b>&lt;port&gt;</b> element.
function Body:getPortPos(p)
  if(self.ports == nil)then
    error("Error! body element with nil ports list!", 2)
  elseif(p > #self.ports)then
    error("Error! body element doesn't have a port child in position "..p.."!", 2)
  end

  return self.ports[p]
end

---
-- Returns a <b>&lt;port&gt;</b> child element of the 
-- <b>&lt;body&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#Body] getPortById
-- @param #string id `id` attribute of the <b>&lt;port&gt;</b> element.
function Body:getPortById(id)
  if(id == nil)then
    error("Error! id attribute of port element must be informed!", 2)
  elseif(self.ports == nil)then
    error("Error! body element with nil ports list!", 2)
  end

  for _, port in ipairs(self.ports) do
    if(port:getId() == id)then
      return port
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;port&gt;</b> child elements of the <b>&lt;body&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Body] setPorts
-- @param #Port ... objects representing the <b>&lt;port&gt;</b> element.
function Body:setPorts(...)
  if(#arg>0)then
    for _, port in ipairs(arg) do
      self:addPort(port)
    end
  end
end

---
-- Removes a <b>&lt;port&gt;</b> child element of the 
-- <b>&lt;body&gt;</b> element. 
-- 
-- @function [parent=#Body] removePort
-- @param #Port port object representing the <b>&lt;port&gt;</b> element.
function Body:removePort(port)
  if((type(port) == "table"
    and port["getNameElem"] ~= nil
    and port:getNameElem() ~= "port")
    or (type(port) == "table"
    and port["getNameElem"] == nil)
    or type(port) ~= "table")then
    error("Error! Invalid port element!", 2)
  elseif(self.children == nil)then
    error("Error! body element with nil children list!", 2)
  elseif(self.ports == nil)then
    error("Error! body element with nil ports list!", 2)
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
-- <b>&lt;body&gt;</b> element in position `p`.
-- 
-- @function [parent=#Body] removePortPos
-- @param #number p position of the <b>&lt;port&gt;</b> child element.
function Body:removePortPos(p)
  if(self.children == nil)then
    error("Error! body element with nil children list!", 2)
  elseif(self.ports == nil)then
    error("Error! body element with nil ports list!", 2)
  elseif(p > #self.children)then
    error("Error! body element doesn't have a port child in position "..p.."!", 2)
  elseif(p > #self.ports)then
    error("Error! body element doesn't have a port child in position "..p.."!", 2)
  end

  self:removeChild(self.ports[p])
  table.remove(self.ports, p)
end

---
-- Adds a <b>&lt;property&gt;</b> child element of the 
-- <b>&lt;body&gt;</b> element. 
-- 
-- @function [parent=#Body] addProperty
-- @param #Property property object representing the 
-- <b>&lt;property&gt;</b> element.
function Body:addProperty(property)
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
-- <b>&lt;body&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Body] getPropertyPos
-- @param #number p  position of the object representing the <b>&lt;property&gt;</b> element.
function Body:getPropertyPos(p)
  if(self.propertys == nil)then
    error("Error! body element with nil propertys list!", 2)
  elseif(p > #self.propertys)then
    error("Error! body element doesn't have a property child in position "..p.."!", 2)
  end

  return self.propertys[p]
end

---
-- Returns a <b>&lt;property&gt;</b> child element of the 
-- <b>&lt;body&gt;</b> element
-- by `name` attribute.
--  
-- @function [parent=#Body] getPropertyByName
-- @param #string name `name` attribute of the <b>&lt;property&gt;</b> element.
function Body:getPropertyByName(name)
  if(name == nil)then
    error("Error! name attribute of property element must be informed!", 2)
  elseif(self.propertys == nil)then
    error("Error! body element with nil propertys list!", 2)
  end

  for _, property in ipairs(self.propertys) do
    if(property:getName() == name)then
      return property
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;property&gt;</b> child elements of the <b>&lt;body&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Body] setPropertys
-- @param #Property ... objects representing the <b>&lt;property&gt;</b> element.
function Body:setPropertys(...)
  if(#arg>0)then
    for _, property in ipairs(arg) do
      self:addProperty(property)
    end
  end
end

---
-- Removes a <b>&lt;property&gt;</b> child element of the 
-- <b>&lt;body&gt;</b> element. 
-- 
-- @function [parent=#Body] removeProperty
-- @param #Property property object representing the <b>&lt;property&gt;</b> element.
function Body:removeProperty(property)
  if((type(property) == "table"
    and property["getNameElem"] ~= nil
    and property:getNameElem() ~= "property")
    or (type(property) == "table"
    and property["getNameElem"] == nil)
    or type(property) ~= "table")then
    error("Error! Invalid property element!", 2)
  elseif(self.children == nil)then
    error("Error! body element with nil children list!", 2)
  elseif(self.propertys == nil)then
    error("Error! body element with nil propertys list!", 2)
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
-- <b>&lt;body&gt;</b> element in position `p`.
-- 
-- @function [parent=#Body] removePropertyPos
-- @param #number p position of the <b>&lt;property&gt;</b> child element.
function Body:removePropertyPos(p)
  if(self.children == nil)then
    error("Error! body element with nil children list!", 2)
  elseif(self.propertys == nil)then
    error("Error! body element with nil propertys list!", 2)
  elseif(p > #self.children)then
    error("Error! body element doesn't have a property child in position "..p.."!", 2)
  elseif(p > #self.propertys)then
    error("Error! body element doesn't have a property child in position "..p.."!", 2)
  end

  self:removeChild(self.propertys[p])
  table.remove(self.propertys, p)
end

---
-- Adds a <b>&lt;media&gt;</b> child element of the 
-- <b>&lt;body&gt;</b> element. 
-- 
-- @function [parent=#Body] addMedia
-- @param #Media media object representing the 
-- <b>&lt;media&gt;</b> element.
function Body:addMedia(media)
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
-- <b>&lt;body&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Body] getMediaPos
-- @param #number p  position of the object representing the <b>&lt;media&gt;</b> element.
function Body:getMediaPos(p)
  if(self.medias == nil)then
    error("Error! body element with nil medias list!", 2)
  elseif(p > #self.medias)then
    error("Error! body element doesn't have a media child in position "..p.."!", 2)
  end

  return self.medias[p]
end

---
-- Returns a <b>&lt;media&gt;</b> child element of the 
-- <b>&lt;body&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#Body] getMediaById
-- @param #string id `id` attribute of the <b>&lt;media&gt;</b> element.
function Body:getMediaById(id)
  if(id == nil)then
    error("Error! id attribute of media element must be informed!", 2)
  elseif(self.medias == nil)then
    error("Error! body element with nil medias list!", 2)
  end

  for _, media in ipairs(self.medias) do
    if(media:getId() == id)then
      return media
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;media&gt;</b> child elements of the <b>&lt;body&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Body] setMedias
-- @param #Media ... objects representing the <b>&lt;media&gt;</b> element.
function Body:setMedias(...)
  if(#arg>0)then
    for _, media in ipairs(arg) do
      self:addMedia(media)
    end
  end
end

---
-- Removes a <b>&lt;media&gt;</b> child element of the 
-- <b>&lt;body&gt;</b> element. 
-- 
-- @function [parent=#Body] removeMedia
-- @param #Media media object representing the <b>&lt;media&gt;</b> element.
function Body:removeMedia(media)
  if((type(media) == "table"
    and media["getNameElem"] ~= nil
    and media:getNameElem() ~= "media")
    or (type(media) == "table"
    and media["getNameElem"] == nil)
    or type(media) ~= "table")then
    error("Error! Invalid media element!", 2)
  elseif(self.children == nil)then
    error("Error! body element with nil children list!", 2)
  elseif(self.medias == nil)then
    error("Error! body element with nil medias list!", 2)
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
-- <b>&lt;body&gt;</b> element in position `p`.
-- 
-- @function [parent=#Body] removeMediaPos
-- @param #number p position of the <b>&lt;media&gt;</b> child element.
function Body:removeMediaPos(p)
  if(self.children == nil)then
    error("Error! body element with nil children list!", 2)
  elseif(self.medias == nil)then
    error("Error! body element with nil medias list!", 2)
  elseif(p > #self.children)then
    error("Error! body element doesn't have a media child in position "..p.."!", 2)
  elseif(p > #self.medias)then
    error("Error! body element doesn't have a media child in position "..p.."!", 2)
  end

  self:removeChild(self.medias[p])
  table.remove(self.medias, p)
end

---
-- Adds a <b>&lt;context&gt;</b> child element of the 
-- <b>&lt;body&gt;</b> element. 
-- 
-- @function [parent=#Body] addContext
-- @param #Context context object representing the 
-- <b>&lt;context&gt;</b> element.
function Body:addContext(context)
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
-- <b>&lt;body&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Body] getContextPos
-- @param #number p  position of the object representing the <b>&lt;context&gt;</b> element.
function Body:getContextPos(p)
  if(self.contexts == nil)then
    error("Error! body element with nil contexts list!", 2)
  elseif(p > #self.contexts)then
    error("Error! body element doesn't have a context child in position "..p.."!", 2)
  end

  if(p > #self.contexts)then
    error("Error! body element doesn't have a context child in position "..p.."!", 2)
  end

  return self.contexts[p]
end

---
-- Returns a <b>&lt;context&gt;</b> child element of the 
-- <b>&lt;body&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#Body] getContextById
-- @param #string id `id` attribute of the <b>&lt;context&gt;</b> element.
function Body:getContextById(id)
  if(self.contexts == nil)then
    error("Error! body element with nil contexts list!", 2)
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
-- Adds so many <b>&lt;context&gt;</b> child elements of the <b>&lt;body&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Body] setContexts
-- @param #Context ... objects representing the <b>&lt;context&gt;</b> element.
function Body:setContexts(...)
  if(#arg>0)then
    for _, context in ipairs(arg) do
      self:addContext(context)
    end
  end
end

---
-- Removes a <b>&lt;context&gt;</b> child element of the 
-- <b>&lt;body&gt;</b> element. 
-- 
-- @function [parent=#Body] removeContext
-- @param #Context context object representing the <b>&lt;context&gt;</b> element.
function Body:removeContext(context)
  if((type(context) == "table"
    and context["getNameElem"] ~= nil
    and context:getNameElem() ~= "context")
    or (type(context) == "table"
    and context["getNameElem"] == nil)
    or type(context) ~= "table")then
    error("Error! Invalid context element!", 2)
  elseif(self.children == nil)then
    error("Error! body element with nil children list!", 2)
  elseif(self.contexts == nil)then
    error("Error! body element with nil contexts list!", 2)
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
-- <b>&lt;body&gt;</b> element in position `p`.
-- 
-- @function [parent=#Body] removeContextPos
-- @param #number p position of the <b>&lt;context&gt;</b> child element.
function Body:removeContextPos(p)
  if(self.children == nil)then
    error("Error! body element with nil children list!", 2)
  elseif(self.contexts == nil)then
    error("Error! body element with nil contexts list!", 2)
  elseif(p > #self.children)then
    error("Error! body element doesn't have a context child in position "..p.."!", 2)
  elseif(p > #self.contexts)then
    error("Error! body element doesn't have a context child in position "..p.."!", 2)
  end

  self:removeChild(self.contexts[p])
  table.remove(self.contexts, p)
end

---
-- Adds a <b>&lt;switch&gt;</b> child element of the 
-- <b>&lt;body&gt;</b> element. 
-- 
-- @function [parent=#Body] addSwitch
-- @param #Switch switch object representing the 
-- <b>&lt;switch&gt;</b> element.
function Body:addSwitch(switch)
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
-- <b>&lt;body&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Body] getSwitchPos
-- @param #number p  position of the object representing the <b>&lt;switch&gt;</b> element.
function Body:getSwitchPos(p)
  if(self.switchs == nil)then
    error("Error! body element with nil switchs list!", 2)
  elseif(p > #self.switchs)then
    error("Error! body element doesn't have a switch child in position "..p.."!", 2)
  end


  if(p > #self.switchs)then
    error("Error! body element doesn't have a switch child in position "..p.."!", 2)
  end

  return self.switchs[p]
end

---
-- Returns a <b>&lt;switch&gt;</b> child element of the 
-- <b>&lt;body&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#Body] getSwitchById
-- @param #string id `id` attribute of the <b>&lt;switch&gt;</b> element.
function Body:getSwitchById(id)
  if(id == nil)then
    error("Error! id attribute of switch element must be informed!", 2)
  elseif(self.switchs == nil)then
    error("Error! body element with nil switchs list!", 2)
  end

  for _, switch in ipairs(self.switchs) do
    if(switch:getId() == id)then
      return switch
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;switch&gt;</b> child elements of the <b>&lt;body&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Body] setSwitchs
-- @param #Switch ... objects representing the <b>&lt;switch&gt;</b> element.
function Body:setSwitchs(...)
  if(#arg>0)then
    for _, switch in ipairs(arg) do
      self:addSwitch(switch)
    end
  end
end

---
-- Removes a <b>&lt;switch&gt;</b> child element of the 
-- <b>&lt;body&gt;</b> element. 
-- 
-- @function [parent=#Body] removeSwitch
-- @param #Switch switch object representing the <b>&lt;switch&gt;</b> element.
function Body:removeSwitch(switch)
  if((type(switch) == "table"
    and switch["getNameElem"] ~= nil
    and switch:getNameElem() ~= "switch")
    or (type(switch) == "table"
    and switch["getNameElem"] == nil)
    or type(switch) ~= "table")then
    error("Error! Invalid switch element!", 2)
  elseif(self.children == nil)then
    error("Error! body element with nil children list!", 2)
  elseif(self.switchs == nil)then
    error("Error! body element with nil switchs list!", 2)
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
-- <b>&lt;body&gt;</b> element in position `p`.
-- 
-- @function [parent=#Body] removeSwitchPos
-- @param #number p position of the <b>&lt;switch&gt;</b> child element.
function Body:removeSwitchPos(p)
  if(self.children == nil)then
    error("Error! body element with nil children list!", 2)
  elseif(self.switchs == nil)then
    error("Error! body element with nil switchs list!", 2)
  elseif(p > #self.children)then
    error("Error! body element doesn't have a switch child in position "..p.."!", 2)
  elseif(p > #self.switchs)then
    error("Error! body element doesn't have a switch child in position "..p.."!", 2)
  end

  self:removeChild(self.switchs[p])
  table.remove(self.switchs, p)
end

---
-- Adds a <b>&lt;link&gt;</b> child element of the 
-- <b>&lt;body&gt;</b> element. 
-- 
-- @function [parent=#Body] addLink
-- @param #Link link object representing the 
-- <b>&lt;link&gt;</b> element.
function Body:addLink(link)
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
-- <b>&lt;body&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Body] getLinkPos
-- @param #number p  position of the object representing the <b>&lt;link&gt;</b> element.
function Body:getLinkPos(p)
  if(self.links == nil)then
    error("Error! body element with nil links list!", 2)
  elseif(p > #self.links)then
    error("Error! body element doesn't have a link child in position "..p.."!", 2)
  end

  return self.links[p]
end

---
-- Returns a <b>&lt;link&gt;</b> child element of the 
-- <b>&lt;body&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#Body] getLinkById
-- @param #string id `id` attribute of the <b>&lt;link&gt;</b> element.
function Body:getLinkById(id)
  if(id == nil)then
    error("Error! id attribute of link element must be informed!", 2)
  elseif(self.links == nil)then
    error("Error! body element with nil links list!", 2)
  end

  for _, link in ipairs(self.links) do
    if(link:getId() == id)then
      return link
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;link&gt;</b> child elements of the <b>&lt;body&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Body] setLinks
-- @param #Link ... objects representing the <b>&lt;link&gt;</b> element.
function Body:setLinks(...)
  if(#arg>0)then
    for _, link in ipairs(arg) do
      self:addLink(link)
    end
  end
end
function Body:removeLink(link)
  if((type(link) == "table"
    and link["getNameElem"] ~= nil
    and link:getNameElem() ~= "link")
    or (type(link) == "table"
    and link["getNameElem"] == nil)
    or type(link) ~= "table")then
    error("Error! Invalid link element!", 2)
  elseif(self.children == nil)then
    error("Error! body element with nil children list!", 2)
  elseif(self.links == nil)then
    error("Error! body element with nil links list!", 2)
  end

  self:removeChild(link)

  for p, lk in ipairs(self.links) do
    if(link == lk)then
      table.remove(self.links, p)
    end
  end
end

function Body:removeLinkPos(p)
  if(self.children == nil)then
    error("Error! body element with nil children list!", 2)
  elseif(self.links == nil)then
    error("Error! body element with nil links list!", 2)
  elseif(p > #self.children)then
    error("Error! body element doesn't have a link child in position "..p.."!", 2)
  elseif(p > #self.links)then
    error("Error! body element doesn't have a link child in position "..p.."!", 2)
  end

  self:removeChild(self.links[p])
  table.remove(self.links, p)
end

function Body:addMeta(meta)
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

function Body:getMetaPos(p)
  if(self.metas == nil)then
    error("Error! body element with nil metas list!", 2)
  elseif(p > #self.metas)then
    error("Error! body element doesn't have a meta child in position "..p.."!", 2)
  end

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
  if((type(meta) == "table"
    and meta["getNameElem"] ~= nil
    and meta:getNameElem() ~= "meta")
    or (type(meta) == "table"
    and meta["getNameElem"] == nil)
    or type(meta) ~= "table")then
    error("Error! Invalid meta element!", 2)
  elseif(self.children == nil)then
    error("Error! body element with nil children list!", 2)
  elseif(self.metas == nil)then
    error("Error! body element with nil metas list!", 2)
  end

  self:removeChild(meta)

  for p, mt in ipairs(self.metas) do
    if(meta == mt)then
      table.remove(self.metas, p)
    end
  end
end

function Body:removeMetaPos(p)
  if(self.children == nil)then
    error("Error! body element with nil children list!", 2)
  elseif(self.metas == nil)then
    error("Error! body element with nil metas list!", 2)
  elseif(p > #self.children)then
    error("Error! body element doesn't have a meta child in position "..p.."!", 2)
  elseif(p > #self.metas)then
    error("Error! body element doesn't have a meta child in position "..p.."!", 2)
  end

  self:removeChildPos(p)
  table.remove(self.metas, p)
end

function Body:addMetaData(metadata)
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

function Body:getMetaDataPos(p)
  if(self.metadatas == nil)then
    error("Error! body element with nil metadatas list!", 2)
  elseif(p > #self.metadatas)then
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
  if((type(metadata) == "table"
    and metadata["getNameElem"] ~= nil
    and metadata:getNameElem() ~= "metadata")
    or (type(metadata) == "table"
    and metadata["getNameElem"] == nil)
    or type(metadata) ~= "table")then
    error("Error! Invalid metadata element!", 2)
  elseif(self.children == nil)then
    error("Error! body element with nil children list!", 2)
  elseif(self.metadatas == nil)then
    error("Error! body element with nil metadatas list!", 2)
  end

  self:removeChild(metadata)

  for p, mt in ipairs(self.metadatas) do
    if(metadata == mt)then
      table.remove(self.metadatas, p)
    end
  end
end

function Body:removeMetaDataPos(p)
  if(self.children == nil)then
    error("Error! body element with nil children list!", 2)
  elseif(self.metadatas == nil)then
    error("Error! body element with nil metadatas list!", 2)
  elseif(p > #self.children)then
    error("Error! body element doesn't have a metadata child in position "..p.."!", 2)
  elseif(p > #self.metadatas)then
    error("Error! body element doesn't have a metadata child in position "..p.."!", 2)
  end

  self:removeChild(self.metadatas[p])
  table.remove(self.metadatas, p)
end

return Body