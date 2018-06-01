---
-- Module short description.
-- Module _long description_
--
-- @module modulename
local M = {}
 
---
-- Field description
--
-- @field [parent=#modulename] #string fieldname 
M.fieldname = 'field value'
 
---
-- Function short description.
-- Function long description
--
-- @function [parent=#modulename] functionname
-- @param #number n Parameter description
-- @return #number Typed return description
-- @return #nil, #string Traditional nil and error message
function M.functionname(n)
  if n then return n else return nil, "error" end
end
return M