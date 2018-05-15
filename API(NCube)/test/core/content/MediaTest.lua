local Media = require "core/content/Media"
local Area = require "core/interface/Area"
local Property = require "core/interface/Property"

local function test1()
   local media = Media:create()
   
   assert(media ~= nil, "Error!")
   assert(media:getId() == nil, "Error!")
   assert(media:getSrc() == nil, "Error!") 
   assert(media:getType() == nil, "Error!")  
   assert(media:getRefer() == nil, "Error!") 
   assert(media:getInstance() == nil, "Error!")    
   assert(media:getDescriptor() == nil, "Error!") 
end

local function test2()
   local media = nil
   
   local atts = { 
      ["id"] = "m1",  
      ["src"] = "img1.png",
      ["type"] = "type1",
      ["refer"] = "reference",
      ["instance"] = "inst",
      ["descriptor"] = "d1"
   }
   
   media = Media:create(atts)
   assert(media:getId() == "m1", "Error!")
   assert(media:getSrc() == "img1.png", "Error!") 
   assert(media:getType() == "type1", "Error!")  
   assert(media:getRefer() == "reference", "Error!") 
   assert(media:getInstance() == "inst", "Error!")    
   assert(media:getDescriptor() == "d1", "Error!") 
end

local function test3()
   local media = nil
      
   media = Media:create()
   
   media:setId("m1")
   media:setSrc("img1.png") 
   media:setType("type1")  
   media:setRefer("reference") 
   media:setInstance("inst")    
   media:setDescriptor("d1") 
   
   assert(media:getId() == "m1", "Error!")
   assert(media:getSrc() == "img1.png", "Error!") 
   assert(media:getType() == "type1", "Error!")  
   assert(media:getRefer() == "reference", "Error!") 
   assert(media:getInstance() == "inst", "Error!")    
   assert(media:getDescriptor() == "d1", "Error!") 
end

local function test4()
   local media = nil
      
   media = Media:create(nil, 1)
   assert(media:getAreaPos(1) ~= nil, "Error!")
   assert(media:getPropertyPos(1) ~= nil, "Error!")
   
   media:addArea(Area:create())
   assert(media:getAreaPos(2) ~= nil, "Error!")
   
   media:addProperty(Property:create())
   assert(media:getPropertyPos(2) ~= nil, "Error!")
   
   media:addArea(Area:create{["id"] = "a1"})
   assert(media:getAreaById("a1") ~= nil, "Error!")   
   
   media:addProperty(Property:create{["name"] = "sound"})
   assert(media:getPropertyByName("sound") ~= nil, "Error!")   
end

local function test5()
   local media = Media:create{["id"] = "m1"}
   local area = Area:create{["id"] = "a1"}
   local property = Property:create{["name"] = "sound"}
 
   media:addArea(area)    
   media:removeArea(area)
   assert(media:getAreaById("a1") == nil, "Error!")
   
   media:addArea(area)    
   media:removeAreaPos(1)
   assert(media:getAreaById("a1") == nil, "Error!")
   
   media:addProperty(property)    
   media:removeProperty(property)
   assert(media:getPropertyByName("sound") == nil, "Error!")
   
   media:addProperty(property)    
   media:removePropertyPos(1)
   assert(media:getPropertyByName("sound") == nil, "Error!")
end

local function test6()
   local media = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
      ["id"] = "media1",  
      ["src"] = "img1.png",
      ["type"] = "type1",
      ["refer"] = "reference",
      ["instance"] = "inst",
      ["descriptor"] = "d1"
   }    
      
   media = Media:create(atts)
   
   nclExp = "<media"   
   for attribute, value in pairs(media:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
   
   nclExp = nclExp.."/>\n"

   nclRet = media:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

local function test7()
   local media = nil
   
   local area, property = nil
   
   local nclExp, nclRet = nil
   
   media = Media:create{["id"] = "m1"}
   nclExp = "<media id=\"m1\">\n"
      
   area = Area:create{["id"] = "a1"}
   nclExp = nclExp.." <area id=\"a1\"/>\n"  
   
   property = Property:create{["name"] = "sound"}
   nclExp = nclExp.." <property name=\"sound\"/>\n"   
   
   nclExp = nclExp.."</media>\n"  

   media:addArea(area)
   media:addProperty(property)      
   
   nclRet = media:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()
test7()
