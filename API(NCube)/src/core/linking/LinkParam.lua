local NCLElem = require "core/content/NCLElem"

local LinkParam = NCLElem:extends()

LinkParam.name = "linkParam"

function LinkParam:create(attributes)  
   local attributes = attributes or {}  
   local linkParam = LinkParam:new() 
   
   linkParam.attributes = {
      ["name"] = "",
      ["value"] = ""
   }
   
   if(attributes ~= nil)then
      linkParam:setAttributes(attributes)
   end
      
   return linkParam
end

function LinkParam:setName(name)
   self:addAttribute("name", name)
end

function LinkParam:getName()
   return self:getAttribute("name")
end

function LinkParam:setValue(value)
   self:addAttribute("value", value)
end

function LinkParam:getValue()
   return self:getAttribute("value")
end

return LinkParam