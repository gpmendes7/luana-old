--local s = "15npt"
--local s = "3s"
local s = "3f"
--local s = "true"

validSymbols = {"%%", "s", "f", "npt"}

for _, symbol in ipairs(validSymbols) do
   if(string.match(s, "(%d+)"..symbol))then
      value = string.match(s, "(%d+)")
      print(tonumber(value))
      print(symbol)
   end
end

if(s == "false")then
   print(false)
elseif(s == "true")then
   print(true)
end

