local NCLElem = require "core/NCLElem"
local LinkParam = require "core/linking/LinkParam"
local Bind = require "core/linking/Bind"

---
-- Implements Link Class representing <b>&lt;link&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=link">
-- http://handbook.ncl.org.br/doku.php?id=link</a>
-- 
-- @module Link
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local Link = require "core/linking/Link" 
local Link = NCLElem:extends()

---
-- Name of <b>&lt;link&gt;</b> element.
-- 
-- @field [parent=#Link] #string nameElem
Link.nameElem = "link"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;link&gt;</b> element.
-- 
-- @field [parent=#Link] #table childrenMap
Link.childrenMap = {
  linkParam = {LinkParam, "many"},
  bind = {Bind, "many"}
}

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;link&gt;</b> element.
-- 
-- @field [parent=#Link] #table attributesTypeMap 
Link.attributesTypeMap = {
  id = "string",
  xconnector = "string"
}

---
-- List with associative map that connects an attribute to an specific object
-- representing a child NCL element of <b>&lt;link&gt;</b> element.
-- 
-- @field [parent=#Link] #table assMap
Link.assMap = {
  {"xconnector", "causalConnectorAss"}
}

---
-- Returns a new Link object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#Link] create
-- @param #table attributes list of attributes to be initialized.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #Link Link object created.
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

---
-- Sets a value to `id` attribute of the 
-- <b>&lt;link&gt;</b> element. 
-- 
-- @function [parent=#Link] setId
-- @param #string id `id` atribute of the
-- <b>&lt;link&gt;</b> element.
function Link:setId(id)
  self:addAttribute("id", id)
end

---
-- Returns the value of the `id` attribute of the 
-- <b>&lt;link&gt;</b> element. 
-- 
-- @function [parent=#Link] getId
-- @return #string `id` atribute of the <b>&lt;link&gt;</b> element.
function Link:getId()
  return self:getAttribute("id")
end

---
-- Sets a value to `xconnector` attribute of the 
-- <b>&lt;link&gt;</b> element. 
-- 
-- @function [parent=#Link] setXConnector
-- @param #stringOrobject xconnector `xconnector` atribute of the
-- <b>&lt;link&gt;</b> element.
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

---
-- Returns the value of the `xconnector` attribute of the 
-- <b>&lt;link&gt;</b> element. 
-- 
-- @function [parent=#Link] getXConnector
-- @return #string `xconnector` atribute of the <b>&lt;link&gt;</b> element.
function Link:getXConnector()
  return self:getAttribute("xconnector")
end

---
-- Returns the causalConnector associated to
-- <b>&lt;bind&gt;</b> element. 
-- 
-- @function [parent=#Link] getCausalConnectorAss
-- @return #object causalConnector associated to <b>&lt;bind&gt;</b> element.
function Link:getCausalConnectorAss()
  return self.causalConnectorAss
end

---
-- Adds a <b>&lt;linkParam&gt;</b> child element of the 
-- <b>&lt;link&gt;</b> element. 
-- 
-- @function [parent=#Link] addLinkParam
-- @param #LinkParam linkParam object representing the 
-- <b>&lt;linkParam&gt;</b> element.
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

---
-- Returns a <b>&lt;linkParam&gt;</b> child element of the 
-- <b>&lt;link&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Link] getLinkParamPos
-- @param #number p  position of the object representing 
-- the <b>&lt;linkParam&gt;</b> element.
function Link:getLinkParamPos(p)
  if(self.linkParams == nil)then
    error("Error! link element with nil linkParams list!", 2)
  elseif(p > #self.linkParams)then
    error("Error! link element doesn't have a linkParam child in position "..p.."!", 2)
  end

  return self.linkParams[p]
end

---
-- Adds so many <b>&lt;linkParam&gt;</b> child elements of the <b>&lt;link&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Link] setLinkParams
-- @param #LinkParam ... objects representing the <b>&lt;linkParam&gt;</b> element.
function Link:setLinkParams(...)
  if(#arg>0)then
    for _, linkParam in ipairs(arg) do
      self:addLinkParam(linkParam)
    end
  end
end

---
-- Removes a <b>&lt;linkParam&gt;</b> child element of the 
-- <b>&lt;link&gt;</b> element. 
-- 
-- @function [parent=#Link] removeLinkParam
-- @param #LinkParam linkParam object representing the <b>&lt;linkParam&gt;</b> element.
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

---
-- Removes a <b>&lt;linkParam&gt;</b> child element of the 
-- <b>&lt;link&gt;</b> element in position `p`.
-- 
-- @function [parent=#Link] removeLinkParamPos
-- @param #number p position of the <b>&lt;linkParam&gt;</b> child element.
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

---
-- Adds a <b>&lt;bind&gt;</b> child element of the 
-- <b>&lt;link&gt;</b> element. 
-- 
-- @function [parent=#Link] addBind
-- @param #Bind bind object representing the 
-- <b>&lt;bind&gt;</b> element.
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

---
-- Returns a <b>&lt;bind&gt;</b> child element of the 
-- <b>&lt;link&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Link] getBindPos
-- @param #number p  position of the object representing 
-- the <b>&lt;bind&gt;</b> element.
function Link:getBindPos(p)
  if(self.binds == nil)then
    error("Error! link element with nil binds list!", 2)
  elseif(p > #self.binds)then
    error("Error! link element doesn't have a bind child in position "..p.."!", 2)
  end

  return self.binds[p]
end

---
-- Adds so many <b>&lt;bind&gt;</b> child elements of the <b>&lt;link&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Link] setBinds
-- @param #Bind ... objects representing the <b>&lt;bind&gt;</b> element.
function Link:setBinds(...)
  if(#arg>0)then
    for _, bind in ipairs(arg) do
      self:addBind(bind)
    end
  end
end

---
-- Removes a <b>&lt;bind&gt;</b> child element of the 
-- <b>&lt;link&gt;</b> element. 
-- 
-- @function [parent=#Link] removeBind
-- @param #Bind bind object representing the <b>&lt;bind&gt;</b> element.
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

---
-- Removes a <b>&lt;bind&gt;</b> child element of the 
-- <b>&lt;link&gt;</b> element in position `p`.
-- 
-- @function [parent=#Link] removeBindPos
-- @param #number p position of the <b>&lt;bind&gt;</b> child element.
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