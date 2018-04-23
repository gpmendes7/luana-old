local NCLElem = require "core/NCLElem"

local Area = NCLElem:extends()

Area.name = "area"

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

Area.attributesSymbolMap = {
  first = {"s", "f", "npt"},
  last = {"s", "f", "npt"}
}

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

function Area:setId(id)
   self:addAttribute("id", id)
end

function Area:getId()
   return self:getAttribute("id")
end

function Area:setCoords(coords)
   self:addAttribute("coords", coords)
end

function Area:getCoords()
   return self:getAttribute("coords")
end

function Area:setBegin(begin)
   self:addAttribute("begin", begin)
end

function Area:getBegin()
   return self:getAttribute("begin")
end

function Area:setEnd(endAtt)
   self:addAttribute("end", endAtt)
end

function Area:getEnd()
   return self:getAttribute("end")
end

function Area:setBeginText(beginText)
   self:addAttribute("beginText", beginText)
end

function Area:getBeginText()
   return self:getAttribute("beginText")
end

function Area:setEndText(endText)
   self:addAttribute("endText", endText)
end

function Area:getEndText()
   return self:getAttribute("endText")
end

function Area:setBeginPosition(beginPosition)
   self:addAttribute("beginPosition", beginPosition)
end

function Area:getBeginPosition()
   return self:getAttribute("beginPosition")
end

function Area:setEndPosition(endPosition)
   self:addAttribute("endPosition", endPosition)
end

function Area:getEndPosition()
   return self:getAttribute("endPosition")
end

function Area:setFirst(first, symbol)
   self:addAttribute("first", first, symbol)
end

function Area:getFirst()
   return self:getAttribute("first")
end

function Area:setLast(last, symbol)
   self:addAttribute("last", last, symbol)
end

function Area:getLast()
   return self:getAttribute("last")
end

function Area:setLabel(label)
   self:addAttribute("label", label)
end

function Area:getLabel()
   return self:getAttribute("label")
end

function Area:setClip(clip)
   self:addAttribute("clip", clip)
end

function Area:getClip()
   return self:getAttribute("clip")
end

return Area