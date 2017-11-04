local ElementA = require "core/content/pseudo/ElementA"
local ElementB = require "core/content/pseudo/ElementB"
local ElementC = require "core/content/pseudo/ElementC"
local ElementD = require "core/content/pseudo/ElementD"
local ElementE = require "core/content/pseudo/ElementE"


local function test1()
    local  elemA = nil
    
    elemA = ElementA:create()   
    
    assert(elemA ~= nil, "Error!")
    assert(elemA:getAttribute("") == nil, "Error!") 
    assert(elemA:getAttribute(nil) == nil, "Error!") 
    assert(elemA:getNumberOfFixedAttributes() == 0, "Error!") 

    elemA = ElementA:create({id = "id1", desc = "desc1"})   
   
    assert(elemA ~= nil, "Error!")
    assert(elemA:getNumberOfFixedAttributes() == 2, "Error!") 
    
    elemA = ElementA:create() 
    elemA:addAttribute("id", "id1") 
    elemA:addAttribute("desc", "desc1") 
    
    assert(elemA:getAttribute("id") == "id1", "Error!")
    assert(elemA:getAttribute("desc") == "desc1", "Error!")
    assert(elemA:getNumberOfFixedAttributes() == 2, "Error!") 
    
    elemA = ElementA:create() 
    elemA:setAttributes({id = "id1", desc = "desc1"}) 
    
    assert(elemA:getAttribute("id") == "id1", "Error!")
    assert(elemA:getAttribute("desc") == "desc1", "Error!")
    
    elemA = ElementA:create({x = "x", y = "y", z = "z"}) 
    
    assert(elemA:getAttribute("x") == nil, "Error!")  
    assert(elemA:getAttribute("y") == nil, "Error!") 
    assert(elemA:getAttribute("z") == nil, "Error!")  
    assert(elemA:getNumberOfFixedAttributes() == 0, "Error!")  
    
    elemA = ElementA:create({id = "id1", desc = "desc1"}) 
    elemA:removeAttribute("id")
    
    assert(elemA:getAttribute("id") == "", "Error!")
    assert(elemA:getNumberOfFixedAttributes() == 1, "Error!") 
end

local function test2()
   local elemA, elemB, elemC = nil
   
   elemA = ElementA:create({id = "id1", desc = "desc1"})   
   elemB = ElementB:create({id = "id2", desc = "desc2"})
   elemC = ElementC:create({id = "id3", desc = "desc3"})      
  
   elemA:addChild(elemB)
   elemA:addChild(elemC) 
   elemB:addChild(elemA)
  
   assert(#elemA:getChildren() == 2, "Error!")
   assert(elemA:getChild(1) == elemB, "Error!")
   assert(elemA:getChild(2) == elemC, "Error!")
   
   elemA = ElementA:create({id = "id1", desc = "desc1"}) 
   elemA:addChild(nil)
  
   assert(#elemA:getChildren() == 0, "Error!")
   
   elemA = ElementA:create({id = "id1", desc = "desc1"})   
   elemB = ElementB:create({id = "id2", desc = "desc2"})
   elemC = ElementC:create({id = "id3", desc = "desc3"})
   elemA:setChildren(elemB, elemC)
   
   assert(#elemA:getChildren() == 2, "Error!")
   
   elemA = ElementA:create(nil, 1)   
   
   assert(#elemA:getChildren() == 3, "Error!")
   assert(elemA:getChild(1):getNameElem() == "elementA", "Error!")
   assert(elemA:getChild(2):getNameElem() == "elementB", "Error!")
   assert(elemA:getChild(3):getNameElem() == "elementC", "Error!")
   
   elemA = ElementA:create({id = "id1", desc = "desc1"})   
   elemB = ElementB:create({id = "id2", desc = "desc2"})
   elemC = ElementC:create({id = "id3", desc = "desc3"})
 
   elemA:addChild(elemB)
   elemA:addChild(elemC) 
   elemA:removeChild(elemB)
   
   assert(#elemA:getChildren() == 1, "Error!")
 
   elemA:removeChild(elemC)
   assert(#elemA:getChildren() == 0, "Error!")
   
   elemA = ElementA:create(nil, 1) 
   elemA:removeChildPos(1)  
   
   assert(#elemA:getChildren() == 2, "Error!")
   
   elemA = ElementA:create(nil, 1) 
   elemA:removeAllChildren()  
   
   assert(#elemA:getChildren() == 0, "Error!")
end

local function test3()
   local elemA, elemB, elemC, elemD, elemE = nil
   
   elemA = ElementA:create({id = "id1", desc = "desc1"})   
   elemB = ElementB:create({id = "id2", desc = "desc2"})
   elemC = ElementC:create({id = "id3", desc = "desc3"}) 
   elemD = ElementD:create({id = "id4", desc = "desc4"})
   elemE = ElementE:create({id = "id5", desc = "desc5"})
   
   elemA:setChildren(elemB, elemC)
   elemB:addChild(elemD)
   elemC:addChild(elemE)
   
   assert(#elemA:getDescendants() == 4, "Error!") 
   assert(elemA:getDescendantByAttribute("id", "id2") ~= nil, "Error!")
   assert(elemA:getDescendantByAttribute("id", "id3") ~= nil, "Error!")
   assert(elemA:getDescendantByAttribute("id", "id4") ~= nil, "Error!")
   assert(elemA:getDescendantByAttribute("id", "id5") ~= nil, "Error!")
end

local function test4()
   local elemA, elemB, elemC, elemD, elemE = nil
   
   elemA = ElementA:create({id = "id1", desc = "desc1"})   
   elemB = ElementB:create({id = "id2", desc = "desc2"})
   elemC = ElementC:create({id = "id3", desc = "desc3"}) 
   elemD = ElementD:create({id = "id4", desc = "desc4"})
   elemE = ElementE:create({id = "id5", desc = "desc5"})
  
   elemA:setChildren(elemB, elemC)
   elemB:addChild(elemD)
   elemC:addChild(elemE)
  
   local nclA = elemA:table2Ncl(0)
   
   local elemG = ElementA:create()
   elemG:setNcl(nclA)
   elemG:ncl2Table()
   local nclG = elemG:table2Ncl(0)
   
   assert(nclA == nclG, "Error!") 
end

test1()
test2()
test3()
test4()