local Rule = require "core/switches/Rule"

local function test1()
   local rule = nil
   
   rule = Rule:create()
   assert(rule ~= nil, "Error!")
   assert(rule:getId() == "", "Error!")  
   assert(rule:getVar() == "", "Error!")  
   assert(rule:getComparator() == "", "Error!")
   assert(rule:getValue() == "", "Error!")
end

local function test2()
   local rule = nil
   
   local atts = {
    ["id"] = "",  
    ["var"] = "", 
    ["comparator"] = "", 
    ["value"] = ""
   }     
   
   rule = Rule:create(atts)
   assert(rule:getId() == "", "Error!")  
   assert(rule:getVar() == "", "Error!")  
   assert(rule:getComparator() == "", "Error!")
   assert(rule:getValue() == "", "Error!") 
end

local function test3()
   local rule = nil
      
   rule = Rule:create()
   
   rule:setId("r1")  
   rule:setVar("idioma")  
   rule:setComparator("eq")
   rule:setValue("pt")

   assert(rule:getId() == "r1", "Error!")  
   assert(rule:getVar() == "idioma", "Error!")  
   assert(rule:getComparator() == "eq", "Error!")
   assert(rule:getValue() == "pt", "Error!") 
end

test1()
test2()
test3()