<html>
<head>
<title>Wetterstationsdaten</title>
</head>
<body>

<?php
//Routine, um Dateien aus einem Verzeichnis auszulesen:
$verzeichnis = openDir("graph");
while($file = readDir($verzeichnis)){
	if($file!="." && $file != ".."){
		echo "<a href=\"$file\">$file</a><br>\n";
	}
}
closeDir($verzeichnis);
?>


</body>
</html>

