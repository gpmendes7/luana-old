<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="exemplo2" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>		
		 <regionBase>
		    <region id="rgTela" width="100%" height="100%">
		    	<region id="rgLogo" left="25%" top="5%" width="50%" height="30%" zIndex="2" />
		    	<region id="rgTrailer" left="25%" top="25%" width="50%" height="50%" zIndex="1" />
		    </region>		    	
		 </regionBase> 
		 
		 <descriptorBase>
		 	<descriptor id="dLogo" region="rgLogo" />
		 	<descriptor id="dTrailer" region="rgTrailer" />
		 </descriptorBase>
		 
		 <connectorBase>
		 	 <causalConnector id="onBeginStart">
			 	<simpleCondition role="onBegin" />
			 	<simpleAction role="start" />
			 </causalConnector>
			 
			 <causalConnector id="onEndStop">
			 	<simpleCondition role="onEnd" />
			 	<simpleAction role="stop" />
			 </causalConnector>
		 </connectorBase>
	</head>

	<body>
        <port id="pTrailer" component="trailer" />
        
        <media id="trailer" type="video/mpeg" src="media/homem_aranha.mpg" descriptor="dTrailer" />
        			
        <media id="logo" type="image/png" src="media/homem_aranha_logo.png" descriptor="dLogo" />
        
        <link id="lLogoStart" xconnector="onBeginStart">
        	<bind role="onBegin" component="trailer" />
        	<bind role="start" component="logo" />
        </link>
        
        <link id="lLogoStop" xconnector="onEndStop">
        	<bind role="onEnd" component="trailer" />
        	<bind role="stop" component="logo" />
        </link>
	</body>
</ncl>