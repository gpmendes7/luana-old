local MetaData = require "core/metadata/MetaData"

local function test1()
   local metadata = MetaData:create()
   
   assert(metadata ~= nil, "Error!")
   assert(metadata:getRdfTree() == nil, "Error!")   
end

local function test2()      
   local meta = MetaData:create()
   
   local tree =   " <rdf:RDF>\n"..
                  "  xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"\n"..
                  "  xmlns:dc=\"http://purl.org/dc/elements/1.1/\">\n"..
                  "  <rdf:Description>\n"..
                  "     rdf:about=\"http://www.telemidia.puc-rio.br/ex/ex01\">\n"..
                  "     <dc:title>Meu primeiro exemplo NCL</dc:title>\n"..
                  "     <dc:description>\n"..
                  "      Exemplo\n"..
                  "     </dc:description>\n"..
                  "  </rdf:Description>\n"..
                  " </rdf:RDF>\n"
   
   local nclExp = "<metadata>\n"..tree.."</metadata>\n"
   
   meta:setRdfTree(tree)
   
   local nclRet = meta:table2Ncl(0)
   
   assert(nclExp == nclRet, "Error!")  
end

test1()
test2()