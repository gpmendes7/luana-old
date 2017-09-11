local NCLElem = require "core/NCLElem"

local Port = require "core/Port"
local Media = require "core/Media"

local Body = Class:createClass(NCLElem)

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
Body.seq = false

function Body:create(attributes, full)
   local attributes = attributes or {}  
   local body = Body:new()
   
   body:setAttributes(attributes)
   body:setChilds()  
   
   if(full ~= nil)then
      body.ports = {}
      body:addChild({} , 1)
      
      body.medias = {}
      body:addChild({} , 2)
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
   table.insert(self:getChild(1), port)
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
   table.insert(self:getChild(2), media)
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