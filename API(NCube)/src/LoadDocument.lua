require("core/NCube")

local doc = Document:create()
doc:loadNcl("doc4.ncl")
doc:writeNcl()

local media = doc:getDescendantByAttribute("id", "contagem") 

print(media:getArea(5):writeNcl())