<?xml version="1.0" encoding="ISO-8859-1"?>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !   EXEMPLO 12
 !
 !   Objetivo: Criar um menu de sele��o atrav�s das teclas de
 !             navega��o do controle remoto.
 !
 !   Caracter�sticas:
 !
 !   - sincronismo: simples (de in�cio e t�rmino de m�dias)
 !   - intera��o do usu�rio: sele��o da op��o de menu
 !
 !   Prepara��o:
 !
 !   Para executar este exemplo, � necess�rio ter as seguintes 
 !   m�dias no subdiret�rio media a partir do caminho do
 !   arquivo NCL:
 !
 !   1) arquivo de v�deo chamado rio.mpg, com uma
 !      introdu��o em loop
 !   2) arquivos de imagem com as seis op��es a serem
 !      selecionadas: opcao1.gif; opcao2.gif; opcao3.gif
 !      opcao4.gif; opcao5.gif; e opcao6.gif
 !   3) arquivos de imagem com as seis op��es j� selecionadas:
 !      sel_opcao1.gif; sel_opcao2.gif; sel_opcao3.gif
 !      sel_opcao4.gif; sel_opcao5.gif; e sel_opcao6.gif
 !   4) arquivos html com o resultado das op��es selecionadas:
 !      selecao1.html; selecao2.html; selecao3.html;
 !      selecao4.html; selecao5.html; e selecao6.html
 !
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->


<ncl id="exemplo12"
     xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ! CABE�ALHO DO PROGRAMA
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<head>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ! BASE DE REGI�ES:
 ! define as regi�es na tela onde as m�dias s�o apresentadas
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<regionBase>
   <region id="rgTV" width="100%" height="100%">
      <region id="rgVideo1" width="100%" height="100%"
              zIndex="1"/>
      <region id="rgOpcao1" left="0%" top="5%" 
              width="200" height="50" zIndex="2"/>
      <region id="rgOpcao2" left="0%" top="13%" 
              width="200" height="50" zIndex="2"/>
      <region id="rgOpcao3" left="0%" top="21%" 
              width="200" height="50" zIndex="2"/>
      <region id="rgOpcao4" left="0%" top="29%" 
              width="200" height="50" zIndex="2"/>
      <region id="rgOpcao5" left="0%" top="37%" 
              width="200" height="50" zIndex="2"/>
      <region id="rgOpcao6" left="0%" top="45%" 
              width="200" height="50" zIndex="2"/>
      <region id="rgResultado" left="0%" top="45%"
              width="100%" height="10%" zIndex="2"/>
   </region>
</regionBase>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ! BASE DE DESCRITORES:
 ! define como as m�dias s�o apresentadas
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<descriptorBase>
   <descriptor id="dVideo1" region="rgVideo1"/>

   <descriptor id="dOpcao1" region="rgOpcao1" focusIndex="1"
               moveDown="2" focusBorderWidth="0"
               focusSrc="media/sel_opcao1.gif"/>

   <descriptor id="dOpcao2" region="rgOpcao2" focusIndex="2" 
               moveDown="3" moveUp="1" focusBorderWidth="0"
               focusSrc="media/sel_opcao2.gif"/>

   <descriptor id="dOpcao3" region="rgOpcao3" focusIndex="3" 
               moveDown="4" moveUp="2" focusBorderWidth="0" 
               focusSrc="media/sel_opcao3.gif"/>

   <descriptor id="dOpcao4" region="rgOpcao4" focusIndex="4" 
               moveDown="5" moveUp="3" focusBorderWidth="0" 
               focusSrc="media/sel_opcao4.gif"/>

   <descriptor id="dOpcao5" region="rgOpcao5" focusIndex="5" 
               moveDown="6" moveUp="4" focusBorderWidth="0" 
               focusSrc="media/sel_opcao5.gif"/>

   <descriptor id="dOpcao6" region="rgOpcao6" focusIndex="6" 
               moveUp="5" focusBorderWidth="0" 
               focusSrc="media/sel_opcao6.gif"/>

   <descriptor id="dResultado" region="rgResultado" 
               explicitDur="4s"/>
</descriptorBase>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ! BASE DE REGRAS:
 ! definem regras utilizadas em switches para a sele��o de n�s
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<ruleBase>
   <rule id="r1" var="opcao" comparator="eq" value="1"/>
   <rule id="r2" var="opcao" comparator="eq" value="2"/>
   <rule id="r3" var="opcao" comparator="eq" value="3"/>
   <rule id="r4" var="opcao" comparator="eq" value="4"/>
   <rule id="r5" var="opcao" comparator="eq" value="5"/>
   <rule id="r6" var="opcao" comparator="eq" value="6"/>
</ruleBase>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ! BASE DE CONECTORES:
 ! definem o comportamento dos elos
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<connectorBase>
   <causalConnector id="onBeginStartN">
      <simpleCondition role="onBegin"/>
      <simpleAction role="start" max="unbounded" qualifier="par"/>
   </causalConnector>
   
   <causalConnector id="onEndStop">
      <simpleCondition role="onEnd" />
      <simpleAction role="stop" />
   </causalConnector>

   <causalConnector id="onSelectionSetNStopNStartN">
      <connectorParam name="var"/>
      <simpleCondition role="onSelection"/>
      <compoundAction operator="seq">
         <simpleAction role="set" value="$var"
                       max="unbounded" qualifier="par"/>
         <simpleAction role="stop" 
                       max="unbounded" qualifier="par"/>
         <simpleAction role="start" 
                       max="unbounded" qualifier="par"/>
      </compoundAction>
   </causalConnector>
</connectorBase>

</head>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ! CORPO DO PROGRAMA:
 ! define as m�dias e estrutura do programa
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<body>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ! PONTO DE ENTRADA:
 ! indica o componente onde o programa inicia
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<port id="pEntryPoint" component="video1"/>

<media type="application/x-ginga-settings" id="nodeSettings">
   <property name="opcao"/>
</media>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
! M�DIAS:
! define o local dos arquivos de m�dia e as associa com seus descritores
!++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<media id="video1" src="media/rio.mpg" descriptor="dVideo1"/>

<media id="opcao1" src="media/opcao1.gif" descriptor="dOpcao1"/>
<media id="opcao2" src="media/opcao2.gif" descriptor="dOpcao2"/>
<media id="opcao3" src="media/opcao3.gif" descriptor="dOpcao3"/>
<media id="opcao4" src="media/opcao4.gif" descriptor="dOpcao4"/>
<media id="opcao5" src="media/opcao5.gif" descriptor="dOpcao5"/>
<media id="opcao6" src="media/opcao6.gif" descriptor="dOpcao6"/>


<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
! SWITCH:
! cont�m os n�s dentre os quais um ser� selecionado
! com base nas regras definidas por bindRule
!++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<switch id="switchOpcao">
   <!-- caso a regra ri seja v�lida, dispara o n� selecaoi -->

   <bindRule rule="r1" constituent="selecao1" />
   <bindRule rule="r2" constituent="selecao2" />
   <bindRule rule="r3" constituent="selecao3" />
   <bindRule rule="r4" constituent="selecao4" />
   <bindRule rule="r5" constituent="selecao5" />
   <bindRule rule="r6" constituent="selecao6" />

   <media id="selecao1" src="media/selecao1.html"
          descriptor="dResultado"/>
   <media id="selecao2" src="media/selecao2.html" 
          descriptor="dResultado"/>
   <media id="selecao3" src="media/selecao3.html" 
          descriptor="dResultado"/>
   <media id="selecao4" src="media/selecao4.html" 
          descriptor="dResultado"/>
   <media id="selecao5" src="media/selecao5.html" 
          descriptor="dResultado"/>
   <media id="selecao6" src="media/selecao6.html" 
          descriptor="dResultado"/>
</switch>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
! ELOS
! define os elos que regem o sincronismo entre as m�dias
!++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<!-- in�cio do v�deo 1 deve iniciar a exibi��o das op��es -->

<link id="Video1Start" xconnector="onBeginStartN">
   <bind component="video1" role="onBegin"/>
   <bind component="opcao1" role="start"/>
   <bind component="opcao2" role="start"/>
   <bind component="opcao3" role="start"/>
   <bind component="opcao4" role="start"/>
   <bind component="opcao5" role="start"/>
   <bind component="opcao6" role="start"/>
</link>

<link id="Selecao_OK1" xconnector="onSelectionSetNStopNStartN">
   <bind component="opcao1" role="onSelection"/>
   <bind component="nodeSettings" interface="opcao" role="set">
      <bindParam name="var" value="1"/>
   </bind>
   <bind component="switchOpcao" role="start"/>
   <bind component="opcao1" role="stop"/>
   <bind component="opcao2" role="stop"/>
   <bind component="opcao3" role="stop"/>
   <bind component="opcao4" role="stop"/>
   <bind component="opcao5" role="stop"/>
   <bind component="opcao6" role="stop"/>
</link>

<link id="Selecao_OK2" xconnector="onSelectionSetNStopNStartN">
   <bind component="opcao2" role="onSelection"/>
   <bind component="nodeSettings" interface="opcao" role="set">
      <bindParam name="var" value="2"/>
   </bind>
   <bind component="switchOpcao" role="start"/>
   <bind component="opcao1" role="stop"/>
   <bind component="opcao2" role="stop"/>
   <bind component="opcao3" role="stop"/>
   <bind component="opcao4" role="stop"/>
   <bind component="opcao5" role="stop"/>
   <bind component="opcao6" role="stop"/>
</link>

<link id="Selecao_OK3" xconnector="onSelectionSetNStopNStartN">
   <bind component="opcao3" role="onSelection"/>
   <bind component="nodeSettings" interface="opcao" role="set">
      <bindParam name="var" value="3"/>
   </bind>
   <bind component="switchOpcao" role="start"/>
   <bind component="opcao1" role="stop"/>
   <bind component="opcao2" role="stop"/>
   <bind component="opcao3" role="stop"/>
   <bind component="opcao4" role="stop"/>
   <bind component="opcao5" role="stop"/>
   <bind component="opcao6" role="stop"/>
</link>

<link id="Selecao_OK4" xconnector="onSelectionSetNStopNStartN">
   <bind component="opcao4" role="onSelection"/>
   <bind component="nodeSettings" interface="opcao" role="set">
      <bindParam name="var" value="4"/>
   </bind>
   <bind component="switchOpcao" role="start"/>
   <bind component="opcao1" role="stop"/>
   <bind component="opcao2" role="stop"/>
   <bind component="opcao3" role="stop"/>
   <bind component="opcao4" role="stop"/>
   <bind component="opcao5" role="stop"/>
   <bind component="opcao6" role="stop"/>
</link>

<link id="Selecao_OK5" xconnector="onSelectionSetNStopNStartN">
   <bind component="opcao5" role="onSelection"/>
   <bind component="nodeSettings" interface="opcao" role="set">
      <bindParam name="var" value="5"/>
   </bind>
   <bind component="switchOpcao" role="start"/>
   <bind component="opcao1" role="stop"/>
   <bind component="opcao2" role="stop"/>
   <bind component="opcao3" role="stop"/>
   <bind component="opcao4" role="stop"/>
   <bind component="opcao5" role="stop"/>
   <bind component="opcao6" role="stop"/>
</link>

<link id="Selecao_OK6" xconnector="onSelectionSetNStopNStartN">
   <bind component="opcao6" role="onSelection"/>
   <bind component="nodeSettings" interface="opcao" role="set">
      <bindParam name="var" value="6"/>
   </bind>
   <bind component="switchOpcao" role="start"/>
   <bind component="opcao1" role="stop"/>
   <bind component="opcao2" role="stop"/>
   <bind component="opcao3" role="stop"/>
   <bind component="opcao4" role="stop"/>
   <bind component="opcao5" role="stop"/>
   <bind component="opcao6" role="stop"/>
</link>

<link id="terminaPrograma" xconnector="onEndStop">
   <bind component="switchOpcao" role="onEnd"/>
   <bind component="video1" role="stop"/>
</link>

</body>

</ncl>
