local NCLElem = require("LuaNa(API)/src/core/NCLElem")
local Validator = require("LuaNa(API)/src/valid/Validator")
local Head = require("LuaNa(API)/src/core/content/Head")
local Body = require("LuaNa(API)/src/core/content/Body")

---
-- Implements Document Class representing <b>&lt;ncl&gt;</b> element. 
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=ncl">
-- http://handbook.ncl.org.br/doku.php?id=ncl</a>
-- 
-- @module Document
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local Document = require "core/content/Document"
-- 
-- -- Now, the object will be created passing the list of attributes
-- -- with id attribute, the xml header and the flag equals to 1.
-- -- This way, the object doc will be created with children objects
-- -- additioned from each children classes.
-- local doc = Document:create({id = "document1", 
--                              xmlns = "http://www.ncl.org.br/NCL3.0/EDTVProfile"},
--                             "<?xml version= \"1.0\" encoding=\"ISO-8859-1\"?>", 1)
--  
-- -- We can also define create the object, define the attributes 
-- -- or children in another likeway  
-- local doc = Document:create()
-- doc:setId("document1")
-- doc:setXmlns("http://www.ncl.org.br/NCL3.0/EDTVProfile")
-- doc:setXmlHead("<?xml version= \"1.0\" encoding=\"ISO-8859-1\"?>")   
-- doc:setHead(Head:create())
-- doc:setBody(Body:create())      
--   
-- -- To load a document we use loadNcl method 
-- -- local doc = Document:create()
-- doc:loadNcl("document.ncl")    
-- 
-- -- To save a document we use saveNcl method
-- local doc = Document:create()
-- 
-- -- other instructions here...
-- doc:saveNcl("document.ncl")                                           
local Document = NCLElem:extends()

---
-- Name of <b>&lt;ncl&gt;</b> element.
-- @field [parent=#Document] #string nameElem  
Document.nameElem = "ncl"

---
-- List with maps to associate classes representing
-- children elements from <b>&lt;ncl&gt;</b> element.
-- 
-- @field [parent=#Document] #table childrenMap  
Document.childrenMap = {
  head = {Head, "one"},
  body = {Body, "one"}
}

---
-- List containing the data types of each attribute
-- belonging to <b>&lt;ncl&gt;</b> element.
-- 
-- @field [parent=#Document] #table attributesTypeMap  
Document.attributesTypeMap = {
  id = "string",
  title = "string",
  xmlns = "string",
  ["xmlns:xsi"] = "string",
  ["xsi:schemaLocation"] = "string"
}

---
-- Returns a new Document object. 
-- If `full` flag is not nil, the object will
-- receive default children objects of each children class.
-- 
-- This case, `full` must be passed to the method with a valid number.  
-- 
-- @function [parent=#Document] create
-- @param #table attributes list of attributes to be initialized.
-- @param #string xmlHead xml header of the document.
-- @param #number full numeric flag to indicate if the object 
--                will be created with filled children list.
-- @return #Document new Document object created.
function Document:create(attributes, xmlHead, full)
  local xmlHead = xmlHead or nil
  local document = Document:new()

  document.id = nil
  document.title = nil
  document.xmlns = nil
  document["xmlns:xsi"] = nil
  document["xsi:schemaLocation"] = nil

  if(attributes ~= nil)then
    document:setAttributes(attributes)
  end

  document.children = {}

  if(xmlHead ~= nil)then
    document:setXmlHead(xmlHead)
  end

  if(full ~= nil)then
    document:setHead(Head:create(full))
    document:setBody(Body:create(nil, full))
  end

  return document
end

---
-- Sets a value to `id` attribute of the <b>&lt;ncl&gt;</b> element. 
-- @function [parent=#Document] setId
-- @param #string id `id` attribute of the <b>&lt;ncl&gt;</b> element.
function Document:setId(id)
  self:addAttribute("id", id)
end

---
-- Returns the value of the `id` attribute of the <b>&lt;ncl&gt;</b> element. 
-- @function [parent=#Document] getId
-- @return #string `id` attribute of the <b>&lt;ncl&gt;</b> element.
function Document:getId()
  return self:getAttribute("id")
end

---
-- Sets a value to `title` attribute of the <b>&lt;ncl&gt;</b> element. 
-- @function [parent=#Document] setTitle
-- @param #string title `title` attribute of the <b>&lt;ncl&gt;</b> element.
function Document:setTitle(title)
  self:addAttribute("title", title)
end

---
-- Returns the value of the `title` attribute of the <b>&lt;ncl&gt;</b> element. 
-- @function [parent=#Document] getTitle
-- @return #string `title` attribute of the <b>&lt;ncl&gt;</b> element.
function Document:getTitle()
  return self:getAttribute("title")
end

---
-- Sets a value to `xmlns` attribute of the <b>&lt;ncl&gt;</b> element. 
-- @function [parent=#Document] setXmlns
-- @param #string xmlns ´xmlns´ attribute of the <b>&lt;ncl&gt;</b> element.
function Document:setXmlns(xmlns)
  self:addAttribute("xmlns", xmlns)
end

---
-- Returns the value of the `xmlns` attribute of the <b>&lt;ncl&gt;</b> element. 
-- @function [parent=#Document] getXmlns
-- @return #string `xmlns` attribute of the <b>&lt;ncl&gt;</b> element.
function Document:getXmlns()
  return self:getAttribute("xmlns")
end

---
-- Sets a value to `xsi` attribute of the <b>&lt;ncl&gt;</b> element. 
-- @function [parent=#Document] setXsi
-- @param #string xsi `xsi` attribute of the <b>&lt;ncl&gt;</b> element.
function Document:setXsi(xsi)
  self:addAttribute("xmlns:xsi", xsi)
end

---
-- Returns the value of the `xsi` attribute of the <b>&lt;ncl&gt;</b> element. 
-- @function [parent=#Document] getXsi
-- @return #string `xsi` attribute of the <b>&lt;ncl&gt;</b> element.
function Document:getXsi()
  return self:getAttribute("xmlns:xsi")
end

---
-- Sets a value to `schemaLocation` attribute of the <b>&lt;ncl&gt;</b> element. 
-- @function [parent=#Document] setSchemaLocation
-- @param #string schemaLocation `schemaLocation` attribute of the <b>&lt;ncl&gt;</b> element.
function Document:setSchemaLocation(schemaLocation)
  self:addAttribute("xsi:schemaLocation", schemaLocation)
end

---
-- Returns the value of the `schemaLocation` attribute of the <b>&lt;ncl&gt;</b> element. 
-- @function [parent=#Document] getSchemaLocation
-- @return #string `schemaLocation` attribute of the <b>&lt;ncl&gt;</b> element.
function Document:getSchemaLocation()
  return self:getAttribute("xsi:schemaLocation")
end

---
-- Sets a value to xml header of the document file.
-- @function [parent=#Document] setXmlHead
-- @param #string xmlHead xml header of the document file.
function Document:setXmlHead(xmlHead)
  if(Validator:isInvalidString(xmlHead))then
    error("Error! Invalid xml head to ncl element! It must be a valid string!", 2)
  end
  self.xmlHead = xmlHead
end

---
-- Returns the value of the xml header of the document file. 
-- @function [parent=#Document] getXmlHead
-- @param #string xml header of the document file.
function Document:getXmlHead()
  return self.xmlHead
end

---
-- Sets the child <b>&lt;head&gt;</b> element of the <b>&lt;ncl&gt;</b> element. 
-- @function [parent=#Document] setHead
-- @param #Head head object representing the <b>&lt;head&gt;</b> element.
function Document:setHead(head)
  if((type(head) == "table"
    and head["getNameElem"] ~= nil
    and head:getNameElem() ~= "head")
    or (type(head) == "table"
    and head["getNameElem"] == nil)
    or type(head) ~= "table")then
    error("Error! Invalid head element!", 2)
  end

  if(self.head == nil)then
    self:addChild(head, 1)
  else
    local p = self:getPosAvailable("head") - 1
    self:removeChildPos(p)
    self:addChild(head, p)
  end

  self.head = head
end

---
-- Returns the <b>&lt;head&gt;</b> child element of the <b>&lt;ncl&gt;</b> element. 
-- @function [parent=#Document] getHead
-- @return #Head head object representing the <b>&lt;head&gt;</b> element.
function Document:getHead()
  return self.head
end

---
-- Removes the <b>&lt;head&gt;</b> child element of the <b>&lt;ncl&gt;</b> element. 
-- @function [parent=#Document] removeHead
function Document:removeHead()
  self:removeChild(self.head)
  self.head = nil
end

---
-- Sets the child <b>&lt;body&gt;</b> element of the <b>&lt;ncl&gt;</b> element. 
-- @function [parent=#Document] setBody
-- @param #Body body object representing the <b>&lt;body&gt;</b> element.
function Document:setBody(body)
  if((type(body) == "table"
    and body["getNameElem"] ~= nil
    and body:getNameElem() ~= "body")
    or (type(body) == "table"
    and body["getNameElem"] == nil)
    or type(body) ~= "table")then
    error("Error! Invalid body element!", 2)
  end

  local p

  if(self.body == nil)then
    p = self:getPosAvailable("head")
    if(p ~= nil)then
      self:addChild(body, p)
    else
      self:addChild(body, 1)
    end
  else
    p = self:getPosAvailable("body") - 1
    self:removeChildPos(p)
    self:addChild(body, p)
  end
  self.body = body
end

---
-- Returns the <b>&lt;body&gt;</b> child element of the <b>&lt;ncl&gt;</b> element. 
-- @function [parent=#Document] getBody
-- @return #Body body object representing the <b>&lt;body&gt;</b> element.
function Document:getBody()
  return self.body
end

---
-- Removes the <b>&lt;body&gt;</b> child element of the <b>&lt;ncl&gt;</b> element. 
-- @function [parent=#Document] removeBody
function Document:removeBody()
  self:removeChild(self.body)
  self.body = nil
end

---
-- Saves a document in extern file.
-- All children elements added to the current document
-- are, step by step, translated into the corresponding ncl format.
-- @function [parent=#Document] saveNcl
-- @param #string name name of the extern file where the document will be save.
function Document:saveNcl(name)
  local ncl = self:table2Ncl(0)
  local file = io.open(name, "w")
  file:write(ncl)
  file:close()
end

function Document:removeComments(ncl)
  local _, nopen = string.gsub(ncl, "<!%-%-", "")
  local _, nclosed = string.gsub(ncl, "%-%->", "")

  if(nopen ~= nclosed)then
    error("Error! Document with invalid syntax!", 2)
  end

  local t = string.find(ncl,"<!%-%-")
  local _, u = string.find(ncl,"%-%->")

  if(t == nil and u == nil)then
    return ncl
  end

  local v = string.find(ncl,"<!%-%-", t+1)
  local x = string.find(ncl,"%-%->", u+1)

  if((u < t) or (v ~= nil and v < u) or (x ~= nil and x < v))then
    error("Error! Document with invalid syntax!", 2)
  end

  local newNcl = ncl

  while(1)do
    local aux1 = string.sub(newNcl, 1, t-1)
    local aux2 = string.sub(newNcl, u+1, string.len(newNcl))
    newNcl = aux1..aux2

    t = string.find(newNcl,"<!%-%-")
    _, u = string.find(newNcl,"%-%->")

    if(t == nil and u == nil)then
      break
    end

    v = string.find(newNcl,"<!%-%-", t+1)
    x = string.find(newNcl,"%-%->", u+1)

    if((u < t) or (v ~= nil and v < u) or (x ~= nil and x < v))then
      error("Error! Document with invalid syntax!", 2)
    end
  end

  return newNcl
end

function Document:readNclFile(name)
  local ncl
  local isXmlHead = true

  local file = io.open(name, "r")

  if(file ~= nil)then
    io.input(file)

    ncl = ""

    for line in io.lines() do
      if(isXmlHead and string.find(line, "<?xml") ~= nil)then
        self:setXmlHead(line)
        isXmlHead = false
      elseif(isXmlHead and string.find(line, "<?xml") == nil)then
        error("Error! File "..name.." is a invalid NCL document! The file must have an XML header!", 2)
      else
        ncl = ncl..line.."\n"
      end
    end

    file:close()

    if(ncl == "")then
      error("Error! File "..name.." is a invalid NCL document! Empty file!", 2)
    end

    ncl = self:removeComments(ncl)
  else
    error("Error! File "..name.." does not exist!", 2)
  end

  return ncl
end

function Document:connectAssociatedElements()
  local descendants = self:getDescendants()

  if(descendants ~= nil)then
    for _, descendant in ipairs(descendants) do
      if(descendant.assMap ~= nil)then
        for _, ass in ipairs(descendant:getAssMap()) do
          local attribute = descendant:getAttribute(ass[1])

          if(attribute ~= nil and string.match(attribute, "#") == nil)then
            local objAss = ass[2]

            descendant[objAss] = self:getDescendantByAttribute("id", attribute)

            if(descendant[objAss] == nil and descendant.component ~= nil)then
              local component = self:getDescendantByAttribute("id", descendant.component)

              if(component ~= nil)then
                local interface = component:getInterface(descendant.interface)

                if(interface == nil and component.referAss ~= nil)then
                  interface = component.referAss:getInterface(descendant.interface)
                end

                if(interface == nil)then
                  error("Error! Unknown "..descendant.interface.." interface associated to "..descendant.nameElem.." element!" , 2)
                else
                  descendant[objAss] = interface
                end
              else
                error("Error! Unknown "..descendant.component.." component associated to "..descendant.nameElem.." element!" , 2)
              end
            elseif(descendant[objAss] == nil and descendant.component == nil)then
              error("Error! Unknown element with id "..attribute.." associated to "..descendant.nameElem.." element!" , 2)
            end

            if(descendant[objAss] ~=nil)then
              table.insert(descendant[objAss].ass, descendant)
            end
          end
        end
      end
    end
  end
end

---
-- Loads a document from an extern file.
-- All children elements present in the file 
-- are, step by step, translated into the corresponding objects.
-- 
-- Each object will have a parent and can have a list of children.
-- 
-- The hierarchy is also kept between the objects created.
-- @function [parent=#Document] loadNcl
-- @param #string name name of the extern file where the document will be load.
function Document:loadNcl(name)
  local ncl = self:readNclFile(name)

  if(ncl == nil)then
    error("Error! File "..name.." couldn't be read! Invalid NCL document!", 2)
  else
    local s = string.find(ncl, "<ncl ")
    local t = string.find(ncl, ">", s)
    local u = string.sub(ncl, 1, t)
    local v = string.find(u, "id=")
    local x = string.find(ncl, "</ncl>")

    if(s == nil or v == nil or x == nil)then
      error("Error! Document with invalid syntax!", 2)
    else
      self:setNcl(ncl)
      self:ncl2Table()
      self:connectAssociatedElements()
    end
  end
end

return Document