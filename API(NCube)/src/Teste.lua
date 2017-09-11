function isArray(tbl)
    local numKeys = 0
    for _, _ in pairs(tbl) do
        numKeys = numKeys+1
    end
    local numIndices = 0
    for _, _ in ipairs(tbl) do
        numIndices = numIndices+1
    end
    return numKeys == numIndices
end

print(isArray({"casa", "morango"}))
print(isArray({{t= "2"}, ["21"] = 2}))