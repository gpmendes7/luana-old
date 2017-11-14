require("core/NCube")

local doc = Document:create({["id"] = "doc", ["xmlns"] = "http://www.ncl.org.br/NCL3.0/EDTVProfile"}, "<?xml version= \"1.0\" encoding=\"ISO-8859-1\"?>")

local head = Head:create()

local regionBase = RegionBase:create()
local region = Region:create({["id"] = "rgTV", ["width"] = "100%", ["height"] = "100%"})
region:addRegion(Region:create({["id"] = "rgTitulo1", ["left"] = "25%", 
                 ["top"] = "5%", ["width"] = "50%", ["height"] = "15%"}))
region:addRegion(Region:create({["id"] = "rgVideo1", ["left"] = "25%", 
                 ["top"] = "25%", ["width"] = "50%", ["height"] = "50%"}))
regionBase:addRegion(region)
head:addRegionBase(regionBase)

local descriptorBase = DescriptorBase:create()
local descriptor1 = Descriptor:create({["id"] = "dTitulo1", ["region"] = "rgTitulo1"})
descriptor1:addDescriptorParam(DescriptorParam:create({["name"] = "scroll", ["value"] = "none"}))
local descriptor2 = Descriptor:create({["id"] = "dVideo1", ["region"] = "rgVideo1"})
descriptor1:addDescriptorParam(DescriptorParam:create({["name"] = "soundLevel", ["value"] = "1"}))
descriptorBase:setDescriptors(descriptor1, descriptor2)
head:setDescriptorBase(descriptorBase)

local connectorBase = ConnectorBase:create()

local causalConnector1 = CausalConnector:create({["id"] = "onBeginStart"})
local simpleCondition1 = SimpleCondition:create({["role"] = "onBegin"})
local simpleAction1 = SimpleAction:create({["role"] = "start"})
causalConnector1:setSimpleCondition(simpleCondition1)
causalConnector1:setSimpleAction(simpleAction1)
connectorBase:addCausalConnector(causalConnector1)

local causalConnector2 = CausalConnector:create({["id"] = "onEndStop"})
local simpleCondition2 = SimpleCondition:create({["role"] = "onEnd"})
local simpleAction2 = SimpleAction:create({["role"] = "stop"})
causalConnector2:setSimpleCondition(simpleCondition2)
causalConnector2:setSimpleAction(simpleAction2)
connectorBase:addCausalConnector(causalConnector2)

head:setConnectorBase(connectorBase)

doc:setHead(head)

local body = Body:create()
body:addPort(Port:create({["id"] = "pInicio", ["component"] = "video1"}))
body:addMedia(Media:create({["type"] = "text/html", ["id"] = "titulo1", 
         ["src"] = "test/createDocument/media/ginga.html", ["descriptor"] = "dTitulo1"}))
body:addMedia(Media:create({["type"] = "video/mpeg", ["id"] = "video1", 
         ["src"] = "test/createDocument/media/abertura.mpg", ["descriptor"] = "dVideo1"}))

local link1 = Link:create({["id"] = "lVideo1Titulo1Start", ["xconnector"] = "onBeginStart"})
link1:addBind(Bind:create({["component"] = "video1", ["role"] = "onBegin"}))
link1:addBind(Bind:create({["component"] = "titulo1", ["role"] = "start"}))

local link2 = Link:create({["id"] = "lVideo1Titulo1Stop", ["xconnector"] = "onEndStop"})
link2:addBind(Bind:create({["component"] = "video1", ["role"] = "onEnd"}))
link2:addBind(Bind:create({["component"] = "titulo1", ["role"] = "stop"}))

body:setLinks(link1, link2)
         
doc:setBody(body)

doc:writeNcl()
doc:saveNcl("doc1.ncl")
os.execute("java -jar ncl-validator-1.4.20.jar -nl pt_BR ".."doc1.ncl")