require("core/NCube")

local doc = Document:create()

doc:loadNcl("test/createDocument/docs/document4.ncl")

local rgVideo1 = doc:getDescendantByAttribute("id", "rgVideo1")

assert(rgVideo1 ~= nil, "Error!")

local nclExp = "<region"   
   for attribute, value in pairs(rgVideo1:getAttributes()) do
      if(value ~= "")then
         nclExp = nclExp.." "..attribute.."=\""..value.."\""
      end
   end 
  
   nclExp = nclExp.."/>\n"

assert(nclExp == rgVideo1:table2Ncl(0), "Error!")

local links = doc:getDescendantByAttribute("xconnector", "connectors#onEndStop")

assert(#links == 3, "Error!")
