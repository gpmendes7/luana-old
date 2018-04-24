local NCLElem = require "core/NCLElem"

local MetaData = NCLElem:extends()

MetaData.nameElem = "metadata"

function MetaData:create()
   local metaData = MetaData:new()  
   
   metaData.rdfTree = nil
   
   return metaData
end

function MetaData:setRdfTree(rdfTree)
    self.rdfTree =rdfTree
end

function MetaData:getRdfTree()
    return self.rdfTree
end

return MetaData
