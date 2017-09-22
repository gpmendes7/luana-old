local NCLElem = require "core/NCLElem"

local Media = NCLElem:extends()

Media.name = "media"

Media.attributes = {
  id = nil,  
  src = nil,
  type = nil,
  descriptor = nil
}

function Media:create(attributes)
   local attributes = attributes or {}    
   local media = Media:new()   
   
   media:setAttributes(attributes)
   media:setChilds()
   
   return media
end

function Media:setId(id)
   self.attributes.id = id
end

function Media:getId()
   return self.attributes.id
end

function Media:setSrc(src)
   self.attributes.src = src
end

function Media:getSrc()
   return self.attributes.src
end

function Media:setType(type)
   self.attributes.type = type
end

function Media:getType()
   return self.attributes.type
end

function Media:setDescriptor(descriptor)
   self.attributes.descriptor = descriptor
end

function Media:getDescriptor()
   return self.attributes.descriptor
end

return Media