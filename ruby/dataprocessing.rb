#Dies ein Modul, das verschiedene Funktionen fuer Logs und Plots enthaelt, kurz für das dataprocessing

module Dataprocessing

def writeLog(spannung,wert)
	File.open("pfad/log.txt","a") do |datei|
		datei.puts
		datei.print Time.new
		datei.print ": "
		datei.print spannung
		datei.print " V "
		datei.print wert
		datei.print " [Einheit]"
	end
end

def drawPlot(log, outputfile)
#Diese Funktion wird den Plot zeichnen.
#Das kann z. B. über ein Shellscript realisiert werden, das den Ploticus aufruft.
end

end