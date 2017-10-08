local NCLElem = require "core/structure_content/NCLElem"
local Port = require "core/interface/Port"
local Property = require "core/interface/Property"
local Media = require "core/structure_content/Media"
local Link = require "core/linking/Link"

local Context = NCLElem:extends()

Context.name = "context"

Context.childrenMap = {
 ["port"] = {Port, "many"},
 ["property"] = {Property, "many"},  
 ["media"] = {Media, "many"},
 ["context"] = {Context, "many"},
 ["link"] = {Link, "many"}
}

function Context:create(attributes, full)
   local context = Context:new()
   
   context.attributes = { 
    ["id"] = "",
    ["refer"] = ""
   }
   
   if(attributes ~= nil)then
      context:setAttributes(attributes)
   end
   
   context.children = {}  
   context.ports = {}
   context.propertys = {}
   context.medias = {}
   context.contexts = {}
   context.links = {}
   
   if(full ~= nil)then
      context:addPort(Port:create()) 
      context:addProperty(Property:create()) 
      context:addMedia(Media:create(nil, full))
      context:addContext(Context:create())  
      context:addLink(Link:create(nil, full))  
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
    self:addAttribute("refer", refer)
end

function Context:getRefer()
   return self:getAttribute("refer")
end

function Context:addPort(port)
   table.insert(self.ports, port)    
   self:addChild(port)
end

function Context:getPortPos(i)
   return self.ports[i]
end

function Context:getPortById(id)
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
   
   for i, pt in ipairs(self.ports) do
       if(port == pt)then
           table.remove(self.ports, i)  
       end
   end 
end

function Context:removePortPos(i)
   self:removeChildPos(i)
   table.remove(self.ports, i)
end

function Context:addProperty(property)
   table.insert(self.propertys, property)    
   self:addChild(property)
end

function Context:getProperty(i)
    return self.propertys[i]
end

function Context:getpropertyByName(name)
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

function Context:addMedia(media)
   table.insert(self.medias, media)    
   self:addChild(media)
end

function Context:getMediaPos(i)
   return self.medias[i]
end

function Context:getMediaById(id)
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
   
   for i, md in ipairs(self.medias) do
       if(media == md)then
           table.remove(self.medias, i)  
       end
   end 
end

function Context:removeMediaPos(i)
   self:removeChildPos(i)
   table.remove(self.medias, i)
end

function Context:addContext(context)
   table.insert(self.contexts, context)    
   self:addChild(context)
end

function Context:getContextPos(i)
   return self.contexts[i]
end

function Context:getContextById(id)
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
   
   for i, ct in ipairs(self.contexts) do
       if(context == ct)then
           table.remove(self.contexts, i)  
       end
   end 
end

function Context:removeContextPos(i)
   self:removeChildPos(i)
   table.remove(self.contexts, i)
end

function Context:addLink(link)
   table.insert(self.links, link)    
   self:addChild(link)
end

function Context:getLinkPos(i)
   return self.links[i]
end

function Context:getLinkById(id)
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
   
   for i, lk in ipairs(self.links) do
       if(link == lk)then
           table.remove(self.links, i)  
       end
   end 
end

function Context:removeLinkPos(i)
   self:removeChildPos(i)
   table.remove(self.links, i)
end


return Context