local NCLElem = require "core/NCLElem"

---
-- Implements Transition Class representing <b>&lt;transition&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=transition">
-- http://handbook.ncl.org.br/doku.php?id=transition</a>
-- 
-- @module Transition
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local Transition = require "core/transition/Transition" 
local Transition = NCLElem:extends()

---
-- Name of <b>&lt;transition&gt;</b> element.
-- 
-- @field [parent=#Transition] #string nameElem
Transition.nameElem = "transition"

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;transition&gt;</b> element.
-- 
-- @field [parent=#Transition] #table attributesTypeMap 
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

---
-- List containing all possible pre-definied values to string attributes
-- belonging to <b>&lt;transition&gt;</b> element.
-- 
-- @field [parent=#Transition] #table attributesStringValueMap
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

---
-- List containing all possible pre-definied symbols to numeric attributes
-- belonging to <b>&lt;transition&gt;</b> element.
-- 
-- @field [parent=#Transition] #table attributesSymbolMap 
Transition.attributesSymbolMap = {
  dur = "s"
}

---
-- Returns a new Transition object. 
-- 
-- @function [parent=#Transition] create
-- @param #table attributes list of attributes to be initialized.
-- @return #Transition new Transition object created.
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

---
-- Sets a value to `id` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] setId
-- @param #string id `id` attribute of the
-- <b>&lt;transition&gt;</b> element.
function Transition:setId(id)
  self:addAttribute("id", id)
end

---
-- Returns the value of the `id` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] getId
-- @return #string `id` attribute of the <b>&lt;transition&gt;</b> element.
function Transition:getId()
  return self:getAttribute("id")
end

---
-- Sets a value to `type` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] setType
-- @param #string type `type` attribute of the
-- <b>&lt;transition&gt;</b> element.
function Transition:setType(type)
  self:addAttribute("type", type)
end

---
-- Returns the value of the `type` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] getType
-- @return #string `type` attribute of the <b>&lt;transition&gt;</b> element.
function Transition:getType()
  return self:getAttribute("type")
end

---
-- Sets a value to `subtype` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] setSubType
-- @param #string subtype `subtype` attribute of the
-- <b>&lt;transition&gt;</b> element.
function Transition:setSubType(subtype) 
  self:addAttribute("subtype", subtype)
end

---
-- Returns the value of the `subtype` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] getSubType
-- @return #string `subtype` attribute of the <b>&lt;transition&gt;</b> element.
function Transition:getSubType()
  return self:getAttribute("subtype")
end


---
-- Sets a value to `dur` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] setDur
-- @param #stringOrnumber dur `dur` attribute of the
-- <b>&lt;transition&gt;</b> element.
function Transition:setDur(dur)
  self:addAttribute("dur", dur)
end

---
-- Returns the value of the `dur` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] getDur
-- @return #stringOrnumber `dur` attribute of the <b>&lt;transition&gt;</b> element.
function Transition:getDur()
  return self:getAttribute("dur")
end

---
-- Sets a value to `startProgress` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] setStartProgress
-- @param #stringOrnumber startProgress `startProgress` attribute of the
-- <b>&lt;transition&gt;</b> element.
function Transition:setStartProgress(startProgress)
  self:addAttribute("startProgress", startProgress)
end

---
-- Returns the value of the `startProgress` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] getStartProgress
-- @return #stringOrnumber `startProgress` attribute of the <b>&lt;transition&gt;</b> element.
function Transition:getStartProgress()
  return self:getAttribute("startProgress")
end

---
-- Sets a value to `endProgress` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] setEndProgress
-- @param #stringOrnumber endProgress `endProgress` attribute of the
-- <b>&lt;transition&gt;</b> element.
function Transition:setEndProgress(endProgress)
  self:addAttribute("endProgress", endProgress)
end

---
-- Returns the value of the `endProgress` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] getEndProgress
-- @return #stringOrnumber `endProgress` attribute of the <b>&lt;transition&gt;</b> element.
function Transition:getEndProgress()
  return self:getAttribute("endProgress")
end

---
-- Sets a value to `direction` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] setDirection
-- @param #string direction `direction` attribute of the
-- <b>&lt;transition&gt;</b> element.
function Transition:setDirection(direction)
  self:addAttribute("direction", direction)
end

---
-- Returns the value of the `direction` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] getDirection
-- @return #string `direction` attribute of the <b>&lt;transition&gt;</b> element.
function Transition:getDirection()
  return self:getAttribute("direction")
end

---
-- Sets a value to `fadeColor` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] setFadeColor
-- @param #string fadeColor `fadeColor` attribute of the
-- <b>&lt;transition&gt;</b> element.
function Transition:setFadeColor(fadeColor)
  self:addAttribute("fadeColor", fadeColor)
end

---
-- Returns the value of the `fadeColor` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] getFadeColor
-- @return #string `fadeColor` attribute of the <b>&lt;transition&gt;</b> element.
function Transition:getFadeColor()
  return self:getAttribute("fadeColor")
end

---
-- Sets a value to `horzRepeat` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] setHorzRepeat
-- @param #stringOrnumber horzRepeat `horzRepeat` attribute of the
-- <b>&lt;transition&gt;</b> element.
function Transition:setHorzRepeat(horzRepeat)
  self:addAttribute("horzRepeat", horzRepeat)
end

---
-- Returns the value of the `horzRepeat` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] getHorzRepeat
-- @return #stringOrnumber `horzRepeat` attribute of the <b>&lt;transition&gt;</b> element.
function Transition:getHorzRepeat()
  return self:getAttribute("horzRepeat")
end

---
-- Sets a value to `vertRepeat` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] setVertRepeat
-- @param #stringOrnumber vertRepeat `vertRepeat` attribute of the
-- <b>&lt;transition&gt;</b> element.
function Transition:setVertRepeat(vertRepeat)
  self:addAttribute("vertRepeat", vertRepeat)
end

---
-- Returns the value of the `vertRepeat` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] getVertRepeat
-- @return #stringOrnumber `vertRepeat` attribute of the <b>&lt;transition&gt;</b> element.
function Transition:getVertRepeat()
  return self:getAttribute("vertRepeat")
end

---
-- Sets a value to `borderWidth` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] setBorderWidth
-- @param #stringOrnumber borderWidth `borderWidth` attribute of the
-- <b>&lt;transition&gt;</b> element.
function Transition:setBorderWidth(borderWidth)
  self:addAttribute("borderWidth", borderWidth)
end

---
-- Returns the value of the `borderWidth` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] getBorderWidth
-- @return #stringOrnumber `borderWidth` attribute of the <b>&lt;transition&gt;</b> element.
function Transition:getBorderWidth()
  return self:getAttribute("borderWidth")
end

---
-- Sets a value to `borderColor` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] setBorderColor
-- @param #string borderColor `borderColor` attribute of the
-- <b>&lt;transition&gt;</b> element.
function Transition:setBorderColor(borderColor)
  self:addAttribute("borderColor", borderColor)
end

---
-- Returns the value of the `borderColor` attribute of the 
-- <b>&lt;transition&gt;</b> element. 
-- 
-- @function [parent=#Transition] getBorderColor
-- @return #string `borderColor` attribute of the <b>&lt;transition&gt;</b> element.
function Transition:getBorderColor()
  return self:getAttribute("borderColor")
end

return Transition