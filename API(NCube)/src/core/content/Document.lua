local Validator = require "valid/Validator";
local NCLElem = require "core/NCLElem";
local Head = require "core/content/Head";
local Body = require "core/content/Body";

local Document = NCLElem:extends();

Document.name = "ncl";

Document.childrenMap = {
 head = {Head, "one"}, 
 body = {Body, "one"}
};

Document.attributesTypeMap = {
  id = "string",
  title = "string",
  ["xmlns"] = "string",
  ["xmlns:xsi"] = "string",
  ["xsi:schemaLocation"] = "string"
};

function Document:create(attributes, xmlHead, full)
    local xmlHead = xmlHead or nil;  
    local document = Document:new();   
     
    document.id = nil;
    document.title = nil;
    document.xmlns = nil;
    document["xmlns:xsi"] = nil;
    document["xsi:schemaLocation"] = nil;
   
   if(attributes ~= nil)then
      document:setAttributes(attributes);
   end
   
   document.children = {};
  
   if(xmlHead ~= nil)then
      document:setXmlHead(xmlHead);
   end
   
   if(full ~= nil)then
      document:setHead(Head:create(full));   
      document:setBody(Body:create(nil, full));
   end

   return document
end

function Document:setId(id)
   self:addAttribute("id", id);
end

function Document:getId()
   return self:getAttribute("id");
end

function Document:setTitle(title)
   self:addAttribute("title", title);
end

function Document:getTitle()
   return self:getAttribute("title");
end

function Document:setXmlns(xmlns)
   self:addAttribute("xmlns", xmlns);
end

function Document:getXmlns()
   return self:getAttribute("xmlns");
end

function Document:setXsi(xsi)
   self:addAttribute("xmlns:xsi", xsi);
end

function Document:getXsi()
   return self:getAttribute("xmlns:xsi");
end

function Document:setSchemaLocation(schemaLocation)
   self:addAttribute("xsi:schemaLocation", schemaLocation);
end

function Document:getSchemaLocation()
   return self:getAttribute("xsi:schemaLocation");
end

function Document:setXmlHead(xmlHead)
   if(Validator:isInvalidString(xmlHead))then
      error("Error! Invalid xml head to ncl element! It must be a valid string!", 2);
   end
      self.xmlHead = xmlHead;  
end

function Document:getXmlHead()
   return self.xmlHead;
end

function Document:setHead(head)      
   if(self.head == nil)then
      self:addChild(head, 1);
   else
       local p = self:getPosAvailable("head") - 1;
       self:removeChildPos(p);
       self:addChild(head, p);
   end
   
   self.head = head;
end

function Document:getHead()
   return self.head;
end

function Document:removeHead(head)
   self:removeChild(head);
   self.head = nil;
end

function Document:setBody(body)   
   local p;
   
   if(self.body == nil)then
      p = self:getPosAvailable("head");          
      if(p ~= nil)then
         self:addChild(body, p);
       else
         self:addChild(body, 1);
      end    
   else
       p = self:getPosAvailable("body") - 1;
       self:removeChildPos(p);
       self:addChild(body, p);
   end
   self.body = body;
end

function Document:getBody()
   return self.body;
end

function Document:removeBody(body)
   self:removeChild(body);
   self.body = nil;
end

function Document:saveNcl(name)
   local ncl = self:table2Ncl(0); 
   local file = io.open(name, "w");       
   file:write(ncl);   
   file:close();
end

function Document:removeComments(ncl)
   local newNcl = ncl;
   
   newNcl = string.gsub(newNcl, "->", "end_comm");
   
   local t = string.find(newNcl,"<!--");
   local _, u = string.find(newNcl,"-end_comm");
    
   if(t == nil and u == nil)then
       return newNcl;
   end
  
   while(1)do
     local aux1 = string.sub(newNcl, 1, t-1);
     local aux2 = string.sub(newNcl, u+1, string.len(newNcl));
     newNcl = aux1..aux2;

     t = string.find(newNcl,"<!--");
     _, u = string.find(newNcl,"-end_comm");
     
     if(t == nil and u == nil)then
        break;
     end
   end
   
   return newNcl;
end

function Document:readNclFile(name)
   local ncl;
   local isXmlHead = true;
   
   local file = io.open(name, "r");
   
   if(file ~= nil)then
      io.input(file);       
      
      ncl = "";
       
      for line in io.lines() do
         if(isXmlHead)then
            self:setXmlHead(line);
            isXmlHead = false;
         else
               ncl = ncl..line.."\n";
         end
      end  
         
      file:close();
     
      ncl = self:removeComments(ncl);
   end
   
   return ncl
end

function Document:connectAssociatedElements()
   local descendants = self:getDescendants();
   
   if(descendants ~= nil)then
       for _, descendant in ipairs(descendants) do
           if(descendant["assMap"] ~= nil)then
              for _, ass in ipairs(descendant:getAssMap()) do
                 local id = descendant:getAttribute(ass[1]);
                                            
                 local field = ass[2];                
                 
                 descendant[field] = self:getDescendantByAttribute("id", id);
              end
           end
       end
   end
end

function Document:loadNcl(name)
   local ncl = self:readNclFile(name);
   
   if(ncl == nil)then
      print("Error! File "..name.." does not exist!");
   else     
     self:setNcl(ncl); 
     self:ncl2Table();
     self:connectAssociatedElements();
   end
end

return Document;