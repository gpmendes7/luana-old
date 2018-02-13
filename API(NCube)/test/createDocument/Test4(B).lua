require("core/NCube")

local doc = Document:create({["id"]="exemplo04",
                             ["xmlns"]="http://www.ncl.org.br/NCL3.0/EDTVProfile"}, 
                             "<?xml version= \"1.0\" encoding=\"ISO-8859-1\"?>")

local head = Head:create()

local regionBase = RegionBase:create()

local rgTV = Region:create({["id"]="rgTV",
                            ["width"]="100%",
                            ["height"]="100%"})
                            
local rgVideo1 = Region:create({["id"]="rgVideo1",
                                ["left"]="25%",
                                ["top="]="25%", 
                                ["width"]="50%",
                                ["height"]="50%"})           
                                
local rgLegenda = Region:create({["id"]="rgLegenda",
                                ["left"]="25%",
                                ["top="]="75%", 
                                ["width"]="50%",
                                ["height"]="5%"})                   

rgTV:addRegion(rgVideo1)
rgTV:addRegion(rgLegenda)
regionBase:addRegion(rgTV)

head:addRegionBase(regionBase)

local descriptorBase = DescriptorBase:create()

local dVideo1 = Descriptor:create({["id"]="dVideo1", ["region"]="rgVideo1"})

local dLegenda = Descriptor:create({["id"]="dLegenda", ["region"]="rgLegenda"})
dLegenda:addDescriptorParam(DescriptorParam:create({["name"]="border", ["value"]="none"}))

descriptorBase:addDescriptor(dVideo1)
descriptorBase:addDescriptor(dLegenda)

head:setDescriptorBase(descriptorBase)

local connectorBase = ConnectorBase:create()
local fileName = "connectorBase4.conn"
connectorBase:addImportBase(ImportBase:create({["alias"]="connectors", ["documentURI"]=fileName}))
head:setConnectorBase(connectorBase)

head:setConnectorBase(connectorBase)

local body = Body:create()

body:addPort(Port:create({["id"] = "pInicio", 
                          ["component"] = "video1"
                         }))

local video1 = Media:create({["type"] = "video/mpeg", 
                            ["id"] = "video1", 
                            ["src"] = "test/createDocument/media/rio.mpg", 
                            ["descriptor"] = "dVideo1"})
                           
video1:addArea(Area:create({["id"]="aVideoLegenda01", ["begin"]="5s", ["end"]="9s"}))
video1:addArea(Area:create({["id"]="aVideoLegenda02", ["begin"]="10s", ["end"]="14s"}))            
video1:addArea(Area:create({["id"]="aVideoLegenda03", ["begin"]="15s", ["end"]="19s"}))               

body:addMedia(video1)

local legenda01 = Media:create({["type"] = "text/html", 
                            ["id"] = "legenda01", 
                            ["src"] = "test/createDocument/media/legenda01.html", 
                            ["descriptor"] = "dLegenda"})                                                                                                          
body:addMedia(legenda01)                            

local legenda02 = Media:create({["type"] = "text/html", 
                            ["id"] = "legenda02", 
                            ["src"] = "test/createDocument/media/legenda02.html", 
                            ["descriptor"] = "dLegenda"})
                                                                                                          
body:addMedia(legenda02)    

local legenda03 = Media:create({["type"] = "text/html", 
                            ["id"] = "legenda03", 
                            ["src"] = "test/createDocument/media/legenda03.html", 
                            ["descriptor"] = "dLegenda"})
                                                                                                          
body:addMedia(legenda03)               
                            
local lLegenda01_start = Link:create({["id"] = "lLegenda01_start", ["xconnector"] = "connectors#onBeginStart"})
lLegenda01_start:addBind(Bind:create({["component"] = "video1", ["interface"] = "aVideoLegenda01", ["role"] = "onBegin"}))
lLegenda01_start:addBind(Bind:create({["component"] = "legenda01", ["role"] = "start"}))

body:addLink(lLegenda01_start)

local lLegenda01_stop = Link:create({["id"] = "lLegenda01_stop", ["xconnector"] = "connectors#onEndStop"})
lLegenda01_stop:addBind(Bind:create({["component"] = "video1", ["interface"] = "aVideoLegenda01", ["role"] = "onEnd"}))
lLegenda01_stop:addBind(Bind:create({["component"] = "legenda01", ["role"] = "stop"}))

body:addLink(lLegenda01_stop)

local lLegenda02_start = Link:create({["id"] = "lLegenda02_start", ["xconnector"] = "connectors#onBeginStart"})
lLegenda02_start:addBind(Bind:create({["component"] = "video1", ["interface"] = "aVideoLegenda02", ["role"] = "onBegin"}))
lLegenda02_start:addBind(Bind:create({["component"] = "legenda02", ["role"] = "start"}))

body:addLink(lLegenda02_start)

local lLegenda02_stop = Link:create({["id"] = "lLegenda02_stop", ["xconnector"] = "connectors#onEndStop"})
lLegenda02_stop:addBind(Bind:create({["component"] = "video1", ["interface"] = "aVideoLegenda02", ["role"] = "onEnd"}))
lLegenda02_stop:addBind(Bind:create({["component"] = "legenda02", ["role"] = "stop"}))

body:addLink(lLegenda02_stop)

local lLegenda03_start = Link:create({["id"] = "lLegenda03_start", ["xconnector"] = "connectors#onBeginStart"})
lLegenda03_start:addBind(Bind:create({["component"] = "video1", ["interface"] = "aVideoLegenda03", ["role"] = "onBegin"}))
lLegenda03_start:addBind(Bind:create({["component"] = "legenda03", ["role"] = "start"}))

body:addLink(lLegenda03_start)

local lLegenda03_stop = Link:create({["id"] = "lLegenda03_stop", ["xconnector"] = "connectors#onEndStop"})
lLegenda03_stop:addBind(Bind:create({["component"] = "video1", ["interface"] = "aVideoLegenda03", ["role"] = "onEnd"}))
lLegenda03_stop:addBind(Bind:create({["component"] = "legenda03", ["role"] = "stop"}))

body:addLink(lLegenda03_stop)

doc:setHead(head)
doc:setBody(body)
         
fileName = "test/createDocument/docs/document4.ncl"
doc:saveNcl(fileName)
os.execute("java -jar ncl-validator-1.4.20.jar -nl pt_BR "..fileName)