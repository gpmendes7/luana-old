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
      ["id"] = "porta",  
      ["component"] = "context1",
      ["interface"] = "pcontext1"
   }
   
   port = Port:create(atts)
   assert(port:getId() == "porta", "Error!")
   assert(port:getComponent() == "context1", "Error!")   
   assert(port:getInterface() == "pcontext1", "Error!")  
end

local function test3()
   local port = nil
      
   port = Port:create()
   
   port:setId("porta")
   port:setComponent("context1")
   port:setInterface("pcontext1")
   
   assert(port:getId() == "porta", "Error!")
   assert(port:getComponent() == "context1", "Error!")   
   assert(port:getInterface() == "pcontext1", "Error!") 
end

test1()
test2()
test3()