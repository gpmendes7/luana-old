require("LuaNa(API)/src/core/LuaNa")

local doc = Document:create({id="exemplo03ConnBase",
                             xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile"}, 
                             "<?xml version= \"1.0\" encoding=\"ISO-8859-1\"?>")

local head = Head:create()

local connectorBase = ConnectorBase:create()

local onEndStart = CausalConnector:create({id = "onEndStart"})
local onEnd = SimpleCondition:create({role = "onEnd"})
local start = SimpleAction:create({role = "start"})
onEndStart:setSimpleCondition(onEnd)
onEndStart:setSimpleAction(start)
connectorBase:addCausalConnector(onEndStart)

head:setConnectorBase(connectorBase)

doc:setHead(head)

local fileName = "LuaNa(API)/test/createDocument/docs/connectorBase3.conn"
doc:saveNcl(fileName)
os.execute("java -jar LuaNa(API)/ncl-validator-1.4.20.jar -nl pt_BR "..fileName)