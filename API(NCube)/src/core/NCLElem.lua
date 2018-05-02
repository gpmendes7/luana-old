local Class = require "oo/Class"
local Validator = require "valid/Validator"

local NCLElem = Class:createClass{
  nameElem = nil,
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

NCLElem.indetityAttributes = {"id", "name", "alias", "var"}

function NCLElem:extends()
  return Class:createClass(NCLElem)
end

function NCLElem:getNameElem()
  return self.nameElem
end

function NCLElem:setParent(parent)
  self.parent = parent
end

function NCLElem:getParent()
  return self.parent
end

function NCLElem:addChild(child, p)
  if(child == nil)then
    error("Error! Attempt to set a nil child to "..self.nameElem.."!", 2)
  end

  local valid = false

  for chd, _ in pairs(self.childrenMap) do
    if(chd == child.nameElem)then
      valid = true
    end
  end

  if(not(valid))then
    error("Error! Attempt to set a invalid child! "..child.nameElem.." cannot be child of "..self.nameElem.."!", 2)
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
    error("Error! "..self.nameElem.." element doesn't have a child in position "..p.."!", 2)
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
    if(child == chd.nameElem)then
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
    error("Error! Attempt to remove failed! "..self.nameElem.." element doesn't have a child in position "..p.."!", 2)
  end

  self:getChild(p):setParent(nil)
  table.remove(self.children, p)
end

function NCLElem:removeChild(child)
  if(child == nil)then
    error("Error! Attempt to remove failed! You are trying to remove a nil child in "..self.nameElem.."!", 2)
  end

  local p = self:getPosChild(child)

  if(p == nil)then
    error("Error! Attempt to remove failed! "..self.nameElem.." element doesn't have this child!", 2)
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
    if(desc.attributesTypeMap ~= nil and desc.attributesTypeMap[attribute] ~= nil
      and desc:getAttribute(attribute) == value)then
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

function NCLElem:getInterface(interface)
  local descs = self:getDescendants()

  for _, desc in ipairs(descs) do
    if(desc.name ~= nil and desc.name == interface)then
      return desc
    end
  end

  return nil
end

function NCLElem:isValidAttributeType(attribute, value)
  local isValid = false

  if(self.attributesTypeMap ~= nil
    and type(self.attributesTypeMap[attribute]) == "table")then
    for _, typeAtt in ipairs(self.attributesTypeMap[attribute]) do
      if(typeAtt == type(value))then
        isValid = true
        break
      end
    end
  elseif(self.attributesTypeMap ~= nil
    and self.attributesTypeMap[attribute] == type(value))then
    isValid = true
  elseif(type(value) == "string"
    and self.attributesStringValueMap ~= nil
    and self.attributesStringValueMap[attribute] ~= nil)then

    for _, val in ipairs(self.attributesStringValueMap[attribute]) do
      if(val == value)then
        isValid = true
        break
      end
    end
  end

  return isValid
end

function NCLElem:addAttribute(attribute, value)
  if((self.attributesTypeMap ~= nil and self.attributesTypeMap[attribute] == nil)
    or Validator:isInvalidString(attribute))then
    error("Error! "..attribute.." attribute is not a valid attribute to "..self.nameElem.." element!", 2)
  elseif(not self:isValidAttributeType(attribute, value))then
    error("Error! Type of "..attribute.." attribute is not valid to "..self.nameElem.." element!", 2)
  else
    self[attribute] = value
  end
end

function NCLElem:removeAttribute(attribute)
  if(Validator:isEmptyOrNil(attribute))then
    error("Error! Empty or nil attribute is not a valid attribute to "..self.nameElem.." element!", 2)
  elseif(Validator:isInvalidString(attribute))then
    error("Error! "..attribute.." attribute is not a valid attribute to "..self.nameElem.." element!", 2)
  elseif(self.attributesTypeMap ~= nil and self.attributesTypeMap[attribute] == nil)then
    error("Error! "..attribute.." attribute is not a valid attribute to "..self.nameElem.." element!", 2)
  else
    self[attribute] = nil
  end
end

function NCLElem:getAttribute(attribute)
  if(Validator:isEmptyOrNil(attribute))then
    error("Error! Empty or nil attribute is not a valid attribute to "..self.nameElem.." element!", 2)
  elseif(Validator:isInvalidString(attribute))then
    error("Error! "..attribute.." attribute is not a valid attribute to "..self.nameElem.." element!", 2)
  elseif(self.attributesTypeMap ~= nil and self.attributesTypeMap[attribute] == nil)then
    error("Error! "..attribute.." attribute is not a valid attribute to "..self.nameElem.." element!", 2)
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

function NCLElem:addSymbol(attribute, symbol)
  local isValid = false

  if(type(self.attributesSymbolMap[attribute]) == "table")then
    for _, sb in pairs(self.attributesSymbolMap[attribute])do
      if(symbol == sb)then
        self.symbols[attribute] = symbol
        break
      end
    end
  else
    isValid = symbol == self.attributesSymbolMap[attribute]
  end

  if(not isValid)then
    error("Error! "..attribute.." attribute cannot have "..symbol.." character in "..self.nameElem.."!")
  end
end

function NCLElem:getAttributeSymbol(attribute, value)
  local sb

  _, sb = string.match(value, "(%d+)(%a+)")
  if(sb == nil and string.match(value, "(%d+)(%%+)") ~= nil)then
    sb = "%"
  end

  local isInvalidSymbol = true

  if(sb ~= nil)then
    if(self.attributesSymbolMap[attribute] == "table")then
      for _, symbol in ipairs(self.attributesSymbolMap[attribute]) do
        if(sb == symbol)then
          isInvalidSymbol = false
          break
        end
      end

    else
      if(self.attributesSymbolMap[attribute] == sb) then
        isInvalidSymbol = false
      end
    end

    if(isInvalidSymbol)then
      error("Error! "..attribute.." attribute cannot have "..sb.." character in "..self.nameElem.." element!", 2)
    end
  end

  return sb
end

function NCLElem:canBeNumber(attribute, value)
  if(type(self.attributesTypeMap[attribute]) == "table")then
    for _, typeAtt in ipairs(self.attributesTypeMap[attribute]) do
      if(typeAtt == "number")then
        return true
      end
    end
  else
    return self.attributesTypeMap[attribute] == "number"
  end

  return false
end

function NCLElem:readAttributes()
  local s, e, t, u, r, v, w, z

  _, s = string.find(self.ncl, "<"..self.nameElem.." ")
  _, t = string.find(self.ncl, "<"..self.nameElem..">")
  e = string.find(self.ncl, ">")

  if(s ~= nil and t == nil and e ~= nil)then
    local attributes = string.sub(self.ncl,s,e-1)

    u, r = string.find(attributes, "%S+=")

    while (u ~= nil and r ~= nil) do
      local attribute = string.sub(attributes, u, r-1)
      v = string.find(attributes, "\"", u+1)
      w = string.find(attributes, "%S+=", v+1)
      z = string.find(attributes, "\"", v+1)

      if(v == nil or z == nil or (w ~= nil and w < z))then
        error("Error! Document with invalid syntax!", 2)
      end

      local value = string.sub(attributes, v+1,z-1)

      if(self.attributesSymbolMap ~= nil and self.attributesSymbolMap[attribute] ~= nil
        and self.symbols ~= nil and string.match(value, ":") == nil)then
        self.symbols[attribute] = self:getAttributeSymbol(attribute, value)
      end

      if(self:canBeNumber(attribute, value) and string.match(value, "(%d+)") ~= nil
        and string.match(value, ":") == nil)then
        value = tonumber(string.match(value, "(%d+)"))
      elseif(self.attributesTypeMap[attribute] == "boolean" and value == "false")then
        value = false
      elseif(self.attributesTypeMap[attribute] == "boolean" and value == "true")then
        value = true
      end

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
    local _, n = string.gsub(self.ncl, "</"..self.nameElem..">", "*")
    local e, v, w

    if(n > 1)then
      childrenNcl = self.ncl
      w, v = 0

      repeat
        e, v = string.find(self.ncl, "</"..self.nameElem..">", v)
        w = w + 1
      until w == n
    else
      e, v = string.find(self.ncl, "</"..self.nameElem..">")
    end

    childrenNcl = string.sub(self.ncl, s+1, e-1)
  end

  return childrenNcl
end

function NCLElem:readChildNcl(childrenNcl, childName)
  local s = string.find(childrenNcl, "<")
  local e = string.find(childrenNcl, ">")

  if(s == nil and e == nil)then
    error("Error! Document with invalid syntax!", 2)
  end

  local t = string.find(childrenNcl, "<", s+1)

  if(t ~= nil and e > t)then
    error("Error! Document with invalid syntax!", 2)
  end

  local aux1 = string.sub(childrenNcl, s, e)

  local v = string.find(aux1,"/>")

  if(v ~= nil)then
    return aux1, e
  else
    local _, u = string.find(childrenNcl, "</"..childName..">")

    if(u == nil)then
      error("Error! Document with invalid syntax!", 2)
    end

    while(1)do
      aux1 = string.sub(childrenNcl, s, u)

      local _, n1 = string.gsub(aux1, "<"..childName..">", "opening_tag")

      local n2 = 0
      local r, z = string.find(aux1, "<"..childName.." ")

      if(n1 == 0 and r == nil and z == nil)then
        error("Error! Document with invalid syntax!", 2)
      end

      while(r ~= nil and z ~= nil)do
        local y = string.find(aux1, ">", z)

        if(y == nil)then
          error("Error! Document with invalid syntax!", 2)
        end

        local aux2 = string.sub(aux1, r, y)

        if(string.find(aux2, "/>") == nil)then
          n2 = n2 + 1
        end

        r, z = string.find(aux1, "<"..childName.." ", y)
      end

      local nopening = n1 + n2
      local _, nclosing = string.gsub(aux1, "</"..childName..">", "closing_tag")

      if(nopening == nclosing)then
        local p = 1

        for i = 1,nclosing do
          _, p = string.find(childrenNcl , "</"..childName..">", p)
          p = p + 1
        end

        return string.sub(childrenNcl, s, p), p
      end

      _, u = string.find(childrenNcl, "</"..childName..">", u)

      if(u == nil)then
        error("Error! Document with invalid syntax!", 2)
      end
    end
  end
end

function NCLElem:ncl2Table()
  local s, e, t, u

  if(self:getNameElem() == "metadata")then
    _, s = string.find(self:getNcl(), "<metadata>")
    e = string.find(self:getNcl(), "</metadata>")

    if(s == nil or e == nil)then
      error("Error! Document with invalid syntax!", 2)
    end

    self:setRdfTree(string.sub(self:getNcl(), s+1, e-1))
    return
  end

  self:readAttributes()

  local childrenNcl = self:readChildrenNcl()
  if(childrenNcl ~= nil)then
    repeat
      t = string.find(childrenNcl, ">")
      u = string.sub(childrenNcl, 1, t)
      s, e = string.find(u, "<%a+")

      if(s == nil and e == nil)then
        error("Error! Document with invalid syntax!", 2)
      else
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
            else
              error("Error! Document with invalid syntax!", 2)
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

  if(deep == 0 and self.nameElem == "ncl")then
    if(self:getXmlHead() ~= nil and self:getXmlHead() ~= "")then
      ncl = ncl..self:getXmlHead().."\n".."<!--Generated by NCube-->\n"
    end
  else
    for i=1,deep do
      ncl = ncl.." "
    end
  end

  if(self.nameElem == "metadata")then
    ncl = ncl.."<metadata>\n"

    if(self:getRdfTree() ~= nil and self:getRdfTree() ~= "")then
      ncl = ncl..self:getRdfTree()
    end

    for i=1,deep do
      ncl = ncl.." "
    end

    return ncl.."</metadata>\n"
  end

  ncl = ncl.."<"..self.nameElem

  if(self.attributesTypeMap ~= nil)then
    for attribute, typeAtt in pairs(self.attributesTypeMap) do
      if(self[attribute] ~= nil)then
        if(type(typeAtt) ~= "table")then
          if(typeAtt == "number" and self.symbols ~= nil
            and self.symbols[attribute] ~= nil)then
            ncl = ncl.." "..attribute.."=".."\""..self[attribute]..self.symbols[attribute].."\""
          else
            ncl = ncl.." "..attribute.."=".."\""..self[attribute].."\""
          end
        elseif(type(typeAtt) == "table")then
          for _, tp in ipairs(typeAtt) do
            if(tp == "number" and self.symbols ~= nil
              and self.symbols[attribute] ~= nil
              and type(self[attribute] == "number"))then
              ncl = ncl.." "..attribute.."=".."\""..self[attribute]..self.symbols[attribute].."\""
              break
            elseif(type(self[attribute]) == tp)then
              ncl = ncl.." "..attribute.."=".."\""..self[attribute].."\""
              break
            end
          end
        end
      end
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

  if(self.nameElem == "ncl")then
    return ncl.."</"..self.nameElem..">"
  else
    return ncl.."</"..self.nameElem..">\n"
  end
end

function NCLElem:setNcl(ncl)
  self.ncl = ncl
end

function NCLElem:getNcl()
  return self.ncl
end

function NCLElem:buildNcl()
  self.ncl = self:table2Ncl(0)
end

function NCLElem:writeNcl()
  self:buildNcl()
  print(self.ncl)
end

return NCLElem