local Class = require "oo/Class"
local Validator = require "valid/Validator"

local NCLElem = Class:createClass{
  name = nil,
  parent = nil,
  children = nil,
  childrenMap = nil,
  assMap = nil,
  attributes = nil,
  attributesTypeMap = nil,
  attributesStringValueMap = nil,
  symbols = nil,
  attributesSymbolMap = nil,
  ncl = nil
}

NCLElem.indetityAttributes = { "id", "name", "alias", "var" }

function NCLElem:extends()
  return Class:createClass(NCLElem)
end

function NCLElem:getNameElem()
  return self.name
end

function NCLElem:setParent(parent)
  self.parent = parent
end

function NCLElem:getParent()
  return self.parent
end

function NCLElem:addChild(child, p)
  if(child == nil)then
    error("Error! Attempt to set a nil child to "..self.name.."!", 2)
  end

  local valid = false

  for chd, _ in pairs(self.childrenMap) do
    if(chd == child.name)then
      valid = true
    end
  end

  if(not(valid))then
    error("Error! Attempt to set a invalid child! "..child.name.." cannot be child of "..self.name.."!", 2)
  end

  if(p ~= nil)then
    table.insert(self.children, p, child)
  else
    table.insert(self.children, child)
  end

  child:setParent(self)
end

function NCLElem:getChild(p)
  if(p > #self.children)then
    error("Error! "..self.name.." element doesn't have a child in position "..p.."!", 2)
  end

  return self.children[p]
end

function NCLElem:getPosChild(child)
  for p, chd in ipairs(self.children) do
    if(chd == child)then
      return p
    end
  end

  return nil
end

function NCLElem:getLastPosChild(child)
  local p

  for i, chd in ipairs(self.children) do
    if(child == chd.name)then
      p = i
    end
  end

  return p
end

function NCLElem:getPosAvailable(...)
  for _, elem in ipairs(arg) do
    local p = self:getLastPosChild(elem)
    if(p ~= nil)then
      return p + 1
    end
  end
end

function NCLElem:removeChildPos(p)
  if(p > #self.children)then
    error("Error! Attempt to remove failed! "..self.name.." element doesn't have a child in position "..p.."!", 2)
  end

  self:getChild(p):setParent(nil)
  table.remove(self.children, p)
end

function NCLElem:removeChild(child)
  if(child == nil)then
    error("Error! Attempt to remove failed! You are trying to remove a nil child in "..self.name.."!", 2)
  end

  local p = self:getPosChild(child)

  if(p == nil)then
    error("Error! Attempt to remove failed! "..self.name.." element doesn't have this child!", 2)
  end

  self:removeChildPos(p)
end

function NCLElem:setChildren(...)
  if(#arg > 0)then
    for _, child in ipairs(arg) do
      self:addChild(child)
    end
  end
end

function NCLElem:getChildren()
  return self.children
end

function NCLElem:removeAllChildren()
  for _, child in ipairs(self.children) do
    child:setParent(nil)
  end

  self.children = {}
end

function NCLElem:getChildrenMap()
  return self.childrenMap
end

function NCLElem:getAssMap()
  return self.assMap
end

function NCLElem:getDescendants()
  local descendants = {}

  local children = self.children

  if(children ~= nil)then
    local nchildren = #children

    local descs = nil

    for i=1,nchildren do
      local child = self.children[i]
      table.insert(descendants, child)

      descs = child:getDescendants()
      for _, desc in ipairs(descs) do
        table.insert(descendants, desc)
      end
    end
  end

  return descendants
end

function NCLElem:getDescendantByAttribute(attribute, value)
  local descs = self:getDescendants()
  local targetDescs = {}

  for _, desc in ipairs(descs) do
    if(desc:getAttribute(attribute) == value)then
      table.insert(targetDescs, desc)
    end
  end

  if(#targetDescs == 1)then
    return targetDescs[1]
  elseif(#targetDescs > 2)then
    return targetDescs
  end

  return nil
end

function NCLElem:addAttribute(attribute, value)
  if(self.attributesTypeMap[attribute] == nil or Validator:isInvalidString(attribute))then
    error("Error! "..attribute.." attribute is not a valid attribute to "..self.name.." element!", 2)
  elseif(Validator:isEmptyOrNil(value))then
    error("Error! Invalid value to "..attribute.." attribute of "..self.name.." element! Value must be informed!", 2)
  elseif(self.attributesTypeMap[attribute] ~= type(value))then
    error("Error! "..attribute.." attribute is not valid to "..self.name.." element! "..
      "The type of "..attribute.." attribute of "..self.name.." element must be a "..self.attributesTypeMap[attribute].." "..
      "and not a "..type(value).."!", 2)
  elseif(self.attributesValuesMap ~= nil and self.attributesValuesMap[attribute] ~= nil)then
    local isInvalid = true

    for i, v in ipairs(self.attributesValuesMap[attribute]) do
      if(v == value)then
        isInvalid = false
        break
      end
    end

    if(isInvalid)then
      error("Error! The value "..value.." is not valid to  "..attribute.." attribute in "..self.name.." element!", 2)
    end
  else
    self[attribute] = value
  end
end

function NCLElem:removeAttribute(attribute)
  if(Validator:isEmptyOrNil(attribute))then
    error("Error! Empty or nil attribute is not a valid attribute to "..self.name.." element!", 2)
  elseif(Validator:isInvalidString(attribute))then
    error("Error! "..attribute.." attribute is not a valid attribute to "..self.name.." element!", 2)
  elseif(self.attributesTypeMap[attribute] == nil)then
    error("Error! "..attribute.." attribute is not a valid attribute to "..self.name.." element!", 2)
  else
    self[attribute] = nil
  end
end

function NCLElem:getAttribute(attribute)
  if(Validator:isEmptyOrNil(attribute))then
    error("Error! Empty or nil attribute is not a valid attribute to "..self.name.." element!", 2)
  elseif(Validator:isInvalidString(attribute))then
    error("Error! "..attribute.." attribute is not a valid attribute to "..self.name.." element!", 2)
  elseif(self.attributesTypeMap[attribute] == nil)then
    error("Error! "..attribute.." attribute is not a valid attribute to "..self.name.." element!", 2)
  else
    return self[attribute]
  end
end

function NCLElem:getAttributesTypeMap()
  return self.attributesTypeMap
end

function NCLElem:getAttributesStringValueMap()
  return self.attributesStringValueMap
end

function NCLElem:isNilAttributes(attributes)
  for _, _ in pairs(attributes) do
    return false
  end

  return true
end

function NCLElem:setAttributes(attributes)
  if(self:isNilAttributes(attributes))then
    error("Error! Attributes must be informed to be defined!", 2)
  end

  for attribute, value in pairs(attributes) do
    self:addAttribute(attribute, value)
  end
end

function NCLElem:getAttributes()
  return self.attributes
end

function NCLElem:readAttributes()
  local s, e, t, u, r, v, w, z

  _, s = string.find(self.ncl, "<"..self.name.." ")
  _, t = string.find(self.ncl, "<"..self.name..">")
  e = string.find(self.ncl, ">")

  if(s ~= nil and t == nil and e ~= nil)then
    local attributes = string.sub(self.ncl,s,e-1)

    u, r = string.find(attributes, "%S+=")

    while (u ~= nil and r ~= nil) do
      local attribute = string.sub(attributes, u, r-1)
      v, w = string.find(attributes, "\"", u+1)
      z = string.find(attributes, "\"", w+1)

      local value = string.sub(attributes, v+1,z-1)

      self:addAttribute(attribute, value)

      attributes = string.sub(attributes, z+1, string.len(attributes))
      u, r = string.find(attributes, "%S+=")
    end
  end
end

function NCLElem:readChildrenNcl()
  local s, t, u

  s = string.find(self.ncl,">")
  t = string.sub(self.ncl, 1, s)
  u = string.find(t,"/>")

  local childrenNcl

  if(u == nil)then
    local _, n = string.gsub(self.ncl, "</"..self.name..">", "*")
    local e, v, w

    if(n > 1)then
      childrenNcl = self.ncl
      w, v = 0

      repeat
        e, v = string.find(self.ncl, "</"..self.name..">", v)
        w = w + 1
      until w == n
    else
      e, v = string.find(self.ncl, "</"..self.name..">")
    end

    childrenNcl = string.sub(self.ncl, s+1, e-1)
  end

  return childrenNcl
end

function NCLElem:readChildNcl(childrenNcl, childName)
  local s = string.find(childrenNcl, "<")
  local e = string.find(childrenNcl, ">")
  local t, u

  local aux1 = string.sub(childrenNcl, s, e)

  if(string.find(aux1,"/>") ~= nil)then
    return aux1, e
  else
    t, u = string.find(childrenNcl, "</"..childName..">")

    while(1)do
      aux1 = string.sub(childrenNcl, s, u)

      local aux2, n1 = string.gsub(aux1, "<"..childName..">", "opening_tag")

      local aux3 = aux1
      local n2 = 0
      local r, z = string.find(aux3, "<"..childName.." ")

      while(r ~= nil and z ~= nil)do
        local y = string.find(aux3, ">", z)
        local aux4 = string.sub(aux3,r,y)

        if(string.find(aux4, "/>") == nil)then
          n2 = n2 + 1
        end

        r, z = string.find(aux3, "<"..childName.." ", y)
      end

      local nopening = n1 + n2
      local aux2, nclosing = string.gsub(aux1, "</"..childName..">", "closing_tag")

      if(nopening == nclosing)then
        local p = 1

        for i = 1,nclosing do
          _, p = string.find(childrenNcl , "</"..childName..">", p)
          p = p + 1
        end

        return string.sub(childrenNcl, s, p), p
      end

      t, u = string.find(childrenNcl, "</"..childName..">", u)
    end
  end
end

function NCLElem:ncl2Table()
  local s, e

  if(self:getNameElem() == "metadata")then
    local _, s = string.find(self:getNcl(), "<metadata>")
    local e = string.find(self:getNcl(), "</metadata>")
    self:setRdfTree(string.sub(self:getNcl(), s+1, e-1))
    return
  end

  self:readAttributes()

  local childrenNcl = self:readChildrenNcl()
  if(childrenNcl ~= nil)then
    repeat
      s, e = string.find(childrenNcl, "<%a+")

      if(s ~= nil and e ~= nil)then

        local childName = string.sub(childrenNcl, s+1, e)
        local childNcl, h = self:readChildNcl(childrenNcl, childName)

        if(childNcl ~= nil)then
          if(self.childrenMap ~= nil)then
            local map = self.childrenMap[childName]

            if(map ~= nil)then
              local childClass = map[1]
              local childObject = childClass:create()

              childObject:setNcl(childNcl)
              childObject:ncl2Table()
              self:addChild(childObject)

              local cardinality = map[2]

              if(cardinality == "many")then
                if(self[childName..'s'] == nil)then
                  self[childName..'s'] = {}
                end

                table.insert(self[childName.."s"], childObject)
              elseif(cardinality == "one")then
                self[childName] = childObject
              end
            end
          end
        end

        if(h ~= nil)then
          childrenNcl = string.sub(childrenNcl, h+1, string.len(childrenNcl))
        end
      end

    until (string.find(childrenNcl, "%a") == nil)
  end
end

function NCLElem:table2Ncl(deep)
  local ncl = ""

  if(deep == 0 and self.name == "ncl")then
    if(self:getXmlHead() ~= nil and self:getXmlHead() ~= "")then
      ncl = ncl..self:getXmlHead().."\n"
      ncl = ncl.."<!--Generated by NCube-->\n"
    end
  else
    for i=1,deep do
      ncl = ncl.." "
    end
  end

  if(self.name == "metadata")then
    ncl = ncl.."<metadata>\n"

    if(self:getRdfTree() ~= nil and self:getRdfTree() ~= "")then
      ncl = ncl..self:getRdfTree()
    end

    for i=1,deep do
      ncl = ncl.." "
    end

    return ncl.."</metadata>\n"
  end

  ncl = ncl.."<"..self.name

  for attribute, typeAtt in pairs(self.attributesTypeMap) do
    if(self[attribute] ~= nil
      and self.attributesTypeMap[attribute] == type(typeAtt))then
      ncl = ncl.." "..attribute.."=".."\""..self[attribute].."\""
    end
  end

  local children = self.children

  if(children ~= nil)then
    local nchildren = #children

    if(nchildren == 0)then
      return ncl.."/>\n"
    end

    if(children ~= nil)then
      ncl = ncl..">\n"
      for i=1,nchildren do
        local child = self.children[i]
        ncl = ncl..child:table2Ncl(deep+1)
      end

      for i=1,deep do
        ncl = ncl.." "
      end
    end
  else
    return ncl.."/>\n"
  end

  return ncl.."</"..self.name..">\n"
end

function NCLElem:setNcl(ncl)
  self.ncl = ncl
end

function NCLElem:getNcl()
  return self.ncl
end

function NCLElem:writeNcl()
  print(self:table2Ncl(0))
end

return NCLElem
