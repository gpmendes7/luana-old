local Area = require "core/interface/Area"

local function test1()
   local area = nil
   
   area = Area:create()
   assert(area ~= nil, "Error!")
   assert(area:getId() == "", "Error!")
   assert(area:getCoords() == "", "Error!")
   assert(area:getBegin() == "", "Error!") 
   assert(area:getEnd() == "", "Error!")  
   assert(area:getBeginText() == "", "Error!")     
   assert(area:getEndText() == "", "Error!")
   assert(area:getBeginPosition() == "", "Error!") 
   assert(area:getEndPosition() == "", "Error!") 
   assert(area:getFirst() == "", "Error!")    
   assert(area:getLast() == "", "Error!")
   assert(area:getLabel() == "", "Error!") 
   assert(area:getClip() == "", "Error!")                 
end

local function test2()
   local area = nil
   
   local atts = { 
      ["id"] = "a1", 
      ["coords"] = "4, 5", 
      ["begin"] = "5s", 
      ["end"] = "10s", 
      ["beginText"] = "begin",
      ["endText"] = "end", 
      ["beginPosition"] = "5",
      ["endPosition"] = "10", 
      ["first"] = "100f", 
      ["last"] = "200f", 
      ["label"] = "area1", 
      ["clip"] = "endOffset"
   }
   
   area = Area:create(atts)
   assert(area:getId() == "a1", "Error!")
   assert(area:getCoords() == "4, 5", "Error!")
   assert(area:getBegin() == "5s", "Error!") 
   assert(area:getEnd() == "10s", "Error!")  
   assert(area:getBeginText() == "begin", "Error!")     
   assert(area:getEndText() == "end", "Error!")
   assert(area:getBeginPosition() == "5", "Error!") 
   assert(area:getEndPosition() == "10", "Error!") 
   assert(area:getFirst() == "100f", "Error!")    
   assert(area:getLast() == "200f", "Error!")
   assert(area:getLabel() == "area1", "Error!") 
   assert(area:getClip() == "endOffset", "Error!")  
end

local function test3()
   local area = nil
      
   area = Area:create()
   
   area:setId("a1")
   area:setCoords("4, 5")
   area:setBegin("5s") 
   area:setEnd("10s")  
   area:setBeginText("begin")     
   area:setEndText("end")
   area:setBeginPosition("5") 
   area:setEndPosition("10") 
   area:setFirst("100f")    
   area:setLast("200f")
   area:setLabel("area1") 
   area:setClip("endOffset")
   
   assert(area:getId() == "a1", "Error!")
   assert(area:getCoords() == "4, 5", "Error!")
   assert(area:getBegin() == "5s", "Error!") 
   assert(area:getEnd() == "10s", "Error!")  
   assert(area:getBeginText() == "begin", "Error!")     
   assert(area:getEndText() == "end", "Error!")
   assert(area:getBeginPosition() == "5", "Error!") 
   assert(area:getEndPosition() == "10", "Error!") 
   assert(area:getFirst() == "100f", "Error!")    
   assert(area:getLast() == "200f", "Error!")
   assert(area:getLabel() == "area1", "Error!") 
   assert(area:getClip() == "endOffset", "Error!")  
end

local function test4()
   local area = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
      ["id"] = "a1", 
      ["coords"] = "4, 5", 
      ["begin"] = "5s", 
      ["end"] = "10s", 
      ["beginText"] = "begin",
      ["endText"] = "end", 
      ["beginPosition"] = "5",
      ["endPosition"] = "10", 
      ["first"] = "100f", 
      ["last"] = "200f", 
      ["label"] = "area1", 
      ["clip"] = "endOffset"
   }    
      
   area = Area:create(atts)
   
   nclExp = "<area"   
   for attribute, value in pairs(area:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
   
   nclExp = nclExp.."/>\n"

   nclRet = area:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()