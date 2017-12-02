local Meta = require "core/metadata/Meta"

local function test1()
   local meta = nil
   
   meta = Meta:create()
   assert(meta ~= nil, "Error!")
   assert(meta:getName() == "", "Error!")  
   assert(meta:getContent() == "", "Error!")  
end

local function test2()
   local meta = nil
   
   local atts = {
    ["name"] = "",
    ["content"] = ""
   }     
   
   meta = Meta:create(atts)
   assert(meta ~= nil, "Error!")
   assert(meta:getName() == "", "Error!")  
   assert(meta:getContent() == "", "Error!")
end

local function test3()
   local meta = nil
      
   meta = Meta:create()
   
   meta:setName("meta1")
   meta:setContent("content1")  

   assert(meta ~= nil, "Error!")
   assert(meta:getName() == "meta1", "Error!")  
   assert(meta:getContent() == "content1", "Error!")
end

local function test4()
   local meta = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
    ["name"] = "meta1",
    ["content"] = "content1"
   }    
      
   meta = Meta:create(atts)
   
   nclExp = "<meta"   
   for attribute, value in pairs(meta:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
  
   nclExp = nclExp.."/>\n"

   nclRet = meta:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end


test1()
test2()
test3()
test4()
