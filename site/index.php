<html>
<head>
<title>Wetterstationsdaten</title>
		<script type="text/javascript">	
			
			function init () {
			arrayLength = document.getElementById('zaehlertag').innerHTML;
		    stelle = 0;
		    <?php
		    //Hier wird das neuste Bild gesucht
				$topdir = openDir("../graph");
				while($topfile = readDir($topdir)){
					if(substr($topfile,0,1)!="."){
						$categorydir = openDir("../graph/$topfile");
							while($file = readDir($categorydir)){
									if(substr($file,0,1)!="."){
										echo "var ersterpfad = \"../graph/$topfile/$file\";";
										break;
									}
							}
							closeDir($categorydir);
					}
				}
				closeDir($topdir);
			?>
			document.getElementById('bild').src = ersterpfad;
			document.getElementById('bildtext').innerHTML = ersterpfad; 
			document.getElementById('bildtextfeld').style.width = document.getElementById('bild').width;
			}
			
			function anzeigen (pfad) {
				document.getElementById('bild').src = pfad;
				document.getElementById('bildtext').innerHTML = pfad; 
				document.getElementById('bildtextfeld').style.width = document.getElementById('bild').width;
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
				     if (anfangLink==-1) {
				     	var anfangLink = linkText.indexOf('"')-2;
				     }
				     var endeLink = linkText.lastIndexOf('%22');
				     if (endeLink==-1) {
				    	 var endeLink = linkText.lastIndexOf('"'); 	
				     }
				     var linkText = linkText.substring(anfangLink+3,endeLink);			     
					 document.getElementById('bild').src = linkText;
					 document.getElementById('bildtext').innerHTML = linkText; 
			 		 document.getElementById('bildtextfeld').style.width = document.getElementById('bild').width;
				 } else if (arrows==37) {
				     if (stelle!=0) {
						 stelle = stelle-1;
					 } else {
					 	 stelle = arrayLength-1;
					 }			 
					 var linkText = String(document.getElementById(stelle));
				     var anfangLink = linkText.indexOf('%22');
				     if (anfangLink==-1) {
				     	var anfangLink = linkText.indexOf('"')-2;
				     }
				     var endeLink = linkText.lastIndexOf('%22');
				     if (endeLink==-1) {
				    	 var endeLink = linkText.lastIndexOf('"'); 	
				     }
				     var linkText = linkText.substring(anfangLink+3,endeLink);
					 document.getElementById('bild').src = linkText;
					 document.getElementById('bildtext').innerHTML = linkText;
			   		 document.getElementById('bildtextfeld').style.width = document.getElementById('bild').width;
				 }
			}
		</script>
		<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body onkeydown="arrow(event);" onload="init();">

<div class="mitte">


	<div class="bild">
		<img src="" id="bild"/>
	</div>
	<div id="bildtextfeld">
		<h6 id="bildtext"></h6>
	</div>

<br>
<br>

<?php
//Zuerst wird eine Variabel generiert für die Pfeiltasten-Navigation
$zaehler = 0;
$zeit = 0;
//Arrays für ansprechende Zeitausgabe
$monate = array("Januar","Februar","M&auml;rz","April","Mai","Juni","Juli","August","September","Oktober","November","Dezember");
$tage = array("Montag","Dienstag","Mittwoch","Donnerstag","Freitag","Samstag","Sonntag");
//Nun die Routine, um Dateien aus einem Verzeichnis auszulesen:
//Erstes Verzeichnis wird geöffnet:
$topdir = openDir("../graph");
//Jede Datei in erstem Verzeichnis ausgelesen:
while($topfile = readDir($topdir)){
//Überprüfung, ob die Datei kein versteckter Ordner ist, wenn nicht wird ein Titel geschrieben
	if(substr($topfile,0,1)!="."){
		echo "<div class=\"titel\"><h1>$topfile</h1></div>";
		echo "<div class=\"liste\">";
				//Gefundenes Kategorienverzeichnis wird geöffnet und nun nach Bildern durchsucht. JS-Links werden generiert.
				$categorydir = openDir("../graph/$topfile");
				while($file = readDir($categorydir)){
					if(substr($file,0,1)!="."){
						echo "<a href='javascript:anzeigen(\"../graph/$topfile/$file\")' id=\"$zaehler\">$file</a><br>\n";
						$zaehler = $zaehler+1;
						//Datei mit der Höchsten änderungszeit wird gesucht
						if (filemtime("../graph/$topfile/$file") > $zeit) {	
							$zeit=fileatime("../graph/$topfile/$file");
						}
					}
				}			
				//Zeiten werden formatiert
				$zeit_monat = $monate[date("n",$zeit)-1];
				$zeit_tag = $tage[date("N",$zeit)-1];
				$zeit_datum = date("d.",$zeit);
				$zeit_uhrzeit = date("H:i:s",$zeit);
				echo "<h6>Dieser Ordner wurde am $zeit_tag, den $zeit_datum $zeit_monat um $zeit_uhrzeit zuletzt ge&auml;ndert.</h6>";
				echo "</div><br>";
				closeDir($categorydir);
				//Zeit wird zurückgesetzt für nächsten Ordner
				$zeit = 0;
				}
		
	}

closeDir($topdir);
//Hier ein versteckter Tag, der die Information erhält, wieviele Bilder es gibt.
echo "<b id=\"zaehlertag\">$zaehler</b>"
?>

</div>

</body>
</html>
