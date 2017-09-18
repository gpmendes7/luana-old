local NCLElem = require "core/NCLElem"

local CausalConnector = Class:createClass(NCLElem)

CausalConnector.name = "causalConnector"

CausalConnector.attributes = {
  id = nil
}

CausalConnector.childsMap = {
 
}

function CausalConnector:create(attributes)  
   local attributes = attributes or {}  
   local causalConnector = CausalConnector:new() 
     
   causalConnector:setAttributes(attributes)
   causalConnector:setChilds()
   
   return causalConnector
end

return CausalConnector