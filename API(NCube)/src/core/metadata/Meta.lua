local NCLElem = require "core/NCLElem"

local Meta = NCLElem:extends()

Meta.name = "meta"

function Meta:create(attributes)
   local meta = Meta:new()
   
   meta.attributes = { 
    ["name"] = "",
    ["content"] = ""
   }
   
   if(attributes ~= nil)then
      meta:setAttributes(attributes)
   end
   
   return meta
end

function Meta:setName(name)
    self:addAttribute("name", name)
end

function Meta:getName()
   return self:getAttribute("name")
end

function Meta:setContent(content)
    self:addAttribute("content", content)
end

function Meta:getContent()
   return self:getAttribute("content")
end

return Meta