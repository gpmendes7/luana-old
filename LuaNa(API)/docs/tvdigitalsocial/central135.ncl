<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="cen135" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">

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
	 ## CENTRAL 135: Arquivo NCL que é declarado como contexto no programa prncipal, responsável por 
	 ## mostrar as telas da opção "Informações Central 135" do menu principal. 
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
	<context id="maincen135">
			<!-- ## Mídias que iniciarão quando o arquivo for disparado --> 	
			<port id="portaC135Main" 	  component="c135Main"   />
			<port id="portaC135Barra1"    component="c135Barra1" />
			<port id="portaC135Barra2" 	  component="c135Barra2" />
			<port id="portaC135Barra3" 	  component="c135Barra3" />
			<port id="portaC135Barra4" 	  component="c135Barra4" />

			<!-- ## Declarações de Mídia --> 
			<media id="c135Main" 	   type="image/png" src="imagens/135_main.png" 	 descriptor="des#descritor135Main"   >
				<property name="fechar" value="" />
			</media>
			<media id="c135Barra1" 	   type="image/png" src="imagens/135_barra1.png" descriptor="des#descritor135Barra1" />
			<media id="c135Barra2" 	   type="image/png" src="imagens/135_barra2.png" descriptor="des#descritor135Barra2" />
			<media id="c135Barra3" 	   type="image/png" src="imagens/135_barra3.png" descriptor="des#descritor135Barra3" />
			<media id="c135Barra4" 	   type="image/png" src="imagens/135_barra4.png" descriptor="des#descritor135Barra4" />
			<media id="c135AgendaMain"   type="image/png" 	src="imagens/135Ag_main.png"  descriptor="des#descritor135Main2" />
			<media id="c135AgendaBarra"  type="image/png"   src="imagens/135Ag_barra.png" descriptor="des#descritor135Barra4" />
			<media id="c135ServicosMain"  type="image/png" src="imagens/135OS_main.png"  descriptor="des#descritor135Main2" />
			<media id="c135ServicosBarra" type="image/png" src="imagens/135Ag_barra.png" descriptor="des#descritor135Barra4" />

			<media id="c135DocumentosMain"  type="image/png"  src="imagens/135DOC_main.png" descriptor="des#descritor135Main2" />
			<media id="c135DocumentosBarra" type="image/png" src="imagens/135DOC_barra.png" descriptor="des#descritor135Barra4" />

			<!-- ## Elos ## --> 
			
			<!-- Ao selecionar o botão AMARELO na tela "inicial", acessa a opção de informações sobre Agendamento. 
			Para-se as mídias desta tela e inicia-se as mídias da tela de agendamento. -->
		   	<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
   				<bind role="onSelection" component="c135Main">
					<bindParam name="tecla" value="YELLOW" />
       			</bind>
			
  				<bind component="c135Main"  role="stop" />
  				<bind component="c135Barra1" role="stop" />
  				<bind component="c135Barra2" role="stop" />
  				<bind component="c135Barra3" role="stop" />
  				<bind component="c135Barra4" role="stop" />

  				<bind component="c135AgendaMain"  role="start" />
  				<bind component="c135AgendaBarra" role="start" />
 			</link>

			<!-- Ao selecionar o botão VERMELHO na tela "inicial", para-se todas as mídias que estão em tela, o que faz
			com que nenhuma mídia declarada deste arquivo esteja ativa. Encerra a atividade desse arquivo ncl. -->
		   	<link xconnector="con#naSelecaoDeTeclaParar" >
   				<bind role="onSelection" component="c135Main">
					<bindParam name="tecla" value="RED" />
       			</bind>

  				<bind component="c135Main"   role="stop" />
 				<bind component="c135Barra1" role="stop" />
  				<bind component="c135Barra2" role="stop" />
  				<bind component="c135Barra3" role="stop" />
  				<bind component="c135Barra4" role="stop" />
			</link>

			<!-- Ao selecionar o botão VERDE na tela "inicial", acessa a opção de informações sobre Serviços da Central 135.
			Para-se as mídias desta tela e inicia-se as mídias da tela de serviços. -->
		   	<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
		   		<bind role="onSelection" component="c135Main">
					<bindParam name="tecla" value="GREEN"/>
				</bind>
			
  				<bind component="c135Main"  role="stop" />
  				<bind component="c135Barra1" role="stop" />
  				<bind component="c135Barra2" role="stop" />
  				<bind component="c135Barra3" role="stop" />
  				<bind component="c135Barra4" role="stop" />

			    <bind component="c135ServicosMain"     role="start"/>
			    <bind component="c135ServicosBarra"    role="start"/>
 			</link>

			<!-- Ao selecionar o botão AZUL na tela "inicial", acessa a opção de orientação sobre documentos necessários 
			para utilizar o Central 135. Para-se as mídias da primeira tela e iniciam as mídias da tela de documentos. -->
		   	<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
		   		<bind role="onSelection" component="c135Main">
					<bindParam name="tecla" value="BLUE"/>
				</bind>
					
  				<bind component="c135Main"  role="stop" />
  				<bind component="c135Barra1" role="stop" />
  				<bind component="c135Barra2" role="stop" />
  				<bind component="c135Barra3" role="stop" />
  				<bind component="c135Barra4" role="stop" />
				
	  			<bind component="c135DocumentosMain"  role="start" />
	  			<bind component="c135DocumentosBarra" role="start" />
 			</link>
	
			<!-- AGENDAMENTO -->

				<!-- Ao selecionar o botão VERMELHO na tela de informações sobre agendamento, param-se as mídias desta
				tela e iniciam-se as mídias da tela principal. -->
			   	<link xconnector="con#naSelecaoDeTeclaPararIniciar">
			   		<bind role="onSelection" component="c135AgendaMain">	
						<bindParam name="tecla" value="RED"/>
			       	</bind>

	  				<bind component="c135AgendaMain"  role="stop" />
	  				<bind component="c135AgendaBarra" role="stop" />
	  				<bind component="c135Main"   	  role="start" />
	  				<bind component="c135Barra1" 	  role="start" />
	  				<bind component="c135Barra2" 	  role="start" />
	  				<bind component="c135Barra3" 	  role="start" />
  					<bind component="c135Barra4" 	  role="start" />
				</link>

				<!-- Ao selecionar o botão AZUL na tela de informações sobre agendamento, param-se as mídias desta
				tela e iniciam-se as mídias da tela de orientação sobre documentos necessários. -->
			   	<link xconnector="con#naSelecaoDeTeclaPararIniciar">
   					<bind role="onSelection" component="c135AgendaMain">
						<bindParam name="tecla" value="BLUE"/>
       				</bind>

  					<bind component="c135AgendaMain"  role="stop" />
  					<bind component="c135AgendaBarra" role="stop" />

		  			<bind component="c135DocumentosMain"  role="start" />
		  			<bind component="c135DocumentosBarra" role="start" />
				</link>

			<!-- OUTROS SERVIÇOS -->

				<!-- Ao selecionar o botão VERMELHO na tela de informações sobre serviços, param-se as mídias desta
				tela e iniciam-se as mídias da tela principal. -->
			   	<link xconnector="con#naSelecaoDeTeclaPararIniciar">
   					<bind role="onSelection" component="c135ServicosMain">
						<bindParam name="tecla" value="RED"/>
       				</bind>

			    	<bind component="c135ServicosMain"  role="stop"  />
			    	<bind component="c135ServicosBarra" role="stop"  />
	  				<bind component="c135Main"  		role="start" />
  					<bind component="c135Barra1" 		role="start" />
  					<bind component="c135Barra2" 		role="start" />
  					<bind component="c135Barra3" 		role="start" />
  					<bind component="c135Barra4" 		role="start" />

				</link>

				<!-- Ao selecionar o botão AZUL na tela de informações sobre serviços, param-se as mídias desta
				tela e iniciam-se as mídias da tela de orientação sobre documentos necessários. -->
			   	<link xconnector="con#naSelecaoDeTeclaPararIniciar">
   					<bind role="onSelection" component="c135ServicosMain">
						<bindParam name="tecla" value="BLUE"/>
       				</bind>

			    	<bind component="c135ServicosMain"    role="stop"  />
			    	<bind component="c135ServicosBarra"   role="stop"  />
		  			<bind component="c135DocumentosMain"  role="start" />
		  			<bind component="c135DocumentosBarra" role="start" />
				</link>

			<!-- DOCUMENTAÇÕES NECESSÁRIAS -->

				<!-- Ao selecionar o botão VERMELHO na tela de orientação sobre documentos, param-se as mídias desta
				tela e iniciam-se as mídias da tela principal. -->
			   	<link xconnector="con#naSelecaoDeTeclaPararIniciar">
   					<bind role="onSelection" component="c135DocumentosMain">
						<bindParam name="tecla" value="RED"/>
       				</bind>
			 
	  				<bind component="c135DocumentosMain"  role="stop" />
		  			<bind component="c135DocumentosBarra" role="stop" />
	  				<bind component="c135Main"   role="start" />
  					<bind component="c135Barra1" role="start" />
  					<bind component="c135Barra2" role="start" />
  					<bind component="c135Barra3" role="start" />
  					<bind component="c135Barra4" role="start" />
				</link>

				<!-- Ao selecionar o botão AMARELO na tela de orientação sobre documentos, param-se as mídias desta
				tela e iniciam-se as mídias da tela de informações sobre serviços. -->
			   	<link xconnector="con#naSelecaoDeTeclaPararIniciar">
			   		<bind role="onSelection" component="c135DocumentosMain">
						<bindParam name="tecla" value="YELLOW"/>
			       	</bind>
			
		  			<bind component="c135DocumentosMain"  role="stop" />
		  			<bind component="c135DocumentosBarra" role="stop" />

			    	<bind component="c135ServicosMain"     role="start"/>
			    	<bind component="c135ServicosBarra"    role="start"/>
				</link>
	</context>
</body>
</ncl>