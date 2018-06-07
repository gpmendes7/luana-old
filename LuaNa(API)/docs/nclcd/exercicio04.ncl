<?xml version="1.0" encoding="ISO-8859-1"?>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !   EXERCICIO 04
 !
 !   Objetivo: Exemplo 3, contendo apenas o cabeçalho (<head>).
 !   IMPORTANTE: Arquivo incompleto!
 !
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  CABEÇALHO NCL:
 !  define as URIs dos esquemas da NCL
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<ncl id="exercicio04" 
     xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">


<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  CABEÇALHO DO PROGRAMA
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

   <head>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  BASE DE REGIÕES:
 !  define as regiões na tela onde as mídias são apresentadas
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<regionBase>
   <region id="rgTV" width="100%" height="100%"> 
      <region id="rgVideo1" top="25%" left="25%"
              width="50%" height="50%" />
   </region>
</regionBase>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  BASE DE DESCRITORES:
 !  define como as mídias são apresentadas
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<descriptorBase>
   <descriptor id="dVideo1" region="rgVideo1">
      <descriptorParam name="soundLevel" value="1" />
   </descriptor>
</descriptorBase>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  BASE DE CONECTORES:
 !  definem o comportamento dos elos
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<connectorBase>
   <importBase alias="connectors"
               documentURI="composerConnectorBase.conn"/>
</connectorBase>

</head>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  CORPO DO PROGRAMA:
 !   define as mídias e estrutura do programa
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<body>

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  PONTO DE ENTRADA:
 !  indica o componente onde o programa inicia
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<port id="pInicio" component="" />

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  MÍDIAS:
 !  define o local dos arquivos de mídia e as associa com seus 
 !  descritores
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

<!-- INCOMPLETO -->
<media src="media/abertura.mpg"   />
<media src="media/passaro.mpg"    />

<!--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 !  ELOS
 !  define os elos que regem o sincronismo entre as mídias
 !++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

</body>

</ncl>
