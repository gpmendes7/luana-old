local NCLElem = require "core/NCLElem"

local Region = NCLElem:extends()

Region.name = "region"

Region.childrenMap = {
  region = {Region, "many"}
}

Region.attributesTypeMap = {
  id = "string",
  title = "string",
  left = "number",
  right = "number",
  top = "number",
  bottom = "number",
  height = "number",
  width = "number",
  zIndex = "number"
}

Region.attributesSymbolMap = {
  left = "%",
  right = "%",
  top = "%",
  bottom = "%",
  height = "%",
  width = "%"
}

function Region:create(attributes, full)
  local region = Region:new()

  region.id = nil
  region.title = nil
  region.left = nil
  region.right = nil
  region.top = nil
  region.bottom = nil
  region.height = nil
  region.width = nil
  region.zIndex = nil
  
  region.symbols = {}
  
  region.ass = {}

  if(attributes ~= nil)then
    region:setAttributes(attributes)
  end

  region.children = {}
  region.regions = {}

  if(full ~= nil)then
    region:addRegion(Region:create())
  end

  return region
end

function Region:setId(id)
  self:addAttribute("id", id)
end

function Region:getId()
  return self:getAttribute("id")
end

function Region:setTitle(title)
  self:addAttribute("title", title)
end

function Region:getTitle()
  return self:getAttribute("title")
end

function Region:setLeft(left)
  self:addAttribute("left", left)
end

function Region:getLeft()
  return self:getAttribute("left")
end

function Region:setRight(right)
  self:addAttribute("right", right)
end

function Region:getRight()
  return self:getAttribute("right")
end

function Region:setTop(top)
  self:addAttribute("top", top)
end

function Region:getTop()
  return self:getAttribute("top")
end

function Region:setBottom(bottom)
  self:addAttribute("bottom", bottom)
end

function Region:getBottom()
  return self:getAttribute("bottom")
end

function Region:setHeight(height)
  self:addAttribute("height", height)
end

function Region:getHeight()
  return self:getAttribute("height")
end

function Region:setWidth(width)
  self:addAttribute("width", width)
end

function Region:getWidth()
  return self:getAttribute("width")
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
  self:addAttribute("zIndex", zIndex)
end

function Region:getZIndex()
  return self:getAttribute("zIndex")
end

function Region:addRegion(region)
  self:addChild(region)
  table.insert(self.regions, region)
end

function Region:getRegionPos(p)
  if(p > #self.regions)then
    error("Error! region element doesn't have a region child in position "..p.."!", 2)
  end

  return self.regions[p]
end

function Region:getRegionById(id)
  if(id == nil)then
    error("Error! id attribute of region element must be informed!", 2)
  end
  
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

  for p, rg in ipairs(self.regions) do
    if(region == rg)then
      table.remove(self.regions, p)
    end
  end
end

function Region:removeRegionPos(p)
  self:removeChildPos(p)
  table.remove(self.regions, p)
end

return Region