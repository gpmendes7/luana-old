local Descriptor = require "core/layout/Descriptor"
local DescriptorParam = require "core/layout/DescriptorParam"

local function test1()
   local descriptor = nil
   
   descriptor = Descriptor:create()
   assert(descriptor ~= nil, "Error!")
   assert(descriptor:getId() == "", "Error!")
   assert(descriptor:getPlayer() == "", "Error!")     
   assert(descriptor:getExplicitDur() == "", "Error!")   
   assert(descriptor:getRegion() == "", "Error!") 
   assert(descriptor:getRegionAss() == nil, "Error!")     
   assert(descriptor:getFreeze() == "", "Error!")   
   assert(descriptor:getMoveLeft() == "", "Error!")
   assert(descriptor:getMoveRight() == "", "Error!")   
   assert(descriptor:getMoveUp() == "", "Error!")    
   assert(descriptor:getMoveDown() == "", "Error!")     
   assert(descriptor:getFocusIndex() == "", "Error!")  
   assert(descriptor:getFocusBorderColor() == "", "Error!")    
   assert(descriptor:getFocusBorderWidth() == "", "Error!") 
   assert(descriptor:getFocusBorderTransparency() == "", "Error!")    
   assert(descriptor:getFocusSrc() == "", "Error!")    
   assert(descriptor:getFocusSelSrc() == "", "Error!")  
   assert(descriptor:getSelBorderColor() == "", "Error!")    
   assert(descriptor:getTransIn() == "", "Error!") 
   assert(descriptor:getTransOut() == "", "Error!")     
end

local function test2()
   local descriptor = nil
   
   local atts = {
      ["id"] = "descriptor", 
      ["player"] = "player",
      ["explicitDur"] = "3s", 
      ["region"] = "region",
      ["freeze"] = "true",
      ["moveLeft"] = "3", 
      ["moveRight"] = "1", 
      ["moveUp"] = "1", 
      ["moveDown"] = "3", 
      ["focusIndex"] = "2", 
      ["focusBorderColor"] = "white", 
      ["focusBorderWidth"] = "3", 
      ["focusBorderTransparency"] = "0.5", 
      ["focusSrc"] = "media/imagem1.gif", 
      ["focusSelSrc"] = "media/imagem2.gif", 
      ["selBorderColor"] = "white", 
      ["transIn"] = "transition1", 
      ["transOut"] = "transition2"
   }     
   
   descriptor = Descriptor:create(atts)
   assert(descriptor ~= nil, "Error!")
   assert(descriptor:getId() == "descriptor", "Error!")
   assert(descriptor:getPlayer() == "player", "Error!")     
   assert(descriptor:getExplicitDur() == "3s", "Error!")   
   assert(descriptor:getRegion() == "region", "Error!") 
   assert(descriptor:getFreeze() == "true", "Error!")   
   assert(descriptor:getMoveLeft() == "3", "Error!")
   assert(descriptor:getMoveRight() == "1", "Error!")   
   assert(descriptor:getMoveUp() == "1", "Error!")    
   assert(descriptor:getMoveDown() == "3", "Error!")     
   assert(descriptor:getFocusIndex() == "2", "Error!")  
   assert(descriptor:getFocusBorderColor() == "white", "Error!")    
   assert(descriptor:getFocusBorderWidth() == "3", "Error!") 
   assert(descriptor:getFocusBorderTransparency() == "0.5", "Error!")    
   assert(descriptor:getFocusSrc() == "media/imagem1.gif", "Error!")    
   assert(descriptor:getFocusSelSrc() == "media/imagem2.gif", "Error!")  
   assert(descriptor:getSelBorderColor() == "white", "Error!")    
   assert(descriptor:getTransIn() == "transition1", "Error!") 
   assert(descriptor:getTransOut() == "transition2", "Error!") 
end

local function test3()
   local descriptor = nil
      
   descriptor = Descriptor:create()
   
   descriptor:setId("descriptor")
   descriptor:setPlayer("player")
   descriptor:setExplicitDur("3s")
   descriptor:setRegion("region")
   descriptor:setFreeze("true")
   descriptor:setMoveLeft("3")
   descriptor:setMoveRight("1")
   descriptor:setMoveUp("1")
   descriptor:setMoveDown("3")     
   descriptor:setFocusIndex("2") 
   descriptor:setFocusBorderColor("white")  
   descriptor:setFocusBorderWidth("3")
   descriptor:setFocusBorderTransparency("0.5")    
   descriptor:setFocusSrc("media/imagem1.gif")    
   descriptor:setFocusSelSrc("media/imagem2.gif")  
   descriptor:setSelBorderColor("white")    
   descriptor:setTransIn("transition1") 
   descriptor:setTransOut("transition2")
   
   assert(descriptor ~= nil, "Error!")
   assert(descriptor:getId() == "descriptor", "Error!")
   assert(descriptor:getPlayer() == "player", "Error!")     
   assert(descriptor:getExplicitDur() == "3s", "Error!")   
   assert(descriptor:getRegion() == "region", "Error!") 
   assert(descriptor:getFreeze() == "true", "Error!")   
   assert(descriptor:getMoveLeft() == "3", "Error!")
   assert(descriptor:getMoveRight() == "1", "Error!")   
   assert(descriptor:getMoveUp() == "1", "Error!")    
   assert(descriptor:getMoveDown() == "3", "Error!")     
   assert(descriptor:getFocusIndex() == "2", "Error!")  
   assert(descriptor:getFocusBorderColor() == "white", "Error!")    
   assert(descriptor:getFocusBorderWidth() == "3", "Error!") 
   assert(descriptor:getFocusBorderTransparency() == "0.5", "Error!")    
   assert(descriptor:getFocusSrc() == "media/imagem1.gif", "Error!")    
   assert(descriptor:getFocusSelSrc() == "media/imagem2.gif", "Error!")  
   assert(descriptor:getSelBorderColor() == "white", "Error!")    
   assert(descriptor:getTransIn() == "transition1", "Error!") 
   assert(descriptor:getTransOut() == "transition2", "Error!") 
end

local function test4()
   local descriptor = nil
      
   descriptor = Descriptor:create(nil, 1)
   assert(descriptor:getDescriptorParamPos(1) ~= nil, "Error!")
   
   descriptor:addDescriptorParam(DescriptorParam:create())
   assert(descriptor:getDescriptorParamPos(2) ~= nil, "Error!")
   
   descriptor:addDescriptorParam(DescriptorParam:create{["name"] = "soundLevel", ["value"] = "0.9"})
   assert(descriptor:getDescendantByAttribute("name", "soundLevel") ~= nil, "Error!")   
end

local function test5()
   local descriptor1 = Descriptor:create{["id"] = "descriptor1"}
   local descriptorParam1 = DescriptorParam:create{["name"] = "soundLevel", ["value"] = "0.9"}
   local descriptorParam2 = DescriptorParam:create{["name"] = "transparency", ["value"] = "60%"}
   local descriptorParam3 = DescriptorParam:create{["name"] = "visible", ["value"] = "false"}
 
   descriptor1:setDescriptorParams(descriptorParam1, descriptorParam2, descriptorParam3)
   assert(descriptor1:getDescendantByAttribute("name", "soundLevel") ~= nil, "Error!")
   assert(descriptor1:getDescendantByAttribute("name", "transparency") ~= nil, "Error!")  
   assert(descriptor1:getDescendantByAttribute("name", "visible") ~= nil, "Error!") 
    
   descriptor1:removeDescriptorParam(descriptorParam1)
   assert(descriptor1:getDescendantByAttribute("name", "soundLevel") == nil, "Error!")
   
   descriptor1:removeDescriptorParamPos(1)
   assert(descriptor1:getDescendantByAttribute("name", "transparency") == nil, "Error!")
end

local function test6()
   local descriptor = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
      ["id"] = "descriptor", 
      ["player"] = "player",
      ["explicitDur"] = "3s", 
      ["region"] = "region",
      ["freeze"] = "true",
      ["moveLeft"] = "3", 
      ["moveRight"] = "1", 
      ["moveUp"] = "1", 
      ["moveDown"] = "3", 
      ["focusIndex"] = "2", 
      ["focusBorderColor"] = "white", 
      ["focusBorderWidth"] = "3", 
      ["focusBorderTransparency"] = "0.5", 
      ["focusSrc"] = "media/imagem1.gif", 
      ["focusSelSrc"] = "media/imagem2.gif", 
      ["selBorderColor"] = "white", 
      ["transIn"] = "transition1", 
      ["transOut"] = "transition2"
   }    
      
   descriptor = Descriptor:create(atts)
   
   nclExp = "<descriptor"   
   for attribute, value in pairs(descriptor:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
  
   nclExp = nclExp.."/>\n"

   nclRet = descriptor:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

local function test7()
   local descriptor = nil
   
   local descriptorParam1, descriptorParam2, descriptorParam3 = nil
   
   local nclExp, nclRet = nil
   
   descriptor = Descriptor:create{["id"] = "descriptor"}
   nclExp = "<descriptor id=\"descriptor\">\n"
      
   descriptorParam1 =  DescriptorParam:create{["name"] = "soundLevel"}
   nclExp = nclExp.." <descriptorParam name=\"soundLevel\"/>\n"  
   
   descriptorParam2 =  DescriptorParam:create{["name"] = "transparency"}
   nclExp = nclExp.." <descriptorParam name=\"transparency\"/>\n"  
   
   descriptorParam3 =  DescriptorParam:create{["name"] = "visible"}
   nclExp = nclExp.." <descriptorParam name=\"visible\"/>\n"  
   
   nclExp = nclExp.."</descriptor>\n"  

   descriptor:setDescriptorParams(descriptorParam1, descriptorParam2, descriptorParam3)      
   
   nclRet = descriptor:table2Ncl(0)
  
   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()
test7()