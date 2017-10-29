<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="locAgencia"  xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">  

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
	 ## LOCALIZAR AGENCIA: Arquivo NCL que é declarado como contexto no programa prncipal, responsável por 
	 ## mostrar as telas da opção "Localizar Agência" do menu principal. 
	 #################################################################################### -->

<!-- ## Cabeçalho ## -->		
<head>
	<!-- ## Bases de descritores e conectores. Definições encontradas nos arquivos referidos. -->			
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
	<context id="mainlocAgencia">
			<!-- ## Mídias que iniciarão quando o arquivo for disparado --> 	
			<port id="portaUsoLocaliza" component="usoLocaliza" />

			<!-- ## Declarações de Mídia --> 
			<media id="usoLocaliza"	type="image/png" src="imagens/usolocaliza.png"     descriptor="des#descritorUsoControle" >
				<property name="encerra2"/>
			</media>
			
			<media id="luaLocaliza" type="application/x-ginga-NCLua" src="lua/LocalizarAgencia/LocalizarAgencia.lua" descriptor="des#descritorLuaLocaliza"  >
				<property name="encerra"/>
			</media>
			
	   		<media type="application/x-ginga-settings" id="settings">
		   		<property name="service.currentKeyMaster" />
				<property name="service.currentFocus" />
				<property name="channel.keyCapture" value="false" />
			</media>	
			
			<!-- ## Elos ## --> 
			
			<!-- Ao Iniciar a mídia "usoLocaliza", iniciar "luaLocaliza". --> 
			<link xconnector="con#aoIniciarIniciar" >
				<bind role="onBegin" component="usoLocaliza" />
				<bind role="start"	 component="luaLocaliza" />
			</link>

			<!-- ## Transfere o foco e o controle do teclado para o foco "jxLua". -->									
		   	<link xconnector="con#aoIniciarSetar">
   				<bind component="luaLocaliza" role="onBegin" />

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

			<!-- ## Ao terminar atribuição da propriedade "encerra" (setada no lua), parar as mídias utilizadas nesse contexto. -->							
			<link xconnector="con#aoTerminarAtribuicaoParar">
		  		<bind role="onEndAttribution" component="luaLocaliza" interface="encerra"/>
   		    		<bind component="usoLocaliza" 	role="stop" />
		    		<bind component="luaLocaliza" 	role="stop" />
    		</link> 
    		
    		<link xconnector="con#aoTerminarAtribuicaoParar">
		  		<bind role="onEndAttribution" component="usoLocaliza" interface="encerra2"/>
   		    		<bind component="usoLocaliza" 	role="stop" />
		    		<bind component="luaLocaliza" 	role="stop" />
    		</link>

			<!-- ## Na seleção do botão VERMELHO enquanto o componente "usoLocaliza" estiver na tela, parar todas as mídias utilizadas nesse contexto. -->			
			<link xconnector="con#naSelecaoDeTeclaParar" >
				<bind role="onSelection" component="usoLocaliza" > 
					<bindParam name="tecla" value="RED" />
				</bind>	
				
				<bind role="stop" component="usoLocaliza" />
				<bind role="stop" component="luaLocaliza" />
			</link>
	</context>
</body>
</ncl>