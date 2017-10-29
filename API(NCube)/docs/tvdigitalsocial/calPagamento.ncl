<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="calPagamento" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">   

<!-- ####################################################################################
 ! Copyright (C) 2010 DATAPREV - Empresa de Tecnologia e Informações da Previdência Social - Brasil
 !
 ! Este arquivo é parte do programa  TVDS - TV DIGITAL SOCIAL 
 !
 ! O TVDS é um software livre; você pode redistribuí­-lo e/ou modificá-lo dentro dos termos da Licença Pública Geral GNU como 
 ! publicada pela Fundação do Software Livre (FSF); na versão 2 da Licença, ou (na sua opnião) qualquer versão.
 !
 ! Este programa é distribuído na esperança que possa ser útil, mas SEM NENHUMA GARANTIA; sem uma garantia implícita de ADEQUAÇÃO a qualquer
 ! MERCADO ou APLICAÇÃO EM PARTICULAR. Veja a Licença Pública Geral GNU para maiores detalhes.
 !
 ! Você deve ter recebido uma cópia da Licença Pública Geral GNU, sob o título "LICENCA.txt", junto com este programa, se não, escreva para a 
 ! Fundação do Software Livre(FSF) Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA.
 !
-->
<!-- ####################################################################################
	 ## CALENDARIO PAGAMENTO: Arquivo NCL que é declarado como contexto no programa prncipal, 
	 ## responsável por mostrar as telas da opção "Calendario de Pagamento" do menu principal. 
	 #################################################################################### -->


<!-- ## Cabeçalho ## -->		
<head>
	<!-- ## Bases de regiões, descritores e conectores. Definições encontradas nos arquivos referidos. -->		
	<regionBase>
		<importBase alias="reg" documentURI="regioes.ncl" />
	</regionBase>

	<descriptorBase>
		<importBase alias="des" documentURI="descritores.ncl" />
	</descriptorBase>

	<connectorBase>
		<importBase alias="con" documentURI="conectores.ncl" />
	</connectorBase>
</head>

<!-- ## Corpo ## -->	
<body>
	<context id="maincalPagamento">
			<!-- ## Mídia iniciada quando o arquivo é disparado --> 
			<port id="portaUsoCalendarioPagamento" component="usoCalendarioPagamento" />
			
			<!-- ## Declarações de Mídia --> 
			<media id="usoCalendarioPagamento" type="image/png" src="imagens/usocalendario.png" descriptor="des#descritorUsoControle" >
				<property name="encerra2" />
			</media>
			
			<media id="luaCalendarioPagamento" type="application/x-ginga-NCLua" src="lua/CalendarioPagamento/CalendarioPagamento.lua" descriptor="des#descritorLuaLocaliza"     >
				<property name="encerra" />
			</media>
			
	   		<media type="application/x-ginga-settings" id="settings">
		   		<property name="service.currentKeyMaster" />
				<property name="service.currentFocus" />
				<property name="channel.keyCapture" value="false" />
			</media>	

			<!-- ## Elos ## --> 
			
			<!-- Ao Iniciar a mídia "usoCalendarioPagamento", iniciar "luaCalendarioPagamento". --> 
			<link xconnector="con#aoIniciarIniciar" >
				<bind role="onBegin" component="usoCalendarioPagamento" />
				<bind role="start"	 component="luaCalendarioPagamento" />
			</link>


			<!-- Ao Iniciar a mídia "luaCalendarioPagamento", setar o foco e o controle do teclado para o índice "ixLua" (veja "descritores.ncl"). --> 
			<link xconnector="con#aoIniciarSetar">
				<bind component="luaCalendarioPagamento" role="onBegin" />
				<bind component="settings" interface="service.currentFocus" role="set">
	 		   		<bindParam name="var" value="jxLua" />
				</bind>
	  			<bind component="settings" interface="service.currentKeyMaster" role="set">
		   	 		<bindParam name="var" value="jxLua" />
	     		</bind>
	     		<bind component="settings" interface="channel.keyCapture" role="set">
	     				<bindParam name="var" value="true" />
     			</bind>
	    	</link>   

			<!-- APÓS ser sido feita uma atribuição de valor na propriedade "encerra2" da mídia "usoCalendarioPagamento", esta é encerrada, além de
			"luaCalendarioPagamento"). -->	    
		    <link xconnector="con#aoTerminarAtribuicaoParar">
			  	<bind role="onEndAttribution" component="usoCalendarioPagamento" interface="encerra2"/>
		
	   		    <bind component="usoCalendarioPagamento" role="stop" />
   			    <bind component="luaCalendarioPagamento" role="stop" />
					
	    	</link>   

			<!-- APÓS ser sido feita uma atribuição de valor na propriedade "encerra" da mídia "luaCalendarioPagamento", esta é encerrada, além de
			"usoCalendarioPagamento"). -->	    
		    <link xconnector="con#aoTerminarAtribuicaoParar">
			  	<bind role="onEndAttribution" component="luaCalendarioPagamento" interface="encerra"/>
		
	   		    <bind component="usoCalendarioPagamento" role="stop" />
   			    <bind component="luaCalendarioPagamento" role="stop" />
					
	    	</link>   

			<!-- Ao pressionar a tecla VERMELHA, setar valor da propriedade "encerra2" da mídia "usoCalendarioPagamento" para o valor "1". -->	
			<link xconnector="con#naSelecaoDeTeclaSetar" >
				<bind role="onSelection" component="usoCalendarioPagamento" > 
					<bindParam name="tecla" value="RED" />
				</bind>	
			
				<bind role="set" component="usoCalendarioPagamento" interface="encerra2" >
					<bindParam name="var" value="1" />
		        </bind>
			</link>  
	</context>
</body>
</ncl>