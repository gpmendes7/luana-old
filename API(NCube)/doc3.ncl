<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="exemplo7" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>		
		 <regionBase>
		    <region id="rgTela" width="100%" height="100%">
		    	 <region id="rgScript" />
		    </region>		    	
		 </regionBase> 
		 
		 <descriptorBase>
		 	<descriptor id="dScript" region="rgScript" />
		 </descriptorBase>
		 
		 <connectorBase>
			 <causalConnector id="onKeySelectionSet">
			  <connectorParam name="keyCode" />
			  <connectorParam name="var"/>
			  <simpleCondition role="onSelection" key="$keyCode" />
			  <simpleAction role="set" value="$var"/>	    
		 	 </causalConnector>		 	
		</connectorBase>
	</head>

	<body>
       <port id="pScript" component="script" interface="desenho"/>
       
       <media id="script" src="script8.lua" descriptor="dScript">
       	 <area id="desenho"/>
		 <property name="somar"/>
		 <area id="exibir"/>
	   </media>
	  
	   <link id="lClica" xconnector="onKeySelectionSet">
		<bind component="script" role="onSelection">
    		<bindParam name="keyCode" value="GREEN" />
    	</bind>
		<bind component="script" interface="somar" role="set" >
			<bindParam name="var" value="1"/>
		</bind>
	   </link>
	  
	</body>
</ncl>