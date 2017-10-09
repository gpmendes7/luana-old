require("core/NCube")

local doc = Document:create({id="doc", xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile"}, "<?xml version= \"1.0\" encoding=\"ISO-8859-1\"?>")

--local rb1 = RegionBase:create({id="rb1", device="rbTV"}, 1)

doc:setHead(Head:create())
doc:setBody(Body:create())

doc:getHead():addRegionBase(RegionBase:create())
doc:getHead():getRegionBasePos(1):addRegion(Region:create())

doc:getHead():setDescriptorBase(DescriptorBase:create())
doc:getHead():getDescriptorBase():addDescriptor(Descriptor:create())

doc:getHead():addConnectorBase(ConnectorBase:create())

local rb1 = doc:getHead():getRegionBasePos(1)

rb1:setAttributes{id="rb1", device="rbTV"}

--local rg1 = Region:create{id="rg1", width="100%", height="100%"}

local rg1 = rb1:getRegionPos(1):setAttributes{id="rg1", width="100%", height="100%"}

--rb1:addRegion(rg1)

local rg2 = Region:create({id="rg2", width="25%", height="25%"}, 1)

rb1:addRegion(rg2)

--local rg3 = Region:create{id="rg3", width="50%", height="50%"}

local rg3 = rg2:getRegionPos(1):setAttributes{id="rg3", width="50%", height="50%"}

--rg2:addRegion(rg3)

local db = doc:getHead():getDescriptorBase()

--local d1 = Descriptor:create{id="d1", region="rg1"}

local d1 = db:getDescriptorPos(1):setAttributes{id="d1", region="rg1"}

local d2 = Descriptor:create{id="d2", region="rg2"}

db:addDescriptor(d1)
db:addDescriptor(d2)

local p1 = Port:create{id="p1", component="m1"}

local m1 = Media:create{id ="m1", src="media/media1.mpg", type="video/mpeg", descriptor="d1"}

doc:getBody():addPort(p1)
doc:getBody():addMedia(m1)

local p2 = Port:create{id="p2", component="m2"}

local m2 = Media:create{id ="m2", src="media/media2.mpg", type="video/mpeg", descriptor="d2"}

doc:getBody():addPort(p2)
doc:getBody():addMedia(m2)

doc:saveNcl("fiesta2.ncl")

local rg2 = doc:getDescendantByAttribute("id", "rg2")
local rg3 = doc:getDescendantByAttribute("id", "rg3")
rg2:removeRegion(rg3)

doc:saveNcl("tech.ncl")