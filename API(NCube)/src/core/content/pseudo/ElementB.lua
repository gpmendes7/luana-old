local NCLElem = require "core/NCLElem"
local ElementD = require "core/content/pseudo/ElementD"

local ElementB = NCLElem:extends()

ElementB.name = "elementB"

ElementB.childrenMap = {
 ["elementD"] = {ElementD, "many"}
}

function ElementB:create(attributes, full)   
   local elementB = ElementB:new()   
   
   elementB.attributes = {
     ["id"] = "",  
     ["desc"] = ""
   }
   
   if(attributes ~= nil)then
      elementB:setAttributes(attributes)
   end
     
   elementB.children = {}
   elementB.elementsD = {}
   
   if(full ~= nil)then
      elementB:addElementD(ElementD:create())     
   end
      
   return elementB
end

function ElementB:setId(id)
   self:addAttribute("id", id)
end

function ElementB:getId()
   return self:getAttribute("id")
end

function ElementB:setDesc(desc)
   self:addAttribute("desc", desc)
end

function ElementB:getDesc()
   return self:getAttribute("desc")
end

function ElementB:addElementD(elementD)
    table.insert(self.elementsD, elementD)    
    local p = self:getPosAvailable("elementD")
    if(p ~= nil)then
       self:addChild(elementD, p)
    else
       self:addChild(elementD, 1)
    end
end

function ElementB:getElementDPos(i)
    return self.elementsD[i]
end

function ElementB:getElementDById(id)
   for _, elementD in ipairs(self.elementsD) do
       if(elementD:getId() == id)then
          return elementD
       end
   end
   
   return nil
end

function ElementB:setElementsD(...)
    if(#arg>0)then
      for _, elementD in ipairs(arg) do
          self:addElementD(elementD)
      end
    end
end

function ElementB:removeElementsD(elementD)
   self:removeChild(elementD)
   
   for i, elemD in ipairs(self.elementsD) do
       if(elementD == elemD)then
           table.remove(self.elementsD, i)  
       end
   end    
end

function ElementB:removeElementDPos(i)
   self:removeChildPos(i)
   table.remove(self.elementsD, i)
end

return ElementB