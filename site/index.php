<html>
<head>
<title>Wetterstationsdaten</title>
		<script type="text/javascript">	
			
			function init () {
			arrayLength = document.getElementById('zaehlertag').innerHTML;
		    stelle = 0;
			}
			
			function anzeigen (pfad) {
				document.getElementById('bild').src = pfad;
			}	
						
			function arrow (ev) {
				 arrows=((ev.which)||(ev.keyCode));
				 if (arrows==39) {
				 	 if (stelle!=arrayLength-1) {
						 stelle = stelle + 1;
					 } else {
					 	 stelle = 0;
					 }
					 var linkText = String(document.getElementById(stelle));
				     var anfangLink = linkText.indexOf('%22');
				     var endeLink = linkText.lastIndexOf('%22');
				     var linkText = linkText.substring(anfangLink+3,endeLink);
					 document.getElementById('bild').src = linkText;
				 } else if (arrows==37) {
				     if (stelle!=0) {
						 stelle = stelle-1;
					 } else {
					 	 stelle = arrayLength-1;
					 }			 
					 var linkText = String(document.getElementById(stelle));
				     var anfangLink = linkText.indexOf('%22');
				     var endeLink = linkText.lastIndexOf('%22');
				     var linkText = linkText.substring(anfangLink+3,endeLink);
					 document.getElementById('bild').src = linkText;
				 }
			}
		</script>
		<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body onkeydown="arrow(event);" onload="init();">

<div class="mitte">

<div class="bild">
<img src="../graph/Feuchtigkeit/2010/01/001.png" id="bild"/>
</div>

<br>

<?php
//Zuerst wird eine Variabel generiert für die Pfeiltasten-Navigation
$zaehler = 0;
//Nun die Routine, um Dateien aus einem Verzeichnis auszulesen:
//Erstes Verzeichnis wird geöffnet:
$topdir = openDir("../graph");
//Jede Datei in erstem Verzeichnis ausgelesen:
while($topfile = readDir($topdir)){
//Überprüfung, ob die Datei kein versteckter Ordner ist, wenn nicht wird ein Titel geschrieben
	if(substr($topfile,0,1)!="."){
		echo "<h1>$topfile</h1>";
		echo "<hr>";
		//Gefundenes Kategorienverzeichnis wird geöffnet und nach Jahresverzeichnissen durchsucht, gleicher Ablauf wie oben
		$categorydir = openDir("../graph/$topfile");
		while($yearfile = readDir($categorydir)){
			if(substr($yearfile,0,1)!="."){
			echo "<h4>$yearfile</h4>";
			
			//Gefundenes Jahresverzeichnis wird geöffnet und nach Monaten durchsucht
			$yeardir = openDir("../graph/$topfile/$yearfile");
			while($monthfile = readDir($yeardir)){
				if(substr($monthfile,0,1)!="."){
				echo "<h6>$monthfile</h6>";
				
				//Gefundenes Monatsverzeichnis wird geöffnet und nun nach Bildern durchsucht. JS-Links werden generiert.
				$monthdir = openDir("../graph/$topfile/$yearfile/$monthfile");
				while($file = readDir($monthdir)){
					if(substr($file,0,1)!="."){
					echo "<a href='javascript:anzeigen(\"../graph/$topfile/$yearfile/$monthfile/$file\")' id=\"$zaehler\">$file</a><br>\n";
					$zaehler = $zaehler+1;
					}
				}
				closeDir($monthdir);
				}
			}
			closeDir($yeardir);	
						
				}
			}
		closeDir($categorydir);
		
		echo "<br>";
	}
}
closeDir($topdir);
//Hier ein versteckter Tag, der die Information erhält, wieviele Bilder es gibt.
echo "<b id=\"zaehlertag\">$zaehler</b>"
?>

</div>

</body>
</html>
