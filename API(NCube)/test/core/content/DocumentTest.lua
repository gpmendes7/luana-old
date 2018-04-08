local Document = require "core/content/Document"
local Head = require "core/content/Head"
local Body = require "core/content/Body"

local function test1()
   local document;
   
   document = Document:create();
   assert(document ~= nil, "Error!");
   assert(document:getId() == nil, "Error!");
   assert(document:getTitle() == nil, "Error!");
   assert(document:getXmlns() == nil, "Error!");
   assert(document:getXsi() == nil, "Error!");
   assert(document:getSchemaLocation() == nil, "Error!");
   assert(document:getXmlHead() == nil, "Error!");
end

local function test2()
   local document, atts;
   
   local status, err;
   
   atts = {
      ["id"] = "document",
      ["title"] = "title",
      ["xmlns"] = "xmlns",
      ["xmlns:xsi"] = "xsi",
      ["xsi:schemaLocation"] = "schema"
   };     
   
   document = Document:create(atts, "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>");
   assert(document:getId() == "document", "Error!");
   assert(document:getTitle() == "title", "Error!");
   assert(document:getXmlns() == "xmlns", "Error!");
   assert(document:getXsi() == "xsi", "Error!");
   assert(document:getSchemaLocation() == "schema", "Error!");
   assert(document:getXmlHead() == "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>", "Error!");
   
   atts = {
      ["id"] = 1.2,
      ["title"] = {},
      ["xmlns"] = function() return a end,
      ["xmlns:xsi"] = 45.5,
      ["xsi:schemaLocation"] = {"a", "b", "c"}
   };     
  
   status, err = pcall(Document["create"], Document, atts, 55.2);
   assert(not(status), "Error!");
end

local function test3()
   local document;
   
   local status, err;
      
   document = Document:create();
   
   document:setId("document");
   document:setTitle("title");
   document:setXmlns("xmlns");
   document:setXsi("xsi");
   document:setSchemaLocation("schema");
   document:setXmlHead("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>", "Error!");

   assert(document:getId() == "document", "Error!");
   assert(document:getTitle() == "title", "Error!");
   assert(document:getXmlns() == "xmlns", "Error!");
   assert(document:getXsi() == "xsi", "Error!");
   assert(document:getSchemaLocation() == "schema", "Error!");
   assert(document:getXmlHead() == "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>", "Error!");
   
   document = Document:create();
     
   status, err = pcall(document["setId"], document, 1.2);
   assert(not(status), "Error!");

   status, err = pcall(document["setTitle"], document, {});
   assert(not(status), "Error!");
                 
   status, err = pcall(document["setXmlns"], document, function() return a end);
   assert(not(status), "Error!");
                 
   status, err = pcall(document["setXsi"], document, 45.5);
   assert(not(status), "Error!");
                 
   status, err = pcall(document["setSchemaLocation"], document, {"a", "b", "c"});
   assert(not(status), "Error!");
                 
   status, err = pcall(document["setXmlHead"], document, 55.2);
   assert(not(status), "Error!");
end

local function test4()
   local document1, document2, n1, n2 = nil;
      
   document1 = Document:create(nil, nil, 1);
   assert(document1:getHead() ~= nil, "Error!");
   assert(document1:getBody() ~= nil, "Error!");
   
   document2 = Document:create();
   
   document2:setHead(Head:create());
   assert(document2:getHead() ~= nil, "Error!");
   
   document2:setBody(Body:create());
   assert(document2:getBody() ~= nil, "Error!");
   
   n1 = #document1:getDescendants();
   document1:setHead(Head:create());
   document1:setBody(Body:create());
   n2 = #document1:getDescendants();
   assert(n1 > n2, "Error!");
end

local function test5()
   local document = Document:create();
   local head = Head:create();
   local body = Body:create();
   
   document:setHead(head);
   document:setBody(body);

   document:removeHead(head);
   assert(document:getHead() == nil, "Error!");
   
   document:removeBody(body);
   assert(document:getBody() == nil, "Error!");
end

local function test6()
   local document = nil;
   
   local nclExp, nclRet, atts = nil;
   
   atts = {
      ["id"] = "document",
      ["title"] = "title",
      ["xmlns"] = "xmlns",
      ["xmlns:xsi"] = "xsi",
      ["xsi:schemaLocation"] = "schema"
   };       
      
   document = Document:create(atts);
   
   nclExp = "<ncl";   
   for attribute, typeAtt in pairs(document:getAttributesMap()) do
      nclExp = nclExp.." "..attribute.."=\""..document[attribute].."\"";
   end 
   
   nclExp = nclExp.."/>\n";

   nclRet = document:table2Ncl(0);

   assert(nclExp == nclRet, "Error!");
end

test1();
test2();
test3();
test4();
test5();
test6();