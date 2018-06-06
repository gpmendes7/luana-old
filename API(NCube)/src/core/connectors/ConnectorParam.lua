local NCLElem = require "core/NCLElem"

---
-- Implements ConnectorParam Class representing <b>&lt;connectorParam&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=connectorparam">
-- http://handbook.ncl.org.br/doku.php?id=connectorparam</a>
-- 
-- @module ConnectorParam
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local ConnectorParam = require "core/connectors/ConnectorParam" 
local ConnectorParam = NCLElem:extends()

---
-- Name of <b>&lt;connectorParam&gt;</b> element.
-- 
-- @field [parent=#ConnectorParam] #string nameElem
ConnectorParam.nameElem = "connectorParam"

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;connectorParam&gt;</b> element.
-- 
-- @field [parent=#ConnectorParam] #table attributesTypeMap
ConnectorParam.attributesTypeMap = {
  name = "string",
  type = "string"
}

---
-- Returns a new ConnectorParam object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#ConnectorParam] create
-- @param #table attributes list of attributes to be initialized.
-- @return #ConnectorParam new ConnectorParam object created.
function ConnectorParam:create(attributes)
  local connectorParam = ConnectorParam:new()

  connectorParam.name = nil
  connectorParam.type = nil

  if(attributes ~= nil)then
    connectorParam:setAttributes(attributes)
  end

  return connectorParam
end

---
-- Sets a value to `name` attribute of the 
-- <b>&lt;connectorParam&gt;</b> element. 
-- 
-- @function [parent=#ConnectorParam] setName
-- @param #string name `name` atribute of the
-- <b>&lt;connectorParam&gt;</b> element.
function ConnectorParam:setName(name)
  self:addAttribute("name", name)
end

---
-- Returns the value of the `name` attribute of the 
-- <b>&lt;connectorParam&gt;</b> element. 
-- 
-- @function [parent=#ConnectorParam] getName
-- @return #string `name` atribute of the <b>&lt;connectorParam&gt;</b> element.
function ConnectorParam:getName()
  return self:getAttribute("name")
end

---
-- Sets a value to `type` attribute of the 
-- <b>&lt;connectorParam&gt;</b> element. 
-- 
-- @function [parent=#ConnectorParam] setType
-- @param #string type `type` atribute of the
-- <b>&lt;connectorParam&gt;</b> element.
function ConnectorParam:setType(type)
  self:addAttribute("type", type)
end

---
-- Returns the value of the `type` attribute of the 
-- <b>&lt;connectorParam&gt;</b> element. 
-- 
-- @function [parent=#ConnectorParam] getType
-- @return #string `type` atribute of the <b>&lt;connectorParam&gt;</b> element.
function ConnectorParam:getType()
  return self:getAttribute("type")
end

return ConnectorParam