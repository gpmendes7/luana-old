<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="exemplo5" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<regionBase>
			<region id="rgTela" width="100%" height="100%">
				<region id="rgBotao1" left="10%" top="30%" width="10%" height="10%" />
		    	<region id="rgCarro1" left="5%"  top="50%" width="20%" height="30%" />
		    	
		    	<region id="rgBotao2" left="35%" top="30%" width="10%" height="10%" />
		    	<region id="rgCarro2" left="30%" top="50%" width="20%" height="30%" />
		    	
		    	<region id="rgBotao3" left="60%" top="30%" width="10%" height="10%" />
		    	<region id="rgCarro3" left="55%" top="50%" width="20%" height="30%" />
		    </region>	
		</regionBase>

        <descriptorBase>
        	  <descriptor id="dBotao1" region="rgBotao1" />
              <descriptor id="dCarro1" region="rgCarro1">
              	 <descriptorParam name="visible" value="true" />
              </descriptor>  
                
              <descriptor id="dBotao2" region="rgBotao2" />            	
              <descriptor id="dCarro2" region="rgCarro2">
              	 <descriptorParam name="visible" value="false" />
              </descriptor>
              	
              <descriptor id="dBotao3" region="rgBotao3" />	
              <descriptor id="dCarro3" region="rgCarro3">
              	  <descriptorParam name="visible" value="false" />
              </descriptor>
              	
        </descriptorBase>
        
        <connectorBase>
	      <causalConnector id="onKeySelectionSetN">
	         <connectorParam name="keyCode" />
	         <connectorParam name="valueSet"/>
	         <simpleCondition role="onSelection" key="$keyCode" />
	         <simpleAction role="set" value="$valueSet" max="unbounded" qualifier="par"/>
	      </causalConnector>
      </connectorBase>
	</head>

	<body>
		 <port id="pBotao1" component="botao1" />
		 <media id="botao1" type="image/png" src="media/botao1.png" descriptor="dBotao1" />	
		 
		 <port id="pCarro1" component="carro1" />	  
		 <media id="carro1" type="image/png" src="media/carro1.png" descriptor="dCarro1">
		 	 <property name="visible"/>
		 </media>
		 	
		 <port id="pBotao2" component="botao2" />
		 <media id="botao2" type="image/png" src="media/botao2.png" descriptor="dBotao2" />
		 	
		 <port id="pCarro2" component="carro2" />		  
		 <media id="carro2" type="image/png" src="media/carro2.png" descriptor="dCarro2">
               <property name="visible"/>
		 </media>
		 	
         <port id="pBotao3" component="botao3" />
		 <media id="botao3" type="image/png" src="media/botao3.png" descriptor="dBotao3" />
		 	
		 <port id="pCarro3" component="carro3" />		  
		 <media id="carro3" type="image/png" src="media/carro3.png" descriptor="dCarro3">
               <property name="visible"/>
		 </media>
		 
		 <link id="lSelecionaBotao1" xconnector="onKeySelectionSetN">
		 	 <bind component="botao1" role="onSelection">
			 	<bindParam name="keyCode" value="RED"/>
			 </bind>
		 	 <bind component="carro1" interface="visible" role="set">
			    <bindParam name="valueSet" value="true"/>
			 </bind>	
		 	 <bind component="carro2" interface="visible" role="set">
			    <bindParam name="valueSet" value="false"/>
			 </bind>	
			  <bind component="carro3" interface="visible" role="set">
			    <bindParam name="valueSet" value="false"/>
			 </bind>
		 </link>
		 
		 <link id="lSelecionaBotao2" xconnector="onKeySelectionSetN">
		 	 <bind component="botao2" role="onSelection">
			 	<bindParam name="keyCode" value="GREEN"/>
			 </bind>
		 	 <bind component="carro2" interface="visible" role="set">
			    <bindParam name="valueSet" value="true"/>
			 </bind>	
		 	 <bind component="carro1" interface="visible" role="set">
			    <bindParam name="valueSet" value="false"/>
			 </bind>	
			  <bind component="carro3" interface="visible" role="set">
			    <bindParam name="valueSet" value="false"/>
			 </bind>
		 </link>
		 
		  <link id="lSelecionaBotao3" xconnector="onKeySelectionSetN">
		 	 <bind component="botao3" role="onSelection">
			 	<bindParam name="keyCode" value="YELLOW"/>
			 </bind>
		 	 <bind component="carro3" interface="visible" role="set">
			    <bindParam name="valueSet" value="true"/>
			 </bind>	
		 	 <bind component="carro1" interface="visible" role="set">
			    <bindParam name="valueSet" value="false"/>
			 </bind>	
			  <bind component="carro2" interface="visible" role="set">
			    <bindParam name="valueSet" value="false"/>
			 </bind>
		 </link>
	</body>
</ncl>