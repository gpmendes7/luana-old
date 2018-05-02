local NCLElem = require "core/NCLElem"

local Meta = NCLElem:extends()

Meta.nameElem = "meta"

Meta.attributesTypeMap = {
  name = "string",
  content = "string"
}

function Meta:create(attributes)
  local meta = Meta:new()

  meta.name = nil
  meta.content = nil

  if(attributes ~= nil)then
    meta:setAttributes(attributes)
  end

  return meta
end

function Meta:setName(name)
  self:addAttribute("name", name)
end

function Meta:getName()
  return self:getAttribute("name")
end

function Meta:setContent(content)
  self:addAttribute("content", content)
end

function Meta:getContent()
  return self:getAttribute("content")
end

return Meta