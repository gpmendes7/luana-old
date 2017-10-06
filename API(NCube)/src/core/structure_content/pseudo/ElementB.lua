local NCLElem = require "core/structure_content/NCLElem"
local ElementD = require "core/structure_content/pseudo/ElementD"

local ElementB = NCLElem:extends()

ElementB.name = "elementB"

ElementB.childsMap = {
 ["elementD"] = {ElementD, "many"}
}

ElementB.attributes = nil
ElementB.elementsD = nil

function ElementB:create(attributes, full)   
   local elementB = ElementB:new()   
   
   elementB.attributes = {
     ["id"] = "",  
     ["desc"] = ""
   }
   
   if(attributes ~= nil)then
      elementB:setAttributes(attributes)
   end
     
   elementB.childs = {}
   elementB.elementsD = {}
   
   if(full ~= nil)then
      elementB:addElementD(ElementD:create())     
   end
      
   return elementB
end

function ElementB:setId(id)
   self.attributes.id = id
end

function ElementB:getId()
   return self.attributes.id
end

function ElementB:setDesc(desc)
   self.attributes.desc = desc
end

function ElementB:getDesc()
   return self.attributes.desc
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

function ElementB:getElementD(i)
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