<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="regioes" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">  

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
	 ## REGIOES: Arquivo NCL que armazena a base com informações sobre as regiões na tela 
	 ## que as mídias ocuparão. 
	 #################################################################################### -->

<!-- ## Cabeçalho ## -->		
<head>
	
	<!-- ## Região da área do vídeo e da área da tela (margem) onde a aplicação interativa vai ocupar. 
	 !   ## A margem foi colocada devido respostar distintas da aplicação em diferentes televisores e set top boxes. -->
	<regionBase>
		<region id="regiaoVideo" 		  width="100%"   height="100%"  top="0"     right="0"  zIndex="2"/>
		<region id="regiaoAreaUtilizada"  width="92%"	 height="95%"	top="4%"	right="6%" zIndex="3">

		<region id="regiaoInteratividade" width="9.5%"  height="8.4%"  top="5.0%"  right="4.0%"  zIndex="3"/>
		<region id="regiaoCabecalho"	  width="100%"   height="10.99%"  top="0%"     right="0%"	 zIndex="3"/>

		<!-- ## Regiões referentes ao Menu Principal. Essas áreas são também utilizadas quando as opções do menu são
		 !   ## alteradas ao entrar no submenu Novidades Twitter. -->
		<region id="menu" 				  				width="45.04%"  height="78.19%" top="5%"   left="54.6%" zIndex="4" >
			<region id="regiaoServicos"	 				width="26.829%" height="7.41%"  top="0%"   	 left="73.17%" zIndex="5"/>
			<region id="regiaoBotaoCalendarioPagamento" width="100%" 	height="11.38%" top="7.41%"  right="0%"    zIndex="5"/>
			<region id="regiaoBotaoCentral135"		    width="100%" 	height="11.38%" top="18.84%" right="0%"    zIndex="5"/>
			<region id="regiaoBotaoTabelaContribuicao"  width="100%" 	height="11.38%" top="30.12%" right="0%"    zIndex="5"/>
			<region id="regiaoBotaoLocalizarAgencia"    width="100%" 	height="11.38%" top="41.4%"  right="0%"    zIndex="5"/>
			<region id="regiaoBotaoTwitter" 		    width="100%" 	height="11.38%" top="52.65%" right="0%"    zIndex="5"/>
			<region id="regiaoBotaoSair" 				width="100%" 	height="11.38%" top="63.9%"  right="0%"    zIndex="5"/>
			<region id="regiaoDescricaoFundo"			width="100%" 	height="19.48%" top="75.2%"  right="0%"    zIndex="5"/>
			<region id="regiaoDescricao" 				width="100%" 	height="19.48%" top="75.2%"  right="0%"    zIndex="6"/>
			<region id="regiaoRodape"	 				width="100%" 	height="4.827%" top="94.5%" right="0%"    zIndex="5"/>
		</region>

		<region id="regiaoFundo"		  width="100%"   height="100%"	 top="0" 	 right="0"	  zIndex="1" />
		<region id="regiaoUsoControle"	  width="37.99%" height="26.56%" top="73.44%" right="0"   zIndex="4" />
       	<region id="regiaoConteudo"		  width="66.5%"	 height="91.01%" top="8.99%" left="0%"    zIndex="4" />
   		<region id="regiaoLuaPrincipal"   width="55%" 	 height="73.39%" top="19%" 	 left="4.5%"  zIndex="4" />
  		<region id="regiaoLuaTwitter" 	  width="58%" 	 height="84.0%"  top="12%"   left="2.8%"  zIndex="4" />

		<!-- ## Regiões utilizadas pela opção Central 135: -->
		<region id="regiao135Main" 		  width="55.2%"  height="57.42%" top="13%"   left="4.2%" zIndex="4" />
		<region id="regiao135Barra1"	  width="45.73%" height="6.38%"  top="72%"   left="1.5%" zIndex="5" />
		<region id="regiao135Barra2"	  width="51.98%" height="6.25%"  top="79%"   left="1.2%" zIndex="5" />
		<region id="regiao135Barra3"	  width="56.96%" height="6.25%"  top="85.5%" left="1.3%" zIndex="5" />
		<region id="regiao135Barra4"	  width="60.86%" height="6.25%"  top="92%"   left="1.3%" zIndex="5" />
		<region id="regiao135Main2"		  width="59.11%" height="82.42%" top="11.5%" left="3%"   zIndex="4" />
		<!-- ## -->
		
		<region id="regiaoTwitUrl"        width="39.71%" height="8.33%"  top="22%"   left="11.5%" zIndex="3" />
		<region id="regiaoTwitFundo1"     width="58.03%" height="30.08%" top="33%"   left="2.5%"  zIndex="3" />
		<region id="regiaoTwitFundo2"     width="58.03%" height="30.08%" top="65.5%" left="2.5%"  zIndex="3" />
		<region id="regiaoConectar"		  width="41.89%" height="34.63%" top="35%" 	 left="12.0%" zIndex="5" />
		<region id="regiaoA" 			  width="1" 	 height="1" 	 top="0" 	 right="0" />

	</region>

	</regionBase>		
</head>
</ncl>