require "rubygems"
require "inline"
#require "controller"

require "dataprocessing"
require "logger"

$log = Logger.new(STDERR)

include Dataprocessing

$log.debug("App launched")



# Array mit allen zu verarbeitenden Werten fuellen als Konfiguration:
werte = ["zufall"]
$log.info("folgende Werte werden ausgegeben")
$log.info(werte)

#Fuer jeden Wert folgendes tun:
werte.each { |wert|
	#Spannungsobjekt erstellen
	zahlwert = getVoltage(wert)
	wert = Spannung.new(zahlwert, wert)
	$log.info(wert)
	
	#Wert in das Jahreslogfile schreiben z.B. log/2009/temperatur/logyearly
	writeLog(wert.to_i, Time.now.year.to_s+"/"+wert.to_s+"/logyearly")
	
	$log.debug("Jahreslog fertig geschrieben")
	
	#Wert in das Monatslogfile schreiben
	writeLog(wert.to_i, Time.now.year.to_s+"/"+wert.to_s+"/log"+Time.now.strftime("%B"))

	$log.debug("Monatslog fertig geschrieben")

	}

#erst wenn alle Logs geschrieben sind, die Graphen zeichnen.
werte.each {|wert|
	
	#Diagrammtitel festlegen
	case wert
		when "zufall"
			diagrammtiteljahr = "Zufälle des Jahres "+Time.now.year.to_s
			diagrammtitelmonat = "Zufälle "+Time.now.strftime("%B %Y")
		when "temperatur"
			diagrammtiteljahr = "Temperaturen des Jahres "+Time.now.year.to_s
			diagrammtitelmonat = "Temperaturen "+Time.now.strftime("%B %Y")
		when "humidity"
			diagrammtiteljahr = "Luftfeuchtigkeiten des Jahres "+Time.now.year.to_s
			diagrammtitelmonat = "Leuftfeuchtigkeiten "+Time.now.strftime("%B %Y")
		else
			$log.warn("Wert "+wert.to_s+" ist nicht implementiert zum Graph zeichnen")
			$log.warn("skip")
			#nichts zeichnen, wenn der Wert nicht vorgesehen ist.
			next
	end
	
	#Jahreslog plotten
	drawPlot(Time.now.year.to_s+"/"+wert.to_s+"/logyearly", wert.to_s+"/#{Time.now.year}.png", diagrammtiteljahr)
	
	$log.debug("Jahreslog fertig geplottet")

	#Monatslog plotten
	drawPlot(Time.now.year.to_s+"/"+wert.to_s+"/log"+Time.now.strftime("%B"), wert.to_s+"/#{Time.now.strftime('%m')}-#{Time.now.year}.png", diagrammtitelmonat)
	$log.debug("Jahreslog fertig geplottet")

}
	
$log.debug("App Finished")