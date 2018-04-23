local NCLElem = require "core/NCLElem"
local DescriptorParam = require "core/layout/DescriptorParam"

local Descriptor = NCLElem:extends()

Descriptor.name = "descriptor"

Descriptor.childrenMap = {
  descriptorParam = {DescriptorParam, "many"}
}

Descriptor.attributesTypeMap = {
  id = "string",
  player = "string",
  explicitDur = {"string", "number"},
  region = "string",
  freeze = "boolean",
  moveLeft = "number",
  moveRight = "number",
  moveUp = "number",
  moveDown = "number",
  focusIndex = "number",
  focusBorderColor = "string",
  focusBorderWidth = "number",
  focusBorderTransparency = "number",
  focusSrc = "string",
  focusSelSrc = "string",
  selBorderColor = "string",
  transIn = "string",
  transOut = "string"
}

Descriptor.attributesStringValueMap = {
  focusBorderColor = {"white", "black", "silver", "gray", "red",
    "maroon", "fuchsia", "purple", "lime", "green", "yellow", "olive",
    "blue", "navy", "aqua", "teal"},
  selBorderColor = {"white", "black", "silver", "gray", "red",
    "maroon", "fuchsia", "purple", "lime", "green", "yellow", "olive",
    "blue", "navy", "aqua", "teal"}
}

Descriptor.attributesSymbolMap = {
  explicitDur = "s",
  focusBorderTransparency = "%"
}

Descriptor.assMap = {
  {"region", "regionAss"}
}

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
  descriptor.transInAss = nil
  descriptor.transOutAss = nil
  
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

function Descriptor:setId(id)
  self:addAttribute("id", id)
end

function Descriptor:getId()
  return self:getAttribute("id")
end

function Descriptor:setPlayer(player)
  self:addAttribute("player", player)
end

function Descriptor:getPlayer()
  return self:getAttribute("player")
end

function Descriptor:setExplicitDur(explicitDur)
  self:addAttribute("explicitDur", explicitDur)
end

function Descriptor:getExplicitDur()
  return self:getAttribute("explicitDur")
end

function Descriptor:setRegion(region)
  if(type(region) == "table" and region.name == "region")then
    self:addAttribute("region", region:getId())
    self.regionAss = region
    table.insert(self.regionAss.ass, self)
  else
    self:addAttribute("region", region)
  end
end

function Descriptor:getRegion()
  return self:getAttribute("region")
end

function Descriptor:setFreeze(freeze)
  self:addAttribute("freeze", freeze)
end

function Descriptor:getFreeze()
  return self:getAttribute("freeze")
end

function Descriptor:setMoveLeft(moveLeft)
  self:addAttribute("moveLeft", moveLeft)
end

function Descriptor:getMoveLeft()
  return self:getAttribute("moveLeft")
end

function Descriptor:setMoveRight(moveRight)
  self:addAttribute("moveRight", moveRight)
end

function Descriptor:getMoveRight()
  return self:getAttribute("moveRight")
end

function Descriptor:setMoveUp(moveUp)
  self:addAttribute("moveUp", moveUp)
end

function Descriptor:getMoveUp()
  return self:getAttribute("moveUp")
end

function Descriptor:setMoveDown(moveDown)
  self:addAttribute("moveDown", moveDown)
end

function Descriptor:getMoveDown()
  return self:getAttribute("moveDown")
end

function Descriptor:setFocusIndex(focusIndex)
  self:addAttribute("focusIndex", focusIndex)
end

function Descriptor:getFocusIndex()
  return self:getAttribute("focusIndex")
end

function Descriptor:setFocusBorderColor(focusBorderColor)
  self:addAttribute("focusBorderColor", focusBorderColor)
end

function Descriptor:getFocusBorderColor()
  return self:getAttribute("focusBorderColor")
end

function Descriptor:setFocusBorderWidth(focusBorderWidth)
  self:addAttribute("focusBorderWidth", focusBorderWidth)
end

function Descriptor:getFocusBorderWidth()
  return self:getAttribute("focusBorderWidth")
end

function Descriptor:setFocusBorderTransparency(focusBorderTransparency)
  self:addAttribute("focusBorderTransparency", focusBorderTransparency)
end

function Descriptor:getFocusBorderTransparency()
  return self:getAttribute("focusBorderTransparency")
end

function Descriptor:setFocusSrc(focusSrc)
  self:addAttribute("focusSrc", focusSrc)
end

function Descriptor:getFocusSrc()
  return self:getAttribute("focusSrc")
end

function Descriptor:setFocusSelSrc(focusSelSrc)
  self:addAttribute("focusSelSrc", focusSelSrc)
end

function Descriptor:getFocusSelSrc()
  return self:getAttribute("focusSelSrc")
end

function Descriptor:setSelBorderColor(selBorderColor)
  self:addAttribute("selBorderColor", selBorderColor)
end

function Descriptor:getSelBorderColor()
  return self:getAttribute("selBorderColor")
end

function Descriptor:setTransIn(...)
  if(#arg > 0)then
    local id = ""

    for p, transIn in ipairs(arg) do
      if(type(transIn) == "table" and transIn.name == "transition")then
        id = id + transIn:getId()
        table.insert(self.transInAss, transIn)
        table.insert(transIn.ass, self)

        if(p < #arg)then
          id = id + ","
        end
      else
        error("Invalid transin element!")
      end
    end

    self:addAttribute("transIn", id)
  else
    if(type(arg) == "table")then
      self:addAttribute("transIn", arg:getId())
    else
      self:addAttribute("transIn", arg)
    end
  end
end

function Descriptor:getTransIn()
  return self:getAttribute("transIn")
end

function Descriptor:setTransOut(...)
  if(#arg > 0)then
    local id = ""

    for p, transOut in ipairs(arg) do
      if(type(transOut) == "table" and transOut.name == "transition")then
        id = id + transOut:getId()
        table.insert(self.transOutAss, transOut)
        table.insert(transOut.ass, self)
          
        if(p < #arg)then
          id = id + ","
        end
      else
        error("Invalid transout element!")
      end
    end

    self:addAttribute("transOut", id)
  else
    if(type(arg) == "table")then
      self:addAttribute("transIn", arg:getId())
    else
      self:addAttribute("transIn", arg)
    end
  end
end

function Descriptor:getTransOut()
  return self:getAttribute("transOut")
end

function Descriptor:addDescriptorParam(descriptorParam)
  self:addChild(descriptorParam)
  table.insert(self.descriptorParams, descriptorParam)
end

function Descriptor:getDescriptorParamPos(p)
  if(p > #self.descriptorParams)then
    error("Error! descriptor element doesn't have a descriptorParam child in position "..p.."!", 2)
  end
    
  return self.descriptorParams[p]
end

function Descriptor:setDescriptorParams(...)
  if(#arg>0)then
    for _, descriptorParam in ipairs(arg) do
      self:addDescriptorParam(descriptorParam)
    end
  end
end

function Descriptor:removeDescriptorParam(descriptorParam)
  self:removeChild(descriptorParam)

  for p, dp in ipairs(self.descriptorParams) do
    if(descriptorParam == dp)then
      table.remove(self.descriptorParams, p)
    end
  end
end

function Descriptor:removeDescriptorParamPos(p)
  self:removeChildPos(p)
  table.remove(self.descriptorParams, p)
end

return Descriptor
