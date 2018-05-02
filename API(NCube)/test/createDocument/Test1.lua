require("core/NCube")

local doc = Document:create({id = "document1", 
                             xmlns = "http://www.ncl.org.br/NCL3.0/EDTVProfile"},
                            "<?xml version= \"1.0\" encoding=\"ISO-8859-1\"?>")

local head = Head:create()

local regionBase = RegionBase:create()

local rgTV = Region:create({id="rgTV", width=100, height=100})
rgTV.symbols["width"]="%"
rgTV.symbols["height"]="%"


local rgVideo1 = Region:create({id="rgVideo1", left=25, top=25, width=50, height=50})
rgVideo1.symbols["left"]="%"
rgVideo1.symbols["top"]="%"
rgVideo1.symbols["width"]="%"
rgVideo1.symbols["height"]="%"

rgTV:addRegion(rgVideo1)
regionBase:addRegion(rgTV)
head:addRegionBase(regionBase)

local descriptorBase = DescriptorBase:create()

local dVideo1 = Descriptor:create({id="dVideo1"})
dVideo1:setRegion(rgVideo1)
descriptorBase:addDescriptor(dVideo1)
head:setDescriptorBase(descriptorBase)

doc:setHead(head)

local body = Body:create()

local pInicio = Port:create({id="pInicio"})

body:addPort(pInicio)

local video1 = Media:create({type="video/mpeg", id="video1", src="test/createDocument/media/abertura.mpg"})
video1:setDescriptor(dVideo1)

body:addMedia(video1)

pInicio:setComponent(video1)

doc:setBody(body)

local fileName = "test/createDocument/docs/document1.ncl"
doc:saveNcl(fileName)
os.execute("java -jar ncl-validator-1.4.20.jar -nl pt_BR "..fileName)