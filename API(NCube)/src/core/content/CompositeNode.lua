local NCLElem = require "core/NCLElem"


local Port = require "core/interface/Port"
local Property = require "core/interface/Property"
local Media = require "core/content/Media"
local Link = require "core/linking/Link"
local Meta = require "core/metadata/Meta"
local MetaData = require "core/metadata/MetaData"

local Context = NCLElem:extends()
local Switch = NCLElem:extends()

 -- Class Context --- 

Context.name = "context"

Context.childrenMap = {
 ["port"] = {Port, "many"},
 ["property"] = {Property, "many"},  
 ["media"] = {Media, "many"},
 ["context"] = {Context, "many"},
 ["link"] = {Link, "many"},
 ["switch"] = {Switch, "many"},
 ["meta"] = {Meta, "many"},
 ["metadata"] = {MetaData, "one"}
}

function Context:create(attributes, full)
   local context = Context:new()
   
   context.attributes = { 
    ["id"] = "",
    ["refer"] = ""
   }
   
   if(attributes ~= nil)then
      context:setAttributes(attributes)
   end
   
   context.children = {}  
   context.ports = {}
   context.propertys = {}
   context.medias = {}
   context.contexts = {}
   context.links = {}
   context.switchs = {}
   context.metas = {}
   context.metadatas = {}
   
   if(full ~= nil)then
      context:addPort(Port:create()) 
      context:addProperty(Property:create()) 
      context:addMedia(Media:create(nil, full))
      context:addContext(Context:create())  
      context:addLink(Link:create(nil, full))  
      context:addSwitch(Switch:create())  
      context:addMeta(Meta:create()) 
      context:addMetaData(MetaData:create())
   end
   
   return context
end

function Context:setId(id)
    self:addAttribute("id", id)
end

function Context:getId()
   return self:getAttribute("id")
end

function Context:setRefer(refer)
    self:addAttribute("refer", refer)
end

function Context:getRefer()
   return self:getAttribute("refer")
end

function Context:addPort(port)
   table.insert(self.ports, port)    
   self:addChild(port)
end

function Context:getPortPos(i)
   return self.ports[i]
end

function Context:getPortById(id)
   for _, port in ipairs(self.ports) do
       if(port:getId() == id)then
          return port
       end
   end
   
   return nil
end

function Context:setPorts(...)
    if(#arg>0)then
      for _, port in ipairs(arg) do
          self:addPort(port)
      end
    end
end

function Context:removePort(port)
   self:removeChild(port)
   
   for i, pt in ipairs(self.ports) do
       if(port == pt)then
           table.remove(self.ports, i)  
       end
   end 
end

function Context:removePortPos(i)
   self:removeChildPos(i)
   table.remove(self.ports, i)
end

function Context:addProperty(property)
   table.insert(self.propertys, property)    
   self:addChild(property)    
end

function Context:getPropertyPos(i)
    return self.propertys[i]
end

function Context:getPropertyByName(name)
   for _, property in ipairs(self.propertys) do
       if(property:getName() == name)then
          return property
       end
   end
   
   return nil
end

function Context:setPropertys(...)
    if(#arg>0)then
      for _, property in ipairs(arg) do
          self:addProperty(property)
      end
    end
end

function Context:removeProperty(property)
   self:removeChild(property)
   
   for i, pr in ipairs(self.propertys) do
       if(property == pr)then
           table.remove(self.propertys, i)  
       end
   end    
end

function Context:removePropertyPos(i)
   self:removeChildPos(i)
   table.remove(self.propertys, i)
end

function Context:addMedia(media)
   table.insert(self.medias, media)    
   self:addChild(media)    
end

function Context:getMediaPos(i)
   return self.medias[i]
end

function Context:getMediaById(id)
   for _, media in ipairs(self.medias) do
       if(media:getId() == id)then
          return media
       end
   end
   
   return nil
end

function Context:setMedias(...)
    if(#arg>0)then
      for _, media in ipairs(arg) do
         self:addMedia(media)
      end
    end
end
function Context:removeMedia(media)
   self:removeChild(media)
   
   for i, md in ipairs(self.medias) do
       if(media == md)then
           table.remove(self.medias, i)  
       end
   end 
end

function Context:removeMediaPos(i)
   self:removeChildPos(i)
   table.remove(self.medias, i)
end

function Context:addContext(context)
   table.insert(self.contexts, context)    
   self:addChild(context)
end

function Context:getContextPos(i)
   return self.contexts[i]
end

function Context:getContextById(id)
   for _, context in ipairs(self.contexts) do
       if(context:getId() == id)then
          return context
       end
   end
   
   return nil
end

function Context:setContexts(...)
    if(#arg>0)then
      for _, context in ipairs(arg) do
         self:addContext(context)
      end
    end
end

function Context:removeContext(context)
   self:removeChild(context)
   
   for i, ct in ipairs(self.contexts) do
       if(context == ct)then
           table.remove(self.contexts, i)  
       end
   end 
end

function Context:removeContextPos(i)
   self:removeChildPos(i)
   table.remove(self.contexts, i)
end

function Context:addLink(link)
   table.insert(self.links, link)    
   self:addChild(link)    
end

function Context:getLinkPos(i)
   return self.links[i]
end

function Context:getLinkById(id)
   for _, link in ipairs(self.links) do
       if(link:getId() == id)then
          return link
       end
   end
   
   return nil
end

function Context:setLinks(...)
    if(#arg>0)then
      for _, link in ipairs(arg) do
         self:addMedia(link)
      end
    end
end
function Context:removeLink(link)
   self:removeChild(link)
   
   for i, lk in ipairs(self.links) do
       if(link == lk)then
           table.remove(self.links, i)  
       end
   end 
end

function Context:removeLinkPos(i)
   self:removeChildPos(i)
   table.remove(self.links, i)
end

function Context:addSwitch(switch)
   table.insert(self.switchs, switch)    
   self:addChild(switch)
end

function Context:getSwitchPos(i)
   return self.switchs[i]
end

function Context:getSwitchById(id)
   for _, switch in ipairs(self.switchs) do
       if(switch:getId() == id)then
          return switch
       end
   end
   
   return nil
end

function Context:setSwitchs(...)
    if(#arg>0)then
      for _, switch in ipairs(arg) do
         self:addSwitch(switch)
      end
    end
end

function Context:removeSwitch(switch)
   self:removeChild(switch)
   
   for i, ct in ipairs(self.switchs) do
       if(switch == ct)then
           table.remove(self.switchs, i)  
       end
   end 
end

function Context:removeSwitchPos(i)
   self:removeChildPos(i)
   table.remove(self.switchs, i)
end

function Context:addMeta(meta)
   table.insert(self.metas, meta)    
   self:addChild(meta)      
end

function Context:getMetaPos(i)
   return self.metas[i]
end

function Context:setMetas(...)
    if(#arg>0)then
      for _, meta in ipairs(arg) do
         self:addMedia(meta)
      end
    end
end
function Context:removeMeta(meta)
   self:removeChild(meta)
   
   for i, mt in ipairs(self.metas) do
       if(meta == mt)then
           table.remove(self.metas, i)  
       end
   end 
end

function Context:removeMetaPos(i)
   self:removeChildPos(i)
   table.remove(self.metas, i)
end

function Context:addMetaData(metadata)
   table.insert(self.metadatas, metadata)  
   local p = self:getPosAvailable("meta", "connectorBase", "descriptorBase", "regionBase", 
                                  "transitionBase", "ruleBase", "importedDocumentBase")          
   if(p ~= nil)then
      self:addChild(metadata, p-1)
   else
      self:addChild(metadata, 1)
   end    
end

function Context:getMetaDataPos(p)
   return self.metadatas[p]
end

function Context:setMetaDatas(...)
    if(#arg>0)then
      for _, metadata in ipairs(arg) do
         self:addMedia(metadata)
      end
    end
end

function Context:removeMetaData(metadata)
   self:removeChild(metadata)
   
   for p, mt in ipairs(self.metadatas) do
       if(metadata == mt)then
           table.remove(self.metadatas, p)  
       end
   end
end

-- Classe Switch -- 

local DefaultComponent = require "core/switches/DefaultComponent"
local SwitchPort = require "core/switches/SwitchPort"
local BindRule = require "core/switches/BindRule"

Switch.name = "switch"

Switch.childrenMap = {
 ["defaultComponent"] = {DefaultComponent, "one"},
 ["switchPort"] = {SwitchPort, "many"},  
 ["bindRule"] = {BindRule, "many"},  
 ["media"] = {Media, "many"},
 ["context"] = {Context, "many"},
 ["switch"] = {Switch, "many"}
}

function Switch:create(attributes, full)
   local switch = Switch:new()
   
   switch.attributes = { 
    ["id"] = "",
    ["refer"] = ""
   }
   
   if(attributes ~= nil)then
      switch:setAttributes(attributes)
   end
   
   switch.children = {}  
   switch.switchPorts = {}
   switch.bindRules = {}
   switch.medias = {}
   switch.contexts = {}
   switch.switchs = {}
   
   if(full ~= nil)then
      switch:setDefaultComponent(DefaultComponent:create()) 
      switch:addSwitchPort(SwitchPort:create(nil, full)) 
      switch:addBindRule(BindRule:create()) 
      switch:addMedia(Media:create(nil, full))
      switch:addContext(Context:create())  
      switch:addSwitch(Switch:create())  
   end
   
   return switch
end

function Switch:setId(id)
    self:addAttribute("id", id)
end

function Switch:getId()
   return self:getAttribute("id")
end

function Switch:setRefer(refer)
    self:addAttribute("refer", refer)
end

function Switch:getRefer()
   return self:getAttribute("refer")
end

function Switch:setDefaultComponent(defaultComponent)   
   self:addChild(defaultComponent, 1)
   self.defaultComponent = defaultComponent       
end

function Switch:getDefaultComponent()
   return self.defaultComponent
end

function Switch:removeDefaultComponent()
   self:removeChild(self.defaultComponent)
   self.defaultComponent = nil
end

function Switch:addSwitchPort(switchPort)
   self:addChild(switchPort)
   table.insert(self.switchPorts, switchPort)  
end

function Switch:getSwitchPortPos(i)
    return self.switchPorts[i]
end

function Switch:getSwitchPortById(id)
   for _, switchPort in ipairs(self.switchPorts) do
       if(switchPort:getId() == id)then
          return switchPort
       end
   end
   
   return nil
end

function Switch:setSwitchPorts(...)
    if(#arg>0)then
      for _, switchPort in ipairs(arg) do
          self:addSwitchPort(switchPort)
      end
    end
end

function Switch:removeSwitchPort(switchPort)
   self:removeChild(switchPort)
   
   for i, sp in ipairs(self.switchPorts) do
       if(switchPort == sp)then
           table.remove(self.switchPorts, i)  
       end
   end    
end

function Switch:removeSwitchPortPos(i)
   self:removeChildPos(i)
   table.remove(self.switchPorts, i)
end

function Switch:addBindRule(bindRule)
   self:addChild(bindRule)
   table.insert(self.bindRules, bindRule)  
end

function Switch:getBindRulePos(i)
    return self.bindRules[i]
end

function Switch:setBindRules(...)
    if(#arg>0)then
      for _, bindRule in ipairs(arg) do
          self:addBindRule(bindRule)
      end
    end
end

function Switch:removeBindRule(bindRule)
   self:removeChild(bindRule)
   
   for i, br in ipairs(self.bindRules) do
       if(bindRule == br)then
           table.remove(self.bindRules, i)  
       end
   end    
end

function Switch:removeBindRulePos(i)
   self:removeChildPos(i)
   table.remove(self.bindRules, i)
end

function Switch:addMedia(media)
   table.insert(self.medias, media)    
   self:addChild(media)
end

function Switch:getMediaPos(i)
   return self.medias[i]
end

function Switch:getMediaById(id)
   for _, media in ipairs(self.medias) do
       if(media:getId() == id)then
          return media
       end
   end
   
   return nil
end

function Switch:setMedias(...)
    if(#arg>0)then
      for _, media in ipairs(arg) do
         self:addMedia(media)
      end
    end
end
function Switch:removeMedia(media)
   self:removeChild(media)
   
   for i, md in ipairs(self.medias) do
       if(media == md)then
           table.remove(self.medias, i)  
       end
   end 
end

function Switch:removeMediaPos(i)
   self:removeChildPos(i)
   table.remove(self.medias, i)
end

function Switch:addContext(context)
   self:addChild(context)
   table.insert(self.contexts, context)    
end

function Switch:getContextPos(i)
   return self.contexts[i]
end

function Switch:getContextById(id)
   for _, context in ipairs(self.contexts) do
       if(context:getId() == id)then
          return context
       end
   end
   
   return nil
end

function Switch:setContexts(...)
    if(#arg>0)then
      for _, context in ipairs(arg) do
         self:addContext(context)
      end
    end
end

function Switch:removeContext(context)
   self:removeChild(context)
   
   for i, ct in ipairs(self.contexts) do
       if(context == ct)then
           table.remove(self.contexts, i)  
       end
   end 
end

function Switch:removeContextPos(i)
   self:removeChildPos(i)
   table.remove(self.contexts, i)
end

function Switch:addSwitch(switch)
   table.insert(self.switchs, switch)    
   self:addChild(switch)
end

function Switch:getSwitchPos(i)
   return self.switchs[i]
end

function Switch:getSwitchById(id)
   for _, switch in ipairs(self.switchs) do
       if(switch:getId() == id)then
          return switch
       end
   end
   
   return nil
end

function Switch:setSwitchs(...)
    if(#arg>0)then
      for _, switch in ipairs(arg) do
         self:addSwitch(switch)
      end
    end
end

function Switch:removeSwitch(switch)
   self:removeChild(switch)
   
   for i, ct in ipairs(self.switchs) do
       if(switch == ct)then
           table.remove(self.switchs, i)  
       end
   end 
end

function Switch:removeSwitchPos(i)
   self:removeChildPos(i)
   table.remove(self.switchs, i)
end

local CompositeNodes = {Context, Switch}

return CompositeNodes