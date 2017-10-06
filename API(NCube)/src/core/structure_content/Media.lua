local NCLElem = require "core/structure_content/NCLElem"
local Area = require "core/interface/Area"

local Media = NCLElem:extends()

Media.name = "media"

Media.childsMap = {
 ["area"] = {Area, "many"}
}

Media.areas = nil

function Media:create(attributes)
   local media = Media:new()   
   
   media.attributes = {
      ["id"] = "",  
      ["src"] = "",
      ["type"] = "",
      ["descriptor"] = ""
   }
      
   if(attributes ~= nil)then
      media:setAttributes(attributes)
   end
   
   media.childs = {}
   media.areas = {}
      
   return media
end

function Media:setId(id)
   self:addAttribute("id", id)
end

function Media:getId()
   return self:getAttribute("id")
end

function Media:setSrc(src)
   self:addAttribute("src", src)
end

function Media:getSrc()
   return self:getAttribute("src")
end

function Media:setType(type)
   self:addAttribute("type", type)
end

function Media:getType()
   return self:getAttribute("type")
end

function Media:setDescriptor(descriptor)
   self:addAttribute("descriptor", descriptor)
end

function Media:getDescriptor()
   return self:getAttribute("descriptor", descriptor)
end

function Media:addArea(area)
    table.insert(self.areas, area)    
    local p = self:getPosAvailable("area")
    if(p ~= nil)then
       self:addChild(area, p)
    else
       self:addChild(area, 1)
    end
end

function Media:getArea(i)
    return self.areas[i]
end

function Media:getAreaById(id)
   for _, area in ipairs(self.areas) do
       if(area:getId() == id)then
          return area
       end
   end
   
   return nil
end

function Media:setAreas(...)
    if(#arg>0)then
      for _, area in ipairs(arg) do
          self:addArea(area)
      end
    end
end

function Media:removeArea(area)
   self:removeChild(area)
   
   for i, ar in ipairs(self.areas) do
       if(area == ar)then
           table.remove(self.areas, i)  
       end
   end    
end

function Media:removeAreaPos(i)
   self:removeChildPos(i)
   table.remove(self.areas, i)
end

return Media