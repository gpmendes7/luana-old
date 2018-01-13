local CompositeNodes = require "core/content/CompositeNode"
local Context = CompositeNodes[1]
local Switch = CompositeNodes[2]
local Port = require "core/interface/Port"
local Property = require "core/interface/Property"
local Media = require "core/content/Media"
local Link = require "core/linking/Link"
local Meta = require "core/metadata/Meta"
local MetaData = require "core/metadata/MetaData"

local function test1()
   local context = nil
   
   context = Context:create()
   assert(context ~= nil, "Error!")
   assert(context:getId() == "", "Error!")
   assert(context:getRefer() == "", "Error!") 
end

local function test2()
   local context = nil
   
   local atts = { 
     ["id"] = "c1",
     ["refer"] = "rf"
   }
   
   context = Context:create(atts)
   assert(context:getId() == "c1", "Error!")
   assert(context:getRefer() == "rf", "Error!")    
end

local function test3()
   local context = nil
      
   context = Context:create()
   
   context:setId("c1")
   context:setRefer("rf")     
   
   assert(context:getId() == "c1", "Error!")
   assert(context:getRefer() == "rf", "Error!")        
end

local function test4()
   local context = nil
      
   context = Context:create(nil, 1)
   assert(context:getPortPos(1) ~= nil, "Error!")
   assert(context:getPropertyPos(1) ~= nil, "Error!")
   assert(context:getMediaPos(1) ~= nil, "Error!")
   assert(context:getContextPos(1) ~= nil, "Error!")
   assert(context:getLinkPos(1) ~= nil, "Error!")
   assert(context:getSwitchPos(1) ~= nil, "Error!")
   assert(context:getMetaPos(1) ~= nil, "Error!")
   assert(context:getMetaDataPos(1) ~= nil, "Error!")
   
   context:addPort(Port:create())
   assert(context:getPortPos(2) ~= nil, "Error!")
   
   context:addProperty(Property:create())
   assert(context:getPropertyPos(2) ~= nil, "Error!")
   
   context:addMedia(Media:create())
   assert(context:getMediaPos(2) ~= nil, "Error!")
   
   context:addContext(Context:create())
   assert(context:getContextPos(2) ~= nil, "Error!")
   
   context:addLink(Link:create())
   assert(context:getLinkPos(2) ~= nil, "Error!")
   
   context:addSwitch(Switch:create())
   assert(context:getSwitchPos(2) ~= nil, "Error!")
   
   context:addMeta(Meta:create())
   assert(context:getMetaPos(2) ~= nil, "Error!")
   
   context:addMetaData(MetaData:create())
   assert(context:getMetaDataPos(2) ~= nil, "Error!")
   
   context:addPort(Port:create{["id"] = "p1"})
   assert(context:getPortById("p1") ~= nil, "Error!")   
   
   context:addProperty(Property:create{["name"] = "sound"})
   assert(context:getPropertyByName("sound") ~= nil, "Error!")
   
   context:addMedia(Media:create{["id"] = "m1"})
   assert(context:getMediaById("m1") ~= nil, "Error!")
   
   context:addContext(Context:create{["id"] = "c1"})
   assert(context:getContextById("c1") ~= nil, "Error!")
   
   context:addLink(Link:create{["id"] = "l1"})
   assert(context:getLinkById("l1") ~= nil, "Error!")
   
   context:addSwitch(Switch:create{["id"] = "s1"})
   assert(context:getSwitchById("s1") ~= nil, "Error!")
   
   context:addMeta(Meta:create{["name"] = "mt"})
   assert(context:getDescendantByAttribute("name", "mt") ~= nil, "Error!")
   
   context:addMetaData(MetaData:create())
   assert(context:getMetaDataPos(1) ~= nil, "Error!")
end

local function test5()
   local context1 = Context:create{["id"] = "c1"}
   local port = Port:create{["id"] = "p1"}
   local property = Property:create{["name"] = "sound"}
   local media = Media:create{["id"] = "m1"}
   local context2 = Context:create{["id"] = "c2"}
   local link = Link:create{["id"] = "l1"}
   local switch = Switch:create{["id"] = "s1"}
   local meta = Meta:create{["name"] = "mt"}
   local metadata = MetaData:create()
    
   context1:addPort(port)    
   context1:removePort(port)
   assert(context1:getPortById("p1") == nil, "Error!")   
   
   context1:addPort(port)    
   context1:removePortPos(1)
   assert(context1:getPortById("p1") == nil, "Error!")
   
   context1:addProperty(property)    
   context1:removeProperty(property)
   assert(context1:getPropertyByName("sound") == nil, "Error!")   
   
   context1:addProperty(property)    
   context1:removePropertyPos(1)
   assert(context1:getPropertyByName("sound") == nil, "Error!")  
   
   context1:addMedia(media)    
   context1:removeMedia(media)
   assert(context1:getMediaById("m1") == nil, "Error!")   
   
   context1:addMedia(media)    
   context1:removeMediaPos(1)
   assert(context1:getMediaById("m1") == nil, "Error!")
   
   context1:addContext(context2)    
   context1:removeContext(context2)
   assert(context1:getContextById("c2") == nil, "Error!")   
   
   context1:addContext(context2)    
   context1:removeContextPos(1)
   assert(context1:getContextById("c2") == nil, "Error!")  
   
   context1:addLink(link)    
   context1:removeLink(link)
   assert(context1:getLinkById("s1") == nil, "Error!")   
   
   context1:addLink(link)    
   context1:removeLinkPos(1)
   assert(context1:getLinkById("s1") == nil, "Error!")  
   
   context1:addSwitch(switch)    
   context1:removeSwitch(switch)
   assert(context1:getSwitchById("s1") == nil, "Error!")   
   
   context1:addSwitch(switch)    
   context1:removeSwitchPos(1)
   assert(context1:getSwitchById("s1") == nil, "Error!")  
   
   context1:addMeta(meta)    
   context1:removeMeta(meta)
   assert(context1:getDescendantByAttribute("name", "mt") == nil, "Error!")  
   
   context1:addMeta(meta)    
   context1:removeMetaPos(1)
   assert(context1:getDescendantByAttribute("name", "mt") == nil, "Error!")
        
   context1:addMetaData(metadata)    
   context1:removeMetaData(metadata)
   assert(context1:getMetaDataPos(1) == nil, "Error!")  
   
   context1:addMeta(meta)    
   context1:removeMetaPos(1)
   assert(context1:getMetaDataPos(1) == nil, "Error!")
end

local function test6()
   local context = nil
   
   local nclExp, nclRet, atts = nil
   
   atts = {
     ["id"] = "s1",
     ["refer"] = "rf"
   }    
      
   context = Context:create(atts)
   
   nclExp = "<context"   
   for attribute, value in pairs(context:getAttributes()) do
      nclExp = nclExp.." "..attribute.."=\""..value.."\""
   end 
   
   nclExp = nclExp.."/>\n"

   nclRet = context:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

local function test7()   
   local context1 = nil
   
   local port, property, media, context2 = nil
   
   local link, switch, meta, metaData = nil
   
   local nclExp, nclRet = nil
   
   context1 = Context:create{["id"] = "c1"}
   nclExp = "<context id=\"c1\">\n"
   
   port = Port:create{["id"] = "p1"}
   nclExp = nclExp.." <port id=\"p1\"/>\n"
      
   property = Property:create{["name"] = "sound"}
   nclExp = nclExp.." <property name=\"sound\"/>\n"  
   
   media = Media:create{["id"] = "m1"}
   nclExp = nclExp.." <media id=\"m1\"/>\n"   
  
   context2 = Context:create{["id"] = "c2"}
   nclExp = nclExp.." <context id=\"c2\"/>\n" 
   
   link = Link:create{["id"] = "l1"}
   nclExp = nclExp.." <link id=\"l1\"/>\n" 
   
   switch = Switch:create{["id"] = "s1"}
   nclExp = nclExp.." <switch id=\"s1\"/>\n" 
   
   meta = Meta:create{["name"] = "mt"}
   nclExp = nclExp.." <meta name=\"mt\"/>\n" 
   
   nclExp = nclExp.."</context>\n"  
   
   context1:addPort(port) 
   context1:addProperty(property)  
   context1:addMedia(media)  
   context1:addContext(context2)  
   context1:addLink(link)  
   context1:addSwitch(switch)    
   context1:addMeta(meta)    
   
   nclRet = context1:table2Ncl(0)

   assert(nclExp == nclRet, "Error!")
end

test1()
test2()
test3()
test4()
test5()
test6()
test7()