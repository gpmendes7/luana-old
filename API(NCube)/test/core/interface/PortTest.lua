local Port = require "core/interface/Port"

local function test1()
   local port = nil
   
   port = Port:create()
   assert(port ~= nil, "Error!")
   assert(port:getId() == "", "Error!")
   assert(port:getComponent() == "", "Error!")   
   assert(port:getInterface() == "", "Error!")     
end

local function test2()
   local port = nil
   
   local atts = { 
      ["id"] = "port",  
      ["component"] = "context1",
      ["interface"] = "pcontext1"
   }
   
   port = Port:create(atts)
   assert(port:getId() == "port", "Error!")
   assert(port:getComponent() == "context1", "Error!")   
   assert(port:getInterface() == "pcontext1", "Error!")  
end

local function test3()
   local port = nil
      
   port = Port:create()
   
   port:setId("port")
   port:setComponent("context1")
   port:setInterface("pcontext1")
   
   assert(port:getId() == "port", "Error!")
   assert(port:getComponent() == "context1", "Error!")   
   assert(port:getInterface() == "pcontext1", "Error!") 
end

local function test4()
   local port = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
      ["id"] = "port",  
      ["component"] = "context1",
      ["interface"] = "pcontext1"
   }    
      
   port = Port:create(atts)
   
   nclExp = "<port"   
   for attribute, value in pairs(port:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
   
   nclExp = nclExp.."/>\n"

   nclRet = port:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()