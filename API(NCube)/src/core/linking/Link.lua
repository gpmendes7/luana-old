local NCLElem = require "core/NCLElem"
local LinkParam = require "core/linking/LinkParam"
local Bind = require "core/linking/Bind"

local Link = NCLElem:extends()

Link.name = "link"

Link.childrenMap = {
 ["linkParam"] = {LinkParam, "many"},
 ["bind"] = {Bind, "many"}
}

Link.assMap = {
  {"xconnector", "causalConnectorAss"}
}

function Link:create(attributes, full)  
   local link = Link:new() 
   
   link.attributes = {
      ["id"] = "",
      ["xconnector"] = ""
   }
     
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
   self:addAttribute("xconnector", xconnector)
end

function Link:getXConnector()
   return self:getAttribute("xconnector")
end

function Link:setCausalConnectorAss(causalConnectorAss)
   self.causalConnectorAss = causalConnectorAss
end

function Link:getCausalConnectorAss()
   return self.causalConnectorAss
end

function Link:addLinkParam(linkParam)
    table.insert(self.linkParams, linkParam)    
    self:addChild(linkParam)
end

function Link:getLinkParamPos(p)
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
   self:removeChild(linkParam)
   
   for p, lp in ipairs(self.linkParams) do
       if(linkParam == lp)then
           table.remove(self.linkParams, p)  
       end
   end 
end

function Link:removeLinkParamPos(p)
   self:removeChildPos(p)
   table.remove(self.linkParams, p)
end

function Link:addBind(bind)
    table.insert(self.binds, bind)    
    self:addChild(bind)
end

function Link:getBindPos(p)
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
   self:removeChild(bind)
   
   for p, bd in ipairs(self.binds) do
       if(bind == bd)then
          table.remove(self.binds, p)  
       end
   end 
end

function Link:removeBindPos(p)
   self:removeChildPos(p)
   table.remove(self.binds, p)
end

return Link