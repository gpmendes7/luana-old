local NCLElem = require "core/NCLElem"
local ConnectorParam = require "core/connectors/ConnectorParam"
local SimpleCondition = require "core/connectors/SimpleCondition"
local CompoundCondition = require "core/connectors/CompoundCondition"
local SimpleAction = require "core/connectors/SimpleAction"
local CompoundAction = require "core/connectors/CompoundAction"

local CausalConnector = NCLElem:extends()

CausalConnector.nameElem = "causalConnector"

CausalConnector.childrenMap = {
  connectorParam = {ConnectorParam, "many"},
  simpleCondition = {SimpleCondition, "one"},
  compoundCondition = {CompoundCondition, "one"},
  simpleAction = {SimpleAction, "one"},
  compoundAction = {CompoundAction, "one"}
}

CausalConnector.attributesTypeMap = {
  id = "string"
}

function CausalConnector:create(attributes, full)
  local causalConnector = CausalConnector:new()

  causalConnector.id = nil

  causalConnector.ass = {}

  if(attributes ~= nil)then
    causalConnector:setAttributes(attributes)
  end

  causalConnector.children = {}
  causalConnector.connectorParams = {}

  if(full ~= nil)then
    causalConnector:addConnectorParam(ConnectorParam:create())
    causalConnector:setCompoundCondition(CompoundCondition:create())
    causalConnector:setCompoundAction(CompoundAction:create())
  end

  return causalConnector
end

function CausalConnector:setId(id)
  self:addAttribute("id", id)
end

function CausalConnector:getId()
  return self:getAttribute("id")
end

function CausalConnector:addConnectorParam(connectorParam)
  if((type(connectorParam) == "table"
    and connectorParam["getNameElem"] ~= nil
    and connectorParam:getNameElem() ~= "connectorParam")
    or (type(connectorParam) == "table"
    and connectorParam["getNameElem"] == nil)
    or type(connectorParam) ~= "table")then
    error("Error! Invalid connectorParam element!", 2)
  end

  local p = self:getPosAvailable("connectorParam")

  if(p ~= nil)then
    self:addChild(connectorParam, p)
  else
    self:addChild(connectorParam, 1)
  end

  table.insert(self.connectorParams, connectorParam)
end

function CausalConnector:getConnectorParamPos(p)
  if(self.connectorParams == nil)then
    error("Error! causalConnector element with nil connectorParams list!", 2)
  elseif(p > #self.connectorParams)then
    error("Error! causalConnector element doesn't have a connectorParam child in position "..p.."!", 2)
  end

  return self.connectorParams[p]
end

function CausalConnector:setConnectorParams(...)
  if(#arg>0)then
    for _, connectorParam in ipairs(arg) do
      self:addConnectorParam(connectorParam)
    end
  end
end

function CausalConnector:removeConnectorParam(connectorParam)
  if((type(connectorParam) == "table"
    and connectorParam["getNameElem"] ~= nil
    and connectorParam:getNameElem() ~= "connectorParam")
    or (type(connectorParam) == "table"
    and connectorParam["getNameElem"] == nil)
    or type(connectorParam) ~= "table")then
    error("Error! Invalid connectorParam element!", 2)
  elseif(self.children == nil)then
    error("Error! causalConnector element with nil children list!", 2)
  elseif(self.connectorParams == nil)then
    error("Error! causalConnector element with nil connectorParams list!", 2)
  end

  self:removeChild(connectorParam)

  for p, cp in ipairs(self.connectorParams) do
    if(connectorParam == cp)then
      table.remove(self.connectorParams, p)
    end
  end
end

function CausalConnector:removeConnectorParamPos(p)
  if(self.children == nil)then
    error("Error! causalConnector element with nil children list!", 2)
  elseif(self.connectorParams == nil)then
    error("Error! causalConnector element with nil connectorParams list!", 2)
  elseif(p > #self.children)then
    error("Error! causalConnector element doesn't have a connectorParam child in position "..p.."!", 2)
  elseif(p > #self.connectorParams)then
    error("Error! causalConnector element doesn't have a connectorParam child in position "..p.."!", 2)
  end

  self:removeChild(self.connectorParams[p])
  table.remove(self.connectorParams, p)
end

function CausalConnector:setSimpleCondition(simpleCondition)
  if((type(simpleCondition) == "table"
    and simpleCondition["getNameElem"] ~= nil
    and simpleCondition:getNameElem() ~= "simpleCondition")
    or (type(simpleCondition) == "table"
    and simpleCondition["getNameElem"] == nil)
    or type(simpleCondition) ~= "table")then
    error("Error! Invalid simpleCondition element!", 2)
  end

  local p

  if(self.simpleCondition == nil and self.compoundCondition == nil)then
    p = self:getPosAvailable("connectorParam")
    if(p ~= nil)then
      self:addChild(simpleCondition, p)
    else
      self:addChild(simpleCondition, 1)
    end
  else
    p = self:getPosAvailable("simpleCondition", "compoundCondition") - 1
    self:removeChildPos(p)
    self:addChild(simpleCondition, p)
  end

  self.simpleCondition = simpleCondition
  self.compoundCondition = nil
end

function CausalConnector:getSimpleCondition()
  return self.simpleCondition
end

function CausalConnector:removeSimpleCondition()
  self:removeChild(self.simpleCondition)
  self.simpleCondition = nil
end

function CausalConnector:setCompoundCondition(compoundCondition)
  if((type(compoundCondition) == "table"
    and compoundCondition["getNameElem"] ~= nil
    and compoundCondition:getNameElem() ~= "compoundCondition")
    or (type(compoundCondition) == "table"
    and compoundCondition["getNameElem"] == nil)
    or type(compoundCondition) ~= "table")then
    error("Error! Invalid compoundCondition element!", 2)
  end

  local p

  if(self.simpleCondition == nil and self.compoundCondition == nil)then
    p = self:getPosAvailable("connectorParam")
    if(p ~= nil)then
      self:addChild(compoundCondition, p)
    else
      self:addChild(compoundCondition, 1)
    end
  else
    p = self:getPosAvailable("compoundCondition", "simpleCondition") - 1
    self:removeChildPos(p)
    self:addChild(compoundCondition, p)
  end

  self.compoundCondition = compoundCondition
  self.simpleCondition = nil
end

function CausalConnector:getCompoundCondition()
  return self.compoundCondition
end

function CausalConnector:removeCompoundCondition()
  self:removeChild(self.compoundCondition)
  self.compoundCondition = nil
end

function CausalConnector:setSimpleAction(simpleAction)
  if((type(simpleAction) == "table"
    and simpleAction["getNameElem"] ~= nil
    and simpleAction:getNameElem() ~= "simpleAction")
    or (type(simpleAction) == "table"
    and simpleAction["getNameElem"] == nil)
    or type(simpleAction) ~= "table")then
    error("Error! Invalid simpleAction element!", 2)
  end

  local p

  if(self.simpleAction == nil and self.compoundAction == nil)then
    p = self:getPosAvailable("connectorParam", "simpleCondition",  "compoundCondition")
    if(p ~= nil)then
      self:addChild(simpleAction, p)
    else
      self:addChild(simpleAction, 1)
    end
  else
    p = self:getPosAvailable("simpleAction", "compoundAction") - 1
    self:removeChildPos(p)
    self:addChild(simpleAction, p)
  end

  self.simpleAction = simpleAction
  self.compoundAction = nil
end

function CausalConnector:getSimpleAction()
  return self.simpleAction
end

function CausalConnector:removeSimpleAction()
  self:removeChild(self.simpleAction)
  self.simpleAction = nil
end

function CausalConnector:setCompoundAction(compoundAction)
  if((type(compoundAction) == "table"
    and compoundAction["getNameElem"] ~= nil
    and compoundAction:getNameElem() ~= "compoundAction")
    or (type(compoundAction) == "table"
    and compoundAction["getNameElem"] == nil)
    or type(compoundAction) ~= "table")then
    error("Error! Invalid compoundAction element!")
  end

  local p

  if(self.simpleAction == nil and self.compoundAction == nil)then
    p = self:getPosAvailable("connectorParam", "simpleCondition",  "compoundCondition")
    if(p ~= nil)then
      self:addChild(compoundAction, p)
    else
      self:addChild(compoundAction, 1)
    end
  else
    p = self:getPosAvailable("compoundAction", "simpleAction") - 1
    self:removeChildPos(p)
    self:addChild(compoundAction, p)
  end

  self.compoundAction = compoundAction
  self.simpleAction = nil
end

function CausalConnector:getCompoundAction()
  return self.compoundAction
end

function CausalConnector:removeCompoundAction()
  self:removeChild(self.compoundAction)
  self.compoundAction = nil
end

return CausalConnector