local Validator = require "valid/Validator"
local NCLElem = require "core/NCLElem"
local Head = require "core/content/Head"
local Body = require "core/content/Body"

local Document = NCLElem:extends()

Document.nameElem = "ncl"

Document.childrenMap = {
  head = {Head, "one"},
  body = {Body, "one"}
}

Document.attributesTypeMap = {
  id = "string",
  title = "string",
  xmlns = "string",
  ["xmlns:xsi"] = "string",
  ["xsi:schemaLocation"] = "string"
}

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

function Document:setId(id)
  self:addAttribute("id", id)
end

function Document:getId()
  return self:getAttribute("id")
end

function Document:setTitle(title)
  self:addAttribute("title", title)
end

function Document:getTitle()
  return self:getAttribute("title")
end

function Document:setXmlns(xmlns)
  self:addAttribute("xmlns", xmlns)
end

function Document:getXmlns()
  return self:getAttribute("xmlns")
end

function Document:setXsi(xsi)
  self:addAttribute("xmlns:xsi", xsi)
end

function Document:getXsi()
  return self:getAttribute("xmlns:xsi")
end

function Document:setSchemaLocation(schemaLocation)
  self:addAttribute("xsi:schemaLocation", schemaLocation)
end

function Document:getSchemaLocation()
  return self:getAttribute("xsi:schemaLocation")
end

function Document:setXmlHead(xmlHead)
  if(Validator:isInvalidString(xmlHead))then
    error("Error! Invalid xml head to ncl element! It must be a valid string!", 2)
  end
  self.xmlHead = xmlHead
end

function Document:getXmlHead()
  return self.xmlHead
end

function Document:setHead(head)
  if(self.head == nil)then
    self:addChild(head, 1)
  else
    local p = self:getPosAvailable("head") - 1
    self:removeChildPos(p)
    self:addChild(head, p)
  end

  self.head = head
end

function Document:getHead()
  return self.head
end

function Document:removeHead(head)
  self:removeChild(head)
  self.head = nil
end

function Document:setBody(body)
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

function Document:getBody()
  return self.body
end

function Document:removeBody(body)
  self:removeChild(body)
  self.body = nil
end

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
    error("Error! NCL document is badly formatted! Syntax error!")
  end

  local t = string.find(ncl,"<!%-%-")
  local _, u = string.find(ncl,"%-%->")

  if(t == nil and u == nil)then
    return ncl
  end

  local v = string.find(ncl,"<!%-%-", t+1)
  local x = string.find(ncl,"%-%->", u+1)

  if((u < t) or (v ~= nil and v < u) or (x ~= nil and x < v))then
    error("Error! NCL document is badly formatted! Syntax error!")
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
      error("Error! NCL document is badly formatted! Syntax error!1")
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
        error("Error! File "..name.." is a invalid NCL document! The file must have an XML header!")
      else
        ncl = ncl..line.."\n"
      end
    end

    file:close()

    if(ncl == "")then
      error("Error! File "..name.." is a invalid NCL document! Empty file!")
    end

    ncl = self:removeComments(ncl)
  else
    error("Error! File "..name.." does not exist!")
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
                local interface

                if(component.referAss ~= nil)then
                  interface = component.referAss:getInterface(descendant.interface)
                else
                  interface = component:getInterface(descendant.interface)
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

function Document:loadNcl(name)
  local ncl = self:readNclFile(name)

  if(ncl == nil)then
    error("Error! File "..name.." couldn't be read! Invalid NCL document!")
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
