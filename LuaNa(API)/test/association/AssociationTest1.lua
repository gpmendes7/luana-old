require("core/LuaNa")

local function test1()
  local c1 = Context:create()
  local c2 = Context:create({id = "c2"})
  local b1 = Body:create({id = "b1"})
  local nclExp, nclRet
  local status, err
  
  c1:setRefer(c2)

  nclExp = "<context refer=\"c2\"/>\n"
  nclRet = c1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(c1.referAss == c2, "Error!")
  assert(c2.ass[1] == c1, "Error!")
  
  c1:setRefer(b1)

  nclExp = "<context refer=\"b1\"/>\n"
  nclRet = c1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(c1.referAss == b1, "Error!")
  assert(b1.ass[1] == c1, "Error!")
   
  status, err = pcall(c1["setRefer"], c1, Switch:create())
  assert(not(status), "Error!")
  assert(err == "Error! Invalid refer element!", "Error!")
end

local function test2()
  local s1 = Switch:create()
  local s2 = Switch:create({id = "s2"})
  local nclExp, nclRet
  local status, err
  
  s1:setRefer(s2)

  nclExp = "<switch refer=\"s2\"/>\n"
  nclRet = s1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(s1.referAss == s2, "Error!")
  assert(s2.ass[1] == s1, "Error!")

  status, err = pcall(s1["setRefer"], s1, Context:create())
  assert(not(status), "Error!")
  assert(err == "Error! Invalid refer element!", "Error!")
end

local function test3()
  local m1 = Media:create()
  local m2 = Media:create({id = "m2"})
  local nclExp, nclRet
  local status, err
  
  m1:setRefer(m2)

  nclExp = "<media refer=\"m2\"/>\n"
  nclRet = m1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(m1.referAss == m2, "Error!")
  assert(m2.ass[1] == m1, "Error!")

  status, err = pcall(m1["setRefer"], m1, Port:create())
  assert(not(status), "Error!")
  assert(err == "Error! Invalid refer element!", "Error!")
end

local function test4()
  local i1 = ImportBase:create()
  local r1 = Region:create({id = "r1"})
  local nclExp, nclRet
  local status, err
  
  i1:setRegion(r1)

  nclExp = "<importBase region=\"r1\"/>\n"
  nclRet = i1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(i1.regionAss == r1, "Error!")
  assert(r1.ass[1] == i1, "Error!")

  status, err = pcall(i1["setRegion"], i1, ConnectorParam:create())
  assert(not(status), "Error!")
  assert(err == "Error! Invalid region element!", "Error!")
end

local function test5()
  local i1 = ImportBase:create()
  local r1 = RegionBase:create({id = "r1"})
  local nclExp, nclRet
  local status, err
  
  i1:setBaseId(r1)

  nclExp = "<importBase baseId=\"r1\"/>\n"
  nclRet = i1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(i1.baseIdAss == r1, "Error!")
  assert(r1.ass[1] == i1, "Error!")
 
  status, err = pcall(i1["setBaseId"], i1, SimpleAction:create())
  assert(not(status), "Error!")
  assert(err == "Error! Invalid baseId element!", "Error!")
end

local function test6()
  local p1 = Port:create()
  local c1 = Context:create({id = "c1"})
  local s1 = Switch:create({id = "s1"})
  local m1 = Media:create({id = "m1"})
  local nclExp, nclRet
  local status, err
  
  p1:setComponent(c1)

  nclExp = "<port component=\"c1\"/>\n"
  nclRet = p1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(p1.componentAss == c1, "Error!")
  assert(c1.ass[1] == p1, "Error!")
  
  p1:setComponent(s1)

  nclExp = "<port component=\"s1\"/>\n"
  nclRet = p1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(p1.componentAss == s1, "Error!")
  assert(s1.ass[1] == p1, "Error!")
  
  p1:setComponent(m1)

  nclExp = "<port component=\"m1\"/>\n"
  nclRet = p1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(p1.componentAss == m1, "Error!")
  assert(m1.ass[1] == p1, "Error!")
 
  status, err = pcall(p1["setComponent"], p1, Descriptor:create())
  assert(not(status), "Error!")
  assert(err == "Error! Invalid component element!", "Error!")
end

local function test7()
  local p1 = Port:create()
  local a1 = Area:create({id = "a1"})
  local pr1 = Property:create({name = "sound"})
  local p2 = Port:create({id = "p2"})
  local sp1 = SwitchPort:create({id = "sp1"})
  local nclExp, nclRet
  local status, err
  
  p1:setInterface(a1)

  nclExp = "<port interface=\"a1\"/>\n"
  nclRet = p1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(p1.interfaceAss == a1, "Error!")
  assert(a1.ass[1] == p1, "Error!")
  
  p1:setInterface(pr1)

  nclExp = "<port interface=\"sound\"/>\n"
  nclRet = p1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(p1.interfaceAss == pr1, "Error!")
  assert(pr1.ass[1] == p1, "Error!")
  
  p1:setInterface(p2)

  nclExp = "<port interface=\"p2\"/>\n"
  nclRet = p1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(p1.interfaceAss == p2, "Error!")
  assert(p2.ass[1] == p1, "Error!")
  
  p1:setInterface(sp1)

  nclExp = "<port interface=\"sp1\"/>\n"
  nclRet = p1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(p1.interfaceAss == sp1, "Error!")
  assert(sp1.ass[1] == p1, "Error!")
 
  status, err = pcall(p1["setInterface"], p1, BindRule:create())
  assert(not(status), "Error!")
  assert(err == "Error! Invalid interface element!", "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()
test7()