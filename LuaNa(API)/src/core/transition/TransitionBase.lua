local NCLElem = require "LuaNa(API)/src/core/NCLElem"
local ImportBase = require "LuaNa(API)/src/core/importation/ImportBase"
local Transition = require "LuaNa(API)/src/core/transition/Transition"

local TransitionBase = NCLElem:extends()

TransitionBase.nameElem = "transitionBase"

TransitionBase.childrenMap = {
  importBase = {ImportBase, "many"},
  transition = {Transition, "many"}
}

TransitionBase.attributesTypeMap = {
  id = "string"
}

function TransitionBase:create(attributes, full)
  local transitionBase = TransitionBase:new()

  transitionBase.id = nil

  if(attributes ~= nil)then
    transitionBase:setAttributes(attributes)
  end

  transitionBase.children = {}
  transitionBase.importBases = {}
  transitionBase.transitions = {}

  if(full ~= nil)then
    transitionBase:addImportBase(ImportBase:create())
    transitionBase:addTransition(Transition:create())
  end

  return transitionBase
end

function TransitionBase:setId(id)
  self:addAttribute("id", id)
end

function TransitionBase:getId()
  return self:getAttribute("id")
end

function TransitionBase:addImportBase(importBase)
  if((type(importBase) == "table"
    and importBase["getNameElem"] ~= nil
    and importBase:getNameElem() ~= "importBase")
    or (type(importBase) == "table"
    and importBase["getNameElem"] == nil)
    or type(importBase) ~= "table")then
    error("Error! Invalid importBase element!", 2)
  end

  self:addChild(importBase)
  table.insert(self.importBases, importBase)
end

function TransitionBase:getImportBasePos(p)
  if(self.importBases == nil)then
    error("Error! transitionBase element with nil importBases list!", 2)
  elseif(p > #self.importBases)then
    error("Error! transitionBase element doesn't have a importBase child in position "..p.."!", 2)
  end

  return self.importBases[p]
end

function TransitionBase:getImportBaseByAlias(alias)
  if(alias == nil)then
    error("Error! alias attribute of importBase element must be informed!", 2)
  elseif(self.importBases == nil)then
    error("Error! transitionBase element with nil importBases list!", 2)
  end

  for _, importBase in ipairs(self.importBases) do
    if(importBase:getAlias() == alias)then
      return importBase
    end
  end

  return nil
end

function TransitionBase:setImportBases(...)
  if(#arg>0)then
    for _, importBase in ipairs(arg) do
      self:addImportBase(importBase)
    end
  end
end

function TransitionBase:removeImportBase(importBase)
  if((type(importBase) == "table"
    and importBase["getNameElem"] ~= nil
    and importBase:getNameElem() ~= "importBase")
    or (type(importBase) == "table"
    and importBase["getNameElem"] == nil)
    or type(importBase) ~= "table")then
    error("Error! Invalid importBase element!", 2)
  elseif(self.children == nil)then
    error("Error! transitionBase element with nil children list!", 2)
  elseif(self.importBases == nil)then
    error("Error! transitionBase element with nil importBases list!", 2)
  end

  self:removeChild(importBase)

  for p, ib in ipairs(self.importBases) do
    if(importBase == ib)then
      table.remove(self.importBases, p)
    end
  end
end

function TransitionBase:removeImportBasePos(p)
  if(self.children == nil)then
    error("Error! transitionBase element with nil children list!", 2)
  elseif(self.importBases == nil)then
    error("Error! transitionBase element with nil importBases list!", 2)
  elseif(p > #self.children)then
    error("Error! transitionBase element doesn't have a importBase child in position "..p.."!", 2)
  elseif(p > #self.importBases)then
    error("Error! transitionBase element doesn't have a importBase child in position "..p.."!", 2)
  end

  self:removeChild(self.importBases[p])
  table.remove(self.importBases, p)
end

function TransitionBase:addTransition(transition)
  if((type(transition) == "table"
    and transition["getNameElem"] ~= nil
    and transition:getNameElem() ~= "transition")
    or (type(transition) == "table"
    and transition["getNameElem"] == nil)
    or type(transition) ~= "table")then
    error("Error! Invalid transition element!", 2)
  end

  self:addChild(transition)
  table.insert(self.transitions, transition)
end

function TransitionBase:getTransitionPos(p)
  if(self.transitions == nil)then
    error("Error! transitionBase element with nil transitions list!", 2)
  elseif(p > #self.transitions)then
    error("Error! transitionBase element doesn't have a transition child in position "..p.."!", 2)
  end

  return self.transitions[p]
end

function TransitionBase:getTransitionById(id)
  if(alias == nil)then
    error("Error! alias attribute of transition element must be informed!", 2)
  elseif(self.transitions == nil)then
    error("Error! transitionBase element with nil transitions list!", 2)
  end

  for _, transition in ipairs(self.transitions) do
    if(transition:getId() == id)then
      return transition
    end
  end

  return nil
end

function TransitionBase:setTransitions(...)
  if(#arg>0)then
    for _, transition in ipairs(arg) do
      self:addTransition(transition)
    end
  end
end

function TransitionBase:removeTransition(transition)
  if((type(transition) == "table"
    and transition["getNameElem"] ~= nil
    and transition:getNameElem() ~= "transition")
    or (type(transition) == "table"
    and transition["getNameElem"] == nil)
    or type(transition) ~= "table")then
    error("Error! Invalid transition element!", 2)
  elseif(self.children == nil)then
    error("Error! transitionBase element with nil children list!", 2)
  elseif(self.transitions == nil)then
    error("Error! transitionBase element with nil transitions list!", 2)
  end

  self:removeChild(transition)

  for p, ts in ipairs(self.transitions) do
    if(transition == ts)then
      table.remove(self.transitions, p)
    end
  end
end

function TransitionBase:removeTransitionPos(p)
  if(self.children == nil)then
    error("Error! transitionBase element with nil children list!", 2)
  elseif(self.transitions == nil)then
    error("Error! transitionBase element with nil transitions list!", 2)
  elseif(p > #self.children)then
    error("Error! transitionBase element doesn't have a transition child in position "..p.."!", 2)
  elseif(p > #self.transitions)then
    error("Error! transitionBase element doesn't have a transition child in position "..p.."!", 2)
  end

  self:removeChild(self.transitions[p])
  table.remove(self.transitions, p)
end

return TransitionBase