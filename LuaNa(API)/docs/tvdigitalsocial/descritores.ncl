<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="descritores" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">  

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
	 ## DESCRITORES: Arquivo NCL onde são declarados os descritores.
	 #################################################################################### -->		
<head>

	<!-- Referência a base de regiões. -->
	<regionBase>
		<importBase alias="reg" documentURI="regioes.ncl" />
	</regionBase>
		
	<!-- Base de descritores -->
	<descriptorBase>
		<descriptor id="descritorVideo"          			 region="reg#regiaoVideo" />
		<descriptor id="descritorInteratividade" 			 region="reg#regiaoInteratividade" />
		<descriptor id="descritorCabecalho"      			  region="reg#regiaoCabecalho" />
		<descriptor id="descritorMenuServicos"       		   region="reg#regiaoServicos" />
		<descriptor id="descritorMenuBotaoCalendarioPagamento" region="reg#regiaoBotaoCalendarioPagamento" />
		<descriptor id="descritorMenuBotaoCentral135"          region="reg#regiaoBotaoCentral135"    	   />
		<descriptor id="descritorMenuBotaoLocalizarAgencia"    region="reg#regiaoBotaoLocalizarAgencia"    />
		<descriptor id="descritorMenuBotaoTabelaContribuicao"  region="reg#regiaoBotaoTabelaContribuicao"  />
		<descriptor id="descritorMenuBotaoTwitter"             region="reg#regiaoBotaoTwitter" 			   />
		<descriptor id="descritorMenuBotaoSair"          	   region="reg#regiaoBotaoSair"    			   />
		<descriptor id="descritorMenuDescricao"        		   region="reg#regiaoDescricao"  />
		<descriptor id="descritorMenuDescricaoFundo"    	   region="reg#regiaoDescricaoFundo"  />
		<descriptor id="descritorMenuRodape"       		   	   region="reg#regiaoRodape"     />
		<descriptor id="descritorFundo" 	   region="reg#regiaoFundo" 						  />
		<descriptor id="descritorUsoControle"  region="reg#regiaoUsoControle" 				      />
		<descriptor id="descritorConteudo" 	   region="reg#regiaoConteudo" 	   focusIndex="ixLua" />			
		<descriptor id="descritorLuaPrincipal" region="reg#regiaoLuaPrincipal" focusIndex="jxLua" />
		<descriptor id="descritorLuaLocaliza"  region="reg#regiaoLuaTwitter"   focusIndex="jxLua" />
		<descriptor id="descritor135Main"      region="reg#regiao135Main"   />
		<descriptor id="descritor135Barra1"    region="reg#regiao135Barra1" />
		<descriptor id="descritor135Barra2"    region="reg#regiao135Barra2" />
		<descriptor id="descritor135Barra3"    region="reg#regiao135Barra3" />
		<descriptor id="descritor135Barra4"    region="reg#regiao135Barra4" />
		<descriptor id="descritor135Main2"  region="reg#regiao135Main2"  />
		<descriptor id="descritorLuaTwitter" region="reg#regiaoLuaTwitter" focusIndex="jxLua" />
		<descriptor id="descritorTwitUrl" 	 region="reg#regiaoTwitUrl"    />
		<descriptor id="descritorTwitFundo1" region="reg#regiaoTwitFundo1" />
		<descriptor id="descritorTwitFundo2" region="reg#regiaoTwitFundo2" />		
	</descriptorBase>		
</head>
</ncl>