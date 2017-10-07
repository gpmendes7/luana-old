function isEmptyOrNil(v)
    if(v == nil or v  == "")then
       return true
    else   
       return false
    end
end

function isNotString(v)
    if(type(v) ~= "string")then
       return true
    else   
       return false
    end
end

function isInvalidString(v)
   if(isEmptyOrNil(v) or isNotString(v))then
       return true
    else   
       return false
    end
end