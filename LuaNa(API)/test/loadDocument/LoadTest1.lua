require("core/LuaNa")

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

local function test2()
  local doc = Document:create()

  doc:loadNcl("docs/nclcd/exemplo02.ncl")

  local rgTV = doc:getDescendantByAttribute("id", "rgTV")
  assert(rgTV:getRegionPos(1):getId() == "rgTitulo1", "Error!")
  assert(rgTV:getRegionPos(2):getId() == "rgVideo1", "Error!")

  local rgTitulo1 = doc:getDescendantByAttribute("id", "rgTitulo1")
  assert(rgTitulo1.ass[1]:getId() == "dTitulo1", "Error!")

  local rgVideo1 = doc:getDescendantByAttribute("id", "rgVideo1")
  assert(rgVideo1.ass[1]:getId() == "dVideo1", "Error!")

  local pInicio = doc:getDescendantByAttribute("id", "pInicio")
  assert(pInicio.componentAss:getId() == "video1", "Error!")

  local titulo1 = doc:getDescendantByAttribute("id", "titulo1")
  assert(titulo1.descriptorAss:getId() == "dTitulo1", "Error!")

  local video1 = doc:getDescendantByAttribute("id", "video1")
  assert(video1.ass[1]:getId() == "pInicio", "Error!")
  assert(video1.descriptorAss:getId() == "dVideo1", "Error!")
end

local function test3()
  local doc = Document:create()

  doc:loadNcl("docs/gingahero/main.ncl")

  local rgTv = doc:getDescendantByAttribute("id", "rgTv")
  assert(rgTv.ass[1]:getId() == "dSong", "Error!")

  local rgIntro = doc:getDescendantByAttribute("id", "rgIntro")
  assert(rgIntro.ass[1]:getId() == "dIntro", "Error!")

  local rgGame = doc:getDescendantByAttribute("id", "rgGame")
  assert(rgGame.ass[1]:getId() == "dGame", "Error!")

  local dIntro = doc:getDescendantByAttribute("id", "dIntro")
  assert(dIntro.ass[1]:getId() == "intro", "Error!")
  assert(dIntro.regionAss:getId() == "rgIntro", "Error!")

  local dGame = doc:getDescendantByAttribute("id", "dGame")
  assert(dGame.ass[1]:getId() == "lua", "Error!")
  assert(dGame.ass[2]:getId() == "game", "Error!")
  assert(dGame.regionAss:getId() == "rgGame", "Error!")

  local dSong = doc:getDescendantByAttribute("id", "dSong")
  assert(dSong.ass[1]:getId() == "fundo", "Error!")
  assert(dSong.ass[2]:getId() == "erro", "Error!")
  assert(dSong.ass[3]:getId() == "guitar", "Error!")
  assert(dSong.ass[4]:getId() == "song", "Error!")
  assert(dSong.regionAss:getId() == "rgTv", "Error!")

  local onBeginStartStop = doc:getDescendantByAttribute("id", "onBeginStartStop")
  assert(onBeginStartStop.ass[1]:getId() == "StartIntro", "Error!")
  assert(onBeginStartStop.ass[2]:getId() == "StartFundo", "Error!")
  assert(onBeginStartStop.ass[3]:getId() == "StartSong", "Error!")
  assert(onBeginStartStop.ass[4]:getId() == "StartGuitar", "Error!")

  local onBeginStart = doc:getDescendantByAttribute("id", "onBeginStart")
  assert(onBeginStart.ass[1]:getId() == "inciaIntro", "Error!")
  assert(onBeginStart.ass[2]:getId() == "inciaFundo", "Error!")
  assert(onBeginStart.ass[3]:getId() == "inciaSong", "Error!")
  assert(onBeginStart.ass[4]:getId() == "inciaGuitar", "Error!")
  assert(onBeginStart.ass[5]:getId() == "inciaErro", "Error!")

  local onPausePause = doc:getDescendantByAttribute("id", "onPausePause")
  assert(onPausePause.ass[1]:getId() == "PausaIntro", "Error!")
  assert(onPausePause.ass[2]:getId() == "PausaFundo", "Error!")
  assert(onPausePause.ass[3]:getId() == "PausaSong", "Error!")
  assert(onPausePause.ass[4]:getId() == "Pausaguitar", "Error!")
  assert(onPausePause.ass[5]:getId() == "PausaErro", "Error!")

  local onResumeReesume = doc:getDescendantByAttribute("id", "onResumeReesume")
  assert(onResumeReesume.ass[1]:getId() == "ResumeIntro", "Error!")
  assert(onResumeReesume.ass[2]:getId() == "ResumeFundo", "Error!")
  assert(onResumeReesume.ass[3]:getId() == "ResumeSong", "Error!")
  assert(onResumeReesume.ass[4]:getId() == "Resumeguitar", "Error!")
  assert(onResumeReesume.ass[5]:getId() == "ResumeErro", "Error!")

  local onStopStop = doc:getDescendantByAttribute("id", "onStopStop")
  assert(onStopStop.ass[1]:getId() == "StopIntro", "Error!")
  assert(onStopStop.ass[2]:getId() == "StopFundo", "Error!")
  assert(onStopStop.ass[3]:getId() == "StopSong", "Error!")
  assert(onStopStop.ass[4]:getId() == "Stopguitar", "Error!")
  assert(onStopStop.ass[5]:getId() == "StopErro", "Error!")

  local onBeginSet = doc:getDescendantByAttribute("id", "onBeginSet")
  assert(onBeginSet.ass[1]:getId() == "MuteFundo", "Error!")
  assert(onBeginSet.ass[2]:getId() == "MuteSong", "Error!")
  assert(onBeginSet.ass[3]:getId() == "Muteguitar", "Error!")
  assert(onBeginSet.ass[4]:getId() == "MuteErro", "Error!")

  local onEndSet = doc:getDescendantByAttribute("id", "onEndSet")
  assert(onEndSet.ass[1]:getId() == "UnMuteFundo", "Error!")
  assert(onEndSet.ass[2]:getId() == "UnMuteSong", "Error!")
  assert(onEndSet.ass[3]:getId() == "UnMuteguitar", "Error!")
  assert(onEndSet.ass[4]:getId() == "UnMuteErro", "Error!")

  local pBody = doc:getDescendantByAttribute("id", "pBody")
  assert(pBody.componentAss:getId() == "game", "Error!")

  local lua = doc:getDescendantByAttribute("id", "lua")
  assert(lua.descriptorAss:getId() == "dGame", "Error!")

  local game = doc:getDescendantByAttribute("id", "game")
  assert(game.descriptorAss:getId() == "dGame", "Error!")
  assert(game.ass[1]:getId() == "pBody", "Error!")
  assert(game.ass[2]:getInterface() == "introPlay", "Error!")
  assert(game.ass[3]:getInterface() == "introStart", "Error!")
  assert(game.ass[4]:getRole() == "onPause", "Error!")
  assert(game.ass[5]:getRole() == "onResume", "Error!")
  assert(game.ass[6]:getRole() == "onEnd", "Error!")

  local inciaIntro = doc:getDescendantByAttribute("id", "inciaIntro")
  assert(inciaIntro.causalConnectorAss:getId() == "onBeginStart", "Error!")
  assert(inciaIntro:getBindPos(1):getInterface() == "introPlay", "Error!")
  assert(inciaIntro:getBindPos(1).interfaceAss:getId() == "introPlay", "Error!")
  assert(inciaIntro:getBindPos(1).interfaceAss == game:getAreaPos(1), "Error!")
end

test1()
test2()
test3()