require("core/NCube")

local fileName = "test/createDocument/docs/document1.ncl"
local doc = Document:create()
doc:loadNcl(fileName)

local head = doc:getHead()

local regionBase = head:getRegionBasePos(1)

local rgTitulo1 = Region:create({["id"]="rgTitulo1",
                                 ["left"]="25%",
                                 ["top="]="5%", 
                                 ["width"]="50%",
                                 ["height"]="15%"})

local rgTV = regionBase:getDescendantByAttribute("id", "rgTV")
rgTV:addRegion(rgTitulo1)

local descriptorBase = head:getDescriptorBase()

local dVideo1 = descriptorBase:getDescendantByAttribute("id", "dVideo1")
dVideo1:addDescriptorParam(DescriptorParam:create({["name"]="soundLevel", ["value"]="1"}))

local dTitulo1 = Descriptor:create({["id"]="dTitulo1", ["region"]="rgTitulo1"})
dTitulo1:addDescriptorParam(DescriptorParam:create({["name"]="scroll", ["value"]="none"}))

descriptorBase:addDescriptor(dTitulo1)

local connectorBase = ConnectorBase:create()
fileName = "test/createDocument/docs/connectorBase2.conn"
connectorBase:addImportBase(ImportBase:create({["alias"]="connectors", ["documentURI"]=fileName}))
head:setConnectorBase(connectorBase)

local body = doc:getBody()
body:addMedia(Media:create({["type"] = "text/html", 
                            ["id"] = "titulo1", 
                            ["src"] = "test/createDocument/media/ginga.html", 
                            ["descriptor"] = "dTitulo1"}))
                            
local lVideo1Titulo1Start = Link:create({["id"] = "lVideo1Titulo1Start", ["xconnector"] = "connectors#onBeginStart"})
lVideo1Titulo1Start:addBind(Bind:create({["component"] = "video1", ["role"] = "onBegin"}))
lVideo1Titulo1Start:addBind(Bind:create({["component"] = "titulo1", ["role"] = "start"}))

local lVideo1Titulo1Stop = Link:create({["id"] = "lVideo1Titulo1Stop", ["xconnector"] = "connectors#onEndStop"})
lVideo1Titulo1Stop:addBind(Bind:create({["component"] = "video1", ["role"] = "onEnd"}))
lVideo1Titulo1Stop:addBind(Bind:create({["component"] = "titulo1", ["role"] = "stop"}))

body:setLinks(lVideo1Titulo1Start, lVideo1Titulo1Stop)
         
doc:setBody(body)

fileName = "test/createDocument/docs/document2.ncl"
doc:saveNcl(fileName)
os.execute("java -jar ncl-validator-1.4.20.jar -nl pt_BR "..fileName)