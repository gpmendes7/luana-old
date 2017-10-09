local NCLElem = require "core/NCLElem"

local ImportNCL = NCLElem:extends()

ImportNCL.name = "importNCL"

function ImportNCL:create(attributes)
   local importNCL = ImportNCL:new()
   
   importNCL.attributes = { 
    ["alias"] = "",
    ["documentURI"] = ""
   }
   
   if(attributes ~= nil)then
      importNCL:setAttributes(attributes)
   end
   
   return importNCL
end

function ImportNCL:setAlias(alias)
    self:addAttribute("alias", alias)
end

function ImportNCL:getAlias()
   return self:getAttribute("alias")
end

function ImportNCL:setDocumentURI(documentURI)
    self:addAttribute("documentURI", documentURI)
end

function ImportNCL:getDocumentURI()
   return self:getAttribute("documentURI")
end

return ImportNCL