local NCLElem = require "core/NCLElem"

local Elem1 = NCLElem:extends()
Elem1.nameElem = "e1"
Elem1.attributesTypeMap = {
  ["id"] = "string"
}

local Elem2 = NCLElem:extends()
Elem2.nameElem = "e2"
Elem2.attributesTypeMap = {
  ["id"] = "string"
}
Elem2.childrenMap = {
  e1 = {Elem1, "many"}
}


local e1 = Elem1:new()
e1:addAttribute("id", "e1")

local e2 = Elem2:new()
e2.children = {}
e2:addAttribute("id", "e2")
e2:addChild(e1)
e2:writeNcl()