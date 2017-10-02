local NCLElem = require "core/structure_content/NCLElem"
local BindParam = require "core/linking/BindParam"

local Bind = NCLElem:extends()

Bind.name = "bind"

Bind.attributes = { 
  role = nil, 
  component = nil, 
  interface = nil, 
  descriptor = nil
}

Bind.childsMap = {
 ["bindParam"] = {BindParam, "many"}
}

Bind.bindParams = nil

function Bind:create(attributes, full)
   local attributes = attributes or {}  
   local bind = Bind:new()
   
   bind:setAttributes(attributes)
   bind:setChilds()    
   bind.bindParams = {}
   
   if(full ~= nil)then
      bind:addBindParam(BindParam:create())     
   end
   
   return bind
end

function Bind:setRole(role)
   self.attributes.role = role
end

function Bind:getRole()
   return self.attributes.role
end

function Bind:setComponent(component)
   self.attributes.component = component
end

function Bind:getComponent()
   return self.attributes.component
end

function Bind:setInterface(interface)
   self.attributes.interface = interface
end

function Bind:getInterface()
   return self.attributes.interface
end

function Bind:setDescriptor(descriptor)
   self.attributes.descriptor = descriptor
end

function Bind:getDescriptor()
   return self.attributes.descriptor
end

function Bind:addBindParam(bindParam)
    table.insert(self.bindParams, bindParam)    
    local p = self:getPosAvailable("bindParam")
    if(p ~= nil)then
       self:addChild(bindParam, p)
    else
       self:addChild(bindParam, 1)
    end
end

function Bind:getBindParam(i)
    return self.bindParams[i]
end

function Bind:setBindParams(...)
    if(#arg>0)then
      for _, bindParam in ipairs(arg) do
          self:addBindParam(bindParam)
      end
    end
end

function Bind:removeBindParam(bindParam)
   self:removeChild(bindParam)
   
   for i, bp in ipairs(self.bindParams) do
       if(bindParam == bp)then
          table.remove(self.bindParams, i)  
       end
   end 
end

function Bind:removeBindParamPos(i)
   self:removeChildPos(i)
   table.remove(self.bindParams, i)
end

return Bind