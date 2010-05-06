require "rubygems"
require "fileutils"

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
	@object = Spannung.new(zahlwert, wert)
	$log.info(wert)

	#Wert in das Jahreslogfile schreiben z.B. log/2009/temperatur/logyearly
	writeLog(wert.to_i, Time.now.year.to_s+"/"+@object.quelle+"/logyearly")

	$log.debug("Jahreslog fertig geschrieben")

	#Wert in das Monatslogfile schreiben
	writeLog(@object.to_i, Time.now.year.to_s+"/"+@object.quelle+"/log"+Time.now.strftime("%B"))

	$log.debug("Monatslog fertig geschrieben")

	}

#erst wenn alle Logs geschrieben sind, die Graphen zeichnen.
werte.each {|wert|
	#Jahreslog plotten
	drawPlot(Time.now.year.to_s+"/"+wert+"/logyearly", wert+"/#{Time.now.year}.png", @object.diagrammtiteljahr)

	$log.debug("Jahreslog fertig geplottet")

	#Monatslog plotten
	drawPlot(Time.now.year.to_s+"/"+wert+"/log"+Time.now.strftime("%B"), wert+"/#{Time.now.strftime('%m')}-#{Time.now.year}.png", @object.diagrammtitelmonat)
	$log.debug("Jahreslog fertig geplottet")

}

$log.debug("App Finished")