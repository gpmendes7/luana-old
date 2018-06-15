local NCLElem = require "core/NCLElem"
local DescriptorParam = require "core/layout/DescriptorParam"

---
-- Implements Descriptor Class representing <b>&lt;descriptor&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=descriptor">
-- http://handbook.ncl.org.br/doku.php?id=descriptor</a>
-- 
-- @module Descriptor
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local Descriptor = require "core/layout/Descriptor" 
local Descriptor = NCLElem:extends()

---
-- Name of <b>&lt;descriptor&gt;</b> element.
-- 
-- @field [parent=#Descriptor] #string nameElem 
Descriptor.nameElem = "descriptor"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;descriptor&gt;</b> element.
-- 
-- @field [parent=#Descriptor] #table childrenMap
Descriptor.childrenMap = {
  descriptorParam = {DescriptorParam, "many"}
}

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;descriptor&gt;</b> element.
-- 
-- @field [parent=#Descriptor] #table attributesTypeMap 
Descriptor.attributesTypeMap = {
  id = "string",
  player = "string",
  explicitDur = {"string", "number"},
  region = "string",
  freeze = "boolean",
  moveLeft = {"string", "number"},
  moveRight = {"string", "number"},
  moveUp = {"string", "number"},
  moveDown = {"string", "number"},
  focusIndex = {"string", "number"},
  focusBorderColor = "string",
  focusBorderWidth = {"string", "number"},
  focusBorderTransparency = {"string", "number"},
  focusSrc = "string",
  focusSelSrc = "string",
  selBorderColor = "string",
  transIn = "string",
  transOut = "string"
}

---
-- List containing all possible pre-definied values to string attributes
-- belonging to <b>&lt;descriptor&gt;</b> element.
-- 
-- @field [parent=#Descriptor] #table attributesStringValueMap
Descriptor.attributesStringValueMap = {
  focusBorderColor = {"white", "black", "silver", "gray", "red",
    "maroon", "fuchsia", "purple", "lime", "green", "yellow", "olive",
    "blue", "navy", "aqua", "teal"},
  selBorderColor = {"white", "black", "silver", "gray", "red",
    "maroon", "fuchsia", "purple", "lime", "green", "yellow", "olive",
    "blue", "navy", "aqua", "teal"}
}

---
-- List containing all possible pre-definied symbols to numeric attributes
-- belonging to <b>&lt;descriptor&gt;</b> element.
-- 
-- @field [parent=#Descriptor] #table attributesSymbolMap 
Descriptor.attributesSymbolMap = {
  explicitDur = "s",
  focusBorderTransparency = "%"
}

---
-- List with associative map that connects an attribute to an specific object
-- representing a child NCL element of <b>&lt;descriptor&gt;</b> element.
-- 
-- @field [parent=#Descriptor] #table assMap
Descriptor.assMap = {
  {"region", "regionAss"},
  {"transIn", "transInAss"},
  {"transOut", "transOutAss"}
}

---
-- Returns a new Descriptor object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#Descriptor] create
-- @param #table attributes list of attributes to be initialized.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #Descriptor new Descriptor object created.
function Descriptor:create(attributes, full)
  local descriptor = Descriptor:new()

  descriptor.id = nil
  descriptor.player = nil
  descriptor.explicitDur = nil
  descriptor.region = nil
  descriptor.freeze = nil
  descriptor.moveLeft = nil
  descriptor.moveRight = nil
  descriptor.moveUp = nil
  descriptor.moveDown = nil
  descriptor.focusIndex = nil
  descriptor.focusBorderColor = nil
  descriptor.focusBorderWidth = nil
  descriptor.focusBorderTransparency = nil
  descriptor.focusSrc = nil
  descriptor.focusSelSrc = nil
  descriptor.selBorderColor = nil
  descriptor.transIn = nil
  descriptor.transOut = nil

  descriptor.regionAss = nil
  descriptor.transInAss = {}
  descriptor.transOutAss = {}

  descriptor.symbols = {}

  descriptor.ass = {}

  if(attributes ~= nil)then
    descriptor:setAttributes(attributes)
  end

  descriptor.children = {}
  descriptor.descriptorParams = {}

  if(full ~= nil)then
    descriptor:addDescriptorParam(DescriptorParam:create())
  end

  return descriptor
end

---
-- Sets a value to `id` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] setId
-- @param #string id `id` attribute of the
-- <b>&lt;descriptor&gt;</b> element.
function Descriptor:setId(id)
  self:addAttribute("id", id)
end

---
-- Returns the value of the `id` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] getId
-- @return #string `id` attribute of the <b>&lt;descriptor&gt;</b> element.
function Descriptor:getId()
  return self:getAttribute("id")
end

---
-- Sets a value to `player` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] setPlayer
-- @param #string player `player` attribute of the
-- <b>&lt;descriptor&gt;</b> element.
function Descriptor:setPlayer(player)
  self:addAttribute("player", player)
end

---
-- Returns the value of the `player` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] getPlayer
-- @return #string `player` attribute of the <b>&lt;descriptor&gt;</b> element.
function Descriptor:getPlayer()
  return self:getAttribute("player")
end

---
-- Sets a value to `explicitDur` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] setExplicitDur
-- @param #stringOrnumber explicitDur `explicitDur` attribute of the
-- <b>&lt;descriptor&gt;</b> element.
function Descriptor:setExplicitDur(explicitDur)
  self:addAttribute("explicitDur", explicitDur)
end

---
-- Returns the value of the `explicitDur` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] getExplicitDur
-- @return #stringOrnumber `explicitDur` attribute of the <b>&lt;descriptor&gt;</b> element.
function Descriptor:getExplicitDur()
  return self:getAttribute("explicitDur")
end

---
-- Sets a value to `region` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] setRegion
-- @param #stringOrobject region `region` attribute of the
-- <b>&lt;descriptor&gt;</b> element.
function Descriptor:setRegion(region)
  if(type(region) == "table"
    and region["getNameElem"] ~= nil
    and region:getNameElem() == "region")then
    self:addAttribute("region", region:getId())
    self.regionAss = region
    table.insert(self.regionAss.ass, self)
  elseif(type(region) == "string")then
    self:addAttribute("region", region)
  else
    error("Error! Invalid region element!", 2)
  end
end

---
-- Returns the value of the `region` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] getRegion
-- @return #string `region` attribute of the <b>&lt;descriptor&gt;</b> element.
function Descriptor:getRegion()
  return self:getAttribute("region")
end

---
-- Returns the region associated to
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] getRegionAss
-- @return #object region associated to <b>&lt;descriptor&gt;</b> element.
function Descriptor:getRegionAss()
  return self.regionAss
end

---
-- Sets a value to `freeze` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] setFreeze
-- @param #boolean freeze `freeze` attribute of the
-- <b>&lt;descriptor&gt;</b> element.
function Descriptor:setFreeze(freeze)
  self:addAttribute("freeze", freeze)
end

---
-- Returns the value of the `freeze` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] getFreeze
-- @return #boolean `freeze` attribute of the <b>&lt;descriptor&gt;</b> element.
function Descriptor:getFreeze()
  return self:getAttribute("freeze")
end

---
-- Sets a value to `moveLeft` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] setMoveLeft
-- @param #stringOrnumber moveLeft `moveLeft` attribute of the
-- <b>&lt;descriptor&gt;</b> element.
function Descriptor:setMoveLeft(moveLeft)
  self:addAttribute("moveLeft", moveLeft)
end

---
-- Returns the value of the `moveLeft` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] getMoveLeft
-- @return #stringOrnumber `moveLeft` attribute of the <b>&lt;descriptor&gt;</b> element.
function Descriptor:getMoveLeft()
  return self:getAttribute("moveLeft")
end

---
-- Sets a value to `moveRight` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] setMoveRight
-- @param #stringOrnumber moveRight `moveRight` attribute of the
-- <b>&lt;descriptor&gt;</b> element.
function Descriptor:setMoveRight(moveRight)
  self:addAttribute("moveRight", moveRight)
end

---
-- Returns the value of the `moveRight` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] getMoveRight
-- @return #stringOrnumber `moveRight` attribute of the <b>&lt;descriptor&gt;</b> element.
function Descriptor:getMoveRight()
  return self:getAttribute("moveRight")
end

---
-- Sets a value to `moveUp` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] setMoveUp
-- @param #stringOrnumber moveUp `moveUp` attribute of the
-- <b>&lt;descriptor&gt;</b> element.
function Descriptor:setMoveUp(moveUp)
  self:addAttribute("moveUp", moveUp)
end

---
-- Returns the value of the `moveUp` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] getMoveUp
-- @return #stringOrnumber `moveUp` attribute of the <b>&lt;descriptor&gt;</b> element.
function Descriptor:getMoveUp()
  return self:getAttribute("moveUp")
end

---
-- Sets a value to `moveDown` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] setMoveDown
-- @param #stringOrnumber moveDown `moveDown` attribute of the
-- <b>&lt;descriptor&gt;</b> element.
function Descriptor:setMoveDown(moveDown)
  self:addAttribute("moveDown", moveDown)
end

---
-- Returns the value of the `moveDown` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] getMoveDown
-- @return #stringOrnumber `moveDown` attribute of the <b>&lt;descriptor&gt;</b> element.
function Descriptor:getMoveDown()
  return self:getAttribute("moveDown")
end

---
-- Sets a value to `focusIndex` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] setFocusIndex
-- @param #stringOrnumber focusIndex `focusIndex` attribute of the
-- <b>&lt;descriptor&gt;</b> element.
function Descriptor:setFocusIndex(focusIndex)
  self:addAttribute("focusIndex", focusIndex)
end

---
-- Returns the value of the `focusIndex` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] getFocusIndex
-- @return #stringOrnumber `focusIndex` attribute of the <b>&lt;descriptor&gt;</b> element.
function Descriptor:getFocusIndex()
  return self:getAttribute("focusIndex")
end

---
-- Sets a value to `focusBorderColor` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] setFocusBorderColor
-- @param #string focusBorderColor `focusBorderColor` attribute of the
-- <b>&lt;descriptor&gt;</b> element.
function Descriptor:setFocusBorderColor(focusBorderColor)
  self:addAttribute("focusBorderColor", focusBorderColor)
end

---
-- Returns the value of the `focusBorderColor` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] getFocusBorderColor
-- @return #string `focusBorderColor` attribute of the <b>&lt;descriptor&gt;</b> element.
function Descriptor:getFocusBorderColor()
  return self:getAttribute("focusBorderColor")
end

---
-- Sets a value to `focusBorderWidth` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] setFocusBorderWidth
-- @param #stringOrnumber focusBorderWidth `focusBorderWidth` attribute of the
-- <b>&lt;descriptor&gt;</b> element.
function Descriptor:setFocusBorderWidth(focusBorderWidth)
  self:addAttribute("focusBorderWidth", focusBorderWidth)
end

---
-- Returns the value of the `focusBorderWidth` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] getFocusBorderWidth
-- @return #stringOrnumber `focusBorderWidth` attribute of the <b>&lt;descriptor&gt;</b> element.
function Descriptor:getFocusBorderWidth()
  return self:getAttribute("focusBorderWidth")
end

---
-- Sets a value to `focusBorderTransparency` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] setFocusBorderTransparency
-- @param #stringOrnumber focusBorderTransparency `focusBorderTransparency` attribute of the
-- <b>&lt;descriptor&gt;</b> element.
function Descriptor:setFocusBorderTransparency(focusBorderTransparency)
  self:addAttribute("focusBorderTransparency", focusBorderTransparency)
end

---
-- Returns the value of the `focusBorderTransparency` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] getFocusBorderTransparency
-- @return #stringOrnumber `focusBorderTransparency` attribute of the <b>&lt;descriptor&gt;</b> element.
function Descriptor:getFocusBorderTransparency()
  return self:getAttribute("focusBorderTransparency")
end

---
-- Sets a value to `focusSrc` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] setFocusSrc
-- @param #string focusSrc `focusSrc` attribute of the
-- <b>&lt;descriptor&gt;</b> element.
function Descriptor:setFocusSrc(focusSrc)
  self:addAttribute("focusSrc", focusSrc)
end

---
-- Returns the value of the `focusSrc` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] getFocusSrc
-- @return #string `focusSrc` attribute of the <b>&lt;descriptor&gt;</b> element.
function Descriptor:getFocusSrc()
  return self:getAttribute("focusSrc")
end

---
-- Sets a value to `focusSelSrc` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] setFocusSelSrc
-- @param #string focusSelSrc `focusSelSrc` attribute of the
-- <b>&lt;descriptor&gt;</b> element.
function Descriptor:setFocusSelSrc(focusSelSrc)
  self:addAttribute("focusSelSrc", focusSelSrc)
end

---
-- Returns the value of the `focusSelSrc` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] getFocusSelSrc
-- @return #string `focusSelSrc` attribute of the <b>&lt;descriptor&gt;</b> element.
function Descriptor:getFocusSelSrc()
  return self:getAttribute("focusSelSrc")
end

---
-- Sets a value to `selBorderColor` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] setSelBorderColor
-- @param #string selBorderColor `selBorderColor` attribute of the
-- <b>&lt;descriptor&gt;</b> element.
function Descriptor:setSelBorderColor(selBorderColor)
  self:addAttribute("selBorderColor", selBorderColor)
end

---
-- Returns the value of the `selBorderColor` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] getSelBorderColor
-- @return #string `selBorderColor` attribute of the <b>&lt;descriptor&gt;</b> element.
function Descriptor:getSelBorderColor()
  return self:getAttribute("selBorderColor")
end

---
-- Sets a value to `transIn` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- Can receive one or more transition objects.
-- 
-- @function [parent=#Descriptor] setTransIn
-- @param #stringOrobject ... `transIn` attribute of the
-- <b>&lt;descriptor&gt;</b> element.
function Descriptor:setTransIn(...)
  if(#arg > 1)then
    local id = ""

    for p, transIn in ipairs(arg) do
      if(type(transIn) == "table"
        and transIn["getNameElem"] ~= nil
        and transIn:getNameElem() == "transition")then
        id = id..transIn:getId()
        table.insert(self.transInAss, transIn)
        table.insert(transIn.ass, self)

        if(p < #arg)then
          id = id..", "
        end
      else
        error("Error! Invalid transIn element!", 2)
      end
    end

    self:addAttribute("transIn", id)
  else
    if(type(arg[1]) == "table"
      and arg[1]["getNameElem"] ~= nil
      and arg[1]:getNameElem() == "transition")then
      self:addAttribute("transIn", arg[1]:getId())
      table.insert(self.transInAss, arg[1])
      table.insert(arg[1].ass, self)
    elseif(type(arg[1]) == "string")then
      self:addAttribute("transIn", arg[1])
    else
      error("Error! Invalid transIn element!", 2)
    end
  end
end

---
-- Returns the value of the `transIn` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] getTransIn
-- @return #string `transIn` attribute of the <b>&lt;descriptor&gt;</b> element.
function Descriptor:getTransIn()
  return self:getAttribute("transIn")
end

---
-- Returns the transition associated to `transIn` attribute of the
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] getTransInAss
-- @return #object transition associated to `transIn` attribute of the
-- <b>&lt;descriptor&gt;</b> element. 
function Descriptor:getTransInAss()
  return self.transInAss
end

---
-- Sets a value to `transOut` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- Can receive one or more transition objects.
-- 
-- @function [parent=#Descriptor] setTransOut
-- @param #stringOrobject ... `transOut` attribute of the
-- <b>&lt;descriptor&gt;</b> element.
function Descriptor:setTransOut(...)
  if(#arg > 1)then
    local id = ""

    for p, transOut in ipairs(arg) do
      if(type(transOut) == "table"
        and transOut["getNameElem"] ~= nil
        and transOut:getNameElem() == "transition")then
        id = id..transOut:getId()
        table.insert(self.transOutAss, transOut)
        table.insert(transOut.ass, self)

        if(p < #arg)then
          id = id..", "
        end
      else
        error("Error! Invalid transOut element!", 2)
      end
    end

    self:addAttribute("transOut", id)
  else
    if(type(arg[1]) == "table"
      and arg[1]["getNameElem"] ~= nil
      and arg[1]:getNameElem() == "transition")then
      self:addAttribute("transOut", arg[1]:getId())
      table.insert(self.transOutAss, arg[1])
      table.insert(arg[1].ass, self)
    elseif(type(arg[1]) == "string")then
      self:addAttribute("transOut", arg[1])
    else
      error("Error! Invalid transOut element!", 2)
    end
  end
end

---
-- Returns the value of the `transOut` attribute of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] getTransOut
-- @return #string `transOut` attribute of the <b>&lt;descriptor&gt;</b> element.
function Descriptor:getTransOut()
  return self:getAttribute("transOut")
end

---
-- Returns the transition associated to `transOut` attribute of the
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] getTransOutAss
-- @return #object transition associated to `transOut` attribute of the
-- <b>&lt;descriptor&gt;</b> element.
function Descriptor:getTransOutAss()
  return self.transOutAss
end

---
-- Adds a <b>&lt;descriptorParam&gt;</b> child element of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] addDescriptorParam
-- @param #DescriptorParam descriptorParam object representing the 
-- <b>&lt;descriptorParam&gt;</b> element.
function Descriptor:addDescriptorParam(descriptorParam)
  if((type(descriptorParam) == "table"
    and descriptorParam["getNameElem"] ~= nil
    and descriptorParam:getNameElem() ~= "descriptorParam")
    or (type(descriptorParam) == "table"
    and descriptorParam["getNameElem"] == nil)
    or type(descriptorParam) ~= "table")then
    error("Error! Invalid descriptorParam element!", 2)
  end

  self:addChild(descriptorParam)
  table.insert(self.descriptorParams, descriptorParam)
end

---
-- Returns a <b>&lt;descriptorParam&gt;</b> child element of the 
-- <b>&lt;descriptor&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#Descriptor] getDescriptorParamPos
-- @param #number p  position of the object representing 
-- the <b>&lt;descriptor&gt;</b> element.
function Descriptor:getDescriptorParamPos(p)
  if(self.descriptorParams == nil)then
    error("Error! descriptor element with nil descriptorParams list!", 2)
  elseif(p > #self.descriptorParams)then
    error("Error! descriptor element doesn't have a descriptorParam child in position "..p.."!", 2)
  end

  return self.descriptorParams[p]
end

---
-- Adds so many <b>&lt;descriptorParam&gt;</b> child elements of the <b>&lt;media&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#Descriptor] setDescriptorParams
-- @param #DescriptorParam ... objects representing the <b>&lt;descriptorParam&gt;</b> element.
function Descriptor:setDescriptorParams(...)
  if(#arg>0)then
    for _, descriptorParam in ipairs(arg) do
      self:addDescriptorParam(descriptorParam)
    end
  end
end

---
-- Removes a <b>&lt;descriptorParam&gt;</b> child element of the 
-- <b>&lt;descriptor&gt;</b> element. 
-- 
-- @function [parent=#Descriptor] removeDescriptorParam
-- @param #DescriptorParam descriptorParam object representing the <b>&lt;descriptorParam&gt;</b> element.
function Descriptor:removeDescriptorParam(descriptorParam)
  if((type(descriptorParam) == "table"
    and descriptorParam["getNameElem"] ~= nil
    and descriptorParam:getNameElem() ~= "descriptorParam")
    or (type(descriptorParam) == "table"
    and descriptorParam["getNameElem"] == nil)
    or type(descriptorParam) ~= "table")then
    error("Error! Invalid descriptorParam element!", 2)
  elseif(self.children == nil)then
    error("Error! descriptor element with nil children list!", 2)
  elseif(self.descriptorParams == nil)then
    error("Error! descriptor element with nil descriptorParams list!", 2)
  end

  self:removeChild(descriptorParam)

  for p, dp in ipairs(self.descriptorParams) do
    if(descriptorParam == dp)then
      table.remove(self.descriptorParams, p)
    end
  end
end

---
-- Removes a <b>&lt;descriptorParam&gt;</b> child element of the 
-- <b>&lt;descriptor&gt;</b> element in position `p`.
-- 
-- @function [parent=#Descriptor] removeDescriptorParamPos
-- @param #number p position of the <b>&lt;descriptor&gt;</b> child element.
function Descriptor:removeDescriptorParamPos(p)
  if(self.children == nil)then
    error("Error! descriptor element with nil children list!", 2)
  elseif(self.descriptorParams == nil)then
    error("Error! descriptor element with nil descriptorParams list!", 2)
  elseif(p > #self.children)then
    error("Error! descriptor element doesn't have a descriptorParam child in position "..p.."!", 2)
  elseif(p > #self.descriptorParams)then
    error("Error! descriptor element doesn't have a descriptorParam child in position "..p.."!", 2)
  end

  self:removeChild(self.descriptorParams[p])
  table.remove(self.descriptorParams, p)
end

return Descriptor