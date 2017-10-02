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
   
   if(full ~= nil)then
      bind:addBindParam(BindParam:create())     
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

function Bind:getLinkParam(i)
    return self.linkParams[i]
end

function Bind:setLinkParams(...)
    if(#arg>0)then
      for i, v in ipairs(arg) do
          self:addLinkParam(v)
      end
    end
end

function Bind:removeLinkParam(linkParam)
   self:removeChild(linkParam)
end

function Bind:removeBindParamPos(i)
   self:removeChild(self.bindParams[i])
end

return Link