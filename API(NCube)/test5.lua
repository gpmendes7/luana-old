require("core/NCube")

local doc = Document:create()
doc:setId("document1")
doc:setXmlns("http://www.ncl.org.br/NCL3.0/EDTVProfile")
doc:setXmlHead("<?xml version= \"1.0\" encoding=\"ISO-8859-1\"?>")   
doc:setHead(Head:create())
doc:setBody(Body:create())

doc:writeNcl()