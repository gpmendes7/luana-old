local NCLElem = require "core/structure_content/NCLElem"
local BindParam = require "core/linking/BindParam"

local Bind = NCLElem:extends()

Bind.name = "bind"

Bind.childrenMap = {
 ["bindParam"] = {BindParam, "many"}
}

function Bind:create(attributes, full)
   local bind = Bind:new()
   
   bind.attributes = { 
      ["role"] = "", 
      ["component"] = "", 
      ["interface"] = "", 
      ["descriptor"] = ""
   }
   
   if(attributes ~= nil)then
      bind:setAttributes(attributes)
   end
           
   bind.children = {}
   bind.bindParams = {}
   
   if(full ~= nil)then
      bind:addBindParam(BindParam:create())     
   end
   
   return bind
end

function Bind:setRole(role)
   self:addAttribute("role", role)
end

function Bind:getRole()
   return self:getAttribute("role")
end

function Bind:setComponent(component)
   self:addAttribute("component", component)
end

function Bind:getComponent()
   return self:getAttribute("component")
end

function Bind:setInterface(interface)
   self:addAttribute("interface", interface)
end

function Bind:getInterface()
   return self:getAttribute("interface")
end

function Bind:setDescriptor(descriptor)
   self:addAttribute("descriptor", descriptor)
end

function Bind:getDescriptor()
   return self:getAttribute("descriptor")
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

function Bind:getBindParamPos(i)
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