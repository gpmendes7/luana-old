require("core/NCube")

local doc = Document:create({["id"]="exemplo03",
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

rgTV:addRegion(rgVideo1)
regionBase:addRegion(rgTV)

head:addRegionBase(regionBase)

local descriptorBase = DescriptorBase:create()

local dVideo1 = Descriptor:create({["id"]="dVideo1", ["region"]="rgVideo1"})
dVideo1:addDescriptorParam(DescriptorParam:create({["name"]="soundLevel", ["value"]="1"}))

descriptorBase:addDescriptor(dVideo1)

head:setDescriptorBase(descriptorBase)

local connectorBase = ConnectorBase:create()
local fileName = "connectorBase3.conn"
connectorBase:addImportBase(ImportBase:create({["alias"]="connectors", ["documentURI"]=fileName}))
head:setConnectorBase(connectorBase)

head:setConnectorBase(connectorBase)

local body = Body:create()

body:addPort(Port:create({["id"] = "pInicio", 
                          ["component"] = "video1"
                         }))

body:addMedia(Media:create({["type"] = "video/mpeg", 
                            ["id"] = "video1", 
                            ["src"] = "test/createDocument/media/abertura.mpg", 
                            ["descriptor"] = "dVideo1"}))
                            
body:addMedia(Media:create({["type"] = "video/mpeg", 
                            ["id"] = "video2", 
                            ["src"] = "test/createDocument/media/passaro.mpg", 
                            ["descriptor"] = "dVideo1"}))                            
                            
local lVideo1Video2Start = Link:create({["id"] = "lVideo1Video2Start", ["xconnector"] = "connectors#onEndStart"})
lVideo1Video2Start:addBind(Bind:create({["component"] = "video1", ["role"] = "onEnd"}))
lVideo1Video2Start:addBind(Bind:create({["component"] = "video2", ["role"] = "start"}))

body:addLink(lVideo1Video2Start)

doc:setHead(head)
doc:setBody(body)
         
fileName = "test/createDocument/docs/document3.ncl"
doc:saveNcl(fileName)
os.execute("java -jar ncl-validator-1.4.20.jar -nl pt_BR "..fileName)