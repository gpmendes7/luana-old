require("core/NCube")

local function test1()
  local doc = Document:create()

  doc:loadNcl("docs/nclcd/exemplo01.ncl")

  local rgTV = doc:getDescendantByAttribute("id", "rgTV")
  assert(rgTV:getRegionPos(1):getId() == "rgVideo1", "Error!")

  local rgVideo1 = doc:getDescendantByAttribute("id", "rgVideo1")
  assert(rgVideo1.ass[1]:getId() == "dVideo1", "Error!")

  local pInicio = doc:getDescendantByAttribute("id", "pInicio")
  assert(pInicio.componentAss:getId() == "video1", "Error!")
  
  local video1 = doc:getDescendantByAttribute("id", "video1")
  assert(video1.ass[1]:getId() == "pInicio", "Error!")
  assert(video1.descriptorAss:getId() == "dVideo1", "Error!")
end

test1()
