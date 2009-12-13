#Dies ein Modul, das verschiedene Funktionen fuer Logs und Plots enthaelt, kurz für das dataprocessing

module Dataprocessing

def writeLog(wert,log)
	#hier kommt der Code hin, der Logs schreibt
	puts wert
	puts log
end

def drawPlot(log, outputfile)
#Diese Funktion wird den Plot zeichnen.
#Das kann z. B. über ein Shellscript realisiert werden, das den Ploticus aufruft.
end

end