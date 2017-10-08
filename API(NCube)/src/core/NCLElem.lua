local Class = require "oo/Class"
require "valid/Validator"

local NCLElem = Class:createClass{
  name = nil, 
  parent = nil,
  children = nil,
  childrenMap = nil,
  assMap = nil,
  attributes = nil, 
  ncl = nil,
  hasAss = nil
}

function NCLElem:create(name, attributes)
   local attributes = attributes    
   local nclElem = NCLElem:new()         
   
   if(isInvalidString(name))then
      print("Invalid name!")
      return nil
   end
   
   nclElem.name = name    
   nclElem:setChildren()
   
   if(attributes ~= nil)then
      nclElem:setAttributes(attributes)
   end
 
   return nclElem
end

function NCLElem:extends()
    return Class:createClass(NCLElem)
end

function NCLElem:getNameElem()
    return self.name
end

function NCLElem:setParent(parent)
    self.parent = parent
end

function NCLElem:getParent()
    return self.parent
end

function NCLElem:addChild(child, p)
    if(child == nil)then
       return
    end
    
    local valid = false
    
    for chd, _ in pairs(self.childrenMap) do
       if(chd == child.name)then
          valid = true
       end
    end
    
    if(not(valid))then
       return
    end
    
    if(p ~= nil)then
       table.insert(self.children, p, child)
    else
       table.insert(self.children, child)
    end
    
    child:setParent(self)
end

function NCLElem:removeChild(child)
    local p = self:getPosChild(child)   
    self:removeChildPos(p)
end

function NCLElem:removeChildPos(i)
    self:getChild(i):setParent(nil) 
    table.remove(self.children, i) 
end

function NCLElem:removeAllChildren()
    self.children = {}
end

function NCLElem:getChild(i)
    return self.children[i]
end

function NCLElem:setChildren(...)
    if(#arg>0)then
      for _, child in ipairs(arg) do
          self:addChild(child)
      end
    end
end

function NCLElem:getChildren()
    return self.children
end

function NCLElem:getPosChild(child)
    for i, chd in ipairs(self.children) do
       if(chd == child)then
          return i
       end 
    end  
end

function NCLElem:getLastPosChild(child)
   local p = nil
   
   for i, chd in ipairs(self.children) do
      if(child == chd.name)then
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

function NCLElem:getChildrenMap()
    return self.childrenMap
end

function NCLElem:getAssMap()
    return self.assMap
end

function NCLElem:getDescendants()
  local descendants = {}

  local children = self.children
  
  if(children ~= nil)then
     local nchildren = #children
      
     local descs = nil
      
     for i=1,nchildren do
         local child = self.children[i]         
         table.insert(descendants, child)  
                                      
         descs = child:getDescendants()
         for _, desc in ipairs(descs) do
             table.insert(descendants, desc)
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
       return
    end
    
    if(isEmptyOrNil(value))then
       return
    end
    
    local valid = false
    
    for att, _ in pairs(self.attributes)do
       if(att == attribute)then
          valid = true
       end
    end
    
    if(not(valid))then
       return
    end
   
    self.attributes[attribute] = value
end

function NCLElem:removeAttribute(attribute)
    if(isInvalidString(attribute))then
       return
    end
    
    if(self.attributes[attribute] == nil)then
       return
    end
    
    local valid = false
    
    for att, _ in pairs(self.attributes)do
       if(att == attribute)then
          valid = true
       end
    end
    
    if(not(valid))then
       return
    end
    
    self.attributes[attribute] = ""
end

function NCLElem:getAttribute(attribute)
    if(isInvalidString(attribute))then
       return nil
    end
        
    local valid = false
    
    for att, _ in pairs(self.attributes)do
       if(att == attribute)then
          valid = true
       end
    end
    
    if(not(valid))then
       return
    end
    
    return self.attributes[attribute]
end

function NCLElem:setAttributes(attributes)    
    for attribute, value in pairs(attributes) do
       self:addAttribute(attribute, value)
    end
end

function NCLElem:getAttributes()  
    return self.attributes
end

function NCLElem:getNumberOfFixedAttributes()
    local c = 0
    
    for attribute, value in pairs(self.attributes) do
       if(not(isInvalidString(value)))then
          c = c + 1
       end
    end
    
    return c
end


function NCLElem:readAttributes()
   local s, e, t, u, w = nil

   _, s = string.find(self.ncl, "<"..self.name.." ")
   _, t = string.find(self.ncl, "<"..self.name..">")
   e = string.find(self.ncl, ">")

   if(s ~= nil and t == nil and e ~= nil)then
     local attributes = string.sub(self.ncl,s,e-1)   
     
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

function NCLElem:readChildrenNcl()
   local s, t, u = nil
      
   s = string.find(self.ncl,">")
   t = string.sub(self.ncl, 1, s)
   u = string.find(t,"/>")
   
   local childrenNcl = nil
        
   if(u == nil)then
      local _, n = string.gsub(self.ncl, "</"..self.name..">", "*")
      
      local e, v, w = nil
      
      if(n > 1)then
         childrenNcl = self.ncl
         w, v = 0

         repeat
           e, v = string.find(self.ncl, "</"..self.name..">", v)
           w = w + 1
         until w == n
      else
         e, v = string.find(self.ncl, "</"..self.name..">")
      end
     
      childrenNcl = string.sub(self.ncl, s+1, e-1)
   end
   
   return childrenNcl
end

function NCLElem:readChildNcl(childrenNcl, childName)
   local s, t, u, v, h = nil
  
   s = string.find(childrenNcl,">")
   t = string.sub(childrenNcl, 1, s)
   u = string.find(t,"/>")
           
   local childNcl = nil
           
   if(u == nil)then
      _, v = string.find(childrenNcl, "</"..childName..">")
      childNcl = string.sub(childrenNcl,1,v)
      
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
            _, v = string.find(childrenNcl, "</"..childName..">", v)
            childNcl = string.sub(childrenNcl,1,v)           
            
            local _, n2 = string.gsub(childNcl, "</"..childName..">", "*")            
            h = v
            
            if(n1 == n2)then
               break
            end
      end            
   else
      childNcl = string.sub(childrenNcl,1,s)
      h = s
   end
   
   return childNcl, h
end

function NCLElem:ncl2Table()   
   self:readAttributes()
       
   local childrenNcl = self:readChildrenNcl()

   if(childrenNcl ~= nil)then
      local s, e = nil
      
      repeat     
        s, e = string.find(childrenNcl, "<%a+")      
      
        if(s ~= nil and e ~= nil)then
           local childName = string.sub(childrenNcl, s+1, e)

           local childNcl, h = self:readChildNcl(childrenNcl, childName)
           
           if(childNcl ~= nil)then                   
              if(self.childrenMap ~= nil)then
                 local map = self.childrenMap[childName]
              
                 if(map ~= nil)then
                    local childClass = map[1]
                                
                    local childObject = childClass:create()            
                             
                    childObject:setNcl(childNcl)
                    childObject:ncl2Table()  
                    self:addChild(childObject)
                                          
                    local cardinality = map[2]
                                       
                    if(cardinality == "many")then    
                       if(self[childName..'s'] == nil)then
                          self[childName..'s'] = {}
                       end
                                              
                       table.insert(self[childName.."s"], childObject)                
                    elseif(cardinality == "one")then                       
                            self[childName] = childObject                
                    end
                 end
               end  
           end 
            
           if(h ~= nil)then
             childrenNcl = string.sub(childrenNcl, h+1, string.len(childrenNcl))      
           end  
        end            

     until (string.find(childrenNcl, "%a") == nil)
  end
end

function NCLElem:table2Ncl(deep)
  local ncl = ""
  
  if(deep == 0 and self.name == "ncl")then
     ncl = self:getXmlHead().."\n"
  else
    for i=1,deep do
       ncl = ncl.." "
    end 
  end 
        
  ncl = ncl.."<"..self.name
    
  local attrs = self.attributes
  if(attrs ~= nil)then
    for k, v in pairs(attrs) do
         if(not(isInvalidString(v)))then
            ncl = ncl.." "..k.."=".."\""..v.."\""
         end
    end
  end 
 
  local children = self.children
  
  if(children ~= nil)then  
     local nchildren = #children
     
     if(nchildren == 0)then
        return ncl.."/>\n"
     end
    
     if(children ~= nil)then
        ncl = ncl..">\n"  
        for i=1,nchildren do
            local child = self.children[i]                     
            ncl = ncl..child:table2Ncl(deep+1)         
        end
             
        for i=1,deep do
            ncl = ncl.." "
        end 
     end
  else
      return ncl.."/>\n"
  end
  
  return ncl.."</"..self.name..">\n"
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