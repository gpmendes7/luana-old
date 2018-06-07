local NCLElem = require "core/NCLElem"
local ConnectorParam = require "core/connectors/ConnectorParam"
local SimpleCondition = require "core/connectors/SimpleCondition"
local CompoundCondition = require "core/connectors/CompoundCondition"
local SimpleAction = require "core/connectors/SimpleAction"
local CompoundAction = require "core/connectors/CompoundAction"

---
-- Implements CausalConnector Class representing <b>&lt;causalConnector&gt;</b> element.
--  
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=causalconnector">
-- http://handbook.ncl.org.br/doku.php?id=causalconnector</a>
-- 
-- @module CausalConnector
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local CausalConnector = require "core/connectors/CausalConnector" 
local CausalConnector = NCLElem:extends()

---
-- Name of <b>&lt;causalConnector&gt;</b> element.
-- 
-- @field [parent=#CausalConnector] #string nameElem 
CausalConnector.nameElem = "causalConnector"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;causalConnector&gt;</b> element.
-- 
-- @field [parent=#CausalConnector] #table childrenMap
CausalConnector.childrenMap = {
  connectorParam = {ConnectorParam, "many"},
  simpleCondition = {SimpleCondition, "one"},
  compoundCondition = {CompoundCondition, "one"},
  simpleAction = {SimpleAction, "one"},
  compoundAction = {CompoundAction, "one"}
}

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;causalConnector&gt;</b> element.
-- 
-- @field [parent=#CausalConnector] #table attributesTypeMap  
CausalConnector.attributesTypeMap = {
  id = "string"
}

---
-- Returns a new CausalConnector object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#CausalConnector] create
-- @param #table attributes list of attributes to be initialized.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #CausalConnector new CausalConnector object created.
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

---
-- Sets a value to `id` attribute of the 
-- <b>&lt;causalConnector&gt;</b> element. 
-- 
-- @function [parent=#CausalConnector] setId
-- @param #string id `id` atribute of the
-- <b>&lt;causalConnector&gt;</b> element.
function CausalConnector:setId(id)
  self:addAttribute("id", id)
end

---
-- Returns the value of the `id` attribute of the 
-- <b>&lt;causalConnector&gt;</b> element. 
-- 
-- @function [parent=#CausalConnector] getId
-- @return #string `id` atribute of the <b>&lt;causalConnector&gt;</b> element.
function CausalConnector:getId()
  return self:getAttribute("id")
end

---
-- Adds a <b>&lt;connectorParam&gt;</b> child element of the 
-- <b>&lt;causalConnector&gt;</b> element. 
-- 
-- @function [parent=#CausalConnector] addConnectorParam
-- @param #ConnectorParam connectorParam object representing the 
-- <b>&lt;connectorParam&gt;</b> element.
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

---
-- Returns a <b>&lt;connectorParam&gt;</b> child element of the 
-- <b>&lt;causalConnector&gt;</b> element
-- in position `p`.
--  
-- @function [parent=#CausalConnector] getConnectorParamPos
-- @param #number p  position of the object representing the <b>&lt;connectorParam&gt;</b> element.
function CausalConnector:getConnectorParamPos(p)
  if(self.connectorParams == nil)then
    error("Error! causalConnector element with nil connectorParams list!", 2)
  elseif(p > #self.connectorParams)then
    error("Error! causalConnector element doesn't have a connectorParam child in position "..p.."!", 2)
  end

  return self.connectorParams[p]
end

---
-- Adds so many <b>&lt;connectorParam&gt;</b> child elements of the <b>&lt;causalConnector&gt;</b> element
-- passed as parameters.
-- 
-- @function [parent=#CausalConnector] setConnectorParams
-- @param #ConnectorParam ... objects representing the <b>&lt;connectorParam&gt;</b>
function CausalConnector:setConnectorParams(...)
  if(#arg>0)then
    for _, connectorParam in ipairs(arg) do
      self:addConnectorParam(connectorParam)
    end
  end
end

---
-- Removes a <b>&lt;connectorParam&gt;</b> child element of the 
-- <b>&lt;causalConnector&gt;</b> element. 
-- 
-- @function [parent=#CausalConnector] removeConnectorParam
-- @param #ConnectorParam connectorParam object representing the <b>&lt;connectorParam&gt;</b> element.
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

---
-- Removes a <b>&lt;connectorParam&gt;</b> child element of the 
-- <b>&lt;causalConnector&gt;</b> element in position `p`.
-- 
-- @function [parent=#CausalConnector] removeConnectorParamPos
-- @param #number p position of the <b>&lt;connectorParam&gt;</b> child element.
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

---
-- Sets the <b>&lt;simpleCondition&gt;</b> child element of the 
-- <b>&lt;causalConnector&gt;</b> element. 
-- 
-- @function [parent=#CausalConnector] setSimpleCondition
-- @param #SimpleCondition simpleCondition object representing the 
-- <b>&lt;simpleCondition&gt;</b> element.
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

---
-- Returns the <b>&lt;simpleCondition&gt;</b> child element of the 
-- <b>&lt;causalConnector&gt;</b> element.
--  
-- @function [parent=#CausalConnector] getSimpleCondition
-- @return #SimpleCondition simpleCondition object representing the <b>&lt;simpleCondition&gt;</b> element.
function CausalConnector:getSimpleCondition()
  return self.simpleCondition
end

---
-- Removes the <b>&lt;simpleCondition&gt;</b> child element of the 
-- <b>&lt;causalConnector&gt;</b> element.
-- 
-- @function [parent=#CausalConnector] removeSimpleCondition
function CausalConnector:removeSimpleCondition()
  self:removeChild(self.simpleCondition)
  self.simpleCondition = nil
end

---
-- Sets the <b>&lt;compoundCondition&gt;</b> child element of the 
-- <b>&lt;causalConnector&gt;</b> element. 
-- 
-- @function [parent=#CausalConnector] setCompoundCondition
-- @param #CompoundCondition compoundCondition object representing the 
-- <b>&lt;compoundCondition&gt;</b> element.
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

---
-- Returns the <b>&lt;compoundCondition&gt;</b> child element of the 
-- <b>&lt;causalConnector&gt;</b> element.
--  
-- @function [parent=#CausalConnector] getCompoundCondition
-- @return #CompoundCondition compoundCondition object representing the <b>&lt;compoundCondition&gt;</b> element.
function CausalConnector:getCompoundCondition()
  return self.compoundCondition
end

---
-- Removes the <b>&lt;compoundCondition&gt;</b> child element of the 
-- <b>&lt;causalConnector&gt;</b> element.
-- 
-- @function [parent=#CausalConnector] removeCompoundCondition
function CausalConnector:removeCompoundCondition()
  self:removeChild(self.compoundCondition)
  self.compoundCondition = nil
end

---
-- Sets the <b>&lt;simpleAction&gt;</b> child element of the 
-- <b>&lt;causalConnector&gt;</b> element. 
-- 
-- @function [parent=#CausalConnector] setSimpleAction
-- @param #SimpleAction simpleAction object representing the 
-- <b>&lt;simpleAction&gt;</b> element.
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

---
-- Returns the <b>&lt;simpleAction&gt;</b> child element of the 
-- <b>&lt;causalConnector&gt;</b> element.
--  
-- @function [parent=#CausalConnector] getSimpleAction
-- @return #SimpleAction simpleAction object representing the <b>&lt;simpleAction&gt;</b> element.
function CausalConnector:getSimpleAction()
  return self.simpleAction
end

---
-- Removes the <b>&lt;simpleAction&gt;</b> child element of the 
-- <b>&lt;causalConnector&gt;</b> element.
-- 
-- @function [parent=#CausalConnector] removeSimpleAction
function CausalConnector:removeSimpleAction()
  self:removeChild(self.simpleAction)
  self.simpleAction = nil
end

---
-- Sets the <b>&lt;compoundAction&gt;</b> child element of the 
-- <b>&lt;causalConnector&gt;</b> element. 
-- 
-- @function [parent=#CausalConnector] setCompoundAction
-- @param #CompoundAction compoundAction object representing the 
-- <b>&lt;compoundAction&gt;</b> element
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

---
-- Returns the <b>&lt;compoundAction&gt;</b> child element of the 
-- <b>&lt;causalConnector&gt;</b> element.
--  
-- @function [parent=#CausalConnector] getCompoundAction
-- @return #CompoundAction compoundAction object representing the <b>&lt;compoundAction&gt;</b> element.
function CausalConnector:getCompoundAction()
  return self.compoundAction
end

---
-- Removes the <b>&lt;compoundAction&gt;</b> child element of the 
-- <b>&lt;causalConnector&gt;</b> element.
-- 
-- @function [parent=#CausalConnector] removeCompoundAction
function CausalConnector:removeCompoundAction()
  self:removeChild(self.compoundAction)
  self.compoundAction = nil
end

return CausalConnector