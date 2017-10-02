function isEmptyOrNil(v)
    if(v == nil or v  == "")then
       print("function isEmptyOrNil - Empty or nil value!")
       return true
    else   
       return false
    end
end

function isNotString(v)
    if(type(v) ~= "string")then
       print("function isNotString - Invalid string!")
       return true
    else   
       return false
    end
end

function isInvalidString(v)
   if(isEmptyOrNil(v) or isNotString(v))then
       print("function isInvalidString - Is not a valid string!")
       return true
    else   
       return false
    end
end