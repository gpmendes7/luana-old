local NCLElem = require "core/NCLElem"
local ConnectorParam = require "core/synchronism/ConnectorParam"
local SimpleCondition = require "core/synchronism/SimpleCondition"
local SimpleAction = require "core/synchronism/SimpleAction"

local CausalConnector = NCLElem:extends()

CausalConnector.name = "causalConnector"

CausalConnector.attributes = {
  id = nil
}

CausalConnector.childsMap = {
 ["connectorParam"] = {ConnectorParam, "many", 1},
 ["simpleCondition"] = {SimpleCondition, "one", 2},
 ["simpleAction"] = {SimpleAction, "one", 3}
}

CausalConnector.connectorParams = nil
CausalConnector.simpleCondition = nil
CausalConnector.seq = true

function CausalConnector:create(attributes)  
   local attributes = attributes or {}  
   local causalConnector = CausalConnector:new() 
     
   causalConnector:setAttributes(attributes)
   causalConnector:setChilds()
   causalConnector.connectorParams = {}
   
   return causalConnector
end

function CausalConnector:setId(id)
   self.attributes.id = id
end

function CausalConnector:getId()
   return self.attributes.id
end

function CausalConnector:addConnectorParam(connectorParam)
    table.insert(self.connectorParams, connectorParam)    
    local p = self:getLastPosChild("connectorParam")
    if(p ~= nil)then
       self:addChild(connectorParam, p+1)
    else
       self:addChild(connectorParam, 1)
    end
end

function CausalConnector:getConnectorParam(i)
    return self.connectorParams[i]
end

function CausalConnector:setConnectorParams(...)
    if(#arg>0)then
      for i, v in ipairs(arg) do
          self:addConnectorParam(v)
      end
    end
end

function CausalConnector:setSimpleCondition(simpleCondition)
   local p = nil 
   
   if(self.simpleCondition == nil)then
      self.simpleCondition = simpleCondition
      p = self:getLastPosChild("connectorParam")     
      if(p ~= nil)then
         self:addChild(simpleCondition, p+1)
      else
         self:addChild(simpleCondition, 1)
      end 
   else
       p = self:getLastPosChild("simpleCondition")
       self:addChild(simpleCondition, p)
   end
end

function CausalConnector:getSimpleCondition()
   return self.simpleCondition
end

function CausalConnector:setSimpleAction(simpleAction)
   local p = nil 
      
   if(self.simpleAction == nil)then
      self.simpleAction = simpleAction
      
      p = self:getLastPosChild("simpleCondition")     
      
      if(p ~= nil)then
         self:addChild(simpleAction, p+1)
      else
         p = self:getLastPosChild("connectorParam")     
         
         if(p ~= nil)then
            self:addChild(simpleAction, p+1)
         else
            self:addChild(simpleAction, 1)
         end
      end 
   else
       p = self:getLastPosChild("simpleAction")
       self:addChild(simpleAction, p)
   end
end

function CausalConnector:getSimpleAction()
   return self.simpleAction
end

return CausalConnector