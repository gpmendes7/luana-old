local NCLElem = require "core/NCLElem"

---
-- Implements Area Class representing <b>&lt;area&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=area">
-- http://handbook.ncl.org.br/doku.php?id=area</a>
-- 
-- @module Area
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local Area = require "core/interface/Area" 
local Area = NCLElem:extends()

---
-- Name of <b>&lt;area&gt;</b> element.
-- 
-- @field [parent=#Area] #string nameElem
Area.nameElem = "area"

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;area&gt;</b> element.
-- 
-- @field [parent=#Area] #table attributesTypeMap 
Area.attributesTypeMap = {
  id = "string", 
  coords = "string", 
  begin = {"string", "number"}, 
  ["end"] = {"string", "number"}, 
  beginText = "string",
  endText = "string", 
  beginPosition = "number",
  endPosition = "number", 
  first = "number", 
  last = "number", 
  label = "string", 
  clip ="string"
}

---
-- List containing all possible pre-definied symbols to numeric attributes
-- belonging to <b>&lt;area&gt;</b> element.
-- 
-- @field [parent=#Area] #table attributesSymbolMap 
Area.attributesSymbolMap = {
  begin = "s",
  ["end"] = "s",
  first = {"s", "f", "npt"},
  last = {"s", "f", "npt"}
}

---
-- Returns a new Area object. 
-- 
-- @function [parent=#Area] create
-- @param #table attributes list of attributes to be initialized.
-- @return #Area new Area object created.
function Area:create(attributes)  
   local area = Area:new()   
   
   area.id = nil 
   area.coords = nil 
   area.begin = nil 
   area["end"] = nil 
   area.beginText = nil
   area.endText = nil 
   area.beginPosition = nil
   area.endPosition = nil 
   area.first = nil 
   area.last = nil 
   area.label = nil 
   area.clip = nil
   
   area.symbols = {}
   
   area.ass = {}

   if(attributes ~= nil)then
      area:setAttributes(attributes)
   end
   
   return area
end

---
-- Sets a value to `id` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] setId
-- @param #string id `id` atribute of the
-- <b>&lt;area&gt;</b> element.
function Area:setId(id)
   self:addAttribute("id", id)
end

---
-- Returns the value of the `id` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] getId
-- @return #string `id` atribute of the <b>&lt;area&gt;</b> element.
function Area:getId()
   return self:getAttribute("id")
end

---
-- Sets a value to `coords` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] setCoords
-- @param #string coords `coords` atribute of the
-- <b>&lt;area&gt;</b> element.
function Area:setCoords(coords)
   self:addAttribute("coords", coords)
end

---
-- Returns the value of the `coords` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] getCoords
-- @return #string `coords` atribute of the <b>&lt;area&gt;</b> element.
function Area:getCoords()
   return self:getAttribute("coords")
end

---
-- Sets a value to `begin` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] setBegin
-- @param #stringOrnumber begin `begin` atribute of the
-- <b>&lt;area&gt;</b> element.
function Area:setBegin(begin)
   self:addAttribute("begin", begin)
end

---
-- Returns the value of the `begin` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] getBegin
-- @return #stringOrnumber `begin` atribute of the <b>&lt;area&gt;</b> element.
function Area:getBegin()
   return self:getAttribute("begin")
end

---
-- Sets a value to `endAtt` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] setEnd
-- @param #stringOrnumber endAtt `endAtt` atribute of the
-- <b>&lt;area&gt;</b> element.
function Area:setEnd(endAtt)
   self:addAttribute("end", endAtt)
end

---
-- Returns the value of the `begin` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] getEnd
-- @return #stringOrnumber `begin` atribute of the <b>&lt;area&gt;</b> element.
function Area:getEnd()
   return self:getAttribute("end")
end

---
-- Sets a value to `beginText` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] setBeginText
-- @param #string beginText `beginText` atribute of the
-- <b>&lt;area&gt;</b> element.
function Area:setBeginText(beginText)
   self:addAttribute("beginText", beginText)
end

---
-- Returns the value of the `beginText` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] getBeginText
-- @return #string `beginText` atribute of the <b>&lt;area&gt;</b> element.
function Area:getBeginText()
   return self:getAttribute("beginText")
end

---
-- Sets a value to `endText` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] setEndText
-- @param #string endText `endText` atribute of the
-- <b>&lt;area&gt;</b> element.
function Area:setEndText(endText)
   self:addAttribute("endText", endText)
end

---
-- Returns the value of the `endText` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] getEndText
-- @return #string `endText` atribute of the <b>&lt;area&gt;</b> element.
function Area:getEndText()
   return self:getAttribute("endText")
end

---
-- Sets a value to `beginPosition` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] setBeginPosition
-- @param #number beginPosition `beginPosition` atribute of the
-- <b>&lt;area&gt;</b> element.
function Area:setBeginPosition(beginPosition)
   self:addAttribute("beginPosition", beginPosition)
end

---
-- Returns the value of the `beginPosition` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] getBeginPosition
-- @return #number `beginPosition` atribute of the <b>&lt;area&gt;</b> element.
function Area:getBeginPosition()
   return self:getAttribute("beginPosition")
end

---
-- Sets a value to `endPosition` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] setEndPosition
-- @param #number endPosition `endPosition` atribute of the
-- <b>&lt;area&gt;</b> element.
function Area:setEndPosition(endPosition)
   self:addAttribute("endPosition", endPosition)
end

---
-- Returns the value of the `endPosition` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] getEndPosition
-- @return #number `endPosition` atribute of the <b>&lt;area&gt;</b> element.
function Area:getEndPosition()
   return self:getAttribute("endPosition")
end

---
-- Sets a value to `first` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] setFirst
-- @param #number first `first` atribute of the
-- <b>&lt;area&gt;</b> element.
function Area:setFirst(first)
   self:addAttribute("first", first)
end

---
-- Returns the value of the `first` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] getFirst
-- @return #number `first` atribute of the <b>&lt;area&gt;</b> element.
function Area:getFirst()
   return self:getAttribute("first")
end

---
-- Sets a value to `last` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] setLast
-- @param #number last `last` atribute of the
-- <b>&lt;area&gt;</b> element.
function Area:setLast(last)
   self:addAttribute("last", last)
end

---
-- Returns the value of the `last` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] getLast
-- @return #number `last` atribute of the <b>&lt;area&gt;</b> element.
function Area:getLast()
   return self:getAttribute("last")
end

---
-- Sets a value to `label` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] setLabel
-- @param #string label `label` atribute of the
-- <b>&lt;area&gt;</b> element.
function Area:setLabel(label)
   self:addAttribute("label", label)
end

---
-- Returns the value of the `label` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] getLabel
-- @return #string `label` atribute of the <b>&lt;area&gt;</b> element.
function Area:getLabel()
   return self:getAttribute("label")
end

---
-- Sets a value to `clip` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] setClip
-- @param #string clip `clip` atribute of the
-- <b>&lt;area&gt;</b> element.
function Area:setClip(clip)
   self:addAttribute("clip", clip)
end

---
-- Returns the value of the `clip` attribute of the 
-- <b>&lt;area&gt;</b> element. 
-- 
-- @function [parent=#Area] getClip
-- @return #string `clip` atribute of the <b>&lt;area&gt;</b> element.
function Area:getClip()
   return self:getAttribute("clip")
end

return Area