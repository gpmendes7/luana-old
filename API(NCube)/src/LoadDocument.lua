require("core/NCube")

local doc = Document:create()
doc:loadNcl("doc4.ncl")
doc:writeNcl()

local sp = SwitchPort:create({id = "sp1"}, 1)
sp:writeNcl()