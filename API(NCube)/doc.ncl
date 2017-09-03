<?xml version= "1.0" encoding="ISO-8859-1"?>
<ncl id="doc" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
 <head>
  <regionBase id="rb1" device="rbTV">
   <region height="100%" id="rg1" width="100%"/>
   <region height="100%" id="rg2" width="100%"/>
  </regionBase>
  <descriptorBase>
   <descriptor id="d1" region="rg1"/>
   <descriptor id="d2" region="rg2"/>
  </descriptorBase>
 </head>
 <body>
  <port id="p1" component="m1"/>
  <media id="m1" src="media/media1.mpg" descriptor="d1" type="video/mpeg"/>
  
  <port id="p2" component="m2"/>
  <media id="m2" src="media/media2.mpg" descriptor="d2" type="video/mpeg"/>
 </body>
</ncl>
