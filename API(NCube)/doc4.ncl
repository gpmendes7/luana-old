<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="exemplo6" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
	    <ruleBase>
		   <rule id="rEn" var="idioma" comparator="eq" value="en" />
		   <rule id="rEs" var="idioma" comparator="eq" value="es" />
		</ruleBase>		
			
	    <regionBase>
	        <region id="rgTela" width="100%" height="100%">	
		         <region id="rgBandeira1" left="30%" bottom="40%" 
		                 width="150" height="150" />		         
		         <region id="rgBandeira2" right="30%" bottom="40%"
		                 width="150" height="150" />		          		                 	     
		      </region>
        </regionBase>
       
        <descriptorBase>
		   <descriptor id="dBandeira1" region="rgBandeira1"  />		   
		   <descriptor id="dBandeira2" region="rgBandeira2" />		 
       </descriptorBase>
       
       <connectorBase>       	        	   
	   <causalConnector id="onKeySelectionSetStopNStart">
	         <connectorParam name="keyCode" />
	         <simpleCondition role="onSelection" key="$keyCode" />
	         <connectorParam name="valueSet"/>
	         <compoundAction operator="seq">
	            <simpleAction role="set" value="$valueSet"/>
	            <simpleAction role="stop" max="unbounded" qualifier="par"/>
	            <simpleAction role="start"/>
	         </compoundAction>
	      </causalConnector>     
       </connectorBase>
	</head>

	<body>
        <media type="application/x-ginga-settings" id="nodeSettings">
		   <property name="idioma" />
		</media>
		 
		 <port id="pBandeira1" component="bandeira1" />
		 <media id="bandeira1" type="image/png" src="media/bandeira1.png" descriptor="dBandeira1" />
		
		 <port id="pBandeira2" component="bandeira2" />
		 <media id="bandeira2" type="image/png" src="media/bandeira2.png" descriptor="dBandeira2" />		

		 <context id="contextoTocaAudio">
	         <port id="pDefineAudio" component="defineAudio"/>
	         	         
	         <switch id="defineAudio">
	           <bindRule rule="rEn" constituent="audio1" />
		       <bindRule rule="rEs" constituent="audio2" />
		
		       <media type="audio/mp3" id="audio1"
		             src="media/audioEn.mp3" />
		       <media type="audio/mp3" id="audio2"
		             src="media/audioEs.mp3" />		             
             </switch>	
         </context>
    				
       <link id="lSelecionaIngles" xconnector="onKeySelectionSetStopNStart">
       	   <bind component="bandeira1" role="onSelection">
			 	<bindParam name="keyCode" value="RED"/>
		   </bind>
		   <bind component="nodeSettings" interface="idioma" role="set">
		      <bindParam name="valueSet" value="en" />
		   </bind>
	       <bind component="bandeira2" role="stop" />
	       <bind component="contextoTocaAudio" interface="pDefineAudio" role="start" />
       </link>
       
       <link id="lSelecionaEspanhol" xconnector="onKeySelectionSetStopNStart">
		   <bind component="bandeira2" role="onSelection">
			 	<bindParam name="keyCode" value="GREEN"/>
		   </bind>
		   <bind component="nodeSettings" interface="idioma" role="set">
		      <bindParam name="valueSet" value="es" />
		   </bind>
	       <bind component="bandeira1" role="stop" />
	       <bind component="contextoTocaAudio" interface="pDefineAudio" role="start" />
       </link>  
	</body>
</ncl>