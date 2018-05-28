require("core/NCube")

local doc = Document:create({id="exemplo04",
  xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile"},
"<?xml version= \"1.0\" encoding=\"ISO-8859-1\"?>")

local head = Head:create()

local regionBase = RegionBase:create()

local rgTV = Region:create({id="rgTV", width=100, height=100})
rgTV:addSymbol("width",  "%")
rgTV:addSymbol("height", "%")

local rgVideo1 = Region:create({id="rgVideo1", left=25, top=25, width=50, height=50})
rgVideo1:addSymbol("left", "%")
rgVideo1:addSymbol("top", "%")
rgVideo1:addSymbol("width", "%")
rgVideo1:addSymbol("height", "%")

local rgLegenda = Region:create({id="rgLegenda", left=25, top=75, width=50, height=5})
rgLegenda:addSymbol("left", "%")
rgLegenda:addSymbol("top", "%")
rgLegenda:addSymbol("width", "%")
rgLegenda:addSymbol("height", "%")

rgTV:addRegion(rgVideo1)
rgTV:addRegion(rgLegenda)
regionBase:addRegion(rgTV)

head:addRegionBase(regionBase)

local descriptorBase = DescriptorBase:create()

local dVideo1 = Descriptor:create({id="dVideo1"})
dVideo1:setRegion(rgVideo1)

local dLegenda = Descriptor:create({id="dLegenda"})
dLegenda:setRegion(rgLegenda)
dLegenda:addDescriptorParam(DescriptorParam:create({name="border", value="none"}))

descriptorBase:addDescriptor(dVideo1)
descriptorBase:addDescriptor(dLegenda)

head:setDescriptorBase(descriptorBase)

local connectorBase = ConnectorBase:create()
local fileName = "connectorBase4.conn"
connectorBase:addImportBase(ImportBase:create({alias="connectors", documentURI=fileName}))
head:setConnectorBase(connectorBase)

head:setConnectorBase(connectorBase)

local body = Body:create()

local pInicio = Port:create({id = "pInicio"})

local video1 = Media:create({type = "video/mpeg",
  id = "video1",
  src = "test/createDocument/media/rio.mpg"})
video1:setDescriptor(dVideo1)
pInicio:setComponent(video1)
body:addMedia(video1)

local aVideoLegenda01 = Area:create({id="aVideoLegenda01", begin=5, ["end"]=9})
aVideoLegenda01.symbols["begin"]="s"
aVideoLegenda01.symbols["end"]="s"
video1:addArea(aVideoLegenda01)

local aVideoLegenda02 = Area:create({id="aVideoLegenda02", begin=10, ["end"]=14})
aVideoLegenda02.symbols["begin"]="s"
aVideoLegenda02.symbols["end"]="s"
video1:addArea(aVideoLegenda02)

local aVideoLegenda03 = Area:create({id="aVideoLegenda03", begin=15, ["end"]=19})
aVideoLegenda03.symbols["begin"]="s"
aVideoLegenda03.symbols["end"]="s"
video1:addArea(aVideoLegenda03)

local legenda01 = Media:create({type = "text/html",
  id = "legenda01",
  src = "test/createDocument/media/legenda01.html"})
legenda01:setDescriptor(dLegenda)
body:addMedia(legenda01)

local legenda02 = Media:create({type = "text/html",
  id = "legenda02",
  src = "test/createDocument/media/legenda02.html"})
legenda02:setDescriptor(dLegenda)
body:addMedia(legenda02)

local legenda03 = Media:create({type = "text/html",
  id = "legenda03",
  src = "test/createDocument/media/legenda03.html"})
legenda03:setDescriptor(dLegenda)
body:addMedia(legenda03)

local lLegenda01_start = Link:create({id = "lLegenda01_start", xconnector = "connectors#onBeginStart"})

local bind1 = Bind:create({role = "onBegin"})
bind1:setComponent(video1)
bind1:setInterface(aVideoLegenda01)
lLegenda01_start:addBind(bind1)

local bind2 = Bind:create({role = "start"})
bind2:setComponent(legenda01)
lLegenda01_start:addBind(bind2)

body:addLink(lLegenda01_start)

local lLegenda01_stop = Link:create({id = "lLegenda01_stop", xconnector = "connectors#onEndStop"})

local bind3 = Bind:create({role = "onEnd"})
bind3:setComponent(video1)
bind3:setInterface(aVideoLegenda01)
lLegenda01_stop:addBind(bind3)

local bind4 = Bind:create({role = "stop"})
bind4:setComponent(legenda01)
lLegenda01_stop:addBind(bind4)

body:addLink(lLegenda01_stop)

local lLegenda02_start = Link:create({id = "lLegenda02_start", xconnector = "connectors#onBeginStart"})

local bind5 = Bind:create({role = "onBegin"})
bind5:setComponent(video1)
bind5:setInterface(aVideoLegenda02)
lLegenda02_start:addBind(bind5)

local bind6 = Bind:create({role = "start"})
bind6:setComponent(legenda02)
lLegenda02_start:addBind(bind6)

body:addLink(lLegenda02_start)

local lLegenda02_stop = Link:create({id = "lLegenda02_stop", xconnector = "connectors#onEndStop"})

local bind7 = Bind:create({role = "onEnd"})
bind7:setComponent(video1)
bind7:setInterface(aVideoLegenda02)
lLegenda02_stop:addBind(bind7)

local bind7 = Bind:create({role = "stop"})
bind7:setComponent(legenda02)
lLegenda02_stop:addBind(bind7)

body:addLink(lLegenda02_stop)

local lLegenda03_start = Link:create({id = "lLegenda03_start", xconnector = "connectors#onBeginStart"})

local bind8 = Bind:create({role = "onBegin"})
bind8:setComponent(video1)
bind8:setInterface(aVideoLegenda03)
lLegenda03_start:addBind(bind8)

local bind9 = Bind:create({role = "start"})
bind9:setComponent(legenda03)
lLegenda03_start:addBind(bind9)

body:addLink(lLegenda03_start)

local lLegenda03_stop = Link:create({["id"] = "lLegenda03_stop", ["xconnector"] = "connectors#onEndStop"})

local bind10 = Bind:create({role = "onEnd"})
bind10:setComponent(video1)
bind10:setInterface(aVideoLegenda03)
lLegenda03_stop:addBind(bind10)

local bind11 = Bind:create({role = "stop"})
bind11:setComponent(legenda03)
lLegenda03_stop:addBind(bind11)

body:addLink(lLegenda03_stop)

doc:setHead(head)
doc:setBody(body)

fileName = "test/createDocument/docs/document4.ncl"
doc:saveNcl(fileName)
os.execute("java -jar ncl-validator-1.4.20.jar -nl pt_BR "..fileName)