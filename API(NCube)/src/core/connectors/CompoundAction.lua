local NCLElem = require "core/NCLElem"
local SimpleAction = require "core/connectors/SimpleAction"

local CompoundAction = NCLElem:extends()

CompoundAction.name = "compoundAction"

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
  self:addChild(simpleAction)
  table.insert(self.simpleActions, simpleAction)
end

function CompoundAction:getSimpleActionPos(p)
  if(p > #self.simpleActions)then
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
  self:removeChild(simpleAction)

  for p, sa in ipairs(self.simpleActions) do
    if(simpleAction == sa)then
      table.remove(self.simpleActions, p)
    end
  end
end

function CompoundAction:removeSimpleActionPos(p)
  self:removeChildPos(p)
  table.remove(self.simpleActions, p)
end

function CompoundAction:addCompoundAction(compoundAction)
  self:addChild(compoundAction)
  table.insert(self.compoundActions, compoundAction)
end

function CompoundAction:getCompoundActionPos(p)
  if(p > #self.compoundActions)then
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
  self:removeChild(compoundAction)

  for p, ca in ipairs(self.compoundActions) do
    if(compoundAction == ca)then
      table.remove(self.compoundActions, p)
    end
  end
end

function CompoundAction:removeCompoundActionPos(p)
  self:removeChildPos(p)
  table.remove(self.compoundActions, p)
end

return CompoundAction
