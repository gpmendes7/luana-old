local NCLElem = require "core/structure_content/NCLElem"
local Port = require "core/interface/Port"
local Property = require "core/interface/Property"
local Media = require "core/structure_content/Media"
local Context = require "core/structure_content/Context"
local Link = require "core/linking/Link"

local Body = NCLElem:extends()

Body.name = "body"

Body.childrenMap = {
 ["port"] = {Port, "many"}, 
 ["property"] = {Property, "many"},
 ["media"] = {Media, "many"},
 ["context"] = {Context, "many"},
 ["link"] = {Link, "many"}
}

function Body:create(attributes, full)
   local body = Body:new()
   
   body.attributes = { 
    ["id"] = ""
   }
   
   if(attributes ~= nil)then
      body:setAttributes(attributes)
   end
   
   body.children = {}  
   body.ports = {}
   body.propertys = {}
   body.medias = {}
   body.contexts = {}
   body.links = {}
   
   if(full ~= nil)then
      body:addPort(Port:create()) 
      body:addProperty(Property:create()) 
      body:addMedia(Media:create(nil, full))
      body:addContext(Context:create(nil, full))  
      body:addLink(Link:create(nil, full)) 
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
   table.insert(self.ports, port)    
   self:addChild(port)
end

function Body:getPortPos(i)
   return self.ports[i]
end

function Body:getPortById(id)
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
   
   for i, pt in ipairs(self.ports) do
       if(port == pt)then
           table.remove(self.ports, i)  
       end
   end 
end

function Body:removePortPos(i)
   self:removeChildPos(i)
   table.remove(self.ports, i)
end

function Body:addProperty(property)
   table.insert(self.propertys, property)    
   self:addChild(property)
end

function Body:getProperty(i)
    return self.propertys[i]
end

function Body:getpropertyByName(name)
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
   
   for i, pr in ipairs(self.propertys) do
       if(property == pr)then
           table.remove(self.propertys, i)  
       end
   end    
end

function Media:removePropertyPos(i)
   self:removeChildPos(i)
   table.remove(self.propertys, i)
end

function Body:addMedia(media)
   table.insert(self.medias, media)    
   self:addChild(media)
end

function Body:getMediaPos(i)
   return self.medias[i]
end

function Body:getMediaById(id)
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
   
   for i, md in ipairs(self.medias) do
       if(media == md)then
           table.remove(self.medias, i)  
       end
   end 
end

function Body:removeMediaPos(i)
   self:removeChildPos(i)
   table.remove(self.medias, i)
end

function Body:addContext(context)
   table.insert(self.contexts, context)    
   self:addChild(context)
end

function Body:getContextPos(i)
   return self.contexts[i]
end

function Body:getContextById(id)
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
   
   for i, ct in ipairs(self.contexts) do
       if(context == ct)then
           table.remove(self.contexts, i)  
       end
   end 
end

function Body:removeContextPos(i)
   self:removeChildPos(i)
   table.remove(self.contexts, i)
end

function Body:addLink(link)
   table.insert(self.links, link)    
   self:addChild(link)
end

function Body:getLinkPos(i)
   return self.links[i]
end

function Body:getLinkById(id)
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
   
   for i, lk in ipairs(self.links) do
       if(link == lk)then
           table.remove(self.links, i)  
       end
   end 
end

function Body:removeLinkPos(i)
   self:removeChildPos(i)
   table.remove(self.links, i)
end


return Body