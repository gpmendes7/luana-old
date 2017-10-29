<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="conectores" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">  

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
	 ## CONECTORES: Arquivo NCL que é declarado os conectores, que são regras sobre como 
	 ## os elos que referirem irão funcionar. 
	 #################################################################################### -->
		
<head>
	<connectorBase>
     		<causalConnector id="aoIniciarSetar">
        		<connectorParam name="var"/>
        		<simpleCondition role="onBegin" />
     			<simpleAction role="set" value="$var" max="unbounded" qualifier="par"/>
      		</causalConnector>

			<causalConnector id="aoTerminarSetar" >
				<connectorParam name="var"/>
				<simpleCondition role="onEnd"/>
           		<simpleAction role="set"   max="unbounded" qualifier="par" value="$var" />
			</causalConnector>

			<causalConnector id="aoTerminarIniciar" >
				<simpleCondition role="onEnd"/>
			    <simpleAction role="start" max="unbounded" qualifier="par"/>
			</causalConnector>

			<causalConnector id="aoIniciarIniciar" >
				<connectorParam name="var"/>
				<simpleCondition role="onBegin"/>
           		<simpleAction role="start" max="unbounded" qualifier="par" />
			</causalConnector>

			<causalConnector id="aoTerminarPararIniciar" >
				<connectorParam name="var"/>
				<simpleCondition role="onEnd"/>
			  <compoundAction operator="seq">
				    <simpleAction role="stop"  max="unbounded" qualifier="par"/>
				    <simpleAction role="start" max="unbounded" qualifier="par"/>
          	  </compoundAction>
			</causalConnector>

			<causalConnector id="aoTerminarParar" >
				<simpleCondition role="onEnd"/>
			    <simpleAction role="stop"  max="unbounded" qualifier="par"/>
			</causalConnector>
			
			<causalConnector id="aoTerminarPararIniciarSetar" >
				<connectorParam name="var"/>
				<simpleCondition role="onEnd"/>
			  <compoundAction operator="seq">
				    <simpleAction role="stop"  max="unbounded" qualifier="par"/>
				    <simpleAction role="start" max="unbounded" qualifier="par"/>
	   				<simpleAction role="set"   value="$var" max="unbounded" qualifier="par"/>
          	  </compoundAction>
			</causalConnector>

   		   <causalConnector id="naSelecaoDeTeclaPararIniciar">
			<connectorParam name="tecla"/>
			  <simpleCondition role="onSelection" key="$tecla"/>
			  <compoundAction operator="seq">
				    <simpleAction role="stop"  max="unbounded" qualifier="par"/>
				    <simpleAction role="start" max="unbounded" qualifier="par"/>
	          	  </compoundAction>
		   </causalConnector>

   		   <causalConnector id="naSelecaoDeTeclaSetarPararIniciar">
		    <connectorParam  name="var"/>
			<connectorParam name="tecla"/>
			<simpleCondition role="onSelection" key="$tecla"/>
			
			 <compoundAction operator="seq">
			   	 <simpleAction role="set"   value="$var" max="unbounded" qualifier="par"/>
				 <simpleAction role="stop"  max="unbounded" qualifier="par"/>
				 <simpleAction role="start" max="unbounded" qualifier="par"/>
	          </compoundAction>
		   </causalConnector>
		   
	       <causalConnector id="naSelecaoSetarIniciarParar">
		   <connectorParam  name="var"/>
        		<simpleCondition role="onSelection"/>
			 <compoundAction operator="seq">
			    	 <simpleAction role="set"   value="$var" max="unbounded" qualifier="par"/>
 	      		   	 <simpleAction role="start" max="unbounded" qualifier="seq"/>
 			     	 <simpleAction role="stop"  max="unbounded" qualifier="par"/>
			 </compoundAction>
	       </causalConnector>

		   <causalConnector id="aoTerminarAtribuicaoParar">
				<simpleCondition role="onEndAttribution"/>
			    <simpleAction role="stop"  max="unbounded" qualifier="par"/>
			</causalConnector>

		   <causalConnector id="aoIniciarAtribuicaoIniciar">
				<simpleCondition role="onBeginAttribution"/>
			    <simpleAction role="start"  max="unbounded" qualifier="par"/>
			</causalConnector>

		   <causalConnector id="aoTerminarAtribuicaoPararAbortar">
		   	  <connectorParam name="var"/>
				<simpleCondition role="onEndAttribution"/>
	   		    <compoundAction operator="seq">
  					<simpleAction role="stop"  max="unbounded" qualifier="par"/>
				   	<simpleAction role="abort"  max="unbounded" qualifier="par"/>
				</compoundAction>

			</causalConnector>

		   <causalConnector id="aoTerminarAtribuicaoTestarParar">
	    	  <connectorParam name="var"/>
			  <compoundCondition operator="and">
		  		  <simpleCondition role="onEndAttribution"/>
				  <assessmentStatement comparator="eq">
			  		<valueAssessment value="$var" />		
				  </assessmentStatement>
			  </compoundCondition>

	 	      <simpleAction role="stop"  max="unbounded" qualifier="par"/>
			</causalConnector>
			
		   <causalConnector id="naSelecaoDeTeclaSetar">
		   	  <connectorParam name="var"/>
			  <connectorParam name="tecla"/>
			  <simpleCondition role="onSelection" key="$tecla"/>
		    	 <simpleAction role="set"   value="$var" max="unbounded" qualifier="par"/>
			</causalConnector>
			
		   <causalConnector id="aoTerminarAtribuicaoPararIniciar">
		   	  <connectorParam name="var"/>
				<simpleCondition role="onEndAttribution"/>
				  <compoundAction operator="seq">
				    <simpleAction role="stop"  max="unbounded" qualifier="par"/>
				    <simpleAction role="start" max="unbounded" qualifier="par"/>
		    	 </compoundAction>
			</causalConnector>
				
   		   <causalConnector id="naSelecaoDeTeclaIniciar">
			<connectorParam name="tecla"/>
			  <simpleCondition role="onSelection" key="$tecla"/>
  		      <simpleAction role="start"  max="unbounded" qualifier="par"/>
		   </causalConnector>
		   	
   		   <causalConnector id="naSelecaoDeTeclaParar">
			<connectorParam name="tecla"/>
			  <simpleCondition role="onSelection" key="$tecla"/>
  		      <simpleAction role="stop"  max="unbounded" qualifier="par"/>
		   </causalConnector>

	       <causalConnector id="naSelecaoSetarIniciar">
		   <connectorParam  name="var"/>
        		<simpleCondition role="onSelection"/>
			 <compoundAction operator="seq">
			    	 <simpleAction role="set"   value="$var" max="unbounded" qualifier="par"/>
 	      		   	 <simpleAction role="start" max="unbounded" qualifier="par"/>
			 </compoundAction>
	       </causalConnector>
				
	</connectorBase>
</head>
</ncl>