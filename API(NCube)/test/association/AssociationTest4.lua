require("core/NCube")

local function test1()
  local b1 = BindRule:create()
  local m1 = Media:create({id = "m1"})
  local nclExp, nclRet
  local status, err
  
  b1:setConstituent(m1)
  
  nclExp = "<bindRule constituent=\"m1\"/>\n"
  nclRet = b1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(b1.constituentAss == m1, "Error!")
  assert(m1.ass[1] == b1, "Error!")  
  
  status, err = pcall(b1["setConstituent"], b1, Meta:create())
  assert(not(status), "Error!")
  assert(err == "Error! Invalid constituent element!", "Error!")
end

local function test2()
  local b1 = BindRule:create()
  local r1 = Rule:create({id = "r1"})
  local cr1 = CompositeRule:create({id = "cr1"})
  local nclExp, nclRet
  local status, err
  
  b1:setRule(r1)

  nclExp = "<bindRule rule=\"r1\"/>\n"
  nclRet = b1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(b1.ruleAss == r1, "Error!")
  assert(r1.ass[1] == b1, "Error!")  
  
  b1:setRule(cr1)

  nclExp = "<bindRule rule=\"cr1\"/>\n"
  nclRet = b1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(b1.ruleAss == cr1, "Error!")
  assert(cr1.ass[1] == b1, "Error!")  
 
  status, err = pcall(b1["setRule"], b1, Transition:create())
  assert(not(status), "Error!")
  assert(err == "Error! Invalid rule element!", "Error!")
end

local function test3()
  local d1 = DefaultComponent:create()
  local m1 = Media:create({id = "m1"})
  local nclExp, nclRet
  local status, err
  
  d1:setComponent(m1)
  
  nclExp = "<defaultComponent component=\"m1\"/>\n"
  nclRet = d1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(d1.componentAss == m1, "Error!")
  assert(m1.ass[1] == d1, "Error!")  
  
  status, err = pcall(d1["setComponent"], d1, Mapping:create())
  assert(not(status), "Error!")
  assert(err == "Error! Invalid component element!", "Error!")
end

local function test4()
  local df1 = DefaultDescriptor:create()
  local d1 = Descriptor:create({id = "d1"})
  local nclExp, nclRet
  local status, err
  
  df1:setDescriptor(d1)
  
  nclExp = "<defaultDescriptor descriptor=\"d1\"/>\n"
  nclRet = df1:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
  assert(df1.descriptorAss == d1, "Error!")
  assert(d1.ass[1] == df1, "Error!")  
  
  status, err = pcall(df1["setDescriptor"], df1, DescriptorSwitch:create())
  assert(not(status), "Error!")
  assert(err == "Error! Invalid descriptor element!", "Error!")
end

test1()
test2()
test3()
test4()