local NCLElem = require "core/NCLElem"

local Property = NCLElem:extends()

Property.name = "property"

function Property:create(attributes)  
   local property = Property:new()   
   
   property.attributes = {
      ["name"] = "", 
      ["value"] = "", 
      ["externable"] = ""
   }
   
   if(attributes ~= nil)then
      property:setAttributes(attributes)
   end
   
   return property
end

function Property:setAttName(name)
   self:addAttribute("name", name)
end

function Property:getAttName()
   return self:getAttribute("name")
end

function Property:setAttValue(value)
   self:addAttribute("value", value)
end

function Property:getAttValue()
   return self:getAttribute("value")
end

function Property:setExternable(externable)
   self:addAttribute("externable", externable)
end

function Property:getExternable()
   return self:getAttribute("externable")
end

return Property