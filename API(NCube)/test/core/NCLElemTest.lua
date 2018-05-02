local ElementA = require "core/content/pseudo/ElementA"
local ElementB = require "core/content/pseudo/ElementB"
local ElementC = require "core/content/pseudo/ElementC"
local ElementD = require "core/content/pseudo/ElementD"
local ElementE = require "core/content/pseudo/ElementE"


local function test1()
    local elemA
    
    local status, err
    
    elemA = ElementA:create()      
    assert(elemA ~= nil, "Error!")

    status, err = pcall(elemA["getAttribute"], elemA, "")
    assert(not(status), "Error!")
    assert(err == "Error! Empty or nil attribute is not a valid attribute to elementA element!", "Error!")

    status, err = pcall(elemA["getAttribute"], elemA, nil)
    assert(not(status), "Error!")
    assert(err == "Error! Empty or nil attribute is not a valid attribute to elementA element!", "Error!")

    status, err = pcall(elemA["getAttribute"], elemA, "xxxx")
    assert(not(status), "Error!")
    assert(err == "Error! xxxx attribute is not a valid attribute to elementA element!", "Error!")
    
    status, err = pcall(elemA["create"], elemA, {id = nil, desc = nil})
    assert(not(status), "Error!")
    
    elemA = ElementA:create({id = "id1", desc = "desc1"})      
    assert(elemA:getAttribute("id") == "id1", "Error!")
    assert(elemA:getAttribute("desc") == "desc1", "Error!")
    
    elemA = ElementA:create() 
    elemA:addAttribute("id", "id1") 
    elemA:addAttribute("desc", "desc1")     
    assert(elemA:getAttribute("id") == "id1", "Error!")
    assert(elemA:getAttribute("desc") == "desc1", "Error!")
    
    status, err = pcall(elemA["addAttribute"], elemA, 4, "id1")
    assert(not(status), "Error!")
    assert(err == "Error! 4 attribute is not a valid attribute to elementA element!", "Error!")              
     
    status, err = pcall(elemA["addAttribute"], elemA, "xxxx", "id1")
    assert(not(status), "Error!")
    assert(err == "Error! xxxx attribute is not a valid attribute to elementA element!", "Error!")
      
    status, err = pcall(elemA["addAttribute"], elemA, "id", 4)
    assert(not(status), "Error!")
    assert(err == "Error! Type of id attribute is not valid to elementA element!", "Error!")
    
    status, err = pcall(elemA["addAttribute"], elemA, "id", {})
    assert(not(status), "Error!")
    assert(err == "Error! Type of id attribute is not valid to elementA element!", "Error!")
    
    status, err = pcall(elemA["addAttribute"], elemA, "id", function(a, b) return a+b end)
    assert(not(status), "Error!")
    assert(err == "Error! Type of id attribute is not valid to elementA element!", "Error!")
                        
    elemA = ElementA:create() 
    elemA:setAttributes({id = "id1", desc = "desc1"})    
    assert(elemA:getAttribute("id") == "id1", "Error!")
    assert(elemA:getAttribute("desc") == "desc1", "Error!")
    
    status, err = pcall(elemA["getAttribute"], elemA, "xxxx")
    assert(not(status), "Error!")
    assert(err == "Error! xxxx attribute is not a valid attribute to elementA element!", "Error!")
       
    elemA = ElementA:create({id = "id1", desc = "desc1"}) 
    elemA:removeAttribute("id")  
    assert(elemA:getAttribute("id") == nil, "Error!")
    
    status, err = pcall(elemA["removeAttribute"], elemA, "xxxx")
    assert(not(status), "Error!")
    assert(err == "Error! xxxx attribute is not a valid attribute to elementA element!", "Error!")
    
    status, err = pcall(elemA["removeAttribute"], elemA, nil)
    assert(not(status), "Error!")
    assert(err == "Error! Empty or nil attribute is not a valid attribute to elementA element!", "Error!")
    
    status, err = pcall(elemA["removeAttribute"], elemA, "")
    assert(not(status), "Error!")
    assert(err == "Error! Empty or nil attribute is not a valid attribute to elementA element!", "Error!")
end

local function test2()
   local elemA, elemB, elemC
   
   local status, err
   
   elemA = ElementA:create({id = "id1", desc = "desc1"}) 
  
   assert(#elemA:getChildren() == 0, "Error!")
   
   elemA = ElementA:create({id = "id1", desc = "desc1"})   
   elemB = ElementB:create({id = "id2", desc = "desc2"})
   elemC = ElementC:create({id = "id3", desc = "desc3"})      
  
   elemA:addChild(elemB)
   elemA:addChild(elemC) 
  
   assert(#elemA:getChildren() == 2, "Error!")
   assert(elemA:getChild(1) == elemB, "Error!")
   assert(elemA:getChild(2) == elemC, "Error!")
   
   status, err = pcall(elemA["getChild"], elemA, 3)
   assert(not(status), "Error!")
   assert(err == "Error! elementA element doesn't have a child in position 3!", "Error!")
      
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
   
   status, err = pcall(elemA["removeChild"], elemA, nil)
   assert(not(status), "Error!")
   assert(err == "Error! Attempt to remove failed! You are trying to remove a nil child in elementA!", "Error!")
   
   status, err = pcall(elemA["removeChild"], elemA, elemC)
   assert(not(status), "Error!")
   assert(err == "Error! Attempt to remove failed! elementA element doesn't have this child!", "Error!")
   
   elemA = ElementA:create(nil, 1) 
   elemA:removeChildPos(1)  
   
   assert(#elemA:getChildren() == 2, "Error!")

   status, err = pcall(elemA["removeChildPos"], elemA, 10)
   assert(not(status), "Error!")
   assert(err == "Error! Attempt to remove failed! elementA element doesn't have a child in position 10!", "Error!")
      
   elemA = ElementA:create(nil, 1) 
   elemA:removeAllChildren()  
   
   assert(#elemA:getChildren() == 0, "Error!")
   
   elemA = ElementA:create({id = "id1", desc = "desc1"})   
   elemB = ElementB:create({id = "id2", desc = "desc2"})
      
   status, err = pcall(elemA["addChild"], elemA, nil)
   assert(not(status), "Error!")
   assert(err == "Error! Attempt to set a nil child to elementA!", "Error!")
   
   status, err = pcall(elemB["addChild"], elemB, elemA)
   assert(not(status), "Error!")
   assert(err == "Error! Attempt to set a invalid child! elementA cannot be child of elementB!", "Error!")
end

local function test3()
   local elemA, elemB, elemC, elemD, elemE
   
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
   local elemA, elemB, elemC, elemD, elemE
   
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