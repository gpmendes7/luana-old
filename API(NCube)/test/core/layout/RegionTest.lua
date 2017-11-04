local Region = require "core/layout/Region"

local function test1()
   local region = nil
   
   region = Region:create()
   assert(region ~= nil, "Error!")
   assert(region:getId() == "", "Error!")    
end

local function test2()
   local region = nil
   
   local atts = {
      ["id"] = "region", 
      ["title"] = "title", 
      ["left"] = "50%", 
      ["right"] = "25%", 
      ["top"] = "50%", 
      ["bottom"] = "25%", 
      ["height"] = "80%", 
      ["width"] = "80%", 
      ["zIndex"] = "3"
   }     
   
   region = Region:create(atts)
   assert(region:getId() == "region", "Error!")
   assert(region:getTitle() == "title", "Error!")
   assert(region:getLeft() == "50%", "Error!")
   assert(region:getRight() == "25%", "Error!")
   assert(region:getTop() == "50%", "Error!")
   assert(region:getBottom() == "25%", "Error!")
   assert(region:getHeight() == "80%", "Error!")
   assert(region:getWidth() == "80%", "Error!")
   assert(region:getZIndex() == "3", "Error!")
end

local function test3()
   local region = nil
      
   region = Region:create()
   
   region:setId("region")
   region:setTitle("title")
   region:setLeft("50%")
   region:setRight("25%")
   region:setTop("50%")
   region:setBottom("25%")
   region:setHeight("80%")
   region:setWidth("80%")
   region:setZIndex("3")
   
   assert(region:getId() == "region", "Error!")
   assert(region:getTitle() == "title", "Error!")
   assert(region:getLeft() == "50%", "Error!")
   assert(region:getRight() == "25%", "Error!")
   assert(region:getTop() == "50%", "Error!")
   assert(region:getBottom() == "25%", "Error!")
   assert(region:getHeight() == "80%", "Error!")
   assert(region:getWidth() == "80%", "Error!")
   assert(region:getZIndex() == "3", "Error!")
   
   region:setPos("13.5%", "18.7%", "22.3%", "17.8%")
   assert(region:getLeft() == "13.5%", "Error!")
   assert(region:getRight() == "18.7%", "Error!")
   assert(region:getTop() == "22.3%", "Error!")
   assert(region:getBottom() == "17.8%", "Error!")
   
   region:setDim("40%", "30%")
   assert(region:getHeight() == "40%", "Error!")
   assert(region:getWidth() == "30%", "Error!")
end

local function test4()
   local region = nil
      
   region = Region:create(nil, 1)
   assert(region:getRegionPos(1) ~= nil, "Error!")
   
   region:addRegion(Region:create())
   assert(region:getRegionPos(2) ~= nil, "Error!")
   
   region:addRegion(Region:create{["id"] = "rg2"})
   assert(region:getRegionById("rg2") ~= nil, "Error!")
end

local function test5()
   local region1 = Region:create{["id"] = "region1"}
   local region2 = Region:create{["id"] = "region2"}
   local region3 = Region:create{["id"] = "region3"}
   local region4 = Region:create{["id"] = "region4"}
   
   region1:setRegions(region2, region3, region4)
   assert(region1:getRegionById("region2") ~= nil, "Error!")
   assert(region1:getRegionById("region3") ~= nil, "Error!")
   assert(region1:getRegionById("region4") ~= nil, "Error!")
   
   region1:removeRegion(region2)
   assert(region1:getRegionById("region2") == nil, "Error!")
   
   region1:removeRegionPos(1)
   assert(region1:getRegionById("region3") == nil, "Error!")
end

test1()
test2()
test3()
test4()
test5()