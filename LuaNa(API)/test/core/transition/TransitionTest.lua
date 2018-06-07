local Transition = require "core/transition/Transition"

local function test1()
  local transition = Transition:create()

  assert(transition ~= nil, "Error!")
  assert(transition:getId() == nil, "Error!")
  assert(transition:getType() == nil, "Error!")
  assert(transition:getSubType() == nil, "Error!")
  assert(transition:getDur() == nil, "Error!")
  assert(transition:getStartProgress() == nil, "Error!")
  assert(transition:getEndProgress() == nil, "Error!")
  assert(transition:getDirection() == nil, "Error!")
  assert(transition:getFadeColor() == nil, "Error!")
  assert(transition:getHorzRepeat() == nil, "Error!")
  assert(transition:getVertRepeat() == nil, "Error!")
  assert(transition:getBorderWidth() == nil, "Error!")
  assert(transition:getBorderColor() == nil, "Error!")
end

local function test2()
  local atts = {
    id = "transition",
    type = "barWipe",
    subtype = "leftToRight",
    dur = 5,
    startProgress = 0.2,
    endProgress = 0.5,
    direction = "forward",
    fadeColor = "silver",
    horzRepeat = 2,
    vertRepeat = 3,
    borderWidth = 2,
    borderColor = "white"
  }

  local transition = Transition:create(atts)

  assert(transition:getId() == "transition", "Error!")
  assert(transition:getType() == "barWipe", "Error!")
  assert(transition:getSubType() == "leftToRight", "Error!")
  assert(transition:getDur() == 5, "Error!")
  assert(transition:getStartProgress() == 0.2, "Error!")
  assert(transition:getEndProgress() == 0.5, "Error!")
  assert(transition:getDirection() == "forward", "Error!")
  assert(transition:getFadeColor() == "silver", "Error!")
  assert(transition:getHorzRepeat() == 2, "Error!")
  assert(transition:getVertRepeat() == 3, "Error!")
  assert(transition:getBorderWidth() == 2, "Error!")
  assert(transition:getBorderColor() == "white", "Error!")
end

local function test3()
  local transition = Transition:create()

  transition:setId("transition")
  transition:setType("barWipe")
  transition:setSubType("leftToRight")
  transition:setDur(5)
  transition:setStartProgress(0.2)
  transition:setEndProgress(0.5)
  transition:setDirection("forward")
  transition:setFadeColor("silver")
  transition:setHorzRepeat(2)
  transition:setVertRepeat(3)
  transition:setBorderWidth(2)
  transition:setBorderColor("white")

  assert(transition:getId() == "transition", "Error!")
  assert(transition:getType() == "barWipe", "Error!")
  assert(transition:getSubType() == "leftToRight", "Error!")
  assert(transition:getDur() == 5, "Error!")
  assert(transition:getStartProgress() == 0.2, "Error!")
  assert(transition:getEndProgress() == 0.5, "Error!")
  assert(transition:getDirection() == "forward", "Error!")
  assert(transition:getFadeColor() == "silver", "Error!")
  assert(transition:getHorzRepeat() == 2, "Error!")
  assert(transition:getVertRepeat() == 3, "Error!")
  assert(transition:getBorderWidth() == 2, "Error!")
  assert(transition:getBorderColor() == "white", "Error!")
end

local function test4()
  local transition = Transition:create()
  local status, err

  status, err = pcall(transition["setType"], transition, "invalid")
  assert(not(status), "Error!")

  status, err = pcall(transition["setType"], transition, nil)
  assert(not(status), "Error!")

  status, err = pcall(transition["setType"], transition, {})
  assert(not(status), "Error!")

  status, err = pcall(transition["setType"], transition, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local atts = {
    id = "transition",
    type = "barWipe",
    subtype = "leftToRight",
    dur = 5,
    startProgress = 0.2,
    endProgress = 0.5,
    direction = "forward",
    fadeColor = "silver",
    horzRepeat = 2,
    vertRepeat = 3,
    borderWidth = 2,
    borderColor = "white"
  }

  local transition = Transition:create(atts)

  transition:addSymbol("dur", "s")

  local nclExp = "<transition"
  for attribute, _ in pairs(transition:getAttributesTypeMap()) do
    if(transition:getSymbols() ~= nil and transition:getSymbol(attribute) ~= nil)then
      nclExp = nclExp.." "..attribute.."=\""..transition[attribute]..transition:getSymbol(attribute).."\""
    else
      nclExp = nclExp.." "..attribute.."=\""..tostring(transition[attribute]).."\""
    end
  end

  nclExp = nclExp.."/>\n"

  local nclRet = transition:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()