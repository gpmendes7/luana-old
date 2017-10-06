local NCLElem = require "core/structure_content/NCLElem"

local Region = NCLElem:extends()

Region.name = "region"

Region.childsMap = {
 ["region"] = {Region, "many"}
}

Region.regions = nil 

function Region:create(attributes, full)
   local region = Region:new() 
   
   region.attributes = {
      ["id"] = "", 
      ["title"] = "", 
      ["left"] = "", 
      ["right"] = "", 
      ["top"] = "", 
      ["bottom"] = "", 
      ["height"] = "", 
      ["width"] = "", 
      ["zIndex"] = ""
   }     
   
   if(attributes ~= nil)then
      region:setAttributes(attributes)
   end
   
   region.childs = {}
   region.regions = {}
   
   if(full ~= nil)then
      region:addRegion(Region:create())
   end
   
   return region
end

function Region:setId(id)
   self.attributes.id = id
end

function Region:getId()
   return self.attributes.id
end

function Region:setTitle(title)
   self.attributes.title = title
end

function Region:getTitle()
   return self.attributes.title
end

function Region:setLeft(left)
   self.attributes.left = left
end

function Region:getLeft()
   return self.attributes.left
end

function Region:setRight(right)
   self.attributes.right = right
end

function Region:getRight()
   return self.attributes.right
end

function Region:setTop(top)
   self.attributes.top = top
end

function Region:getTop()
   return self.attributes.top
end

function Region:setBottom(bottom)
   self.attributes.bottom = bottom
end

function Region:getBottom()
   return self.attributes.bottom
end

function Region:setHeight(height)
   self.attributes.height = height
end

function Region:getHeight()
   return self.attributes.height
end

function Region:setWidth(width)
   self.attributes.width = width
end

function Region:getWidth()
   return self.attributes.width
end

function Region:setDim(height, width) 
   self:setHeight(height)
   self:setWidth(width)
end

function Region:setPos(left, right, top, bottom) 
   self:setLeft(left)
   self:setRight(right)
   self:setTop(top)
   self:setBottom(bottom)
end

function Region:setZIndex(zIndex)
   self.attributes.zIndex = zIndex
end

function Region:getZIndex()
   return self.attributes.zIndex
end

function Region:addRegion(region)
    table.insert(self.regions, region)    
    local p = self:getPosAvailable("region")
    if(p ~= nil)then
       self:addChild(region, p)
    else
       self:addChild(region, 1)
    end
end

function Region:getRegion(i)
    return self.regions[i]
end

function Region:getRegionById(id)
   for _, region in ipairs(self.regions) do
       if(region:getId() == id)then
          return region
       end
   end
   
   return nil
end

function Region:setRegions(...)
    if(#arg>0)then
      for _, region in ipairs(arg) do
          self:addRegion(region)
      end
    end
end

function Region:removeRegion(region)
   self:removeChild(region)
      
   for i, rg in ipairs(self.regions) do
       if(region == rg)then
           table.remove(self.regions, i)  
       end
   end 
end

function Region:removeRegionPos(i)
   self:removeChildPos(i)
   table.remove(self.regions, i)
end

return Region