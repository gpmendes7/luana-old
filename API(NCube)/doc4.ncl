<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="exemplo3" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
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
		 	<causalConnector id="onEndStart">
			 	<simpleCondition role="onEnd" />
			 	<simpleAction role="start" />
		    </causalConnector>	
		    
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
        <port id="pTrailer" component="homem_aranha" />
        
        <media id="homem_aranha" type="video/mpeg" src="media/homem_aranha.mpg" descriptor="dTrailer" />
        
        <media id="planeta_macacos" type="video/mpeg" src="media/planeta_macacos.mpg" descriptor="dTrailer" />
        		
        <media id="logoHomemAranha" type="image/png" src="media/homem_aranha_logo.png" descriptor="dLogo" />
        
        <media id="logoPlanetaMacacos" type="image/png" src="media/planeta_macacos_logo.png" descriptor="dLogo" />
         			
        <link id="lMudaTrailer" xconnector="onEndStart">
        	<bind role="onEnd" component="homem_aranha" />
        	<bind role="start" component="planeta_macacos" />
        </link>
        
        <link id="lAtivaLogoHomemAranha" xconnector="onBeginStart">
        	<bind role="onBegin" component="homem_aranha" />
        	<bind role="start" component="logoHomemAranha" />
        </link>
        
        <link id="lDesativaLogoHomemAranha" xconnector="onEndStop">
        	<bind role="onEnd" component="homem_aranha" />
        	<bind role="stop" component="logoHomemAranha" />
        </link>
        
         <link id="lAtivaLogoPlanetaMacacos" xconnector="onBeginStart">
        	<bind role="onBegin" component="planeta_macacos" />
        	<bind role="start" component="logoPlanetaMacacos" />
        </link>
        
        <link id="lDesativaLogoPlanetaMacacos" xconnector="onEndStop">
        	<bind role="onEnd" component="planeta_macacos" />
        	<bind role="stop" component="logoPlanetaMacacos" />
        </link>
	</body>
</ncl>