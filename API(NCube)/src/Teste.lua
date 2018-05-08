--local ncl = "<!-- --> --> <!--"
--
--local t = string.find(ncl,"<!%-%-")
--local _, u = string.find(ncl,"%-%->")
--
--local v = string.find(ncl,"<!%-%-", t+1)
--local x = string.find(ncl,"%-%->", u+1)
--
--if((u < t) or (v ~= nil and v < u)
--  or (x ~= nil and x < v))then
--  error("Tá errado. Melhor consertar!")
--end

local s = "0.3s"
local sb = string.match(s, "(%a+)")
print(sb)

s = "$"
print(string.match(s, "%$"))

local d = "20:"
print(string.match(d, "(%d+):") == nil)