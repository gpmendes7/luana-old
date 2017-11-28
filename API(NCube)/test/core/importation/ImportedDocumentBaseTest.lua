local ImportedDocumentBase = require "core/importation/ImportedDocumentBase"
local ImportNCL = require "core/importation/ImportNCL"

local function test1()
   local importedDocumentBase = nil
   
   importedDocumentBase = ImportedDocumentBase:create()
   assert(importedDocumentBase ~= nil, "Error!")
   assert(importedDocumentBase:getId() == "", "Error!")  
end

local function test2()
   local importedDocumentBase = nil
   
   local atts = {
      ["id"] = "importedDocumentBase1",
   }     
   
   importedDocumentBase = ImportedDocumentBase:create(atts)
   assert(importedDocumentBase:getId() == "importedDocumentBase1", "Error!")
end

local function test3()
   local importedDocumentBase = nil
      
   importedDocumentBase = ImportedDocumentBase:create()
   
   importedDocumentBase:setId("importedDocumentBase1")
   assert(importedDocumentBase:getId() == "importedDocumentBase1", "Error!")
end

local function test4()
   local importedDocumentBase = nil
      
   importedDocumentBase = ImportedDocumentBase:create(nil, 1)
   assert(importedDocumentBase:getImportNCLPos(1) ~= nil, "Error!")
   
   importedDocumentBase:addImportNCL(ImportNCL:create())
   assert(importedDocumentBase:getImportNCLPos(2) ~= nil, "Error!")
   
   importedDocumentBase:addImportNCL(ImportNCL:create{["alias"] = "doc1"})
   assert(importedDocumentBase:getDescendantByAttribute("alias","doc1") ~= nil, "Error!")
end

local function test5()
   local importedDocumentBase1 = nil
      
   importedDocumentBase1 = ImportedDocumentBase:create{["id"] = "importedDocumentBase1"}
    
   local importNCL1 = ImportNCL:create{["alias"] = "doc1", ["documentURI"] = "document1.ncl"}
   local importNCL2 = ImportNCL:create{["alias"] = "doc2", ["documentURI"] = "document2.ncl"}
   local importNCL3 = ImportNCL:create{["alias"] = "doc3", ["documentURI"] = "document3.ncl"}
   
   importedDocumentBase1:setImportNCLs(importNCL1, importNCL2, importNCL3)
   assert(importedDocumentBase1:getDescendantByAttribute("alias","doc1") ~= nil, "Error!")
   assert(importedDocumentBase1:getDescendantByAttribute("alias","doc2") ~= nil, "Error!")
   assert(importedDocumentBase1:getDescendantByAttribute("alias","doc3") ~= nil, "Error!")
   
   importedDocumentBase1:removeImportNCL(importNCL1)
   assert(importedDocumentBase1:getDescendantByAttribute("alias","doc1") == nil, "Error!")
   
   importedDocumentBase1:removeImportNCLPos(1)
   assert(importedDocumentBase1:getDescendantByAttribute("alias","doc2") == nil, "Error!")
end

local function test6()
   local importedDocumentBase = nil
   local importNCL1, importNCL2, importNCL3 = nil
   
   local nclExp, nclRet = nil
   
   importedDocumentBase = ImportedDocumentBase:create{["id"] = "importedDocumentBase"}
   nclExp = "<importedDocumentBase id=\"importedDocumentBase\">\n" 
      
   importNCL1 = ImportNCL:create{["alias"] = "doc1"}
   nclExp = nclExp.." <importNCL alias=\"doc1\"/>\n"  
      
   importNCL2 = ImportNCL:create{["alias"] = "doc2"}
   nclExp = nclExp.." <importNCL alias=\"doc2\"/>\n"
   
   importNCL3 = ImportNCL:create{["alias"] = "doc3"}
   nclExp = nclExp.." <importNCL alias=\"doc3\"/>\n"
   
   nclExp = nclExp.."</importedDocumentBase>\n"
   
   importedDocumentBase:setImportNCLs(importNCL1, importNCL2, importNCL3)   
          
   nclRet = importedDocumentBase:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()