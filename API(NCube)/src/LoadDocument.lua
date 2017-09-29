require("core/NCube")

local doc = Document:create()
doc:loadNcl("doc.ncl")

--doc:writeNcl()

local head = doc:getHead()
--head:writeNcl()
head:getDescriptorBase(1):getDescriptor(1):setAttributes{id="d7", region="rg7"}
--head:setDescriptorBase(DescriptorBase:create({id = "db"}, 1))
--head:setDescriptorBase(DescriptorBase:create({id = "db2"}, 1))
--head:removeRegionBasePos(1)
--head:setDescriptorBase(DescriptorBase:create({id = "db2"}, 1))
head:addRegionBase(RegionBase:create())
head:getRegionBase(1):getRegion(1):setAttributes{id="rg7", width="100%", height="100%"}


head:addConnectorBase(ConnectorBase:create())
local cb = head:getConnectorBase(1)
cb:setId("cb1")
cb:addCausalConnector(CausalConnector:create())
cb:getCausalConnector(1):setId("cc1")
cb:getCausalConnector(1):setSimpleCondition(SimpleCondition:create{role = "onBegin"})
cb:getCausalConnector(1):setSimpleAction(SimpleAction:create{role = "start"})
--head:writeNcl()

--head:getDescendantByAttribute("id", "cb1"):writeNcl()

--print(doc:getHead():writeNcl())

--local descs = doc:getDescendants()
--print(#descs)

--local d1 = doc:getDescendantByAttribute("id", "d1")
--print(d1:writeNcl())
--print(d1:getRegionAss():writeNcl())

--local rg3 = Region:create({id="rg3", width="100%", height="100%"})5
--doc:getHead():getRegionBase(1):addRegion(rg3)
--
--local d3 = Descriptor:create{id="d3", region="rg3"}
--
--doc:getHead():getDescriptorBase():addDescriptor(d3)
--
--doc:saveNcl("doc2.ncl")

doc:writeNcl()
