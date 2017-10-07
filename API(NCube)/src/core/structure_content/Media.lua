local NCLElem = require "core/structure_content/NCLElem"
local Area = require "core/interface/Area"
local Property = require "core/interface/Property"

local Media = NCLElem:extends()

Media.name = "media"

Media.childrenMap = {
 ["area"] = {Area, "many"},
 ["property"] = {Property, "many"}
}

Media.areas = nil
Media.propertys = nil

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
   
   media.children = {}
   media.areas = {}
   media.propertys = {}
      
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
   return self:getAttribute("descriptor")
end

function Media:addArea(area)
    table.insert(self.areas, area)    
    local p = self:getPosAvailable("area", "property")
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

function Media:addProperty(property)
    table.insert(self.propertys, property)    
    local p = self:getPosAvailable("property", "area")
    if(p ~= nil)then
       self:addChild(property, p)
    else
       self:addChild(property, 1)
    end
end

function Media:getProperty(i)
    return self.propertys[i]
end

function Media:getpropertyByName(name)
   for _, property in ipairs(self.propertys) do
       if(property:getName() == name)then
          return property
       end
   end
   
   return nil
end

function Media:setPropertys(...)
    if(#arg>0)then
      for _, property in ipairs(arg) do
          self:addProperty(property)
      end
    end
end

function Media:removeProperty(property)
   self:removeChild(property)
   
   for i, pr in ipairs(self.propertys) do
       if(property == pr)then
           table.remove(self.propertys, i)  
       end
   end    
end

function Media:removePropertyPos(i)
   self:removeChildPos(i)
   table.remove(self.propertys, i)
end

return Media