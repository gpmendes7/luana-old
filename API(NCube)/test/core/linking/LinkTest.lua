local Link = require "core/linking/Link"
local LinkParam = require "core/linking/LinkParam"
local Bind = require "core/linking/Bind"

local function test1()
   local link = nil
   
   link = Link:create()
   assert(link ~= nil, "Error!")
   assert(link:getId() == "", "Error!")  
   assert(link:getXConnector() == "", "Error!")
end

local function test2()
   local link = nil
   
   local atts = {
      ["id"] = "link1",
      ["xconnector"] = "onBeginStart"
   }     
   
   link = Link:create(atts)
   assert(link:getId() == "link1", "Error!")  
   assert(link:getXConnector() == "onBeginStart", "Error!")
end

local function test3()
   local link = nil
      
   link = Link:create()
   
   link:setId("link1")
   link:setXConnector("onBeginStart")

   assert(link:getId() == "link1", "Error!")  
   assert(link:getXConnector() == "onBeginStart", "Error!")
end

local function test4()
   local link = nil
      
   link = Link:create(nil, 1)
   assert(link:getLinkParamPos(1) ~= nil, "Error!")
   assert(link:getBindPos(1) ~= nil, "Error!")
   
   link:addLinkParam(LinkParam:create())
   assert(link:getLinkParamPos(2) ~= nil, "Error!")
   
   link:addBind(Bind:create())
   assert(link:getBindPos(2) ~= nil, "Error!")
   
   link:addLinkParam(LinkParam:create{["name"] = "delay"})
   assert(link:getDescendantByAttribute("name", "delay") ~= nil, "Error!")
       
   link:addBind(Bind:create{["role"] = "onBegin"})
   assert(link:getDescendantByAttribute("role", "onBegin") ~= nil, "Error!")
end

local function test5()
   local link = Link:create{["id"] = "link1"}  
   local linkParam = LinkParam:create{["name"] = "delay"}
   local bind = Bind:create{["role"] = "onBegin"}

   link:addLinkParam(linkParam)
   assert(link:getDescendantByAttribute("name", "delay") ~= nil, "Error!")

   link:removeLinkParam(linkParam)
   assert(link:getDescendantByAttribute("name", "delay") == nil, "Error!")
   
   link:addLinkParam(linkParam)
   link:removeLinkParamPos(1)
   assert(link:getDescendantByAttribute("name", "delay") == nil, "Error!")
   
   link:addBind(bind)
   assert(link:getDescendantByAttribute("role", "onBegin") ~= nil, "Error!")

   link:removeBind(bind)
   assert(link:getDescendantByAttribute("role", "onBegin") == nil, "Error!")
   
   link:addBind(bind)
   link:removeBindPos(1)
   assert(link:getDescendantByAttribute("role", "onBegin") == nil, "Error!")
end

local function test6()
   local link = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
      ["id"] = "link1",
      ["xconnector"] = "onBeginStart"
   }  
      
   link = Link:create(atts)
   
   nclExp = "<link"   
   for attribute, value in pairs(link:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
   
   nclExp = nclExp.."/>\n"
  
   nclRet = link:table2Ncl(0)
   
   assert(nclExp == nclRet, "Error!")
end

local function test7()
   local link = nil
   local linkParam = nil
   local bind = nil
   
   local nclExp, nclRet = nil
   
   link = Link:create{["id"] = "link1"}  
   nclExp = "<link id=\"link1\">\n"    
         
   linkParam =  LinkParam:create{["name"] = "delay"}
   nclExp = nclExp.." <linkParam name=\"delay\"/>\n"
   
   bind = Bind:create{["role"] = "onBegin"}    
   nclExp = nclExp.." <bind role=\"onBegin\"/>\n"
       
   nclExp = nclExp.."</link>\n"

   link:addLinkParam(linkParam)  
   link:addBind(bind) 

   nclRet = link:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()
test7()