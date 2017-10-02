local NCLElem = require "core/structure_content/NCLElem"

local function test1()
   local elem1 = NCLElem:create("elem1")
   assert(elem1 ~= "nil", "Error!")
   
   local elem2 = NCLElem:create("elem2")
   assert(elem2:getName() == "elem2", "Error!")
   
   local elem3 = NCLElem:create("elem3")
   assert(elem3:getChilds() ~= "elem3", "Error!")
   
   local elem4 = NCLElem:create("elem4", {id = "e4"})
   assert(elem4:getAttributes() ~= nil, "Error!")
   
   local elem4 = NCLElem:create()
   assert(elem4 == nil, "Error!")
end

local function test2()
   local elem1 = NCLElem:create("elem1", {id = "e1"})   
   local elem2 = NCLElem:create("elem2", {id = "e2"})
   local elem3 = NCLElem:create("elem3", {id = "e3"}) 
    
   elem1:addChild(elem2)   
   elem1:addChild(elem3)
   assert(#elem1:getChilds() == 2, "Error!")
   assert(elem1:getChild(1) == elem2, "Error!")
   assert(elem2:getParent() == elem1, "Error!")
   assert(elem1:getChild(2) == elem3, "Error!")
   assert(elem3:getParent() == elem1, "Error!")
   
   elem1:removeChild(elem2)
   assert(#elem1:getChilds() == 1, "Error!")
   assert(elem2:getParent() == nil, "Error!")
   
   elem1:removeChild(elem3)
   assert(#elem1:getChilds() == 0, "Error!")
   assert(elem3:getParent() == nil, "Error!")
   
   elem1:setChilds(elem2, elem3)
   assert(#elem1:getChilds() == 2, "Error!")
   assert(elem2:getParent() ~= nil, "Error!")
   assert(elem3:getParent() ~= nil, "Error!")
   assert(elem1:getPosChild(elem2) == 1, "Error!")
   assert(elem1:getPosChild(elem3) == 2, "Error!")
   
   local elem4 = NCLElem:create("elem4", {id = "e4"})
   elem2:addChild(elem4)
   local elem5 = NCLElem:create("elem5", {id = "e5"})
   elem3:addChild(elem5) 
   assert(#elem1:getDescendants() == 4, "Error!") 
   assert(elem1:getDescendantByAttribute("id", "e2") ~= nil, "Error!")
   assert(elem1:getDescendantByAttribute("id", "e3") ~= nil, "Error!")
   assert(elem1:getDescendantByAttribute("id", "e4") ~= nil, "Error!")
   assert(elem1:getDescendantByAttribute("id", "e5") ~= nil, "Error!")
   assert(elem1:getDescendantByAttribute("id", "e6") == nil, "Error!")
end

local function test3()
   local elem1 = NCLElem:create("elem1", {id = "e1"})  
   
   elem1:addAttribute("description", "desc1") 
   assert(elem1:getAttribute("description") == "desc1", "Error!")
   
   elem1:addAttribute("", "element 1") 
   assert(elem1:getAttribute("") == nil, "Error!")
   
   elem1:addAttribute("name", "") 
   assert(elem1:getAttribute("name") == nil, "Error!")
   
   elem1:addAttribute(nil, nil) 
   assert(elem1:getAttribute(nil) == nil, "Error!")
   
   elem1:setAttributes{id = "e1", name = "element1", description = "desc1"}
   assert(elem1:getAttribute("id") == "e1", "Error!")
   assert(elem1:getAttribute("name") == "element1", "Error!")
   assert(elem1:getAttribute("description") == "desc1", "Error!")
   
end

test1()
test2()
test3()