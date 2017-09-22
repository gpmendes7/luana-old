local Class = require "oo/Class"

local NCLElem = Class:createClass{
  name = nil, 
  childs = nil,
  childsAux = nil,
  childsMap = nil,
  assMap = nil,
  attributes = nil, 
  ncl = nil,
  seq = nil,
  hasAss = nil
}

function NCLElem:extends()
    return Class:createClass(NCLElem)
end

function NCLElem:setName(name)
    self.name = name
end

function NCLElem:getName()
    return self.name
end

function NCLElem:addChild(child, p)
    if(p ~= nil)then
       table.insert(self.childs, p, child)
    else
       table.insert(self.childs, child)
    end
end

function NCLElem:removeChild(child)
    local p = self:getPosChild(child)   
    table.remove(self.childs, p)  
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
      for i, v in ipairs(arg) do
          self.childs[i] =  v
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

function NCLElem:getPosEmpty(...)      
   for _, elem in ipairs(arg) do
      local p = self:getLastPosChild(elem) 
      if(p ~= nil)then
         return p + 1
      end
   end
end

function NCLElem:setChildsAux(...)
    self.childsAux = {}
    if(#arg>0)then
      for i, v in ipairs(arg) do
          self.childsAux[i] =  v
      end
    end
end

function NCLElem:getChildsAux()
    return self.childsAux
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
    if(attribute ~= "" and value ~= "")then
       self.attributes[attribute] = value
    end
end

function NCLElem:getAttribute(attribute)
    return self.attributes[attribute]
end

function NCLElem:setAttributes(attributes)
    self.attributes = {}
    local attributes = attributes or {}
    for i, v in pairs(attributes) do
       self:addAttribute(i, v)
    end
end

function NCLElem:getAttributes()
    return self.attributes
end

function NCLElem:ncl2Table()   
   local s, e, t, u, v = nil
   local elemNcl = self:getNcl()    
      
   _, s = string.find(elemNcl, "<"..self:getName().." ")
   _, t = string.find(elemNcl, "<"..self:getName()..">")
   e = string.find(elemNcl, ">")

   if(s ~= nil and t == nil and e ~= nil)then
     local attributes = string.sub(elemNcl,s,e-1)   
     local w = nil
     
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
   
   s = string.find(elemNcl,">")
   t = string.sub(elemNcl, 1, s)
   u = string.find(t,"/>")
     
   local childsNcl = nil
   
   if(u == nil)then
     local _, n = string.gsub(elemNcl, "</"..self:getName()..">", "*")
     if(n > 1)then
        childsNcl = elemNcl
        local p = 0
        v = 0
       repeat
         e, v = string.find(elemNcl, "</"..self:getName()..">", v)
         p = p + 1
       until p == n
     else
        e, v = string.find(elemNcl, "</"..self:getName()..">")
     end
    childsNcl = string.sub(elemNcl, s+1, e-1)
   end
   
   if(childsNcl  ~= nil)then
     repeat     
       s, e = string.find(childsNcl, "<%a+")      
       local childName = nil
       
       if(s ~= nil and e ~= nil)then
           childName = string.sub(childsNcl, s+1, e)
           
           s = string.find(childsNcl,">")
           t = string.sub(childsNcl, 1, s)
           u = string.find(t,"/>")
           local childNcl = nil
           local h = nil
           if(u == nil)then
              v = 0
              _, v = string.find(childsNcl, "</"..childName..">", v)
              childNcl = string.sub(childsNcl,1,v)
              local n1 = 0 
              local aux1 = childNcl
              
              while(1)do
               local t = string.find(aux1, "<"..childName)
               local u = string.find(aux1, ">")
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
           if(childNcl ~= nil)then       
             local childClass = self:getChildsMap()[childName][1]
                          
             local childObject = childClass:create()            
             
             childObject:setNcl(childNcl)
             childObject:ncl2Table()  
             self:addChild(childObject)
                          
             local cardinality = self:getChildsMap()[childName][2]
                         
             local p = self:getChildsMap()[childName][3]
                       
             if(cardinality == "many")then    
                if(self[childName..'s'] == nil)then
                     self[childName..'s'] = {}
                end
                              
                table.insert(self[childName.."s"], childObject)                
             else if(cardinality == "one")then                       
                     self[childName] = childObject                
             end
                         
           end 
            
           if(h ~= nil)then
             childsNcl = string.sub(childsNcl,h+1,string.len(childsNcl))      
             end  
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