require("core/LuaNa")

local fileName = "test/createDocument/docs/document1.ncl"
local doc = Document:create()
doc:loadNcl(fileName)

local head = doc:getHead()

local regionBase = head:getRegionBasePos(1)

local rgTitulo1 = Region:create({id="rgTitulo1", left=25, top=5, width=50, height=15})
rgTitulo1:addSymbol("left", "%")
rgTitulo1:addSymbol("top", "%")
rgTitulo1:addSymbol("width", "%")
rgTitulo1:addSymbol("height", "%")

local rgTV = regionBase:getDescendantByAttribute("id", "rgTV")
rgTV:addRegion(rgTitulo1)

local descriptorBase = head:getDescriptorBase()

local dVideo1 = descriptorBase:getDescendantByAttribute("id", "dVideo1")
dVideo1:addDescriptorParam(DescriptorParam:create({name="soundLevel", value="1"}))

local dTitulo1 = Descriptor:create({id="dTitulo1"})
dTitulo1:setRegion(rgTitulo1)
dTitulo1:addDescriptorParam(DescriptorParam:create({name="scroll", value="none"}))
descriptorBase:addDescriptor(dTitulo1)

local connectorBase = ConnectorBase:create()
fileName = "connectorBase2.conn"
connectorBase:addImportBase(ImportBase:create({alias="connectors", documentURI=fileName}))
head:setConnectorBase(connectorBase)

local body = doc:getBody()

local titulo1 = Media:create({type = "text/html",
  id = "titulo1",
  src = "test/createDocument/media/ginga.html"})
titulo1:setDescriptor(dTitulo1)

body:addMedia(titulo1)

local video1 = body:getDescendantByAttribute("id", "video1")

local lVideo1Titulo1Start = Link:create({id = "lVideo1Titulo1Start",
  xconnector = "connectors#onBeginStart"})
local bind1 = Bind:create({role = "onBegin"})
bind1:setComponent(video1)
lVideo1Titulo1Start:addBind(bind1)

local bind2 = Bind:create({role = "start"})
bind2:setComponent(titulo1)
lVideo1Titulo1Start:addBind(bind2)

local lVideo1Titulo1Stop = Link:create({id = "lVideo1Titulo1Stop",
  xconnector = "connectors#onEndStop"})
local bind3 = Bind:create({role = "onEnd"})
bind3:setComponent(body:getDescendantByAttribute("id", "video1"))
lVideo1Titulo1Stop:addBind(bind3)

local bind4 = Bind:create({role = "stop"})
bind4:setComponent(titulo1)
lVideo1Titulo1Stop:addBind(bind4)

body:setLinks(lVideo1Titulo1Start, lVideo1Titulo1Stop)

fileName = "test/createDocument/docs/document2.ncl"
doc:saveNcl(fileName)
os.execute("java -jar ncl-validator-1.4.20.jar -nl pt_BR "..fileName)