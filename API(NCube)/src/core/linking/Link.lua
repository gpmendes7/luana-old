local NCLElem = require "core/structure_content/NCLElem"
local LinkParam = require "core/linking/LinkParam"
local Bind = require "core/linking/Bind"

local Link = NCLElem:extends()

Link.name = "link"

Link.attributes = {
  id = nil,
  xconnector = nil
}

Link.childsMap = {
 ["linkParam"] = {LinkParam, "many"},
 ["bind"] = {Bind, "many"}
}

Link.linkParams = nil
Link.binds = nil

function Link:create(attributes, full)  
   local attributes = attributes or {}  
   local link = Link:new() 
     
   link:setAttributes(attributes)
   link:setChilds() 
   link.linkParams = {}
   link.binds = {}
   
   if(full ~= nil)then
      link:addLinkParam(LinkParam:create()) 
      link:addBind(Bind:create(nil, full))         
   end
   
   return link
end

function Link:setId(id)
   self.attributes.id = id
end

function Link:getId()
   return self.attributes.id
end

function Link:setXConnector(xconnector)
   self.attributes.xconnector = xconnector
end

function Link:getXConnector()
   return self.attributes.xconnector
end

function Link:addLinkParam(linkParam)
    table.insert(self.linkParams, linkParam)    
    local p = self:getPosAvailable("linkParam")
    if(p ~= nil)then
       self:addChild(linkParam, p)
    else
       self:addChild(linkParam, 1)
    end
end

function Link:getLinkParam(i)
    return self.linkParams[i]
end

function Link:setLinkParams(...)
    if(#arg>0)then
      for _, linkParam in ipairs(arg) do
          self:addLinkParam(linkParam)
      end
    end
end

function Link:removeLinkParam(linkParam)
   self:removeChild(linkParam)
   
   for i, lp in ipairs(self.linkParams) do
       if(linkParam == lp)then
           table.remove(self.linkParams, i)  
       end
   end 
end

function Link:removeLinkParamPos(i)
   self:removeChildPos(i)
   table.remove(self.linkParams, i)
end

function Link:addBind(bind)
    table.insert(self.binds, bind)    
    local p = self:getPosAvailable("bind")
    if(p ~= nil)then
       self:addChild(bind, p)
    else
       self:addChild(bind, 1)
    end
end

function Link:getBind(i)
    return self.binds[i]
end

function Link:setBinds(...)
    if(#arg>0)then
      for _, bind in ipairs(arg) do
          self:addBind(bind)
      end
    end
end

function Link:removeBind(bind)
   self:removeChild(bind)
   
   for i, bd in ipairs(self.binds) do
       if(bind == bd)then
          table.remove(self.binds, i)  
       end
   end 
end

function Link:removeBindPos(i)
   self:removeChildPos(i)
   table.remove(self.binds, i)
end

return Link