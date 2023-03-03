local Validator = require "LuaNa(API)/src/valid/Validator"

local function test1()
   assert(Validator:isEmptyOrNil(), "Error!")
   assert(Validator:isEmptyOrNil(nil), "Error!")
   assert(Validator:isEmptyOrNil(""), "Error!")
end

local function test2()
   assert(not(Validator:isNotString("ncl")), "Error!")
   assert(Validator:isNotString(true), "Error!")
   assert(Validator:isNotString(10), "Error!")
   assert(Validator:isNotString(4.5), "Error!")
   assert(Validator:isNotString(test1), "Error!")
end

local function test3()
   assert(Validator:isInvalidString(), "Error!")
   assert(Validator:isInvalidString(nil), "Error!")
   assert(Validator:isInvalidString(""), "Error!")
   assert(not(Validator:isInvalidString("ncl")), "Error!")
   assert(Validator:isInvalidString(true), "Error!")
   assert(Validator:isInvalidString(10), "Error!")
   assert(Validator:isInvalidString(4.5), "Error!")
   assert(Validator:isInvalidString(test1), "Error!")
end

local function test4()
  assert(Validator:isBlank(nil), "Error!")
  assert(Validator:isBlank(""), "Error!")
  assert(Validator:isBlank("         "), "Error!")
end

test1()
test2()
test3()
test4()

print("Without error!")