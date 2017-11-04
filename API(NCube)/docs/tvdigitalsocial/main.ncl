<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="main" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
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
 !	 ## MAIN: Arquivo NCL com as definições da tela inicial e controles do menu principal. 
 !	 #################################################################################### -->

<!-- [## Cabeçalho ## -->
<head>
	<!-- ## Documentos importados: Arquivos NCL com as definições do conteúdo das opções dos itens do menu ## -->
	<importedDocumentBase>
		<importNCL alias="cal" documentURI="calPagamento.ncl"       />
		<importNCL alias="cen" documentURI="central135.ncl"         />
		<importNCL alias="tab" documentURI="tabelaContribuicao.ncl" />		
		<importNCL alias="loc" documentURI="localizarAgencia.ncl"   />
		<importNCL alias="twd" documentURI="twitterDataprev.ncl"    />
		<importNCL alias="twp" documentURI="twitterPrevidencia.ncl" /> 
	</importedDocumentBase>

	<!-- ## Bases de regiões, descritores e conectores. Definições encontradas nos documentos referidos. -->		
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
		<!-- ## Mídias que iniciarão quando o arquivo for disparado  -->
		<port id="portaVideo" 		   component="videoo" 		  />
		<port id="portaInteratividade" component="interatividade" />

		<!-- ## Declarações de Mídia --> 
		<media id="videoo" src="imagens/C35.mpeg" descriptor="des#descritorVideo">
			<property name="bounds" value="0,0,100%,100%" />
		</media>
		<media id="interatividade" type="image/png"  src="imagens/int.png" descriptor="des#descritorInteratividade"/>

		<!-- ## Elos ## --> 

		<!-- Ao selecionar o botão VERMELHO na tela "inicial", acesso ao menu principal.
		 !	 Mídia do botão de interatividade é parada, e o contexto do menu é iniciado. -->
		<link xconnector="con#naSelecaoDeTeclaPararIniciar">
	   		<bind role="onSelection" component="interatividade">
				<bindParam name="tecla" value="RED" />
   	    	</bind>
			<bind component="interatividade"  role="stop"  />
			<bind component="ctxMenu" 	  	  role="start" />
		</link>

		<!-- ## Ao terminar o vídeo, reiniciá-lo. Loop para manter o vídeo ativo. ##-->
		
		<link xconnector="con#aoTerminarIniciar" id="aoTerminarVideoIniciarVideo" >
				<bind role="onEnd" component="videoo" /> 
			    <bind role="start" component="videoo" />
		</link>		

		<!-- ## Contexto: Menu Principal ## --> 

		<context id="ctxMenu" >
			<!-- ## Mídias que iniciarão quando o contexto for disparado --> 	
			<port id="portaCabecalho"	 	  			    component="cabecalho" 					/>
			<port id="portaMenuServicos" 	   			    component="menuServicos" 				/>
			<port id="portaMenuBotaoCalendarioPagamento"    component="menuBotaoCalPagamento" 		/>
			<port id="portaMenuBotaoCentral135"   		    component="menuBotaoCentral135" 		    />
			<port id="portaMenuBotaoTabelaContribuicao"     component="menuBotaoTabelaContribuicao"  />
			<port id="portaMenuBotaoLocalizarAgencia"	    component="menuBotaoLocalizarAgencia" 	/>
			<port id="portaMenuBotaoTwitter"   			    component="menuBotaoTwitter" 			/>
			<port id="portaMenuBotaoSair"   			    component="menuBotaoSair" 				/>
			<port id="portaMenuDescricaoFundo"				component="menuDescricaoFundo"			/>
			<port id="portaMenuDescricaoCalPagamento"	    component="menuDescricaoCalPagamento"	/>
			<port id="portaMenuRodape"					    component="menuRodape"					/>
			<port id="portaMenuBotaoSelCalendarioPagamento" component="menuBotaoSelCalPagamento" 	/>

			<!-- ## Declarações das mídias do contexto. --> 
			<media id="fundo"  	  						type="image/png" src="imagens/fundo.png" 	   						 descriptor="des#descritorFundo" />
			<media id="cabecalho" 						type="image/png" src="imagens/cabecalho.png" 		     	 	 	 descriptor="des#descritorCabecalho" />
			<media id="menuServicos" 			 	 	type="image/png" src="imagens/menu/menuServicos.png" 		     	 descriptor="des#descritorMenuServicos" />
			<media id="menuRodape"		     	 		type="image/png" src="imagens/menu/menuRodape.png"  		 		 descriptor="des#descritorMenuRodape"   />
			<media id="menuDescricaoCentral135"    	 	type="image/png" src="imagens/menu/menuDescricaoCentral135.png"  	 descriptor="des#descritorMenuDescricao"/>
			<media id="menuDescricaoCalPagamento"  	 	type="image/png" src="imagens/menu/menuDescricaoCalPagamento.png"  	 descriptor="des#descritorMenuDescricao"/>
			<media id="menuDescricaoLocalizarAgencia" 	type="image/png" src="imagens/menu/menuDescricaoLocalizarAgencia.png"   descriptor="des#descritorMenuDescricao"/>
			<media id="menuDescricaoTabelaContribuicao"	type="image/png" src="imagens/menu/menuDescricaoTabelaContribuicao.png" descriptor="des#descritorMenuDescricao"/>
			<media id="menuDescricaoTwitter"		 	type="image/png" src="imagens/menu/menuDescricaoTwitter.png"   		 descriptor="des#descritorMenuDescricao"/>
			<media id="menuDescricaoSair"			 	type="image/png" src="imagens/menu/menuDescricaoSair.png"   		 descriptor="des#descritorMenuDescricao"/>
			<media id="menuBotaoCalPagamento" 			type="image/png" src="imagens/menu/menuBotaoCalPagamento.png" 		descriptor="des#descritorMenuBotaoCalendarioPagamento"/>
			<media id="menuBotaoCentral135" 		 	type="image/png" src="imagens/menu/menuBotaoCentral135.png" 		descriptor="des#descritorMenuBotaoCentral135"		   />
			<media id="menuBotaoLocalizarAgencia"	 	type="image/png" src="imagens/menu/menuBotaoLocalizarAgencia.png" 	descriptor="des#descritorMenuBotaoLocalizarAgencia"   />
			<media id="menuBotaoTabelaContribuicao"  	type="image/png" src="imagens/menu/menuBotaoTabelaContribuicao.png" descriptor="des#descritorMenuBotaoTabelaContribuicao" />
			<media id="menuBotaoTwitter"		     	type="image/png" src="imagens/menu/menuBotaoNovTwitter.png"  		descriptor="des#descritorMenuBotaoTwitter"			   />
			<media id="menuBotaoSair"		     	 	type="image/png" src="imagens/menu/menuBotaoSair.png"  		 		descriptor="des#descritorMenuBotaoSair"   			   >
				<property name="fechar" value="" />
			</media>
			<media id="menuBotaoTwitterDataprev"		type="image/png" src="imagens/menu/menuBotaoTwitterDataprev.png" 	descriptor="des#descritorMenuBotaoCalendarioPagamento" />
			<media id="menuBotaoTwitterPrevidencia"	 	type="image/png" src="imagens/menu/menuBotaoTwitterPrevidencia.png" descriptor="des#descritorMenuBotaoCentral135"		   />
			<media id="menuBotaoVoltar"	 				type="image/png" src="imagens/menu/menuBotaoVoltar.png"	 		 	descriptor="des#descritorMenuBotaoTabelaContribuicao"  />
			<media id="menuBotao4"	 					type="image/png" src="imagens/menu/menuBotao.png" 	 		 		descriptor="des#descritorMenuBotaoLocalizarAgencia"    />
			<media id="menuBotao5"	 					type="image/png" src="imagens/menu/menuBotao.png" 	 		 		descriptor="des#descritorMenuBotaoTwitter"			   />
			<media id="menuBotao6"	 					type="image/png" src="imagens/menu/menuBotao.png" 	 		 		descriptor="des#descritorMenuBotaoSair"			   	   />
			<media id="menuBotaoSelTwitterDataprev"		type="image/png" src="imagens/menu/menuBotaoSelTwitterDataprev.png" descriptor="des#descritorMenuBotaoCalendarioPagamento"/>
			<media id="menuBotaoSelTwitterPrevidencia" 	type="image/png" src="imagens/menu/menuBotaoSelTwitterPrevidencia.png" descriptor="des#descritorMenuBotaoCentral135"	   />
			<media id="menuBotaoSelVoltar"	 			type="image/png" src="imagens/menu/menuBotaoSelVoltar.png" 	 		 descriptor="des#descritorMenuBotaoTabelaContribuicao" />
			<media id="menuDescricaoFundo"			 	type="image/png" src="imagens/menu/menuDescricaoFundo.png"    		 descriptor="des#descritorMenuDescricaoFundo"		   />
			<media id="menuDescricaoTwitterDataprev" 	type="image/png" src="imagens/menu/menuDescricaoTwitDataprev.png"    descriptor="des#descritorMenuDescricao" 			   />
			<media id="menuDescricaoTwitterPrevidencia"	type="image/png" src="imagens/menu/menuDescricaoTwitPrevidencia.png" descriptor="des#descritorMenuDescricao" 			   />
			<media id="menuDescricaoVoltar"				type="image/png" src="imagens/menu/menuDescricaoVoltar.png" 		 descriptor="des#descritorMenuDescricao"			   />
			<media id="menuBotaoSelCalPagamento" 		type="image/png" src="imagens/menu/menuBotaoSelCalPagamento.png" 	 descriptor="des#descritorMenuBotaoCalendarioPagamento"/>
			<media id="menuBotaoSelCentral135" 		 	type="image/png" src="imagens/menu/menuBotaoSelCentral135.png" 		 descriptor="des#descritorMenuBotaoCentral135"			/>
			<media id="menuBotaoSelLocalizarAgencia" 	type="image/png" src="imagens/menu/menuBotaoSelLocalizarAgencia.png" descriptor="des#descritorMenuBotaoLocalizarAgencia"  />
			<media id="menuBotaoSelTabelaContribuicao"  type="image/png" src="imagens/menu/menuBotaoSelTabelaContribuicao.png" descriptor="des#descritorMenuBotaoTabelaContribuicao" />
			<media id="menuBotaoSelTwitter"		     	type="image/png" src="imagens/menu/menuBotaoSelNovTwitter.png"  	 descriptor="des#descritorMenuBotaoTwitter"  		/>
			<media id="menuBotaoSelSair"		        type="image/png" src="imagens/menu/menuBotaoSelSair.png"  		 	 descriptor="des#descritorMenuBotaoSair"			 	/>
			<media id="int" refer="interatividade" instance="instSame" />
			<media id="video" refer="videoo" instance="instSame" />
	   		<media type="application/x-ginga-settings" id="settings">
		   		<property name="service.currentKeyMaster" />
				<property name="service.currentFocus" />
				<property name="channel.keyCapture" value="false" />
			</media>	

		<!-- ## Contextos referenciando as id's dos arquivos ncl. ## -->
			
			<context id="calendario" 		 refer="cal#maincalPagamento"	   />
	   		<context id="central135" 		 refer="cen#maincen135" 	       />
			<context id="tabelaContribuicao" refer="tab#maintabContribuicao"   /> 
			<context id="localizarAgencia"   refer="loc#mainlocAgencia"        /> 
			<context id="twitterDataprev"    refer="twd#maintwiDataprev"       /> 
			<context id="twitterPrevidencia" refer="twp#maintwiPrevidencia"    /> 

		<!-- ## Quando selecionado Calendário Pagamento: ## -->
		
			<!-- ## Tecla Baixo: Seleciona Central 135. -->
			<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelCalPagamento" > 
					<bindParam name="tecla" value="CURSOR_DOWN"/>
			    </bind>
			    <bind role="start" component="menuBotaoSelCentral135"    />
		    	<bind role="start" component="menuDescricaoCentral135"   />
			    <bind role="stop"  component="menuBotaoSelCalPagamento"  />
		    	<bind role="stop"  component="menuDescricaoCalPagamento" />
			</link>

			<!-- ## Tecla Cima: Seleciona opção Sair. -->
			<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelCalPagamento" > 
					<bindParam name="tecla" value="CURSOR_UP"/>
		    	</bind>
		    
				<bind role="start" component="menuBotaoSelSair"          />
	   		 	<bind role="start" component="menuDescricaoSair"         />
			    <bind role="stop"  component="menuBotaoSelCalPagamento"  />
	    		<bind role="stop"  component="menuDescricaoCalPagamento" />
			</link>
				
			<!-- ## Tecla Enter: Acesso ao conteúdo. -->
			<link xconnector="con#naSelecaoDeTeclaSetarPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelCalPagamento" > 
					<bindParam name="tecla" value="ENTER"/>
				</bind>

	       	<bind role="set" component="video" interface="bounds" >
	      	   <bindParam name="var" value="60.36%,15.70%,33%,56%" />  <!--  value="60.36%,13.50%,34%,58%" -->
	        </bind>			
    			<bind role="stop"  component="menuRodape"    	    	   />
    			<bind role="stop"  component="menuDescricaoFundo"		   />
    			<bind role="stop"  component="menuDescricaoCalPagamento"   />
		    	<bind role="stop"  component="menuBotaoSelCalPagamento"	   />
	   		 	<bind role="stop"  component="menuBotaoSair"     		   />
	   		 	<bind role="stop"  component="menuBotaoTwitter" 		   />
	    		<bind role="stop"  component="menuBotaoTabelaContribuicao" />
	    		<bind role="stop"  component="menuBotaoLocalizarAgencia"   />
	    		<bind role="stop"  component="menuBotaoCentral135" 		   />
	   	 		<bind role="stop"  component="menuBotaoCalPagamento"  	   />
	    		<bind role="stop"  component="menuServicos"				   />
				<bind role="start" component="calendario"				   />
				<bind role="start" component="fundo"					   />					
			</link>

			<!-- ## Ao encerrar todas as mídias do contexto Calendário Pagamento, iniciar menu novamente. -->			
			<link xconnector="con#aoTerminarPararIniciarSetar" >
				<bind role="onEnd" component="calendario" /> 
				
    			<bind role="stop"   component="fundo"	    	    	   />
    			<bind role="start"  component="menuRodape"    	    	   />
    			<bind role="start"  component="menuDescricaoFundo"		   />
    			<bind role="start"  component="menuDescricaoCalPagamento"  />
	   		 	<bind role="start"  component="menuBotaoSair"     		   />
	   		 	<bind role="start"  component="menuBotaoTwitter" 		   />
	    		<bind role="start"  component="menuBotaoTabelaContribuicao"/>
	    		<bind role="start"  component="menuBotaoLocalizarAgencia"  />
	    		<bind role="start"  component="menuBotaoCentral135" 	   />
	   	 		<bind role="start"  component="menuBotaoCalPagamento"  	   />
	    		<bind role="start"  component="menuServicos"			   />
		    	<bind role="start"  component="menuBotaoSelCalPagamento"   />
		    	
				<bind role="set" component="video" interface="bounds" >
		      	    	<bindParam name="var" value="0%,0%,304%,179%" /> 
		        </bind>    	
		    	
			</link>
			
		<!-- ## Quando selecionado Central 135 -->

			<!-- ## Tecla Cima: Seleciona Calendario Pagamento. -->
			<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelCentral135" > 
					<bindParam name="tecla" value="CURSOR_UP"/>
			    </bind>
		    
			    <bind role="start"  component="menuBotaoSelCalPagamento"  />
	    		<bind role="start"  component="menuDescricaoCalPagamento" />
			    <bind role="stop"   component="menuBotaoSelCentral135"    />
	    		<bind role="stop"   component="menuDescricaoCentral135"   />
			</link>

			<!-- ## Tecla Baixo: Seleciona Tabela Contribuicao. -->
			<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelCentral135" > 
					<bindParam name="tecla" value="CURSOR_DOWN"/>
			    </bind>
		    
			    <bind role="start"  component="menuBotaoSelTabelaContribuicao"  />
	    		<bind role="start"  component="menuDescricaoTabelaContribuicao" />
		    	<bind role="stop"   component="menuBotaoSelCentral135"          />
	    		<bind role="stop"   component="menuDescricaoCentral135"         />
			</link>
				
			<!-- ## Tecla Enter: Acesso ao conteúdo. -->
			<link xconnector="con#naSelecaoDeTeclaSetarPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelCentral135" > 
					<bindParam name="tecla" value="ENTER" />
				</bind>	

				<bind role="set" component="video" interface="bounds" >
					<bindParam name="var" value="60.36%,15.70%,33%,56%" />
		        </bind>
    			<bind role="stop"  component="menuRodape"    	    	   />
    			<bind role="stop"  component="menuDescricaoFundo"		   />
    			<bind role="stop"  component="menuDescricaoCentral135"     />
		    	<bind role="stop"  component="menuBotaoSelCentral135"	   />
	   		 	<bind role="stop"  component="menuBotaoSair"     		   />
	   		 	<bind role="stop"  component="menuBotaoTwitter" 		   />
	    		<bind role="stop"  component="menuBotaoTabelaContribuicao" />
	    		<bind role="stop"  component="menuBotaoLocalizarAgencia"   />
	    		<bind role="stop"  component="menuBotaoCentral135" 		   />
	   	 		<bind role="stop"  component="menuBotaoCalPagamento"  	   />
	    		<bind role="stop"  component="menuServicos"				   />
				<bind role="start" component="central135"				   />					
				<bind role="start" component="fundo"					   />					
			</link>

			<!-- ## Ao encerrar todas as mídias do contexto Central 135, iniciar menu novamente. -->			
			<link xconnector="con#aoTerminarPararIniciarSetar" >
				<bind role="onEnd" component="central135" /> 
				
    			<bind role="stop"   component="fundo"	    	    	   />
    			<bind role="start"  component="menuRodape"    	    	   />
    			<bind role="start"  component="menuDescricaoFundo"		   />
    			<bind role="start"  component="menuDescricaoCentral135"    />
	   		 	<bind role="start"  component="menuBotaoSair"     		   />
	   		 	<bind role="start"  component="menuBotaoTwitter" 		   />
	    		<bind role="start"  component="menuBotaoTabelaContribuicao" />
	    		<bind role="start"  component="menuBotaoLocalizarAgencia"  />
	    		<bind role="start"  component="menuBotaoCentral135" 	   />
	   	 		<bind role="start"  component="menuBotaoCalPagamento"  	   />
	    		<bind role="start"  component="menuServicos"			   />
		    	<bind role="start"  component="menuBotaoSelCentral135"     />
		    	
				<bind role="set" component="video" interface="bounds" >
		      	    	<bindParam name="var" value="0%,0%,304%,179%" /> 
		        </bind>   	
		    	
			</link>
				
		<!-- ## Quando selecionado Tabela Contribuição -->
		
			<!-- ## Tecla baixo: Seleciona Localizar Agêcia -->
			<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelTabelaContribuicao" > 
					<bindParam name="tecla" value="CURSOR_DOWN" />
			    </bind>
		    
		    	<bind role="start" component="menuBotaoSelLocalizarAgencia"    />
	    		<bind role="start" component="menuDescricaoLocalizarAgencia"   />
		    	<bind role="stop"  component="menuBotaoSelTabelaContribuicao"  />
	    		<bind role="stop"  component="menuDescricaoTabelaContribuicao" />
			</link>

			<!-- ## Tecla Cima: Seleciona Central 135 -->
			<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelTabelaContribuicao" > 
					<bindParam name="tecla" value="CURSOR_UP" />
			    </bind>
		    
			    <bind role="start" component="menuBotaoSelCentral135"   	   />
		    	<bind role="start" component="menuDescricaoCentral135"  	   />
			    <bind role="stop"  component="menuBotaoSelTabelaContribuicao"  />
		    	<bind role="stop"  component="menuDescricaoTabelaContribuicao" />
			</link>

			<!-- ## Tecla Enter: Acesso ao Conteúdos -->
			<link xconnector="con#naSelecaoDeTeclaSetarPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelTabelaContribuicao" > 
					<bindParam name="tecla" value="ENTER" />
				</bind>	
				
				<bind role="set" component="video" interface="bounds" >
					<bindParam name="var" value="60.36%,15.70%,33%,56%" />
		        </bind>

    			<bind role="stop"  component="menuRodape"    	    	   />
    			<bind role="stop"  component="menuDescricaoFundo"		   />
    			<bind role="stop"  component="menuDescricaoTabelaContribuicao" />
		    	<bind role="stop"  component="menuBotaoSelTabelaContribuicao"/>
	   		 	<bind role="stop"  component="menuBotaoSair"     		   />
	   		 	<bind role="stop"  component="menuBotaoTwitter" 		   />
	    		<bind role="stop"  component="menuBotaoTabelaContribuicao" />
	    		<bind role="stop"  component="menuBotaoLocalizarAgencia"   />
	    		<bind role="stop"  component="menuBotaoCentral135" 		   />
	   	 		<bind role="stop"  component="menuBotaoCalPagamento"  	   />
	    		<bind role="stop"  component="menuServicos"				   />
				<bind role="start" component="tabelaContribuicao"		   />					
				<bind role="start" component="fundo"					   />					
			</link>

			<!-- ## Ao encerrar todas as mídias do contexto Tabela Contribuicao, iniciar menu novamente. -->			

			<link xconnector="con#aoTerminarPararIniciarSetar" >
				<bind role="onEnd" component="tabelaContribuicao" /> 
				
    			<bind role="stop"   component="fundo"	    	    	   />
    			<bind role="start"  component="menuRodape"    	    	   />
    			<bind role="start"  component="menuDescricaoFundo"		   />  		
    			<bind role="start"  component="menuDescricaoTabelaContribuicao" />
	   		 	<bind role="start"  component="menuBotaoSair"     		   />
	   		 	<bind role="start"  component="menuBotaoTwitter" 		   />
	    		<bind role="start"  component="menuBotaoTabelaContribuicao" />
	    		<bind role="start"  component="menuBotaoLocalizarAgencia"  />
	    		<bind role="start"  component="menuBotaoCentral135" 	   />
	   	 		<bind role="start"  component="menuBotaoCalPagamento"  	   />
	    		<bind role="start"  component="menuServicos"			   />
		    	<bind role="start"  component="menuBotaoSelTabelaContribuicao" />
		    	
				<bind role="set" component="video" interface="bounds" >
		      	    	<bindParam name="var" value="0%,0%,304%,179%" /> 
		        </bind>    	
		    	
			</link>

			<!-- ## Quando selecionado Localizar Agência... ###  -->
	
			<!-- ## Tecla Cima: Seleciona Tabela Contribuicao. -->
			<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelLocalizarAgencia" > 
					<bindParam name="tecla" value="CURSOR_UP" />
			    </bind>

			    <bind role="start" component="menuBotaoSelTabelaContribuicao"  />
	    		<bind role="start" component="menuDescricaoTabelaContribuicao" />
			    <bind role="stop"  component="menuBotaoSelLocalizarAgencia"    />
	    		<bind role="stop"  component="menuDescricaoLocalizarAgencia"   />
			</link>

			<!-- ##Tecla Baixo: Seleciona Twitter -->
			<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelLocalizarAgencia" > 
					<bindParam name="tecla" value="CURSOR_DOWN" />
			    </bind>
		    
			    <bind role="start" component="menuBotaoSelTwitter"  		 />
		    	<bind role="start" component="menuDescricaoTwitter" 		 />
			    <bind role="stop"  component="menuBotaoSelLocalizarAgencia"  />
		    	<bind role="stop"  component="menuDescricaoLocalizarAgencia" />
			</link>

			<!-- ## Tecla Enter: Acesso ao conteúdo do contexto Localizar Agência.  -->
			<link xconnector="con#naSelecaoDeTeclaSetarPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelLocalizarAgencia" > 
					<bindParam name="tecla" value="ENTER"/>
				</bind>

				<bind role="set" component="video" interface="bounds" >
					<bindParam name="var" value="60.36%,15.70%,33%,56%" />
		        </bind>

    			<bind role="stop"  component="menuRodape"    	    	   />
    			<bind role="stop"  component="menuDescricaoFundo"		   />
    			<bind role="stop"  component="menuDescricaoLocalizarAgencia" />
		    	<bind role="stop"  component="menuBotaoSelLocalizarAgencia"  />
	   		 	<bind role="stop"  component="menuBotaoSair"     		   />
	   		 	<bind role="stop"  component="menuBotaoTwitter" 		   />
	    		<bind role="stop"  component="menuBotaoTabelaContribuicao" />
	    		<bind role="stop"  component="menuBotaoLocalizarAgencia"   />
	    		<bind role="stop"  component="menuBotaoCentral135" 		   />
	   	 		<bind role="stop"  component="menuBotaoCalPagamento"  	   />
	    		<bind role="stop"  component="menuServicos"				   />
				<bind role="start" component="localizarAgencia"			   />
				<bind role="start" component="fundo"					   />					
			</link>

			<!-- ## Ao encerrar todas as mídias do contexto Localizar Agência, iniciar menu novamente. -->			
			<link xconnector="con#aoTerminarPararIniciarSetar" >
				<bind role="onEnd" component="localizarAgencia" /> 
				
    			<bind role="stop"   component="fundo"	    	    	   />
    			<bind role="start"  component="menuRodape"    	    	   />
    			<bind role="start"  component="menuDescricaoFundo"		   />
    			<bind role="start"  component="menuDescricaoLocalizarAgencia"  />
	   		 	<bind role="start"  component="menuBotaoSair"     		   />
	   		 	<bind role="start"  component="menuBotaoTwitter" 		   />
	    		<bind role="start"  component="menuBotaoTabelaContribuicao" />
	    		<bind role="start"  component="menuBotaoLocalizarAgencia"  />
	    		<bind role="start"  component="menuBotaoCentral135" 	   />
	   	 		<bind role="start"  component="menuBotaoCalPagamento"  	   />
	    		<bind role="start"  component="menuServicos"			   />
		    	<bind role="start"  component="menuBotaoSelLocalizarAgencia" />
		    	
				<bind role="set" component="video" interface="bounds" >
		      	    	<bindParam name="var" value="0%,0%,304%,179%" /> 
		        </bind>   		
			</link>
		
		<!-- ## Quando selecionado Novidades Twitter. ## -->

			<!-- ## Tecla Baixo: Seleciona Sair. -->
			<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelTwitter" > 
					<bindParam name="tecla" value="CURSOR_DOWN" />
		    	</bind>
		    
		    	<bind role="start" component="menuBotaoSelSair"     />
    			<bind role="start" component="menuDescricaoSair"    />
		   	 	<bind role="stop"  component="menuBotaoSelTwitter"  />
    			<bind role="stop"  component="menuDescricaoTwitter" />
			</link>		

			<!-- ## Tecla Cima: Seleciona Localizar Agência. -->
			<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelTwitter" > 
					<bindParam name="tecla" value="CURSOR_UP" />
			    </bind>
		 
		    	<bind role="start" component="menuBotaoSelLocalizarAgencia" />
		    	<bind role="start" component="menuDescricaoLocalizarAgencia" />
	   		 	<bind role="stop"  component="menuBotaoSelTwitter"  		 />
    			<bind role="stop"  component="menuDescricaoTwitter" 		 />
			</link>

			<!-- ## Tecla Enter : Acesso a novas opções. 
			 !   -> Twitter Previdencia 
			 !   -> Twitter Dataprev -->
			
			<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelTwitter" > 
					<bindParam name="tecla" value="ENTER" />
				</bind>
					
		    	<bind role="stop"   component="menuBotaoSelTwitter"	   	    />
       			<bind role="stop"   component="menuDescricaoTwitter"   	    />
	   		 	<bind role="stop"   component="menuBotaoSair"     		    />
	   		 	<bind role="stop"   component="menuBotaoTwitter" 		    />
	    		<bind role="stop"   component="menuBotaoTabelaContribuicao" />
	    		<bind role="stop"   component="menuBotaoLocalizarAgencia"   />
	    		<bind role="stop"   component="menuBotaoCentral135" 		/>
	   	 		<bind role="stop"   component="menuBotaoCalPagamento"  	    />

	   		 	<bind role="start"  component="menuBotaoTwitterDataprev"     />
	   		 	<bind role="start"  component="menuBotaoTwitterPrevidencia"  />
	   		 	<bind role="start"  component="menuBotaoVoltar"        		 />
	   		 	<bind role="start"  component="menuBotao4"       		 	 />
	   		 	<bind role="start"  component="menuBotao5"       		 	 />
	   		 	<bind role="start"  component="menuBotao6"       		 	 />
    			<bind role="start"  component="menuDescricaoTwitterDataprev" />
	   		 	<bind role="start"  component="menuBotaoSelTwitterDataprev"  />
	   	 			
			</link>			

		<!-- ## Quando selecionado twitter Dataprev: -->

			<!-- ## Tecla Cima: Seleciona botao Voltar. -->
			<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelTwitterDataprev" > 
					<bindParam name="tecla" value="CURSOR_UP" />
			    </bind>

    			<bind role="stop"  component="menuDescricaoTwitterDataprev" />
	   		 	<bind role="stop"  component="menuBotaoSelTwitterDataprev"  />
	   		 	<bind role="start" component="menuBotaoSelVoltar"  			/>
    			<bind role="start" component="menuDescricaoVoltar" 			/>
			</link>
    			
			<!-- ## Tecla Baixo: Seleciona Twitter Previdencia. -->
			<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelTwitterDataprev" > 
					<bindParam name="tecla" value="CURSOR_DOWN" />
			    </bind>

    			<bind role="stop"  component="menuDescricaoTwitterDataprev"    />
	   		 	<bind role="stop"  component="menuBotaoSelTwitterDataprev"     />
	   		 	<bind role="start" component="menuBotaoSelTwitterPrevidencia"  />
    			<bind role="start" component="menuDescricaoTwitterPrevidencia" />
				<bind role="start" component="menuDescricaoTwitterPrevidencia" />
			
			</link>

			<!-- ## Tecla Enter: Acessa o conteúdo. -->
			<link xconnector="con#naSelecaoDeTeclaSetarPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelTwitterDataprev" > 
					<bindParam name="tecla" value="ENTER" />
				</bind>	
				
				<bind role="set" component="video" interface="bounds" >
					<bindParam name="var" value="60.36%,15.70%,33%,56%" />
		        </bind>
				
    			<bind role="stop"  component="menuRodape"    	    	   />
	   		 	<bind role="stop"  component="menuBotaoTwitterDataprev"    />
	   		 	<bind role="stop"  component="menuBotaoTwitterPrevidencia" />
	   		 	<bind role="stop"  component="menuBotaoVoltar"        	   />
	   		 	<bind role="stop"  component="menuBotao4"       		   />
	   		 	<bind role="stop"  component="menuBotao5"       		   />
	   		 	<bind role="stop"  component="menuBotao6"       		   />
    			<bind role="stop"  component="menuDescricaoFundo"		   />
    			<bind role="stop"  component="menuDescricaoTwitterDataprev"/>
	   		 	<bind role="stop"  component="menuBotaoSelTwitterDataprev" />
	    		<bind role="stop"  component="menuServicos"				   />
				<bind role="start" component="twitterDataprev"			   />			
				<bind role="start" component="fundo"					   />					
			</link>

			<!-- ## Ao encerrar todas as mídias do contexto Twitter Dataprev, reiniciar menu. -->						
			<link xconnector="con#aoTerminarPararIniciarSetar" >
				<bind role="onEnd" component="twitterDataprev" /> 
				
    			<bind role="stop"   component="fundo"	    	    	   />
	    		<bind role="start"  component="menuServicos"			   />
    			<bind role="start"  component="menuRodape"    	    	   />
	   		 	<bind role="start"  component="menuBotaoTwitterDataprev"   />
	   		 	<bind role="start"  component="menuBotaoTwitterPrevidencia"/>
	   		 	<bind role="start"  component="menuBotaoVoltar"            />
	   		 	<bind role="start"  component="menuBotao4"       		   />
	   		 	<bind role="start"  component="menuBotao5"       		   />
	   		 	<bind role="start"  component="menuBotao6"       		   />
    			<bind role="start"  component="menuDescricaoFundo"		   />
    			<bind role="start"  component="menuDescricaoTwitterDataprev" />
	   		 	<bind role="start"  component="menuBotaoSelTwitterDataprev"  />
		    	
				<bind role="set" component="video" interface="bounds" >
		      	    	<bindParam name="var" value="0%,0%,304%,179%" /> 
		        </bind>   	
		    	
			</link>

		<!-- ## Quando selecionado Twitter Previdencia. :::::::::::::::::::::::::::: -->

			<!-- ## Tecla Cima: Seleciona Twitter Dataprev. -->
			<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelTwitterPrevidencia" > 
					<bindParam name="tecla" value="CURSOR_UP" />
			    </bind>

    			<bind role="stop"  component="menuDescricaoTwitterPrevidencia" />
	   		 	<bind role="stop"  component="menuBotaoSelTwitterPrevidencia"  />
	   		 	<bind role="start" component="menuBotaoSelTwitterDataprev"     />
    			<bind role="start" component="menuDescricaoTwitterDataprev"    />
			</link>

			<!-- ## Tecla Baixo: Seleciona Voltar. -->
			<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelTwitterPrevidencia" > 
					<bindParam name="tecla" value="CURSOR_DOWN" />
			    </bind>

    			<bind role="stop"  component="menuDescricaoTwitterPrevidencia" />
	   		 	<bind role="stop"  component="menuBotaoSelTwitterPrevidencia"  />
	   		 	<bind role="start" component="menuBotaoSelVoltar"  			   />
    			<bind role="start" component="menuDescricaoVoltar" 			   />
			</link>

			<!-- ## Tecla Enter: Acessa o conteúdo. -->			
			<link xconnector="con#naSelecaoDeTeclaSetarPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelTwitterPrevidencia" > 
					<bindParam name="tecla" value="ENTER" />
				</bind>	
					
				<bind role="set" component="video" interface="bounds" >
					<bindParam name="var" value="60.36%,15.70%,33%,56%" />
		        </bind>
				
    			<bind role="stop"  component="menuRodape"    	    	   />
	   		 	<bind role="stop"  component="menuBotaoTwitterDataprev"    />
	   		 	<bind role="stop"  component="menuBotaoTwitterPrevidencia" />
	   		 	<bind role="stop"  component="menuBotaoVoltar"        	   />
	   		 	<bind role="stop"  component="menuBotao4"       		   />
	   		 	<bind role="stop"  component="menuBotao5"       		   />
	   		 	<bind role="stop"  component="menuBotao6"       		   />
    			<bind role="stop"  component="menuDescricaoFundo"		   />
    			<bind role="stop"  component="menuDescricaoTwitterPrevidencia"/>
	   		 	<bind role="stop"  component="menuBotaoSelTwitterPrevidencia" />
	    		<bind role="stop"  component="menuServicos"				   />
				<bind role="start" component="twitterPrevidencia"		   />								
				<bind role="start" component="fundo"					   />					
			</link>

			<!-- ## Ao encerrar todas as mídias do contexto Twitter Previdencia, reiniciar menu. -->						
			<link xconnector="con#aoTerminarPararIniciarSetar" >
				<bind role="onEnd" component="twitterPrevidencia" /> 
				
    			<bind role="stop"   component="fundo"	    	    	   />
	    		<bind role="start"  component="menuServicos"			   />
    			<bind role="start"  component="menuRodape"    	    	   />
	   		 	<bind role="start"  component="menuBotaoTwitterDataprev"   />
	   		 	<bind role="start"  component="menuBotaoTwitterPrevidencia"/>
	   		 	<bind role="start"  component="menuBotaoVoltar"        	   />
	   		 	<bind role="start"  component="menuBotao4"       		   />
	   		 	<bind role="start"  component="menuBotao5"       		   />
	   		 	<bind role="start"  component="menuBotao6"       		   />
    			<bind role="start"  component="menuDescricaoFundo"		   />
    			<bind role="start"  component="menuDescricaoTwitterPrevidencia"/>
	   		 	<bind role="start"  component="menuBotaoSelTwitterPrevidencia" />
		    	
				<bind role="set" component="video" interface="bounds" >
		      	    	<bindParam name="var" value="0%,0%,304%,179%" /> 
		        </bind>
		    	
			</link>

		<!-- ## Quando selecionado Voltar: -->

			<!-- ## Tecla CIma: Seleciona Twitter Previdencia. -->
			<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelVoltar" > 
					<bindParam name="tecla" value="CURSOR_UP" />
			    </bind>

    			<bind role="stop"  component="menuDescricaoVoltar"   		   />
	   		 	<bind role="stop"  component="menuBotaoSelVoltar"  			   />
	   		 	<bind role="start" component="menuBotaoSelTwitterPrevidencia"  />
    			<bind role="start" component="menuDescricaoTwitterPrevidencia" />
			</link>

			<!-- ## Tecla Baixo: Seleciona Twitter Dataprev. -->
			<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelVoltar" > 
					<bindParam name="tecla" value="CURSOR_DOWN" />
			    </bind>

    			<bind role="stop"  component="menuDescricaoVoltar" 			/>
    			<bind role="stop"  component="menuBotaoSelVoltar"  			/>
	   		 	<bind role="start" component="menuBotaoSelTwitterDataprev"  />
    			<bind role="start" component="menuDescricaoTwitterDataprev" />
			</link>

			<!-- ## Tecla Enter: Acesso ao Conteúdo. -->
			<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelVoltar" > 
					<bindParam name="tecla" value="ENTER" />
				</bind>

	   		 	<bind role="stop"  component="menuBotaoTwitterDataprev"    />
	   		 	<bind role="stop"  component="menuBotaoTwitterPrevidencia" />
	   		 	<bind role="stop"  component="menuBotaoVoltar"        	   />
	   		 	<bind role="stop"  component="menuBotao4"       		   />
	   		 	<bind role="stop"  component="menuBotao5"       		   />
	   		 	<bind role="stop"  component="menuBotao6"       		   />
    			<bind role="stop"  component="menuDescricaoVoltar" 		   />
	   		 	<bind role="stop"  component="menuBotaoSelVoltar"		   />
				
		    	<bind role="start" component="menuBotaoSelTwitter"	   	   />
    			<bind role="start" component="menuDescricaoTwitter"   	   />
	   		 	<bind role="start" component="menuBotaoSair"     		   />
	   		 	<bind role="start" component="menuBotaoTwitter" 		   />
	    		<bind role="start" component="menuBotaoTabelaContribuicao" />
	    		<bind role="start" component="menuBotaoLocalizarAgencia"   />
	    		<bind role="start" component="menuBotaoCentral135"		   />
	   	 		<bind role="start" component="menuBotaoCalPagamento"  	   />	
			</link>	
				
		<!-- ## Quando selecionado Sair: -->
		
			<!-- ## Tecla Baixo: Acesso Calendário Pagamento. -->
			<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelSair" > 
					<bindParam name="tecla" value="CURSOR_DOWN" />
			    </bind>
		    
				<bind role="start" component="menuBotaoSelCalPagamento"  />
	   		 	<bind role="start" component="menuDescricaoCalPagamento" />
			    <bind role="stop"  component="menuBotaoSelSair"  		 />
	    		<bind role="stop"  component="menuDescricaoSair" 		 />
			</link>			

			<!-- ## Tecla Cima: Seleciona Novidades Twitter -->
			<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
				<bind role="onSelection" component="menuBotaoSelSair" > 
					<bindParam name="tecla" value="CURSOR_UP" />
		   		</bind>
		   					    	
		    	<bind role="start" component="menuBotaoSelTwitter"  />
	    		<bind role="start" component="menuDescricaoTwitter" />
		    	<bind role="stop"  component="menuBotaoSelSair"     />
	    		<bind role="stop"  component="menuDescricaoSair"    />
			</link>			

			<!-- ## Tecla Enter: Executa a ação. -->
		   	<link xconnector="con#naSelecaoDeTeclaPararIniciar" >
	   				<bind role="onSelection" component="menuBotaoSelSair">
						<bindParam name="tecla" value="ENTER" />
	       			</bind>
	
	    		<bind role="stop"  component="menuRodape"    	    	   />
    			<bind role="stop"  component="menuDescricaoFundo"		   />
	    		<bind role="stop"  component="menuDescricaoSair"    	   />
		   		<bind role="stop"  component="menuBotaoSelSair"     	   />
		   		<bind role="stop"  component="menuBotaoSair"     		   />
		    	<bind role="stop"  component="menuBotaoTwitter" 		   />
		    	<bind role="stop"  component="menuBotaoTabelaContribuicao" />
		    	<bind role="stop"  component="menuBotaoLocalizarAgencia"   />
		    	<bind role="stop"  component="menuBotaoCentral135" 		   />
		    	<bind role="stop"  component="menuBotaoCalPagamento"  	   />
		    	<bind role="stop"  component="menuServicos"				   />	   
		    	<bind role="stop"  component="cabecalho"				   />		
		    	<bind role="start" component="int"			   			   />		
		    </link>			
		</context>
</body>
</ncl>