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

local function soma(...)
   print(type(arg[1]))
  local soma = 0
  for _, n  in ipairs(arg) do
      print(type(n))
      soma = soma + n 
  end
  return soma
end

print(soma("2"))

local s = "0.3s"
local sb = string.match(s, "(%a+)")
print(sb)

s = "$"
print(string.match(s, "%$"))

local d = "20:"
print(string.match(d, "(%d+):") == nil)

function isNilOrEmptyTable(attributes)
  if(attributes == nil)then
    return true
  end
  
  for _, _ in pairs(attributes) do
    return false
  end

  return true
end

local t = {}
print(getmetatable(t))