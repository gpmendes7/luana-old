local NCLElem = require "core/NCLElem"

---
-- Implements Region Class representing <b>&lt;region&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=region">
-- http://handbook.ncl.org.br/doku.php?id=region</a>
-- 
-- @module Region
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local Region = require "core/layout/Region" 
local Region = NCLElem:extends()

---
-- Name of <b>&lt;region&gt;</b> element.
-- 
-- @field [parent=#Region] #string nameElem 
Region.nameElem = "region"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;region&gt;</b> element.
-- 
-- @field [parent=#Region] #table childrenMap
Region.childrenMap = {
  region = {Region, "many"}
}

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;region&gt;</b> element.
-- 
-- @field [parent=#Region] #table attributesTypeMap 
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

---
-- List containing all possible pre-definied symbols to numeric attributes
-- belonging to <b>&lt;region&gt;</b> element.
-- 
-- @field [parent=#Region] #table attributesSymbolMap 
Region.attributesSymbolMap = {
  left = "%",
  right = "%",
  top = "%",
  bottom = "%",
  height = "%",
  width = "%"
}

---
-- Returns a new Region object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#Region] create
-- @param #table attributes list of attributes to be initialized.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #Region new Region object created.
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

---
-- Sets a value to `id` attribute of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] setId
-- @param #string id `id` attribute of the
-- <b>&lt;region&gt;</b> element.
function Region:setId(id)
  self:addAttribute("id", id)
end

---
-- Returns the value of the `id` attribute of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] getId
-- @return #string `id` attribute of the <b>&lt;region&gt;</b> element.
function Region:getId()
  return self:getAttribute("id")
end

---
-- Sets a value to `title` attribute of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] setTitle
-- @param #string title `title` attribute of the
-- <b>&lt;region&gt;</b> element.
function Region:setTitle(title)
  self:addAttribute("title", title)
end

---
-- Returns the value of the `title` attribute of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] getTitle
-- @return #string `title` attribute of the <b>&lt;region&gt;</b> element.
function Region:getTitle()
  return self:getAttribute("title")
end

---
-- Sets a value to `left` attribute of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] setLeft
-- @param #number left `left` attribute of the
-- <b>&lt;region&gt;</b> element.
function Region:setLeft(left)
  self:addAttribute("left", left)
end

---
-- Returns the value of the `left` attribute of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] getLeft
-- @return #number `left` attribute of the <b>&lt;region&gt;</b> element.
function Region:getLeft()
  return self:getAttribute("left")
end

---
-- Sets a value to `right` attribute of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] setRight
-- @param #number right `right` attribute of the
-- <b>&lt;region&gt;</b> element.
function Region:setRight(right)
  self:addAttribute("right", right)
end

---
-- Returns the value of the `right` attribute of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] getRight
-- @return #number `right` attribute of the <b>&lt;region&gt;</b> element.
function Region:getRight()
  return self:getAttribute("right")
end

---
-- Sets a value to `top` attribute of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] setTop
-- @param #number top `top` attribute of the
-- <b>&lt;region&gt;</b> element.
function Region:setTop(top)
  self:addAttribute("top", top)
end

---
-- Returns the value of the `top` attribute of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] getTop
-- @return #number `top` attribute of the <b>&lt;region&gt;</b> element.
function Region:getTop()
  return self:getAttribute("top")
end

---
-- Sets a value to `bottom` attribute of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] setBottom
-- @param #number bottom `bottom` attribute of the
-- <b>&lt;region&gt;</b> element.
function Region:setBottom(bottom)
  self:addAttribute("bottom", bottom)
end

---
-- Returns the value of the `bottom` attribute of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] getBottom
-- @return #number `bottom` attribute of the <b>&lt;region&gt;</b> element.
function Region:getBottom()
  return self:getAttribute("bottom")
end

---
-- Sets a value to `height` attribute of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] setHeight
-- @param #number height `height` attribute of the
-- <b>&lt;region&gt;</b> element.
function Region:setHeight(height)
  self:addAttribute("height", height)
end

---
-- Returns the value of the `height` attribute of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] getHeight
-- @return #number `height` attribute of the <b>&lt;region&gt;</b> element.
function Region:getHeight()
  return self:getAttribute("height")
end

---
-- Sets a value to `width` attribute of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] setWidth
-- @param #number width `width` attribute of the
-- <b>&lt;region&gt;</b> element.
function Region:setWidth(width)
  self:addAttribute("width", width)
end

---
-- Returns the value of the `width` attribute of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] getWidth
-- @return #number `width` attribute of the <b>&lt;region&gt;</b> element.
function Region:getWidth()
  return self:getAttribute("width")
end

---
-- Sets values to `height` and `width` attributes of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] setDim
-- @param #number height `height` attribute of the
-- <b>&lt;region&gt;</b> element.
-- @param #number width `width` attribute of the
-- <b>&lt;region&gt;</b> element.
function Region:setDim(height, width)
  self:setHeight(height)
  self:setWidth(width)
end

---
-- Sets values to `left`, `right`, `top` and `bottom` attributes of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] setPos
-- @param #number left `left` attribute of the
-- <b>&lt;region&gt;</b> element.
-- @param #number right `right` attribute of the
-- <b>&lt;region&gt;</b> element.
-- @param #number top `top` attribute of the
-- <b>&lt;region&gt;</b> element.
-- @param #number bottom `bottom` attribute of the
-- <b>&lt;region&gt;</b> element.
function Region:setPos(left, right, top, bottom)
  self:setLeft(left)
  self:setRight(right)
  self:setTop(top)
  self:setBottom(bottom)
end

---
-- Sets a value to `zIndex` attribute of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] setZIndex
-- @param #number zIndex `zIndex` attribute of the
-- <b>&lt;region&gt;</b> element.
function Region:setZIndex(zIndex)
  self:addAttribute("zIndex", zIndex)
end

---
-- Returns the value of the `zIndex` attribute of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] getZIndex
-- @return #number `zIndex` attribute of the <b>&lt;region&gt;</b> element.
function Region:getZIndex()
  return self:getAttribute("zIndex")
end

---
-- Adds a <b>&lt;region&gt;</b> child element of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] addRegion
-- @param #Region region object representing the 
-- <b>&lt;region&gt;</b> element.
function Region:addRegion(region)
  if((type(region) == "table"
    and region["getNameElem"] ~= nil
    and region:getNameElem() ~= "region")
    or (type(region) == "table"
    and region["getNameElem"] == nil)
    or type(region) ~= "table")then
    error("Error! Invalid region element!", 2)
  end

  self:addChild(region)
  table.insert(self.regions, region)
end

---
-- Returns a <b>&lt;region&gt;</b> child element of the 
-- <b>&lt;region&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Region] getRegionPos
-- @param #number p  position of the object representing 
-- the <b>&lt;region&gt;</b> element.
function Region:getRegionPos(p)
  if(self.regions == nil)then
    error("Error! region element with nil regions list!", 2)
  elseif(p > #self.regions)then
    error("Error! region element doesn't have a region child in position "..p.."!", 2)
  end

  return self.regions[p]
end

---
-- Returns a <b>&lt;region&gt;</b> child element of the 
-- <b>&lt;region&gt;</b> element
-- by `id` attribute.
--  
-- @function [parent=#Region] getRegionById
-- @param #string id `id` attribute of the <b>&lt;region&gt;</b> element.
function Region:getRegionById(id)
  if(id == nil)then
    error("Error! id attribute of region element must be informed!", 2)
  elseif(self.regions == nil)then
    error("Error! region element with nil regions list!", 2)
  end

  for _, region in ipairs(self.regions) do
    if(region:getId() == id)then
      return region
    end
  end

  return nil
end

---
-- Adds so many <b>&lt;region&gt;</b> child elements of the <b>&lt;region&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Region] setRegions
-- @param #Region ... objects representing the <b>&lt;region&gt;</b> element.
function Region:setRegions(...)
  if(#arg>0)then
    for _, region in ipairs(arg) do
      self:addRegion(region)
    end
  end
end

---
-- Removes a <b>&lt;region&gt;</b> child element of the 
-- <b>&lt;region&gt;</b> element. 
-- 
-- @function [parent=#Region] removeRegion
-- @param #Region region object representing the <b>&lt;region&gt;</b> element.
function Region:removeRegion(region)
  if((type(region) == "table"
    and region["getNameElem"] ~= nil
    and region:getNameElem() ~= "region")
    or (type(region) == "table"
    and region["getNameElem"] == nil)
    or type(region) ~= "table")then
    error("Error! Invalid region element!", 2)
  elseif(self.children == nil)then
    error("Error! region element with nil children list!", 2)
  elseif(self.regions == nil)then
    error("Error! region element with nil regions list!", 2)
  end

  self:removeChild(region)

  for p, rg in ipairs(self.regions) do
    if(region == rg)then
      table.remove(self.regions, p)
    end
  end
end

---
-- Removes a <b>&lt;region&gt;</b> child element of the 
-- <b>&lt;region&gt;</b> element in position `p`.
-- 
-- @function [parent=#Region] removeRegionPos
-- @param #number p position of the <b>&lt;region&gt;</b> child element.
function Region:removeRegionPos(p)
  if(self.children == nil)then
    error("Error! region element with nil children list!", 2)
  elseif(self.regions == nil)then
    error("Error! region element with nil regions list!", 2)
  elseif(p > #self.children)then
    error("Error! region element doesn't have a region child in position "..p.."!", 2)
  elseif(p > #self.regions)then
    error("Error! region element doesn't have a region child in position "..p.."!", 2)
  end

  self:removeChild(self.regions[p])
  table.remove(self.regions, p)
end

return Region