local NCLElem = require "core/structure_content/NCLElem"

local Descriptor = NCLElem:extends()

Descriptor.name = "descriptor"

Descriptor.attributes = {
  id = nil, 
  player = nil,
  explicitDur = nil, 
  region = nil,
  freeze = nil,
  moveLeft = nil, 
  moveRight = nil, 
  moveUp = nil, 
  moveDown = nil, 
  focusIndex = nil, 
  focusBorderColor = nil, 
  focusBorderWidth = nil, 
  focusBorderTransparency = nil, 
  focusSrc = nil, 
  focusSelSrc = nil, 
  selBorderColor = nil, 
  transIn = nil, 
  transOut = nil
}

Descriptor.hasAss = true

Descriptor.assMap = {
  {"region", "regionAss"}
}

Descriptor.regionAss = nil

function Descriptor:create(attributes)  
   local attributes = attributes or {}  
   local descriptor = Descriptor:new() 
     
   descriptor:setAttributes(attributes)
   descriptor:setChilds()
   
   return descriptor
end

function Descriptor:setId(id)
   self.attributes.id = id
end

function Descriptor:getId()
   return self.attributes.id
end

function Descriptor:setPlayer(player)
   self.attributes.player = player
end

function Descriptor:getPlayer()
   return self.attributes.player
end

function Descriptor:setExplicitDur(explicitDur)
   self.attributes.explicitDur = explicitDur
end

function Descriptor:getExplicitDur()
   return self.attributes.explicitDur
end

function Descriptor:setRegion(region)
   self.attributes.region = region
end

function Descriptor:getRegion()
   return self.attributes.region
end

function Descriptor:setRegionAss(regionAss)
   self.regionAss = regionAss
end

function Descriptor:getRegionAss()
   return self.regionAss
end

function Descriptor:setFreeze(freeze)
   self.attributes.freeze = freeze
end

function Descriptor:getFreeze()
   return self.attributes.freeze
end

function Descriptor:setMoveLeft(moveLeft)
   self.attributes.moveLeft = moveLeft
end

function Descriptor:getMoveLeft()
   return self.attributes.moveLeft
end

function Descriptor:setMoveRight(moveRight)
   self.attributes.moveRight = moveRight
end

function Descriptor:getMoveRight()
   return self.attributes.moveRight
end

function Descriptor:setMoveUp(moveUp)
   self.attributes.moveUp = moveUp
end

function Descriptor:getMoveUp()
   return self.attributes.moveUp
end

function Descriptor:setMoveDown(moveDown)
   self.attributes.moveDown = moveDown
end

function Descriptor:getMoveDown()
   return self.attributes.moveDown
end

function Descriptor:setFocusIndex(focusIndex)
   self.attributes.focusIndex = focusIndex
end

function Descriptor:getFocusIndex()
   return self.attributes.focusIndex
end

function Descriptor:setFocusBorderColor(focusBorderColor)
   self.attributes.focusBorderColor = focusBorderColor
end

function Descriptor:getFocusBorderColor()
   return self.attributes.focusBorderColor
end

function Descriptor:setFocusBorderWidth(focusBorderWidth)
   self.attributes.focusBorderWidth = focusBorderWidth
end

function Descriptor:getFocusBorderWidth()
   return self.attributes.focusBorderWidth
end

function Descriptor:setFocusBorderTransparency(focusBorderTransparency)
   self.attributes.focusBorderTransparency = focusBorderTransparency
end

function Descriptor:getFocusBorderTransparency()
   return self.attributes.focusBorderTransparency
end

function Descriptor:setFocusSrc(focusSrc)
   self.attributes.focusSrc = focusSrc
end

function Descriptor:getFocusSrc()
   return self.attributes.focusSrc
end

function Descriptor:setFocusSelSrc(focusSelSrc)
   self.attributes.focusSelSrc = focusSelSrc
end

function Descriptor:getFocusSelSrc()
   return self.attributes.focusSelSrc
end

function Descriptor:setSelBorderColor(selBorderColor)
   self.attributes.selBorderColor = selBorderColor
end

function Descriptor:getSelBorderColor()
   return self.attributes.selBorderColor
end

function Descriptor:setTransIn(transIn)
   self.attributes.transIn = transIn
end

function Descriptor:getTransIn()
   return self.attributes.transIn
end

function Descriptor:setTransOut(transOut)
   self.attributes.transOut = transOut
end

function Descriptor:getTransOut()
   return self.attributes.transOut
end

return Descriptor