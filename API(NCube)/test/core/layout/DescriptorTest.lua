local Descriptor = require "core/layout/Descriptor"
local DescriptorParam = require "core/layout/DescriptorParam"

local function test1()
  local descriptor = Descriptor:create()

  assert(descriptor ~= nil, "Error!")
  assert(descriptor:getId() == nil, "Error!")
  assert(descriptor:getPlayer() == nil, "Error!")
  assert(descriptor:getExplicitDur() == nil, "Error!")
  assert(descriptor:getRegion() == nil, "Error!")
  assert(descriptor:getRegionAss() == nil, "Error!")
  assert(descriptor:getFreeze() == nil, "Error!")
  assert(descriptor:getMoveLeft() == nil, "Error!")
  assert(descriptor:getMoveRight() == nil, "Error!")
  assert(descriptor:getMoveUp() == nil, "Error!")
  assert(descriptor:getMoveDown() == nil, "Error!")
  assert(descriptor:getFocusIndex() == nil, "Error!")
  assert(descriptor:getFocusBorderColor() == nil, "Error!")
  assert(descriptor:getFocusBorderWidth() == nil, "Error!")
  assert(descriptor:getFocusBorderTransparency() == nil, "Error!")
  assert(descriptor:getFocusSrc() == nil, "Error!")
  assert(descriptor:getFocusSelSrc() == nil, "Error!")
  assert(descriptor:getSelBorderColor() == nil, "Error!")
  assert(descriptor:getTransIn() == nil, "Error!")
  assert(#descriptor:getTransInAss() == 0, "Error!")
  assert(descriptor:getTransOut() == nil, "Error!")
  assert(#descriptor:getTransInAss() == 0, "Error!")
end

local function test2()
  local atts = {
    id = "descriptor",
    player = "player",
    explicitDur = 3,
    region = "region",
    freeze = true,
    moveLeft = 3,
    moveRight = 1,
    moveUp = 1,
    moveDown = 3,
    focusIndex = 2,
    focusBorderColor = "white",
    focusBorderWidth = 3,
    focusBorderTransparency = 0.5,
    focusSrc = "media/imagem1.gif",
    focusSelSrc = "media/imagem2.gif",
    selBorderColor = "white",
    transIn = "transition1",
    transOut = "transition2"
  }

  local descriptor = Descriptor:create(atts)

  assert(descriptor:getId() == "descriptor", "Error!")
  assert(descriptor:getPlayer() == "player", "Error!")
  assert(descriptor:getExplicitDur() == 3, "Error!")
  assert(descriptor:getRegion() == "region", "Error!")
  assert(descriptor:getFreeze() == true, "Error!")
  assert(descriptor:getMoveLeft() == 3, "Error!")
  assert(descriptor:getMoveRight() == 1, "Error!")
  assert(descriptor:getMoveUp() == 1, "Error!")
  assert(descriptor:getMoveDown() == 3, "Error!")
  assert(descriptor:getFocusIndex() == 2, "Error!")
  assert(descriptor:getFocusBorderColor() == "white", "Error!")
  assert(descriptor:getFocusBorderWidth() == 3, "Error!")
  assert(descriptor:getFocusBorderTransparency() == 0.5, "Error!")
  assert(descriptor:getFocusSrc() == "media/imagem1.gif", "Error!")
  assert(descriptor:getFocusSelSrc() == "media/imagem2.gif", "Error!")
  assert(descriptor:getSelBorderColor() == "white", "Error!")
  assert(descriptor:getTransIn() == "transition1", "Error!")
  assert(descriptor:getTransOut() == "transition2", "Error!")
end

local function test3()
  local descriptor = Descriptor:create()

  descriptor:setId("descriptor")
  descriptor:setPlayer("player")
  descriptor:setExplicitDur(3)
  descriptor:setRegion("region")
  descriptor:setFreeze(true)
  descriptor:setMoveLeft(3)
  descriptor:setMoveRight(1)
  descriptor:setMoveUp(1)
  descriptor:setMoveDown(3)
  descriptor:setFocusIndex(2)
  descriptor:setFocusBorderColor("white")
  descriptor:setFocusBorderWidth(3)
  descriptor:setFocusBorderTransparency(0.5)
  descriptor:setFocusSrc("media/imagem1.gif")
  descriptor:setFocusSelSrc("media/imagem2.gif")
  descriptor:setSelBorderColor("white")
  descriptor:setTransIn("transition1")
  descriptor:setTransOut("transition2")

  assert(descriptor:getId() == "descriptor", "Error!")
  assert(descriptor:getPlayer() == "player", "Error!")
  assert(descriptor:getExplicitDur() == 3, "Error!")
  assert(descriptor:getRegion() == "region", "Error!")
  assert(descriptor:getFreeze() == true, "Error!")
  assert(descriptor:getMoveLeft() == 3, "Error!")
  assert(descriptor:getMoveRight() == 1, "Error!")
  assert(descriptor:getMoveUp() == 1, "Error!")
  assert(descriptor:getMoveDown() == 3, "Error!")
  assert(descriptor:getFocusIndex() == 2, "Error!")
  assert(descriptor:getFocusBorderColor() == "white", "Error!")
  assert(descriptor:getFocusBorderWidth() == 3, "Error!")
  assert(descriptor:getFocusBorderTransparency() == 0.5, "Error!")
  assert(descriptor:getFocusSrc() == "media/imagem1.gif", "Error!")
  assert(descriptor:getFocusSelSrc() == "media/imagem2.gif", "Error!")
  assert(descriptor:getSelBorderColor() == "white", "Error!")
  assert(descriptor:getTransIn() == "transition1", "Error!")
  assert(descriptor:getTransOut() == "transition2", "Error!")
end

local function test4()
  local descriptor = Descriptor:create()
  local status, err
  
  status, err = pcall(descriptor["setFreeze"], Descriptor, "invalid")
  assert(not(status), "Error!")
  
  status, err = pcall(descriptor["setFreeze"], Descriptor, nil)
  assert(not(status), "Error!")
  
  status, err = pcall(descriptor["setFreeze"], Descriptor, 999999)
  assert(not(status), "Error!")

  status, err = pcall(descriptor["setFreeze"], Descriptor, {})
  assert(not(status), "Error!")

  status, err = pcall(descriptor["setFreeze"], Descriptor, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local descriptor

  descriptor = Descriptor:create(nil, 1)
  assert(descriptor:getDescriptorParamPos(1) ~= nil, "Error!")

  descriptor:addDescriptorParam(DescriptorParam:create())
  assert(descriptor:getDescriptorParamPos(2) ~= nil, "Error!")

  descriptor:addDescriptorParam(DescriptorParam:create{name = "soundLevel", value = 0.9})
  assert(descriptor:getDescendantByAttribute("name", "soundLevel") ~= nil, "Error!")
end

local function test6()
  local descriptor = Descriptor:create{id = "descriptor"}
  local descriptorParam1 = DescriptorParam:create{name = "soundLevel", value = "0.9"}
  local descriptorParam2 = DescriptorParam:create{name = "transparency", value = "60%"}
  local descriptorParam3 = DescriptorParam:create{name = "visible", value = "false"}

  descriptor:setDescriptorParams(descriptorParam1, descriptorParam2, descriptorParam3)
  assert(descriptor:getDescendantByAttribute("name", "soundLevel") ~= nil, "Error!")
  assert(descriptor:getDescendantByAttribute("name", "transparency") ~= nil, "Error!")
  assert(descriptor:getDescendantByAttribute("name", "visible") ~= nil, "Error!")

  descriptor:removeDescriptorParam(descriptorParam1)
  assert(descriptor:getDescendantByAttribute("name", "soundLevel") == nil, "Error!")

  descriptor:removeDescriptorParamPos(1)
  assert(descriptor:getDescendantByAttribute("name", "transparency") == nil, "Error!")
end

local function test7()
  local descriptor = Descriptor:create()
  local status, err
    
  status, err = pcall(descriptor["addDescriptorParam"], descriptor, Descriptor:create())
  assert(not(status), "Error!")
  
  status, err = pcall(descriptor["addDescriptorParam"], descriptor, "invalid")
  assert(not(status), "Error!")

  status, err = pcall(descriptor["addDescriptorParam"], descriptor, nil)
  assert(not(status), "Error!")

  status, err = pcall(descriptor["addDescriptorParam"], descriptor, 999999)
  assert(not(status), "Error!")

  status, err = pcall(descriptor["addDescriptorParam"], descriptor, {})
  assert(not(status), "Error!")

  status, err = pcall(descriptor["addDescriptorParam"], descriptor, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test8()
  local atts = {
    id = "descriptor",
    player = "player",
    explicitDur = 3,
    region = "region",
    freeze = true,
    moveLeft = 3,
    moveRight = 1,
    moveUp = 1,
    moveDown = 3,
    focusIndex = 2,
    focusBorderColor = "white",
    focusBorderWidth = 3,
    focusBorderTransparency = 0.5,
    focusSrc = "media/imagem1.gif",
    focusSelSrc = "media/imagem2.gif",
    selBorderColor = "white",
    transIn = "transition1",
    transOut = "transition2"
  }

  local descriptor = Descriptor:create(atts)

  local nclExp = "<descriptor"
  for attribute, _ in pairs(descriptor:getAttributesTypeMap()) do
    if(descriptor:getSymbols() ~= nil and descriptor:getSymbol(attribute) ~= nil)then
      nclExp = nclExp.." "..attribute.."=\""..descriptor[attribute]..descriptor:getSymbol(attribute).."\""
    else
      nclExp = nclExp.." "..attribute.."=\""..tostring(descriptor[attribute]).."\""
    end
  end

  nclExp = nclExp.."/>\n"

  local nclRet = descriptor:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

local function test9()
  local descriptor = Descriptor:create{id = "descriptor"}
  local nclExp = "<descriptor id=\"descriptor\">\n"

  local descriptorParam1 =  DescriptorParam:create{name = "soundLevel"}
  nclExp = nclExp.." <descriptorParam name=\"soundLevel\"/>\n"

  local descriptorParam2 =  DescriptorParam:create{name = "transparency"}
  nclExp = nclExp.." <descriptorParam name=\"transparency\"/>\n"

  local descriptorParam3 =  DescriptorParam:create{name = "visible"}
  nclExp = nclExp.." <descriptorParam name=\"visible\"/>\n"

  nclExp = nclExp.."</descriptor>\n"

  descriptor:setDescriptorParams(descriptorParam1, descriptorParam2, descriptorParam3)

  local nclRet = descriptor:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()
test7()
test8()
test9()