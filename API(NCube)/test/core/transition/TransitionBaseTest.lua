local TransitionBase = require "core/transition/TransitionBase"
local ImportBase = require "core/importation/ImportBase"
local Transition = require "core/transition/Transition"

local function test1()
  local transitionBase = TransitionBase:create()
  
  assert(transitionBase ~= nil, "Error!")
  assert(transitionBase:getId() == nil, "Error!")
end

local function test2()
  local atts = {
    id= "transitionBase"
  }

  local transitionBase = TransitionBase:create(atts)

  assert(transitionBase:getId() == "transitionBase", "Error!")
end

local function test3()
  local transitionBase = TransitionBase:create()

  transitionBase:setId("transitionBase")

  assert(transitionBase:getId() == "transitionBase", "Error!")
end

local function test4()
  local transitionBase = TransitionBase:create()
  local status, err

  status, err = pcall(transitionBase["setId"], TransitionBase, nil)
  assert(not(status), "Error!")

  status, err = pcall(transitionBase["setId"], TransitionBase, {})
  assert(not(status), "Error!")

  status, err = pcall(transitionBase["setId"], TransitionBase, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test5()
  local transitionBase

  transitionBase = TransitionBase:create(nil, 1)
  assert(transitionBase:getImportBasePos(1) ~= nil, "Error!")
  assert(transitionBase:getTransitionPos(1) ~= nil, "Error!")

  transitionBase:addImportBase(ImportBase:create())
  assert(transitionBase:getImportBasePos(2) ~= nil, "Error!")

  transitionBase:addTransition(Transition:create())
  assert(transitionBase:getTransitionPos(2) ~= nil, "Error!")

  transitionBase:addImportBase(ImportBase:create{["alias"] = "connBase"})
  assert(transitionBase:getDescendantByAttribute("alias", "connBase") ~= nil, "Error!")

  transitionBase:addTransition(Transition:create{["id"] = "transition"})
  assert(transitionBase:getDescendantByAttribute("id", "transition") ~= nil, "Error!")
end

local function test6()
  local transitionBase = TransitionBase:create{id = "transitionBase"}
  local importBase1 = ImportBase:create{alias = "connBase1"}
  local importBase2 = ImportBase:create{alias = "connBase2"}
  local transition1 = Transition:create{id = "transition1"}
  local transition2 = Transition:create{id = "transition2"}

  transitionBase:setImportBases(importBase1, importBase2)
  assert(transitionBase:getDescendantByAttribute("alias", "connBase1") ~= nil, "Error!")
  assert(transitionBase:getDescendantByAttribute("alias", "connBase2") ~= nil, "Error!")

  transitionBase:removeImportBase(importBase1)
  assert(transitionBase:getDescendantByAttribute("alias", "connBase1") == nil, "Error!")

  transitionBase:removeImportBasePos(1)
  assert(transitionBase:getDescendantByAttribute("alias", "connBase2") == nil, "Error!")

  transitionBase:setTransitions(transition1, transition2)
  assert(transitionBase:getDescendantByAttribute("id", "transition1") ~= nil, "Error!")
  assert(transitionBase:getDescendantByAttribute("id", "transition2") ~= nil, "Error!")

  transitionBase:removeTransition(transition1)
  assert(transitionBase:getDescendantByAttribute("id", "transition1") == nil, "Error!")

  transitionBase:removeTransitionPos(1)
  assert(transitionBase:getDescendantByAttribute("id", "transition2") == nil, "Error!")
end

local function test7()
  local transitionBase = TransitionBase:create()
  local status, err

  status, err = pcall(transitionBase["removeTransition"], TransitionBase, TransitionBase:create())
  assert(not(status), "Error!")

  status, err = pcall(transitionBase["removeTransition"], TransitionBase, "invalid")
  assert(not(status), "Error!")

  status, err = pcall(transitionBase["removeTransition"], TransitionBase, nil)
  assert(not(status), "Error!")

  status, err = pcall(transitionBase["removeTransition"], TransitionBase, {})
  assert(not(status), "Error!")

  status, err = pcall(transitionBase["removeTransition"], TransitionBase, function(a, b) return a+b end)
  assert(not(status), "Error!")
end

local function test8()
  local atts = {
    id= "transitionBase"
  }

  local transitionBase = TransitionBase:create(atts)

  local nclExp = "<transitionBase id=\"transitionBase\"/>\n"

  nclRet = transitionBase:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

local function test9()
  local transitionBase = TransitionBase:create{id = "transitionBase"}
  local nclExp = "<transitionBase id=\"transitionBase\">\n"

  local transition = Transition:create{id = "transition"}
  nclExp = nclExp.." <transition id=\"transition\"/>\n"

  local importBase = ImportBase:create{alias = "connBase"}
  nclExp = nclExp.." <importBase alias=\"connBase\"/>\n"

  nclExp = nclExp.."</transitionBase>\n"

  transitionBase:addTransition(transition)
  transitionBase:addImportBase(importBase)

  local nclRet = transitionBase:table2Ncl(0)

  assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()
test7()
test8()
test9()