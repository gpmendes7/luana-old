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
 ["port"] = {Port, "many"}, 
 ["property"] = {Property, "many"},
 ["media"] = {Media, "many"},
 ["context"] = {Context, "many"},
 ["switch"] = {Switch, "many"},
 ["link"] = {Link, "many"},
 ["meta"] = {Meta, "many"},
 ["metadata"] = {MetaData, "many"}
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
   table.insert(self.ports, port)    
   local p = self:getPosAvailable("link")
   if(p ~= nil)then
      self:addChild(port, p-1)
   else
      self:addChild(port)
   end
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
   table.insert(self.propertys, property)    
   local p = self:getPosAvailable("link")
   if(p ~= nil)then
      self:addChild(property, p-1)
   else
      self:addChild(property)
   end  
end

function Body:getPropertyPos(p)
    return self.propertys[p]
end

function Body:getPropertyByName(name)
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
   table.insert(self.medias, media)    
   local p = self:getPosAvailable("link")
   if(p ~= nil)then
      self:addChild(media, p-1)
   else
      self:addChild(media)
   end     
end

function Body:getMediaPos(p)
   return self.medias[p]
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
   table.insert(self.contexts, context)    
   local p = self:getPosAvailable("link")
   if(p ~= nil)then
      self:addChild(context, p-1)
   else
      self:addChild(context)
   end       
end

function Body:getContextPos(p)
   return self.contexts[p]
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
   table.insert(self.switchs, switch)    
   local p = self:getPosAvailable("link")
   if(p ~= nil)then
      self:addChild(switch, p-1)
   else
      self:addChild(switch)
   end       
end

function Body:getSwitchPos(p)
   return self.switchs[p]
end

function Body:getSwitchById(id)
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
   
   for p, ct in ipairs(self.switchs) do
       if(switch == ct)then
           table.remove(self.switchs, p)  
       end
   end 
end

function Body:removeSwitchPos(p)
   self:removeChildPos(p)
   table.remove(self.switchs, p)
end


function Body:addLink(link)
   table.insert(self.links, link)    
   local p = self:getPosAvailable("link")
   if(p ~= nil)then
      self:addChild(link, p)
   else
      self:addChild(link)
   end          
end

function Body:getLinkPos(p)
   return self.links[p]
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
   table.insert(self.metas, meta)    
   local p = self:getPosAvailable("link")
   if(p ~= nil)then
      self:addChild(meta, p-1)
   else
      self:addChild(meta)
   end          
end

function Body:getMetaPos(i)
   return self.metas[i]
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
   table.insert(self.metadatas, metadata)  
   local p = self:getPosAvailable("meta", "connectorBase", "descriptorBase", "regionBase", 
                                  "transitionBase", "ruleBase", "importedDocumentBase")          
   if(p ~= nil)then
      self:addChild(metadata, p-1)
   else
      self:addChild(metadata, 1)
   end    
end

function Body:getMetaDataPos(p)
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