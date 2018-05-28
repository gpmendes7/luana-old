require("core/NCube")

local doc = Document:create({id="exemplo03",
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

rgTV:addRegion(rgVideo1)
regionBase:addRegion(rgTV)

head:addRegionBase(regionBase)

local descriptorBase = DescriptorBase:create()

local dVideo1 = Descriptor:create({id="dVideo1"})
dVideo1:setRegion(rgVideo1)
dVideo1:addDescriptorParam(DescriptorParam:create({name="soundLevel", value=1}))

descriptorBase:addDescriptor(dVideo1)

head:setDescriptorBase(descriptorBase)

local connectorBase = ConnectorBase:create()
local fileName = "connectorBase3.conn"
connectorBase:addImportBase(ImportBase:create({alias="connectors", documentURI=fileName}))

head:setConnectorBase(connectorBase)

local body = Body:create()

local pInicio = Port:create({id = "pInicio"})

local video1 = Media:create({type = "video/mpeg",
  id = "video1",
  src = "test/createDocument/media/abertura.mpg"})
video1:setDescriptor(dVideo1)  
pInicio:setComponent(video1)
body:addPort(pInicio)
body:addMedia(video1)

local video2 = Media:create({type = "video/mpeg",
  id = "video2",
  src = "test/createDocument/media/passaro.mpg"})
video2:setDescriptor(dVideo1)
body:addMedia(video2)

local lVideo1Video2Start = Link:create({id = "lVideo1Video2Start", xconnector = "connectors#onEndStart"})

local bind1 = Bind:create({role = "onEnd"})
bind1:setComponent(video1)
lVideo1Video2Start:addBind(bind1)

local bind2 = Bind:create({role = "start"})
bind2:setComponent(video2)
lVideo1Video2Start:addBind(bind2)

body:addLink(lVideo1Video2Start)

doc:setHead(head)
doc:setBody(body)

fileName = "test/createDocument/docs/document3.ncl"
doc:saveNcl(fileName)
os.execute("java -jar ncl-validator-1.4.20.jar -nl pt_BR "..fileName)