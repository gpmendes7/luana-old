require("core/LuaNa")

local doc = Document:create({id="exemplo06ConnBase",
  xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile"},
"<?xml version= \"1.0\" encoding=\"ISO-8859-1\"?>")

local head = Head:create()

local connectorBase = ConnectorBase:create()

local onBeginStart = CausalConnector:create({id = "onBeginStart"})
local onBegin = SimpleCondition:create({role = "onBegin"})
local start = SimpleAction:create({role = "start", max="unbounded", qualifier="par"})
onBeginStart:setSimpleCondition(onBegin)
onBeginStart:setSimpleAction(start)
connectorBase:addCausalConnector(onBeginStart)

local onEndStart = CausalConnector:create({id = "onEndStart"})
local onEnd = SimpleCondition:create({role = "onEnd"})
onEndStart:setSimpleCondition(onEnd)
onEndStart:setSimpleAction(start)
connectorBase:addCausalConnector(onEndStart)

local onKeySelectionStartStopAbort =
  CausalConnector:create({id = "onKeySelectionStartStopAbort"})
local keyCode = ConnectorParam:create({name = "keyCode"})
local onSelection = SimpleCondition:create({role="onSelection", key="$keyCode"})
local seq = CompoundAction:create({operator="seq"})
seq:addSimpleAction(SimpleAction:create({role = "start"}))
seq:addSimpleAction(SimpleAction:create({role = "stop"}))
seq:addSimpleAction(SimpleAction:create({role = "abort"}))
onKeySelectionStartStopAbort:addConnectorParam(keyCode)
onKeySelectionStartStopAbort:setSimpleCondition(onSelection)
onKeySelectionStartStopAbort:setCompoundAction(seq)
connectorBase:addCausalConnector(onKeySelectionStartStopAbort)

head:setConnectorBase(connectorBase)

doc:setHead(head)

local fileName = "test/createDocument/docs/connectorBase6.conn"
doc:saveNcl(fileName)
os.execute("java -jar ncl-validator-1.4.20.jar -nl pt_BR "..fileName)