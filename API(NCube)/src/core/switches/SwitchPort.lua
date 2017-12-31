local NCLElem = require "core/NCLElem"
local Mapping = require "core/switches/Mapping"

local SwitchPort = NCLElem:extends()

SwitchPort.name = "switchPort"

SwitchPort.childrenMap = {
 ["mapping"] = {Mapping, "many"}
}

function SwitchPort:create(attributes, full) 
   local switchPort = SwitchPort:new()
   
   switchPort.attributes = { 
      ["id"] = ""
   }
   
   if(attributes ~= nil)then
      switchPort:setAttributes(attributes)
   end
   
   switchPort.children = {}    
   switchPort.mappings = {}
   
   if(full ~= nil)then
      switchPort:addMapping(Mapping:create())     
   end
   
   return switchPort
end

function SwitchPort:setId(id)
   self:addAttribute("id", id)
end

function SwitchPort:getId()
   return self:getAttribute("id")
end

function SwitchPort:addMapping(mapping)
    table.insert(self.mappings, mapping)    
    self:addChild(mapping)
end

function SwitchPort:getMappingPos(i)
    return self.mappings[i]
end

function SwitchPort:getMappingById(id)
   for _, mapping in ipairs(self.mappings) do
       if(mapping:getId() == id)then
          return mapping
       end
   end
   
   return nil
end

function SwitchPort:setMappings(...)
    if(#arg>0)then
      for _, mapping in ipairs(arg) do
          self:addMapping(mapping)
      end
    end
end

function SwitchPort:removeMapping(mapping)
   self:removeChild(mapping)
   
   for i, dc in ipairs(self.mappings) do
       if(mapping == dc)then
           table.remove(self.mappings, i)  
       end
   end    
end

function SwitchPort:removeMappingPos(i)
   self:removeChildPos(i)
   table.remove(self.mappings, i)
end

return SwitchPort