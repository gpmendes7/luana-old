<?xml version= "1.0" encoding="ISO-8859-1"?>
<ncl id="doc" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
 <head>
  <regionBase>
   <region id="rgTV" width="100%" height="100%">
    <region id="rgTitulo1" left="25%" width="50%" top="5%" height="15%"/>
    <region id="rgVideo1" left="25%" width="50%" top="25%" height="50%"/>
   </region>
  </regionBase>
  <descriptorBase>
   <descriptor region="rgTitulo1" id="dTitulo1">
    <descriptorParam name="scroll" value="none"/>
    <descriptorParam name="soundLevel" value="1"/>
   </descriptor>
   <descriptor region="rgVideo1" id="dVideo1"/>
  </descriptorBase>
  <connectorBase>
   <causalConnector id="onBeginStart">
    <simpleCondition role="onBegin"/>
    <simpleAction role="start"/>
   </causalConnector>
   <causalConnector id="onEndStop">
    <simpleCondition role="onEnd"/>
    <simpleAction role="stop"/>
   </causalConnector>
  </connectorBase>
 </head>
 <body>
  <port id="pInicio" component="video1"/>
  <media src="test/createDocument/media/ginga.html" id="titulo1" descriptor="dTitulo1" type="text/html"/>
  <media src="test/createDocument/media/abertura.mpg" id="video1" descriptor="dVideo1" type="video/mpeg"/>
  <link id="lVideo1Titulo1Stop" xconnector="onEndStop">
   <bind component="video1" role="onEnd"/>
   <bind component="titulo1" role="stop"/>
  </link>
  <link id="lVideo1Titulo1Start" xconnector="onBeginStart">
   <bind component="video1" role="onBegin"/>
   <bind component="titulo1" role="start"/>
  </link>
 </body>
</ncl>
