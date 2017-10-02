local Class = require "oo/Class"
require "valid/Validator"

local NCLElem = Class:createClass{
  name = nil, 
  parent = nil,
  childs = nil,
  childsMap = nil,
  assMap = nil,
  attributes = nil, 
  ncl = nil,
  hasAss = nil
}

function NCLElem:create(name, attributes)
   local attributes = attributes or {}    
   local nclElem = NCLElem:new()         
   
   if(isInvalidString(name))then
      print("Invalid name!")
      return nil
   end
   
   nclElem.name = name    
   nclElem:setChilds()
   nclElem:setAttributes(attributes)
 
   return nclElem
end

function NCLElem:extends()
    return Class:createClass(NCLElem)
end

function NCLElem:setName(name)
    self.name = name
end

function NCLElem:getName()
    return self.name
end

function NCLElem:setParent(parent)
    self.parent = parent
end

function NCLElem:getParent()
    return self.parent
end

function NCLElem:addChild(child, p)
    if(p ~= nil)then
       table.insert(self.childs, p, child)
    else
       table.insert(self.childs, child)
    end
    
    child:setParent(self)
end

function NCLElem:removeChild(child)
    local p = self:getPosChild(child)   
    self:removeChildPos(p)
end

function NCLElem:removeChildPos(i)
    self:getChild(i):setParent(nil) 
    table.remove(self.childs, i) 
end

function NCLElem:removeAllChilds()
    self.childs = {}
end

function NCLElem:getChild(i)
    return self.childs[i]
end

function NCLElem:setChilds(...)
    self.childs = {}
    if(#arg>0)then
      for _, child in ipairs(arg) do
          self:addChild(child)
      end
    end
end

function NCLElem:getChilds()
    return self.childs
end

function NCLElem:getPosChild(child)
    for i, chd in ipairs(self.childs) do
       if(chd == child)then
          return i
       end 
    end  
end

function NCLElem:getLastPosChild(child)
   local p = nil
   
   for i, chd in ipairs(self.childs) do
      if(child == chd:getName())then
         p = i
      end
   end
      
   return p
end

function NCLElem:getPosAvailable(...)      
   for _, elem in ipairs(arg) do
      local p = self:getLastPosChild(elem) 
      if(p ~= nil)then
         return p + 1
      end
   end
end

function NCLElem:getChildsMap()
    return self.childsMap
end

function NCLElem:getAssMap()
    return self.assMap
end

function NCLElem:getDescendants()
  local descendants = {}

  local childs = self:getChilds()
  
  if(childs ~= nil)then
     local nchilds = #childs
      
     local descs = nil
      
     if(childs ~= nil)then
        for i=1,nchilds do
            local child = self:getChild(i)         
            table.insert(descendants, child)  
                                      
            descs = child:getDescendants()
            for _, desc in ipairs(descs) do
                table.insert(descendants, desc)
            end       
        end
     end
   end
     
   return descendants
end

function NCLElem:getDescendantByAttribute(attribute, value) 
   local descs = self:getDescendants()
   
   for _, desc in ipairs(descs) do
      if(desc.attributes ~= nil and desc:getAttribute(attribute) == value)then
        return desc
      end
   end
   
   return nil
end

function NCLElem:addAttribute(attribute, value)
    if(isInvalidString(attribute))then
       print("Invalid attribute!")
       return nil
    end
    
    if(isInvalidString(value))then
       print("Invalid value!")
       return nil
    end
   
    self.attributes[attribute] = value
end

function NCLElem:removeAttribute(attribute)
    if(isInvalidString(attribute))then
       print("Invalid attribute!")
       return nil
    end
    
    if(self.attributes[attribute] == nil)then
       print("There is not an attribute "..attribute.."!")
       return nil
    end
    
    self.attributes[attribute] = nil
end

function NCLElem:getAttribute(attribute)
     if(isInvalidString(attribute))then
       print("Invalid attribute!")
       return nil
    end
    
    if(self.attributes[attribute] == nil)then
       print("There is not an attribute called "..attribute.." in the element "..self:getName().."!")
       return nil
    end
    
    return self.attributes[attribute]
end

function NCLElem:setAttributes(attributes)
    self.attributes = {}    
    local attributes = attributes or {}
    
    for attribute, value in pairs(attributes) do
       self:addAttribute(attribute, value)
    end
end

function NCLElem:getAttributes()  
    return self.attributes
end

function NCLElem:getNumberOfAttributes()
    local c = 0
    
    for attribute, value in pairs(self.attributes) do
       c = c + 1
    end
    
    return c
end


function NCLElem:readAttributes()
   local s, e, t, u, w = nil
       
   _, s = string.find(self:getNcl(), "<"..self:getName().." ")
   _, t = string.find(self:getNcl(), "<"..self:getName()..">")
   e = string.find(self:getNcl(), ">")

   if(s ~= nil and t == nil and e ~= nil)then
     local attributes = string.sub(self:getNcl(),s,e-1)   
     
     for w in string.gmatch(attributes, "%S+") do
       t = string.find(w, "=")
       
       if(t ~= nil)then
          local attribute = string.sub(w, 1, t-1)
         
          local valuewithQuotes = string.sub(w,t+2,string.len(w))
          u = string.find(valuewithQuotes, "\"")          
          local value = string.sub(valuewithQuotes, 1, u-1)  
          
          self:addAttribute(attribute, value)
       end
     end
   end
end

function NCLElem:readChildsNcl()
   local s, t, u = nil
      
   s = string.find(self:getNcl(),">")
   t = string.sub(self:getNcl(), 1, s)
   u = string.find(t,"/>")
   
   local childsNcl = nil
        
   if(u == nil)then
      local _, n = string.gsub(self:getNcl(), "</"..self:getName()..">", "*")
      
      local e, v, w = nil
      
      if(n > 1)then
         childsNcl = self:getNcl()
         w, v = 0

         repeat
           e, v = string.find(self:getNcl(), "</"..self:getName()..">", v)
           w = w + 1
         until w == n
      else
         e, v = string.find(self:getNcl(), "</"..self:getName()..">")
      end
     
      childsNcl = string.sub(self:getNcl(), s+1, e-1)
   end
   
   return childsNcl
end

function NCLElem:readChildNcl(childsNcl, childName)
   local s, t, u, v, h = nil
  
   s = string.find(childsNcl,">")
   t = string.sub(childsNcl, 1, s)
   u = string.find(t,"/>")
           
   local childNcl = nil
           
   if(u == nil)then
      _, v = string.find(childsNcl, "</"..childName..">")
      childNcl = string.sub(childsNcl,1,v)
      
      local n1 = 0 
      local aux1 = childNcl
              
      while(1)do
            t = string.find(aux1, "<"..childName)
            u = string.find(aux1, ">")
            
            if(t ~= nil and u ~= nil)then
               local aux2 = string.sub(aux1,t,u)
               
               if(string.find(aux2,"/>") == nil)then
                   n1 = n1 + 1
               end
               
               aux1 = string.sub(aux1,u+1,string.len(aux1))
            else
                break
            end
      end
      
      v = 0                
      while(1)do
            _, v = string.find(childsNcl, "</"..childName..">", v)
            childNcl = string.sub(childsNcl,1,v)           
            
            local _, n2 = string.gsub(childNcl, "</"..childName..">", "*")            
            h = v
            
            if(n1 == n2)then
               break
            end
      end            
   else
      childNcl = string.sub(childsNcl,1,s)
      h = s
   end
   
   return childNcl, h
end

function NCLElem:buildChild(childName, childNcl)
    local childClass = self:getChildsMap()[childName][1]
                          
    local childObject = childClass:create()            
             
    childObject:setNcl(childNcl)
    childObject:ncl2Table()  
    self:addChild(childObject)
                          
    local cardinality = self:getChildsMap()[childName][2]
                       
    if(cardinality == "many")then    
       if(self[childName..'s'] == nil)then
          self[childName..'s'] = {}
       end
                              
       table.insert(self[childName.."s"], childObject)                
    elseif(cardinality == "one")then                       
            self[childName] = childObject                
    end
                         
end

function NCLElem:ncl2Table()   
   self:readAttributes()
       
   local childsNcl = self:readChildsNcl()
  
   if(childsNcl ~= nil)then
      local s, e = nil
      
      repeat     
        s, e = string.find(childsNcl, "<%a+")      
      
        if(s ~= nil and e ~= nil)then
           local childName = string.sub(childsNcl, s+1, e)

           local childNcl, h = self:readChildNcl(childsNcl, childName)
           
           if(childNcl ~= nil)then     
              self:buildChild(childName, childNcl)   
           end 
            
           if(h ~= nil)then
             childsNcl = string.sub(childsNcl, h+1, string.len(childsNcl))      
           end  
        end            
 
     until (string.find(childsNcl, "%a") == nil)
  end
end

function NCLElem:table2Ncl(deep)
  local ncl = ""
  
  if(deep == 0 and self:getName() == "ncl")then
     ncl = self:getXmlHead().."\n"
  else
    for i=1,deep do
       ncl = ncl.." "
    end 
  end 
        
  ncl = ncl.."<"..self:getName()
    
  local attrs = self:getAttributes()
  if(attrs ~= nil)then
    for k, v in pairs(attrs) do
         if(v ~= nil)then
            ncl = ncl.." "..k.."=".."\""..v.."\""
         end
    end
  end 
 
  local childs = self:getChilds()
  
  if(childs ~= nil)then  
     local nchilds = #childs
    
     if(nchilds == 0)then
        return ncl.."/>\n"
     end
    
     if(childs ~= nil)then
        ncl = ncl..">\n"  
        for i=1,nchilds do
            local child = self:getChild(i)                     
            ncl = ncl..child:table2Ncl(deep+1)         
        end
             
        for i=1,deep do
            ncl = ncl.." "
        end 
     end
  end
  
  return ncl.."</"..self:getName()..">\n"
end

function NCLElem:setNcl(ncl)
   self.ncl = ncl
end

function NCLElem:getNcl()
   return self.ncl
end

function NCLElem:writeNcl()
  print(self:table2Ncl(0))
end

return NCLElem