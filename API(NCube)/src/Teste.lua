function readDelay(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end

local rDelay = readDelay("12:45:3.31", ":")
local hours, minutes, seconds_fractions = rDelay[1], rDelay[2], rDelay[3] 

print(hours)
print(minutes)
print(seconds_fractions)

seconds_fractions = readDelay(seconds_fractions, ".")
local seconds, fractions = seconds_fractions[1], seconds_fractions[2]

print(seconds)
print(fractions)

print(2.45==math.floor(2.45))