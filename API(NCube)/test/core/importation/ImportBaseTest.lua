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
    ["alias"] = "connBase",
    ["documentURI"] = "connBase.ncl", 
    ["region"] = "region", 
    ["baseId"] = "bc"
   }
   
   importBase = ImportBase:create(atts)
   assert(importBase:getAlias() == "connBase", "Error!")
   assert(importBase:getDocumentURI() == "connBase.ncl", "Error!")
   assert(importBase:getRegion() == "region", "Error!")
   assert(importBase:getBaseId() == "bc", "Error!")      
end

local function test3()
   local importBase = nil
      
   importBase = ImportBase:create()
   
   importBase:setAlias("connBase")
   importBase:setDocumentURI("connBase.ncl")
   importBase:setRegion("region")
   importBase:setBaseId("bc")
   
   assert(importBase:getAlias() == "connBase", "Error!")
   assert(importBase:getDocumentURI() == "connBase.ncl", "Error!")
   assert(importBase:getRegion() == "region", "Error!")
   assert(importBase:getBaseId() == "bc", "Error!")   
end

local function test4()
   local importBase = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
    ["alias"] = "connBase",
    ["documentURI"] = "connBase.ncl", 
    ["region"] = "region", 
    ["baseId"] = "bc"
   }    
      
   importBase = ImportBase:create(atts)
   
   nclExp = "<importBase"   
   for attribute, value in pairs(importBase:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
   
   nclExp = nclExp.."/>\n"

   nclRet = importBase:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()