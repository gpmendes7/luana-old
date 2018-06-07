require("core/LuaNa")

local doc = Document:create({id="exemplo06",
  xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile"},
"<?xml version= \"1.0\" encoding=\"ISO-8859-1\"?>")

local head = Head:create()

local rb = RegionBase:create()

local rgTV = Region:create({id="rgTV", width=100, height=100})
rgTV:addSymbol("width", "%")
rgTV:addSymbol("height", "%")

local rgVideo1 = Region:create({id="rgVideo1", top=25, left=25,
  width=50, height=50, zIndex=0})
rgVideo1:addSymbol("top", "%")
rgVideo1:addSymbol("left", "%")
rgVideo1:addSymbol("width", "%")
rgVideo1:addSymbol("height", "%")

local rgBotaoVerde = Region:create({id="rgBotaoVerde", left=28, bottom=28,
  width=87, height=70, zIndex=1})
rgBotaoVerde:addSymbol("top", "%")
rgBotaoVerde:addSymbol("left", "%")

rgTV:setRegions(rgVideo1, rgBotaoVerde)

rb:addRegion(rgTV)

local db = DescriptorBase:create()

local dVideo1 = Descriptor:create({id="dVideo1"})
dVideo1:setRegion(rgVideo1)

local dBotaoVerde = Descriptor:create({id="dBotaoVerde"})
dBotaoVerde:setRegion(rgBotaoVerde)

db:setDescriptors(dVideo1, dBotaoVerde)

local cb = ConnectorBase:create()

local ib = ImportBase:create({alias="connectors", documentURI="connectorBase6.conn"})

cb:addImportBase(ib)

head:addRegionBase(rb)
head:setDescriptorBase(db)
head:setConnectorBase(cb)

doc:setHead(head)

local body = Body:create()

local pInicio = Port:create({id="pInicio"})

local video1 = Media:create({type="video/mpeg", id="video1", 
                             src="test/createDocument/media/abertura.mpg"})
video1:setDescriptor(dVideo1)

local video2 = Media:create({type="video/mpeg", id="video2", 
                            src="test/createDocument/media/reciclagem.mpg"})
video2:setDescriptor(dVideo1)

local botaoVerde = Media:create({type="image/png", id="botaoVerde",
                                 src="test/createDocument/media/botao_reciclagem.png"})
botaoVerde:setDescriptor(dBotaoVerde)

pInicio:setComponent(video1)

body:addPort(pInicio)

body:setMedias(video1, video2, botaoVerde)

local lVideo1Init = Link:create({id="lVideo1Init",
  xconnector="connectors#onBeginStart"})

local b1 = Bind:create({role="onBegin"})
b1:setComponent(video1)

local b2 = Bind:create({role="start"})
b2:setComponent(botaoVerde)

lVideo1Init:setBinds(b1, b2)

local lVideo1Loop = Link:create({id="lVideo1Loop",
  xconnector="connectors#onEndStart"})

local b3 = Bind:create({role="onEnd"})
b3:setComponent(video1)

local b4 = Bind:create({role="start"})
b4:setComponent(video1)

lVideo1Loop:setBinds(b3, b4)

local lSelectBotaoVerde = Link:create({id="lSelectBotaoVerde",
  xconnector="connectors#onKeySelectionStartStopAbort"})
local b5 = Bind:create({role="onSelection"})
b5:setComponent(botaoVerde)
b5:addBindParam(BindParam:create({name="keyCode", value="GREEN"}))

local b6 = Bind:create({role="stop"})
b6:setComponent(botaoVerde)

local b7 = Bind:create({role="abort"})
b7:setComponent(video1)

local b8 = Bind:create({role="start"})
b8:setComponent(video2)

lSelectBotaoVerde:setBinds(b5, b6, b7, b8)

body:setLinks(lVideo1Init, lVideo1Loop, lSelectBotaoVerde)

doc:setBody(body)

local fileName = "test/createDocument/docs/document6.conn"
doc:saveNcl(fileName)
os.execute("java -jar ncl-validator-1.4.20.jar -nl pt_BR "..fileName)