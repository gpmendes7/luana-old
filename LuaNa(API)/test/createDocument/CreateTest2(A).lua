require("LuaNa(API)/src/core/LuaNa")

local doc = Document:create({id="connectorBase2",
  xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile"},
"<?xml version= \"1.0\" encoding=\"ISO-8859-1\"?>")

local head = Head:create()

local connectorBase = ConnectorBase:create()

local onBeginStart = CausalConnector:create({id = "onBeginStart"})
local onBegin = SimpleCondition:create({role = "onBegin"})
local start = SimpleAction:create({role = "start"})
onBeginStart:setSimpleCondition(onBegin)
onBeginStart:setSimpleAction(start)
connectorBase:addCausalConnector(onBeginStart)

local onEndStop = CausalConnector:create({id = "onEndStop"})
local onEnd = SimpleCondition:create({role = "onEnd"})
local stop = SimpleAction:create({role = "stop"})
onEndStop:setSimpleCondition(onEnd)
onEndStop:setSimpleAction(stop)
connectorBase:addCausalConnector(onEndStop)

head:setConnectorBase(connectorBase)

doc:setHead(head)

local fileName = "LuaNa(API)/test/createDocument/docs/connectorBase2.conn"
doc:saveNcl(fileName)
os.execute("java -jar LuaNa(API)/ncl-validator-1.4.20.jar -nl pt_BR "..fileName)