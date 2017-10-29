local NCLElem = require "core/NCLElem"

local MetaData = NCLElem:extends()

MetaData.name = "metadata"

function MetaData:create()
   local metaData = MetaData:new()  
   return metaData
end

return MetaData