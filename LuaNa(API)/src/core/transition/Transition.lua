local NCLElem = require "core/NCLElem"

local Transition = NCLElem:extends()

Transition.nameElem = "transition"

Transition.attributesTypeMap = {
  id = "string",
  type = "string",
  subtype = "string",
  dur = {"string", "number"},
  startProgress = {"string", "number"},
  endProgress = {"string", "number"},
  direction = "string",
  fadeColor = "string",
  horzRepeat = {"string", "number"},
  vertRepeat = {"string", "number"},
  borderWidth = {"string", "number"},
  borderColor = "string"
}

Transition.attributesStringValueMap = {
  type = {"barWipe", "irisWipe", "clockWipe", "snakeWipe", "fade"},
  subtype = {"leftToRight", "rectangle", "clockwiseTwelve",
    "topLeftHorizontal", "crossfade"},
  direction = {"forward", "backward"},
  fadeColor = {"white", "black", "silver", "gray", "red", "maroon",
    "fuchsia", "purple", "lime", "green", "yellow", "olive",
    "blue", "navy", "aqua", "teal"},
  borderColor = {"white", "black", "silver", "gray", "red", "maroon",
    "fuchsia", "purple", "lime", "green", "yellow", "olive",
    "blue", "navy", "aqua", "teal"}
}

Transition.attributesSymbolMap = {
  dur = "s"
}

function Transition:create(attributes)
  local transition = Transition:new()

  transition.id = nil
  transition.type = nil
  transition.subtype = nil
  transition.dur = nil
  transition.startProgress = nil
  transition.endProgress = nil
  transition.direction = nil
  transition.fadeColor = nil
  transition.horzRepeat = nil
  transition.vertRepeat = nil
  transition.borderWidth = nil
  transition.borderColor = nil
  
  transition.symbols = {}
  
  transition.ass = {}

  if(attributes ~= nil)then
    transition:setAttributes(attributes)
  end

  return transition
end

function Transition:setId(id)
  self:addAttribute("id", id)
end

function Transition:getId()
  return self:getAttribute("id")
end

function Transition:setType(type)
  self:addAttribute("type", type)
end

function Transition:getType()
  return self:getAttribute("type")
end

function Transition:setSubType(subtype) 
  self:addAttribute("subtype", subtype)
end

function Transition:getSubType()
  return self:getAttribute("subtype")
end

function Transition:setDur(dur)
  self:addAttribute("dur", dur)
end

function Transition:getDur()
  return self:getAttribute("dur")
end

function Transition:setStartProgress(startProgress)
  self:addAttribute("startProgress", startProgress)
end

function Transition:getStartProgress()
  return self:getAttribute("startProgress")
end

function Transition:setEndProgress(endProgress)
  self:addAttribute("endProgress", endProgress)
end

function Transition:getEndProgress()
  return self:getAttribute("endProgress")
end

function Transition:setDirection(direction)
  self:addAttribute("direction", direction)
end

function Transition:getDirection()
  return self:getAttribute("direction")
end

function Transition:setFadeColor(fadeColor)
  self:addAttribute("fadeColor", fadeColor)
end

function Transition:getFadeColor()
  return self:getAttribute("fadeColor")
end

function Transition:setHorzRepeat(horzRepeat)
  self:addAttribute("horzRepeat", horzRepeat)
end

function Transition:getHorzRepeat()
  return self:getAttribute("horzRepeat")
end

function Transition:setVertRepeat(vertRepeat)
  self:addAttribute("vertRepeat", vertRepeat)
end

function Transition:getVertRepeat()
  return self:getAttribute("vertRepeat")
end

function Transition:setBorderWidth(borderWidth)
  self:addAttribute("borderWidth", borderWidth)
end

function Transition:getBorderWidth()
  return self:getAttribute("borderWidth")
end

function Transition:setBorderColor(borderColor)
  self:addAttribute("borderColor", borderColor)
end

function Transition:getBorderColor()
  return self:getAttribute("borderColor")
end

return Transition