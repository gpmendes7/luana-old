local NCLElem = require "core/NCLElem"
local SimpleAction = require "core/connectors/SimpleAction"

local CompoundAction = NCLElem:extends()

CompoundAction.nameElem = "compoundAction"

CompoundAction.childrenMap = {
  simpleAction = {SimpleAction, "many"},
  compoundAction = {CompoundAction, "many"}
}

CompoundAction.attributesTypeMap = {
  operator = "string",
  delay = {"string", "number"}
}

CompoundAction.attributesStringValueMap = {
  operator = {"seq", "par"}
}

CompoundAction.attributesSymbolMap = {
  delay = "s"
}

function CompoundAction:create(attributes, full)
  local compoundAction = CompoundAction:new()

  compoundAction.operator = nil
  compoundAction.delay = nil

  if(attributes ~= nil)then
    compoundAction:setAttributes(attributes)
  end

  compoundAction.children = {}
  compoundAction.simpleActions = {}
  compoundAction.compoundActions = {}

  compoundAction.symbols = {}

  if(full ~= nil)then
    compoundAction:addSimpleAction(SimpleAction:create())
    compoundAction:addCompoundAction(CompoundAction:create())
  end

  return compoundAction
end

function CompoundAction:setOperator(operator)
  self:addAttribute("operator", operator)
end

function CompoundAction:getOperator()
  return self:getAttribute("operator")
end

function CompoundAction:setDelay(delay, symbol)
  self:addAttribute("delay", delay, symbol)
end

function CompoundAction:getDelay()
  return self:getAttribute("delay")
end

function CompoundAction:addSimpleAction(simpleAction)
  if((type(simpleAction) == "table"
    and simpleAction["getNameElem"] ~= nil
    and simpleAction:getNameElem() ~= "simpleAction")
    or (type(simpleAction) == "table"
    and simpleAction["getNameElem"] == nil)
    or type(simpleAction) ~= "table")then
    error("Error! Invalid simpleAction element!", 2)
  end

  self:addChild(simpleAction)
  table.insert(self.simpleActions, simpleAction)
end

function CompoundAction:getSimpleActionPos(p)
  if(self.simpleActions == nil)then
    error("Error! compoundAction element with nil simpleActions list!", 2)
  elseif(p > #self.simpleActions)then
    error("Error! compoundAction element doesn't have a simpleAction child in position "..p.."!", 2)
  end

  return self.simpleActions[p]
end

function CompoundAction:setSimpleActions(...)
  if(#arg>0)then
    for _, simpleAction in ipairs(arg) do
      self:addSimpleAction(simpleAction)
    end
  end
end

function CompoundAction:removeSimpleAction(simpleAction)
  if((type(simpleAction) == "table"
    and simpleAction["getNameElem"] ~= nil
    and simpleAction:getNameElem() ~= "simpleAction")
    or (type(simpleAction) == "table"
    and simpleAction["getNameElem"] == nil)
    or type(simpleAction) ~= "table")then
    error("Error! Invalid simpleAction element!", 2)
  elseif(self.children == nil)then
    error("Error! compoundAction element with nil children list!", 2)
  elseif(self.simpleActions == nil)then
    error("Error! compoundAction element with nil simpleActions list!", 2)
  end

  self:removeChild(simpleAction)

  for p, sa in ipairs(self.simpleActions) do
    if(simpleAction == sa)then
      table.remove(self.simpleActions, p)
    end
  end
end

function CompoundAction:removeSimpleActionPos(p)
  if(self.children == nil)then
    error("Error! compoundAction element with nil children list!", 2)
  elseif(self.simpleActions == nil)then
    error("Error! compoundAction element with nil simpleActions list!", 2)
  elseif(p > #self.children)then
    error("Error! compoundAction element doesn't have a simpleAction child in position "..p.."!", 2)
  elseif(p > #self.simpleActions)then
    error("Error! compoundAction element doesn't have a simpleAction child in position "..p.."!", 2)
  end

  self:removeChild(self.simpleActions[p])
  table.remove(self.simpleActions, p)
end

function CompoundAction:addCompoundAction(compoundAction)
  if((type(compoundAction) == "table"
    and compoundAction["getNameElem"] ~= nil
    and compoundAction:getNameElem() ~= "compoundAction")
    or (type(compoundAction) == "table"
    and compoundAction["getNameElem"] == nil)
    or type(compoundAction) ~= "table")then
    error("Error! Invalid compoundAction element!", 2)
  end

  self:addChild(compoundAction)
  table.insert(self.compoundActions, compoundAction)
end

function CompoundAction:getCompoundActionPos(p)
  if(self.compoundActions == nil)then
    error("Error! compoundAction element with nil compoundActions list!", 2)
  elseif(p > #self.compoundActions)then
    error("Error! compoundAction element doesn't have a compoundAction child in position "..p.."!", 2)
  end

  return self.compoundActions[p]
end

function CompoundAction:setCompoundActions(...)
  if(#arg>0)then
    for _, compoundAction in ipairs(arg) do
      self:addCompoundAction(compoundAction)
    end
  end
end

function CompoundAction:removeCompoundAction(compoundAction)
  if((type(compoundAction) == "table"
    and compoundAction["getNameElem"] ~= nil
    and compoundAction:getNameElem() ~= "compoundAction")
    or (type(compoundAction) == "table"
    and compoundAction["getNameElem"] == nil)
    or type(compoundAction) ~= "table")then
    error("Error! Invalid compoundAction element!", 2)
  elseif(self.children == nil)then
    error("Error! compoundAction element with nil children list!", 2)
  elseif(self.compoundActions == nil)then
    error("Error! compoundAction element with nil compoundActions list!", 2)
  end

  self:removeChild(compoundAction)

  for p, ca in ipairs(self.compoundActions) do
    if(compoundAction == ca)then
      table.remove(self.compoundActions, p)
    end
  end
end

function CompoundAction:removeCompoundActionPos(p)
   if(self.children == nil)then
    error("Error! compoundAction element with nil children list!", 2)
  elseif(self.compoundActions == nil)then
    error("Error! compoundAction element with nil compoundActions list!", 2)
  elseif(p > #self.children)then
    error("Error! compoundAction element doesn't have a compoundAction child in position "..p.."!", 2)
  elseif(p > #self.compoundActions)then
    error("Error! compoundAction element doesn't have a compoundAction child in position "..p.."!", 2)
  end
  
  self:removeChild(self.compoundActions[p])
  table.remove(self.compoundActions, p)
end

return CompoundAction