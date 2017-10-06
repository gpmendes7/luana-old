require "valid/Validator"

local function test1()
   assert(isEmptyOrNil(), "Error!")
   assert(isEmptyOrNil(nil), "Error!")
   assert(isEmptyOrNil(""), "Error!")
end

local function test2()
   assert(not(isNotString("ncl")), "Error!")
   assert(isNotString(true), "Error!")
   assert(isNotString(10), "Error!")
   assert(isNotString(4.5), "Error!")
   assert(isNotString(test1), "Error!")
end

local function test3()
   assert(isInvalidString(), "Error!")
   assert(isInvalidString(nil), "Error!")
   assert(isInvalidString(""), "Error!")
   assert(not(isInvalidString("ncl")), "Error!")
   assert(isInvalidString(true), "Error!")
   assert(isInvalidString(10), "Error!")
   assert(isInvalidString(4.5), "Error!")
   assert(isInvalidString(test1), "Error!")
end


test1()
test2()
test3()