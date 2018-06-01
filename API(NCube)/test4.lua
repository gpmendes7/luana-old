---
-- A simple addressbook module
--
-- @module addressbook
-- @list <#contact>
local M = {}
 
--- @type contact
-- @field #string name Contact full name
-- @field #number phone Contact landline
 
function M.empty()
  return M[1] == nil
end
 
function M:add(name,phonenumber)
  table.insert(self,{name = name, phone = phonenumber})
end
 
---
-- @return #contact
-- @return nil, errormsg
function M:find(name)
  for _, contact in pairs(self) do
    if (contact.name == name) then
      return contact
    end
  end
  return nil, string.format("No contact found under the name %s", name)
end
 
return M