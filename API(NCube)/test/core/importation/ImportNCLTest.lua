local ImportNCL = require "core/importation/ImportNCL"

local function test1()
   local importNCL = nil
   
   importNCL = ImportNCL:create()
   assert(importNCL ~= nil, "Error!")
   assert(importNCL:getAlias() == "", "Error!")
   assert(importNCL:getDocumentURI() == "", "Error!")     
end

local function test2()
   local importNCL = nil
   
   local atts = { 
    ["alias"] = "doc1",
    ["documentURI"] = "document1.ncl"
   }
   
   importNCL = ImportNCL:create(atts)
   assert(importNCL:getAlias() == "doc1", "Error!")
   assert(importNCL:getDocumentURI() == "document1.ncl", "Error!")   
end

local function test3()
   local importNCL = nil
      
   importNCL = ImportNCL:create()
   
   importNCL:setAlias("doc1")
   importNCL:setDocumentURI("document1.ncl")
   
   assert(importNCL:getAlias() == "doc1", "Error!")
   assert(importNCL:getDocumentURI() == "document1.ncl", "Error!") 
end

test1()
test2()
test3()