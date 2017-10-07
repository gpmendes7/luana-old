local NCLElem = require "core/structure_content/NCLElem"
local Port = require "core/interface/Port"
local Media = require "core/structure_content/Media"
local Link = require "core/linking/Link"

local Body = NCLElem:extends()

Body.name = "body"

Body.childrenMap = {
 ["port"] = {Port, "many"}, 
 ["media"] = {Media, "many"},
 ["link"] = {Link, "many"}
}

Body.ports = nil
Body.medias = nil

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
   body.medias = {}
   
   if(full ~= nil)then
      body:addPort(Port:create()) 
      body:addMedia(Media:create()) 
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

function Body:addLink(link)
   table.insert(self.links, link)    
   self:addChild(link)
end

function Body:getLinkPos(i)
   return self.links[i]
end

function Body:getLinkById(id)
   for _, link in ipairs(self.link) do
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