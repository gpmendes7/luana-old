<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="exemplo4" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>		
		 <regionBase>
		    <region id="rgTela" width="100%" height="100%">
		    	<region id="rgNum" left="35%" top="30%" width="30%" height="30%" />
		    	<region id="rgFogos" left="25%" top="25%" width="60%" height="60%" zIndex="1" />
		    	<region id="rgAnoNovo" left="25%" top="5%" width="30%" height="30%" zIndex="2" />
		    </region>		    	
		 </regionBase> 
		 
		 <descriptorBase>
		 	<descriptor id="dNum" region="rgNum" />
		 	<descriptor id="dFogos" region="rgFogos" />
		 	<descriptor id="dAnoNovo" region="rgAnoNovo" />
		 </descriptorBase>
		 
		 <connectorBase>
		 	 <causalConnector id="onBeginStart">
			 	<simpleCondition role="onBegin" />
			 	<simpleAction role="start" max="unbounded" qualifier="par" />
			 </causalConnector>
			 
			 <causalConnector id="onEndStop">
			 	<simpleCondition role="onEnd" />
			 	<simpleAction role="stop" max="unbounded" qualifier="par" />
			 </causalConnector>
			 
			 <causalConnector id="onEndStart">
			 	<simpleCondition role="onEnd" />
			 	<simpleAction role="start" max="unbounded" qualifier="par" />
			 </causalConnector>
		 </connectorBase>
	</head>

	<body>
        <port id="pContagem" component="contagem" />
        
        <media id="contagem" type="audio/mp3" src="media/contagem.mp3">
        	 <area id="a1" begin="12s" end="13s"/>
        	 <area id="a2" begin="11s" end="12s"/>
        	 <area id="a3" begin="10s" end="11s"/>
        	 <area id="a4" begin="9s" end="10s"/>       
        	 <area id="a5" begin="8s" end="9s"/> 
        	 <area id="a6" begin="7s" end="8s"/>
        	 <area id="a7" begin="6s" end="7s"/>
        	 <area id="a8" begin="5s" end="6s"/>
        	 <area id="a9" begin="3s" end="5s"/>    
        	 <area id="a10" begin="2s" end="3s"/>  	    
        </media>
        
        <media id="um" type="image/png" src="media/um.png" descriptor="dNum" />
       
        <media id="dois" type="image/png" src="media/dois.png" descriptor="dNum" />
        
        <media id="tres" type="image/png" src="media/tres.png" descriptor="dNum" />
        
        <media id="quatro" type="image/png" src="media/quatro.png" descriptor="dNum" />
        
        <media id="cinco" type="image/png" src="media/cinco.png" descriptor="dNum" />
        
        <media id="seis" type="image/png" src="media/seis.png" descriptor="dNum" />
        
        <media id="sete" type="image/png" src="media/sete.png" descriptor="dNum" />
        
        <media id="oito" type="image/png" src="media/oito.png" descriptor="dNum" />
        
        <media id="nove" type="image/png" src="media/nove.png" descriptor="dNum" />
        
        <media id="dez" type="image/png" src="media/dez.png" descriptor="dNum" />
        
        <media id="fogos" type="video/mpeg" src="media/fogos.mpg" descriptor="dFogos" />
        
        <media id="ano_novo" type="image/png" src="media/ano_novo.png" descriptor="dAnoNovo"/>
        
        <link id="lUm_start" xconnector="onBeginStart">
          <bind component="contagem" interface="a1" role="onBegin" />
		   <bind component="um" role="start" />
		</link>

		<link id="lUm_stop" xconnector="onEndStop">
		   <bind component="contagem" interface="a1" role="onEnd" />
		   <bind component="um" role="stop" />
		</link>
		
		<link id="lDois_start" xconnector="onBeginStart">
          <bind component="contagem" interface="a2" role="onBegin" />
		  <bind component="dois" role="start" />
		</link>

		<link id="lDois_stop" xconnector="onEndStop">
		   <bind component="contagem" interface="a2" role="onEnd" />
		   <bind component="dois" role="stop" />
		</link>
		
		<link id="lTres_start" xconnector="onBeginStart">
          <bind component="contagem" interface="a3" role="onBegin" />
		  <bind component="tres" role="start" />
		</link>

		<link id="lTres_stop" xconnector="onEndStop">
		   <bind component="contagem" interface="a3" role="onEnd" />
		   <bind component="tres" role="stop" />
		</link>
		
		<link id="lQuatro_start" xconnector="onBeginStart">
          <bind component="contagem" interface="a4" role="onBegin" />
		  <bind component="quatro" role="start" />
		</link>

		<link id="lQuatro_stop" xconnector="onEndStop">
		   <bind component="contagem" interface="a4" role="onEnd" />
		   <bind component="quatro" role="stop" />
		</link>
		
		<link id="lCinco_start" xconnector="onBeginStart">
          <bind component="contagem" interface="a5" role="onBegin" />
		  <bind component="cinco" role="start" />
		</link>

		<link id="lCinco_stop" xconnector="onEndStop">
		   <bind component="contagem" interface="a5" role="onEnd" />
		   <bind component="cinco" role="stop" />
		</link>
		
		<link id="lSeis_start" xconnector="onBeginStart">
          <bind component="contagem" interface="a6" role="onBegin" />
		  <bind component="seis" role="start" />
		</link>

		<link id="lSeis_stop" xconnector="onEndStop">
		   <bind component="contagem" interface="a6" role="onEnd" />
		   <bind component="seis" role="stop" />
		</link>
		
		<link id="lSete_start" xconnector="onBeginStart">
          <bind component="contagem" interface="a7" role="onBegin" />
		  <bind component="sete" role="start" />
		</link>

		<link id="lSete_stop" xconnector="onEndStop">
		   <bind component="contagem" interface="a7" role="onEnd" />
		   <bind component="sete" role="stop" />
		</link>
		
		<link id="lOito_start" xconnector="onBeginStart">
          <bind component="contagem" interface="a8" role="onBegin" />
		  <bind component="oito" role="start" />
		</link>

		<link id="lOito_stop" xconnector="onEndStop">
		   <bind component="contagem" interface="a8" role="onEnd" />
		   <bind component="oito" role="stop" />
		</link>
		
		<link id="lNove_start" xconnector="onBeginStart">
          <bind component="contagem" interface="a9" role="onBegin" />
		  <bind component="nove" role="start" />
		</link>

		<link id="lNove_stop" xconnector="onEndStop">
		   <bind component="contagem" interface="a9" role="onEnd" />
		   <bind component="nove" role="stop" />
		</link>
		
		<link id="lDez_start" xconnector="onBeginStart">
          <bind component="contagem" interface="a10" role="onBegin" />
		  <bind component="dez" role="start" />
		</link>

		<link id="lDez_stop" xconnector="onEndStop">
		   <bind component="contagem" interface="a10" role="onEnd" />
		   <bind component="dez" role="stop" />
		</link>
		
		<link id="lFogosAnoNovo_start" xconnector="onEndStart">
		   <bind component="contagem" role="onEnd" />
		   <bind component="fogos" role="start" />
		   <bind component="ano_novo" role="start" />
		</link>

	</body>
</ncl>