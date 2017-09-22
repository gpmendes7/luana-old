local NCLElem = require "core/NCLElem"
local Port = require "core/interface/Port"
local Media = require "core/content/Media"

local Body = NCLElem:extends()

Body.name = "body"

Body.attributes = { 
  id = nil
}

Body.childsMap = {
 ["port"] = {Port, "many", 1}, 
 ["media"] = {Media, "many", 2}
}

Body.ports = nil
Body.medias = nil

function Body:create(attributes, full)
   local attributes = attributes or {}  
   local body = Body:new()
   
   body:setAttributes(attributes)
   body:setChilds()  
   body.ports = {}
   body.medias = {}
   
   if(full ~= nil)then
      body:addPort(Port:create()) 
      body:addMedia(Media:create()) 
   end
   
   return body
end

function Body:setId(id)
   self.attributes.id = id
end

function Body:getId()
   return self.attributes.id
end

function Body:addPort(port)
   table.insert(self.ports, port)    
   self:addChild(port)
end

function Body:getPort(i)
   return self.ports[i]
end

function Body:getPortById(id)
   for i, v in ipairs(self.ports) do
       if(self.ports[i]:getId() == id)then
          return self.ports[i]
       end
   end
   
   return nil
end

function Body:setPorts(...)
    if(#arg>0)then
      for i, v in ipairs(arg) do
          self:addPort(v)
      end
    end
end

function Body:addMedia(media)
   table.insert(self.medias, media)    
   self:addChild(media)
end

function Body:getMedia(i)
   return self.medias[i]
end

function Body:getMediaById(id)
   for i, v in ipairs(self.medias) do
       if(self.medias[i]:getId() == id)then
          return self.medias[i]
       end
   end
   
   return nil
end

function Body:setMedias(...)
    if(#arg>0)then
      for i, v in ipairs(arg) do
         self:addMedia(v)
      end
    end
end

return Body