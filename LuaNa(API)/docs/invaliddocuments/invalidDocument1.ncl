<?xml version="1.0" encoding="ISO-8859-1"?>

<ncl id="exemplo01" 
 xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">

<head>

<!-- regionBase without closed tag -->
<regionBase>
   <region id="rgTV" width="100%" height="100%"> 
      <region id="rgVideo1" left="25%" top="25%" 
              width="50%" height="50%" />
   </region>


<descriptorBase>
   <!-- rgVideo2 doesn't exist! -->
   <descriptor id="dVideo1" region="rgVideo2" />
</descriptorBase>

<!-- tag not closes properly -->
</head

<body>

<!-- tag without closed quotation marks at atributte id -->
<port id="pInicio component="video1"/>

<media type="video/mpeg" id="video1" src="media/abertura.mpg" 
       descriptor="dVideo1"/>

</body>

</ncl>
