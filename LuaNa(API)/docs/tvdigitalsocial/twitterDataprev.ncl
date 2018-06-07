<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="twiDataprev" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">

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
	 ## TWITTER DATAPREV: Arquivo NCL que é declarado como contexto no programa prncipal, responsável por 
	 ## mostrar a tela de "Twitter Dataprev" do menu "Novidades Twitter". 
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
	<context id="maintwiDataprev">
	<!-- ## Mídias que iniciarão quando o arquivo for disparado --> 
	<port id="portaTwitUrl"    		   component="twitUrl"    		  />
	<port id="portaTwitFundo1" 		   component="twitFundo1" 		  />
	<port id="portaTwitFundo2" 		   component="twitFundo2" 		  />
	<port id="portaLuaTwitDataprev"    component="luaTwitDataprev"    />
	<port id="portaUsoTwitter" 		   component="usoTwitter" 		  />

	<!-- ## Declarações de Mídia --> 	
	<media id="twitUrl"	   		type="image/png" 				 src="imagens/twitUrl.png"	  	  descriptor="des#descritorTwitUrl" 	/>
	<media id="twitFundo1" 		type="image/png" 				 src="imagens/twitFundo.png"  	  descriptor="des#descritorTwitFundo1"  />
	<media id="twitFundo2" 		type="image/png" 				 src="imagens/twitFundo2.png"  	  descriptor="des#descritorTwitFundo2"  />
	<media id="usoTwitter" 		type="image/png" 				 src="imagens/usotwitter.png" 	  descriptor="des#descritorUsoControle" />
	<media id="luaTwitDataprev" type="application/x-ginga-NCLua" src="lua/Twitter/Dataprev.lua"  descriptor="des#descritorLuaTwitter"   >	
		<property name="valor"/>
	</media>

	<!-- ## Na seleção do botão VERMELHO enquanto o componente "usoTwitter" estiver na tela, parar todas as mídias utilizadas nesse contexto. -->
	<link xconnector="con#naSelecaoDeTeclaParar" >
		<bind role="onSelection" component="usoTwitter" > 
			<bindParam name="tecla" value="RED" />
		</bind>	
				
	    <bind component="twitUrl" 	 	  role="stop" />		
	    <bind component="twitFundo1" 	  role="stop" />
	    <bind component="twitFundo2" 	  role="stop" />
	    <bind component="usoTwitter" 	  role="stop" />
	    <bind component="luaTwitDataprev" role="stop" />
	</link>
	</context>
</body>
</ncl>