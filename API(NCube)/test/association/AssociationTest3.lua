require("core/NCube")

local function test1()
  local b1 = Bind:create()
  local bd1 = Body:create({id = "bd1"})
  local c1 = Context:create({id = "c1"})
  local s1 = Switch:create({id = "s1"})
  local m1 = Media:create({id = "m1"})
  local nclExp, nclRet
  local status, err
  
  b1:setComponent(bd1)

  nclExp = "<bind component=\"bd1\"/>\n"
  nclRet = b1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(b1.componentAss == bd1, "Error!")
  assert(bd1.ass[1] == b1, "Error!")
  
  b1:setComponent(c1)

  nclExp = "<bind component=\"c1\"/>\n"
  nclRet = b1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(b1.componentAss == c1, "Error!")
  assert(c1.ass[1] == b1, "Error!")
  
  b1:setComponent(s1)

  nclExp = "<bind component=\"s1\"/>\n"
  nclRet = b1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(b1.componentAss == s1, "Error!")
  assert(s1.ass[1] == b1, "Error!")
  
  b1:setComponent(m1)

  nclExp = "<bind component=\"m1\"/>\n"
  nclRet = b1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(b1.componentAss == m1, "Error!")
  assert(m1.ass[1] == b1, "Error!")
 
  status, err = pcall(b1["setComponent"], b1, ValueAssessment:create())
  assert(not(status), "Error!")
  assert(err == "Error! Invalid component element!", "Error!")
end

local function test2()
  local b1 = Bind:create()
  local a1 = Area:create({id = "a1"})
  local pr1 = Property:create({name = "sound"})
  local p2 = Port:create({id = "p2"})
  local sb1 = SwitchPort:create({id = "sb1"})
  local nclExp, nclRet
  local status, err
  
  b1:setInterface(a1)

  nclExp = "<bind interface=\"a1\"/>\n"
  nclRet = b1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(b1.interfaceAss == a1, "Error!")
  assert(a1.ass[1] == b1, "Error!")
  
  b1:setInterface(pr1)

  nclExp = "<bind interface=\"sound\"/>\n"
  nclRet = b1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(b1.interfaceAss == pr1, "Error!")
  assert(pr1.ass[1] == b1, "Error!")
  
  b1:setInterface(p2)

  nclExp = "<bind interface=\"p2\"/>\n"
  nclRet = b1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(b1.interfaceAss == p2, "Error!")
  assert(p2.ass[1] == b1, "Error!")
  
  b1:setInterface(sb1)

  nclExp = "<bind interface=\"sb1\"/>\n"
  nclRet = b1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(b1.interfaceAss == sb1, "Error!")
  assert(sb1.ass[1] == b1, "Error!")
 
  status, err = pcall(b1["setInterface"], b1, CompositeRule:create())
  assert(not(status), "Error!")
  assert(err == "Error! Invalid interface element!", "Error!")
end

local function test3()
  local l1 = Link:create()
  local c1 = CausalConnector:create({id = "c1"})
  local nclExp, nclRet
  local status, err
  
  l1:setXConnector(c1)

  nclExp = "<link xconnector=\"c1\"/>\n"
  nclRet = l1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(l1.causalConnectorAss == c1, "Error!")
  assert(c1.ass[1] == l1, "Error!")  
 
  status, err = pcall(l1["setXConnector"], l1, DescriptorSwitch:create())
  assert(not(status), "Error!")
  assert(err == "Error! Invalid causalConnector element!", "Error!")
end

test1()
test2()
test3()