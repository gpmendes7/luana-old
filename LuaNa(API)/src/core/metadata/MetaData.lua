local NCLElem = require "LuaNa(API)/src/core/NCLElem"

---
-- Implements MetaData Class representing <b>&lt;metaData&gt;</b> element.
-- 
-- Implemented based on: <a href="http://handbook.ncl.org.br/doku.php?id=metadata">
-- http://handbook.ncl.org.br/doku.php?id=metadata</a>
-- 
-- @module MetaData
-- 
-- @extends #NCLElement
-- 
-- @author Gabriel Pereira Mendes
-- 
-- @usage 
-- -- The module needs to be imported to be used with the instruction
-- local MetaData = require "core/metadata/MetaData"
local MetaData = NCLElem:extends()

---
-- Name of <b>&lt;metaData&gt;</b> element.
-- 
-- @field [parent=#MetaData] #string nameElem
MetaData.nameElem = "metadata"

---
-- Returns a new MetaData object. 
-- 
-- @function [parent=#MetaData] create
-- @return #MetaData new MetaData object created.
function MetaData:create()
   local metaData = MetaData:new()  
   
   metaData.rdfTree = nil
   
   return metaData
end

---
-- Sets a value to `rdfTree` attribute of the 
-- <b>&lt;metaData&gt;</b> element. 
-- 
-- @function [parent=#MetaData] setRdfTree
-- @param #string rdfTree `rdfTree` attribute of the
-- <b>&lt;metaData&gt;</b> element.
function MetaData:setRdfTree(rdfTree)
    self.rdfTree = rdfTree
end

---
-- Returns the value of the `rdfTree` attribute of the 
-- <b>&lt;metaData&gt;</b> element. 
-- 
-- @function [parent=#MetaData] getRdfTree
-- @return #string `rdfTree` attribute of the <b>&lt;metaData&gt;</b> element.
function MetaData:getRdfTree()
    return self.rdfTree
end

return MetaData