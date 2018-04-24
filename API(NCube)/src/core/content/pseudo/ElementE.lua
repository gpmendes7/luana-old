local NCLElem = require "core/NCLElem"

local ElementE = NCLElem:extends()

ElementE.nameElem = "elementE"

ElementE.attributesTypeMap = {
  ["id"] = "string",
  ["desc"] = "string"
}

function ElementE:create(attributes)
   local elementE = ElementE:new()   
   
   elementE.id = nil
   elementE.desc = nil
   
   if(attributes ~= nil)then
      elementE:setAttributes(attributes)
   end
         
   return elementE
end

function ElementE:setId(id)
   self:addAttribute("id", id)
end

function ElementE:getId()
   return self:getAttribute("id")
end

function ElementE:setDesc(desc)
   self:addAttribute("desc", desc)
end

function ElementE:getDesc()
   return self:getAttribute("desc")
end

return ElementE