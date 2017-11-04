local ImportBase = require "core/importation/ImportBase"

local function test1()
   local importBase = nil
   
   importBase = ImportBase:create()
   assert(importBase ~= nil, "Error!")
   assert(importBase:getAlias() == "", "Error!")
   assert(importBase:getDocumentURI() == "", "Error!") 
   assert(importBase:getRegion() == "", "Error!")
   assert(importBase:getBaseId() == "", "Error!")      
end

local function test2()
   local importBase = nil
   
   local atts = { 
    ["alias"] = "baseConectores",
    ["documentURI"] = "baseConectores.ncl", 
    ["region"] = "region", 
    ["baseId"] = "bc"
   }
   
   importBase = ImportBase:create(atts)
   assert(importBase:getAlias() == "baseConectores", "Error!")
   assert(importBase:getDocumentURI() == "baseConectores.ncl", "Error!")
   assert(importBase:getRegion() == "region", "Error!")
   assert(importBase:getBaseId() == "bc", "Error!")      
end

local function test3()
   local importBase = nil
      
   importBase = ImportBase:create()
   
   importBase:setAlias("baseConectores")
   importBase:setDocumentURI("baseConectores.ncl")
   importBase:setRegion("region")
   importBase:setBaseId("bc")
   
   assert(importBase:getAlias() == "baseConectores", "Error!")
   assert(importBase:getDocumentURI() == "baseConectores.ncl", "Error!")
   assert(importBase:getRegion() == "region", "Error!")
   assert(importBase:getBaseId() == "bc", "Error!")   
end

test1()
test2()
test3()