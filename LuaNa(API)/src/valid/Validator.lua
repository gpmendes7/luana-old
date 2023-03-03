local Validator = {}

function Validator:isEmptyOrNil(v)
    if(v == nil or v  == "")then
       return true
    else   
       return false
    end
end

function Validator:isNotString(v)
    if(type(v) ~= "string")then
       return true
    else   
       return false
    end
end

function Validator:isInvalidString(v)
   if(self:isEmptyOrNil(v) or self:isNotString(v))then
       return true
    else   
       return false
    end
end

function Validator:isBlank(s)
	return s == nil or s:match("%S") == nil
end

return Validator