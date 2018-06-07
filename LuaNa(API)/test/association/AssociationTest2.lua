require("core/LuaNa")

local function test1()
  local d1 = Descriptor:create()
  local r1 = Region:create({id = "r1"})
  local nclExp, nclRet
  local status, err
  
  d1:setRegion(r1)

  nclExp = "<descriptor region=\"r1\"/>\n"
  nclRet = d1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(d1.regionAss == r1, "Error!")
  assert(r1.ass[1] == d1, "Error!")

  status, err = pcall(d1["setRegion"], d1, Mapping:create())
  assert(not(status), "Error!")
  assert(err == "Error! Invalid region element!", "Error!")
end

local function test2()
  local d1 = Descriptor:create()
  local t1 = Transition:create({id = "t1"})
  local t2 = Transition:create({id = "t2"})
  local t3 = Transition:create({id = "t3"})
  local t4 = Transition:create({id = "t4"})
  local nclExp, nclRet
  local status, err
  
  d1:setTransIn(t1)

  nclExp = "<descriptor transIn=\"t1\"/>\n"
  nclRet = d1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(d1.transInAss[1] == t1, "Error!")
  assert(t1.ass[1] == d1, "Error!")
  
  d1 = Descriptor:create()
  
  d1:setTransIn(t2, t3, t4)

  nclExp = "<descriptor transIn=\"t2, t3, t4\"/>\n"
  nclRet = d1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(d1.transInAss[1] == t2, "Error!")
  assert(d1.transInAss[2] == t3, "Error!")
  assert(d1.transInAss[3] == t4, "Error!")
  assert(t2.ass[1] == d1, "Error!")
  assert(t3.ass[1] == d1, "Error!")
  assert(t4.ass[1] == d1, "Error!")
  
  status, err = pcall(d1["setTransIn"], d1, SwitchPort:create())
  assert(not(status), "Error!")
  assert(err == "Error! Invalid transIn element!", "Error!")
end

local function test3()
  local d1 = Descriptor:create()
  local t1 = Transition:create({id = "t1"})
  local t2 = Transition:create({id = "t2"})
  local t3 = Transition:create({id = "t3"})
  local t4 = Transition:create({id = "t4"})
  local nclExp, nclRet
  local status, err
  
  d1:setTransOut(t1)

  nclExp = "<descriptor transOut=\"t1\"/>\n"
  nclRet = d1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(d1.transOutAss[1] == t1, "Error!")
  assert(t1.ass[1] == d1, "Error!")
  
  d1 = Descriptor:create()
  
  d1:setTransOut(t2, t3, t4)

  nclExp = "<descriptor transOut=\"t2, t3, t4\"/>\n"
  nclRet = d1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(d1.transOutAss[1] == t2, "Error!")
  assert(d1.transOutAss[2] == t3, "Error!")
  assert(d1.transOutAss[3] == t4, "Error!")
  assert(t2.ass[1] == d1, "Error!")
  assert(t3.ass[1] == d1, "Error!")
  assert(t4.ass[1] == d1, "Error!")
  
  status, err = pcall(d1["setTransOut"], d1, Meta:create())
  assert(not(status), "Error!")
  assert(err == "Error! Invalid transOut element!", "Error!")
end

local function test4()
  local rb1 = RegionBase:create()
  local r1 = Region:create({id = "r1"})
  local nclExp, nclRet
  local status, err
  
  rb1:setRegion(r1)

  nclExp = "<regionBase region=\"r1\"/>\n"
  nclRet = rb1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(rb1.regionAss == r1, "Error!")
  assert(r1.ass[1] == rb1, "Error!")

  status, err = pcall(rb1["setRegion"], rb1, Mapping:create())
  assert(not(status), "Error!")
  assert(err == "Error! Invalid region element!", "Error!")
end

test1()
test2()
test3()
test4()