local NCLElem = require "core/NCLElem"
local ElementB = require "core/pseudo/ElementB"
local ElementC = require "core/pseudo/ElementC"

local ElementA = NCLElem:extends()

ElementA.nameElem = "elementA"

ElementA.childrenMap = {
  elementA = {ElementA, "many"},
  elementB = {ElementB, "many"},
  elementC = {ElementC, "many"}
}

ElementA.attributesTypeMap = {
  ["id"] = "string",
  ["desc"] = "string"
}

function ElementA:create(attributes, full)
  local elementA = ElementA:new()

  elementA.id = nil
  elementA.desc = nil

  if(attributes ~= nil)then
    elementA:setAttributes(attributes)
  end

  elementA.children = {}
  elementA.elementsA = {}
  elementA.elementsB = {}
  elementA.elementsC = {}

  if(full ~= nil)then
    elementA:addElementA(ElementA:create())
    elementA:addElementB(ElementB:create(nil, full))
    elementA:addElementC(ElementC:create(nil, full))
  end

  return elementA
end

function ElementA:setId(id)
  self:addAttribute("id", id)
end

function ElementA:getId()
  return self:getAttribute("id")
end

function ElementA:setDesc(desc)
  self:addAttribute("desc", desc)
end

function ElementA:getDesc()
  return self:getAttribute("desc")
end

function ElementA:addElementA(elementA)
  table.insert(self.elementsA, elementA)
  local p = self:getPosAvailable("elementA", "elementB", "elementC")
  if(p ~= nil)then
    self:addChild(elementA, p)
  else
    self:addChild(elementA, 1)
  end
end

function ElementA:getElementAPos(p)
  return self.elementsA[p]
end

function ElementA:getElementAById(id)
  for _, elementA in ipairs(self.elementsA) do
    if(elementA:getId() == id)then
      return elementA
    end
  end

  return nil
end

function ElementA:setElementsA(...)
  if(#arg>0)then
    for _, elementA in ipairs(arg) do
      self:addElementA(elementA)
    end
  end
end

function ElementA:removeElementsA(elementA)
  self:removeChild(elementA)

  for i, elemA in ipairs(self.elementsA) do
    if(elementA == elemA)then
      table.remove(self.elementsA, i)
    end
  end
end

function ElementA:removeElementAPos(p)
  self:removeChildPos(p)
  table.remove(self.elementsA, p)
end

function ElementA:addElementB(elementB)
  table.insert(self.elementsB, elementB)
  local p = self:getPosAvailable("elementB", "elementA", "elementC")
  if(p ~= nil)then
    self:addChild(elementB, p)
  else
    self:addChild(elementB, 1)
  end
end

function ElementA:getElementBPos(p)
  return self.elementsB[p]
end

function ElementA:getElementBById(id)
  for _, elementB in ipairs(self.elementsB) do
    if(elementB:getId() == id)then
      return elementB
    end
  end

  return nil
end

function ElementA:setElementsB(...)
  if(#arg>0)then
    for _, elementB in ipairs(arg) do
      self:addElementB(elementB)
    end
  end
end

function ElementA:removeElementB(elementB)
  self:removeChild(elementB)

  for i, elemB in ipairs(self.elementsB) do
    if(elementB == elemB)then
      table.remove(self.elementsB, i)
    end
  end
end

function ElementA:removeElementBPos(p)
  self:removeChildPos(p)
  table.remove(self.elementsB, p)
end

function ElementA:addElementC(elementC)
  table.insert(self.elementsC, elementC)
  local p = self:getPosAvailable("elementC", "elementB", "elementA")
  if(p ~= nil)then
    self:addChild(elementC, p)
  else
    self:addChild(elementC, 1)
  end
end

function ElementA:getElementCPos(p)
  return self.elementsC[p]
end

function ElementA:getElementCById(id)
  for _, elementC in ipairs(self.elementsC) do
    if(elementC:getId() == id)then
      return elementC
    end
  end

  return nil
end

function ElementA:setElementsC(...)
  if(#arg>0)then
    for _, elementC in ipairs(arg) do
      self:addElementC(elementC)
    end
  end
end

function ElementA:removeElementC(elementC)
  self:removeChild(elementC)

  for i, elemC in ipairs(self.elementsC) do
    if(elementC == elemC)then
      table.remove(self.elementsC, i)
    end
  end
end

function ElementA:removeElementCPos(p)
  self:removeChildPos(p)
  table.remove(self.elementsC, p)
end

return ElementA